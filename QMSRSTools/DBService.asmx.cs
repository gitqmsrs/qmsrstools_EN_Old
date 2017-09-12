using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Data.Linq;
using System.Data.SqlClient;
using System.Text;
using System.Web;
using System.IO;
using System.Globalization;
using System.Xml.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
using System.Drawing;
using LINQConnection;
using LicenseLINQConnection;

namespace QMSRSTools
{
   

    /// <summary>
    /// Summary description for DBService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
   
    public class DBService : System.Web.Services.WebService
    {
        private QMSRSContextDataContext _context = new QMSRSContextDataContext();
        private LicenseMGRDataContext _licensecontext = new LicenseMGRDataContext();
        
        #region LicenseControl
        [WebMethod]
        public bool isValidateLicense()
        {
            var clientID = System.Configuration.ConfigurationManager.AppSettings["ClientID"];

            var client = _licensecontext.Clients.Where(C => C.ClientID == clientID).Select(C => C).SingleOrDefault();
            if (client != null)
            {
                var license = client.ClientToolsLicenses.Where(L => L.ActiveFlag == true).Select(L => L).SingleOrDefault();
                if (license != null)
                {
                    if (DateTime.Now > license.EndDate)
                    {
                        throw new Exception("The system is unable to activate since the current license quote has expired");
  
                    }
                    else if (DateTime.Now < license.StartDate)
                    {
                        throw new Exception("The system will be due to activate on " + license.StartDate.ToString("dd/MM/yyyy"));

                    }
                }
                else
                {
                    throw new Exception("The system is unable to find the current license quote information, contact vendor for support");
                }
            }
            else
            {
                throw new Exception("The system is unable to find the related client record, contact vendor for support");
            }

            return true;    
        }

        [WebMethod]
        public int getTotalUsers()
        {
            int totalusers = -1;
            var clientID = System.Configuration.ConfigurationManager.AppSettings["ClientID"];

            var client = _licensecontext.Clients.Where(C => C.ClientID == clientID).Select(C => C).SingleOrDefault();
            if (client != null)
            {
                var license = client.ClientToolsLicenses.Where(L => L.ActiveFlag == true).Select(L => L).SingleOrDefault();
                if (license != null)
                {
                    totalusers = license.TotalUsers;
                }
            }

            return totalusers;
        }

        [WebMethod]
        public int getCurrentUsers()
        {
            return _context.SystemUsers.Where(USR => USR.CurrentSessionID != null && USR.SystemUserType.UserType == "Employee Account").Select(USR => USR).ToList().Count;
        }

        #endregion
        #region General
 
        [WebMethod]
        public string UploadCauses(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Causes> causes = serializer.Deserialize<List<Causes>>(json);

            LINQConnection.Cause cause = null;

            string result = string.Empty;

            try
            {
                foreach (Causes C in causes)
                {
                    switch (C.Status)
                    {
                        case RecordsStatus.ADDED:
                            cause=_context.Causes.Where(CUS=>CUS.CauseName==C.name && CUS.RootCauseID.HasValue==false).Select(CUS=>CUS).SingleOrDefault();
                            if (cause == null)
                            {
                                cause = new Cause();
                                cause.CauseName = C.name;
                                cause.Description = C.Description == string.Empty ? null : C.Description;
                                cause.ModifiedDate = DateTime.Now;
                                cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                searchModifiedCause(C, cause);

                                _context.Causes.InsertOnSubmit(cause);
                            }
                            else
                            {
                                throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            }
                            break;
                        case RecordsStatus.MODIFIED:
                            cause = _context.Causes.Single(CU => CU.CauseID == C.CauseID);
                            cause.CauseName = C.name;
                            cause.Description = C.Description == string.Empty ? null : C.Description;
                            cause.ModifiedDate = DateTime.Now;
                            cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedCause(C, cause);

                            break;
                        case RecordsStatus.ORIGINAL:
                            cause = _context.Causes.Single(CU => CU.CauseID == C.CauseID);
                            searchModifiedCause(C, cause);
                            break;

                    }
                }

                _context.SubmitChanges();

                result = "Changes have been updated sucessfully";

            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return result;
        }

        [WebMethod]
        public string loadRootCauses()
        {
            var causes = (from C in _context.Causes
                          where C.RootCauseID == null
                          select new Causes
                          {
                              name = "ID: " + C.CauseID + " , Root Cause= " + C.CauseName,
                              CauseID = C.CauseID
                          }).ToList();

            XmlSerializer serializer = null;
            StringWriter writer = null;

            serializer = new XmlSerializer(typeof(List<Causes>));

            writer = new StringWriter();
            serializer.Serialize(writer, causes);


            return writer.ToString();
        }

        [WebMethod]
        public string loadAllCauses()
        {
            var causes = _context.fn_getCauseTreeHierarchy()
                .Select(C => new Causes
                {  
                    CauseID = Convert.ToInt32(C.CauseID),
                    name = C.Cause,
                    Description = C.Description,
                    ParentID = Convert.ToInt32(C.ParentID == null ? 0 : C.ParentID),
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            foreach (var cause in causes)
            {
                List<Causes> obj = causes.Where(x => x.ParentID == cause.CauseID).ToList<Causes>();

                if (obj.Count > 0)
                {
                    cause.children = obj;
                }
            }

            for (int i = causes.Count - 1; i >= 0; i--)
            {
                if (causes[i].ParentID != 0)
                {
                    causes.RemoveAt(i);
                }
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(causes);

            return result;
        }

        [WebMethod]
        public string loadChildCauseTree(int causeid)
        {
            var causes = _context.fn_getRootCauseChildTree(causeid)
            .Select(C => new Causes
            {
                CauseID = Convert.ToInt32(C.CauseID),
                name = C.Cause,
                Description = C.Description,
                ParentID = Convert.ToInt32(C.ParentID == null ? 0 : C.ParentID),
                Status = RecordsStatus.ORIGINAL
            }).ToList();


            foreach (var cause in causes)
            {
                List<Causes> obj = causes.Where(x => x.ParentID == cause.CauseID).ToList<Causes>();

                if (obj.Count > 0)
                {
                    cause.children = obj;
                }
            }

            for (int i = causes.Count - 1; i >= 0; i--)
            {
                if (causes[i].ParentID != 0)
                {
                    causes.RemoveAt(i);
                }
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(causes);

            return result;
        }

        [WebMethod]
        public void removeCause(int causeID)
        {

            var cause = _context.Causes.Where(C => C.CauseID == causeID)
            .Select(C => C).SingleOrDefault();

            if (cause != null)
            {
                _context.Causes.DeleteOnSubmit(cause);
                _context.SubmitChanges();
            }
        }


        private void searchModifiedCause(Causes obj, Cause cause)
        {
            Cause childcause = null;

            if (obj.children != null)
            {
                foreach (Causes c in obj.children)
                {
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                            childcause = new Cause();
                            childcause.CauseName = c.name;
                            childcause.Description = c.Description == string.Empty ? null : c.Description;
                            childcause.ModifiedDate = DateTime.Now;
                            childcause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            cause.Causes.Add(childcause);

                            searchModifiedCause(c, childcause);

                            break;
                        case RecordsStatus.MODIFIED:
                            childcause = _context.Causes.Where(CU => CU.CauseID == c.CauseID).SingleOrDefault();
                            childcause.CauseName = c.name;
                            childcause.Description = c.Description == string.Empty ? null : c.Description;
                            childcause.ModifiedDate = DateTime.Now;
                            childcause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedCause(c, childcause);

                            break;
                        case RecordsStatus.ORIGINAL:
                            childcause = _context.Causes.Where(CU => CU.CauseID == c.CauseID).SingleOrDefault();
                            searchModifiedCause(c, childcause);
                            break;
                    }
                }
            }
        }

        private void searchModifiedCause2(Causes obj, Cause cause, Causes selected)
        {
            Cause childcause = null;

            if (obj.children != null)
            {
                foreach (Causes c in obj.children)
                {
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                            
                                childcause = new Cause();
                                childcause.CauseName = c.name;
                                childcause.Description = c.Description == string.Empty ? null : c.Description;
                                childcause.ModifiedDate = DateTime.Now;
                                childcause.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                childcause.RootCauseID = c.ParentID;
                                //cause.Causes.Add(childcause);
                                _context.Causes.InsertOnSubmit(childcause);
                                _context.SubmitChanges();

                                if (c.isSelected)
                                {
                                    selected.CauseID = childcause.CauseID;
                                }
                                searchModifiedCause2(c, childcause, selected);
                           
                            break;
                        case RecordsStatus.MODIFIED:
                            childcause = _context.Causes.Where(CU => CU.CauseID == c.CauseID).SingleOrDefault();
                            childcause.CauseName = c.name;
                            childcause.Description = c.Description == string.Empty ? null : c.Description;
                            childcause.ModifiedDate = DateTime.Now;
                            childcause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedCause2(c, childcause, selected);

                            break;
                        case RecordsStatus.ORIGINAL:
                            childcause = _context.Causes.Where(CU => CU.CauseID == c.CauseID).SingleOrDefault();
                            searchModifiedCause2(c, childcause, selected);
                            break;
                    }

                }
            }
        }


        private void addSubCauses(Causes root, Cause rootobj)
        {
            if (root.children != null)
            {
                foreach (var c in root.children)
                {
                    Cause child = new Cause();
                    child.CauseName = c.name;
                    child.Description = c.Description == string.Empty ? null : c.Description;
                    child.ModifiedDate = DateTime.Now;

                    if (c.children != null)
                    {
                        addSubCauses(c, child);
                    }

                    rootobj.Causes.Add(child);
                }
            }
        }
     
        [WebMethod]
        public string[] loadDependantRelation()
        {
            var relation = (from rel in _context.DependantRelations
                         select rel.DependantRelation1).ToArray();

            return relation;
        }

        [WebMethod]
        public string[] loadEducationGradeSystem()
        {
            var grade = (from sys in _context.GradeSystems
                        select sys.Grade).ToArray();

            return grade;
        }

        [WebMethod]
        public string[] loadStudyMode()
        {
            var mode = (from STDYMOD in _context.StudyModes
                          select STDYMOD.StudyMode1).ToArray();

            return mode;
        }

        [WebMethod]
        public string[] loadEducationDegree()
        {
            var degree = (from DGR in _context.EducationDegrees
                          select DGR.DegreeTitle).ToArray();

            return degree;
        }

        [WebMethod]
        public string[] loadResidenceType()
        {
            var type = (from TYP in _context.ResidencePermitTypes
                        select TYP.PermitType).ToArray();
            return type;
        }
        [WebMethod]
        public string[] loadResidenceStatus()
        {
            var status = (from STS in _context.ResidencePermitStatus
                        select STS.ResidencePermitStatus1).ToArray();
            return status;
        }
        [WebMethod]
        public string[] loadQuestionMode()
        {
            var mode = (from MOD in _context.QuestionModes
                             select MOD.QuestionMode1).ToArray();
            return mode;
        }

        [WebMethod]
        public string[] loadCourseQuestions()
        {
            var questions = (from QUS in _context.CourseQuestions
                             select QUS.Question).ToArray();
            return questions;
        }
        [WebMethod]
        public string[] loadAttendanceStatus()
        {
            var attendance = (from ATTSTS in _context.CourseAttendanceStatus
                              select ATTSTS.AttendanceStatus).ToArray();
            return attendance;
        }

        [WebMethod]
        public string[] loadProficiencyLevel()
        {
            var proflevel = (from PRFLVL in _context.EnrollerLevels
                             select PRFLVL.EnrollerLevel1).ToArray();
            return proflevel;
        }

        [WebMethod]
        public string[] loadRecordMode()
        {
            var mode = (from MODSTS in _context.RecordModes
                        select MODSTS.RecordMode1).ToArray();
            return mode;
        }

        [WebMethod]
        public string[] loadReviewStatus()
        {
            var status = (from STS in _context.ManagementStatus
                            select STS.ManagementStatus1).ToArray();
            return status;
        }

        [WebMethod]
        public string[] loadCourseStatus()
        {
            var status = (from STS in _context.TrainingCourseStatus
                          select STS.TrainingStatus).ToArray();
            return status;
        }
        [WebMethod]
        public string[] loadInstructorType()
        {
            var instructortype = (from INSTTYP in _context.InstructorTypes
                                  select INSTTYP.InstructorType1).ToArray();
            return instructortype;
        }
        [WebMethod]
        public string[] loadAllDCRType()
        {
            var ccnTypes = (from CCNT in _context.ChangeControlTypes
                            select CCNT.CCNType).ToArray();
            return ccnTypes;
        }
        [WebMethod]
        public string[] loadResult()
        {
            var result = (from RES in _context.Results
                             select RES.Result1).ToArray();

            return result;
        }
        [WebMethod]
        public string[] loadProjectStatus()
        {
            var projstatus = (from STS in _context.ProjectStatus
                              select STS.ProjectStatus1).ToArray();
            return projstatus;
        }
        [WebMethod]
        public string[] loadAssetStatus()
        {
            var assetstatus = (from STS in _context.AssetStatus
                               select STS.AssetStatus1).ToArray();
            return assetstatus;
        }
        [WebMethod]
        public string[] loadCurrencies()
        {
            var currencies = (from CURR in _context.Currencies
                              select CURR.CurrencyCode).ToArray();
            return currencies;
        }
        [WebMethod]
        public string[] loadSecurityKeys()
        {
            var keys = (from KEY in _context.AT_TreeNodeSecurityKeys
                        select KEY.SecurityKey).ToArray();

            return keys;
        }
        [WebMethod]
        public string[] loadDCRStatus()
        {
            var CCNStatus = (from CCNSTS in _context.ChangeControlNoteStatus
                             select CCNSTS.CCNStatus).ToArray();
            return CCNStatus;
        }
        [WebMethod]
        public string[] loadSMTPServers()
        {
            var servers = (from SRV in _context.AT_SMTPservers
                           select SRV.SMTPserver).ToArray();

            return servers;
        }
        [WebMethod]
        public string[] loadTitles()
        {
            var titles = (from TTL in _context.Titles
                          select TTL.Title1).ToArray();

            return titles;
        }

        [WebMethod]
        public string[] loadEmployees()
        {
            var employees = (from EMP in _context.fn_GetEmployees()
                             select EMP.EmployeeName).ToArray();
            return employees;
        }
        
        [WebMethod]
        public string[] loadDocumentTypes()
        {
            var doctype = (from dt in _context.DocumentTypes
                            select dt.DocumentType1).ToArray();

            return doctype;
        }
        [WebMethod]
        public string[] loadDocumentFileTypes()
        {
            var docftype = (from dft in _context.DocumentFileTypes
                           select dft.FileType).ToArray();

            return docftype;
        }
        [WebMethod]
        public object[] loadDocumentFileTypes2()
        {
            var docftype = (from dft in _context.DocumentFileTypes
                            select new { dft.Extention,dft.FileType}).ToArray();

            return docftype;
        }
        [WebMethod]
        public string[] loadModules()
        {
            var modules = (from MOD in _context.Modules
                           where MOD.Active == true
                           orderby MOD.Name
                           select MOD.Name).ToArray();
            return modules;
        }
        [WebMethod]
        public string[] loadApprovalStatus()
        {
            var approvals = (from APPR in _context.ApprovalStatus
                             where APPR.ApprovalStatusID!=(int)ApprovalStatus.PENDING
                             select APPR.ApprovalStatus1).ToArray();
            return approvals;
        }
        [WebMethod]
        public string[] loadPositionStatus()
        {
            var status = (from STS in _context.PositionStatus
                          select STS.PositionStatus1).ToArray();
            return status;
        }

        [WebMethod]
        public string[] loadMemberTypes()
        {
            var memtyp = (from MTYP in _context.ApprovalMemberTypes
                          select MTYP.MemberType).ToArray();
            return memtyp;
        }

        [WebMethod]
        public string[] loadPeriod()
        {
            var periods = (from PRD in _context.Periods
                           select PRD.Period1).ToArray();
            return periods;
        }
        [WebMethod]
        public string[] loadGenders()
        {
            var genders = (from GDR in _context.Genders
                           select GDR.Gender1).ToArray();
            return genders;
        }
        [WebMethod]
        public string[] loadMaritalStatus()
        {
            var marital = (from MTR in _context.MaritalStatus
                           select MTR.MaritalStatus1).ToArray();
            return marital;
        }
        [WebMethod]
        public string[] loadReligions()
        {
            var religions = (from REL in _context.Religions
                             select REL.Religion1).ToArray();
            return religions;
        }
       
        [WebMethod]
        public string[] loadCCNActions()
        {
            var actions = (from ACT in _context.ChangeControlTypes
                           select ACT.CCNType).ToArray();
            return actions;
        }
        
        //subject to modification dependending on method loadJSONOrganizationLevel
        [WebMethod]
        public string[] loadOrganizationLevel()
        {
            var levels = (from LVL in _context.OrganizationLevels
                         select LVL.ORGLevel).ToArray();
            return levels;
        }
       
        [WebMethod]
        public string[] loadOperators()
        {
            var operators = (from OPR in _context.AT_RAGSigns
                             select OPR.Sign).ToArray();
            return operators;
        }

        [WebMethod]
        public string[] loadComparatorOperators()
        {
            var operators = (from OPR in _context.AT_RAGSigns
                             where OPR.IsComparator==true
                             select OPR.Sign).ToArray();
            return operators;
        }

        [WebMethod]
        public string[] loadAuditType()
        {

            var audittype = (from AUDTTYP in _context.AuditTypes
                             select AUDTTYP.AuditType1).ToArray();
            return audittype;
        }

        [WebMethod]
        public string[] loadAuditStatus()
        {

            var auditstatus = (from AUDTSTS in _context.AuditStatus
                               select AUDTSTS.AuditStatus1).ToArray();
            return auditstatus;
        }

       
        [WebMethod]
        public string getDialCode(string country)
        {
            var dial = (from CTRY in _context.Countries
                        where CTRY.CountryName == country
                        select CTRY.DialCode).SingleOrDefault();

            return dial.ToString();
        }
        [WebMethod]
        public string[] loadCountries()
        {
            var countries = (from C in _context.Countries
                             orderby C.CountryName
                         select C.CountryName).ToArray();
            return countries;
        }

        [WebMethod]
        public object[] loadCountries2()
        {
            var countries = (from C in _context.Countries
                             orderby C.CountryName
                             select new { C.CountryID, C.CountryName }).ToArray();
            return countries;
        }
        [WebMethod]
        public Dictionary<string, string> loadCountryList()
        {
            var countries = (from C in _context.Countries
                             orderby C.CountryName
                             select C).ToList();

            Dictionary<string, string> dictCountries = new Dictionary<string, string>();
            foreach(var c in countries)
            {
                dictCountries.Add(c.CountryID.ToString(), c.CountryName);
            }

            return dictCountries;
        }

        [WebMethod]
        public Dictionary<string, string> loadStates(string countryId)
        {
            if (countryId == "")
                countryId = "0";

            var states = (from R in _context.Regions
                          where R.CountryID == Convert.ToInt32(countryId)
                             orderby R.RegionName
                          select R).ToList();

            Dictionary<string, string> dictStates = new Dictionary<string, string>();
            foreach (var s in states)
            {
                dictStates.Add(s.RegionID.ToString(), s.RegionName);
            }
            return dictStates;
        }

        [WebMethod]
        public Dictionary<string, string> loadCitiesByRegion(string regionId)
        {
            if (regionId == "null" || regionId == "")
                regionId = "0";
            var cities = (from C in _context.Cities
                          where C.RegionID == Convert.ToInt32(regionId)
                          orderby C.CityName
                          select C).ToList();

            Dictionary<string, string> dictCities = new Dictionary<string, string>();
            foreach (var c in cities)
            {
                dictCities.Add(c.CityID.ToString(), c.CityName);
            }
            return dictCities;
        }

        [WebMethod]
        public Dictionary<string, string> loadCitiesByCountry(string countryId)
        {
            if (countryId == null && countryId == "")
                countryId = "0";
            var cities = (from C in _context.Cities
                          where C.CountryID == Convert.ToInt32(countryId)
                          orderby C.CityName
                          select C).ToList();

            Dictionary<string, string> dictCities = new Dictionary<string, string>();
            foreach (var c in cities)
            {
                dictCities.Add(c.CityID.ToString(), c.CityName);
            }
            return dictCities;
        }

        [WebMethod]
        public object[] loadCitiesByCountry2(string countryId)
        {
            if (countryId == null && countryId == "")
                countryId = "0";

            var cities = (from C in _context.Cities
                          where C.CountryID == Convert.ToInt32(countryId)
                          orderby C.CityName
                          select new { C.CityID, C.CityName }).ToArray();
            return cities;
        }
       
        [WebMethod]
        public string[] loadContractType()
        {
            var ctype = (from CTYP in _context.ContractTypes
                         select CTYP.ContractType1).ToArray();
            return ctype;
        }
        #endregion

        #region CostCentre

        [WebMethod]
        public void createCostCentre(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            CostCentre obj = serializer.Deserialize<CostCentre>(json);

            var centre = _context.CostCentres.Where(CNTR => CNTR.CostCentreName == obj.CostCentreName)
                .Select(CNTR => CNTR).SingleOrDefault();

            if (centre == null)
            {
                centre = _context.CostCentres.Where(CNTR => CNTR.CostCentreNo == obj.CostCentreNo).Select(CNTR => CNTR).SingleOrDefault();
                if (centre == null)
                {
                    centre = new LINQConnection.CostCentre();
                    centre.CostCentreNo = obj.CostCentreNo;
                    centre.CostCentreName = obj.CostCentreName;
                    centre.UnitID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == obj.ORGUnit).UnitID;
                    centre.ManagerID = (from EMP in _context.Employees
                                        where EMP.FirstName == obj.Manager.Substring(obj.Manager.LastIndexOf(".") + 1, obj.Manager.IndexOf(" ") - 3) &&
                                        EMP.LastName == obj.Manager.Substring(obj.Manager.IndexOf(" ") + 1)
                                        select EMP.EmployeeID).SingleOrDefault();

                    centre.ModifiedDate = DateTime.Now;
                    centre.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    _context.CostCentres.InsertOnSubmit(centre);
                    _context.SubmitChanges();
                }
                else
                {
                    throw new Exception("Enter a unique identifier for the cost centre");
                }
            }
            else
            {
                throw new Exception("The name of the cost centre already exists");
            }
    
        }

        [WebMethod]
        public string getLastCentreID()
        {
            string centreID = null;

            if (_context.CostCentres.ToList().Count > 0)
            {
                long maxId = _context.CostCentres.Max(i => i.CostCentreID);
                centreID = _context.CostCentres.Single(CNTR => CNTR.CostCentreID == maxId).CostCentreNo;
            }
            return centreID == null ? string.Empty : centreID;
        }

        [WebMethod]
        public void updateCostCentre(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            CostCentre obj = serializer.Deserialize<CostCentre>(json);

            var centre = _context.CostCentres.Where(CNTR => CNTR.CostCentreNo == obj.CostCentreNo)
                .Select(CNTR => CNTR).SingleOrDefault();

            if (centre != null)
            {
                centre.CostCentreName = obj.CostCentreName;
                centre.UnitID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == obj.ORGUnit).UnitID;
                centre.ManagerID = (from EMP in _context.Employees
                                    where EMP.FirstName == obj.Manager.Substring(obj.Manager.LastIndexOf(".") + 1, obj.Manager.IndexOf(" ") - 3) &&
                                    EMP.LastName == obj.Manager.Substring(obj.Manager.IndexOf(" ") + 1)
                                    select EMP.EmployeeID).SingleOrDefault();

                centre.ModifiedDate = DateTime.Now;
                centre.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related cost centre record");
            }

        }

        [WebMethod]
        public string loadCostCentres()
        {
            var centres = _context.CostCentres
                .Select(COST => new CostCentre
                {
                    CostCentreID=COST.CostCentreID,
                    CostCentreNo=COST.CostCentreNo,
                    CostCentreName=COST.CostCentreName,
                    ORGUnit=COST.OrganizationUnit.UnitName,
                    Manager= (from T in _context.Titles
                                       join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                       from g in empgroup
                                       where g.EmployeeID == COST.ManagerID
                                       select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            var xml = new XmlSerializer(typeof(List<CostCentre>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, centres);

            return str.ToString();
        }

        [WebMethod]
        public void removeCostCentre(string centreNo)
        {
            var centre = _context.CostCentres.Where(CNTR => CNTR.CostCentreNo == centreNo).Select(CNTR => CNTR).SingleOrDefault();
            if (centre != null)
            {
                if (centre.Assets.Count() > 0 || centre.Assets1.Count() > 0)
                {
                    throw new Exception("The value of the cost centre is referenced in one or more asset records, please make sure you remove this reference and try again");
                }
                else
                {
                    _context.CostCentres.DeleteOnSubmit(centre);
                    _context.SubmitChanges();
                }
            }
            else
            {
                throw new Exception("Cannot find the related cost centre record");
            }
       
        }
        #endregion
        #region AssetManagement

        [WebMethod]
        public string filterAssetsByPurchaseDate(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var assets = _context.Assets
              .Where(ASST => ASST.PurchaseDate >= obj.StartDate && ASST.PurchaseDate <= obj.EndDate)
              .Select(ASST => new Asset
              {
                  AssetID = ASST.AssetId,
                  TAG = ASST.Tag,
                  OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                  BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                  SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                  AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                  AssetCategory = ASST.AssetCategory.CategoryName,
                  CostCentre = ASST.CostCentre.CostCentreName,
                  OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                  WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                  BillingCategory = ASST.BillingCategory.PaymentMethod,
                  AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                  Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                  PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                  PurchasePrice = ASST.PurchasePrice,
                  Currency = ASST.Currency.CurrencyCode,
                  CurrentValue = ASST.CurrentAssetValue,
                  Supplier = ASST.Customer1.CustomerName,
                  ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer.CustomerName,
                  AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                  AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                         from g in empgroup
                                                                                         where g.EmployeeID == ASST.AnotherOwnerId
                                                                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == ASST.OwnerId
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  DepreciableLife = ASST.DepreciableLife,
                  DepreciablePeriod = ASST.Period3.Period1,
                  Department = ASST.OrganizationUnit.UnitName,
                  Description = ASST.Description == null ? string.Empty : ASST.Description,
                  Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                  DisposalDate = ASST.DisposeDate != null ? ConvertToLocalTime(ASST.DisposeDate.Value) : ASST.DisposeDate,
                  DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                  IsBillable = ASST.Billable,
                  Model = ASST.Model,
                  Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                  RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                  Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                  CalibrationFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                  CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                  MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                  MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                  MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                  ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                  ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                  ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                  ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                  AssetStatus = ASST.AssetStatus.AssetStatus1,
                  HasCalibration = ASST.HasCalibration,
                  HasElectricalTest = ASST.HasElectricalTest,
                  HasMaintenance = ASST.HasMaintenance,
                  FloorNo=ASST.FloorNo,
                  RoomNo=ASST.RoomNo,
                  Mode = (RecordMode)ASST.RecordModeID,
                

              }).ToList();

            var xml = new XmlSerializer(typeof(List<Asset>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, assets);

            return str.ToString();
        }
        [WebMethod]
        public string filterAssetsByInstallationDate(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var assets = _context.Assets
              .Where(ASST => ASST.InstallationDate >= obj.StartDate && ASST.InstallationDate <= obj.EndDate)
              .Select(ASST => new Asset
              {
                  AssetID = ASST.AssetId,
                  TAG = ASST.Tag,
                  OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                  BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                  SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                  AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                  AssetCategory = ASST.AssetCategory.CategoryName,
                  CostCentre = ASST.CostCentre.CostCentreName,
                  OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                  WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                  BillingCategory = ASST.BillingCategory.PaymentMethod,
                  AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                  Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                  PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                  PurchasePrice = ASST.PurchasePrice,
                  Currency = ASST.Currency.CurrencyCode,
                  CurrentValue = ASST.CurrentAssetValue,
                  Supplier = ASST.Customer1.CustomerName,
                  ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer.CustomerName,
                  AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                  AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                         from g in empgroup
                                                                                         where g.EmployeeID == ASST.AnotherOwnerId
                                                                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == ASST.OwnerId
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  DepreciableLife = ASST.DepreciableLife,
                  DepreciablePeriod = ASST.Period3.Period1,
                  Department = ASST.OrganizationUnit.UnitName,
                  Description = ASST.Description == null ? string.Empty : ASST.Description,
                  Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                  DisposalDate = ASST.DisposeDate != null ? ConvertToLocalTime(ASST.DisposeDate.Value) : ASST.DisposeDate,
                  DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                  IsBillable = ASST.Billable,
                  Model = ASST.Model,
                  Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                  RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                  Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                  CalibrationFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                  CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                  MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                  MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                  MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                  ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                  ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                  ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                  ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                  AssetStatus = ASST.AssetStatus.AssetStatus1,
                  HasCalibration = ASST.HasCalibration,
                  HasElectricalTest = ASST.HasElectricalTest,
                  HasMaintenance = ASST.HasMaintenance,
                   FloorNo=ASST.FloorNo,
                  RoomNo=ASST.RoomNo,
                  Mode = (RecordMode)ASST.RecordModeID,
                


              }).ToList();

            var xml = new XmlSerializer(typeof(List<Asset>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, assets);

            return str.ToString();
        }

        [WebMethod]
        public string filterAssetsByDepartment(string department)
        {
            var assets = _context.Assets
              .Where(ASST => ASST.OrganizationUnit.UnitName == department)
              .Select(ASST => new Asset
              {
                  AssetID = ASST.AssetId,
                  TAG = ASST.Tag,
                  OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                  BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                  SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                  AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                  AssetCategory = ASST.AssetCategory.CategoryName,
                  CostCentre = ASST.CostCentre.CostCentreName,
                  OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                  WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                  BillingCategory = ASST.BillingCategory.PaymentMethod,
                  AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                  Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                  PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                  PurchasePrice = ASST.PurchasePrice,
                  Currency = ASST.Currency.CurrencyCode,
                  CurrentValue = ASST.CurrentAssetValue,
                  Supplier = ASST.Customer1.CustomerName,
                  ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer.CustomerName,
                  AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                  AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                         from g in empgroup
                                                                                         where g.EmployeeID == ASST.AnotherOwnerId
                                                                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == ASST.OwnerId
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  DepreciableLife = ASST.DepreciableLife,
                  DepreciablePeriod = ASST.Period3.Period1,
                  Department = ASST.OrganizationUnit.UnitName,
                  Description = ASST.Description == null ? string.Empty : ASST.Description,
                  Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                  DisposalDate = ASST.DisposeDate != null ? ConvertToLocalTime(ASST.DisposeDate.Value) : ASST.DisposeDate,
                  DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                  IsBillable = ASST.Billable,
                  Model = ASST.Model,
                  Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                  RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                  Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                  CalibrationFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                  CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                  MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                  MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                  MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                  ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                  ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                  ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                  ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                  AssetStatus = ASST.AssetStatus.AssetStatus1,
                  HasCalibration = ASST.HasCalibration,
                  HasElectricalTest = ASST.HasElectricalTest,
                  HasMaintenance = ASST.HasMaintenance,
                  FloorNo = ASST.FloorNo,
                  RoomNo = ASST.RoomNo,
                  Mode = (RecordMode)ASST.RecordModeID,
                

              }).ToList();

            var xml = new XmlSerializer(typeof(List<Asset>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, assets);

            return str.ToString();
        }

        [WebMethod]
        public string filterAssetsByStatus(string status)
        {
            var assets = _context.Assets
              .Where(ASST => ASST.AssetStatus.AssetStatus1 == status)
              .Select(ASST => new Asset
              {
                  AssetID = ASST.AssetId,
                  TAG = ASST.Tag,
                  OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                  BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                  SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                  AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                  AssetCategory = ASST.AssetCategory.CategoryName,
                  CostCentre = ASST.CostCentre.CostCentreName,
                  OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                  WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                  BillingCategory = ASST.BillingCategory.PaymentMethod,
                  AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                  Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                  PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                  PurchasePrice = ASST.PurchasePrice,
                  Currency = ASST.Currency.CurrencyCode,
                  CurrentValue = ASST.CurrentAssetValue,
                  Supplier = ASST.Customer1.CustomerName,
                  ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer.CustomerName,
                  AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                  AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                         from g in empgroup
                                                                                         where g.EmployeeID == ASST.AnotherOwnerId
                                                                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == ASST.OwnerId
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  DepreciableLife = ASST.DepreciableLife,
                  DepreciablePeriod = ASST.Period3.Period1,
                  Department = ASST.OrganizationUnit.UnitName,
                  Description = ASST.Description == null ? string.Empty : ASST.Description,
                  Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                  DisposalDate = ASST.DisposeDate,
                  DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                  IsBillable = ASST.Billable,
                  Model = ASST.Model,
                  Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                  RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                  Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                  CalibrationFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                  CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                  MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                  MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                  MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                  ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                  ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                  ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                  ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                  AssetStatus = ASST.AssetStatus.AssetStatus1,
                  HasCalibration = ASST.HasCalibration,
                  HasElectricalTest = ASST.HasElectricalTest,
                  HasMaintenance = ASST.HasMaintenance,
                  FloorNo = ASST.FloorNo,
                  RoomNo = ASST.RoomNo,
                  Mode = (RecordMode)ASST.RecordModeID,


              }).ToList();

            var xml = new XmlSerializer(typeof(List<Asset>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, assets);

            return str.ToString();
        }

        [WebMethod]
        public string filterAssetsByCategory(string category)
        {
            var assets = _context.Assets
              .Where(ASST => ASST.AssetCategory.CategoryName == category)
              .Select(ASST => new Asset
              {
                  AssetID = ASST.AssetId,
                  TAG = ASST.Tag,
                  OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                  BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                  SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                  AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                  AssetCategory = ASST.AssetCategory.CategoryName,
                  CostCentre = ASST.CostCentre.CostCentreName,
                  OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                  WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                  BillingCategory = ASST.BillingCategory.PaymentMethod,
                  AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                  Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                  PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                  PurchasePrice = ASST.PurchasePrice,
                  Currency = ASST.Currency.CurrencyCode,
                  CurrentValue = ASST.CurrentAssetValue,
                  Supplier = ASST.Customer1.CustomerName,
                  ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer.CustomerName,
                  AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                  AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                         from g in empgroup
                                                                                         where g.EmployeeID == ASST.AnotherOwnerId
                                                                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == ASST.OwnerId
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  DepreciableLife = ASST.DepreciableLife,
                  DepreciablePeriod = ASST.Period3.Period1,
                  Department = ASST.OrganizationUnit.UnitName,
                  Description = ASST.Description == null ? string.Empty : ASST.Description,
                  Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                  DisposalDate = ASST.DisposeDate != null ? ConvertToLocalTime(ASST.DisposeDate.Value) : ASST.DisposeDate,
                  DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                  IsBillable = ASST.Billable,
                  Model = ASST.Model,
                  Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                  RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                  Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                  CalibrationFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                  CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                  MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                  MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                  MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                  ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                  ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                  ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                  ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                  AssetStatus = ASST.AssetStatus.AssetStatus1,
                  HasCalibration=ASST.HasCalibration,
                  HasElectricalTest=ASST.HasElectricalTest,
                  HasMaintenance=ASST.HasMaintenance,
                  FloorNo = ASST.FloorNo,
                  RoomNo = ASST.RoomNo,
                  Mode = (RecordMode)ASST.RecordModeID,
                


              }).ToList();

            var xml = new XmlSerializer(typeof(List<Asset>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, assets);

            return str.ToString();
        }

        [WebMethod]
        public string filterAssetsByMode(string mode)
        {
            var assets = _context.Assets
              .Where(ASST => ASST.RecordMode.RecordMode1 == mode )
              .Select(ASST => new Asset
              {
                  AssetID = ASST.AssetId,
                  TAG = ASST.Tag,
                  OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                  BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                  SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                  AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                  AssetCategory = ASST.AssetCategory.CategoryName,
                  CostCentre = ASST.CostCentre.CostCentreName,
                  OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                  WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                  BillingCategory = ASST.BillingCategory.PaymentMethod,
                  AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                  Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                  PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                  PurchasePrice = ASST.PurchasePrice,
                  Currency = ASST.Currency.CurrencyCode,
                  CurrentValue = ASST.CurrentAssetValue,
                  Supplier = ASST.Customer1.CustomerName,
                  ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer.CustomerName,
                  AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                  AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                         from g in empgroup
                                                                                         where g.EmployeeID == ASST.AnotherOwnerId
                                                                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == ASST.OwnerId
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  DepreciableLife = ASST.DepreciableLife,
                  DepreciablePeriod = ASST.Period3.Period1,
                  Department = ASST.OrganizationUnit.UnitName,
                  Description = ASST.Description == null ? string.Empty : ASST.Description,
                  Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                  DisposalDate = ASST.DisposeDate != null ? ConvertToLocalTime(ASST.DisposeDate.Value) : ASST.DisposeDate,
                  DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                  IsBillable = ASST.Billable,
                  Model = ASST.Model,
                  Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                  RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                  Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                  CalibrationFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                  CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                  MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                  MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                  MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                  ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                  ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                  ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                  ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                  AssetStatus = ASST.AssetStatus.AssetStatus1,
                  HasCalibration = ASST.HasCalibration,
                  HasElectricalTest = ASST.HasElectricalTest,
                  HasMaintenance = ASST.HasMaintenance,
                  FloorNo = ASST.FloorNo,
                  RoomNo = ASST.RoomNo,
                  Mode = (RecordMode)ASST.RecordModeID,
                


              }).ToList();

            var xml = new XmlSerializer(typeof(List<Asset>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, assets);

            return str.ToString();
        }
        [WebMethod]
        public string loadAssets()
        {
            /*load all non-archived assets*/
            var assets = _context.Assets
            .Select(ASST => new Asset
            {
                AssetID = ASST.AssetId,
                TAG = ASST.Tag,
                OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                AssetCategory = ASST.AssetCategory.CategoryName,
                CostCentre = ASST.CostCentre.CostCentreName,
                OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                BillingCategory = ASST.BillingCategory.PaymentMethod,
                AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                PurchasePrice = ASST.PurchasePrice,
                Currency = ASST.Currency.CurrencyCode,
                CurrentValue = ASST.CurrentAssetValue,
                Supplier = ASST.Customer1.CustomerName,
                ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer.CustomerName,
                AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                       join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                       from g in empgroup
                                                                                       where g.EmployeeID == ASST.AnotherOwnerId
                                                                                       select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == ASST.OwnerId
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                DepreciableLife = ASST.DepreciableLife,
                DepreciablePeriod = ASST.Period3.Period1,
                Department = ASST.OrganizationUnit.UnitName,
                Description = ASST.Description == null ? string.Empty : ASST.Description,
                Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                DisposalDate = ASST.DisposeDate != null ? ConvertToLocalTime(ASST.DisposeDate.Value) : ASST.DisposeDate,
                DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                IsBillable = ASST.Billable,
                Model = ASST.Model == null ? string.Empty : ASST.Model,
                Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                CalibrationFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                AssetStatus = ASST.AssetStatus.AssetStatus1,
                HasCalibration = ASST.HasCalibration,
                HasElectricalTest = ASST.HasElectricalTest,
                HasMaintenance = ASST.HasMaintenance,
                FloorNo = ASST.FloorNo,
                RoomNo = ASST.RoomNo,
                Mode = (RecordMode)ASST.RecordModeID

            }).ToList();

            var xml = new XmlSerializer(typeof(List<Asset>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, assets);

            return str.ToString();
        }

        [WebMethod]
        public void createMaintenance(string json, string TAG)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AssetExtensions obj = serializer.Deserialize<AssetExtensions>(json);
            var asset = _context.Assets.Where(ASST => ASST.Tag == TAG).Select(ASST => ASST).SingleOrDefault();
            if (asset != null)
            {
                var maintenance = new AssetMaintenance();
                maintenance.PurchaseOrderNumber = obj.PurchaseOrderNumber;
                maintenance.MaintenanceDate = obj.ExtensionDate;
                maintenance.MaintenanceDueDate = obj.ExtensionDueDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.ExtensionDueDate);
                maintenance.MaintenanceCost = obj.ExtensionCost;
                maintenance.ResultID = _context.Results.Single(RES => RES.Result1 == obj.ResultString).ResultID;
                maintenance.MaintenanceProviderID = obj.ExtensionProvider == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExtensionProvider).CustomerID;  
                maintenance.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                maintenance.Trend = obj.Trend;
                maintenance.ActionNeededOrComment = obj.ActionNeededOrComment == string.Empty ? null : obj.ActionNeededOrComment;
                maintenance.ModifiedDate = DateTime.Now;
                maintenance.ModifiedBy = HttpContext.Current.User.Identity.Name;

                asset.AssetMaintenances.Add(maintenance);
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot to find the related asset record");
            }
        }
        [WebMethod]
        public void createCalibration(string json, string TAG)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AssetExtensions obj = serializer.Deserialize<AssetExtensions>(json);
            var asset = _context.Assets.Where(ASST => ASST.Tag == TAG).Select(ASST => ASST).SingleOrDefault();
            if (asset != null)
            {
                  var calibration = new AssetCalibration();
                  calibration.PurchaseOrderNumber = obj.PurchaseOrderNumber;
                  calibration.CalibrationDate = obj.ExtensionDate;
                  calibration.CalibrationDueDate = obj.ExtensionDueDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.ExtensionDueDate);
                  calibration.CalibrationCost = obj.ExtensionCost;
                  calibration.ResultID = _context.Results.Single(RES => RES.Result1 == obj.ResultString).ResultID;
                  calibration.CalibrationProviderID = obj.ExtensionProvider == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExtensionProvider).CustomerID;
                  calibration.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                  calibration.Trend = obj.Trend;
                  calibration.ActionNeededOrComment = obj.ActionNeededOrComment == string.Empty ? null : obj.ActionNeededOrComment;
                  calibration.ModifiedDate = DateTime.Now;
                  calibration.ModifiedBy = HttpContext.Current.User.Identity.Name;

                  asset.AssetCalibrations.Add(calibration);
                  _context.SubmitChanges();

              }
              else
              {
                  throw new Exception("Unable to find the related asset record");
              }
        }

        [WebMethod]
        public void createElectricalTest(string json, string TAG)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AssetExtensions obj = serializer.Deserialize<AssetExtensions>(json);
            var asset = _context.Assets.Where(ASST => ASST.Tag == TAG).Select(ASST => ASST).SingleOrDefault();
            if (asset != null)
            {
                var electricaltest = new AssetElectricalTest();
                electricaltest.PurchaseOrderNumber = obj.PurchaseOrderNumber;
                electricaltest.ElectricalTestDate = obj.ExtensionDate;
                electricaltest.ElectricalTestDueDate= obj.ExtensionDueDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.ExtensionDueDate);
                electricaltest.ElectricalTestCost = obj.ExtensionCost;
                electricaltest.ResultID = _context.Results.Single(RES => RES.Result1 == obj.ResultString).ResultID;
                electricaltest.ElectricalTestProviderID = obj.ExtensionProvider == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExtensionProvider).CustomerID; 
                electricaltest.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                electricaltest.Trend = obj.Trend;
                electricaltest.ActionNeededOrComment = obj.ActionNeededOrComment == string.Empty ? null : obj.ActionNeededOrComment;
                electricaltest.ModifiedDate = DateTime.Now;
                electricaltest.ModifiedBy = HttpContext.Current.User.Identity.Name;

                asset.AssetElectricalTests.Add(electricaltest);
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Unable to find the related asset record");
            }
        }
        [WebMethod]
        public void updateMaintenance(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AssetExtensions obj = serializer.Deserialize<AssetExtensions>(json);

            var maintenance = _context.AssetMaintenances.Where(MAINT => MAINT.AssetMaintenanceId == obj.ExtensionID)
                .Select(MAINT => MAINT).SingleOrDefault();

            if (maintenance != null)
            {
                maintenance.PurchaseOrderNumber = obj.PurchaseOrderNumber;
                maintenance.MaintenanceDate = obj.ExtensionDate;
                maintenance.MaintenanceDueDate = obj.ExtensionDueDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.ExtensionDueDate);
                maintenance.MaintenanceCost = obj.ExtensionCost;
                maintenance.ResultID = _context.Results.Single(RES => RES.Result1 == obj.ResultString).ResultID;
                maintenance.MaintenanceProviderID = obj.ExtensionProvider == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExtensionProvider).CustomerID;
                maintenance.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                maintenance.Trend = obj.Trend;
                maintenance.ActionNeededOrComment = obj.ActionNeededOrComment == string.Empty ? null : obj.ActionNeededOrComment;
                maintenance.ModifiedDate = DateTime.Now;
                maintenance.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related asset maintenance record");
            }
        }

       
        [WebMethod]
        public void updateCalibration(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AssetExtensions obj = serializer.Deserialize<AssetExtensions>(json);

            var calibration = _context.AssetCalibrations.Where(CAL => CAL.AssetCalibrationId == obj.ExtensionID)
                .Select(CAL => CAL).SingleOrDefault();

            if (calibration != null)
            {
                  calibration.PurchaseOrderNumber = obj.PurchaseOrderNumber;
                  calibration.CalibrationDate = obj.ExtensionDate;
                  calibration.CalibrationDueDate = obj.ExtensionDueDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.ExtensionDueDate);
                  calibration.CalibrationCost = obj.ExtensionCost;
                  calibration.ResultID = _context.Results.Single(RES => RES.Result1 == obj.ResultString).ResultID;
                  calibration.CalibrationProviderID = obj.ExtensionProvider == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExtensionProvider).CustomerID;
                  calibration.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                  calibration.Trend = obj.Trend;
                  calibration.ActionNeededOrComment = obj.ActionNeededOrComment == string.Empty ? null : obj.ActionNeededOrComment;
                  calibration.ModifiedDate = DateTime.Now;
                  calibration.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related asset's calibration record");
            }
        }

        [WebMethod]
        public void updateElectricalTest(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AssetExtensions obj = serializer.Deserialize<AssetExtensions>(json);

            var electricaltest = _context.AssetElectricalTests.Where(TST => TST.AssetElectricalTestId == obj.ExtensionID)
                .Select(TST => TST).SingleOrDefault();

            if (electricaltest != null)
            {
                electricaltest.PurchaseOrderNumber = obj.PurchaseOrderNumber;
                electricaltest.ElectricalTestDate = obj.ExtensionDate;
                electricaltest.ElectricalTestDueDate = obj.ExtensionDueDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.ExtensionDueDate);
                electricaltest.ElectricalTestCost = obj.ExtensionCost;
                electricaltest.ResultID = _context.Results.Single(RES => RES.Result1 == obj.ResultString).ResultID;
                electricaltest.ElectricalTestProviderID = obj.ExtensionProvider == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExtensionProvider).CustomerID;
                electricaltest.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                electricaltest.Trend = obj.Trend;
                electricaltest.ActionNeededOrComment = obj.ActionNeededOrComment == string.Empty ? null : obj.ActionNeededOrComment;
                electricaltest.ModifiedDate = DateTime.Now;
                electricaltest.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Unable to fine the related asset's electrical test record");
            }
        }
        [WebMethod]
        public void removeMaintenance(long ID)
        {
            var maintenance = _context.AssetMaintenances.Where(MAINT => MAINT.AssetMaintenanceId == ID)
                .Select(MAINT => MAINT).SingleOrDefault();

            if (maintenance != null)
            {
                _context.AssetMaintenances.DeleteOnSubmit(maintenance);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to fine the related asset's maintenance record");
            }
        }

        [WebMethod]
        public void removeCalibration(long ID)
        {
            var calibration = _context.AssetCalibrations.Where(CAL => CAL.AssetCalibrationId == ID)
                .Select(CAL => CAL).SingleOrDefault();

            if (calibration != null)
            {
                _context.AssetCalibrations.DeleteOnSubmit(calibration);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to fine the related asset's calibration record");
            }
        }

        [WebMethod]
        public void removeElectricalTest(long ID)
        {
            var electricaltest = _context.AssetElectricalTests.Where(TST => TST.AssetElectricalTestId == ID)
                .Select(TST => TST).SingleOrDefault();

            if (electricaltest != null)
            {
                _context.AssetElectricalTests.DeleteOnSubmit(electricaltest);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to fine the related asset's electrical test record");
            }
        }
        [WebMethod]
        public void createDepreciation(string json,string TAG)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Depreciation obj = serializer.Deserialize<Depreciation>(json);

            var asset = _context.Assets.Where(ASST => ASST.Tag == TAG).Select(ASST => ASST).SingleOrDefault();
            if (asset != null)
            {
                var depreciation = new AssetDepreciation();
                depreciation.DepreciationAmount = obj.DepreciationAmount;
                depreciation.DepreciationDate = obj.DepreciationDate;
                depreciation.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                depreciation.ModifiedDate = DateTime.Now;
                depreciation.ModifiedBy = HttpContext.Current.User.Identity.Name;

                asset.AssetDepreciations.Add(depreciation);

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to find the related asset record");
            }
        }

        [WebMethod]
        public void updateDepreciation(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Depreciation obj = serializer.Deserialize<Depreciation>(json);

            var depreciation = _context.AssetDepreciations.Where(DEP => DEP.AssetDepreciationId == obj.DepreciationID)
                .Select(DEP => DEP).SingleOrDefault();

            if (depreciation != null)
            {
                depreciation.DepreciationAmount = obj.DepreciationAmount;
                depreciation.DepreciationDate = obj.DepreciationDate;
                depreciation.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                depreciation.ModifiedDate = DateTime.Now;
                depreciation.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to fine the related asset depreciation record");
            }
        }

        [WebMethod]
        public void removeDepreciation(long ID)
        {
            var depreciation = _context.AssetDepreciations.Where(DEP => DEP.AssetDepreciationId == ID)
                .Select(DEP => DEP).SingleOrDefault();

            if (depreciation != null)
            {
                _context.AssetDepreciations.DeleteOnSubmit(depreciation);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to fine the related asset depreciation record");
            }
        }

        [WebMethod]
        public string loadAssetDepreciation(string TAG)
        {
            StringWriter str = new StringWriter();

            var asset = _context.Assets
           .Where(ASST => ASST.Tag == TAG).Select(ASST => ASST).SingleOrDefault();

            decimal accomulative = 0;
            decimal currentprice = 0;

            List<Depreciation> deplist = new List<Depreciation>();

            if (asset != null)
            {
                currentprice = asset.PurchasePrice;

                foreach (var obj in asset.AssetDepreciations.OrderBy(DEP => DEP.DepreciationDate))
                {
                    currentprice -= obj.DepreciationAmount;
                    accomulative += obj.DepreciationAmount;

                    Depreciation dep = new Depreciation();
                    dep.DepreciationID = obj.AssetDepreciationId;
                    dep.DepreciationDate = ConvertToLocalTime(obj.DepreciationDate);
                    dep.DepreciationAmount = obj.DepreciationAmount;
                    dep.CurrentAssetValue = currentprice;
                    dep.AccumulativeDepreciation = accomulative;
                    dep.Currency = asset.Currency.CurrencyCode;


                    deplist.Add(dep);

                }

                var xml = new XmlSerializer(typeof(List<Depreciation>));
                xml.Serialize(str, deplist);


            }
            else
            {
                throw new Exception("Cannot find the related asset record");
            }
            return str.ToString();
        }

        [WebMethod]
        public string getAsset(string TAG)
        {
             var asset = _context.Assets
            .Where(ASST => ASST.Tag == TAG)
            .Select(ASST => new Asset
            {
                  AssetID = ASST.AssetId,
                  TAG = ASST.Tag,
                  OtherTAG = ASST.OtherTag == null ? string.Empty : ASST.OtherTag,
                  BARCode = ASST.BarCode == null ? string.Empty : ASST.BarCode,
                  SerialNo = ASST.SerialNumber == null ? string.Empty : ASST.SerialNumber,
                  AccountingCode = ASST.AccountingCode == null ? string.Empty : ASST.AccountingCode,
                  AssetCategory = ASST.AssetCategory.CategoryName,
                  CostCentre = ASST.CostCentre.CostCentreName,
                  OtherCostCentre = ASST.OtherCostCentreId.HasValue == false ? string.Empty : ASST.CostCentre1.CostCentreName,
                  WorkRequestNO = ASST.WorkRequestNumber == null ? string.Empty : ASST.WorkRequestNumber,
                  BillingCategory = ASST.BillingCategory.PaymentMethod,
                  AcquisitionDate = ConvertToLocalTime(ASST.AcquistionDate),
                  Installationdate = ConvertToLocalTime(ASST.InstallationDate),
                  PurchaseDate = ConvertToLocalTime(ASST.PurchaseDate),
                  PurchasePrice = ASST.PurchasePrice,
                  Currency = ASST.Currency.CurrencyCode,
                  CurrentValue = ASST.CurrentAssetValue,
                  Supplier = ASST.Customer.CustomerName,
                  ExternalOwner = ASST.AnotherExternalOwnerID.HasValue == false ? string.Empty : ASST.Customer1.CustomerName,
                  AcquisitionMethod = ASST.AssetAcquisitionMethodId.HasValue == false ? string.Empty : ASST.AssetAcquisitionMethod.AcquisitionMethod,
                  AnotherOwner = ASST.AnotherOwnerId.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                         from g in empgroup
                                                                                         where g.EmployeeID == ASST.AnotherOwnerId
                                                                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == ASST.OwnerId
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  DepreciableLife = ASST.DepreciableLife,
                  DepreciablePeriod = ASST.Period3.Period1,
                  Department = ASST.OrganizationUnit.UnitName,
                  Description = ASST.Description == null ? string.Empty : ASST.Description,
                  Remarks = ASST.Remarks == null ? string.Empty : ASST.Remarks,
                  DisposalDate = ASST.DisposeDate != null ? ConvertToLocalTime(ASST.DisposeDate.Value) : ASST.DisposeDate,
                  DepreciationMethod = ASST.DepreciationMethodId.HasValue == false ? string.Empty : ASST.AssetDepreciationMethod.DepreciationMethod,
                  IsBillable = ASST.Billable,
                  Model = ASST.Model==null?string.Empty:ASST.Model,
                  Retirement = ASST.Retirement == null ? string.Empty : ASST.Retirement,
                  RetirementRemarks = ASST.RetirementRemarks == null ? string.Empty : ASST.RetirementRemarks,
                  Manufacturer = ASST.Manufacturer == null ? string.Empty : ASST.Manufacturer,
                  CalibrationFrequency = ASST.CalibrationFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.CalibrationFrequancy),
                  CalibrationPeriod = ASST.CalibrationPeriodID.HasValue == false ? string.Empty : ASST.Period.Period1,
                  CalibrationDocument = ASST.CalibrationDocumentId.HasValue == false ? string.Empty : ASST.Document1.Title,
                  CalibrationStatus = ASST.CalibrationStatusId.HasValue == false ? string.Empty : ASST.AssetCalibrationStatus.CalibrationStatus,
                  MaintenanceFrequency = ASST.MaintenanceFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.MaintenanceFrequancy),
                  MaintenancePeriod = ASST.MaintenancePeriodID.HasValue == false ? string.Empty : ASST.Period2.Period1,
                  MaintenanceDocument = ASST.MaintenanceDocumentId.HasValue == false ? string.Empty : ASST.Document2.Title,
                  MaintenanceStatus = ASST.MaintenanceStatusId.HasValue == false ? string.Empty : ASST.AssetMaintenanceStatus.MaintenanceStatus,
                  ExternalPurchaseOrder = ASST.ExternalPurchaseOrder == null ? string.Empty : ASST.ExternalPurchaseOrder,
                  ElectricalTestFrequency = ASST.ElectricalTestFrequancy.HasValue == false ? 0 : Convert.ToInt32(ASST.ElectricalTestFrequancy),
                  ElectricalTestDocument = ASST.ElectricalTestDocumentId.HasValue == false ? string.Empty : ASST.Document.Title,
                  ElectricalTestPeriod = ASST.ElectricalTestPeriodID.HasValue == false ? string.Empty : ASST.Period1.Period1,
                  ElectricalTestStatus = ASST.ElectricalTestStatusId.HasValue == false ? string.Empty : ASST.AssetElectricalTestStatus.ElectricalTestStatus,
                  HasCalibration = ASST.HasCalibration,
                  HasElectricalTest = ASST.HasElectricalTest,
                  HasMaintenance = ASST.HasMaintenance,
                  FloorNo = ASST.FloorNo,
                  RoomNo = ASST.RoomNo,
                  AssetStatus = ASST.AssetStatus.AssetStatus1,
                  Mode=(RecordMode)ASST.RecordModeID,
                  CalibrationList = ASST.AssetCalibrations.Select(CAL => new AssetExtensions
                  {
                      ExtensionID = CAL.AssetCalibrationId,
                      ExtensionCost = CAL.CalibrationCost,
                      ExtensionDate = ConvertToLocalTime(CAL.CalibrationDate),
                      ExtensionDueDate = CAL.CalibrationDate != null ? ConvertToLocalTime(CAL.CalibrationDueDate.Value) : CAL.CalibrationDueDate,
                      ExtensionProvider =CAL.Customer.CustomerName,
                      ActionNeededOrComment = CAL.ActionNeededOrComment == null ? string.Empty : CAL.ActionNeededOrComment,
                      Currency = CAL.Currency.CurrencyCode,
                      PurchaseOrderNumber = CAL.PurchaseOrderNumber,
                      Result = (Result)CAL.ResultID,
                      Trend = CAL.Trend,
                      Module = Modules.AssetCalibration
                  }).ToList(),

                  MaintenanceList = ASST.AssetMaintenances.Select(MAINT => new AssetExtensions
                  {
                      ExtensionID = MAINT.AssetMaintenanceId,
                      ExtensionCost = MAINT.MaintenanceCost,
                      ExtensionDate = ConvertToLocalTime(MAINT.MaintenanceDate),
                      ExtensionDueDate = MAINT.MaintenanceDueDate != null ? ConvertToLocalTime(MAINT.MaintenanceDueDate.Value) : MAINT.MaintenanceDueDate,
                      ExtensionProvider = MAINT.Customer.CustomerName,
                      ActionNeededOrComment = MAINT.ActionNeededOrComment == null ? string.Empty : MAINT.ActionNeededOrComment,
                      Currency = MAINT.Currency.CurrencyCode,
                      PurchaseOrderNumber = MAINT.PurchaseOrderNumber,
                      Result = (Result)MAINT.ResultID,
                      Trend = MAINT.Trend,
                      Module = Modules.AssetMaintenance
                  }).ToList(),
                  ElectricalTestList=ASST.AssetElectricalTests.Select(ELECTR=>new AssetExtensions
                  {
                      ExtensionID = ELECTR.AssetElectricalTestId,
                      ExtensionCost = ELECTR.ElectricalTestCost,
                      ExtensionDate = ConvertToLocalTime(ELECTR.ElectricalTestDate),
                      ExtensionDueDate = ELECTR.ElectricalTestDueDate != null ? ConvertToLocalTime(ELECTR.ElectricalTestDueDate.Value) : ELECTR.ElectricalTestDueDate,
                      ExtensionProvider = ELECTR.Customer.CustomerName,
                      ActionNeededOrComment = ELECTR.ActionNeededOrComment == null ? string.Empty : ELECTR.ActionNeededOrComment,
                      Currency = ELECTR.Currency.CurrencyCode,
                      PurchaseOrderNumber = ELECTR.PurchaseOrderNumber,
                      Result = (Result)ELECTR.ResultID,
                      Trend = ELECTR.Trend,
                      Module = Modules.AssetElectricalTest
                  }).ToList()
              }).SingleOrDefault();

            if (asset == null)
            {
                throw new Exception("Cannot find the related asset record");
            }

            var xml = new XmlSerializer(typeof(Asset));

            StringWriter str = new StringWriter();
            xml.Serialize(str, asset);

            return str.ToString();
        }

        

        [WebMethod]
        public string updateAssetCalibrationRecord(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Asset obj = serializer.Deserialize<Asset>(json);

            var asset = _context.Assets.Where(ASST => ASST.Tag == obj.TAG).Select(ASST => ASST).SingleOrDefault();

            if (asset != null)
            {
                asset.CalibrationFrequancy = obj.CalibrationFrequency == 0 ? (int?)null : obj.CalibrationFrequency;
                asset.CalibrationPeriodID = obj.CalibrationPeriod == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.CalibrationPeriod).PeriodID;
                asset.CalibrationDocumentId = obj.CalibrationDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.CalibrationDocument).DocumentId;
                asset.CalibrationStatusId = obj.CalibrationStatus == string.Empty ? (long?)null : _context.AssetCalibrationStatus.Single(STS => STS.CalibrationStatus == obj.CalibrationStatus).AssetCalibrationStatusId;

                asset.ModifiedDate = DateTime.Now;
                asset.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Cannot find the related asset record");
            }
     
            return result;
        }

        [WebMethod]
        public string updateAssetElectricalTestRecord(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Asset obj = serializer.Deserialize<Asset>(json);

            var asset = _context.Assets.Where(ASST => ASST.Tag == obj.TAG).Select(ASST => ASST).SingleOrDefault();

            if (asset != null)
            {
                asset.ElectricalTestFrequancy = obj.ElectricalTestFrequency== 0 ? (int?)null : obj.ElectricalTestFrequency;
                asset.ElectricalTestPeriodID = obj.ElectricalTestPeriod == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.ElectricalTestPeriod).PeriodID;
                asset.ElectricalTestDocumentId = obj.ElectricalTestDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.ElectricalTestDocument).DocumentId;
                asset.ElectricalTestStatusId = obj.ElectricalTestStatus == string.Empty ? (long?)null : _context.AssetElectricalTestStatus.Single(STS => STS.ElectricalTestStatus == obj.ElectricalTestStatus).AssetElectricalTestStatusId;

                asset.ModifiedDate = DateTime.Now;
                asset.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Cannot find the related asset record");
            }

            return result;
        }
        [WebMethod]
        public string updateAssetMaintenanceRecord(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Asset obj = serializer.Deserialize<Asset>(json);

            var asset = _context.Assets.Where(ASST => ASST.Tag == obj.TAG).Select(ASST => ASST).SingleOrDefault();

            if (asset != null)
            {
                asset.MaintenanceFrequancy = obj.MaintenanceFrequency == 0 ? (int?)null : obj.MaintenanceFrequency;
                asset.MaintenancePeriodID = obj.MaintenancePeriod == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.MaintenancePeriod).PeriodID;
                asset.MaintenanceDocumentId = obj.MaintenanceDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.MaintenanceDocument).DocumentId;
                asset.MaintenanceStatusId = obj.MaintenanceStatus == string.Empty ? (long?)null : _context.AssetMaintenanceStatus.Single(STS => STS.MaintenanceStatus == obj.MaintenanceStatus).AssetMaintenanceStatusId;

                asset.ModifiedDate = DateTime.Now;
                asset.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Cannot find the related asset record");
            }

            return result;
        }
        [WebMethod]
        public void removeAsset(long assetID)
        {
            var asset = _context.Assets.Where(ASST => ASST.AssetId == assetID).Select(ASST => ASST).SingleOrDefault();
            
            if (asset != null)
            {
                if (asset.AssetDepreciations.Count > 0)
                {
                    throw new Exception("The asset has (" + asset.AssetDepreciations.Count + ") depreciation records which must be removed first!");
                }
                else
                {
                    _context.Assets.DeleteOnSubmit(asset);
                    _context.SubmitChanges();
                }
            }
            else
            {
                throw new Exception("Cannot find the related asset record");
            }
        }

        [WebMethod]
        public string updateAsset(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Asset obj = serializer.Deserialize<Asset>(json);

            var asset = _context.Assets.Where(ASST => ASST.AssetId == obj.AssetID).Select(ASST => ASST).SingleOrDefault();

            if (asset != null)
            {
                asset.AssetCategoryId = _context.AssetCategories.Single(ASST => ASST.CategoryName == obj.AssetCategory).AssetCategoryId;
                asset.Tag = obj.TAG;
                asset.OtherTag = obj.OtherTAG == string.Empty ? null : obj.OtherTAG;
                asset.SerialNumber = obj.SerialNo == string.Empty ? null : obj.SerialNo;
                asset.BarCode = obj.BARCode == string.Empty ? null : obj.BARCode;
                asset.Model = obj.Model == string.Empty ? null : obj.Model;
                asset.Manufacturer = obj.Manufacturer == string.Empty ? null : obj.Manufacturer;
                asset.Description = obj.Description == string.Empty ? null : obj.Description;
                asset.AssetStatusId = _context.AssetStatus.Single(ASST => ASST.AssetStatus1 == obj.AssetStatus).AssetStatusID;
                asset.SupplierId = _context.Customers.Single(SUPP => SUPP.CustomerName == obj.Supplier).CustomerID;
                asset.WorkRequestNumber = obj.WorkRequestNO == string.Empty ? null : obj.WorkRequestNO;
                asset.AccountingCode = obj.AccountingCode == string.Empty ? null : obj.AccountingCode;
                asset.PurchaseDate = obj.PurchaseDate;
                asset.PurchasePrice = obj.PurchasePrice;
                asset.CurrentAssetValue = obj.CurrentValue;
                asset.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                asset.ExternalPurchaseOrder = obj.ExternalPurchaseOrder == string.Empty ? null : obj.ExternalPurchaseOrder;
                asset.Billable = obj.IsBillable;
                asset.CostCentreId = _context.CostCentres.Single(CNTR => CNTR.CostCentreName == obj.CostCentre).CostCentreID;
                asset.OtherCostCentreId = obj.OtherCostCentre == string.Empty ? (int?)null : _context.CostCentres.Single(CNTR => CNTR.CostCentreName == obj.OtherCostCentre).CostCentreID;
                asset.BillingCategoryId = _context.BillingCategories.Single(CAT => CAT.PaymentMethod == obj.BillingCategory).BillingCategoryId;
                asset.AssetAcquisitionMethodId = _context.AssetAcquisitionMethods.Single(ACQ => ACQ.AcquisitionMethod == obj.AcquisitionMethod).AssetAcquisitionMethodId;
                asset.AcquistionDate = obj.AcquisitionDate;
                asset.InstallationDate = obj.Installationdate;
                asset.DisposeDate = obj.DisposalDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.DisposalDate);

                asset.DepreciationMethodId = _context.AssetDepreciationMethods.Single(DEPR => DEPR.DepreciationMethod == obj.DepreciationMethod).AssetDepreciationMethodId;
                asset.DepreciableLife = obj.DepreciableLife;
                asset.PeriodID = _context.Periods.Single(PRD => PRD.Period1 == obj.DepreciablePeriod).PeriodID;
                asset.DepartmentID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == obj.Department).UnitID;
                asset.OwnerId = (from EMP in _context.Employees
                                 where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                 EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                 select EMP.EmployeeID).SingleOrDefault();
                asset.AnotherOwnerId = obj.AnotherOwner == string.Empty ? (int?)null : (from EMP in _context.Employees
                                                                                        where EMP.FirstName == obj.AnotherOwner.Substring(obj.AnotherOwner.LastIndexOf(".") + 1, obj.AnotherOwner.IndexOf(" ") - 3) &&
                                                                                        EMP.LastName == obj.AnotherOwner.Substring(obj.AnotherOwner.IndexOf(" ") + 1)
                                                                                        select EMP.EmployeeID).SingleOrDefault();
                asset.AnotherExternalOwnerID = obj.ExternalOwner == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExternalOwner).CustomerID;
                asset.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
                asset.Retirement = obj.Retirement == string.Empty ? null : obj.Retirement;
                asset.RetirementRemarks = obj.RetirementRemarks == string.Empty ? null : obj.RetirementRemarks;
                asset.FloorNo = obj.FloorNo == string.Empty ? null : obj.FloorNo;
                asset.RoomNo = obj.RoomNo == string.Empty ? null : obj.RoomNo;
                asset.ModifiedDate = DateTime.Now;
                asset.ModifiedBy = HttpContext.Current.User.Identity.Name;


                _context.SubmitChanges();


                // generate automatic email notification for adding new document list
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.AssetManagement;

                automail.KeyValue = asset.AssetId;

                automail.Action = "Update";

                //add asset owners as recipients
                automail.Recipients.Add(asset.OwnerId);

                if (asset.AnotherOwnerId.HasValue == true)
                {
                    automail.Recipients.Add(Convert.ToInt32(asset.AnotherOwnerId));
                }

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Cannot find the related asset record");
            }
            return result;
        }
        [WebMethod]
        public string archiveAsset(long assetID)
        {
            string result = String.Empty;

            var asset = _context.Assets.Where(ASST => ASST.AssetId == assetID).Select(ASST => ASST).SingleOrDefault();

            if (asset != null)
            {
                asset.RecordModeID = (int)RecordMode.Archived;
                asset.ModifiedDate = DateTime.Now;
                asset.ModifiedBy = HttpContext.Current.User.Identity.Name;
                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Cannot find the related asset record");
            }

            return result;
        }
        [WebMethod]
        public string createAsset(string json)
        {
           string result = string.Empty;

           JavaScriptSerializer serializer = new JavaScriptSerializer();
           Asset obj = serializer.Deserialize<Asset>(json);

           var asset = _context.Assets.Where(ASST => ASST.Tag == obj.TAG).Select(ASST => ASST).SingleOrDefault();

           if (asset == null)
           {
               asset = new LINQConnection.Asset();
               asset.AssetCategoryId = _context.AssetCategories.Single(ASST => ASST.CategoryName == obj.AssetCategory).AssetCategoryId;
               asset.Tag = obj.TAG;
               asset.OtherTag = obj.OtherTAG == string.Empty ? null : obj.OtherTAG;
               asset.SerialNumber = obj.SerialNo == string.Empty ? null : obj.SerialNo;
               asset.BarCode = obj.BARCode == string.Empty ? null : obj.BARCode;
               asset.Model = obj.Model == string.Empty ? null : obj.Model;
               asset.Manufacturer = obj.Manufacturer == string.Empty ? null : obj.Manufacturer;
               asset.Description = obj.Description == string.Empty ? null : obj.Description;
               asset.AssetStatusId = _context.AssetStatus.Single(ASST => ASST.AssetStatus1 == obj.AssetStatus).AssetStatusID;
               asset.SupplierId = _context.Customers.Single(SUPP => SUPP.CustomerName == obj.Supplier).CustomerID;
               asset.WorkRequestNumber = obj.WorkRequestNO == string.Empty ? null : obj.WorkRequestNO;
               asset.AccountingCode = obj.AccountingCode == string.Empty ? null : obj.AccountingCode;
               asset.PurchaseDate = obj.PurchaseDate;
               asset.PurchasePrice = obj.PurchasePrice;
               asset.CurrentAssetValue = obj.CurrentValue;
               asset.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
               asset.ExternalPurchaseOrder = obj.ExternalPurchaseOrder == string.Empty ? null : obj.ExternalPurchaseOrder;
               asset.Billable = obj.IsBillable;
               asset.CostCentreId = _context.CostCentres.Single(CNTR => CNTR.CostCentreName == obj.CostCentre).CostCentreID;
               asset.OtherCostCentreId = obj.OtherCostCentre == string.Empty ? (int?)null : _context.CostCentres.Single(CNTR => CNTR.CostCentreName == obj.OtherCostCentre).CostCentreID;
               asset.BillingCategoryId = _context.BillingCategories.Single(CAT => CAT.PaymentMethod == obj.BillingCategory).BillingCategoryId;
               asset.AssetAcquisitionMethodId = _context.AssetAcquisitionMethods.Single(ACQ => ACQ.AcquisitionMethod == obj.AcquisitionMethod).AssetAcquisitionMethodId;
               asset.AcquistionDate = obj.AcquisitionDate;
               asset.InstallationDate = obj.Installationdate;
               asset.DepreciationMethodId = _context.AssetDepreciationMethods.Single(DEPR => DEPR.DepreciationMethod == obj.DepreciationMethod).AssetDepreciationMethodId;
               asset.DepreciableLife = obj.DepreciableLife;
               asset.PeriodID = _context.Periods.Single(PRD => PRD.Period1 == obj.DepreciablePeriod).PeriodID;
               asset.DepartmentID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == obj.Department).UnitID;
               asset.OwnerId = (from EMP in _context.Employees
                                where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                select EMP.EmployeeID).SingleOrDefault();
               asset.AnotherOwnerId = obj.AnotherOwner == string.Empty ? (int?)null : (from EMP in _context.Employees
                                                                                       where EMP.FirstName == obj.AnotherOwner.Substring(obj.AnotherOwner.LastIndexOf(".") + 1, obj.AnotherOwner.IndexOf(" ") - 3) &&
                                                                                       EMP.LastName == obj.AnotherOwner.Substring(obj.AnotherOwner.IndexOf(" ") + 1)
                                                                                       select EMP.EmployeeID).SingleOrDefault();
               asset.AnotherExternalOwnerID = obj.ExternalOwner == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExternalOwner).CustomerID;
               asset.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
               asset.CalibrationFrequancy = obj.CalibrationFrequency == 0 ? (int?)null : obj.CalibrationFrequency;
               asset.CalibrationPeriodID = obj.CalibrationPeriod == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.CalibrationPeriod).PeriodID;
               asset.MaintenanceFrequancy = obj.MaintenanceFrequency == 0 ? (int?)null : obj.MaintenanceFrequency;
               asset.MaintenancePeriodID = obj.MaintenancePeriod == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.MaintenancePeriod).PeriodID;
               asset.ElectricalTestFrequancy = obj.ElectricalTestFrequency == 0 ? (int?)null : obj.ElectricalTestFrequency;
               asset.ElectricalTestPeriodID = obj.ElectricalTestPeriod == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.ElectricalTestPeriod).PeriodID;
               asset.HasCalibration = obj.HasCalibration;
               asset.HasElectricalTest = obj.HasElectricalTest;
               asset.HasMaintenance = obj.HasMaintenance;
               asset.CalibrationDocumentId = obj.CalibrationDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.CalibrationDocument).DocumentId;
               asset.MaintenanceDocumentId = obj.MaintenanceDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.MaintenanceDocument).DocumentId;
               asset.ElectricalTestDocumentId = obj.ElectricalTestDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.ElectricalTestDocument).DocumentId;
               asset.FloorNo = obj.FloorNo==string.Empty?null:obj.FloorNo;
               asset.RoomNo = obj.RoomNo == string.Empty ? null : obj.RoomNo;
               asset.RecordModeID = (int)obj.Mode;
               asset.ModifiedDate = DateTime.Now;
               asset.ModifiedBy = HttpContext.Current.User.Identity.Name;


               _context.Assets.InsertOnSubmit(asset);
               _context.SubmitChanges();


               // generate automatic email notification for adding new document list
               EmailConfiguration automail = new EmailConfiguration();
               automail.Module = Modules.AssetManagement;

               automail.KeyValue = asset.AssetId;

               automail.Action = "Add";

               //add asset owners as recipients
               automail.Recipients.Add(asset.OwnerId);

               if (asset.AnotherOwnerId.HasValue == true)
               {
                   automail.Recipients.Add(Convert.ToInt32(asset.AnotherOwnerId));
               }

               try
               {
                   bool isGenerated = automail.GenerateEmail();

                   if (isGenerated == true)
                   {
                       result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                   }
                   else
                   {
                       result = "Operation has been committed sucessfully";
                   }
               }
               catch (Exception ex)
               {
                   result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                   result += "\n\n" + ex.Message;
               }
           }
           else
           {
               throw new Exception("The TAG of the asset should be unique");
           }
           return result;

        }

        [WebMethod]
        public string loadBillingCategories()
        {
            var categories = _context.BillingCategories
                .OrderBy(CAT => CAT.PaymentMethod)
                .Select(CAT => new Category
                {
                    CategoryID = CAT.BillingCategoryId,
                    CategoryName = CAT.PaymentMethod,
                    Description = CAT.Description == null ? string.Empty : CAT.Description,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Category>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, categories);

            return str.ToString();
        }
        [WebMethod]
        public string loadAssetCategories()
        {
            var categories = _context.AssetCategories
                .OrderBy(CAT=>CAT.CategoryName)
                .Select(CAT => new Category
                {
                    CategoryID = CAT.AssetCategoryId,
                    CategoryName = CAT.CategoryName,
                    Description = CAT.Description == null ? string.Empty : CAT.Description,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Category>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, categories);

            return str.ToString();
        }

        [WebMethod]
        public string loadAcquisitionMethods()
        {
            var methods = _context.AssetAcquisitionMethods
                .Select(ACQ => new Method
                {
                    MethodID = ACQ.AssetAcquisitionMethodId,
                    MethodName = ACQ.AcquisitionMethod,
                    Description = ACQ.Description == null ? string.Empty : ACQ.Description,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Method>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, methods);

            return str.ToString();
        }
        [WebMethod]
        public string loadMaintenanceStatus()
        {
            var statuslist = _context.AssetMaintenanceStatus
                .Select(STS => new Status
                {
                    StatusID = STS.AssetMaintenanceStatusId,
                    StatusName = STS.MaintenanceStatus,
                    Description = STS.Description == null ? string.Empty : STS.Description
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Status>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, statuslist);

            return str.ToString();
        }
        [WebMethod]
        public string loadElectricalTestStatus()
        {
            var statuslist = _context.AssetElectricalTestStatus
            .Select(STS => new Status
            {
                StatusID = STS.AssetElectricalTestStatusId,
                StatusName = STS.ElectricalTestStatus,
                Description = STS.Description == null ? string.Empty : STS.Description
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Status>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, statuslist);

            return str.ToString();
        }
        [WebMethod]
        public string loadCalibrationStatus()
        {
            var statuslist = _context.AssetCalibrationStatus
                .Select(STS => new Status
                {
                    StatusID = STS.AssetCalibrationStatusId,
                    StatusName = STS.CalibrationStatus,
                    Description = STS.Description == null ? string.Empty : STS.Description
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Status>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, statuslist);

            return str.ToString();
        }

        [WebMethod]
        public string loadAssetListStatus()
        {
            var statuslist = _context.AssetStatus
                .Select(STS => new Status
                {
                    StatusID = STS.AssetStatusID,
                    StatusName = STS.AssetStatus1,
                    Description = STS.Description == null ? string.Empty : STS.Description
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Status>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, statuslist);

            return str.ToString();
        }

        [WebMethod]
        public string loadDepreciationMethods()
        {
            var methods = _context.AssetDepreciationMethods
                .Select(DPR => new Method
                {
                    MethodID = DPR.AssetDepreciationMethodId,
                    MethodName = DPR.DepreciationMethod,
                    Description = DPR.Description == null ? string.Empty : DPR.Description,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Method>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, methods);

            return str.ToString();
        }
        [WebMethod]
        public void createAssetCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.AssetCategories.Where(CAT => CAT.CategoryName == obj.CategoryName).Select(CAT => CAT).SingleOrDefault();
            if (category == null)
            {
                category = new LINQConnection.AssetCategory();
                category.CategoryName = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AssetCategories.InsertOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the asset category already exists");
            }
        }

        [WebMethod]
        public void createBillingCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.BillingCategories.Where(CAT => CAT.PaymentMethod == obj.CategoryName).Select(CAT => CAT).SingleOrDefault();
            if (category == null)
            {
                category = new LINQConnection.BillingCategory();
                category.PaymentMethod = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.BillingCategories.InsertOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the billing category already exists");
            }
        }

        [WebMethod]
        public void createAcquisitionMethod(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Method obj = serializer.Deserialize<Method>(json);

            var method = _context.AssetAcquisitionMethods.Where(ACQ => ACQ.AcquisitionMethod == obj.MethodName).Select(ACQ => ACQ).SingleOrDefault();
            if (method == null)
            {
                method = new AssetAcquisitionMethod();
                method.AcquisitionMethod = obj.MethodName;
                method.Description = obj.Description == string.Empty ? null : obj.Description;
                method.ModifiedDate = DateTime.Now;
                method.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AssetAcquisitionMethods.InsertOnSubmit(method);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the acquisition method already exists");
            }
        }

        [WebMethod]
        public void createMaintenanceStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);

            var status = _context.AssetMaintenanceStatus.Where(STS => STS.MaintenanceStatus == obj.StatusName).Select(STS => STS).SingleOrDefault();
            if (status == null)
            {
                status = new AssetMaintenanceStatus();
                status.MaintenanceStatus = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AssetMaintenanceStatus.InsertOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the asset maintenance status already exists");
            }
        }
        [WebMethod]
        public void createCalibrationStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);

            var status = _context.AssetCalibrationStatus.Where(STS => STS.CalibrationStatus == obj.StatusName).Select(STS => STS).SingleOrDefault();
            if (status == null)
            {
                status = new AssetCalibrationStatus();
                status.CalibrationStatus = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AssetCalibrationStatus.InsertOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the asset calibration status already exists");
            }
        }

        [WebMethod]
        public void createAssetStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);

            var status = _context.AssetStatus.Where(STS => STS.AssetStatus1 == obj.StatusName).Select(STS => STS).SingleOrDefault();
            if (status == null)
            {
                status = new AssetStatus();
                status.AssetStatus1 = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AssetStatus.InsertOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the asset status already exists");
            }
        }
        [WebMethod]
        public void createElectricalTestStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);

            var status = _context.AssetElectricalTestStatus.Where(STS => STS.ElectricalTestStatus == obj.StatusName).Select(STS => STS).SingleOrDefault();
            if (status == null)
            {
                status = new AssetElectricalTestStatus();
                status.ElectricalTestStatus = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AssetElectricalTestStatus.InsertOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the asset electrical test status already exists");
            }
        }

        [WebMethod]
        public void createDepreciationMethod(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Method obj = serializer.Deserialize<Method>(json);

            var method = _context.AssetDepreciationMethods.Where(DPR => DPR.DepreciationMethod == obj.MethodName).Select(DPR => DPR).SingleOrDefault();
            if (method == null)
            {
                method = new AssetDepreciationMethod();
                method.DepreciationMethod = obj.MethodName;
                method.Description = obj.Description == string.Empty ? null : obj.Description;
                method.ModifiedDate = DateTime.Now;
                method.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AssetDepreciationMethods.InsertOnSubmit(method);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the depreciation method already exists");
            }
        }

        [WebMethod]
        public void updateAssetCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.AssetCategories.Where(CAT => CAT.AssetCategoryId == obj.CategoryID).Select(CAT => CAT).SingleOrDefault();
            if (category != null)
            {
                category.CategoryName = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;

              
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related asset category record");
            }
        }

        [WebMethod]
        public void updateBillingCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.BillingCategories.Where(CAT => CAT.BillingCategoryId == obj.CategoryID).Select(CAT => CAT).SingleOrDefault();
            if (category != null)
            {
                category.PaymentMethod = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;


                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related billing category record");
            }
        }

        [WebMethod]
        public void updateMaintenanceStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);

            var status = _context.AssetMaintenanceStatus.Where(STS => STS.AssetMaintenanceStatusId == obj.StatusID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                status.MaintenanceStatus = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related asset maintenance status record");
            }
        }
        [WebMethod]
        public void updateCalibrationStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);
            
            var status = _context.AssetCalibrationStatus.Where(STS => STS.AssetCalibrationStatusId == obj.StatusID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                status.CalibrationStatus = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related asset calibration status record");
            }
        }

        [WebMethod]
        public void updateAssetStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);

            var status = _context.AssetStatus.Where(STS => STS.AssetStatusID == obj.StatusID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                status.AssetStatus1 = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related asset status record");
            }
        }
        [WebMethod]
        public void updateElectricalTestStatus(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Status obj = serializer.Deserialize<Status>(json);

            var status = _context.AssetElectricalTestStatus.Where(STS => STS.AssetElectricalTestStatusId == obj.StatusID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                status.ElectricalTestStatus = obj.StatusName;
                status.Description = obj.Description == string.Empty ? null : obj.Description;
                status.ModifiedDate = DateTime.Now;
                status.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related asset electrical test status record");
            }
        }
        [WebMethod]
        public void updateAcquisitionMethod(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Method obj = serializer.Deserialize<Method>(json);

            var method = _context.AssetAcquisitionMethods.Where(ACQ => ACQ.AssetAcquisitionMethodId == obj.MethodID).Select(ACQ => ACQ).SingleOrDefault();
            if (method != null)
            {
                method.AcquisitionMethod = obj.MethodName;
                method.Description = obj.Description == string.Empty ? null : obj.Description;
                method.ModifiedDate = DateTime.Now;
                method.ModifiedBy = HttpContext.Current.User.Identity.Name;
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related acquisition method record");
            }
        }


        [WebMethod]
        public void updateDepreciationMethod(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Method obj = serializer.Deserialize<Method>(json);

            var method = _context.AssetDepreciationMethods.Where(DPR => DPR.AssetDepreciationMethodId == obj.MethodID).Select(DPR => DPR).SingleOrDefault();
            if (method != null)
            {
                method.DepreciationMethod = obj.MethodName;
                method.Description = obj.Description == string.Empty ? null : obj.Description;
                method.ModifiedDate = DateTime.Now;
                method.ModifiedBy = HttpContext.Current.User.Identity.Name;
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related depreciation method record");
            }
        }
        [WebMethod]
        public void removeAssetCategory(long ID)
        {
            var category = _context.AssetCategories.Where(CAT => CAT.AssetCategoryId == ID).Select(CAT => CAT).SingleOrDefault();
            if (category != null)
            {
                _context.AssetCategories.DeleteOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related asset category record");
            }
        }

        [WebMethod]
        public void removeBillingCategory(long ID)
        {
            var category = _context.BillingCategories.Where(CAT => CAT.BillingCategoryId == ID).Select(CAT => CAT).SingleOrDefault();
            if (category != null)
            {
                _context.BillingCategories.DeleteOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related billing category record");
            }
        }

        [WebMethod]
        public void removeAcquisitionMethod(long ID)
        {
            var method = _context.AssetAcquisitionMethods.Where(ACQ => ACQ.AssetAcquisitionMethodId == ID).Select(ACQ => ACQ).SingleOrDefault();
            if (method != null)
            {
                _context.AssetAcquisitionMethods.DeleteOnSubmit(method);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related acquisition method record");
            }
        }

        [WebMethod]
        public void removeMaintenanceStatus(long ID)
        {
            var status = _context.AssetMaintenanceStatus.Where(STS => STS.AssetMaintenanceStatusId == ID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                _context.AssetMaintenanceStatus.DeleteOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related maintenance status record");
            }
        }

        [WebMethod]
        public void removeCalibrationStatus(long ID)
        {
            var status = _context.AssetCalibrationStatus.Where(STS => STS.AssetCalibrationStatusId == ID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                _context.AssetCalibrationStatus.DeleteOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related calibration status record");
            }
        }

        [WebMethod]
        public void removeAssetStatus(long ID)
        {
            var status = _context.AssetStatus.Where(STS => STS.AssetStatusID == ID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                _context.AssetStatus.DeleteOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related asset status record");
            }
        }

        [WebMethod]
        public void removeElectricalTestStatus(long ID)
        {
            var status = _context.AssetElectricalTestStatus.Where(STS => STS.AssetElectricalTestStatusId == ID).Select(STS => STS).SingleOrDefault();
            if (status != null)
            {
                _context.AssetElectricalTestStatus.DeleteOnSubmit(status);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related electrical test status record");
            }
        }

        [WebMethod]
        public void removeDepreciationMethod(long ID)
        {
            var method = _context.AssetDepreciationMethods.Where(DEPR => DEPR.AssetDepreciationMethodId == ID).Select(DEPR => DEPR).SingleOrDefault();
            if (method != null)
            {
                _context.AssetDepreciationMethods.DeleteOnSubmit(method);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related depreciation method record");
            }
        }
        #endregion
        #region TreeNode

        [WebMethod]
        public string[] loadMainModules()
        {
            var modules = _context.AT_TreeNodes.Where(MODL => MODL.ParentId == null)
                .OrderBy(MODL => MODL.NodeName)
                .Select(MODL => MODL.NodeName).ToArray();

            return modules;

        }

        [WebMethod]
        public void UploadVisioLinks(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<VisioManagement> visio = serializer.Deserialize<List<VisioManagement>>(json);

            AT_TreeNode module = null;

            foreach (VisioManagement obj in visio)
            {
                switch (obj.Status)
                {
                    case RecordsStatus.ADDED:
                        module = new AT_TreeNode();
                        module.NodeName = obj.name;
                        module.NodeNavigateLink = obj.NavigationURL;
                        module.PageExtension = obj.PageExtension;
                        module.SecurityKeyID = _context.AT_TreeNodeSecurityKeys.Single(SECK => SECK.SecurityKey == obj.SecurityKey).SecurityKeyID;
                        module.IsQueryString = obj.IsQueryString;
                        module.IsModule = obj.IsModule;
                        module.ParentId = _context.AT_TreeNodes.Single(MODL => MODL.NodeName == obj.RelatedModule).NodeId;
                        module.ModifiedDate = DateTime.Now;
                        module.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        _context.AT_TreeNodes.InsertOnSubmit(module);
                        break;

                    case RecordsStatus.MODIFIED:
                        module = _context.AT_TreeNodes.Where(MODUL => MODUL.NodeId == obj.NodeID)
                            .Select(MODUL => MODUL).SingleOrDefault();

                        module.NodeName = obj.name;
                        module.NodeNavigateLink = obj.NavigationURL;
                        module.PageExtension = obj.PageExtension;
                        module.SecurityKeyID = _context.AT_TreeNodeSecurityKeys.Single(SECK => SECK.SecurityKey == obj.SecurityKey).SecurityKeyID;
                        module.IsQueryString = obj.IsQueryString;
                        module.IsModule = obj.IsModule;
                        module.ParentId = _context.AT_TreeNodes.Where(P => P.NodeName == obj.RelatedModule).Select(P => P.NodeId).SingleOrDefault();
                        module.ModifiedDate = DateTime.Now;
                        module.ModifiedBy = HttpContext.Current.User.Identity.Name;
                        break;
                }
            }

            _context.SubmitChanges();

        }

        [WebMethod]
        public void removeVisioLink(long nodeID)
        {
            var visio = _context.AT_TreeNodes.Where(VSIO => VSIO.NodeId == nodeID)
                .Select(VSIO => VSIO).SingleOrDefault();

            if (visio != null)
            {
                _context.AT_TreeNodes.DeleteOnSubmit(visio);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the specified visio process record");
            }
        }
        
        [WebMethod]
        public string loadVisoProcesses()
        {
            var processes = _context.AT_TreeNodes.Where(VSIO => VSIO.IsQueryString == true)
                .OrderBy(MODL => MODL.NodeName)
                .Select(MODL => new VisioManagement
                {
                    NodeID = MODL.NodeId,
                    name = MODL.NodeName,
                    SecurityKey = MODL.SecurityKeyID == null ? null : MODL.AT_TreeNodeSecurityKey.SecurityKey,
                    PageExtension=MODL.PageExtension,
                    NavigationURL=MODL.NodeNavigateLink,
                    RelatedModule=MODL.AT_TreeNode1.NodeName,
                    IsQueryString = MODL.IsQueryString,
                    IsModule = MODL.IsModule,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(processes);

            return result;
        }

        [WebMethod]
        public string loadModuleTree(string permissions)
        {
            string[] pstr = permissions.Split(',');
            int[] vals = pstr.Select(v => int.Parse(v)).ToArray();
            var modules = _context.AT_TreeNodes
                .OrderBy(MODL => MODL.NodeName)
                .Where(MODL => MODL.SecurityKeyID == null || vals.Contains(MODL.SecurityKeyID.Value))
                .OrderBy(MODL => MODL.SortingOrder)
                .Select(MODL => new ToolMenuTree
                {
                    NodeID = MODL.NodeId,
                    name = MODL.NodeName,
                    NavigationLink = MODL.NodeNavigateLink,
                    ParentID = Convert.ToInt32(MODL.ParentId == null ? 0 : MODL.ParentId),
                    PageExtension = MODL.PageExtension.Trim(),
                    SecurityKey = MODL.SecurityKeyID == null ? null : MODL.AT_TreeNodeSecurityKey.SecurityKey,
                    IsQueryString=MODL.IsQueryString,
                    IsModule=MODL.IsModule,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();



            foreach (var module in modules)
            {
                List<ToolMenuTree> obj = modules.Where(x => x.ParentID == module.NodeID).ToList<ToolMenuTree>();

                if (obj.Count > 0)
                {
                    module.children = obj;
                }
            }

            for (int i = modules.Count - 1; i >= 0; i--)
            {
                if (modules[i].ParentID != 0)
                {
                    modules.RemoveAt(i);
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(modules);

            return result;
        }
        #endregion
        #region ISOManagement

        [WebMethod]
        public string loadISOStandards()
        {
            var iso = _context.ISOStandards.Select(ISO => new ISOStandard
            {
                ISOStandardID=ISO.ISOStandardID,
                ISOName=ISO.ISOStandard1,
                Description=ISO.Discription==null?string.Empty:ISO.Discription

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<ISOStandard>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, iso);

            return strwriter.ToString();
        }

        [WebMethod]
        public void createNewISO(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ISOStandard obj = serializer.Deserialize<ISOStandard>(json);

            var existing = _context.ISOStandards.Where(ISO => ISO.ISOStandard1 == obj.ISOName)
                .Select(ISO => ISO).SingleOrDefault();
            if (existing == null)
            {
                LINQConnection.ISOStandard std = new LINQConnection.ISOStandard();
                std.ISOStandard1 = obj.ISOName;
                std.Discription = obj.Description == string.Empty ? null : obj.Description;
                std.ModifiedDate = DateTime.Now;
                std.ModifiedBy = HttpContext.Current.User.Identity.Name;
              
                _context.ISOStandards.InsertOnSubmit(std);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the ISO standard already exists");
            }
        }

        [WebMethod]
        public void updateISO(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ISOStandard obj = serializer.Deserialize<ISOStandard>(json);

            var existing = _context.ISOStandards.Where(ISO => ISO.ISOStandardID == obj.ISOStandardID)
            .Select(ISO => ISO).SingleOrDefault();
            
            if (existing != null)
            {
                existing.ISOStandard1 = obj.ISOName;
                existing.Discription = obj.Description == string.Empty ? null : obj.Description;
                existing.ModifiedDate = DateTime.Now;
                existing.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related ISO standard record");
            }
        }

        [WebMethod]
        public void removeISOStandard(int standardID)
        {
            var existing = _context.ISOStandards.Where(ISO => ISO.ISOStandardID == standardID)
            .Select(ISO => ISO).SingleOrDefault();

            if (existing != null)
            {
                _context.ISOStandards.DeleteOnSubmit(existing);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related ISO standard record");
            }
         

        }
        [WebMethod]
        public string getISOChecklist(string isoname)
        {
            var iso = _context.ISOStandards.Single(ISO => ISO.ISOStandard1 == isoname);
            var processes = _context.ISOProcesses
               .Where(PROC => PROC.ISOStandardID == iso.ISOStandardID)
               .Select(PROC => new QMSRSTools.ISOProcess
               {
                   ISOProcessID = PROC.ISOProcessID,
                   ISOStandard = isoname,
                   name = PROC.Process,
                   Description = PROC.Description,
                   ParentID = Convert.ToInt32(PROC.ParentProcessID == null ? 0 : PROC.ParentProcessID),
                   Status = RecordsStatus.ORIGINAL,
                   Tag = PROC.Tag
               }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(processes);

            return result;
        }

        [WebMethod]
        public string loadISOProcesses(string isoname)
        {

            var iso = _context.ISOStandards.Single(ISO => ISO.ISOStandard1 == isoname);

            var processes = _context.ISOProcesses
                .Where(PROC=>PROC.ISOStandardID==iso.ISOStandardID)
                .Select(PROC=>new QMSRSTools.ISOProcess
                {
                    ISOProcessID=PROC.ISOProcessID,
                    ISOStandard=isoname,
                    name=PROC.Process,
                    Description=PROC.Description,
                    ParentID = Convert.ToInt32(PROC.ParentProcessID == null ? 0 : PROC.ParentProcessID),
                    Status=RecordsStatus.ORIGINAL,
                    Tag=PROC.Tag.Trim()
                }).ToList();

            foreach (var process in processes)
            {
                List<ISOProcess> obj = processes.Where(x=>x.ParentID == process.ISOProcessID).ToList<ISOProcess>();

                if (obj.Count > 0)
                {
                    process.children = obj;
                }
            }

            for (int i = processes.Count - 1; i >= 0; i--)
            {
                if (processes[i].ParentID!=0)
                {
                    processes.RemoveAt(i);
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(processes);

            return result;
        }

        [WebMethod]
        public void removeISOProcess(int processID)
        {

            var process = _context.ISOProcesses.Where(PROC => PROC.ISOProcessID == processID)
                .Select(PROC => PROC).SingleOrDefault();

            if (process != null)
            {
                _context.ISOProcesses.DeleteOnSubmit(process);
                _context.SubmitChanges();
            }
        }

        [WebMethod]
        public string UploadISOProcess(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<ISOProcess> processes = serializer.Deserialize<List<ISOProcess>>(json);

            LINQConnection.ISOProcess process = null;

            string result = string.Empty;

            try
            {
                foreach (ISOProcess procobj in processes)
                {
                    switch (procobj.Status)
                    {
                        case RecordsStatus.ADDED:

                            process = new LINQConnection.ISOProcess();
                            process.Process = procobj.name;
                            process.Description = procobj.Description == string.Empty ? null : procobj.Description;
                            //process.Tag = procobj.Tag == string.Empty ? null : procobj.Tag.Trim();
                            process.Tag = String.IsNullOrEmpty(procobj.Tag) ? null : procobj.Tag.Trim();
                            process.ISOStandardID = _context.ISOStandards.Single(ISO => ISO.ISOStandard1 == procobj.ISOStandard).ISOStandardID;
                            process.ModifiedDate = DateTime.Now;
                            process.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedProcesses(procobj, process);
                            _context.ISOProcesses.InsertOnSubmit(process);

                            break;
                        case RecordsStatus.MODIFIED:
                            process = _context.ISOProcesses.Where(PROC => PROC.ISOProcessID == procobj.ISOProcessID).SingleOrDefault();
                            process.Process = procobj.name;
                            process.Description = procobj.Description == string.Empty ? null : procobj.Description;
                            //process.Tag = procobj.Tag == string.Empty ? null : procobj.Tag.Trim();
                            process.Tag = String.IsNullOrEmpty(procobj.Tag) ? null : procobj.Tag.Trim();
                            process.ModifiedDate = DateTime.Now;
                            process.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedProcesses(procobj, process);
                            break;

                        case RecordsStatus.ORIGINAL:
                            process = _context.ISOProcesses.Where(PROC => PROC.ISOProcessID == procobj.ISOProcessID).SingleOrDefault();
                            searchModifiedProcesses(procobj, process);

                            break;
                    }
                }

                _context.SubmitChanges();

                result = "Changes have been updated sucessfully";

            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return result;
        }
        public void searchModifiedProcesses(ISOProcess procobj, LINQConnection.ISOProcess process)
        {
            LINQConnection.ISOProcess childobj = null;

            if (procobj.children != null)
            {
                foreach (ISOProcess p in procobj.children)
                {
                    switch (p.Status)
                    {
                        case RecordsStatus.ADDED:
                            childobj = new LINQConnection.ISOProcess();
                            childobj.Process = p.name;
                            childobj.Description = p.Description == string.Empty ? null : p.Description;
                            //childobj.Tag = p.Tag == string.Empty ? null : p.Tag.Trim();
                            childobj.Tag = String.IsNullOrEmpty(p.Tag) ? null : p.Tag.Trim();
                            childobj.ISOStandardID = _context.ISOStandards.Single(ISO => ISO.ISOStandard1 == p.ISOStandard).ISOStandardID;
                            childobj.ModifiedDate = DateTime.Now;
                            childobj.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            process.ISOProcesses.Add(childobj);
                            searchModifiedProcesses(p, childobj);

                            break;
                        case RecordsStatus.MODIFIED:
                            childobj = _context.ISOProcesses.Where(PROC => PROC.ISOProcessID == p.ISOProcessID).SingleOrDefault();
                            childobj.Process = p.name;
                            childobj.Description = p.Description == string.Empty ? null : p.Description;
                            //childobj.Tag = p.Tag == string.Empty ? null : p.Tag.Trim();
                            childobj.Tag = String.IsNullOrEmpty(p.Tag) ? null : p.Tag.Trim();
                            childobj.ISOStandardID = _context.ISOStandards.Single(ISO => ISO.ISOStandard1 == p.ISOStandard).ISOStandardID;
                            childobj.ModifiedDate = DateTime.Now;
                            childobj.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedProcesses(p, childobj);

                            break;
                        case RecordsStatus.ORIGINAL:
                            childobj = _context.ISOProcesses.Where(PROC => PROC.ISOProcessID == p.ISOProcessID).SingleOrDefault();
                            searchModifiedProcesses(p, childobj);
                            break;
                    }
                }
            }
        }
        #endregion
        #region Authorization

        [WebMethod]
        public void deactivateEmployeeSession(int employeeID)
        {
            var user = _context.SystemUsers.Where(USR => USR.EmployeeID == employeeID).Select(USR => USR).SingleOrDefault();
            if (user != null)
            {
                user.CurrentSessionID = null;
                user.ModifiedDate = DateTime.Now;
                user.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related user record");
            }
        }
        [WebMethod]
        public void activateEmployeeSession(int employeeID)
        {
            var user = _context.SystemUsers.Where(USR => USR.EmployeeID == employeeID).Select(USR => USR).SingleOrDefault();
            if (user != null)
            {
                user.CurrentSessionID = HttpContext.Current.Session.SessionID;
                user.ModifiedDate = DateTime.Now;
                user.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related user record");
            }
        }

        [WebMethod]
        public void updateUser(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Users obj = serializer.Deserialize<Users>(json);
            PasswordHash hash = new PasswordHash();

            SystemUser user=null;

            if (obj.Employee != string.Empty)
            {
                LINQConnection.Employee employee = (from EMP in _context.Employees
                                                    where EMP.FirstName == obj.Employee.Substring(obj.Employee.LastIndexOf(".") + 1, obj.Employee.IndexOf(" ") - 3) &&
                                                    EMP.LastName == obj.Employee.Substring(obj.Employee.IndexOf(" ") + 1)
                                                    select EMP).SingleOrDefault();

                user = _context.SystemUsers.Where(USR => USR.EmployeeID == employee.EmployeeID)
               .Select(USR => USR).SingleOrDefault();
            }
            else if (obj.UserName != string.Empty)
            {
                user = _context.SystemUsers.Where(USR => USR.UserName == obj.UserName).Select(USR => USR).SingleOrDefault();
            }

            if (user != null)
            {
                if (obj.Permissions != null)
                {
                    foreach (var permission in obj.Permissions)
                    {
                        var existing = _context.SystemUserPermissions.Where(PRM => PRM.UserID == user.UserID && PRM.SecurityKeyID == permission.KeyID)
                            .Select(PRM => PRM).SingleOrDefault();

                        switch (permission.Status)
                        {
                            case RecordsStatus.ADDED:
                                if (existing == null)
                                {
                                    SystemUserPermission userprm = new SystemUserPermission();
                                    userprm.SecurityKeyID = permission.KeyID;
                                    userprm.ModifiedDate = DateTime.Now;

                                    user.SystemUserPermissions.Add(userprm);
                                }
                                break;
                            case RecordsStatus.REMOVED:
                                _context.SystemUserPermissions.DeleteOnSubmit(existing);
                                break;
                        }

                    }

                }

                if (obj.Password != string.Empty)
                {
                    user.UserPassword = hash.Hash(obj.Password);
                }


                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related user record");
            }
        }

        [WebMethod]
        public void createNewUser(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Users obj = serializer.Deserialize<Users>(json);
            PasswordHash hash = new PasswordHash();

            SystemUser user = null;

            if (obj.Employee != string.Empty)
            {

                LINQConnection.Employee employee = (from EMP in _context.Employees
                                                    where EMP.FirstName == obj.Employee.Substring(obj.Employee.LastIndexOf(".") + 1, obj.Employee.IndexOf(" ") - 3) &&
                                                    EMP.LastName == obj.Employee.Substring(obj.Employee.IndexOf(" ") + 1)
                                                    select EMP).SingleOrDefault();


                user = _context.SystemUsers.Where(USR => USR.EmployeeID == employee.EmployeeID)
                .Select(USR => USR).SingleOrDefault();

                if (user == null)
                {
                    user = new SystemUser();
                    user.EmployeeID = employee.EmployeeID;
                    user.UserTypeID = _context.SystemUserTypes.Single(TYP => TYP.UserType == obj.AccountType).UserTypeID;
                    user.UserPassword = hash.Hash(obj.Password);
                    user.ModifiedDate = DateTime.Now;
                    user.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    if (obj.Permissions != null)
                    {
                        foreach (var permission in obj.Permissions)
                        {
                            SystemUserPermission userprm = new SystemUserPermission();
                            userprm.SecurityKeyID = permission.KeyID;
                            userprm.ModifiedDate = DateTime.Now;

                            user.SystemUserPermissions.Add(userprm);
                        }
                    }

                    _context.SystemUsers.InsertOnSubmit(user);
                    _context.SubmitChanges();
                }
                else
                {
                    throw new Exception("There is already an account for the selected employee");
                }
            }
            else if (obj.UserName != string.Empty)
            {
                //constrict the system so that only one system account is allowed
                var users=_context.SystemUsers.Where(USR=>USR.UserTypeID==(int)UserType.System).Select(USR=>USR).ToList();
                if (users.Count == 0)
                {
                    user = _context.SystemUsers.Where(USR => USR.UserName == obj.UserName)
                    .Select(USR => USR).SingleOrDefault();
                    if (user == null)
                    {
                    
                        user = new SystemUser();
                        user.UserName = obj.UserName;
                        user.UserTypeID = _context.SystemUserTypes.Single(TYP => TYP.UserType == obj.AccountType).UserTypeID;
                        user.UserPassword = hash.Hash(obj.Password);
                        user.ModifiedDate = DateTime.Now;
                        user.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        if (obj.Permissions != null)
                        {
                            foreach (var permission in obj.Permissions)
                            {
                                SystemUserPermission userprm = new SystemUserPermission();
                                userprm.SecurityKeyID = permission.KeyID;
                                userprm.ModifiedDate = DateTime.Now;

                                user.SystemUserPermissions.Add(userprm);
                            }
                        }

                        _context.SystemUsers.InsertOnSubmit(user);
                        _context.SubmitChanges();
                    }
                    else
                    {
                        throw new Exception("The name of the user already exists");
                    }
                }
                else
                {
                    throw new Exception("Only one system user is allowed");
                }
            }

           
        }

        [WebMethod]
        public string loadPermissionsKey()
        {
            var keys = _context.AT_TreeNodeSecurityKeys
                    .Select(KEY => new Permission
                    {
                        KeyID = KEY.SecurityKeyID,
                        Key = KEY.SecurityKey
                    }).ToList();

            var xml = new XmlSerializer(typeof(List<Permission>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, keys);

            return str.ToString();

        }

        [WebMethod]
        public void removeUser(int userID)
        {
            var user = _context.SystemUsers.Where(USR => USR.UserID == userID)
                .Select(USR => USR).SingleOrDefault();

            if (user != null)
            {
                _context.SystemUsers.DeleteOnSubmit(user);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related user record");
            }

        }
        
        [WebMethod]
        public string[] loadUserType()
        {
            var usertype = (from TYP in _context.SystemUserTypes

                            select TYP.UserType).ToArray();
            return usertype;
        }

        [WebMethod]
        public string filterByUserType(string type)
        {
            var users = _context.SystemUsers
            .Where(USR => USR.SystemUserType.UserType == type)
            .Select(USR => new Users
            {
                UserID = USR.UserID,
                Employee = USR.EmployeeID.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                              from g in empgroup
                                                                              where g.EmployeeID == USR.EmployeeID
                                                                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                UserName = USR.UserName == null ? string.Empty : USR.UserName,
                AccountType = USR.SystemUserType.UserType,
                Permissions = _context.SystemUserPermissions.Where(USRP => USRP.UserID == USR.UserID)
                .Select(USRP => new Permission
                {
                    KeyID = USRP.AT_TreeNodeSecurityKey.SecurityKeyID,
                    Key = USRP.AT_TreeNodeSecurityKey.SecurityKey
                }).ToList()

            }).ToList();

            var xml = new XmlSerializer(typeof(List<Users>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, users);

            return str.ToString();
        }
        [WebMethod]
        public string refreshUsers()
        {
            var users = _context.SystemUsers
            .Select(USR => new Users
            {
                UserID = USR.UserID,
                Employee = USR.EmployeeID.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                              from g in empgroup
                                                                              where g.EmployeeID == USR.EmployeeID
                                                                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                UserName = USR.UserName == null ? string.Empty : USR.UserName,
                AccountType = USR.SystemUserType.UserType,
                Permissions = _context.SystemUserPermissions.Where(USRP => USRP.UserID == USR.UserID)
                .Select(USRP => new Permission
                {
                    KeyID = USRP.AT_TreeNodeSecurityKey.SecurityKeyID,
                    Key = USRP.AT_TreeNodeSecurityKey.SecurityKey
                }).ToList()

            }).ToList();

            var xml = new XmlSerializer(typeof(List<Users>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, users);

            return str.ToString();
        }
        
        #endregion
        #region EmailConfigration
        
        [WebMethod]
        public string loadEmailTemplates()
        {
            var templates = _context.AT_EmailsTemplates
            .Select(ETMP => new EmailTemplate
            {
                EmailID=ETMP.EmailId,
                EmailFrom=ETMP.EmailFrom,
                Action=ETMP.Action.ActionNameEng,
                Body=ETMP.EmailBody,
                Subject=ETMP.EmailSubject,
                SMTPServer=ETMP.AT_SMTPserver.SMTPserver,
                Status=RecordsStatus.ORIGINAL,
                Module = ETMP.Module.Name
            }).ToList();

            var xml = new XmlSerializer(typeof(List<EmailTemplate>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, templates);

            return str.ToString();
        }

        [WebMethod]
        public string removeEmailTemplate(int emailID)
        {
            string result = string.Empty;

            var template = _context.AT_EmailsTemplates.Where(ETMP => ETMP.EmailId == emailID)
                .Select(ETMP => ETMP).SingleOrDefault();
            if (template != null)
            {
                _context.AT_EmailsTemplates.DeleteOnSubmit(template);
                _context.SubmitChanges();

                result = "Email template has been removed successfully";
            }
            else
            {
                    throw new Exception("Cannot find the related email template");
            }

            return result;
        }

        [WebMethod]
        public void updateEmailTemplate(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            EmailTemplate obj = serializer.Deserialize<EmailTemplate>(json);

            AT_EmailsTemplate template = _context.AT_EmailsTemplates.Where(TEMP => TEMP.EmailId == obj.EmailID)
                .Select(TEMP => TEMP).SingleOrDefault();

            if (template != null)
            {
                template.EmailFrom = obj.EmailFrom;
                template.EmailBody = obj.Body;
                template.ModuleId = _context.Modules.Single(MODL => MODL.Name == obj.Module).ModuleId;
                template.EmailSubject = obj.Subject;
                template.SMTPServerId = _context.AT_SMTPservers.Single(SRV => SRV.SMTPserver == obj.SMTPServer).SMTPServerID;
                template.ActionId = _context.Actions.Single(ACT => ACT.ActionNameEng == obj.Action).ActionID;
                template.ModifiedDate = DateTime.Now;
                template.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related Email template");
            }
        }

        [WebMethod]
        public void createEmailTemplate(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            EmailTemplate obj = serializer.Deserialize<EmailTemplate>(json);

            var template = _context.AT_EmailsTemplates.Where(TEMP => TEMP.Action.ActionNameEng == obj.Action
                                                        && TEMP.Module.Name == obj.Module)
                                                        .Select(TEMP => TEMP).SingleOrDefault();
            if (template == null)
            {


                template = new AT_EmailsTemplate();
                template.EmailFrom = obj.EmailFrom;
                template.EmailBody = obj.Body;
                template.ModuleId = _context.Modules.Single(MODL => MODL.Name == obj.Module).ModuleId;
                template.EmailSubject = obj.Subject;
                template.SMTPServerId = _context.AT_SMTPservers.Single(SRV => SRV.SMTPserver == obj.SMTPServer).SMTPServerID;
                template.ActionId = _context.Actions.Single(ACT => ACT.ActionNameEng == obj.Action).ActionID;
                template.ModifiedDate = DateTime.Now;
                template.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AT_EmailsTemplates.InsertOnSubmit(template);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Email template for the specified module and action already exists");
            }
        }

        [WebMethod]
        public string[] getModuleAttributes(string name)
        {
            var module = _context.Modules.Where(MODL => MODL.Name == name)
                .Select(MODL => MODL).SingleOrDefault();

            var attributes = (from PARM in _context.fn_GetTableColumns(module.SchemaName, module.SQLModuleName)
                              select PARM.ParameterValue).ToArray();

            return attributes;
        }
        
        [WebMethod]
        public string[] getModuleActions(string name)
        {
            var module = _context.Modules.Where(MODL => MODL.Name == name)
            .Select(MODL => MODL).SingleOrDefault();

            var actions = _context.Actions.Join(_context.AT_ModulesActions,
            ACT => ACT.ActionID, MACT => MACT.ActionId, (ACT, MACT) => new { ACT, MACT }).OrderBy(MODACT => MODACT.ACT.ActionNameEng)
            .Where(MODACT=>MODACT.MACT.ModuleId==module.ModuleId)
            .Select(MODACT => MODACT.ACT.ActionNameEng).ToArray();

            return actions;
        }
        [WebMethod]
        public string getSMTPServer()
        {
            var servers = _context.AT_SMTPservers.Select(SRV => new SMTPServer
                {
                    SMTPServerID = SRV.SMTPServerID,
                    SMTP = SRV.SMTPserver,
                    UserName = SRV.UserName,
                    Password = SRV.Password,
                    Status=RecordsStatus.ORIGINAL

                }).ToList();
            var xml = new XmlSerializer(typeof(List<SMTPServer>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, servers);

            return str.ToString();
        }
        [WebMethod]
        public void updateSMTPServer(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            SMTPServer obj = serializer.Deserialize<SMTPServer>(json);

            var server = _context.AT_SMTPservers.Where(SRV => SRV.SMTPServerID == obj.SMTPServerID)
              .Select(SRV => SRV).SingleOrDefault();

            if (server != null)
            {
                server.SMTPserver = obj.SMTP;
                server.UserName = obj.UserName;
                server.Password = obj.Password;
                server.ModifiedDate = DateTime.Now;
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related SMTP record");
            }
           
        }
        [WebMethod]
        public void removeSMTPServer(int serverid)
        {
            var server = _context.AT_SMTPservers.Where(SRV => SRV.SMTPServerID == serverid)
                .Select(SRV => SRV).SingleOrDefault();
            if (server != null)
            {
                _context.AT_SMTPservers.DeleteOnSubmit(server);
                _context.SubmitChanges();
            }

        }
        [WebMethod]
        public void createSMTPServer(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            SMTPServer obj = serializer.Deserialize<SMTPServer>(json);

            var server = _context.AT_SMTPservers.Where(SRV => SRV.SMTPserver == obj.SMTP)
                .Select(SRV => SRV).SingleOrDefault();

            if (server == null)
            {
                server = new AT_SMTPserver();
                server.SMTPserver = obj.SMTP;
                server.UserName = obj.UserName;
                server.Password = obj.Password;
                server.ModifiedDate = DateTime.Now;
                server.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AT_SMTPservers.InsertOnSubmit(server);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the server already exists");
            }
        }
        #endregion
        #region RAGCondition

        [WebMethod]
        public string getDBAttribute(string parameter, string module)
        {
            var attribute = _context.AT_RAGParameters.Where(PRM => PRM.Module.Name == module && PRM.ParameterText == parameter)
                .Select(PRM => PRM.ParameterValue).SingleOrDefault();

            return attribute;
        }
        [WebMethod]
        public string loadRAGConditions()
        {
            var conditions = _context.RAGConditions
            .Select(RAG => new RAGCondition
            {
                RAGConditionID = RAG.RAGConditionID,
                Condition = RAG.Condition,
                RAG = RAG.RAGConditionSymbol.RAGSymbol,
                Module = RAG.Module.Name

            }).ToList();


            var xml = new XmlSerializer(typeof(List<RAGCondition>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, conditions);

            return str.ToString();
        }
        [WebMethod]
        public string filterRAGConditions(string module, string symbol)
        {
            var conditions = _context.RAGConditions
            .Where(RAG=>RAG.Module.Name==module || RAG.RAGConditionSymbol.RAGSymbol==symbol)
            .Select(RAG => new RAGCondition
            {
                RAGConditionID = RAG.RAGConditionID,
                Condition = RAG.Condition,
                RAG = RAG.RAGConditionSymbol.RAGSymbol,
                Module = RAG.Module.Name

            }).ToList();


            var xml = new XmlSerializer(typeof(List<RAGCondition>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, conditions);

            return str.ToString();
        }
        [WebMethod]
        public string[] loadConjunctionOperators()
        {
            var operators = _context.AT_RAGSigns.Where(SGN => SGN.IsLinkOperator == true)
                .Select(SGN => SGN.Sign).ToArray();

            return operators;
        }

        [WebMethod]
        public string getModuleRAGCondition(string module, string symbol)
        {
            var condition = _context.RAGConditions.Where(RAG => RAG.Module.Name == module && RAG.RAGConditionSymbol.RAGSymbol == symbol)
                .Select(RAG => new RAGCondition
                {
                    RAGConditionID=RAG.RAGConditionID,
                    Condition=RAG.Condition,
                    RAG=RAG.RAGConditionSymbol.RAGSymbol,
                    Module=RAG.Module.Name
                }).SingleOrDefault();

            if (condition != null)
            {
                var xml = new XmlSerializer(typeof(RAGCondition));

                StringWriter str = new StringWriter();
                xml.Serialize(str, condition);

                return str.ToString();
            }
            else
            {
                throw new Exception("Cannot find the corresponding RAG condition");
            }
        }
        [WebMethod]
        public string[] getModuleParameters(string module)
        {
            var param = (from PRM in _context.AT_RAGParameters
                         where PRM.ModuleId == _context.Modules.Single(MOD => MOD.Name == module).ModuleId
                         select PRM.ParameterText).ToArray();

            return param;
        }

        [WebMethod]
        public string[] loadRAGSymbols()
        {
            var symbols = (from SYM in _context.RAGConditionSymbols
                           select SYM.RAGSymbol).ToArray();
            return symbols;
        }
        [WebMethod]
        public void createRAGCondition(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            RAGCondition obj = serializer.Deserialize<RAGCondition>(json);

            var condition = _context.RAGConditions.Where(RAG => RAG.Module.Name == obj.Module &&
                RAG.RAGConditionSymbol.RAGSymbol == obj.RAG).Select(RAG => RAG).SingleOrDefault();
            if (condition == null)
            {
                condition = new LINQConnection.RAGCondition();
                condition.ModuleID = _context.Modules.Single(MODL => MODL.Name == obj.Module).ModuleId;
                condition.RAGSymbolID = _context.RAGConditionSymbols.Single(RAG => RAG.RAGSymbol == obj.RAG).RAGSymbolID;
                condition.Condition = obj.Condition;
                condition.ModifiedDate = DateTime.Now;
                condition.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.RAGConditions.InsertOnSubmit(condition);

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The type of the RAG condition already exists");
            }
        }
        [WebMethod]
        public void updateRAGCondition(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            RAGCondition  obj = serializer.Deserialize<RAGCondition>(json);

            var condition = _context.RAGConditions.Where(RAG => RAG.RAGConditionID==obj.RAGConditionID)
                .Select(RAG => RAG).SingleOrDefault();
            if (condition != null)
            {

                condition.ModuleID = _context.Modules.Single(MODL => MODL.Name == obj.Module).ModuleId;
                condition.RAGSymbolID = _context.RAGConditionSymbols.Single(RAG => RAG.RAGSymbol == obj.RAG).RAGSymbolID;
                condition.Condition = obj.Condition;
                condition.ModifiedDate = DateTime.Now;
                condition.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the current RAG condition in the system");
            }
        }

        [WebMethod]
        public void removeRAGCondition(int RAGID)
        {
            var RAGCondition = _context.RAGConditions.Where(RAG => RAG.RAGConditionID == RAGID).Select(RAG => RAG).SingleOrDefault();
            if (RAGCondition != null)
            {
                _context.RAGConditions.DeleteOnSubmit(RAGCondition);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the current RAG condition in the system");
            }
        }            

        #endregion
        #region AuditManagement
       
        [WebMethod]
        public string[] enumAuditYears()
        {
            var years = _context.Audits.Select(AUDT => AUDT.PlannedAuditDate.Year.ToString()).Distinct().ToArray();

            return years;
        }
        [WebMethod]
        public string[] loadAuditors()
        {
            var auditors = _context.fn_GetAuditors().Select(ADTR => ADTR.EmployeeName).ToArray();
            return auditors;
        }
        [WebMethod]
        public string getLastAuditNo()
        {
            string auditNo = null;

            if (_context.Audits.ToList().Count > 0)
            {
                long maxId = _context.Audits.Max(i => i.AuditId);
                auditNo = _context.Audits.Single(AUDT => AUDT.AuditId == maxId).AuditReference;
            }
            return auditNo == null ? string.Empty : auditNo;
        }

        [WebMethod]
        public void createActionType(string type)
        {
            var actiontype = _context.AuditActionTypes
                .Where(ACTTYP => ACTTYP.Name == type)
                .Select(ACTTYP => ACTTYP).SingleOrDefault();

            if (actiontype == null)
            {
                AuditActionType obj = new AuditActionType();
                obj.Name = type;
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AuditActionTypes.InsertOnSubmit(obj);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The desired action type already exists");
            }
        }

        [WebMethod]
        public string createAuditAction(string json, int findingID)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AuditActions action = serializer.Deserialize<AuditActions>(json);

            var finding = _context.Findings.Where(FND => FND.FindingId == findingID)
                .Select(FND => FND).SingleOrDefault();

            if (finding != null)
            {
                AuditAction obj = new AuditAction();
                obj.AuditActionTypeId = _context.AuditActionTypes.Single(AAT => AAT.Name == action.ActionType).AuditActionTypeId;
                obj.Details = action.Details == string.Empty ? null : action.Details;
                obj.TargetClosingDate = action.TargetClosingDate;
                obj.ActioneeId = (from EMP in _context.Employees
                                  where EMP.FirstName == action.Actionee.Substring(action.Actionee.LastIndexOf(".") + 1, action.Actionee.IndexOf(" ") - 3) &&
                                  EMP.LastName == action.Actionee.Substring(action.Actionee.IndexOf(" ") + 1)
                                  select EMP.EmployeeID).SingleOrDefault();
                obj.ModifiedDate = DateTime.Now;
                obj.ModifiedBy = HttpContext.Current.User.Identity.Name;


                finding.AuditActions.Add(obj);
                _context.SubmitChanges();

                // generate automatic email notification for adding new CCN
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.AuditAction;
                automail.KeyValue = obj.AuditActionId;
                automail.Action = "Add";

                //add both the originator and the owner as a recipient
                automail.Recipients.Add(obj.ActioneeId);

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Cannot find the specified finding record");

            }
            return result;
        }

        [WebMethod]
        public string loadFindingType()
        {
            var findingtype = _context.FindingTypes
           .Select(FNDTYP => new ActionFindingType
           {
               TypeID = FNDTYP.FindingTypeId,
               TypeName = FNDTYP.FindingType1,
               Description = FNDTYP.Description == null ? string.Empty : FNDTYP.Description
           }).ToList();

            var serializer = new XmlSerializer(typeof(List<ActionFindingType>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, findingtype);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadAuditActionType()
        {
            var actiontype = _context.AuditActionTypes
           .Select(ACTTYP => new ActionFindingType
           {
               TypeID = ACTTYP.AuditActionTypeId,
               TypeName = ACTTYP.Name,
               Description = ACTTYP.Description == null ? string.Empty : ACTTYP.Description
           }).ToList();

            var serializer = new XmlSerializer(typeof(List<ActionFindingType>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, actiontype);

            return strwriter.ToString();
        }

        [WebMethod]
        public void removeFindingType(long findingtypeID)
        {
            var findingtype = _context.FindingTypes.Where(FNDTYP => FNDTYP.FindingTypeId == findingtypeID).Select(FNDTYP => FNDTYP).SingleOrDefault();
            if (findingtype != null)
            {
                _context.FindingTypes.DeleteOnSubmit(findingtype);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to find the related finding type record");
            }
        }

        [WebMethod]
        public void removeAuditActionType(long actiontypeID)
        {
            var actiontype = _context.AuditActionTypes.Where(ACTTYP => ACTTYP.AuditActionTypeId == actiontypeID)
            .Select(ACTTYP => ACTTYP).SingleOrDefault();

            if (actiontype != null)
            {
                _context.AuditActionTypes.DeleteOnSubmit(actiontype);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Unable to find the related action type record");
            }
        }

        [WebMethod]
        public string updateFindingType(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ActionFindingType obj = serializer.Deserialize<ActionFindingType>(json);

            var findingtype = _context.FindingTypes.Where(FT => FT.FindingTypeId==obj.TypeID)
            .Select(FT => FT).SingleOrDefault();

            if (findingtype != null)
            {
                findingtype.FindingType1 = obj.TypeName;
                findingtype.Description = obj.Description == string.Empty ? null : obj.Description;
                findingtype.ModifiedDate = DateTime.Now;
                findingtype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Unable to find the related finding type record");
            }

            return result;
        }

        [WebMethod]
        public string updateAuditActionType(string json)
        {
            string result = string.Empty;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ActionFindingType obj = serializer.Deserialize<ActionFindingType>(json);

            var actiontype = _context.AuditActionTypes.Where(ACTTYP => ACTTYP.AuditActionTypeId == obj.TypeID)
            .Select(ACTTYP => ACTTYP).SingleOrDefault();

            if (actiontype != null)
            {
                actiontype.Name = obj.TypeName;
                actiontype.Description = obj.Description == string.Empty ? null : obj.Description;
                actiontype.ModifiedDate = DateTime.Now;
                actiontype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Unable to find the related action type record");
            }
            return result;
        }

        [WebMethod]
        public void createFindingType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ActionFindingType obj = serializer.Deserialize<ActionFindingType>(json);

            var findingtype = _context.FindingTypes.Where(FT => FT.FindingType1 == obj.TypeName)
            .Select(FT => FT).SingleOrDefault();

            if (findingtype == null)
            {
                findingtype = new LINQConnection.FindingType();
                findingtype.FindingType1 = obj.TypeName;
                findingtype.Description = obj.Description == string.Empty ? null : obj.Description;
                findingtype.ModifiedDate = DateTime.Now;
                findingtype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.FindingTypes.InsertOnSubmit(findingtype);
                _context.SubmitChanges();

            }
            else
            {
               throw new Exception("The name of the finding type already exists");
            }
        }

        [WebMethod]
        public void createAuditActionType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ActionFindingType obj = serializer.Deserialize<ActionFindingType>(json);

            var actiontype = _context.AuditActionTypes.Where(ACTTYP => ACTTYP.Name == obj.TypeName)
            .Select(ACTTYP => ACTTYP).SingleOrDefault();

            if (actiontype == null)
            {
                actiontype = new LINQConnection.AuditActionType();
                actiontype.Name = obj.TypeName;
                actiontype.Description = obj.Description == string.Empty ? null : obj.Description;
                actiontype.ModifiedDate = DateTime.Now;
                actiontype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.AuditActionTypes.InsertOnSubmit(actiontype);
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("The name of the action type already exists");
            }
        }

     

        
        [WebMethod]
        public string loadFindingCauses(int findingid)
        {
            var causes = _context.fn_getFindingCauseChildTree(findingid)
            .Select(C => new Causes
            {
                CauseID = Convert.ToInt32(C.CauseID),
                name = C.Cause,
                Description = C.Description,
                ParentID = Convert.ToInt32(C.ParentID == null ? 0 : C.ParentID),
                Status = RecordsStatus.ORIGINAL,
                SelectedCauseID = Convert.ToInt32(C.SelectedCauseID == null ? 0 : C.SelectedCauseID),
                id = Convert.ToInt32(C.CauseID)
            }).ToList();


            foreach (var cause in causes)
            {
                List<Causes> obj = causes.Where(x => x.ParentID == cause.CauseID).ToList<Causes>();

                if (obj.Count > 0)
                {
                    cause.children = obj;
                }
            }

            for (int i = causes.Count - 1; i >= 0; i--)
            {
                if (causes[i].ParentID != 0)
                {
                    causes.RemoveAt(i);
                }else
                {
                    causes[i].ParentID = causes[i].CauseID;
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(causes);

            return result;
        }
        [WebMethod]
        public void removeFinding(int findingid)
        {
            Finding finding = _context.Findings.Where(FND => FND.FindingId == findingid)
            .Select(FND => FND).SingleOrDefault();

            if (finding != null)
            {
                try
                {
                    if (finding.Cause != null)
                    {
                        removeRelatedCauses(finding.Cause);
                    }
                }
                finally
                {
                    _context.Findings.DeleteOnSubmit(finding);
                    _context.SubmitChanges();
                }
            }
            else
            {
                throw new Exception("Unable to find the related finding record");
            }
        }
        private void removeRelatedCauses(Cause cause)
        {
            if (cause.Causes.Count() > 0)
            {
                for (int i = 0; i < cause.Causes.Count(); i++)
                {
                    removeRelatedCauses(cause.Causes[i]);
                }
            }
            _context.Causes.DeleteOnSubmit(cause);
        }
        
        [WebMethod]
        public void updateFinding(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AuditFinding obj = serializer.Deserialize<AuditFinding>(json);

            Finding finding = _context.Findings.Where(FND => FND.FindingId == obj.FindingID)
                .Select(FND => FND).SingleOrDefault();
            
            if (finding != null)
            {
                finding.FindingTypeId = _context.FindingTypes.Single(FT => FT.FindingType1 == obj.FindingType).FindingTypeId;
                finding.Title = obj.Finding;
                finding.Details = obj.Details == string.Empty ? null : obj.Details;
                finding.ModifiedDate = DateTime.Now;

                if (obj.Causes != null)
                {
                    var c = obj.Causes.First();

                    if (c.ParentID == 0)
                        c.ParentID = c.CauseID;
                    
                    Cause cause = null;
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                           cause = _context.Causes.Where(CUS => CUS.CauseName == c.name && CUS.RootCauseID.HasValue == false).Select(CUS => CUS).SingleOrDefault();
                            if (cause == null)
                            {
                                cause = new Cause();
                                cause.CauseName = c.name;
                                cause.Description = c.Description == string.Empty ? null : c.Description;
                                cause.ModifiedDate = DateTime.Now;
                                cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                searchModifiedCause(c, cause);

                                _context.Causes.InsertOnSubmit(cause);
                                _context.SubmitChanges();

                                //finding.RootCauseID = cause.CauseID;
                                finding.RootCauseID = cause.RootCauseID;
                                finding.SubCauseID = c.SelectedCauseID;
                            }
                            else
                            {
                                throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            }

                            break;
                        case RecordsStatus.MODIFIED:
                            //cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            cause = _context.Causes.Single(CU => CU.CauseID == c.SelectedCauseID);
                            cause.CauseName = c.name;
                            cause.Description = c.Description == string.Empty ? null : c.Description;
                            cause.ModifiedDate = DateTime.Now;
                            cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            //finding.RootCauseID = cause.CauseID;
                            finding.RootCauseID = c.ParentID;
                            finding.SubCauseID = c.SelectedCauseID;

                            searchModifiedCause(c, cause);

                            break;
                        case RecordsStatus.ORIGINAL:
                            ////cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            //cause = _context.Causes.Single(CU => CU.CauseID == c.ParentID);

                            ////finding.RootCauseID = cause.CauseID;
                            //finding.RootCauseID = cause.RootCauseID;
                            //finding.SubCauseID = c.SelectedCauseID;

                            //searchModifiedCause(c, cause);
                            cause = _context.Causes.Single(CU => CU.CauseID == c.SelectedCauseID);
                            cause.CauseName = c.name;
                            cause.Description = c.Description == string.Empty ? null : c.Description;
                            cause.ModifiedDate = DateTime.Now;
                            cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            //finding.RootCauseID = cause.CauseID;
                            finding.RootCauseID = c.ParentID;
                            finding.SubCauseID = c.SelectedCauseID;

                            searchModifiedCause(c, cause);
                            break;

                    }
                }
                if (obj.CheckList != null)
                {
                    finding.ISOCheckID = obj.CheckList.ISOProcessID;
                }

                _context.SubmitChanges();
            }
        }

        [WebMethod]
        public string updateFinding2(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AuditFinding obj = serializer.Deserialize<AuditFinding>(json);

            Finding finding = _context.Findings.Where(FND => FND.FindingId == obj.FindingID)
                .Select(FND => FND).SingleOrDefault();

            if (finding != null)
            {
                finding.FindingTypeId = _context.FindingTypes.Single(FT => FT.FindingType1 == obj.FindingType).FindingTypeId;
                finding.Title = obj.Finding;
                finding.Details = obj.Details == string.Empty ? null : obj.Details;
                finding.ModifiedDate = DateTime.Now;

                if (obj.Causes != null)
                {
                    var c = obj.Causes.First();
                    var s = obj.SelectedCause.First();

                    Cause cause = null;
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                            cause = _context.Causes.Where(CUS => CUS.CauseName == c.name && CUS.RootCauseID.HasValue == false).Select(CUS => CUS).SingleOrDefault();
                            if (cause == null)
                            {
                                cause = new Cause();
                                cause.CauseName = c.name;
                                cause.Description = c.Description == string.Empty ? null : c.Description;
                                cause.ModifiedDate = DateTime.Now;
                                cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                searchModifiedCause2(c, cause, s);

                                _context.Causes.InsertOnSubmit(cause);
                                _context.SubmitChanges();

                            }
                            else
                            {
                                throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            }
                            break;
                        case RecordsStatus.MODIFIED:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            cause.CauseName = c.name;
                            cause.Description = c.Description == string.Empty ? null : c.Description;
                            cause.ModifiedDate = DateTime.Now;
                            cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedCause2(c, cause, s);

                            break;
                        case RecordsStatus.ORIGINAL:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);

                            searchModifiedCause2(c, cause, s);

                            break;
                    }


                    if (c.ParentID == 0)
                        finding.RootCauseID = c.CauseID;
                    else
                        finding.RootCauseID = c.ParentID;

                    finding.SubCauseID = s.CauseID;

                }
                if (obj.CheckList != null)
                {
                    finding.ISOCheckID = obj.CheckList.ISOProcessID;
                }

                _context.SubmitChanges();
                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Failed to update this finding record.");
            }

            return result;
        }

        [WebMethod]
        public string createFinding(string json, string auditno)
        {
            string result = string.Empty;

            var audit = _context.Audits.Where(AUDT => AUDT.AuditReference == auditno).SingleOrDefault();

            if (audit != null)
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();

                AuditFinding obj = serializer.Deserialize<AuditFinding>(json);

                Finding finding = new Finding();
                finding.FindingTypeId = _context.FindingTypes.Single(FT => FT.FindingType1 == obj.FindingType).FindingTypeId;
                finding.Title = obj.Finding;
                finding.Details = obj.Details == string.Empty ? null : obj.Details;
                finding.ModifiedDate = DateTime.Now;
                finding.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.Causes != null)
                {
                    var c = obj.Causes.First();
                    var s = obj.SelectedCause.First();

                    Cause cause = null;
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                            cause = _context.Causes.Where(CUS => CUS.CauseName == c.name && CUS.RootCauseID.HasValue == false).Select(CUS => CUS).SingleOrDefault();
                            if (cause == null)
                            {
                                cause = new Cause();
                                cause.CauseName = c.name;
                                cause.Description = c.Description == string.Empty ? null : c.Description;
                                cause.ModifiedDate = DateTime.Now;
                                cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                searchModifiedCause2(c, cause, s);

                                _context.Causes.InsertOnSubmit(cause);
                                _context.SubmitChanges();

                            }
                            else
                            {
                                throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            }
                            break;
                        case RecordsStatus.MODIFIED:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            cause.CauseName = c.name;
                            cause.Description = c.Description == string.Empty ? null : c.Description;
                            cause.ModifiedDate = DateTime.Now;
                            cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedCause2(c, cause, s);

                            break;
                        case RecordsStatus.ORIGINAL:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);

                            searchModifiedCause2(c, cause, s);

                            break;
                            //case RecordsStatus.ADDED:
                            //    cause = _context.Causes.Where(CUS => CUS.CauseName == c.name && CUS.RootCauseID.HasValue == false).Select(CUS => CUS).SingleOrDefault();
                            //    if (cause == null)
                            //    {
                            //        cause = new Cause();
                            //        cause.CauseName = c.name;
                            //        cause.Description = c.Description == string.Empty ? null : c.Description;
                            //        cause.ModifiedDate = DateTime.Now;
                            //        cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            //        searchModifiedCause(c, cause);

                            //        _context.Causes.InsertOnSubmit(cause);
                            //        _context.SubmitChanges();

                            //        //finding.RootCauseID = cause.CauseID;
                            //        finding.RootCauseID = c.ParentID;
                            //        finding.SubCauseID = c.SelectedCauseID;
                            //    }
                            //    else
                            //    {
                            //        throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            //    }
                            //    break;
                            //case RecordsStatus.MODIFIED:
                            //    cause = _context.Causes.Single(CU => CU.CauseID == c.SelectedCauseID);
                            //    cause.CauseName = c.name;
                            //    cause.Description = c.Description == string.Empty ? null : c.Description;
                            //    cause.ModifiedDate = DateTime.Now;
                            //    cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            //    //finding.RootCauseID = cause.CauseID;
                            //    finding.RootCauseID = c.ParentID;
                            //    finding.SubCauseID = c.SelectedCauseID;

                            //    searchModifiedCause(c, cause);

                            //    break;
                            //case RecordsStatus.ORIGINAL:
                            //    //cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            //    //cause = _context.Causes.Single(CU => CU.CauseID == c.ParentID);

                            //    ////finding.RootCauseID = cause.CauseID;
                            //    //finding.RootCauseID = cause.RootCauseID;
                            //    //finding.SubCauseID = c.SelectedCauseID;

                            //    //searchModifiedCause(c, cause);
                            //    cause = _context.Causes.Single(CU => CU.CauseID == c.SelectedCauseID);
                            //    cause.CauseName = c.name;
                            //    cause.Description = c.Description == string.Empty ? null : c.Description;
                            //    cause.ModifiedDate = DateTime.Now;
                            //    cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            //    //finding.RootCauseID = cause.CauseID;
                            //    finding.RootCauseID = c.ParentID;
                            //    finding.SubCauseID = c.SelectedCauseID;

                            //    searchModifiedCause(c, cause);
                            //    break;

                    }

                    if (c.ParentID == 0)
                        finding.RootCauseID = c.CauseID;
                    else
                        finding.RootCauseID = c.ParentID;

                    finding.SubCauseID = s.CauseID;
                }

                if (obj.CheckList != null)
                {
                    finding.ISOCheckID = obj.CheckList.ISOProcessID;
                }

                audit.Findings.Add(finding);
                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Cannot find the related audit record");
            }
            return result;
        }
        
        [WebMethod]
        public string loadISOChecklist(string auditno)
        {
            var processes = _context.CheckLists
               .Where(CHK => CHK.AuditID == _context.Audits.Single(AUDT => AUDT.AuditReference == auditno).AuditId)
               .Select(CHK => new QMSRSTools.ISOProcess
               {
                   ISOProcessID = CHK.ISOProcessID,
                   name = CHK.ISOProcess.Process,
               }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(processes);

            return result;
        }
        
    
        [WebMethod]
        public string updateAuditAction(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AuditActions obj = serializer.Deserialize<AuditActions>(json);
            var result = string.Empty;

            var action = _context.AuditActions.Where(ACT => ACT.AuditActionId == obj.ActionID)
                .Select(ACT => ACT).SingleOrDefault();
            if (action != null)
            {
                action.AuditActionTypeId = _context.AuditActionTypes.Single(ACTTYP => ACTTYP.Name == obj.ActionType).AuditActionTypeId;
                action.Details = (obj.Details == string.Empty ? null : obj.Details);
                action.FollowUpComments = (obj.FollowUpComments == string.Empty ? null : obj.FollowUpComments);
                action.TargetClosingDate = obj.TargetClosingDate;
                action.DelayedDate = (obj.DelayedDate == null ? null : obj.DelayedDate);
                action.CompletedDate = (obj.CompleteDate == null ? null : obj.CompleteDate);
                action.ActioneeId = (from EMP in _context.Employees
                                     where EMP.FirstName == obj.Actionee.Substring(obj.Actionee.LastIndexOf(".") + 1, obj.Actionee.IndexOf(" ") - 3) &&
                                     EMP.LastName == obj.Actionee.Substring(obj.Actionee.IndexOf(" ") + 1)
                                     select EMP.EmployeeID).SingleOrDefault();

                action.IsClosed = obj.IsClosed;
                action.ModifiedDate = DateTime.Now;
                action.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

                // generate automatic email notification for adding new CCN
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.AuditAction;
                automail.KeyValue = action.AuditActionId;
                automail.Action = "Update";

                //add both the originator and the owner as a recipient
                automail.Recipients.Add(action.ActioneeId);

                bool isGenerated = automail.GenerateEmail();

                if (isGenerated == true)
                {
                    result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";

                }
                else
                {
                    result = "Operation has been committed sucessfully";

                }

            }
            else
            {
                throw new Exception("Cannot find the specified audit action record");
            }
            return result;
        }
        [WebMethod]
        public void removeAuditAction(int actionID)
        {
            try
            {
                var action = _context.AuditActions.Where(ACT => ACT.AuditActionId == actionID)
                    .Select(ACT => ACT).SingleOrDefault();

                _context.AuditActions.DeleteOnSubmit(action);
                _context.SubmitChanges();
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }
        }
        [WebMethod]
        public string getAudit(string auditno)
        {
            var audit = (from AUDT in _context.Audits
                            where AUDT.AuditReference == auditno
                            select new AuditRecord
                            {
                                AuditName=AUDT.AuditTitle,
                                AuditType=AUDT.AuditType.AuditType1,
                                PlannedAuditDate= ConvertToLocalTime(AUDT.PlannedAuditDate),
                                ActualAuditDate= AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                                AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                            }).SingleOrDefault();

            if (audit == null)
            {
                throw new Exception("Cannot find the related audit record");
            }

            var serializer = new XmlSerializer(typeof(AuditRecord));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, audit);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadFindings(string auditno)
        {
            StringWriter strwriter = new StringWriter();

            try
            {
                var audit = _context.Audits.Join(_context.AuditTypes,
                AUDT => AUDT.AuditTypeId, TYP => TYP.AuditTypeId, (AUDT, TYP) => new { AUDT, TYP }).OrderBy(ADT => ADT.AUDT.PlannedAuditDate)
                .Where(ADT => ADT.AUDT.AuditReference == auditno)
                .Select(ADT => new AuditRecord
                {
                    AuditNo = ADT.AUDT.AuditReference,
                    AuditType = ADT.TYP.AuditType1,
                    PlannedAuditDate = ConvertToLocalTime(ADT.AUDT.PlannedAuditDate),
                    ActualAuditDate = ADT.AUDT.ActualAuditDate != null ? ConvertToLocalTime(ADT.AUDT.ActualAuditDate.Value) : ADT.AUDT.ActualAuditDate,
                    AuditStatusString = ADT.AUDT.AuditStatus.AuditStatus1,
                    Findings = _context.Findings.Where(FND => FND.AuditId == ADT.AUDT.AuditId)
                    .Select(FND => new AuditFinding
                    {
                        FindingID = FND.FindingId,
                        Finding = FND.Title,
                        Details = FND.Details,
                        FindingType = FND.FindingType.FindingType1
                    }).ToList()

                }).SingleOrDefault();

                if (audit != null)
                {
                    var serializer = new XmlSerializer(typeof(AuditRecord));

                    serializer.Serialize(strwriter, audit);
                }
                else
                {
                    throw new Exception("The desired audit record does not exists");
                }
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return strwriter.ToString();
        }
        [WebMethod]
        public void removeAudit(string auditno)
        {
            var audit = _context.Audits.Where(AUDT => AUDT.AuditReference == auditno).Select(AUDT => AUDT).SingleOrDefault();
            if (audit != null)
            {
                _context.Audits.DeleteOnSubmit(audit);
                
                //delete recipients associated with this audit
                var recipient = _context.Recipients.Where(r => r.AuditID == audit.AuditId);
                _context.Recipients.DeleteAllOnSubmit(recipient);

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related audit record");
            }
        }
        [WebMethod]
        public void removeAuditeeUnit(long auditID)
        {
            var relatedAuditUnits = _context.RelatedAuditUnits.Where(AUDT => AUDT.AuditID == auditID).Select(AUDT => AUDT).ToList();
            if (relatedAuditUnits != null)
            {
                foreach (var unit in relatedAuditUnits)
                {
                    _context.RelatedAuditUnits.DeleteOnSubmit(unit);
                    _context.SubmitChanges();
                }
            }
        }
        [WebMethod]
        public string filterAuditsByMonth(int month, int year)
        {
            StringWriter strwriter = new StringWriter();

            var audits = _context.Audits
            .Where(AUDT => AUDT.PlannedAuditDate.Month == month && AUDT.PlannedAuditDate.Year == year)
            .OrderBy(AUDT => AUDT.PlannedAuditDate)
            .Select(AUDT => new AuditRecord
            {
                AuditID = AUDT.AuditId,
                AuditNo = AUDT.AuditReference,
                AuditType = AUDT.AuditType.AuditType1,
                PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                Mode = (RecordMode)AUDT.RecordModeID,
                ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                Scope = AUDT.Scope,
                Summery = AUDT.Summery,
                Comments = AUDT.Notes,
                CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                {
                    ISOProcessID = CHK.ISOProcessID,
                    name = CHK.ISOProcess.Process,
                    ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                    Status = RecordsStatus.ORIGINAL
                
                }).ToList(),

                Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                {
                    ORGID = UNT.OrganizationUnit.UnitID,
                    name = UNT.OrganizationUnit.UnitName,
                    ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                    Country = UNT.OrganizationUnit.Country.CountryName,
                    Status=RecordsStatus.ORIGINAL

                }).ToList(),

                Auditors = AUDT.Auditors.Select(AUDTR=>new Employee
                {
                    EmployeeID=AUDTR.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == AUDTR.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),

                Findings = AUDT.Findings.Select(FND => new AuditFinding
                {
                    FindingID = FND.FindingId,
                    Finding = FND.Title,
                    Details = FND.Details == null ? string.Empty : FND.Details,
                    FindingType = FND.FindingType.FindingType1,
                    CauseName = FND.SubCause.CauseName,
                    CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                    .Select(ISO => new ISOProcess
                    {
                        ISOProcessID = ISO.ISOProcessID,
                        name = ISO.Process
                    }).SingleOrDefault(),
                    Actions = FND.AuditActions.Select(ACT => new AuditActions
                    {
                        ActionID = ACT.AuditActionId,
                        ActionType = ACT.AuditActionType.Name,
                        Details = ACT.Details == null ? string.Empty : ACT.Details,
                        FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                        Actionee = (from T in _context.Titles
                                    join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                    from g in empgroup
                                    where g.EmployeeID == ACT.ActioneeId
                                    select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                        TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                        CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                        DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                        IsClosed = ACT.IsClosed,
                        Module = Modules.AuditAction

                    }).ToList()
                }).ToList()

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<AuditRecord>));
            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterByAuditMode(string mode, int year)
        {
            StringWriter strwriter = new StringWriter();

            var audits = _context.Audits
            .Where(AUDT => AUDT.RecordMode.RecordMode1 == mode & AUDT.PlannedAuditDate.Year == year)
            .OrderBy(AUDT => AUDT.PlannedAuditDate)
             .Select(AUDT => new AuditRecord
             {
                 AuditID = AUDT.AuditId,
                 AuditNo = AUDT.AuditReference,
                 AuditName = AUDT.AuditTitle,
                 AuditType = AUDT.AuditType.AuditType1,
                 PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                 ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                 ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                 AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                 Mode = (RecordMode)AUDT.RecordModeID,
                 ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                 Scope = AUDT.Scope,
                 Summery = AUDT.Summery,
                 Comments = AUDT.Notes,
                 Completed = AUDT._Completed,
                 Project = AUDT.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(P => P.ProjectId == AUDT.ProjectID).ProjectName,
                 Supplier = AUDT.SupplierID.HasValue == false ? string.Empty : _context.Customers.Single(S => S.CustomerID == AUDT.SupplierID).CustomerName,
                 CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                 {
                     ISOProcessID = CHK.ISOProcessID,
                     name = CHK.ISOProcess.Process,
                     ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                     Status = RecordsStatus.ORIGINAL

                 }).ToList(),

                 Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                 {
                     ORGID = UNT.OrganizationUnit.UnitID,
                     name = UNT.OrganizationUnit.UnitName,
                     ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                     Country = UNT.OrganizationUnit.Country.CountryName,
                     Status = RecordsStatus.ORIGINAL
                 }).ToList(),

                 Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                 {
                     EmployeeID = AUDTR.EmployeeID,
                     NameFormat = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == AUDTR.EmployeeID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                 }).ToList(),

                 Findings = AUDT.Findings.Select(FND => new AuditFinding
                 {
                     FindingID = FND.FindingId,
                     Finding = FND.Title,
                     Details = FND.Details == null ? string.Empty : FND.Details,
                     FindingType = FND.FindingType.FindingType1,
                     CauseName = FND.SubCause.CauseName,
                     CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                     .Select(ISO => new ISOProcess
                     {
                         ISOProcessID = ISO.ISOProcessID,
                         name = ISO.Process
                     }).SingleOrDefault(),
                     Actions = FND.AuditActions.Select(ACT => new AuditActions
                     {
                         ActionID = ACT.AuditActionId,
                         ActionType = ACT.AuditActionType.Name,
                         Details = ACT.Details == null ? string.Empty : ACT.Details,
                         FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                         Actionee = (from T in _context.Titles
                                     join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                     from g in empgroup
                                     where g.EmployeeID == ACT.ActioneeId
                                     select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                         TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                         CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                         DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                         IsClosed = ACT.IsClosed,
                         Module = Modules.AuditAction

                     }).ToList()
                 }).ToList()

             }).ToList();

         
            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }
        [WebMethod]
        public string filterByAuditType(string type,int year)
        {
            StringWriter strwriter = new StringWriter();

            var audits = _context.Audits
            .Where(AUDT => AUDT.AuditType.AuditType1 == type && AUDT.PlannedAuditDate.Year==year)
            .OrderBy(AUDT => AUDT.PlannedAuditDate)
             .Select(AUDT => new AuditRecord
             {
                 AuditID = AUDT.AuditId,
                 AuditNo = AUDT.AuditReference,
                 AuditName = AUDT.AuditTitle,
                 AuditType = AUDT.AuditType.AuditType1,
                 PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                 ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                 AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                 ActualCloseDate= AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                 Mode = (RecordMode)AUDT.RecordModeID,
                 ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                 Scope = AUDT.Scope,
                 Summery = AUDT.Summery,
                 Comments = AUDT.Notes,
                 Completed = AUDT._Completed,
                 Project = AUDT.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(P => P.ProjectId == AUDT.ProjectID).ProjectName,
                 Supplier = AUDT.SupplierID.HasValue == false ? string.Empty : _context.Customers.Single(S => S.CustomerID == AUDT.SupplierID).CustomerName,
                 CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                 {
                     ISOProcessID = CHK.ISOProcessID,
                     name = CHK.ISOProcess.Process,
                     ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                     Status = RecordsStatus.ORIGINAL

                 }).ToList(),

                 Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                 {
                     ORGID = UNT.OrganizationUnit.UnitID,
                     name = UNT.OrganizationUnit.UnitName,
                     ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                     Country = UNT.OrganizationUnit.Country.CountryName,
                     Status = RecordsStatus.ORIGINAL
                 }).ToList(),

                 Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                 {
                     EmployeeID = AUDTR.EmployeeID,
                     NameFormat = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == AUDTR.EmployeeID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                 }).ToList(),

                 Findings = AUDT.Findings.Select(FND => new AuditFinding
                 {
                     FindingID = FND.FindingId,
                     Finding = FND.Title,
                     Details = FND.Details == null ? string.Empty : FND.Details,
                     FindingType = FND.FindingType.FindingType1,
                     CauseName = FND.SubCause.CauseName,
                     CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                     .Select(ISO => new ISOProcess
                     {
                         ISOProcessID = ISO.ISOProcessID,
                         name = ISO.Process
                     }).SingleOrDefault(),
                     Actions = FND.AuditActions.Select(ACT => new AuditActions
                     {
                         ActionID = ACT.AuditActionId,
                         ActionType = ACT.AuditActionType.Name,
                         Details = ACT.Details == null ? string.Empty : ACT.Details,
                         FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                         Actionee = (from T in _context.Titles
                                     join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                     from g in empgroup
                                     where g.EmployeeID == ACT.ActioneeId
                                     select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                         TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                         CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                         DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                         IsClosed = ACT.IsClosed,
                         Module = Modules.AuditAction

                     }).ToList()
                 }).ToList()

             }).ToList();

         
            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterByAuditStatus(string status, int year)
        {
            StringWriter strwriter = new StringWriter();

            var audits = _context.Audits
            .Where(AUDT => AUDT.AuditStatus.AuditStatus1 == status)
            .OrderBy(AUDT => AUDT.PlannedAuditDate)
            .Select(AUDT => new AuditRecord
            {
                 AuditID = AUDT.AuditId,
                 AuditNo = AUDT.AuditReference,
                 AuditName = AUDT.AuditTitle,
                 AuditType = AUDT.AuditType.AuditType1,
                 PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                 ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                 ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                 AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                 Mode = (RecordMode)AUDT.RecordModeID,
                 ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                 Scope = AUDT.Scope,
                 Summery = AUDT.Summery,
                 Comments = AUDT.Notes,
                 Completed = AUDT._Completed,
                 Project = AUDT.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(P => P.ProjectId == AUDT.ProjectID).ProjectName,
                 Supplier = AUDT.SupplierID.HasValue == false ? string.Empty : _context.Customers.Single(S => S.CustomerID == AUDT.SupplierID).CustomerName,
                 CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                 {
                     ISOProcessID = CHK.ISOProcessID,
                     name = CHK.ISOProcess.Process,
                     ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                     Status = RecordsStatus.ORIGINAL

                 }).ToList(),

                 Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                 {
                     ORGID = UNT.OrganizationUnit.UnitID,
                     name = UNT.OrganizationUnit.UnitName,
                     ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                     Country = UNT.OrganizationUnit.Country.CountryName,
                     Status = RecordsStatus.ORIGINAL
                 }).ToList(),

                 Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                 {
                     EmployeeID = AUDTR.EmployeeID,
                     NameFormat = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == AUDTR.EmployeeID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                 }).ToList(),

                 Findings = AUDT.Findings.Select(FND => new AuditFinding
                 {
                     FindingID = FND.FindingId,
                     Finding = FND.Title,
                     Details = FND.Details == null ? string.Empty : FND.Details,
                     FindingType = FND.FindingType.FindingType1,
                     CauseName = FND.SubCause.CauseName,
                     CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                     .Select(ISO => new ISOProcess
                     {
                         ISOProcessID = ISO.ISOProcessID,
                         name = ISO.Process
                     }).SingleOrDefault(),
                     Actions = FND.AuditActions.Select(ACT => new AuditActions
                     {
                         ActionID = ACT.AuditActionId,
                         ActionType = ACT.AuditActionType.Name,
                         Details = ACT.Details == null ? string.Empty : ACT.Details,
                         FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                         Actionee = (from T in _context.Titles
                                     join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                     from g in empgroup
                                     where g.EmployeeID == ACT.ActioneeId
                                     select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                         TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                         CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                         DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                         IsClosed = ACT.IsClosed,
                         Module = Modules.AuditAction

                     }).ToList()
                 }).ToList()

             }).ToList();


            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterByAuditByFindingRootCause(int causeID, int year)
        {
            StringWriter strwriter = new StringWriter();

            var audits = _context.Audits
            .Where(AUDT => AUDT.PlannedAuditDate.Year == year)
            .OrderBy(AUDT => AUDT.PlannedAuditDate)
            .Select(AUDT => new AuditRecord
            {
                AuditID = AUDT.AuditId,
                AuditNo = AUDT.AuditReference,
                AuditName = AUDT.AuditTitle,
                AuditType = AUDT.AuditType.AuditType1,
                PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                Mode = (RecordMode)AUDT.RecordModeID,
                ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                Scope = AUDT.Scope,
                Summery = AUDT.Summery,
                Comments = AUDT.Notes,
                Completed = AUDT._Completed,
                Project = AUDT.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(P => P.ProjectId == AUDT.ProjectID).ProjectName,
                Supplier = AUDT.SupplierID.HasValue == false ? string.Empty : _context.Customers.Single(S => S.CustomerID == AUDT.SupplierID).CustomerName,
                CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                {
                    ISOProcessID = CHK.ISOProcessID,
                    name = CHK.ISOProcess.Process,
                    ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                    Status = RecordsStatus.ORIGINAL

                }).ToList(),

                Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                {
                    ORGID = UNT.OrganizationUnit.UnitID,
                    name = UNT.OrganizationUnit.UnitName,
                    ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                    Country = UNT.OrganizationUnit.Country.CountryName,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),

                Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                {
                    EmployeeID = AUDTR.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == AUDTR.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),

                Findings = AUDT.Findings
                .Where(FND => FND.RootCauseID == causeID)
                .Select(FND => new AuditFinding
                {
                    FindingID = FND.FindingId,
                    Finding = FND.Title,
                    Details = FND.Details == null ? string.Empty : FND.Details,
                    FindingType = FND.FindingType.FindingType1,
                    CauseName = FND.SubCause.CauseName,
                    CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                    .Select(ISO => new ISOProcess
                    {
                        ISOProcessID = ISO.ISOProcessID,
                        name = ISO.Process
                    }).SingleOrDefault(),
                    Actions = FND.AuditActions.Select(ACT => new AuditActions
                    {
                        ActionID = ACT.AuditActionId,
                        ActionType = ACT.AuditActionType.Name,
                        Details = ACT.Details == null ? string.Empty : ACT.Details,
                        FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                        Actionee = (from T in _context.Titles
                                    join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                    from g in empgroup
                                    where g.EmployeeID == ACT.ActioneeId
                                    select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                        TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                        CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                        DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                        IsClosed = ACT.IsClosed,
                        Module = Modules.AuditAction

                    }).ToList()
                }).ToList()

            }).ToList();


            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterByAuditByFindingType(string type, int year)
        {
            StringWriter strwriter = new StringWriter();

            var audits = _context.Audits
            .Where(AUDT => AUDT.PlannedAuditDate.Year == year)
            .OrderBy(AUDT => AUDT.PlannedAuditDate)
            .Select(AUDT => new AuditRecord
            {
                AuditID = AUDT.AuditId,
                AuditNo = AUDT.AuditReference,
                AuditName = AUDT.AuditTitle,
                AuditType = AUDT.AuditType.AuditType1,
                PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                Mode = (RecordMode)AUDT.RecordModeID,
                ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                Scope = AUDT.Scope,
                Summery = AUDT.Summery,
                Comments = AUDT.Notes,
                Completed = AUDT._Completed,
                Project = AUDT.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(P => P.ProjectId == AUDT.ProjectID).ProjectName,
                Supplier = AUDT.SupplierID.HasValue == false ? string.Empty : _context.Customers.Single(S => S.CustomerID == AUDT.SupplierID).CustomerName,
                CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                {
                    ISOProcessID = CHK.ISOProcessID,
                    name = CHK.ISOProcess.Process,
                    ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                    Status = RecordsStatus.ORIGINAL

                }).ToList(),

                Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                {
                    ORGID = UNT.OrganizationUnit.UnitID,
                    name = UNT.OrganizationUnit.UnitName,
                    ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                    Country = UNT.OrganizationUnit.Country.CountryName,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),

                Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                {
                    EmployeeID = AUDTR.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == AUDTR.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),

                Findings = AUDT.Findings
                .Where(FND=>FND.FindingType.FindingType1==type)
                .Select(FND => new AuditFinding
                {
                    FindingID = FND.FindingId,
                    Finding = FND.Title,
                    Details = FND.Details == null ? string.Empty : FND.Details,
                    FindingType = FND.FindingType.FindingType1,
                    CauseName = FND.SubCause.CauseName,
                    CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                    .Select(ISO => new ISOProcess
                    {
                        ISOProcessID = ISO.ISOProcessID,
                        name = ISO.Process
                    }).SingleOrDefault(),
                    Actions = FND.AuditActions.Select(ACT => new AuditActions
                    {
                        ActionID = ACT.AuditActionId,
                        ActionType = ACT.AuditActionType.Name,
                        Details = ACT.Details == null ? string.Empty : ACT.Details,
                        FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                        Actionee = (from T in _context.Titles
                                    join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                    from g in empgroup
                                    where g.EmployeeID == ACT.ActioneeId
                                    select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                        TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                        CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                        DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                        IsClosed = ACT.IsClosed,
                        Module = Modules.AuditAction

                    }).ToList()
                }).ToList()

            }).ToList();


            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterAuditsByDate(string json)
        {
            StringWriter strwriter = new StringWriter();

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var audits = _context.Audits
                   .Where(AUDT => AUDT.PlannedAuditDate >= obj.StartDate && AUDT.PlannedAuditDate <= obj.EndDate)
                   .OrderBy(AUDT => AUDT.PlannedAuditDate)
                   .Select(AUDT => new AuditRecord
                   {
                       AuditID = AUDT.AuditId,
                       AuditNo = AUDT.AuditReference,
                       AuditName = AUDT.AuditTitle,
                       AuditType = AUDT.AuditType.AuditType1,
                       PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                       ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                       ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                       AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                       Mode = (RecordMode)AUDT.RecordModeID,
                       ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                       Scope = AUDT.Scope,
                       Summery = AUDT.Summery,
                       Comments = AUDT.Notes,
                       Completed = AUDT._Completed,
                       Project = AUDT.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(P => P.ProjectId == AUDT.ProjectID).ProjectName,
                       Supplier = AUDT.SupplierID.HasValue == false ? string.Empty : _context.Customers.Single(S => S.CustomerID == AUDT.SupplierID).CustomerName,
                       CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                       {
                           ISOProcessID = CHK.ISOProcessID,
                           name = CHK.ISOProcess.Process,
                           ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                           Status = RecordsStatus.ORIGINAL

                       }).ToList(),

                       Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                       {
                           ORGID = UNT.OrganizationUnit.UnitID,
                           name = UNT.OrganizationUnit.UnitName,
                           ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                           Country = UNT.OrganizationUnit.Country.CountryName,
                           Status = RecordsStatus.ORIGINAL
                       }).ToList(),

                       Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                       {
                           EmployeeID = AUDTR.EmployeeID,
                           NameFormat = (from T in _context.Titles
                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                         from g in empgroup
                                         where g.EmployeeID == AUDTR.EmployeeID
                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                       }).ToList(),

                       Findings = AUDT.Findings.Select(FND => new AuditFinding
                       {
                           FindingID = FND.FindingId,
                           Finding = FND.Title,
                           Details = FND.Details == null ? string.Empty : FND.Details,
                           FindingType = FND.FindingType.FindingType1,
                           CauseName = FND.SubCause.CauseName,
                           CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                           .Select(ISO => new ISOProcess
                           {
                               ISOProcessID = ISO.ISOProcessID,
                               name = ISO.Process
                           }).SingleOrDefault(),
                           Actions = FND.AuditActions.Select(ACT => new AuditActions
                           {
                               ActionID = ACT.AuditActionId,
                               ActionType = ACT.AuditActionType.Name,
                               Details = ACT.Details == null ? string.Empty : ACT.Details,
                               FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                               Actionee = (from T in _context.Titles
                                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                           from g in empgroup
                                           where g.EmployeeID == ACT.ActioneeId
                                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                               TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                               CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                               DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                               IsClosed = ACT.IsClosed,
                               Module = Modules.AuditAction

                           }).ToList()
                       }).ToList()

                   }).ToList();



            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterAuditsById(string json)
        {
            StringWriter strwriter = new StringWriter();

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            AuditRecord obj = jsonserializer.Deserialize<AuditRecord>(json);

            var audits = _context.Audits
                   .Where(AUDT => AUDT.AuditReference == obj.AuditNo)
                   .OrderBy(AUDT => AUDT.PlannedAuditDate)
                   .Select(AUDT => new AuditRecord
                   {
                       AuditID = AUDT.AuditId,
                       AuditNo = AUDT.AuditReference,
                       AuditName = AUDT.AuditTitle,
                       AuditType = AUDT.AuditType.AuditType1,
                       PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                       ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                       ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                       AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                       Mode = (RecordMode)AUDT.RecordModeID,
                       ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                       Scope = AUDT.Scope,
                       Summery = AUDT.Summery,
                       Comments = AUDT.Notes,
                       Completed = AUDT._Completed,
                       Project = AUDT.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(P => P.ProjectId == AUDT.ProjectID).ProjectName,
                       Supplier = AUDT.SupplierID.HasValue == false ? string.Empty : _context.Customers.Single(S => S.CustomerID == AUDT.SupplierID).CustomerName,
                       CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                       {
                           ISOProcessID = CHK.ISOProcessID,
                           name = CHK.ISOProcess.Process,
                           ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                           Status = RecordsStatus.ORIGINAL

                       }).ToList(),

                       Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                       {
                           ORGID = UNT.OrganizationUnit.UnitID,
                           name = UNT.OrganizationUnit.UnitName,
                           ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                           Country = UNT.OrganizationUnit.Country.CountryName,
                           Status = RecordsStatus.ORIGINAL
                       }).ToList(),

                       Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                       {
                           EmployeeID = AUDTR.EmployeeID,
                           NameFormat = (from T in _context.Titles
                                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                         from g in empgroup
                                         where g.EmployeeID == AUDTR.EmployeeID
                                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                       }).ToList(),

                       Findings = AUDT.Findings.Select(FND => new AuditFinding
                       {
                           FindingID = FND.FindingId,
                           Finding = FND.Title,
                           Details = FND.Details == null ? string.Empty : FND.Details,
                           FindingType = FND.FindingType.FindingType1,
                           CauseName = FND.SubCause.CauseName,
                           CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                           .Select(ISO => new ISOProcess
                           {
                               ISOProcessID = ISO.ISOProcessID,
                               name = ISO.Process
                           }).SingleOrDefault(),
                           Actions = FND.AuditActions.Select(ACT => new AuditActions
                           {
                               ActionID = ACT.AuditActionId,
                               ActionType = ACT.AuditActionType.Name,
                               Details = ACT.Details == null ? string.Empty : ACT.Details,
                               FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                               Actionee = (from T in _context.Titles
                                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                           from g in empgroup
                                           where g.EmployeeID == ACT.ActioneeId
                                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                               TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                               CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                               DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                               IsClosed = ACT.IsClosed,
                               Module = Modules.AuditAction

                           }).ToList()
                       }).ToList()

                   }).ToList();



            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod(EnableSession = true)]
        public string getAuditsByYear(int year)
        {            
            StringWriter strwriter = new StringWriter();
            var audits = _context.Audits
            .OrderBy(AUDT => AUDT.PlannedAuditDate)
            .Where(AUDT => AUDT.PlannedAuditDate.Year == year)
            .Select(AUDT => new AuditRecord
            {
                AuditID = AUDT.AuditId,
                AuditNo = AUDT.AuditReference,
                AuditName = AUDT.AuditTitle,
                AuditType = AUDT.AuditType.AuditType1,
                PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                Mode=(RecordMode)AUDT.RecordModeID,
                ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                Scope = AUDT.Scope,
                Summery = AUDT.Summery,
                Comments = AUDT.Notes,
                Completed = AUDT._Completed,
                Project=AUDT.ProjectID.HasValue==false?string.Empty:_context.ProjectInformations.Single(P=>P.ProjectId==AUDT.ProjectID).ProjectName,
                Supplier=AUDT.SupplierID.HasValue==false?string.Empty:_context.Customers.Single(S=>S.CustomerID==AUDT.SupplierID).CustomerName,
                CheckLists = AUDT.CheckLists.Select(CHK => new ISOProcess
                {
                    ISOProcessID = CHK.ISOProcessID,
                    name = CHK.ISOProcess.Process,
                    ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                    Status = RecordsStatus.ORIGINAL

                }).ToList(),

                Units = AUDT.RelatedAuditUnits.Select(UNT => new ORGUnit
                {
                    ORGID = UNT.OrganizationUnit.UnitID,
                    name = UNT.OrganizationUnit.UnitName,
                    ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                    Country = UNT.OrganizationUnit.Country.CountryName,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),

                Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                {
                    EmployeeID = AUDTR.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == AUDTR.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),

                AuditRecipients = AUDT.Recipients.Select(REC => new Employee
                {
                    EmployeeID = REC.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == REC.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),

                Findings = AUDT.Findings.Select(FND => new AuditFinding
                {
                    FindingID = FND.FindingId,
                    Finding = FND.Title,
                    Details = FND.Details == null ? string.Empty : FND.Details,
                    FindingType = FND.FindingType.FindingType1,
                    CauseName = FND.SubCause.CauseName,
                    CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                    .Select(ISO => new ISOProcess
                    {
                        ISOProcessID = ISO.ISOProcessID,
                        name = ISO.Process
                    }).SingleOrDefault(),
                    Actions = FND.AuditActions.Select(ACT => new AuditActions
                    {
                        ActionID = ACT.AuditActionId,
                        ActionType = ACT.AuditActionType.Name,
                        Details = ACT.Details == null ? string.Empty : ACT.Details,
                        FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                        Actionee = (from T in _context.Titles
                                    join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                    from g in empgroup
                                    where g.EmployeeID == ACT.ActioneeId
                                    select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                        TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                        CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                        DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                        IsClosed = ACT.IsClosed,
                        Module = Modules.AuditAction

                    }).ToList()
                }).ToList()

            }).ToList();

         
            var serializer = new XmlSerializer(typeof(List<AuditRecord>));

            serializer.Serialize(strwriter, audits);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadAudits()
        {
            StringWriter strwriter = new StringWriter();

            //default data should be between the range 01/01/current year and 31/12/current year
            DateTime start = new DateTime(DateTime.Now.Year, 1, 1);
            DateTime end = new DateTime(DateTime.Now.Year, 12, 31);

            try
            {
                var audits = _context.Audits
                .OrderBy(AUDT => AUDT.PlannedAuditDate)
                .Where(AUDT=>AUDT.PlannedAuditDate>=start && AUDT.PlannedAuditDate<=end)    
                .Select(AUDT => new AuditRecord
                {
                    AuditID = AUDT.AuditId,
                    AuditNo = AUDT.AuditReference,
                    AuditName=AUDT.AuditTitle,
                    AuditType = AUDT.AuditType.AuditType1,
                    PlannedAuditDate = ConvertToLocalTime(AUDT.PlannedAuditDate),
                    ActualAuditDate = AUDT.ActualAuditDate != null ? ConvertToLocalTime(AUDT.ActualAuditDate.Value) : AUDT.ActualAuditDate,
                    ActualCloseDate = AUDT.ActualCloseDate != null ? ConvertToLocalTime(AUDT.ActualCloseDate.Value) : AUDT.ActualCloseDate,
                    AuditStatusString = AUDT.AuditStatus.AuditStatus1,
                    ProcessDocument = AUDT.Document.Title == null ? string.Empty : AUDT.Document.Title,
                    Scope=AUDT.Scope,
                    Summery=AUDT.Summery,
                    Comments=AUDT.Notes,
                    Completed=AUDT._Completed,
                    Mode=(RecordMode)AUDT.RecordModeID,
                    CheckLists=AUDT.CheckLists.Select(CHK=>new ISOProcess
                    {
                        ISOProcessID = CHK.ISOProcessID,
                        name = CHK.ISOProcess.Process,
                        ISOStandard = CHK.ISOProcess.ISOStandard.ISOStandard1,
                        Status = RecordsStatus.ORIGINAL
                
                    }).ToList(),

                    Units=AUDT.RelatedAuditUnits.Select(UNT=>new ORGUnit
                    {
                        ORGID=UNT.OrganizationUnit.UnitID,
                        name=UNT.OrganizationUnit.UnitName,
                        ORGLevel=UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                        Country=UNT.OrganizationUnit.Country.CountryName,
                        Status = RecordsStatus.ORIGINAL
                    }).ToList(),

                    Auditors = AUDT.Auditors.Select(AUDTR => new Employee
                    {
                        EmployeeID = AUDTR.EmployeeID,
                        NameFormat = (from T in _context.Titles
                                      join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                      from g in empgroup
                                      where g.EmployeeID == AUDTR.EmployeeID
                                      select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                    }).ToList(),

                    Findings = AUDT.Findings.Select(FND => new AuditFinding
                    {
                        FindingID = FND.FindingId,
                        Finding = FND.Title,
                        Details = FND.Details == null ? string.Empty : FND.Details,
                        FindingType = FND.FindingType.FindingType1,
                        CauseName = FND.SubCause.CauseName,
                        CheckList = _context.ISOProcesses.Where(ISO => ISO.ISOProcessID == FND.ISOCheckID)
                        .Select(ISO => new ISOProcess
                        {
                            ISOProcessID = ISO.ISOProcessID,
                            name = ISO.Process
                        }).SingleOrDefault(),
                        Actions = FND.AuditActions.Select(ACT => new AuditActions
                        {
                            ActionID = ACT.AuditActionId,
                            ActionType = ACT.AuditActionType.Name,
                            Details = ACT.Details == null ? string.Empty : ACT.Details,
                            FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                            Actionee = (from T in _context.Titles
                                        join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                        from g in empgroup
                                        where g.EmployeeID == ACT.ActioneeId
                                        select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                            TargetClosingDate = ConvertToLocalTime(ACT.TargetClosingDate),
                            CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                            DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                            IsClosed = ACT.IsClosed,
                            Module = Modules.AuditAction

                        }).ToList()
                    }).ToList()

                }).ToList();

                var serializer = new XmlSerializer(typeof(List<AuditRecord>));

                serializer.Serialize(strwriter, audits);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return strwriter.ToString();
        }
        [WebMethod(EnableSession = true)]
        public string updateAudit(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AuditRecord obj = serializer.Deserialize<AuditRecord>(json);

            var audit = _context.Audits.Where(AUDT => AUDT.AuditReference == obj.AuditNo)
                .Select(AUDT => AUDT).SingleOrDefault();
            
            if (audit != null)
            {
                audit.AuditTypeId = _context.AuditTypes.Single(AUDTTYP => AUDTTYP.AuditType1 == obj.AuditType).AuditTypeId;
                audit.AuditTitle = obj.AuditName;
                audit.PlannedAuditDate = obj.PlannedAuditDate;
                audit.ActualAuditDate = obj.ActualAuditDate.HasValue == true ? obj.ActualAuditDate : null;
                audit.ProcessDocumentID = obj.ProcessDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.ProcessDocument).DocumentId;
                audit.AuditStatusID = _context.AuditStatus.Single(AUDTSTS => AUDTSTS.AuditStatus1 == obj.AuditStatusString).AuditStatusID;
                audit.Summery = obj.Summery == string.Empty ? null : obj.Summery;
                audit.Scope = obj.Scope == string.Empty ? null : obj.Scope;
                audit.Notes = obj.Comments == string.Empty ? null : obj.Comments;
                audit.ProjectID = obj.Project == string.Empty ? (int?)null : _context.ProjectInformations.Single(PROJ => PROJ.ProjectName == obj.Project).ProjectId;
                audit.SupplierID = obj.Supplier == string.Empty ? (int?)null : _context.Customers.Single(SUPP => SUPP.CustomerName == obj.Supplier).CustomerID;
                audit._Completed = obj.Completed;


                /*if the actual close date of the audit is set, then the system shall perform the following:
                * 1- Check if there are outstanding actions, then abort the update transaction. 
                * 2- If there are no outstanding actions, then, set the status of the audit to closed.
                */

                if (obj.ActualCloseDate != null)
                {
                    audit.ActualCloseDate = Convert.ToDateTime(obj.ActualCloseDate);

                    int outstandingactions = 0;
                    foreach (var finding in audit.Findings)
                    {
                        var findingactions = finding.AuditActions.Where(ACT => ACT.IsClosed == false).Select(ACT => ACT).ToList();
                        if (findingactions.Count > 0)
                        {
                            outstandingactions++;
                        }
                    }

                    if (outstandingactions > 0)
                    {
                        throw new Exception("The system cannot allow updating and closing the audit record, since there are outstanding actions which must be closed first");
                    }
                    else
                    {
                        audit.AuditStatusID = (int)AuditRecordStatus.Completed;
                    }
                    
                }
                else
                {

                    audit.ActualCloseDate = (DateTime?)null;
                }
                /*if the status of the audit record is completed or cancelled
                 * then, close all related actions, and send the audit record to archive
                 */ 

                switch ((AuditRecordStatus)audit.AuditStatusID)
                {
                    case AuditRecordStatus.Completed:
                    case AuditRecordStatus.Cancelled:
                        audit.RecordModeID = (int)RecordMode.Archived;

                        //close all audit actions

                        if (audit.Findings.Count > 0)
                        {
                            foreach (var finding in audit.Findings)
                            {
                                finding.AuditActions.ToList().ForEach(ACT => ACT.IsClosed = true);
                            }
                        }

                        break;
                    case AuditRecordStatus.InProgress:
                    case AuditRecordStatus.Pending:
                    case AuditRecordStatus.Rescheduled:
                    case AuditRecordStatus.Closing:
                        audit.RecordModeID = (int)RecordMode.Current;
                        break;
                }

                audit.ModifiedDate = DateTime.Now;
                audit.ModifiedBy = HttpContext.Current.User.Identity.Name;
         
                if (obj.CheckLists != null)
                {
                    CheckList list = null;
                        
                    foreach (var checklist in obj.CheckLists)
                    {
                        switch (checklist.Status)
                        {
                            case RecordsStatus.ADDED:
                                list = audit.CheckLists.Where(CHK => CHK.ISOProcessID == checklist.ISOProcessID).Select(CHK => CHK).SingleOrDefault();
                                
                                if (list == null)
                                {
                                    list = new CheckList();
                                    list.ISOProcessID = checklist.ISOProcessID;
                                    list.ModifiedDate = DateTime.Now;
                                    list.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                    audit.CheckLists.Add(list);
                                }
                                break;
                            case RecordsStatus.REMOVED:
                                list = audit.CheckLists.Where(CHK => CHK.ISOProcessID == checklist.ISOProcessID).Select(CHK => CHK).SingleOrDefault();
                                if (list != null)
                                {
                                    _context.CheckLists.DeleteOnSubmit(list);
                                }
                                break;
                        }
                    }
                }

                if (obj.Auditors != null)
                {
                    Auditor auditor = null;


                    foreach (var employee in obj.Auditors)
                    {
                        var employeeID = (from EMP in _context.Employees
                                          where EMP.FirstName == employee.NameFormat.Substring(employee.NameFormat.LastIndexOf(".") + 1, employee.NameFormat.IndexOf(" ") - 3) &&
                                          EMP.LastName == employee.NameFormat.Substring(employee.NameFormat.IndexOf(" ") + 1)
                                          select EMP.EmployeeID).SingleOrDefault();

                        switch (employee.Status)
                        {
                            case RecordsStatus.ADDED:
                                auditor = audit.Auditors.Where(AUDTR => AUDTR.EmployeeID == employeeID).Select(AUDTR => AUDTR).SingleOrDefault();
                                
                                //if (auditor == null)
                                //{
                                    auditor = new Auditor();
                                    auditor.EmployeeID = employeeID;
                                    auditor.ModifiedDate = DateTime.Now;
                                    auditor.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                    audit.Auditors.Add(auditor);
                                //}
                                break;
                            case RecordsStatus.REMOVED:
                                auditor = audit.Auditors.Where(AUDTR => AUDTR.EmployeeID == employeeID).Select(AUDTR => AUDTR).SingleOrDefault();
                                
                                if (auditor != null)
                                {
                                    _context.Auditors.DeleteOnSubmit(auditor);
                                }
                                break;
                        }
                       
                    }
                }

                if (obj.Units != null)
                {
                    //remove existing AuditUnits first
                    //removeAuditeeUnit(audit.AuditId);

                    RelatedAuditUnit relatedunit = null;
                    foreach (var unit in obj.Units)
                    {
                        switch (unit.Status)
                        {
                            case RecordsStatus.ADDED:
                                //relatedunit = audit.RelatedAuditUnits.Where(UNT => UNT.UnitID == unit.ORGID).Select(UNT => UNT).SingleOrDefault();
                                //if (relatedunit == null)
                                //{
                                    relatedunit = new RelatedAuditUnit();
                                    relatedunit.UnitID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == unit.name).UnitID;
                                    relatedunit.ModifiedDate = DateTime.Now;
                                    relatedunit.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                    audit.RelatedAuditUnits.Add(relatedunit);
                                //}
                                break;
                            case RecordsStatus.REMOVED:
                                relatedunit = audit.RelatedAuditUnits.Where(UNT => UNT.UnitID == unit.ORGID).FirstOrDefault();
                                if (relatedunit != null)
                                {
                                    _context.RelatedAuditUnits.DeleteOnSubmit(relatedunit);
                                }
                                break;
                        }
                      
                    }
                }

                

                EmailConfiguration automail = null;

                if (obj.Recipients != null)
                {
                    // generate automatic email notification for adding audit record
                    automail = new EmailConfiguration();
                    automail.Module = obj.Module;
                    automail.KeyValue = audit.AuditId;
                    automail.Action = "Update";

                    Recipient auditRecipient = null;
                    var query = audit.Recipients.Where(R => R.AuditID == audit.AuditId).Select(R => R.EmployeeID).ToList();
                    List<int> ids = new List<int>();

                    foreach (var recipient in obj.Recipients)
                    {
                        //add both the originator and the owner as a recipient
                        int employeeID = (from EMP in _context.Employees
                                          where EMP.FirstName == recipient.Employee.Substring(recipient.Employee.LastIndexOf(".") + 1, recipient.Employee.IndexOf(" ") - 3) &&
                                          EMP.LastName == recipient.Employee.Substring(recipient.Employee.IndexOf(" ") + 1)
                                          select EMP.EmployeeID).SingleOrDefault();
                        automail.Recipients.Add(employeeID);
                        ids.Add(employeeID);
                        auditRecipient = audit.Recipients.Where(R => R.EmployeeID == employeeID).Select(R => R).SingleOrDefault();
                        
                        if (auditRecipient == null)
                        {
                            Recipient rec = new Recipient();
                            rec.EmployeeID = employeeID;
                            rec.AuditID = audit.AuditId;
                            rec.ModifiedDate = DateTime.Now;
                            rec.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            audit.Recipients.Add(rec);
                        }

                        //automail.Recipients.Add(employeeID);

                        //auditRecipient = audit.Recipients.Where(R => R.EmployeeID == employeeID).Select(R => R).SingleOrDefault();
                        //if (auditRecipient != null)
                        //{
                        //    _context.Recipients.DeleteOnSubmit(auditRecipient);
                        //}

                        //Recipient rec = new Recipient();
                        //rec.EmployeeID = employeeID;
                        //rec.AuditID = audit.AuditId;
                        //rec.ModifiedDate = DateTime.Now;
                        //rec.ModifiedBy = HttpContext.Current.User.Identity.Name;
                        //audit.Recipients.Add(rec);



                    }
                    var deleteEmployee = query.Except(ids);

                    foreach(var del in deleteEmployee)
                    {
                        auditRecipient = audit.Recipients.Where(R => R.EmployeeID == del).SingleOrDefault();
                        _context.Recipients.DeleteOnSubmit(auditRecipient);
                    }

                }else
                {
                    var recipient = _context.Recipients.Where(r => r.AuditID == audit.AuditId);
                    _context.Recipients.DeleteAllOnSubmit(recipient);
                }

                _context.SubmitChanges();

                if (automail != null)
                {
                    //generate email request
                    bool sent = automail.GenerateEmail();
                    if (sent == true)
                    {
                        result = "Operation has been committed sucessfully, an auto generated mail has been sent to the corresponding employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                else
                {

                    result = "Operation has been committed sucessfully";
                }
            }

            return result;
        }

        [WebMethod]
        public string createAudit(string json)
        {
            string result = string.Empty;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            AuditRecord obj = serializer.Deserialize<AuditRecord>(json);

            var audit = _context.Audits.Where(AUDT => AUDT.AuditReference == obj.AuditNo).Select(AUDT => AUDT).SingleOrDefault();
            if (audit == null)
            {
                audit = new Audit();
                audit.AuditReference = obj.AuditNo;
                audit.AuditTitle = obj.AuditName;
                audit.AuditTypeId = _context.AuditTypes.Single(AUDTTYP => AUDTTYP.AuditType1 == obj.AuditType).AuditTypeId;
                audit.PlannedAuditDate = obj.PlannedAuditDate;
                audit.ProcessDocumentID = obj.ProcessDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.ProcessDocument).DocumentId;
                audit.Scope = obj.Scope == string.Empty ? null : obj.Scope;
                audit.ProjectID = obj.Project == string.Empty ? (int?)null : _context.ProjectInformations.Single(PROJ => PROJ.ProjectName == obj.Project).ProjectId;
                audit.SupplierID = obj.Supplier == string.Empty ? (int?)null : _context.Customers.Single(SUPP => SUPP.CustomerName == obj.Supplier).CustomerID;

                audit.AuditStatusID = (int)obj.AuditStatus;
                audit.RecordModeID = (int)obj.Mode;
                audit.ModifiedDate = DateTime.Now;
                audit.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.CheckLists != null)
                {
                    foreach (var checklist in obj.CheckLists)
                    {
                        CheckList list = new CheckList();
                        list.ISOProcessID = checklist.ISOProcessID;
                        list.ModifiedDate = DateTime.Now;
                        audit.CheckLists.Add(list);
                    }
                }

                if (obj.Auditors != null)
                {
                    foreach (var employee in obj.Auditors)
                    {

                        Auditor auditor = new Auditor();
                        auditor.EmployeeID = (from EMP in _context.Employees
                                              where EMP.FirstName == employee.NameFormat.Substring(employee.NameFormat.LastIndexOf(".") + 1, employee.NameFormat.IndexOf(" ") - 3) &&
                                              EMP.LastName == employee.NameFormat.Substring(employee.NameFormat.IndexOf(" ") + 1)
                                              select EMP.EmployeeID).SingleOrDefault();
                        auditor.ModifiedDate = DateTime.Now;
                        audit.Auditors.Add(auditor);
                    }
                }

                if (obj.Units != null)
                {
                    foreach (var unit in obj.Units)
                    {
                        if(unit.StatusInt != 4)
                        {
                            RelatedAuditUnit relatedunit = new RelatedAuditUnit();
                            relatedunit.UnitID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == unit.name).UnitID;
                            relatedunit.ModifiedDate = DateTime.Now;
                            audit.RelatedAuditUnits.Add(relatedunit);
                        }
                        
                    }
                }                

                EmailConfiguration automail = null;

                if (obj.Recipients != null)
                {
                    // generate automatic email notification for adding audit record
                    automail = new EmailConfiguration();
                    automail.Module = obj.Module;
                    automail.KeyValue = audit.AuditId;
                    automail.Action = "Add";
                    foreach (var recipient in obj.Recipients)
                    {
                        //add both the originator and the owner as a recipient
                        int employeeID = (from EMP in _context.Employees
                                          where EMP.FirstName == recipient.Employee.Substring(recipient.Employee.LastIndexOf(".") + 1, recipient.Employee.IndexOf(" ") - 3) &&
                                          EMP.LastName == recipient.Employee.Substring(recipient.Employee.IndexOf(" ") + 1)
                                          select EMP.EmployeeID).SingleOrDefault();
                        automail.Recipients.Add(employeeID);

                        Recipient rec = new Recipient();
                        rec.EmployeeID = employeeID;
                        rec.AuditID = audit.AuditId;
                        rec.ModifiedDate = DateTime.Now;
                        rec.ModifiedBy = HttpContext.Current.User.Identity.Name;
                        _context.Recipients.InsertOnSubmit(rec);
                        audit.Recipients.Add(rec);
                    }
                }

                _context.Audits.InsertOnSubmit(audit);
                _context.SubmitChanges();

                if (automail != null)
                {
                    try
                    {
                        bool isGenerated = automail.GenerateEmail();

                        if (isGenerated == true)
                        {
                            result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                        }
                        else
                        {
                            result = "Operation has been committed sucessfully";
                        }
                    }
                    catch (Exception ex)
                    {
                        result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                        result += "\n\n" + ex.Message;
                    }
                }
                else
                {
                    result = "Operation has been committed sucessfully";

                }
            }
            else
            {
                throw new Exception("Please enter a unique audit reference number");
            }

            return result;
        }
        #endregion
        #region Employee

        
        [WebMethod]
        public string[] getDepEmployees(string unit)
        {
            var employees = (from EMP in _context.fn_GetDepartmentEmployees(unit)
                             select EMP.EmployeeName).ToArray();
            return employees;
        }

        [WebMethod]
        public string[] getDepManagers(string unit)
        {
            var managers = (from EMP in _context.fn_GetDepartmentManagers(unit)
                             select EMP.EmployeeName).ToArray();
            return managers;
        }

        [WebMethod]
        public string[] getParentDepEmployees(string unit)
        {
            var employees = (from EMP in _context.fn_GetRootDepartmentEmployees(unit)
                             select EMP.EmployeeName).ToArray();
            return employees;
        }

        [WebMethod]
        public string getEmployeeEmail(string name)
        {
            string email = string.Empty;

            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == name.Substring(name.LastIndexOf(".") + 1, name.IndexOf(" ") - 3) &&
                              EMP.LastName == name.Substring(name.IndexOf(" ") + 1)
                              select EMP.EmployeeID).SingleOrDefault();

            var employee = _context.Employees.Where(EMP => EMP.EmployeeID == employeeID).Select(EMP => EMP).SingleOrDefault();
            if (employee != null)
            {
                email = employee.EmailAddress;
            }
            else
            {
                throw new Exception("Cannot find the related employee record");
            }

            return email;
        }


        [WebMethod]
        public string getLastPersonnelID()
        {
            string personnelID = null;

            if (_context.Employees.ToList().Count > 0)
            {
                int maxId = _context.Employees.Max(i => i.EmployeeID);
                personnelID = _context.Employees.Single(EMP => EMP.EmployeeID == maxId).PersonnelID;
            }
            return personnelID == null ? string.Empty : personnelID;
        }

        [WebMethod]
        public string getLastContractNo()
        {
            string contractID = null;
            if (_context.Contracts.ToList().Count > 0)
            {
                int maxID = _context.Contracts.Max(i => i.ContractID);
                contractID = _context.Contracts.Single(CONT => CONT.ContractID == maxID).ContractNo;    
            }
            return contractID == null ? string.Empty : contractID;
  
        }

        [WebMethod]
        public string getContractGroup(string name)
        {
            var group = _context.ContractGroups.Where(GRP => GRP.GroupName == name)
           .Select(GRP => new ContractGroup
           {
               GroupID = GRP.GroupID,
               GroupName = GRP.GroupName,
               Description = GRP.Description == null ? string.Empty : GRP.Description,
               Duration = GRP.Duration.HasValue == true ? Convert.ToInt32(GRP.Duration) : 0,
               Period = GRP.PeriodID.HasValue == true ? _context.Periods.Single(PRD => PRD.PeriodID == GRP.PeriodID).Period1 : string.Empty,
               IsConstraint = GRP.IsConstraint
           }).SingleOrDefault();

            if (group == null)
            {
                throw new Exception("Cannot find the related contract group record");
            }

            var xml = new XmlSerializer(typeof(ContractGroup));

            StringWriter str = new StringWriter();
            xml.Serialize(str, group);

            return str.ToString();

        }
        [WebMethod]
        public string loadContractGroup()
        {
            var groups = _context.ContractGroups
           .Select(GRP => new ContractGroup
           {
               GroupID = GRP.GroupID,
               GroupName = GRP.GroupName,
               Description = GRP.Description==null?string.Empty:GRP.Description,
               Duration = GRP.Duration.HasValue==true?Convert.ToInt32(GRP.Duration):0,
               Period = GRP.PeriodID.HasValue==true?_context.Periods.Single(PRD=>PRD.PeriodID==GRP.PeriodID).Period1:string.Empty,
               IsConstraint = GRP.IsConstraint
           }).ToList();

            var xml = new XmlSerializer(typeof(List<ContractGroup>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, groups);

            return str.ToString();

        }

        [WebMethod]
        public void removeContractGroup(int groupID)
        {
            var group = _context.ContractGroups.Where(GRP => GRP.GroupID == groupID)
                .Select(GRP => GRP).SingleOrDefault();

            if (group != null)
            {
                _context.ContractGroups.DeleteOnSubmit(group);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related contract group record");
            }
        }
        [WebMethod]
        public void createContractGroup(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ContractGroup obj = serializer.Deserialize<ContractGroup>(json);

            var group = _context.ContractGroups.Where(GRP => GRP.GroupName == obj.GroupName).Select(GRP => GRP).SingleOrDefault();
            if (group == null)
            {
                group = new LINQConnection.ContractGroup();
                group.GroupName = obj.GroupName;
                group.Description = obj.Description == string.Empty ? null : obj.Description;
                group.Duration = obj.Duration == 0 ? (int?)null : obj.Duration;
                group.PeriodID = obj.Period == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.Period).PeriodID;
                group.IsConstraint = obj.IsConstraint;
                group.ModifiedDate = DateTime.Now;
                group.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.ContractGroups.InsertOnSubmit(group);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the group already exists");
            }
        }
        [WebMethod]
        public void updateContractGroup(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ContractGroup obj = serializer.Deserialize<ContractGroup>(json);

            var group = _context.ContractGroups.Where(GRP => GRP.GroupID == obj.GroupID).Select(GRP => GRP).SingleOrDefault();
            if (group != null)
            {
                group.GroupName = obj.GroupName;
                group.Description = obj.Description == string.Empty ? null : obj.Description;
                group.Duration = obj.Duration == 0 ? (int?)null : obj.Duration;
                group.PeriodID = obj.Period == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.Period).PeriodID;
                group.IsConstraint = obj.IsConstraint;
                group.ModifiedDate = DateTime.Now;
                group.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related contract group record");
            }
        }
        [WebMethod]
        public string filterEmployeesByDateOfBirth(string json)
        {

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var employees = _context.Employees
            .Where(EMP => EMP.DateofBith >= obj.StartDate && EMP.DateofBith <= obj.EndDate)
            .Select(EMP => new Employee
            {
                EmployeeID = EMP.EmployeeID,
                PersonnelID = EMP.PersonnelID,
                Title = EMP.Title.Title1,
                FirstName = EMP.FirstName,
                MiddleName = EMP.MiddleName,
                LastName = EMP.LastName,
                CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                COB = EMP.Country.CountryName,
                DOB = ConvertToLocalTime(EMP.DateofBith),
                MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                Gender = EMP.Gender.Gender1,
                Religion = EMP.Religion.Religion1,
                EmailAddress = EMP.EmailAddress,
                Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                {
                    ContractID = CONT.ContractID,
                    ContractNo = CONT.ContractNo,
                    Group = CONT.ContractGroup.GroupName,
                    StartDate = ConvertToLocalTime(CONT.StartDate),
                    EndDate = ConvertToLocalTime(CONT.EndDate),
                    ExtendedToDate = CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                    TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                    TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                    Type = CONT.ContractType.ContractType1,
                    CStatus = (ContractStatus)CONT.ContractStatusID,
                    Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                    Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                    .Select(ASGN => new ContractAssignement
                    {
                        AssignmentID = ASGN.AssignmentID,
                        DOA = ASGN.DateofAssignment,
                        Position = ASGN.Position.Title
                    }).ToList()
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }
        [WebMethod]
        public string filterEmployeesByReligion(string religion)
        {
            var employees = _context.Employees
            .Where(EMP => EMP.Religion.Religion1 == religion)
             .Select(EMP => new Employee
             {
                 EmployeeID = EMP.EmployeeID,
                 PersonnelID = EMP.PersonnelID,
                 Title = EMP.Title.Title1,
                 FirstName = EMP.FirstName,
                 MiddleName = EMP.MiddleName,
                 LastName = EMP.LastName,
                 CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                 KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                 COB = EMP.Country.CountryName,
                 DOB = ConvertToLocalTime(EMP.DateofBith),
                 MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                 Gender = EMP.Gender.Gender1,
                 Religion = EMP.Religion.Religion1,
                 EmailAddress = EMP.EmailAddress,
                 Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                 Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                 {
                     ContractID = CONT.ContractID,
                     ContractNo = CONT.ContractNo,
                     Group = CONT.ContractGroup.GroupName,
                     StartDate = ConvertToLocalTime(CONT.StartDate),
                     EndDate = ConvertToLocalTime(CONT.EndDate),
                     ExtendedToDate = CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                     TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                     TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                     Type = CONT.ContractType.ContractType1,
                     CStatus = (ContractStatus)CONT.ContractStatusID,
                     Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                     Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                     .Select(ASGN => new ContractAssignement
                     {
                         AssignmentID = ASGN.AssignmentID,
                         DOA = ASGN.DateofAssignment,
                         Position = ASGN.Position.Title
                     }).ToList()
                 }).ToList()
             }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }
        [WebMethod]
        public string filterEmployeesByMaritalStatus(string status)
        {
            var employees = _context.Employees
            .Where(EMP => EMP.MaritalStatus.MaritalStatus1 == status)
             .Select(EMP => new Employee
             {
                 EmployeeID = EMP.EmployeeID,
                 PersonnelID = EMP.PersonnelID,
                 Title = EMP.Title.Title1,
                 FirstName = EMP.FirstName,
                 MiddleName = EMP.MiddleName,
                 LastName = EMP.LastName,
                 CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                 KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                 COB = EMP.Country.CountryName,
                 DOB = ConvertToLocalTime(EMP.DateofBith),
                 MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                 Gender = EMP.Gender.Gender1,
                 Religion = EMP.Religion.Religion1,
                 EmailAddress = EMP.EmailAddress,
                 Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                 Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                 {
                     ContractID = CONT.ContractID,
                     ContractNo = CONT.ContractNo,
                     Group = CONT.ContractGroup.GroupName,
                     StartDate = ConvertToLocalTime(CONT.StartDate),
                     EndDate = ConvertToLocalTime(CONT.EndDate),
                     ExtendedToDate = CONT.ExtendedToDate != null  ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                     TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                     TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                     Type = CONT.ContractType.ContractType1,
                     CStatus = (ContractStatus)CONT.ContractStatusID,
                     Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                     Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                     .Select(ASGN => new ContractAssignement
                     {
                         AssignmentID = ASGN.AssignmentID,
                         DOA = ASGN.DateofAssignment,
                         Position = ASGN.Position.Title
                     }).ToList()
                 }).ToList()
             }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }
        [WebMethod]
        public string filterEmployeesByGender(string gender)
        {
            var employees = _context.Employees
            .Where(EMP => EMP.Gender.Gender1==gender)
             .Select(EMP => new Employee
             {
                 EmployeeID = EMP.EmployeeID,
                 PersonnelID = EMP.PersonnelID,
                 Title = EMP.Title.Title1,
                 FirstName = EMP.FirstName,
                 MiddleName = EMP.MiddleName,
                 LastName = EMP.LastName,
                 CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                 KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                 COB = EMP.Country.CountryName,
                 DOB = ConvertToLocalTime(EMP.DateofBith),
                 MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                 Gender = EMP.Gender.Gender1,
                 Religion = EMP.Religion.Religion1,
                 EmailAddress = EMP.EmailAddress,
                 Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                 Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                 {
                     ContractID = CONT.ContractID,
                     ContractNo = CONT.ContractNo,
                     Group = CONT.ContractGroup.GroupName,
                     StartDate = ConvertToLocalTime(CONT.StartDate),
                     EndDate = ConvertToLocalTime(CONT.EndDate),
                     ExtendedToDate = CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                     TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                     TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                     Type = CONT.ContractType.ContractType1,
                     CStatus = (ContractStatus)CONT.ContractStatusID,
                     Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                     Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                     .Select(ASGN => new ContractAssignement
                     {
                         AssignmentID = ASGN.AssignmentID,
                         DOA = ASGN.DateofAssignment,
                         Position = ASGN.Position.Title
                     }).ToList()
                 }).ToList()
             }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }
        [WebMethod]
        public string filterEmployeesByLastName(string last)
        {
            var employees = _context.Employees
            .Where(EMP => EMP.LastName.StartsWith(last))
             .Select(EMP => new Employee
             {
                 EmployeeID = EMP.EmployeeID,
                 PersonnelID = EMP.PersonnelID,
                 Title = EMP.Title.Title1,
                 FirstName = EMP.FirstName,
                 MiddleName = EMP.MiddleName,
                 LastName = EMP.LastName,
                 CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                 KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                 COB = EMP.Country.CountryName,
                 DOB = ConvertToLocalTime(EMP.DateofBith),
                 MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                 Gender = EMP.Gender.Gender1,
                 Religion = EMP.Religion.Religion1,
                 EmailAddress = EMP.EmailAddress,
                 Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                 Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                 {
                     ContractID = CONT.ContractID,
                     ContractNo = CONT.ContractNo,
                     Group = CONT.ContractGroup.GroupName,
                     StartDate = ConvertToLocalTime(CONT.StartDate),
                     EndDate = ConvertToLocalTime(CONT.EndDate),
                     ExtendedToDate = CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                     TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                     TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                     Type = CONT.ContractType.ContractType1,
                     CStatus = (ContractStatus)CONT.ContractStatusID,
                     Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                     Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                     .Select(ASGN => new ContractAssignement
                     {
                         AssignmentID = ASGN.AssignmentID,
                         DOA = ASGN.DateofAssignment,
                         Position = ASGN.Position.Title
                     }).ToList()
                 }).ToList()
             }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }
        
        [WebMethod]
        public string filterEmployeesByFirstName(string first)
        {
            var employees = _context.Employees
            .Where(EMP=>EMP.FirstName.StartsWith(first))
             .Select(EMP => new Employee
             {
                 EmployeeID = EMP.EmployeeID,
                 PersonnelID = EMP.PersonnelID,
                 Title = EMP.Title.Title1,
                 FirstName = EMP.FirstName,
                 MiddleName = EMP.MiddleName,
                 LastName = EMP.LastName,
                 CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                 KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                 COB = EMP.Country.CountryName,
                 DOB = ConvertToLocalTime(EMP.DateofBith),
                 MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                 Gender = EMP.Gender.Gender1,
                 Religion = EMP.Religion.Religion1,
                 EmailAddress = EMP.EmailAddress,
                 Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                 Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                 {
                     ContractID = CONT.ContractID,
                     ContractNo = CONT.ContractNo,
                     Group = CONT.ContractGroup.GroupName,
                     StartDate = ConvertToLocalTime(CONT.StartDate),
                     EndDate = ConvertToLocalTime(CONT.EndDate),
                     ExtendedToDate = CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                     TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                     TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                     Type = CONT.ContractType.ContractType1,
                     CStatus = (ContractStatus)CONT.ContractStatusID,
                     Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                     Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                     .Select(ASGN => new ContractAssignement
                     {
                         AssignmentID = ASGN.AssignmentID,
                         DOA = ASGN.DateofAssignment,
                         Position = ASGN.Position.Title
                     }).ToList()
                 }).ToList()
             }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }

        [WebMethod]
        public string filterEmployeesByOrganization(string unit)
        {
            var employees = _context.Employees
            .Where(EMP => EMP.Contracts.Where(CONT=>CONT.ActiveFlag==true).SingleOrDefault().OrganizationAssignments.Where(A=>A.ActiveFlag==true).SingleOrDefault().Position.OrganizationUnit.UnitName==unit)
            .Select(EMP => new Employee
            {
                 EmployeeID = EMP.EmployeeID,
                 PersonnelID = EMP.PersonnelID,
                 Title = EMP.Title.Title1,
                 FirstName = EMP.FirstName,
                 MiddleName = EMP.MiddleName,
                 LastName = EMP.LastName,
                 CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                 KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                 COB = EMP.Country.CountryName,
                 DOB = ConvertToLocalTime(EMP.DateofBith),
                 MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                 Gender = EMP.Gender.Gender1,
                 Religion = EMP.Religion.Religion1,
                 EmailAddress = EMP.EmailAddress,
                 Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                 Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                 {
                     ContractID = CONT.ContractID,
                     ContractNo = CONT.ContractNo,
                     Group = CONT.ContractGroup.GroupName,
                     StartDate = ConvertToLocalTime(CONT.StartDate),
                     EndDate = ConvertToLocalTime(CONT.EndDate),
                     ExtendedToDate = CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                     TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                     TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                     Type = CONT.ContractType.ContractType1,
                     CStatus = (ContractStatus)CONT.ContractStatusID,
                     Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                     Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                     .Select(ASGN => new ContractAssignement
                     {
                         AssignmentID = ASGN.AssignmentID,
                         DOA = ASGN.DateofAssignment,
                         Position = ASGN.Position.Title
                     }).ToList()
                 }).ToList()
             }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }

        [WebMethod]
        public string getEmployeeByPersonnelID(string personnelID)
        {
            var employee = _context.Employees.Where(EMP => EMP.PersonnelID == personnelID)
            .Select(EMP => new Employee
            {
                EmployeeID = EMP.EmployeeID,
                PersonnelID = EMP.PersonnelID,
                Title = EMP.Title.Title1,
                FirstName = EMP.FirstName,
                MiddleName = EMP.MiddleName,
                LastName = EMP.LastName,
                CompleteName = EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(),
                KnownAs = EMP.KnownAs == null ? string.Empty : EMP.KnownAs,
                COB = EMP.Country.CountryName,
                DOB = ConvertToLocalTime(EMP.DateofBith),
                MaritalStatus = EMP.MaritalStatus.MaritalStatus1,
                Gender = EMP.Gender.Gender1,
                Religion = EMP.Religion.Religion1,
                EmailAddress = EMP.EmailAddress,
                Remarks = EMP.Remarks == null ? string.Empty : EMP.Remarks,
                Address = EMP.Addresses.Select(ADDR => new Address
                {
                    AddressID = ADDR.AddressID,
                    AddressLine1 = ADDR.AddressLine1,
                    AddressLine2 = ADDR.AddressLine2 == null ? string.Empty : ADDR.AddressLine2,
                    //City = ADDR.City,
                    //City =_context.Cities.Single(CTY => CTY.CityID == ADDR.CityID).CityName,
                    Country = _context.Countries.Single(CNTR => CNTR.CountryID == ADDR.CountryID).CountryName,
                    CountryID = ADDR.CountryID == null ? 0 : Convert.ToInt32(ADDR.CountryID),
                    StateID = ADDR.StateID == null ? 0 : Convert.ToInt32(ADDR.StateID),
                    City = _context.Cities.Single(CTY => CTY.CityID == ADDR.CityID).CityName,
                    CityID = ADDR.CityID == null ? 0 : Convert.ToInt32(ADDR.CityID),
                    PostalCode = ADDR.PostalCode == null ? string.Empty : ADDR.PostalCode,
                    Contacts=ADDR.ContactDetails.Select(C=>new Contact
                    {
                        ContactID=C.ContactID,
                        Number=C.ContactNumber,
                        Type=C.PhoneNumberType.Name,
                        Status=RecordsStatus.ORIGINAL
                    }).ToList()
                }).ToList(),
                Education=EMP.Educations.Select(EDU=>new Education
                {
                    EducationID=EDU.EducationID,
                    Degree=EDU.EducationDegree.DegreeTitle,
                    AwardTitle=EDU.AwardTitle,
                    StudyMode=EDU.StudyMode.StudyMode1,
                    Institute=EDU.Institute,
                    StartDate=EDU.StartDate,
                    EndDate=EDU.EndDate,
                    Faculty=EDU.Faculty,
                    Department=EDU.Department,
                    GradeSystem=EDU.GradeSystem.Grade,
                    Score=EDU.GradeScore,
                    Country=EDU.Country.CountryName,
                    CountryID = EDU.CountryID == null ? 0 : Convert.ToInt32(EDU.CountryID),
                    StateID = EDU.StateID == null ? 0 : Convert.ToInt32(EDU.StateID),
                    CityID = EDU.CityID == null ? 0 : Convert.ToInt32(EDU.CityID),
                    City = _context.Cities.Single(CTY => CTY.CityID == EDU.CityID).CityName
                }).ToList(),
                ResidenceDoc=EMP.ResidencePermits.Select(RES=>new ResidenceDocument
                {
                    PermitID=RES.PermitID,
                    DocumentNo=RES.DocumentID,
                    ValidFrom=RES.ValidFrom,
                    ValidTo=RES.ValidTo,
                    DocumentType=RES.ResidencePermitType.PermitType,
                    DocumentStatus=RES.ResidencePermitStatus.ResidencePermitStatus1
                }).ToList(),
                Contracts = EMP.Contracts.OrderBy(CONT => CONT.StartDate).Select(CONT => new Contract
                {
                    ContractID = CONT.ContractID,
                    ContractNo = CONT.ContractNo,
                    Group = CONT.ContractGroup.GroupName,
                    StartDate = ConvertToLocalTime(CONT.StartDate),
                    EndDate = ConvertToLocalTime(CONT.EndDate),
                    ExtendedToDate = CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                    TerminationDate = CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                    TermenationReason = CONT.ReasonForTermination == null ? string.Empty : CONT.ReasonForTermination,
                    Type = CONT.ContractType.ContractType1,
                    CStatus = (ContractStatus)CONT.ContractStatusID,
                    Remarks = CONT.Remarks == null ? string.Empty : CONT.Remarks,
                    Assignement = CONT.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true)
                    .Select(ASGN => new ContractAssignement
                    {
                        AssignmentID = ASGN.AssignmentID,
                        DOA = ASGN.DateofAssignment,
                        Position = ASGN.Position.Title
                    }).ToList()
                }).ToList()
            }).SingleOrDefault();

            if (employee == null)
            {
                throw new Exception("Cannot find the related employee record");
            }
            
            var xml = new XmlSerializer(typeof(Employee));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employee);

            return str.ToString();
        }
        [WebMethod]
        public string getEmployees()
        {
           var employees = _context.Employees
           .Select(EMP => new Employee
           {
                EmployeeID=EMP.EmployeeID,
                PersonnelID=EMP.PersonnelID,
                Title=EMP.Title.Title1,
                FirstName=EMP.FirstName,
                MiddleName=EMP.MiddleName,
                LastName=EMP.LastName,
                CompleteName=EMP.Title.Title1.Trim() + "." + EMP.LastName.Trim() + ", " + EMP.FirstName.Trim() + " " + EMP.MiddleName.Trim(), 
                KnownAs=EMP.KnownAs==null?string.Empty:EMP.KnownAs,
                COB=EMP.Country.CountryName,
                DOB=ConvertToLocalTime(EMP.DateofBith),
                MaritalStatus=EMP.MaritalStatus.MaritalStatus1,
                Gender=EMP.Gender.Gender1,
                Religion=EMP.Religion.Religion1,
                EmailAddress=EMP.EmailAddress,
                Remarks=EMP.Remarks==null?string.Empty:EMP.Remarks,
                Contracts=EMP.Contracts.OrderBy(CONT=>CONT.StartDate).Select(CONT=>new Contract
                {
                    ContractID=CONT.ContractID,
                    ContractNo=CONT.ContractNo,
                    Group=CONT.ContractGroup.GroupName,
                    StartDate=ConvertToLocalTime(CONT.StartDate),
                    EndDate=ConvertToLocalTime(CONT.EndDate),
                    ExtendedToDate=CONT.ExtendedToDate != null ? ConvertToLocalTime(CONT.ExtendedToDate.Value) : CONT.ExtendedToDate,
                    TerminationDate=CONT.TerminationDate != null ? ConvertToLocalTime(CONT.TerminationDate.Value) : CONT.TerminationDate,
                    TermenationReason=CONT.ReasonForTermination==null?string.Empty:CONT.ReasonForTermination,
                    Type=CONT.ContractType.ContractType1,
                    CStatus = (ContractStatus)CONT.ContractStatusID,
                    Remarks=CONT.Remarks==null?string.Empty:CONT.Remarks,
                    Assignement=CONT.OrganizationAssignments.Where(ASGN=>ASGN.ActiveFlag==true)
                    .Select(ASGN=>new ContractAssignement
                    {
                        AssignmentID=ASGN.AssignmentID,
                        DOA=ASGN.DateofAssignment,
                        Position=ASGN.Position.Title
                    }).ToList()
                }).ToList()
           }).ToList();

            var xml = new XmlSerializer(typeof(List<Employee>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, employees);

            return str.ToString();

        }
        [WebMethod]
        public void updateEmployee(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Employee obj = serializer.Deserialize<Employee>(json);

            var employee = _context.Employees.Where(EMP => EMP.PersonnelID == obj.PersonnelID).Select(EMP => EMP).SingleOrDefault();
            if (employee != null)
            {
                employee.TitleID = _context.Titles.Single(T => T.Title1 == obj.Title).TitleID;
                employee.FirstName = obj.FirstName.Trim();
                employee.MiddleName = obj.MiddleName.Trim();
                employee.LastName = obj.LastName.Trim();
                employee.KnownAs = obj.KnownAs == string.Empty ? null : obj.KnownAs;
                employee.DateofBith = obj.DOB;
                employee.GenderID = _context.Genders.Single(G => G.Gender1 == obj.Gender).GenderID;
                employee.MaritalStatusID = _context.MaritalStatus.Single(MS => MS.MaritalStatus1 == obj.MaritalStatus).MaritalStatusID;
                employee.ReligionID = _context.Religions.Single(RL => RL.Religion1 == obj.Religion).ReligionID;
                employee.CountryBirthID = _context.Countries.Single(C => C.CountryName == obj.COB).CountryID;
                employee.EmailAddress = obj.EmailAddress;
                employee.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
                employee.ModifiedDate = DateTime.Now;
                employee.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.EMPImg != string.Empty)
                {
                    try
                    {
                        employee.ProfileImg = File.ReadAllBytes(obj.EMPImg);
                    }
                    finally
                    {
                        File.Delete(obj.EMPImg);
                    }
                }
                if (obj.Contracts != null)
                {
                    foreach (var c in obj.Contracts)
                    {
                        var contract = employee.Contracts.Where(CONT => CONT.ContractNo == c.ContractNo).Select(CONT => CONT).SingleOrDefault();

                        contract.ContractNo = c.ContractNo;
                        contract.StartDate = c.StartDate;
                        contract.EndDate = c.EndDate;
                        contract.GroupID = _context.ContractGroups.Single(G => G.GroupName == c.Group).GroupID;
                        contract.ContractTypeID = _context.ContractTypes.Single(CT => CT.ContractType1 == c.Type).ContractTypeID;
                        contract.ContractStatusID = (int)c.CStatus;
                        contract.Remarks = c.Remarks;
                        contract.ModifiedDate = DateTime.Now;
                        contract.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        if (c.Assignement != null)
                        {
                            foreach (var a in c.Assignement)
                            {
                                var assignment = contract.OrganizationAssignments.Where(ASGN => ASGN.ActiveFlag == true).Select(ASGN => ASGN).SingleOrDefault();
                                  
                                //check if the position has changed
                                if (assignment.Position.Title != a.Position)
                                {
                                    //check if the position has been filled already
                                    var position = _context.Positions.Where(POS => POS.Title == a.Position).Select(POS => POS).SingleOrDefault();
                                    if (position.PositionStatusID == (int)PositionStatus.FILLED)
                                    {

                                        throw new Exception("The position is already filled");
                                    }
                                    else
                                    {
                                        //set old position to vacant
                                        // _context.Positions.Single(P => P.Title == assignment.Position.Title).PositionStatusID = (int)PositionStatus.VACANT;

                                        //assignment.PositionID = position.PositionID; //_context.Positions.SingleOrDefault(P => P.Title == a.Position).PositionID;
                                        var positionID = _context.Positions.Single(P => P.Title == a.Position).PositionID;
                                        assignment.Position = _context.Positions.Single(P => P.PositionID == positionID);
                                        assignment.DateofAssignment = a.DOA;
                                        assignment.ModifiedDate = DateTime.Now;
                                        assignment.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                        //update new position status to filled
                                        //Setting Status to Filled should be manual since there are positions that allows more than 1 employee
                                        //_context.Positions.Single(P => P.Title == a.Position).PositionStatusID = (int)PositionStatus.FILLED;
                                    }
                                }
                                else
                                {
                                    assignment.DateofAssignment = a.DOA;
                                    assignment.ModifiedDate = DateTime.Now;
                                    assignment.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                }
                            }
                        }
                    }
                }

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related employee record");
            }
        }
        [WebMethod]
        public void removeEmployee(int employeeID)
        {
            var employee = _context.Employees.Where(EMP => EMP.EmployeeID == employeeID).Select(EMP => EMP).SingleOrDefault();
            if(employee!=null)
            {
                if(employee.ChangeControlNotes.Count>0 || employee.ChangeControlNotes1.Count>0 || employee.ChangeControlApprovalMembers.Count>0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more document change request, or document change approval records");
                }
                else if(employee.Problems.Count>0 || employee.Problems1.Count>0 || employee.Problems2.Count>0 || employee.ProblemActions.Count>0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more problem management, or problem action records");           
                }
                else if(employee.TrainingCourses.Count>0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more training course records");           
                }
                else if(employee.TrainingCourseSchedules.Count>0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more training course schedule records");           
                }
                else if(employee.TrainingCourseEnrollments.Count>0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more training course enrollment records");        
                }
                else if(employee.Auditors.Count>0 || employee.AuditActions.Count>0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more training course enrollment records");
                }
                else if (employee.Assets.Count > 0 || employee.Assets1.Count > 0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more asset management records");
                }
                else if (employee.ManagementRepresentatives.Count > 0 || employee.Tasks.Count > 0 || employee.ReviewActions.Count > 0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more management reviews, tasks, or action records");
                }
                else if (employee.Risks.Count > 0)
                {
                    throw new Exception("Cannot remove the related employee record, since it is associated with one or more risk records");
                }
                else
                {
                    _context.Employees.DeleteOnSubmit(employee);
                    _context.SubmitChanges();
                }
            }
            else
            {
                throw new Exception("Cannot find the related employee record");
            }
        }
        [WebMethod]
        public string createNewEmployee(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Employee obj = serializer.Deserialize<Employee>(json);

            var employee = _context.Employees.Where(EMP => EMP.PersonnelID == obj.PersonnelID).Select(EMP => EMP).SingleOrDefault();
            if (employee == null)
            {
                employee = _context.Employees.Where(EMP => EMP.FirstName == obj.FirstName && EMP.LastName == obj.LastName)
                     .Select(EMP => EMP).SingleOrDefault();
                if (employee == null)
                {
                    employee = new LINQConnection.Employee();
                    employee.PersonnelID = obj.PersonnelID;
                    employee.TitleID = _context.Titles.Single(T => T.Title1 == obj.Title).TitleID;
                    employee.FirstName = obj.FirstName.Trim();
                    employee.MiddleName = obj.MiddleName.Trim();
                    employee.LastName = obj.LastName.Trim();
                    employee.KnownAs = obj.KnownAs == string.Empty ? null : obj.KnownAs;
                    employee.DateofBith = obj.DOB;
                    employee.GenderID = _context.Genders.Single(G => G.Gender1 == obj.Gender).GenderID;
                    employee.MaritalStatusID = _context.MaritalStatus.Single(MS => MS.MaritalStatus1 == obj.MaritalStatus).MaritalStatusID;
                    employee.ReligionID = _context.Religions.Single(RL => RL.Religion1 == obj.Religion).ReligionID;
                    employee.CountryBirthID = _context.Countries.Single(C => C.CountryName == obj.COB).CountryID;
                    employee.EmailAddress = obj.EmailAddress;
                    employee.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
                    employee.ModifiedDate = DateTime.Now;
                    employee.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    //Add employee address record*/
                    if (obj.Address != null)
                    {
                        foreach (var addr in obj.Address)
                        {
                            LINQConnection.Address address = new LINQConnection.Address();
                            address.AddressLine1 = addr.AddressLine1;
                            address.AddressLine2 = addr.AddressLine2 == string.Empty ? null : addr.AddressLine2;
                            address.City = addr.City;
                            address.CountryID = addr.CountryID;
                            if (address.CountryID == 1 || address.CountryID == 2 || address.CountryID == 95)
                            {
                                address.StateID = addr.StateID;
                            }
                            else
                            {
                                address.StateID = null;
                            }
                            address.CityID = addr.CityID;
                            address.PostalCode = addr.PostalCode == string.Empty ? null : addr.PostalCode;
                            address.ModifiedDate = DateTime.Now;
                            address.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            if (addr.Contacts != null)
                            {
                                foreach (var cont in addr.Contacts)
                                {
                                    ContactDetail contdtl = new ContactDetail();
                                    contdtl.ContactNumber = cont.Number;
                                    contdtl.ContactTypeID = _context.PhoneNumberTypes.Single(TYP => TYP.Name == cont.Type).PhoneNumberTypeId;
                                    contdtl.ModifiedDate = DateTime.Now;
                                    contdtl.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                    address.ContactDetails.Add(contdtl);
                                }
                            }
                            employee.Addresses.Add(address);
                        }
                    }
                    //Add employee nationality record*/

                    if (obj.Nationalities != null)
                    {
                        foreach (var n in obj.Nationalities)
                        {
                            EmployeeCitizenship nationality = new EmployeeCitizenship();
                            nationality.PassportNo = n.PassportNo;
                            nationality.IssueDate = n.IssueDate;
                            nationality.ExpiryDate = n.ExpiryDate;
                            nationality.NationalityID = _context.Countries.Single(NAT => NAT.CountryName == n.Authority).CountryID;
                            nationality.ModifiedDate = DateTime.Now;
                            nationality.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            employee.EmployeeCitizenships.Add(nationality);
                        }
                    }

                    //Add employee residence information record//
                    if (obj.ResidenceDoc != null)
                    {
                        foreach (var res in obj.ResidenceDoc)
                        {
                            ResidencePermit residence = new ResidencePermit();
                            residence.DocumentID = res.DocumentNo;
                            residence.ResidenceTypeID = _context.ResidencePermitTypes.Single(TYP => TYP.PermitType == res.DocumentType).PermitTypeID;
                            residence.ResidenceStatusID = _context.ResidencePermitStatus.Single(STS => STS.ResidencePermitStatus1 == res.DocumentStatus).PermitStatusID;
                            residence.ValidFrom = res.ValidFrom;
                            residence.ValidTo = res.ValidTo;
                            residence.ModifiedDate = DateTime.Now;
                            residence.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            employee.ResidencePermits.Add(residence);
                        }
                    }

                    if (obj.Contracts != null)
                    {
                        foreach (var c in obj.Contracts)
                        {
                            LINQConnection.Contract cont = new LINQConnection.Contract();
                            cont.ContractNo = c.ContractNo;
                            cont.StartDate = c.StartDate;
                            cont.EndDate = c.EndDate;
                            cont.GroupID = _context.ContractGroups.Single(G => G.GroupName == c.Group).GroupID;
                            cont.ContractTypeID = _context.ContractTypes.Single(CT => CT.ContractType1 == c.Type).ContractTypeID;
                            cont.ContractStatusID = (int)c.CStatus;
                            cont.Remarks = c.Remarks;
                            cont.ModifiedDate = DateTime.Now;
                            cont.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            if (c.Assignement != null)
                            {
                                foreach (var a in c.Assignement)
                                {
                                    //check if the position has been filled already//
                                    var position = _context.Positions.Where(POS => POS.Title == a.Position).Select(POS => POS).SingleOrDefault();
                                    if (position.PositionStatusID == (int)PositionStatus.FILLED)
                                    {
                                        throw new Exception("The position has been already filled");
                                    }
                                    else
                                    {
                                        LINQConnection.OrganizationAssignment assignement = new OrganizationAssignment();
                                        assignement.PositionID = _context.Positions.Single(P => P.Title == a.Position).PositionID;
                                        assignement.DateofAssignment = a.DOA;
                                        assignement.ActiveFlag = true;
                                        assignement.ModifiedDate = DateTime.Now;
                                        assignement.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                        //update position status to filled
                                        //_context.Positions.Single(P => P.Title == a.Position).PositionStatusID = (int)PositionStatus.FILLED;

                                        cont.OrganizationAssignments.Add(assignement);
                                    }
                                }
                            }
                            employee.Contracts.Add(cont);
                        }
                    }

                    _context.Employees.InsertOnSubmit(employee);
                    _context.SubmitChanges();

                    result = "Operation has been committed sucessfully";
                }
                else
                {
                    throw new Exception("The name of the employee already exists");
                }
            }
            else
            {
                throw new Exception("Please enter a unique personnel ID");
            }

            return result;
        }
        [WebMethod]
        public void updateEmployeeAddress(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Address obj = serializer.Deserialize<Address>(json);

            var address = _context.Addresses.Where(ADDR => ADDR.AddressID == obj.AddressID).Select(ADDR => ADDR).SingleOrDefault();
            if (address != null)
            {
                address.AddressLine1 = obj.AddressLine1;
                address.AddressLine2 = obj.AddressLine2 == string.Empty ? null : obj.AddressLine2;
                address.City = obj.City;
                //address.CountryID = _context.Countries.Single(C => C.CountryName == obj.Country).CountryID;
                address.CountryID = obj.CountryID;
                if (address.CountryID == 1 || address.CountryID == 2 || address.CountryID == 95)
                {
                    address.StateID = obj.StateID;
                }
                else
                {
                    address.StateID = null;
                }
                address.CityID = obj.CityID;
                address.PostalCode = obj.PostalCode == string.Empty ? null : obj.PostalCode;
                address.ModifiedDate = DateTime.Now;
                address.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.Contacts != null)
                {
                    LINQConnection.ContactDetail contact;
                    foreach (var cont in obj.Contacts)
                    {
                        switch (cont.Status)
                        {
                            case RecordsStatus.ADDED:

                                contact = new LINQConnection.ContactDetail();
                                contact.ContactNumber = cont.Number;
                                contact.ContactTypeID = _context.PhoneNumberTypes.Single(PH => PH.Name == cont.Type).PhoneNumberTypeId;
                                contact.ModifiedDate = DateTime.Now;
                                contact.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                address.ContactDetails.Add(contact);

                                break;
                            case RecordsStatus.MODIFIED:
                                contact = _context.ContactDetails.Where(CONT => CONT.ContactID == cont.ContactID)
                                    .Select(CONT => CONT).SingleOrDefault();

                                contact.ContactNumber = cont.Number;
                                contact.ContactTypeID = _context.PhoneNumberTypes.Single(PH => PH.Name == cont.Type).PhoneNumberTypeId;
                                contact.ModifiedDate = DateTime.Now;
                                contact.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                break;
                            case RecordsStatus.REMOVED:
                                contact = _context.ContactDetails.Where(CONT => CONT.ContactID == cont.ContactID)
                                  .Select(CONT => CONT).SingleOrDefault();

                                _context.ContactDetails.DeleteOnSubmit(contact);
                                break;
                        }
                    }
                }
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related employee address record");
            }
        }

        [WebMethod]
        public void createNewResidence(string json, string personnelID)
        {

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ResidenceDocument obj = serializer.Deserialize<ResidenceDocument>(json);

            var employee = _context.Employees.Where(EMP => EMP.PersonnelID == personnelID).Select(EMP => EMP).SingleOrDefault();
            if (employee != null)
            {

                var existing = employee.ResidencePermits.Where(P => P.ValidFrom <= obj.ValidFrom).Select(P => P).ToList();
                foreach (var residence in existing)
                {
                    if ((obj.ValidFrom < residence.ValidTo && residence.ValidTo >= obj.ValidTo) || (obj.ValidFrom < residence.ValidTo && residence.ValidTo <= obj.ValidTo))
                    {
                        throw new Exception("The new residence validity date range should not overlap with any existing residence permit records");
                    }
                }

                existing = employee.ResidencePermits.Where(P => P.ValidFrom >= obj.ValidFrom).Select(P => P).ToList();
                foreach (var residence in existing)
                {
                    if (residence.ValidTo >= obj.ValidTo && residence.ValidFrom <=obj.ValidTo)
                    {
                        throw new Exception("The new residence validity date range should not overlap with any existing residence permit records");
                    }
                }

                LINQConnection.ResidencePermit permit = new LINQConnection.ResidencePermit();
                permit.DocumentID = obj.DocumentNo;
                permit.ValidFrom = obj.ValidFrom;
                permit.ValidTo = obj.ValidTo;
                permit.ResidenceTypeID = _context.ResidencePermitTypes.Single(PRMTYP => PRMTYP.PermitType == obj.DocumentType).PermitTypeID;
                permit.ResidenceStatusID = _context.ResidencePermitStatus.Single(PRMSTS => PRMSTS.ResidencePermitStatus1 == obj.DocumentStatus).PermitStatusID;
                permit.ModifiedDate = DateTime.Now;
                permit.ModifiedBy = HttpContext.Current.User.Identity.Name;

                employee.ResidencePermits.Add(permit);

                _context.SubmitChanges();
           
            }
            else
            {
                throw new Exception("Cannot find the related employee record");
            }

        }

        [WebMethod]
        public void updateResidence(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ResidenceDocument obj = serializer.Deserialize<ResidenceDocument>(json);

            var residence = _context.ResidencePermits.Where(P => P.PermitID == obj.PermitID).Select(P => P).SingleOrDefault();
            if (residence != null)
            {
                residence.DocumentID = obj.DocumentNo;
                residence.ValidFrom = obj.ValidFrom;
                residence.ValidTo = obj.ValidTo;
                residence.ResidenceTypeID = _context.ResidencePermitTypes.Single(PRMTYP => PRMTYP.PermitType == obj.DocumentType).PermitTypeID;
                residence.ResidenceStatusID = _context.ResidencePermitStatus.Single(PRMSTS => PRMSTS.ResidencePermitStatus1 == obj.DocumentStatus).PermitStatusID;
                residence.ModifiedDate = DateTime.Now;
                residence.ModifiedBy = HttpContext.Current.User.Identity.Name;

            
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related residence permit record");
            }
        }

        [WebMethod]
        public void removeResidence(int permitID)
        {
            var residence = _context.ResidencePermits.Where(P => P.PermitID == permitID).Select(P => P).SingleOrDefault();
            if (residence != null)
            {
                _context.ResidencePermits.DeleteOnSubmit(residence);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related residence permit record");
            }
        }

        [WebMethod]
        public void createNewEmployeeEducation(string json, string personnelID)
        {

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Education obj = serializer.Deserialize<Education>(json);

            var employee = _context.Employees.Where(EMP => EMP.PersonnelID == personnelID).Select(EMP => EMP).SingleOrDefault();
            if (employee != null)
            {
                LINQConnection.Education education = new LINQConnection.Education();
                education.DegreeID = _context.EducationDegrees.Single(D=>D.DegreeTitle==obj.Degree).DegreeID;
                education.AwardTitle = obj.AwardTitle;
                education.StudyModeID = _context.StudyModes.Single(MOD => MOD.StudyMode1 == obj.StudyMode).StudyModeID;
                education.Institute = obj.Institute;
                education.StartDate = obj.StartDate;
                education.EndDate = obj.EndDate == null ? (DateTime?)null : Convert.ToDateTime(obj.EndDate);
                education.Faculty = obj.Faculty == string.Empty ? null : obj.Faculty;
                education.Department = obj.Department == string.Empty ? null : obj.Department;
                education.GradeSystemID = obj.GradeSystem==string.Empty?(int?)null:_context.GradeSystems.Single(SYS => SYS.Grade == obj.GradeSystem).GradeID;
                education.GradeScore = obj.Score;
                //education.CountryID = _context.Countries.Single(C => C.CountryName == obj.Country).CountryID;
                //education.City = obj.City == string.Empty ? null : obj.City;
                education.CountryID = obj.CountryID;
                if (education.CountryID == 1 || education.CountryID == 2 || education.CountryID == 95)
                {
                    education.StateID = obj.StateID;
                }
                else
                {
                    education.StateID = null;
                }
                education.CityID = obj.CityID;
                education.ModifiedDate = DateTime.Now;
                education.ModifiedBy = HttpContext.Current.User.Identity.Name;

                employee.Educations.Add(education);

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related employee record");
            }

        }
        [WebMethod]
        public void updateNewEmployeeEducation(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Education obj = serializer.Deserialize<Education>(json);

            var education = _context.Educations.Where(EDU => EDU.EducationID == obj.EducationID).Select(EDU => EDU).SingleOrDefault();
            if (education != null)
            {
                education.DegreeID = _context.EducationDegrees.Single(D => D.DegreeTitle == obj.Degree).DegreeID;
                education.AwardTitle = obj.AwardTitle;
                education.StudyModeID = _context.StudyModes.Single(MOD => MOD.StudyMode1 == obj.StudyMode).StudyModeID;
                education.Institute = obj.Institute;
                education.StartDate = obj.StartDate;
                education.EndDate = obj.EndDate == null ? (DateTime?)null : Convert.ToDateTime(obj.EndDate);
                education.Faculty = obj.Faculty == string.Empty ? null : obj.Faculty;
                education.Department = obj.Department == string.Empty ? null : obj.Department;
                education.GradeSystemID = obj.GradeSystem == string.Empty ? (int?)null : _context.GradeSystems.Single(SYS => SYS.Grade == obj.GradeSystem).GradeID;
                education.GradeScore = obj.Score;
                //education.CountryID = _context.Countries.Single(C => C.CountryName == obj.Country).CountryID;
                //education.City = obj.City == string.Empty ? null : obj.City;
                education.CountryID = obj.CountryID;
                if (education.CountryID == 1 || education.CountryID == 2 || education.CountryID == 95)
                {
                    education.StateID = obj.StateID;
                }
                else
                {
                    education.StateID = null;
                }
                education.CityID = obj.CityID;
                education.ModifiedDate = DateTime.Now;
                education.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related employee education record");
            }
        }
        [WebMethod]
        public void createNewEmployeeAddress(string json,string personnelID)
        {
 
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Address obj = serializer.Deserialize<Address>(json);

            var employee = _context.Employees.Where(EMP => EMP.PersonnelID == personnelID).Select(EMP => EMP).SingleOrDefault();
            if (employee != null)
            {
                LINQConnection.Address address = new LINQConnection.Address();
                address.AddressLine1 = obj.AddressLine1;
                address.AddressLine2 = obj.AddressLine2 == string.Empty ? null : obj.AddressLine2;
                address.City = obj.City;
                //address.CountryID = _context.Countries.Single(C => C.CountryName == obj.Country).CountryID;
                address.CountryID = obj.CountryID;
                if (address.CountryID == 1 || address.CountryID == 2 || address.CountryID == 95)
                {
                    address.StateID = obj.StateID;
                }
                else
                {
                    address.StateID = null;
                }
                address.CityID = obj.CityID;
                address.PostalCode = obj.PostalCode == string.Empty ? null : obj.PostalCode;
                address.ModifiedDate = DateTime.Now;
                address.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.Contacts != null)
                {
                    foreach (var cont in obj.Contacts)
                    {
                        LINQConnection.ContactDetail contact = new LINQConnection.ContactDetail();
                        contact.ContactNumber = cont.Number;
                        contact.ContactTypeID = _context.PhoneNumberTypes.Single(PH => PH.Name == cont.Type).PhoneNumberTypeId;
                        contact.ModifiedDate = DateTime.Now;
                        contact.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        address.ContactDetails.Add(contact);
                    }
                }

                employee.Addresses.Add(address);

                _context.SubmitChanges();
                
            }
            else
            {
                throw new Exception("Cannot find the related employee record");
            }
            
        }

        [WebMethod]
        public void removeEmployeeAddress(int addressID)
        {
            var address = _context.Addresses.Where(A => A.AddressID == addressID).Select(A => A).SingleOrDefault();
            if (address != null)
            {
                _context.Addresses.DeleteOnSubmit(address);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related employee address record");
            }
        }

        [WebMethod]
        public void removeEmployeeEducation(int educationID)
        {
            var education = _context.Educations.Where(EDU => EDU.EducationID == educationID).Select(EDU => EDU).SingleOrDefault();
            if (education != null)
            {
                _context.Educations.DeleteOnSubmit(education);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related employee education record");
            }
        } 
        #endregion
        #region OrganizationManagement


        [WebMethod]
        public void updatePosition(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Position obj = serializer.Deserialize<Position>(json);

            var position = _context.Positions.Where(POS => POS.PositionID == obj.PositionID)
                .Select(POS=>POS).SingleOrDefault();

            if (position != null)
            {
                
                position.Title = obj.Title;
                position.Description = obj.Description == string.Empty ? null : obj.Description;
                position.OpeningDate = obj.OpenDate;
                position.ClosingDate = obj.CloseDate;
                position.DepartmentID = _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.Unit).UnitID;
                position.PositionStatusID = _context.PositionStatus.Single(POSSTS => POSSTS.PositionStatus1 == obj.POSStatusStr).PositionStatusID;
                
                position.ModifiedDate = DateTime.Now;
                position.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.Supervisor == "Self")
                {
                    position.ReportingPositionID = position.PositionID;

                }
                else
                {
                    position.ReportingPositionID = _context.Positions.Single(P => P.Title == obj.Supervisor).PositionID;
                }

                if (obj.Skills != null)
                {
                    foreach (var s in obj.Skills)
                    {
                        LINQConnection.Skill skill = null;

                        switch (s.Status)
                        {
                            case RecordsStatus.MODIFIED:
                                skill = _context.Skills.Where(SKL => SKL.SkillID == s.SkillID)
                                     .Select(SKL => SKL).SingleOrDefault();

                                skill.SkillKey = s.SKL;
                                skill.Description = s.DESC == string.Empty ? null : s.DESC;
                                skill.ModifiedDate = DateTime.Now;
                                skill.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                break;

                            case RecordsStatus.REMOVED:
                                skill = _context.Skills.Where(SKL => SKL.SkillID == s.SkillID)
                                    .Select(SKL => SKL).SingleOrDefault();
                                _context.Skills.DeleteOnSubmit(skill);
                                break;

                            case RecordsStatus.ADDED:
                                skill = new LINQConnection.Skill();
                                skill.SkillKey = s.SKL;
                                skill.Description = s.DESC == string.Empty ? null : s.DESC;
                                skill.ModifiedDate = DateTime.Now;
                                skill.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                LINQConnection.PositionSkill pskill = new PositionSkill();
                                pskill.PositionID = position.PositionID;
                                pskill.ModifiedDate = DateTime.Now;
                                pskill.ModifiedBy = HttpContext.Current.User.Identity.Name;


                                skill.PositionSkills.Add(pskill);
                                _context.Skills.InsertOnSubmit(skill);
                                break;
                        }
                    }
                }

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related position record");
            }
        }
        [WebMethod]
        public string createNewPosition(string json)
        {
            string result = string.Empty;

            try
            {
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                Position obj = serializer.Deserialize<Position>(json);


                LINQConnection.Position pos = new LINQConnection.Position();

                pos.Title = obj.Title;
                pos.Description = obj.Description == string.Empty ? null : obj.Description;
                pos.OpeningDate = obj.OpenDate;
                pos.ClosingDate = obj.CloseDate;
                pos.DepartmentID = _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.Unit).UnitID;
                pos.PositionStatusID = (int)obj.POSStatus;
                pos.ModifiedDate = DateTime.Now;
                pos.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.Positions.InsertOnSubmit(pos);
                _context.SubmitChanges();


                if (obj.Supervisor == "Self")
                {
                    pos.ReportingPositionID = pos.PositionID;

                }
                else
                {
                    pos.ReportingPositionID = _context.Positions.Single(P => P.Title == obj.Supervisor).PositionID;
                }

                _context.SubmitChanges();

                if (obj.Skills != null)
                {
                    //submit all skills first
                    foreach (var skl in obj.Skills)
                    {
                        LINQConnection.Skill skill = new LINQConnection.Skill();
                        skill.SkillKey = skl.SKL;
                        skill.Description = skl.DESC == string.Empty ? null : skl.DESC;
                        skill.ModifiedDate = DateTime.Now;
                        skill.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        PositionSkill pskl = new PositionSkill();
                        pskl.PositionID = pos.PositionID;
                        pskl.ModifiedDate = DateTime.Now;
                        pskl.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        skill.PositionSkills.Add(pskl);
                        _context.Skills.InsertOnSubmit(skill);
                        _context.SubmitChanges();
                    }
                }
            }
            finally
            {
                result = "Operation has been committed sucessfully";
            }
            return result;
        }
       [WebMethod]
       public string[] getRelatedDepPositions(string unit)
       {
            var positions = (from POS in _context.Positions
                             where POS.DepartmentID==_context.OrganizationUnits.Single(ORG=>ORG.UnitName==unit).UnitID
                             select POS.Title).ToArray();

            return positions;
       }
       [WebMethod]
       public string[] getParentDepPositions(string unit)
       {
           var positions = (from POS in _context.fn_GetRootDepartmentPositions(unit)
                            select POS.PositionTitle).ToArray();
           return positions;
       }
       [WebMethod]
        public string loadJSONOrganizationLevel()
        {
            var result = String.Empty;
            try
            {
                var levels = _context.OrganizationLevels
                        .Select(LVL => new ORGLevel
                        {
                            LevelID = LVL.LevelID,
                            Level = LVL.ORGLevel,
                            Status=RecordsStatus.ORIGINAL

                        }).ToList();

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                result = serializer.Serialize(levels);
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }
            return result;
       }
       [WebMethod]
       public void uploadOrganizationLevel(string json)
       {
           JavaScriptSerializer serializer = new JavaScriptSerializer();
           List<ORGLevel> obj = serializer.Deserialize<List<ORGLevel>>(json);

           OrganizationLevel level = null;
           foreach (var lvl in obj)
           {
               switch (lvl.Status)
               {
                   case RecordsStatus.ADDED:
                       level = new OrganizationLevel();
                       level.ORGLevel = lvl.Level;
                       level.ModifiedDate = DateTime.Now;
                       level.ModifiedBy = HttpContext.Current.User.Identity.Name;

                       _context.OrganizationLevels.InsertOnSubmit(level);

                       break;
                   case RecordsStatus.MODIFIED:
                       level = _context.OrganizationLevels.Where(LVL => LVL.LevelID == lvl.LevelID)
                           .Select(LVL => LVL).SingleOrDefault();

                       level.ORGLevel = lvl.Level;
                       level.ModifiedDate = DateTime.Now;
                       level.ModifiedBy = HttpContext.Current.User.Identity.Name;

                       break;
                   case RecordsStatus.REMOVED:
                       level = _context.OrganizationLevels.Where(LVL => LVL.LevelID == lvl.LevelID)
                            .Select(LVL => LVL).SingleOrDefault();

                       _context.OrganizationLevels.DeleteOnSubmit(level);
                       break;
               }
               _context.SubmitChanges();
           }
       }
       [WebMethod]
       public string filterPositionsByTitle(string title)
       {
           var positions = _context.Positions.Where(POS => POS.Title.StartsWith(title))
           .OrderBy(POS => POS.OpeningDate)
           .Select(POS => new Position
           {
               PositionID = POS.PositionID,
               Title = POS.Title,
               OpenDate = ConvertToLocalTime(Convert.ToDateTime(POS.OpeningDate)),
               CloseDate = ConvertToLocalTime(Convert.ToDateTime(POS.ClosingDate)),
               Description = POS.Description == null ? string.Empty : POS.Description,
               Supervisor = (POS.PositionID == POS.ReportingPositionID ? "Self" : _context.Positions.Single(PPOS => PPOS.PositionID == POS.ReportingPositionID).Title),
               POSStatus = (PositionStatus)POS.PositionStatusID,
               Unit = POS.OrganizationUnit.UnitName,
               
               Skills = _context.Skills.Join(_context.PositionSkills, SKL => SKL.SkillID, PSKL => PSKL.SkillID, (SKL, PSKL) => new { SKL, PSKL })
               .Where(P => P.PSKL.PositionID == POS.PositionID)
               .Select(P => new Skill
               {
                   SkillID = P.SKL.SkillID,
                   SKL = P.SKL.SkillKey,
                   DESC = P.SKL.Description
               }).ToList()

           }).ToList();

           var xml = new XmlSerializer(typeof(List<Position>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, positions);

           return str.ToString();
       }
       [WebMethod]
       public string filterPositionsByStatus(string status)
       {
           var positions = _context.Positions.Where(POS => POS.PositionStatus.PositionStatus1 == status)
           .OrderBy(POS => POS.OpeningDate)
           .Select(POS => new Position
           {
               PositionID = POS.PositionID,
               Title = POS.Title,
               OpenDate = ConvertToLocalTime(Convert.ToDateTime(POS.OpeningDate)),
               CloseDate = ConvertToLocalTime(Convert.ToDateTime(POS.ClosingDate)),
               Description = POS.Description == null ? string.Empty : POS.Description,
               Supervisor = (POS.PositionID == POS.ReportingPositionID ? "Self" : _context.Positions.Single(PPOS => PPOS.PositionID == POS.ReportingPositionID).Title),
               POSStatus = (PositionStatus)POS.PositionStatusID,
               Unit = POS.OrganizationUnit.UnitName,
               
               Skills = _context.Skills.Join(_context.PositionSkills, SKL => SKL.SkillID, PSKL => PSKL.SkillID, (SKL, PSKL) => new { SKL, PSKL })
               .Where(P => P.PSKL.PositionID == POS.PositionID)
               .Select(P => new Skill
               {
                   SkillID = P.SKL.SkillID,
                   SKL = P.SKL.SkillKey,
                   DESC = P.SKL.Description
               }).ToList()

           }).ToList();

           var xml = new XmlSerializer(typeof(List<Position>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, positions);

           return str.ToString();
       }
       [WebMethod]
       public string filterPositionsByUnit(string unit)
       {
           var positions = _context.Positions.Where(POS => POS.OrganizationUnit.UnitName == unit)
           .OrderBy(POS => POS.OpeningDate)
           .Select(POS => new Position
           {
               PositionID = POS.PositionID,
               Title = POS.Title,
               OpenDate = ConvertToLocalTime(Convert.ToDateTime(POS.OpeningDate)),
               CloseDate = ConvertToLocalTime(Convert.ToDateTime(POS.ClosingDate)),
               Description = POS.Description == null ? string.Empty : POS.Description,
               Supervisor = (POS.PositionID == POS.ReportingPositionID ? "Self" : _context.Positions.Single(PPOS => PPOS.PositionID == POS.ReportingPositionID).Title),
               POSStatus = (PositionStatus)POS.PositionStatusID,
               Unit = POS.OrganizationUnit.UnitName,
               Skills = _context.Skills.Join(_context.PositionSkills, SKL => SKL.SkillID, PSKL => PSKL.SkillID, (SKL, PSKL) => new { SKL, PSKL })
               .Where(P => P.PSKL.PositionID == POS.PositionID)
               .Select(P => new Skill
               {
                   SkillID = P.SKL.SkillID,
                   SKL = P.SKL.SkillKey,
                   DESC = P.SKL.Description
               }).ToList()

           }).ToList();

           var xml = new XmlSerializer(typeof(List<Position>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, positions);

           return str.ToString();
       }
       [WebMethod]
       public string filterPositionsByOpeningDateRange(string json)
       {
           JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
           DateParam obj = jsonserializer.Deserialize<DateParam>(json);

           var positions = _context.Positions.Where(POS=>POS.OpeningDate>=obj.StartDate && POS.OpeningDate<=obj.EndDate)
           .OrderBy(POS => POS.OpeningDate)
           .Select(POS => new Position
           {
               PositionID = POS.PositionID,
               Title = POS.Title,
               OpenDate = ConvertToLocalTime(Convert.ToDateTime(POS.OpeningDate)),
               CloseDate = ConvertToLocalTime(Convert.ToDateTime(POS.ClosingDate)),
               Description = POS.Description == null ? string.Empty : POS.Description,
               Supervisor = (POS.PositionID == POS.ReportingPositionID ? "Self" : _context.Positions.Single(PPOS => PPOS.PositionID == POS.ReportingPositionID).Title),
               POSStatus = (PositionStatus)POS.PositionStatusID,
               Unit = POS.OrganizationUnit.UnitName,
               Skills = _context.Skills.Join(_context.PositionSkills, SKL => SKL.SkillID, PSKL => PSKL.SkillID, (SKL, PSKL) => new { SKL, PSKL })
               .Where(P => P.PSKL.PositionID == POS.PositionID)
               .Select(P => new Skill
               {
                   SkillID = P.SKL.SkillID,
                   SKL = P.SKL.SkillKey,
                   DESC = P.SKL.Description
               }).ToList()

           }).ToList();

           var xml = new XmlSerializer(typeof(List<Position>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, positions);

           return str.ToString();
       }
       [WebMethod]
       public string loadPositions()
       {
           var positions = _context.Positions.OrderBy(POS => POS.OpeningDate)
           .Select(POS => new Position
           {
               PositionID = POS.PositionID,
               Title = POS.Title,
               OpenDate = ConvertToLocalTime(Convert.ToDateTime(POS.OpeningDate)),
               CloseDate = ConvertToLocalTime(Convert.ToDateTime(POS.ClosingDate)),
               Description = POS.Description == null ? string.Empty : POS.Description,
               Supervisor = (POS.PositionID == POS.ReportingPositionID ? "Self" : _context.Positions.Single(PPOS => PPOS.PositionID == POS.ReportingPositionID).Title),
               POSStatus = (PositionStatus)POS.PositionStatusID,
               Unit=POS.OrganizationUnit.UnitName,
               Skills = _context.Skills.Join(_context.PositionSkills, SKL => SKL.SkillID, PSKL => PSKL.SkillID, (SKL, PSKL) => new { SKL, PSKL })
               .Where(P => P.PSKL.PositionID == POS.PositionID)
               .Select(P => new Skill
               {
                   SkillID = P.SKL.SkillID,
                   SKL = P.SKL.SkillKey,
                   DESC = P.SKL.Description
               }).ToList()

           }).ToList();

           var xml = new XmlSerializer(typeof(List<Position>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, positions);

           return str.ToString();
       }

        [WebMethod]
        public void RemovePosition(int positionID)
        {
            var position = _context.Positions.Where(POS => POS.PositionID == positionID)
                .Select(POS => POS).SingleOrDefault();
            if (position != null)
            {
                _context.Positions.DeleteOnSubmit(position);

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Could not find the related position record");
            }

        }
        [WebMethod]
        public void RemoveOrganziationUnit(int ID)
        {
            
           var unit = _context.OrganizationUnits.Where(ORG => ORG.UnitID == ID)
                .Select(ORG => ORG).SingleOrDefault();

            if (unit != null)
            {
                if (unit.Documents.Count() > 0)
                {
                    throw new Exception("Cannot remove the selected unit because there are (" + unit.Documents.Count + ") related documents, please either migrate these documents to another organization unit, or remove them");
                }
                else if (unit.Positions.Count > 0)
                {
                    throw new Exception("Cannot remove the selected unit because there are (" + unit.Positions.Count + ") related positions, please either migrate these positions to another organization unit or remove them");
                }
                else if (unit.Problems.Count > 0 || unit.Problems1.Count > 0)
                {
                    throw new Exception("Cannot remove the selected unit because there are problems referencing the unit as the source or the reporter of the problem, please either migrate these problems to another organization unit, or remove them");
                }
                else
                {
                    _context.OrganizationUnits.DeleteOnSubmit(unit);
                    _context.SubmitChanges();
                }
            }
            else
            {
                throw new Exception("Cannot find the selected organization unit record");
            }
        }
        [WebMethod]
        public string UploadOrganizationUnit(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<ORGUnit> units = serializer.Deserialize<List<ORGUnit>>(json);

            OrganizationUnit unit = null;

            string result = string.Empty;
            try
            {
                foreach (ORGUnit unitobj in units)
                {
                    switch (unitobj.Status)
                    {
                        case RecordsStatus.ADDED:

                            unit = new OrganizationUnit();
                            unit.UnitName = unitobj.name;
                            unit.UnitCode = unitobj.Code;
                            unit.Depth = unitobj.Depth;
                            unit.CreateDate = Convert.ToDateTime(unitobj.CreateDate);
                            unit.CountryID = _context.Countries.Single(CTRY => CTRY.CountryName == unitobj.Country).CountryID;
                            unit.ORGLevelID = _context.OrganizationLevels.Single(LVL => LVL.ORGLevel == unitobj.ORGLevel).LevelID;
                            unit.ModifiedDate = DateTime.Now;
                            unit.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedORG(unitobj, unit);

                            _context.OrganizationUnits.InsertOnSubmit(unit);
                   
                            break;
                        case RecordsStatus.MODIFIED:
                            unit = _context.OrganizationUnits.Where(ORG => ORG.UnitID == unitobj.ORGID).SingleOrDefault();
                            unit.UnitName = unitobj.name;
                            unit.UnitCode = unitobj.Code;
                            unit.Depth = unitobj.Depth;
                            unit.CreateDate = Convert.ToDateTime(unitobj.CreateDate);
                            unit.CountryID = _context.Countries.Single(CTRY => CTRY.CountryName == unitobj.Country).CountryID;
                            unit.ORGLevelID = _context.OrganizationLevels.Single(LVL => LVL.ORGLevel == unitobj.ORGLevel).LevelID;
                            unit.ModifiedDate = DateTime.Now;
                            unit.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedORG(unitobj, unit);

                            break;

                        case RecordsStatus.ORIGINAL:
                            unit = _context.OrganizationUnits.Where(ORG => ORG.UnitID == unitobj.ORGID).SingleOrDefault();
                            searchModifiedORG(unitobj, unit);
                           
                            break;
                    }
                }

               _context.SubmitChanges();

                result = "Changes have been committed sucessfully";

            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return result; 
        }

        
        public void searchModifiedORG(ORGUnit unitobj, OrganizationUnit unit)
        {
            OrganizationUnit childobj=null;

            if (unitobj.children != null)
            {
                foreach (ORGUnit c in unitobj.children)
                {
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                            childobj = new OrganizationUnit();
                            childobj.UnitCode = c.Code;
                            childobj.UnitName = c.name;
                            childobj.Depth = c.Depth;
                            childobj.CreateDate = Convert.ToDateTime(c.CreateDate);
                            childobj.CountryID = _context.Countries.Single(CTRY => CTRY.CountryName == c.Country).CountryID;
                            childobj.ORGLevelID = _context.OrganizationLevels.Single(LVL => LVL.ORGLevel == c.ORGLevel).LevelID;
                            childobj.ModifiedDate = DateTime.Now;
                            childobj.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            unit.OrganizationUnits.Add(childobj);
                            searchModifiedORG(c, childobj);

                            break;
                        case RecordsStatus.MODIFIED:
                            childobj = _context.OrganizationUnits.Where(ORG => ORG.UnitID == c.ORGID).SingleOrDefault();
                            childobj.UnitCode = c.Code;
                            childobj.UnitName = c.name;
                            childobj.Depth = c.Depth;
                            childobj.CreateDate = Convert.ToDateTime(c.CreateDate);
                            childobj.CountryID = _context.Countries.Single(CTRY => CTRY.CountryName == c.Country).CountryID;
                            childobj.ORGLevelID = _context.OrganizationLevels.Single(LVL => LVL.ORGLevel == c.ORGLevel).LevelID;
                            childobj.ModifiedDate = DateTime.Now;
                            childobj.ModifiedBy = HttpContext.Current.User.Identity.Name;

                           
                            searchModifiedORG(c, childobj);

                            break;
                        case RecordsStatus.ORIGINAL:
                            childobj = _context.OrganizationUnits.Where(ORG => ORG.UnitID == c.ORGID).SingleOrDefault();
                            searchModifiedORG(c, childobj);
                            break;
                    }
                }
            }
        }

        [WebMethod]
        public string UploadOrganizationLevel(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<ORGLevel> units = serializer.Deserialize<List<ORGLevel>>(json);

            string result = string.Empty;
            try
            {
                OrganizationLevel unitlevel = null;
                foreach (var unit in units)
                {
                    switch (unit.Status)
                    {
                        case RecordsStatus.REMOVED:
                            unitlevel = (from LVL in _context.OrganizationLevels
                                         where LVL.LevelID == unit.LevelID
                                         select LVL).SingleOrDefault();

                            _context.OrganizationLevels.DeleteOnSubmit(unitlevel);
                            break;
                        case RecordsStatus.MODIFIED:
                            unitlevel = (from LVL in _context.OrganizationLevels
                                         where LVL.LevelID == unit.LevelID
                                         select LVL).SingleOrDefault();

                            unitlevel.ORGLevel = unit.Level;

                            break;
                        case RecordsStatus.ADDED:
                            unitlevel = new OrganizationLevel();
                            unitlevel.ORGLevel = unit.Level;

                            _context.OrganizationLevels.InsertOnSubmit(unitlevel);
                            break;
                    }
                }

                _context.SubmitChanges();

                result = "Changes have been updated sucessfully!";
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return result;
        }

        [WebMethod]
        public string[] filterOrganizationUnitByCountry(string country)
        {
            var units = (from UNT in _context.OrganizationUnits
                         where UNT.Country.CountryName==country
                         select UNT.UnitName).ToArray();
            return units;
        }

        [WebMethod]
        public string[] getOrganizationUnits()
        {
            var units = (from UNT in _context.OrganizationUnits
                         select UNT.UnitName).ToArray();
            return units;
        }
        [WebMethod]
        public string getOrganizationUnitRecord(string name)
        {
            var unit = _context.OrganizationUnits.Where(UNT => UNT.UnitName == name)
            .Select(UNT => new ORGUnit
            {
                ORGID = UNT.UnitID,
                Code = UNT.UnitCode,
                ParentID = Convert.ToInt32(UNT.DominatorID == null ? 0 : UNT.DominatorID),
                name = UNT.UnitName,
                CreateDate = ConvertToLocalTime(Convert.ToDateTime(UNT.CreateDate)),
                ORGLevel = UNT.ORGLevelID.HasValue == false ? string.Empty : UNT.OrganizationLevel.ORGLevel,
                Country = UNT.Country.CountryName
            }).SingleOrDefault();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(unit);

            return result;
        }

        [WebMethod]
        public string loadOrganizationUnit()
        {
            var units = _context.OrganizationUnits.Join(_context.OrganizationLevels,
                ORG => ORG.ORGLevelID, LVL => LVL.LevelID, (ORG, LVL) => new { ORG, LVL }).OrderBy(ORG => ORG.ORG.UnitName)
                .Select(ORGLVL => new ORGUnit
                {
                    ORGID = ORGLVL.ORG.UnitID,
                    Code = ORGLVL.ORG.UnitCode,
                    ParentID = Convert.ToInt32(ORGLVL.ORG.DominatorID == null ? 0 : ORGLVL.ORG.DominatorID),
                    name = ORGLVL.ORG.UnitName,
                    CreateDate = ConvertToLocalTime(Convert.ToDateTime(ORGLVL.ORG.CreateDate)),
                    ORGLevel = ORGLVL.ORG.ORGLevelID.HasValue == false ? string.Empty : ORGLVL.ORG.OrganizationLevel.ORGLevel,
                    Country = ORGLVL.ORG.Country.CountryName,
                    Depth = Convert.ToInt32(ORGLVL.ORG.Depth)
                }).ToList();

            foreach(var unit in units)
            {
                List<ORGUnit> obj = units.Where(x => x.ParentID == unit.ORGID).ToList<ORGUnit>();

                if (obj.Count > 0)
                {
                    unit.children = obj;
                }
            }

            for (int i = units.Count-1; i >= 0; i--)
            {
                if (units[i].Depth > 1)
                {
                    units.RemoveAt(i);
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(units);
          
            return result;
        }
        
       
        #endregion

        #region CCN

        [WebMethod]
        public string createNewDCR(string json, string docID)
        {
            string result = String.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
         
            CCN obj = serializer.Deserialize<CCN>(json);

            var doc = _context.Documents.Where(DOC => DOC.DocumentNo == docID)
                .Select(DOC => DOC).SingleOrDefault();

            if (doc != null)
            {

                ChangeControlNote ccn = new ChangeControlNote();
                ccn.CCNTypeID = _context.ChangeControlTypes.Single(CCNT => CCNT.CCNType == obj.CCNTypeString).CCNTypeID;
                ccn.OriginationDate = obj.OrginationDate;
                ccn.DocumentFileURL = obj.DocumentFileURL == string.Empty ? null : ccn.DocumentFileURL;
                if (obj.DocumentFile != string.Empty)
                {
                    try
                    {
                        ccn.DocumentFile = File.ReadAllBytes(obj.DocumentFile);
                        ccn.DocumentFileName = obj.DocumentFileName;
                    }
                    finally
                    {
                        File.Delete(obj.DocumentFile);
                    }
                }

                ccn.OriginatorID = (from EMP in _context.Employees
                                    where EMP.FirstName == obj.Originator.Substring(obj.Originator.LastIndexOf(".") + 1, obj.Originator.IndexOf(" ") - 3) &&
                                     EMP.LastName == obj.Originator.Substring(obj.Originator.IndexOf(" ") + 1)
                                    select EMP.EmployeeID).SingleOrDefault();

                ccn.OwnerID = (from EMP in _context.Employees
                               where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                               select EMP.EmployeeID).SingleOrDefault();

                ccn.Details = obj.CCNDetails == string.Empty ? null : obj.CCNDetails;

                ccn.CCNStatusID = (int)obj.CCNStatus;
                ccn.ModuleId = (int)obj.Module;
                ccn.ModifiedDate = DateTime.Now;
                ccn.ModifiedBy = HttpContext.Current.User.Identity.Name;

                doc.ChangeControlNotes.Add(ccn);
                _context.SubmitChanges();


                // generate automatic email notification for adding new CCN
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = obj.Module;
                automail.KeyValue = ccn.CCNID;
                automail.Action = "Add";

                //add both the originator and the owner as a recipient
                automail.Recipients.Add(ccn.OriginatorID);
                automail.Recipients.Add(ccn.OwnerID);

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            return result;
        }

        [WebMethod]
        public string[] loadDCRType(string ID)
        {
            var doc= _context.Documents.Single(DOC => DOC.DocumentNo == ID);

            DocStatus status = (DocStatus)doc.DocumentStatusID;

            string[] ccnTypes = null ;

            switch (status)
            {
                case DocStatus.Pending:
                case DocStatus.Issued:
                    ccnTypes = (from CCNT in _context.ChangeControlTypes
                                where CCNT.CCNTypeID != (int)status
                                select CCNT.CCNType).ToArray();
                    break;
                case DocStatus.Updated:
                    ccnTypes = (from CCNT in _context.ChangeControlTypes
                                where CCNT.CCNTypeID !=(int)CCNType.ISSUE
                                select CCNT.CCNType).ToArray();
                    
                    break;
            }

            return ccnTypes;
        }

        [WebMethod]
        public string filterDCRByType(string type)
        {

            var ccn = _context.ChangeControlNotes.Where(DCR => DCR.ChangeControlType.CCNType == type)
           .Select(DCR => new DocFile
           {
               DOCID = DCR.Document.DocumentId,
               DOCNo = DCR.Document.DocumentNo,
               DOCType = DCR.Document.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DCR.Document.DocumentTypeID).DocumentType1,
               DOCFileType = DCR.Document.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DCR.Document.DocumentFileTypeID).FileType,
               DOCTitle = DCR.Document.Title,
               IssueDate = DCR.Document.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DCR.Document.IssueDate)),
               LastReviewDate = DCR.Document.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DCR.Document.LastReviewDate)),
               NextReviewDate = DCR.Document.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DCR.Document.NextReviewDate)),
               ReviewDuration = DCR.Document.ReviewDuration,
               ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DCR.Document.PeriodID).Period1,
               ReviewDurationDays = DCR.Document.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DCR.Document.ReviewDurationDays),
               Remarks = DCR.Document.Remarks == null ? string.Empty : DCR.Document.Remarks,
               DOCStatus = ((DocStatus)DCR.Document.DocumentStatusID),
               Department = DCR.Document.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DCR.Document.DepartmentID).UnitName,
               Project = DCR.Document.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DCR.Document.ProjectID).ProjectName,
               CCNList = DCR.Document.ChangeControlNotes.Where(C => C.ChangeControlType.CCNType == type)
               .Select(C => new CCN
               {
                   CCNID = C.CCNID,
                   CCNType = (CCNType)C.CCNTypeID,
                   OrginationDate = C.OriginationDate,
                   Originator = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == C.OriginatorID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Owner = (from T in _context.Titles
                            join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                            from g in empgroup
                            where g.EmployeeID == C.OwnerID
                            select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Version = C.Version,
                   CCNStatus = (CCNStatus)C.CCNStatusID,
                   CCNDetails = C.Details == null ? string.Empty : C.Details,
                   DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                   DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                   Members = C.ChangeControlApprovalMembers
                   .Select(APRCN => new ApprovalMember
                   {
                       MemberID = APRCN.MemberID,
                       Member = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == APRCN.ApproverID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                       MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                       ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                       ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                       Status = RecordsStatus.ORIGINAL

                   }).ToList()
               }).ToList(),
               Module = (Modules)DCR.Document.ModuleId

           }).ToList();

            var xml = new XmlSerializer(typeof(List<DocFile>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, ccn);

            return str.ToString();
        }
        [WebMethod]
        public string loadDCRByApprovalEmployee(string firstname, string lastname, string approval)
        {
            var ccn = _context.ChangeControlApprovalMembers.Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname
                && MEM.ApprovalStatus.ApprovalStatus1 == approval)
            .Select(MEM => new CCN
            {
                CCNID = MEM.ChangeControlNote.CCNID,
                CCNType = (CCNType)MEM.ChangeControlNote.CCNTypeID,
                OrginationDate = ConvertToLocalTime(MEM.ChangeControlNote.OriginationDate),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ChangeControlNote.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.ChangeControlNote.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Version = MEM.ChangeControlNote.Version,
                CCNStatus = (CCNStatus)MEM.ChangeControlNote.CCNStatusID,
                CCNDetails = MEM.ChangeControlNote.Details==null?string.Empty:MEM.ChangeControlNote.Details,
                DocumentFileURL = MEM.ChangeControlNote.DocumentFileURL == null ? string.Empty : MEM.ChangeControlNote.DocumentFileURL,
                DocumentFileName = MEM.ChangeControlNote.DocumentFileName == null ? string.Empty : MEM.ChangeControlNote.DocumentFileName,

                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }
            }).ToList();

            var xml = new XmlSerializer(typeof(List<CCN>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, ccn);

            return str.ToString();
        }

        [WebMethod]
        public string loadDCRByStatusEmployee(string firstname, string lastname, string status)
        {
            var ccn = _context.ChangeControlApprovalMembers.Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname
                && MEM.ChangeControlNote.ChangeControlNoteStatus.CCNStatus == status)
            .Select(MEM => new CCN
            {
                CCNID = MEM.ChangeControlNote.CCNID,
                CCNType = (CCNType)MEM.ChangeControlNote.CCNTypeID,
                OrginationDate = ConvertToLocalTime(MEM.ChangeControlNote.OriginationDate),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ChangeControlNote.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.ChangeControlNote.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Version = MEM.ChangeControlNote.Version,
                CCNStatus = (CCNStatus)MEM.ChangeControlNote.CCNStatusID,
                CCNDetails = MEM.ChangeControlNote.Details==null?string.Empty:MEM.ChangeControlNote.Details,
                DocumentFileURL = MEM.ChangeControlNote.DocumentFileURL == null ? string.Empty : MEM.ChangeControlNote.DocumentFileURL,
                DocumentFileName = MEM.ChangeControlNote.DocumentFileName == null ? string.Empty : MEM.ChangeControlNote.DocumentFileName,
    
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }
            }).ToList();

            var xml = new XmlSerializer(typeof(List<CCN>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, ccn);

            return str.ToString();
        }
        [WebMethod]
        public string loadDCRByTypeEmployee(string firstname, string lastname, string type)
        {
            var ccn = _context.ChangeControlApprovalMembers.Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname
                && MEM.ChangeControlNote.ChangeControlType.CCNType==type)
            .Select(MEM => new CCN
            {
                CCNID = MEM.ChangeControlNote.CCNID,
                CCNType = (CCNType)MEM.ChangeControlNote.CCNTypeID,
                OrginationDate = ConvertToLocalTime(MEM.ChangeControlNote.OriginationDate),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ChangeControlNote.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.ChangeControlNote.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Version = MEM.ChangeControlNote.Version,
                CCNStatus = (CCNStatus)MEM.ChangeControlNote.CCNStatusID,
                CCNDetails = MEM.ChangeControlNote.Details==null?string.Empty:MEM.ChangeControlNote.Details,
                DocumentFileURL = MEM.ChangeControlNote.DocumentFileURL == null ? string.Empty : MEM.ChangeControlNote.DocumentFileURL,
                DocumentFileName = MEM.ChangeControlNote.DocumentFileName == null ? string.Empty : MEM.ChangeControlNote.DocumentFileName,
    
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }
            }).ToList();

            var xml = new XmlSerializer(typeof(List<CCN>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, ccn);

            return str.ToString();
        }

        [WebMethod]
        public string loadDCRByEmployee(string firstname, string lastname)
        {

            var ccn = _context.ChangeControlApprovalMembers.Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname)
            .Select(MEM => new CCN
            {
                CCNID = MEM.ChangeControlNote.CCNID,
                CCNType = (CCNType)MEM.ChangeControlNote.CCNTypeID,
                OrginationDate = ConvertToLocalTime(MEM.ChangeControlNote.OriginationDate),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ChangeControlNote.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.ChangeControlNote.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Version = MEM.ChangeControlNote.Version,
                CCNStatus = (CCNStatus)MEM.ChangeControlNote.CCNStatusID,
                CCNDetails = MEM.ChangeControlNote.Details==null?string.Empty:MEM.ChangeControlNote.Details,
                DocumentFileURL = MEM.ChangeControlNote.DocumentFileURL == null ? string.Empty : MEM.ChangeControlNote.DocumentFileURL,
                DocumentFileName = MEM.ChangeControlNote.DocumentFileName == null ? string.Empty : MEM.ChangeControlNote.DocumentFileName,
                 
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }
            }).ToList();

            var xml = new XmlSerializer(typeof(List<CCN>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, ccn);

            return str.ToString();
        }
       
       
        [WebMethod]
        public string updateDCR(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            CCN obj = serializer.Deserialize<CCN>(json);

            string result = string.Empty;

            var ccn = _context.ChangeControlNotes.Where(C => C.CCNID == obj.CCNID)
                .Select(C=>C).SingleOrDefault();

            if (ccn != null)
            {
                ccn.Version = obj.Version;
                ccn.OriginatorID = (from EMP in _context.Employees
                                    where EMP.FirstName == obj.Originator.Substring(obj.Originator.LastIndexOf(".") + 1, obj.Originator.IndexOf(" ") - 3) &&
                                    EMP.LastName == obj.Originator.Substring(obj.Originator.IndexOf(" ") + 1)
                                    select EMP.EmployeeID).SingleOrDefault();

                ccn.OwnerID = (from EMP in _context.Employees
                               where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                               EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                               select EMP.EmployeeID).SingleOrDefault();

                ccn.OriginationDate = obj.OrginationDate;
                ccn.CCNStatusID = _context.ChangeControlNoteStatus.Single(CCNSTS => CCNSTS.CCNStatus == obj.CCNStatusString).CCNStatusID;
                ccn.Details = obj.CCNDetails == string.Empty ? null : obj.CCNDetails;
                ccn.DocumentFileURL = obj.DocumentFileURL == string.Empty ? null : ccn.DocumentFileURL;
                if (obj.DocumentFile != string.Empty)
                {
                    try
                    {
                        ccn.DocumentFile = File.ReadAllBytes(obj.DocumentFile);
                        ccn.DocumentFileName = obj.DocumentFileName;
                    }
                    finally
                    {
                        File.Delete(obj.DocumentFile);
                    }
                }

                //if the CCN of type issue has been cancelled, then the document should also be cancelled
                if (ccn.CCNTypeID == (int)CCNType.ISSUE)
                {
                    if (ccn.CCNStatusID == (int)CCNStatus.Cancelled)
                    {
                        ccn.Document.DocumentStatusID = (int)DocStatus.Cancelled;
                    }
                }

                ccn.ModifiedDate = DateTime.Now;
                ccn.ModifiedBy = HttpContext.Current.User.Identity.Name;

                EmailConfiguration automail = null;

                if (obj.Members != null)
                {
                    ChangeControlApprovalMember member = null;

                    foreach (var app in obj.Members)
                    {
                        switch (app.Status)
                        {
                            case RecordsStatus.ADDED:

                                member = new ChangeControlApprovalMember();
                                member.MemberTypeID = _context.ApprovalMemberTypes.Single(MT => MT.MemberType == app.MemberType).MemberTypeID;
                                member.ApproverID = (from EMP in _context.Employees
                                                     where EMP.FirstName == app.Member.Substring(app.Member.LastIndexOf(".") + 1, app.Member.IndexOf(" ") - 3) &&
                                                     EMP.LastName == app.Member.Substring(app.Member.IndexOf(" ") + 1)
                                                     select EMP.EmployeeID).SingleOrDefault();
                                member.ApprovalStatusID = _context.ApprovalStatus.Single(APP => APP.ApprovalStatus1 == app.ApprovalStatusString).ApprovalStatusID;
                                member.ModifiedDate = DateTime.Now;

                                ccn.ChangeControlApprovalMembers.Add(member);


                                // generate automatic email notification for approving CCN request
                                automail = new EmailConfiguration();
                                automail.Module = obj.Module;
                                automail.KeyValue = ccn.CCNID;
                                automail.Action = "Approve";

                                //add both the originator and the owner as a recipient
                                automail.Recipients.Add(member.ApproverID);

                                //generate email request
                                automail.GenerateEmail();

                                break;
                            case RecordsStatus.MODIFIED:
                                member = _context.ChangeControlApprovalMembers.Single(MT => MT.MemberID == app.MemberID);
                                member.MemberTypeID = _context.ApprovalMemberTypes.Single(MT => MT.MemberType == app.MemberType).MemberTypeID;
                                member.ApproverID = (from EMP in _context.Employees
                                                     where EMP.FirstName == app.Member.Substring(app.Member.LastIndexOf(".") + 1, app.Member.IndexOf(" ") - 3) &&
                                                     EMP.LastName == app.Member.Substring(app.Member.IndexOf(" ") + 1)
                                                     select EMP.EmployeeID).SingleOrDefault();
                                member.ApprovalStatusID = _context.ApprovalStatus.Single(APP => APP.ApprovalStatus1 == app.ApprovalStatusString).ApprovalStatusID;

                                member.ModifiedDate = DateTime.Now;

                                // generate automatic email notification for approving CCN request
                                automail = new EmailConfiguration();
                                automail.Module = obj.Module;
                                automail.KeyValue = ccn.CCNID;
                                automail.Action = "Approve";

                                //add both the originator and the owner as a recipient
                                automail.Recipients.Add(member.ApproverID);

                                //generate email request
                                automail.GenerateEmail();

                                break;
                            case RecordsStatus.REMOVED:      
                                if(app.MemberID != 0)
                                {
                                    member = _context.ChangeControlApprovalMembers.Single(MT => MT.MemberID == app.MemberID);
                                    _context.ChangeControlApprovalMembers.DeleteOnSubmit(member);
                                }
                                break;
                        }
                    }
                }


                _context.SubmitChanges();

                // generate automatic email notification for approving CCN request
                automail = new EmailConfiguration();
                automail.Module = obj.Module;
                automail.KeyValue = ccn.CCNID;
                automail.Action = "Update";

                //add both the originator and the owner as a recipient
                automail.Recipients.Add(ccn.OriginatorID);
                automail.Recipients.Add(ccn.OwnerID);

               

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                result = "Cannot find the related DCR record";
            }
            return result;
            
        }
        
        [WebMethod]
        public string updateDCRApproval(string json)
        {
            string result = String.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ApprovalMember obj = serializer.Deserialize<ApprovalMember>(json);

            var ccnmember = _context.ChangeControlApprovalMembers.Where(CCNMEM => CCNMEM.MemberID == obj.MemberID)
            .Select(CCNMEM => CCNMEM).SingleOrDefault();

            if (ccnmember != null)
            {
                ccnmember.ApprovalStatusID = _context.ApprovalStatus.Single(APP => APP.ApprovalStatus1 == obj.ApprovalStatusString).ApprovalStatusID;
                ccnmember.ApprovalRemarks = obj.ApprovalRemarks;
                ccnmember.ModifiedDate = DateTime.Now;
                ccnmember.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();


                //get all approvals of the CCN record

                int _approved = 0;
                int _pending = 0;
                int _declined = 0;

                var ccn = ccnmember.ChangeControlNote;
                foreach (var member in ccn.ChangeControlApprovalMembers)
                {
                    switch (member.ApprovalStatus.ApprovalStatus1)
                    {
                        case "APPROVED":
                            _approved++;
                            break;
                        case "DECLINED":
                            _declined++;
                            break;
                        case "PENDING":
                            _pending++;
                            break;
                    }
                }

                var document = ccn.Document;

                // if at least one decline and the rest is approved
                if ((_declined != 0 && _approved == ccn.ChangeControlApprovalMembers.Count - 1) || (_declined == ccn.ChangeControlApprovalMembers.Count))
                {
                    //check if the type of CCN is ISSUE

                    if (ccnmember.ChangeControlNote.CCNTypeID == (int)CCNType.ISSUE)
                    {
                        //set the status of the document to cancelled
                        document.DocumentStatusID = (int)DocStatus.Cancelled;
                        
                    }

                    //set CCN Status to closed 
                    ccnmember.ChangeControlNote.CCNStatusID = (int)CCNStatus.Closed;

                }
                else if (_approved == ccn.ChangeControlApprovalMembers.Count)
                {
                    

                    //update the status of the document according to CCN type
                    switch ((CCNType)ccn.CCNTypeID)
                    {
                        case CCNType.ISSUE:
                            document.DocumentStatusID = (int)DocStatus.Issued;
                            document.IssueDate = DateTime.Now;
                            break;
                        case CCNType.UPDATE:
                            document.DocumentStatusID = (int)DocStatus.Updated;
                            break;
                        case CCNType.WITHDRAW:
                            document.DocumentStatusID = (int)DocStatus.Withdrawn;
                            break;
                    }

                    //set CCN Status to closed 
                    ccnmember.ChangeControlNote.CCNStatusID = (int)CCNStatus.Closed;
                }


                //send the document record to archive if the status is cancelled or withdrawn
                switch ((DocStatus)document.DocumentStatusID)
                {
                    case DocStatus.Cancelled:
                    case DocStatus.Withdrawn:
                        document.RecordModeID = (int)RecordMode.Archived;
                        break;
                }

                //commit the document status changes
                _context.SubmitChanges();

                result = "Your decision has been committed sucessfully";

            }
            else
            {
                throw new Exception("Cannot find the approval member record");
            }
            return result;
        }

        #endregion
        #region DocumentList

        [WebMethod]
        public string[] loadDocumentStatus()
        {
            var docsts = (from STS in _context.DocumentStatus
                          select STS.DocumentStatus1).ToArray();
            return docsts;
        }

        [WebMethod]
        public string getLastDocumentID()
        {
            string documentID = null;

            if (_context.Documents.ToList().Count > 0)
            {
                long maxId = _context.Documents.Max(i => i.DocumentId);
                documentID = _context.Documents.Single(DOC => DOC.DocumentId == maxId).DocumentNo;
            }
            return documentID == null ? string.Empty : documentID;
        }
        [WebMethod]
        public string createNewDocument(string json)
        {
            string result = String.Empty;


            JavaScriptSerializer serializer = new JavaScriptSerializer();
            DocFile obj = serializer.Deserialize<DocFile>(json);
            var doc = _context.Documents.Where(DOC => DOC.DocumentNo == obj.DOCNo).Select(DOC => DOC).SingleOrDefault();
            if (doc == null)
            {
                doc = _context.Documents.Where(DOC => DOC.Title == obj.DOCTitle)
                    .Select(DOC => DOC).SingleOrDefault();

                if (doc == null)
                {
                    doc = new Document();
                    doc.DocumentNo = obj.DOCNo;
                    doc.Title = obj.DOCTitle;
                    doc.DocumentTypeID = obj.DOCType == string.Empty ? (int?)null : _context.DocumentTypes.Single(DT => DT.DocumentType1 == obj.DOCType).DocumentTypeID;
                    doc.DocumentFileTypeID = obj.DOCFileType == string.Empty ? (long?)null : _context.DocumentFileTypes.Single(DFT => DFT.FileType == obj.DOCFileType).DocumentFileTypeId;
                    doc.ReviewDuration = obj.ReviewDuration;
                    doc.PeriodID = _context.Periods.Single(PRD => PRD.Period1 == obj.ReviewPeriod).PeriodID;
                    doc.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
                    doc.DocumentStatusID = (int)obj.DOCStatus;
                    doc.ReviewDurationDays = obj.ReviewDurationDays;
                    doc.DepartmentID = obj.Department == string.Empty ? (int?)null : _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.Department).UnitID;
                    doc.ProjectID = obj.Project == string.Empty ? (int?)null : _context.ProjectInformations.Single(PROJ => PROJ.ProjectName == obj.Project).ProjectId;
                    doc.ModuleId = (int)obj.Module;
                    doc.RecordModeID = (int)obj.Mode;
                    doc.ModifiedDate = DateTime.Now;
                    doc.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    //setup issue CCN for the document
                    ChangeControlNote note = new ChangeControlNote();
                    note.CCNTypeID = (int)obj.CCNList[0].CCNType;


                    note.OriginatorID = (from EMP in _context.Employees
                                         where EMP.FirstName == obj.CCNList[0].Originator.Substring(obj.CCNList[0].Originator.LastIndexOf(".") + 1, obj.CCNList[0].Originator.IndexOf(" ") - 3) &&
                                         EMP.LastName == obj.CCNList[0].Originator.Substring(obj.CCNList[0].Originator.IndexOf(" ") + 1)
                                         select EMP.EmployeeID).SingleOrDefault();

                    note.OwnerID = (from EMP in _context.Employees
                                    where EMP.FirstName == obj.CCNList[0].Owner.Substring(obj.CCNList[0].Owner.LastIndexOf(".") + 1, obj.CCNList[0].Owner.IndexOf(" ") - 3) &&
                                    EMP.LastName == obj.CCNList[0].Owner.Substring(obj.CCNList[0].Owner.IndexOf(" ") + 1)
                                    select EMP.EmployeeID).SingleOrDefault();

                    note.OriginationDate = obj.CCNList[0].OrginationDate;
                    note.DocumentFileURL = obj.CCNList[0].DocumentFileURL == string.Empty ? null : obj.CCNList[0].DocumentFileURL;

                    if (obj.CCNList[0].DocumentFile != string.Empty)
                    {
                        try
                        {
                            note.DocumentFile = File.ReadAllBytes(obj.CCNList[0].DocumentFile);
                            note.DocumentFileName = obj.CCNList[0].DocumentFileName;
                        }
                        finally
                        {
                            File.Delete(obj.CCNList[0].DocumentFile);
                        }
                    }

                    note.CCNStatusID = (int)CCNStatus.Open;
                    note.ModuleId = (int)Modules.DocumentChangeRequest;
                    note.ModifiedDate = DateTime.Now;
                    note.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    doc.ChangeControlNotes.Add(note);

                    _context.Documents.InsertOnSubmit(doc);
                    _context.SubmitChanges();


                    // generate automatic email notification for adding new document list
                    EmailConfiguration automail = new EmailConfiguration();
                    automail.Module = obj.Module;
                    automail.KeyValue = doc.DocumentId;
                    automail.Action = "Add";

                    //add both the originator and the owner as a recipient
                    automail.Recipients.Add(note.OriginatorID);
                    automail.Recipients.Add(note.OwnerID);


                    try
                    {
                        bool isGenerated = automail.GenerateEmail();

                        if (isGenerated == true)
                        {
                            result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                        }
                        else
                        {
                            result = "Operation has been committed sucessfully";
                        }
                    }
                    catch (Exception ex)
                    {
                        result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                        result += "\n\n" + ex.Message;
                    }
                }
                else
                {
                    throw new Exception("The name of the document already exists");
                }
            }
            else
            {
                throw new Exception("The ID of the document must be unique");
            }
            return result;
        }
        [WebMethod]
        public string getDocument(string docno)
        {
            //get current document record
            var document = _context.Documents.Where(DOC => DOC.DocumentNo == docno)
            .Select(DOC => new DocFile
            {
                DOCID = DOC.DocumentId,
                DOCNo = DOC.DocumentNo,
                DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
                DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
                DOCTitle = DOC.Title,
                IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
                LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
                NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
                ReviewDuration = DOC.ReviewDuration,
                ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
                ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
                Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
                DOCStatus = ((DocStatus)DOC.DocumentStatusID),
                Mode = ((RecordMode)DOC.RecordModeID),
                Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
                Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
                
                Module = (Modules)DOC.ModuleId

            }).SingleOrDefault();

            if (document == null)
                throw new Exception("Cannot find the related document record");

            var xml = new XmlSerializer(typeof(DocFile));

            StringWriter str = new StringWriter();
            xml.Serialize(str, document);

            return str.ToString();
        }

        [WebMethod]
        public string loadCurrentDocuments(string type)
        {
            /*obtain all the issued and the updated documents only*/

            List<int> enums = new List<int>();
            enums.Add((int)DocStatus.Issued);
            enums.Add((int)DocStatus.Updated);

            List<DocFile> documents = new List<DocFile>();
            if (type == "All")
            {
                documents = _context.Documents
                .Where(DOC => enums.Contains(DOC.DocumentStatusID) && DOC.RecordModeID == (int)RecordMode.Current)
                .Select(DOC => new DocFile
                {
                    DOCID = DOC.DocumentId,
                    DOCNo = DOC.DocumentNo,
                    DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
                    DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
                    DOCTitle = DOC.Title,
                    IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
                    LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
                    NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
                    ReviewDuration = DOC.ReviewDuration,
                    ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
                    ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
                    Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
                    DOCStatus = ((DocStatus)DOC.DocumentStatusID),
                    Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
                    Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
                    Module = (Modules)DOC.ModuleId

                }).ToList();
            }
            else
            {
                documents = _context.Documents
                .Where(DOC => DOC.DocumentType.DocumentType1 == type && enums.Contains(DOC.DocumentStatusID) && DOC.RecordModeID == (int)RecordMode.Current)
                .Select(DOC => new DocFile
                {
                    DOCID = DOC.DocumentId,
                    DOCNo = DOC.DocumentNo,
                    DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
                    DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
                    DOCTitle = DOC.Title,
                    IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
                    LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
                    NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
                    ReviewDuration = DOC.ReviewDuration,
                    ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
                    ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
                    Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
                    DOCStatus = ((DocStatus)DOC.DocumentStatusID),
                    Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
                    Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
                    Module = (Modules)DOC.ModuleId

                }).ToList();
            }
            
            var xml = new XmlSerializer(typeof(List<DocFile>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, documents);

            return str.ToString();
        }
        
        [WebMethod]
        public string filterDocumentByStatus(string status)
        {
            var documents = _context.Documents
           .Where(DOC => DOC.DocumentStatus.DocumentStatus1 == status)
           .Select(DOC => new DocFile
           {
               DOCID = DOC.DocumentId,
               DOCNo = DOC.DocumentNo,
               DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
               DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
               DOCTitle = DOC.Title,
               IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
               LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
               NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
               ReviewDuration = DOC.ReviewDuration,
               ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
               ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
               Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
               DOCStatus = ((DocStatus)DOC.DocumentStatusID),
               Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
               Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
               CCNList = DOC.ChangeControlNotes
                .Select(C => new CCN
                {
                    CCNID = C.CCNID,
                    CCNType = (CCNType)C.CCNTypeID,
                    OrginationDate = ConvertToLocalTime(C.OriginationDate),
                    Originator = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == C.OriginatorID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    Owner = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == C.OwnerID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    Version = C.Version,
                    CCNStatus = (CCNStatus)C.CCNStatusID,
                    CCNDetails = C.Details == null ? string.Empty : C.Details,
                    DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                    DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                    Members = C.ChangeControlApprovalMembers
                    .Select(APRCN => new ApprovalMember
                    {
                        MemberID = APRCN.MemberID,
                        Member = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == APRCN.ApproverID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                        MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                        ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                        ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                        Status = RecordsStatus.ORIGINAL

                    }).ToList()
                }).ToList(),
               Module = (Modules)DOC.ModuleId

           }).ToList();

           var xml = new XmlSerializer(typeof(List<DocFile>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, documents);

           return str.ToString();
           
       }
        [WebMethod]
        public string filterDocumentByType(string type)
        {
            var documents = _context.Documents
           .Where(DOC => DOC.DocumentType.DocumentType1 == type)
           .Select(DOC => new DocFile
           {
               DOCID = DOC.DocumentId,
               DOCNo = DOC.DocumentNo,
               DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
               DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
               DOCTitle = DOC.Title,
               IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
               LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
               NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
               ReviewDuration = DOC.ReviewDuration,
               ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
               ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
               Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
               DOCStatus = ((DocStatus)DOC.DocumentStatusID),
               Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
               Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
               CCNList = DOC.ChangeControlNotes
               .Select(C => new CCN
               {
                   CCNID = C.CCNID,
                   CCNType = (CCNType)C.CCNTypeID,
                   OrginationDate = ConvertToLocalTime(C.OriginationDate),
                   Originator = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == C.OriginatorID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Owner = (from T in _context.Titles
                            join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                            from g in empgroup
                            where g.EmployeeID == C.OwnerID
                            select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Version = C.Version,
                   CCNStatus = (CCNStatus)C.CCNStatusID,
                   CCNDetails = C.Details == null ? string.Empty : C.Details,
                   DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                   DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                   Members = C.ChangeControlApprovalMembers
                   .Select(APRCN => new ApprovalMember
                   {
                       MemberID = APRCN.MemberID,
                       Member = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == APRCN.ApproverID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                       MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                       ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                       ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                       Status = RecordsStatus.ORIGINAL

                   }).ToList()
               }).ToList(),
               Module = (Modules)DOC.ModuleId

           }).ToList();

            var xml = new XmlSerializer(typeof(List<DocFile>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, documents);

            return str.ToString();
        }

        [WebMethod]
        public string filterDocumentsByDCROriginationDate(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var documents = _context.Documents
             .Select(DOC => new DocFile
             {
                 DOCID = DOC.DocumentId,
                 DOCNo = DOC.DocumentNo,
                 DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
                 DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
                 DOCTitle = DOC.Title,
                 IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
                 LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
                 NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
                 ReviewDuration = DOC.ReviewDuration,
                 ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
                 ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
                 Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
                 DOCStatus = ((DocStatus)DOC.DocumentStatusID),
                 Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
                 Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
                 CCNList = DOC.ChangeControlNotes
                 .Where(C => C.OriginationDate >= obj.StartDate && C.OriginationDate <= obj.EndDate)
                 .Select(C => new CCN
                 {
                     CCNID = C.CCNID,
                     CCNType = (CCNType)C.CCNTypeID,
                     OrginationDate = ConvertToLocalTime(C.OriginationDate),
                     Originator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == C.OriginatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                     Owner = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == C.OwnerID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                     Version = C.Version,
                     CCNStatus = (CCNStatus)C.CCNStatusID,
                     CCNDetails = C.Details == null ? string.Empty : C.Details,
                     DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                     DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                     Members = C.ChangeControlApprovalMembers
                     .Select(APRCN => new ApprovalMember
                     {
                         MemberID = APRCN.MemberID,
                         Member = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == APRCN.ApproverID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                         MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                         ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                         ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                         Status = RecordsStatus.ORIGINAL

                     }).ToList()
                 }).ToList(),
                 Module = (Modules)DOC.ModuleId

             }).ToList();

            var xml = new XmlSerializer(typeof(List<DocFile>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, documents);

            return str.ToString();
        }

       [WebMethod]
       public string filterDocumentsByIssueDate(string json)
       {
           JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
           DateParam obj = jsonserializer.Deserialize<DateParam>(json);

           var documents = _context.Documents
           .Where(DOC => DOC.IssueDate >= obj.StartDate && DOC.IssueDate <= obj.EndDate)
            .Select(DOC => new DocFile
            {
                DOCID = DOC.DocumentId,
                DOCNo = DOC.DocumentNo,
                DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
                DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
                DOCTitle = DOC.Title,
                IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
                LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
                NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
                ReviewDuration = DOC.ReviewDuration,
                ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
                ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
                Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
                DOCStatus = ((DocStatus)DOC.DocumentStatusID),
                Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
                Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
                CCNList = DOC.ChangeControlNotes
                .Select(C => new CCN
                {
                   CCNID = C.CCNID,
                   CCNType = (CCNType)C.CCNTypeID,
                   OrginationDate = ConvertToLocalTime(C.OriginationDate),
                   Originator = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == C.OriginatorID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Owner = (from T in _context.Titles
                            join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                            from g in empgroup
                            where g.EmployeeID == C.OwnerID
                            select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Version = C.Version,
                   CCNStatus = (CCNStatus)C.CCNStatusID,
                   CCNDetails = C.Details == null ? string.Empty : C.Details,
                   DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                   DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                   Members = C.ChangeControlApprovalMembers
                   .Select(APRCN => new ApprovalMember
                   {
                       MemberID = APRCN.MemberID,
                       Member = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == APRCN.ApproverID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                       MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                       ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                       ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                       Status = RecordsStatus.ORIGINAL

                   }).ToList()
               }).ToList(),
               Module = (Modules)DOC.ModuleId

            }).ToList();

           var xml = new XmlSerializer(typeof(List<DocFile>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, documents);

           return str.ToString();
       }

       [WebMethod]
       public string filterDocumentByName(string title)
       {
           var documents = _context.Documents
          .Where(DOC => DOC.Title.StartsWith(title))
          .Select(DOC => new DocFile
          {
              DOCID = DOC.DocumentId,
              DOCNo = DOC.DocumentNo,
              DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
              DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
              DOCTitle = DOC.Title,
              IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
              LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
              NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
              ReviewDuration = DOC.ReviewDuration,
              ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
              ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
              Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
              DOCStatus = ((DocStatus)DOC.DocumentStatusID),
              Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
              Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
              CCNList = DOC.ChangeControlNotes
              .Select(C => new CCN
              {
                  CCNID = C.CCNID,
                  CCNType = (CCNType)C.CCNTypeID,
                  OrginationDate = ConvertToLocalTime(C.OriginationDate),
                  Originator = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == C.OriginatorID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == C.OwnerID
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Version = C.Version,
                  CCNStatus = (CCNStatus)C.CCNStatusID,
                  CCNDetails = C.Details == null ? string.Empty : C.Details,
                  DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                  DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                  Members = C.ChangeControlApprovalMembers
                  .Select(APRCN => new ApprovalMember
                  {
                      MemberID = APRCN.MemberID,
                      Member = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == APRCN.ApproverID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                      MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                      ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                      ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                      Status = RecordsStatus.ORIGINAL

                  }).ToList()
              }).ToList(),
              Module = (Modules)DOC.ModuleId

          }).ToList();

           var xml = new XmlSerializer(typeof(List<DocFile>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, documents);

           return str.ToString();
           
       }

       [WebMethod]
       public string filterDocumentByMode(string mode)
       {
           var documents = _context.Documents
          .Where(DOC => DOC.RecordMode.RecordMode1 == mode)
          .Select(DOC => new DocFile
          {
              DOCID = DOC.DocumentId,
              DOCNo = DOC.DocumentNo,
              DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
              DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
              DOCTitle = DOC.Title,
              IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
              LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
              NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
              ReviewDuration = DOC.ReviewDuration,
              ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
              ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
              Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
              DOCStatus = ((DocStatus)DOC.DocumentStatusID),
              Mode=(RecordMode)DOC.RecordModeID,
              Department = DOC.DepartmentID.HasValue == false ? string.Empty : _context.OrganizationUnits.Single(ORG => ORG.UnitID == DOC.DepartmentID).UnitName,
              Project = DOC.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == DOC.ProjectID).ProjectName,
              CCNList = DOC.ChangeControlNotes
              .Select(C => new CCN
              {
                  CCNID = C.CCNID,
                  CCNType = (CCNType)C.CCNTypeID,
                  OrginationDate = ConvertToLocalTime(C.OriginationDate),
                  Originator = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == C.OriginatorID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Owner = (from T in _context.Titles
                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                           from g in empgroup
                           where g.EmployeeID == C.OwnerID
                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  Version = C.Version,
                  CCNStatus = (CCNStatus)C.CCNStatusID,
                  CCNDetails = C.Details == null ? string.Empty : C.Details,
                  DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                  DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                  Members = C.ChangeControlApprovalMembers
                  .Select(APRCN => new ApprovalMember
                  {
                      MemberID = APRCN.MemberID,
                      Member = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == APRCN.ApproverID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                      MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                      ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                      ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                      Status = RecordsStatus.ORIGINAL

                  }).ToList()
              }).ToList(),
              Module = (Modules)DOC.ModuleId

          }).ToList();

           var xml = new XmlSerializer(typeof(List<DocFile>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, documents);

           return str.ToString();

       }
       [WebMethod]
       public string loadDocumentList()
       {
           //get all current document records
           var documents = _context.Documents
           .Select(DOC => new DocFile
           {
               DOCID = DOC.DocumentId,
               DOCNo = DOC.DocumentNo,
               DOCType = DOC.DocumentTypeID.HasValue == false ? string.Empty : _context.DocumentTypes.Single(DT => DT.DocumentTypeID == DOC.DocumentTypeID).DocumentType1,
               DOCFileType = DOC.DocumentFileTypeID.HasValue == false ? string.Empty : _context.DocumentFileTypes.Single(DFT => DFT.DocumentFileTypeId == DOC.DocumentFileTypeID).FileType,
               DOCTitle = DOC.Title,
               IssueDate = DOC.IssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.IssueDate)),
               LastReviewDate = DOC.LastReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.LastReviewDate)),
               NextReviewDate = DOC.NextReviewDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(DOC.NextReviewDate)),
               ReviewDuration = DOC.ReviewDuration,
               ReviewDurationDays = DOC.ReviewDurationDays.HasValue == false ? 0 : Convert.ToInt32(DOC.ReviewDurationDays),
               ReviewPeriod = _context.Periods.Single(P => P.PeriodID == DOC.PeriodID).Period1,
               Remarks = DOC.Remarks == null ? string.Empty : DOC.Remarks,
               DOCStatus = ((DocStatus)DOC.DocumentStatusID),
               Mode = ((RecordMode)DOC.RecordModeID),
               Department=DOC.DepartmentID.HasValue==false?string.Empty:_context.OrganizationUnits.Single(ORG=>ORG.UnitID==DOC.DepartmentID).UnitName,
               Project=DOC.ProjectID.HasValue==false?string.Empty:_context.ProjectInformations.Single(PRJ=>PRJ.ProjectId==DOC.ProjectID).ProjectName,
               CCNList = DOC.ChangeControlNotes
               .Select(C => new CCN
               {
                   CCNID = C.CCNID,
                   CCNType = (CCNType)C.CCNTypeID,
                   OrginationDate = ConvertToLocalTime(C.OriginationDate),
                   Originator = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == C.OriginatorID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Owner = (from T in _context.Titles
                            join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                            from g in empgroup
                            where g.EmployeeID == C.OwnerID
                            select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   Version = C.Version,
                   CCNStatus = (CCNStatus)C.CCNStatusID,
                   CCNDetails = C.Details == null ? string.Empty : C.Details,
                   DocumentFileURL = C.DocumentFileURL == null ? string.Empty : C.DocumentFileURL,
                   DocumentFileName = C.DocumentFileName == null ? string.Empty : C.DocumentFileName,
                   Members = C.ChangeControlApprovalMembers
                   .Select(APRCN => new ApprovalMember
                   {
                       MemberID = APRCN.MemberID,
                       Member = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == APRCN.ApproverID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                       MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APRCN.MemberTypeID).MemberType,
                       ApprovalStatus = (ApprovalStatus)APRCN.ApprovalStatusID,
                       ApprovalRemarks = APRCN.ApprovalRemarks == null ? string.Empty : APRCN.ApprovalRemarks,
                       Status = RecordsStatus.ORIGINAL

                   }).ToList()
               }).ToList(),
               Module = (Modules)DOC.ModuleId

           }).ToList();

           var xml = new XmlSerializer(typeof(List<DocFile>));

           StringWriter str = new StringWriter();
           xml.Serialize(str, documents);

           return str.ToString();
       }

       [WebMethod]
       public string updateDocument(string json)
       {
           string result = string.Empty;

           JavaScriptSerializer serializer = new JavaScriptSerializer();
           DocFile obj = serializer.Deserialize<DocFile>(json);

           var doc = _context.Documents.Where(DOC => DOC.DocumentNo == obj.DOCNo)
               .Select(DOC => DOC).SingleOrDefault();

           if (doc != null)
           {
               doc = _context.Documents.Single(DOC => DOC.DocumentNo == obj.DOCNo);
               doc.DocumentTypeID = obj.DOCType == string.Empty ? (int?)null : _context.DocumentTypes.Single(DT => DT.DocumentType1 == obj.DOCType).DocumentTypeID;
               doc.DocumentFileTypeID = obj.DOCFileType == string.Empty ? (long?)null : _context.DocumentFileTypes.Single(DFT => DFT.FileType == obj.DOCFileType).DocumentFileTypeId;
               doc.DocumentStatusID = _context.DocumentStatus.Single(DS => DS.DocumentStatus1 == obj.DOCStatusString).DocumentStatusID;
               doc.Title = obj.DOCTitle;
               doc.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
               doc.ReviewDuration = obj.ReviewDuration;
               doc.PeriodID = _context.Periods.Single(P => P.Period1 == obj.ReviewPeriod).PeriodID;
               doc.ReviewDurationDays = obj.ReviewDurationDays;
               doc.LastReviewDate = obj.LastReviewDate == null ? (DateTime?)null : Convert.ToDateTime(obj.LastReviewDate);
               doc.NextReviewDate = obj.NextReviewDate == null ? (DateTime?)null : Convert.ToDateTime(obj.NextReviewDate);
               doc.DepartmentID = obj.Department == string.Empty ? (int?)null : _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.Department).UnitID;
               doc.ProjectID = obj.Project == string.Empty ? (int?)null : _context.ProjectInformations.Single(PROJ => PROJ.ProjectName == obj.Project).ProjectId;
               doc.ModifiedDate = DateTime.Now;
               doc.ModifiedBy = HttpContext.Current.User.Identity.Name;
                
               _context.SubmitChanges();

               //get the cnn record of type issue
               var ccn = doc.ChangeControlNotes.Where(CCN => CCN.CCNTypeID == (int)CCNType.ISSUE).Select(CCN => CCN).SingleOrDefault();
               if (ccn != null)
               {
                   EmailConfiguration automail = new EmailConfiguration();
                   automail.Module = obj.Module;
                   automail.KeyValue = doc.DocumentId;
                   automail.Action = "Update";

                   automail.Recipients.Add(ccn.OriginatorID);
                   automail.Recipients.Add(ccn.OwnerID);

                   bool isGenerated = automail.GenerateEmail();
                   if (isGenerated == true)
                   {

                       result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";

                   }
                   else
                   {
                       result = "Operation has been committed sucessfully";

                   }
               }
           }
           else
           {
               result = "Cannot find the related document record";
           }
           return result;
       }

       [WebMethod]
       public void removeDocument(int ID)
       {
           string result = String.Empty;

           var doc = _context.Documents.Where(DOC => DOC.DocumentId == ID)
               .Select(DOC => DOC).SingleOrDefault();

           if (doc != null)
           {
               if (doc.Assets.Count > 0 || doc.Assets1.Count > 0 || doc.Assets2.Count > 0)
               {

                   throw new Exception("Cannot remove the select document record, since it is associated with one or more asset record(s)");
               }
               else
               {
                   _context.Documents.DeleteOnSubmit(doc);
                   _context.SubmitChanges();
               }
             
           }
           else
           {
               throw new Exception("Cannot find the related document record");
           }


       }


        [WebMethod]
        public void removeDocumentFileType(int ID)
        {
            var docftype = _context.DocumentFileTypes.Where(DFT => DFT.DocumentFileTypeId == ID)
                .Select(DT => DT).SingleOrDefault();

            if (docftype != null)
            {
                _context.DocumentFileTypes.DeleteOnSubmit(docftype);
                _context.SubmitChanges();
            }
        }

        [WebMethod]
        public string getDocumentFileType()
        {
            var doctype = _context.DocumentFileTypes
                .Select(DFT => new DocFileType
                {
                    DocFileTypeID=DFT.DocumentFileTypeId,
                    FileType = DFT.FileType,
                    Extension = DFT.Extention,
                    ContentType = DFT.ContentType
                 }).ToList();

            var xml = new XmlSerializer(typeof(List<DocFileType>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, doctype);

            return str.ToString();
        }

        [WebMethod]
        public void updateDocumentFileType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            DocFileType obj = serializer.Deserialize<DocFileType>(json);

            var docfiletype = _context.DocumentFileTypes.Where(DFT => DFT.DocumentFileTypeId == obj.DocFileTypeID)
            .Select(DFT => DFT).SingleOrDefault();

            if (docfiletype != null)
            {
                docfiletype.FileType = obj.FileType;
                docfiletype.Extention = obj.Extension;
                docfiletype.ContentType = obj.ContentType;
                if (obj.Icon != string.Empty)
                {
                    try
                    {
                        docfiletype.Icon = File.ReadAllBytes(obj.Icon);
                    }
                    finally
                    {
                        File.Delete(obj.Icon);
                    }
                }
                docfiletype.ModifiedDate = DateTime.Now;
                docfiletype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related document file type");
            }
   
        }
        [WebMethod]
        //insert new document file type to the database 
        public void createDocumentFileType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            DocFileType obj = serializer.Deserialize<DocFileType>(json);

            var docfiletype = _context.DocumentFileTypes.Where(DFT => DFT.FileType == obj.FileType || DFT.ContentType == obj.ContentType || DFT.Extention == obj.Extension)
                .Select(DOCTYP => DOCTYP).FirstOrDefault();
            if (docfiletype == null)
            {
                docfiletype = new DocumentFileType();
                docfiletype.FileType = obj.FileType;
                docfiletype.Extention = obj.Extension;
                docfiletype.ContentType = obj.ContentType;
                if (obj.Icon != string.Empty)
                {
                    try
                    {
                        docfiletype.Icon = File.ReadAllBytes(obj.Icon);
                    }
                    finally
                    {
                        File.Delete(obj.Icon);
                    }
                }
                docfiletype.ModifiedDate = DateTime.Now;
                docfiletype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.DocumentFileTypes.InsertOnSubmit(docfiletype);
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("The document file type already exists");
            }
        }
        #endregion
        #region CustomerManagement
       
        [WebMethod]
        public string getLastCustomerID()
        {
            string customerID = null;

            if (_context.Customers.ToList().Count > 0)
            {
                long maxId = _context.Customers.Max(i => i.CustomerID);
                customerID = _context.Customers.Single(CUST => CUST.CustomerID == maxId).CustomerReference;
            }
            return customerID == null ? string.Empty : customerID;
        }
        [WebMethod]
        public string getCustomer(string custID)
        {

            var customer = (from CUST in _context.Customers
                            where CUST.CustomerReference == custID
                            select new Customer
                            {
                                CustomerNo=CUST.CustomerReference,
                                CustomerID=CUST.CustomerID,
                                CustomerName=CUST.CustomerName,
                                CustomerType=CUST.CustomerType.CustomerType1,
                                EmailAddress = CUST.EmailAddress == null ? string.Empty : CUST.EmailAddress,
                                Website=CUST.Website,
                                ContactPerson=CUST.ContactPerson
                            }).SingleOrDefault();

            if (customer == null)
            {
                throw new Exception("Unable to find the specified customer");
            }

            var serializer = new XmlSerializer(typeof(Customer));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, customer);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterCustomerByType(string type)
        {
            var customers = _context.Customers.Join(_context.CustomerTypes,
                 CUST => CUST.CustomerTypeID, TYP => TYP.CustomerTypeID, (CUST, TYP) => new { CUST, TYP })
                 .OrderBy(C => C.CUST.CustomerName)
                 .Select(C => new Customer
                 {
                     CustomerID = C.CUST.CustomerID,
                     CustomerNo = C.CUST.CustomerReference,
                     CustomerType = C.TYP.CustomerType1,
                     ContactPerson = C.CUST.ContactPerson == null ? string.Empty : C.CUST.ContactPerson,
                     CustomerName = C.CUST.CustomerName,
                     EmailAddress = C.CUST.EmailAddress == null ? string.Empty : C.CUST.EmailAddress,
                     Website = C.CUST.Website == null ? string.Empty : C.CUST.Website,
                     Address = C.CUST.CustomerAddresses
                     .Select(ADDR => new CustomerAddress
                     {
                         AddressID = ADDR.CustomerAddressID,
                         AddressLine1 = ADDR.AddressLine1,
                         AddressLine2 = ADDR.AddressLine2 == null ? string.Empty : ADDR.AddressLine2,
                         City = ADDR.City,
                         Country = ADDR.Country.CountryName,
                         CountryID = ADDR.CountryID == null  ? 0 : Convert.ToInt32(ADDR.CountryID),
                         StateID = ADDR.StateID == null ? 0 : Convert.ToInt32(ADDR.StateID),
                         CityID = ADDR.CityID == null ? 0 : Convert.ToInt32(ADDR.CityID),
                         PostalCode = ADDR.PostalCode == null ? string.Empty : ADDR.PostalCode
                     }).SingleOrDefault(),
                     Contacts = C.CUST.CustomerContacts
                     .Select(CONT => new CustomerContact
                     {
                         ContactID = CONT.ContactID,
                         Number = CONT.ContactNumber,
                         Type = CONT.PhoneNumberType.Name
                     }).ToList()

                 })
                 .Where(CUST => CUST.CustomerType==type).ToList();

            var serializer = new XmlSerializer(typeof(List<Customer>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, customers);

            return strwriter.ToString();
        }
        [WebMethod]
        public string filterCustomerByName(string name)
        {
           var customers = _context.Customers.Join(_context.CustomerTypes,
                CUST => CUST.CustomerTypeID, TYP => TYP.CustomerTypeID, (CUST, TYP) => new { CUST, TYP })
                .OrderBy(C => C.CUST.CustomerName)
                .Select(C => new Customer
                {
                    CustomerID = C.CUST.CustomerID,
                    CustomerNo = C.CUST.CustomerReference,
                    CustomerType = C.TYP.CustomerType1,
                    ContactPerson = C.CUST.ContactPerson == null ? string.Empty : C.CUST.ContactPerson,
                    CustomerName = C.CUST.CustomerName,
                    EmailAddress = C.CUST.EmailAddress == null ? string.Empty : C.CUST.EmailAddress,
                    Website = C.CUST.Website == null ? string.Empty : C.CUST.Website,
                    Address = C.CUST.CustomerAddresses
                    .Select(ADDR => new CustomerAddress
                    {
                        AddressID = ADDR.CustomerAddressID,
                        AddressLine1 = ADDR.AddressLine1,
                        AddressLine2 = ADDR.AddressLine2 == null ? string.Empty : ADDR.AddressLine2,
                        City = ADDR.City,
                        Country = ADDR.Country.CountryName,
                        CountryID = ADDR.CountryID == null ? 0 : Convert.ToInt32(ADDR.CountryID),
                        StateID = ADDR.StateID == null ? 0 : Convert.ToInt32(ADDR.StateID),
                        CityID = ADDR.CityID == null ? 0 : Convert.ToInt32(ADDR.CityID),
                        PostalCode = ADDR.PostalCode == null ? string.Empty : ADDR.PostalCode
                    }).SingleOrDefault(),
                    Contacts = C.CUST.CustomerContacts
                    .Select(CONT => new CustomerContact
                    {
                        ContactID = CONT.ContactID,
                        Number = CONT.ContactNumber,
                        Type = CONT.PhoneNumberType.Name
                    }).ToList()

                })
                .Where(CUST=>CUST.CustomerName.StartsWith(name)).ToList();

           var serializer = new XmlSerializer(typeof(List<Customer>));

           StringWriter strwriter = new StringWriter();
           serializer.Serialize(strwriter, customers);

           return strwriter.ToString();
        }

        [WebMethod]
        public void removeCustomerType(int ID)
        {
            var customertype = _context.CustomerTypes.Where(CTYP => CTYP.CustomerTypeID == ID).Select(CTYP => CTYP).SingleOrDefault();
            if (customertype != null)
            {
                _context.CustomerTypes.DeleteOnSubmit(customertype);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related external party type record");
            }
        }

        [WebMethod]
        public string loadCustomerType()
        {
            var customertypes = _context.CustomerTypes.Select(CTYP => new GenericType
            {
                TypeID = CTYP.CustomerTypeID,
                TypeName = CTYP.CustomerType1,
                Description = CTYP.Description == null ? string.Empty : CTYP.Description
            }).ToList();

            var serializer = new XmlSerializer(typeof(List<GenericType>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, customertypes);

            return strwriter.ToString();
        }

        [WebMethod]
        public object[] loadCustomerType2()
        {

            var customertypes = (from ct in _context.CustomerTypes
                                 select new { ct.CustomerType1, ct.CustomerTypeID }).ToArray();

            return customertypes;
        }

        [WebMethod]
        public object[] loadCustomersByTypeId(int typeId)
        {
            var customers = (from c in _context.Customers
                             where c.CustomerTypeID == typeId
                             select new { c.CustomerID, c.CustomerName }).ToArray();

            return customers;
        }

        [WebMethod]
        public string[] loadContactType()
        {
            var ctype = (from CTYP in _context.PhoneNumberTypes
                         select CTYP.Name).ToArray();
            return ctype;
        }
        
     
        [WebMethod]
        public string loadCustomers()
        {
            var customer = _context.Customers.Join(_context.CustomerTypes,
                CUST => CUST.CustomerTypeID, TYP => TYP.CustomerTypeID, (CUST, TYP) => new { CUST, TYP }).OrderBy(C => C.CUST.CustomerName)
                .Select(C => new Customer
                {
                    CustomerID = C.CUST.CustomerID,
                    CustomerNo = C.CUST.CustomerReference,
                    CustomerType = C.TYP.CustomerType1,
                    ContactPerson=C.CUST.ContactPerson==null?string.Empty:C.CUST.ContactPerson,
                    CustomerName = C.CUST.CustomerName,
                    EmailAddress = C.CUST.EmailAddress == null ? string.Empty : C.CUST.EmailAddress,
                    Website = C.CUST.Website == null ? string.Empty : C.CUST.Website,
                    Address=C.CUST.CustomerAddresses
                    .Select(ADDR=>new CustomerAddress
                    {
                        AddressID=ADDR.CustomerAddressID,
                        AddressLine1=ADDR.AddressLine1,
                        AddressLine2=ADDR.AddressLine2==null?string.Empty:ADDR.AddressLine2,
                        City=ADDR.City,
                        Country=ADDR.Country.CountryName,
                        CountryID = ADDR.CountryID == null ? 0 : Convert.ToInt32(ADDR.CountryID),
                        StateID = ADDR.StateID == null ? 0 : Convert.ToInt32(ADDR.StateID),
                        CityID = ADDR.CityID == null ? 0 : Convert.ToInt32(ADDR.CityID),
                        PostalCode=ADDR.PostalCode==null?string.Empty:ADDR.PostalCode
                    }).SingleOrDefault(),
                    Contacts=C.CUST.CustomerContacts
                    .Select(CONT=>new CustomerContact
                    {
                        ContactID=CONT.ContactID,
                        Number=CONT.ContactNumber,
                        Type=CONT.PhoneNumberType.Name
                    }).ToList()

                }).ToList();

            var serializer = new XmlSerializer(typeof(List<Customer>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, customer);

            return strwriter.ToString();
        }

        [WebMethod]
        public void updateCustomer(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Customer obj = serializer.Deserialize<Customer>(json);

            var customer = _context.Customers.Where(CUST => CUST.CustomerReference == obj.CustomerNo)
                    .Select(CUST => CUST).SingleOrDefault();

            if (customer != null)
            {
                customer.CustomerName = obj.CustomerName;
                customer.CustomerReference = obj.CustomerNo;
                customer.CustomerTypeID = _context.CustomerTypes.Single(CT => CT.CustomerType1 == obj.CustomerType).CustomerTypeID;
                customer.Website = obj.Website == string.Empty ? null : obj.Website;
                customer.EmailAddress = obj.EmailAddress == string.Empty ? null : obj.EmailAddress;
                customer.ContactPerson = obj.ContactPerson == string.Empty ? null : obj.ContactPerson;
                customer.ModifiedDate = DateTime.Now;
                customer.ModifiedBy = HttpContext.Current.User.Identity.Name;

                var address = customer.CustomerAddresses.First();
                if (address != null)
                {
                    address.AddressLine1 = obj.Address.AddressLine1;
                    address.AddressLine2 = obj.Address.AddressLine2 == string.Empty ? null : obj.Address.AddressLine2;
                    //address.CountryID = _context.Countries.Single(CTRY => CTRY.CountryName == obj.Address.Country).CountryID;
                    address.CountryID = obj.Address.CountryID;
                    if (address.CountryID == 1 || address.CountryID == 2 || address.CountryID == 95)
                    {
                        address.StateID = obj.Address.StateID;
                    }
                    else
                    {
                        address.StateID = null;
                    }
                    address.CityID = obj.Address.CityID;
                    address.City = obj.Address.City;
                    address.PostalCode = obj.Address.PostalCode == string.Empty ? null : obj.Address.PostalCode;
                    address.ModifiedDate = DateTime.Now;
                    address.ModifiedBy = HttpContext.Current.User.Identity.Name;
                }

                if (obj.Contacts != null)
                {
                    LINQConnection.CustomerContact contact;
                    foreach (var cont in obj.Contacts)
                    {
                        switch (cont.Status)
                        {
                            case RecordsStatus.ADDED:

                                contact = new LINQConnection.CustomerContact();
                                contact.ContactNumber = cont.Number;
                                contact.ContactTypeID = _context.PhoneNumberTypes.Single(PH => PH.Name == cont.Type).PhoneNumberTypeId;
                                contact.ModifiedDate = DateTime.Now;
                                contact.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                customer.CustomerContacts.Add(contact);
                                break;
                            case RecordsStatus.MODIFIED:
                                contact = customer.CustomerContacts.Where(CONT => CONT.ContactID == cont.ContactID)
                                    .Select(CONT => CONT).SingleOrDefault();

                                contact.ContactNumber = cont.Number;
                                contact.ContactTypeID = _context.PhoneNumberTypes.Single(PH => PH.Name == cont.Type).PhoneNumberTypeId;
                                contact.ModifiedDate = DateTime.Now;
                                contact.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                break;
                            case RecordsStatus.REMOVED:
                                contact = customer.CustomerContacts.Where(CONT => CONT.ContactID == cont.ContactID)
                                    .Select(CONT => CONT).SingleOrDefault();
                                _context.CustomerContacts.DeleteOnSubmit(contact);
                                break;
                        }
                    }
                }
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related affected party record");

            }
        }
        
        [WebMethod]
        public void createCustomerType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            GenericType obj = serializer.Deserialize<GenericType>(json);


            var custtype = _context.CustomerTypes.Where(TYP => TYP.CustomerType1 == obj.TypeName).Select(TYP => TYP).SingleOrDefault();
            if (custtype == null)
            {
                custtype = new LINQConnection.CustomerType();
                custtype.CustomerType1 = obj.TypeName;
                custtype.Description = obj.Description;
                custtype.ModifiedDate = DateTime.Now;
                custtype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.CustomerTypes.InsertOnSubmit(custtype);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The type of the external party already exists"); 
            }
        }

        [WebMethod]
        public void createNewCustomer(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Customer obj = serializer.Deserialize<Customer>(json);

            var customer = _context.Customers.Where(CUST => CUST.CustomerName == obj.CustomerName)
                .Select(CUST => CUST).SingleOrDefault();

            if (customer == null)
            {

                customer = new LINQConnection.Customer();
                customer.CustomerName = obj.CustomerName;
                customer.CustomerReference = obj.CustomerNo;
                customer.CustomerTypeID = _context.CustomerTypes.Single(CT => CT.CustomerType1 == obj.CustomerType).CustomerTypeID;
                customer.Website = obj.Website == string.Empty ? null : obj.Website;
                customer.EmailAddress = obj.EmailAddress == string.Empty ? null : obj.EmailAddress;
                customer.ContactPerson = obj.ContactPerson == string.Empty ? null : obj.ContactPerson;
                customer.ModifiedDate = DateTime.Now;
                customer.ModifiedBy = HttpContext.Current.User.Identity.Name;

                LINQConnection.CustomerAddress address = new LINQConnection.CustomerAddress();
                address.AddressLine1 = obj.Address.AddressLine1;
                address.AddressLine2 = obj.Address.AddressLine2 == string.Empty ? null : obj.Address.AddressLine2;
                //address.CountryID = _context.Countries.Single(CTRY => CTRY.CountryName == obj.Address.Country).CountryID;
                //address.City = obj.Address.City;
                address.CountryID = obj.Address.CountryID;
                if (address.CountryID == 1 || address.CountryID == 2 || address.CountryID == 95)
                {
                    address.StateID = obj.Address.StateID;
                }
                else
                {
                    address.StateID = null;
                }
                address.CityID = obj.Address.CityID;
                address.City = obj.Address.City;
                address.PostalCode = obj.Address.PostalCode == string.Empty ? null : obj.Address.PostalCode;
                address.ModifiedDate = DateTime.Now;
                address.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.Contacts != null)
                {
                    foreach (var cont in obj.Contacts)
                    {
                        LINQConnection.CustomerContact contact = new LINQConnection.CustomerContact();
                        contact.ContactNumber = cont.Number;
                        contact.ContactTypeID = _context.PhoneNumberTypes.Single(PH => PH.Name == cont.Type).PhoneNumberTypeId;
                        contact.ModifiedDate = DateTime.Now;
                        contact.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        customer.CustomerContacts.Add(contact);
                    }
                }

                customer.CustomerAddresses.Add(address);

                _context.Customers.InsertOnSubmit(customer);

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("The name of the affected party already exists");

            }
        }
       
        [WebMethod]
        public void removeCustomer(int customerID)
        {
            string result = string.Empty;

            var customer = _context.Customers.Where(CUST => CUST.CustomerID == customerID)
                .Select(CUST => CUST).SingleOrDefault();
            if (customer != null)
            {
                if (customer.Assets.Count > 0 || customer.Assets1.Count > 0)
                {
                    throw new Exception("The name of the customer is referenced in one or more asset records, please make sure you remove this reference and try again");      
                }
                else
                {
                    _context.Customers.DeleteOnSubmit(customer);
                    _context.SubmitChanges();
                }
            }
            else
            {

                throw new Exception("Cannot find the related affected party record");
            }
        }
        
        #endregion

        #region Severity
        [WebMethod]
        public void removeSeverity(int severityID)
        {
            var severity = _context.Severities.Where(SVR => SVR.SeverityID == severityID)
                .Select(SVR => SVR).SingleOrDefault();
            if (severity != null)
            {
                _context.Severities.DeleteOnSubmit(severity);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related severity record");
            }
        }
        [WebMethod]
        public void updateSeverity(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Severity obj = serializer.Deserialize<Severity>(json);

            var severity = _context.Severities.Where(SVR => SVR.SeverityID == obj.SeverityID)
                    .Select(SVR => SVR).SingleOrDefault();

            if (severity != null)
            {
                severity.Criteria = obj.Criteria;
                severity.Value = obj.SeverityValue;
                severity.Score = obj.Score;
                severity.ModifiedDate = DateTime.Now;
                severity.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related severity record");
            }
        }
        [WebMethod]
        public void createSeverity(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Severity obj = serializer.Deserialize<Severity>(json);

            var severity = _context.Severities.Where(SVR => SVR.Criteria == obj.Criteria)
                .Select(SVR => SVR).SingleOrDefault();

            if (severity == null)
            {
                severity = new LINQConnection.Severity();
                severity.Criteria = obj.Criteria;
                severity.Value = obj.SeverityValue;
                severity.Score = obj.Score;
                severity.ModifiedDate = DateTime.Now;
                severity.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.Severities.InsertOnSubmit(severity);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the severity criteria already exists");
            }
        }
        [WebMethod]
        public string loadSeverity()
        {
            var severity = _context.Severities
            .Select(SVR => new Severity
            {
                SeverityID=SVR.SeverityID,
                Criteria=SVR.Criteria,
                SeverityValue=SVR.Value,
                Score=SVR.Score,
                ModifiedDate=ConvertToLocalTime(SVR.ModifiedDate),
                ModifiedBy=SVR.ModifiedBy
            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Severity>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, severity);

            return strwriter.ToString();
        }
        #endregion

        #region ProblemManagement

        [WebMethod]
        public string[] loadProblemPartyType()
        {
            var partytype = (from PRTY in _context.AffectedPartyTypes
                             select PRTY.AffectedPartyType1).ToArray();

            return partytype;
        }

        [WebMethod]
        public string updateProblem(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Problem obj = serializer.Deserialize<Problem>(json);

            EmailConfiguration automail;

            var problem = _context.Problems.Where(PRM => PRM.CaseNo == obj.CaseNO)
                .Select(PRM => PRM).SingleOrDefault();

            if (problem != null)
            {
                problem.AffectedPartyTypeID = _context.AffectedPartyTypes.Single(PRTYP => PRTYP.AffectedPartyType1 == obj.AffectedPartyType).AffectedPartyTypeID;
                problem.AffectedDepartmentID = obj.AffectedDepartment == string.Empty ? (int?)null : _context.OrganizationUnits.Single(UNT => UNT.UnitName == obj.AffectedDepartment).UnitID;
                problem.AffectedDocumentID = obj.AffectedDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.AffectedDocument).DocumentId;
                problem.AffectedPartyID = obj.ExternalParty == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExternalParty.Trim()).CustomerID;
                problem.Title = obj.Title;
                problem.Description = obj.Details == string.Empty ? null : obj.Details;
                problem.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
                problem.RaiseDate = obj.RaiseDate;
                problem.OriginationDate = obj.OriginationDate == null ? (DateTime?)null : Convert.ToDateTime(obj.OriginationDate);
                problem.TargetCloseDate = obj.TargetCloseDate;
                problem.ReviewReportIssueDate = obj.ReviewReportIssueDate == null ? (DateTime?)null : Convert.ToDateTime(obj.ReviewReportIssueDate);

                problem.OriginatorID = (from EMP in _context.Employees
                                        where EMP.FirstName == obj.Originator.Substring(obj.Originator.LastIndexOf(".") + 1, obj.Originator.IndexOf(" ") - 3) &&
                                        EMP.LastName == obj.Originator.Substring(obj.Originator.IndexOf(" ") + 1)
                                        select EMP.EmployeeID).SingleOrDefault();

                problem.OwnerID = (from EMP in _context.Employees
                                   where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                   EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                   select EMP.EmployeeID).SingleOrDefault();

                problem.ExecutiveID = (from EMP in _context.Employees
                                       where EMP.FirstName == obj.Executive.Substring(obj.Executive.LastIndexOf(".") + 1, obj.Executive.IndexOf(" ") - 3) &&
                                       EMP.LastName == obj.Executive.Substring(obj.Executive.IndexOf(" ") + 1)
                                       select EMP.EmployeeID).SingleOrDefault();

                problem.ProblemTypeID = _context.ProblemTypes.Single(PRBTYP => PRBTYP.ProblemType1 == obj.ProblemType).ProblemTypeID;
                problem.StatusID = _context.ProblemStatus.Single(PRMSTS => PRMSTS.ProblemStatus1 == obj.ProblemStatusString).ProblemStatusID;
                problem.SeverityID = obj.Severity == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.Severity).SeverityID;
                problem.ReportDepartmentID = obj.ReportDepartment == string.Empty ? (int?)null : _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.ReportDepartment).UnitID;
                problem.ProblemRelatedDepartmentID = obj.ProblemRelatedDepartment == string.Empty ? (int?)null : _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.ProblemRelatedDepartment).UnitID;
                

                /*if the actual close date of the problem is set, then the system shall perform the following:
                 * 1- Check if there are outstanding actions, then abort the update transaction. 
                 * 2- If there are no outstanding actions, then, set the status of the action to closed.
                 */

                if (obj.ActualCloseDate != null)
                {
                    problem.ActualCloseDate = Convert.ToDateTime(obj.ActualCloseDate);

                    var outstandingactions = problem.ProblemActions.Where(ACT => ACT.IsClosed == false).Select(ACT => ACT).ToList();
                    if (outstandingactions.Count > 0)
                    {
                        throw new Exception("The system cannot allow updating and closing the problem record, since there are outstanding actions which must be closed first");
                    }
                    else
                    {
                        //set the status of the problem to close
                        problem.StatusID = (int)ProblemStatus.Closed;
                    }
                }
                else
                {

                    problem.ActualCloseDate = (DateTime?)null;
                }

                //send the problem record to archive if the status is closed or withdrawn
                switch ((ProblemStatus)problem.StatusID)
                {
                    case ProblemStatus.Closed:
                    case ProblemStatus.Cancelled:
                        problem.RecordModeID = (int)RecordMode.Archived;
                        break;
                    case ProblemStatus.Open:
                        problem.RecordModeID = (int)RecordMode.Current;
                        break;
                }

                problem.ModifiedDate = DateTime.Now;
                problem.ModifiedBy = HttpContext.Current.User.Identity.Name;


                if (obj.Causes != null)
                {
                    var c = obj.Causes.First();
                    var s = obj.SelectedCause.First();

                    Cause cause = null;
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                            cause = _context.Causes.Where(CUS => CUS.CauseName == c.name && CUS.RootCauseID.HasValue == false).Select(CUS => CUS).SingleOrDefault();
                            if (cause == null)
                            {
                                cause = new Cause();
                                cause.CauseName = c.name;
                                cause.Description = c.Description == string.Empty ? null : c.Description;
                                cause.ModifiedDate = DateTime.Now;
                                cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                searchModifiedCause2(c, cause, s);

                                _context.Causes.InsertOnSubmit(cause);
                                _context.SubmitChanges();

                            }
                            else
                            {
                                throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            }
                            break;
                        case RecordsStatus.MODIFIED:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            cause.CauseName = c.name;
                            cause.Description = c.Description == string.Empty ? null : c.Description;
                            cause.ModifiedDate = DateTime.Now;
                            cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedCause2(c, cause, s);

                            break;
                        case RecordsStatus.ORIGINAL:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);

                            searchModifiedCause2(c, cause, s);

                            break;
                            //case RecordsStatus.ADDED:
                            //     cause=_context.Causes.Where(CUS=>CUS.CauseName==c.name && CUS.RootCauseID.HasValue==false).Select(CUS=>CUS).SingleOrDefault();
                            //     if (cause == null)
                            //     {
                            //         cause = new Cause();
                            //         cause.CauseName = c.name;
                            //         cause.Description = c.Description == string.Empty ? null : c.Description;
                            //         cause.ModifiedDate = DateTime.Now;
                            //         cause.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            //         searchModifiedCause(c, cause);

                            //         _context.Causes.InsertOnSubmit(cause);
                            //         _context.SubmitChanges();

                            //         problem.CauseID = cause.CauseID;
                            //     }
                            //     else
                            //     {
                            //         throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            //     }
                            //    break;
                            //case RecordsStatus.MODIFIED:
                            //    cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            //    cause.CauseName = c.name;
                            //    cause.Description = c.Description == string.Empty ? null : c.Description;
                            //    cause.ModifiedDate = DateTime.Now;
                            //    cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            //    problem.CauseID = cause.CauseID;
                            //    searchModifiedCause(c, cause);

                            //    break;
                            //case RecordsStatus.ORIGINAL:
                            //    cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);

                            //    problem.CauseID = cause.CauseID;
                            //    searchModifiedCause(c, cause);
                            //    break;
                    }

                    if (c.ParentID == 0)
                        problem.CauseID = c.CauseID;
                    else
                        problem.CauseID = c.ParentID;

                    problem.SubCauseID = s.CauseID;

                }

                if (obj.RiskSubcategory != null)
                {
                    ProblemRiskSubCategory subcategory = null;
                    foreach (var subcat in obj.RiskSubcategory)
                    {
                        switch (subcat.Status)
                        {
                            case RecordsStatus.ADDED:
                                subcategory = new ProblemRiskSubCategory();
                                subcategory.SubCategoryID = subcat.SubCategoryID;
                                subcategory.ModifiedDate = DateTime.Now;
                                subcategory.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                problem.ProblemRiskSubCategories.Add(subcategory);
                                break;
                            case RecordsStatus.REMOVED:
                                subcategory = _context.ProblemRiskSubCategories.Where(SUBCAT => SUBCAT.ProblemID == problem.ProblemID && SUBCAT.SubCategoryID == subcat.SubCategoryID)
                                    .Select(SUBCAT => SUBCAT).SingleOrDefault();
                                if (subcategory != null)
                                {
                                    _context.ProblemRiskSubCategories.DeleteOnSubmit(subcategory);
                                }
                                break;
                        }

                    }
                }

                if (obj.Members != null)
                {
                    ProblemApprovalMember member = null;

                    foreach (var app in obj.Members)
                    {
                        switch (app.Status)
                        {
                            case RecordsStatus.ADDED:

                               member = new ProblemApprovalMember();
                               member.MemberTypeID = _context.ApprovalMemberTypes.Single(MT => MT.MemberType == app.MemberType).MemberTypeID;
                               member.ApproverID = (from EMP in _context.Employees
                                             where EMP.FirstName == app.Member.Substring(app.Member.LastIndexOf(".") + 1, app.Member.IndexOf(" ") - 3) &&
                                             EMP.LastName == app.Member.Substring(app.Member.IndexOf(" ") + 1)
                                             select EMP.EmployeeID).SingleOrDefault();
                               member.ApprovalStatusID = _context.ApprovalStatus.Single(APP => APP.ApprovalStatus1 == app.ApprovalStatusString).ApprovalStatusID;
                               member.ModifiedDate = DateTime.Now;
                               member.ModifiedBy = HttpContext.Current.User.Identity.Name;
                               problem.ProblemApprovalMembers.Add(member);

                               // generate automatic email notification for approving problem request
                               automail = new EmailConfiguration();
                               automail.Module = Modules.ProblemManagement;
                               automail.KeyValue = problem.ProblemID;
                               automail.Action = "Approve";

                               //add both the originator and the owner as a recipient
                               automail.Recipients.Add(member.ApproverID);

                               //generate email request
                               automail.GenerateEmail();
                               break;
                            case RecordsStatus.MODIFIED:
                               member = _context.ProblemApprovalMembers.Single(APPM => APPM.MemberID == app.MemberID);
                               member.MemberTypeID = _context.ApprovalMemberTypes.Single(MT => MT.MemberType == app.MemberType).MemberTypeID;
                               member.ApproverID = (from EMP in _context.Employees
                                                     where EMP.FirstName == app.Member.Substring(app.Member.LastIndexOf(".") + 1, app.Member.IndexOf(" ") - 3) &&
                                                     EMP.LastName == app.Member.Substring(app.Member.IndexOf(" ") + 1)
                                                     select EMP.EmployeeID).SingleOrDefault();
                               member.ApprovalStatusID = _context.ApprovalStatus.Single(APP => APP.ApprovalStatus1 == app.ApprovalStatusString).ApprovalStatusID;
                               member.ModifiedDate = DateTime.Now;
                               member.ModifiedBy = HttpContext.Current.User.Identity.Name;

                               // generate automatic email notification for approving problem request
                               automail = new EmailConfiguration();
                               automail.Module = Modules.ProblemManagement;
                               automail.KeyValue = problem.ProblemID;
                               automail.Action = "Approve";

                               //add both the originator and the owner as a recipient
                               automail.Recipients.Add(member.ApproverID);

                               //generate email request
                               //automail.GenerateEmail();
                                break;
                            case RecordsStatus.REMOVED:
                                if(app.MemberID != 0)
                                {
                                    member = _context.ProblemApprovalMembers.Single(APPM => APPM.MemberID == app.MemberID);
                                    _context.ProblemApprovalMembers.DeleteOnSubmit(member);
                                }                  
                                break;
                        }
                    }
                }

                _context.SubmitChanges();

                // generate automatic email notification for adding new CCN
                automail = new EmailConfiguration();
                automail.Module = Modules.ProblemManagement;
                automail.KeyValue = problem.ProblemID;
                automail.Action = "Update";

                //add both the originator and the owner as a recipient
                automail.Recipients.Add(problem.OriginatorID);
                automail.Recipients.Add(problem.OwnerID);
                automail.Recipients.Add(problem.ExecutiveID);
                
                try
                {
                    bool isGenerated = automail.GenerateEmail();
                    
                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Cannot find the specified problem record");
            }

            return result;
        }

        [WebMethod]
        public void removeProblem(string caseNo)
        {
            var problem = _context.Problems.Where(PRM => PRM.CaseNo == caseNo)
              .Select(PRM => PRM).SingleOrDefault();

            if (problem != null)
            {
                _context.Problems.DeleteOnSubmit(problem);
                _context.SubmitChanges();
            }
            else
            {

                throw new Exception("Cannot find the specified problem record");
            }
        }

        [WebMethod]
        public string createProblem(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Problem obj = serializer.Deserialize<Problem>(json);

            EmailConfiguration automail;

            var problem = _context.Problems.Where(PRM => PRM.CaseNo == obj.CaseNO).Select(PRM => PRM).SingleOrDefault();
            if (problem == null)
            {
                problem = new LINQConnection.Problem();

                problem.CaseNo = obj.CaseNO;
                problem.AffectedPartyTypeID = _context.AffectedPartyTypes.Single(PRTYP => PRTYP.AffectedPartyType1 == obj.AffectedPartyType).AffectedPartyTypeID;
                problem.AffectedDepartmentID = obj.AffectedDepartment == string.Empty ? (int?)null : _context.OrganizationUnits.Single(UNT => UNT.UnitName == obj.AffectedDepartment).UnitID;
                problem.AffectedDocumentID = obj.AffectedDocument == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.AffectedDocument).DocumentId;
                problem.AffectedPartyID = obj.ExternalParty == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExternalParty.Trim()).CustomerID;
                problem.Title = obj.Title;
                problem.Description = obj.Details == string.Empty ? null : obj.Details;
                problem.RaiseDate = obj.RaiseDate;
                problem.OriginationDate = obj.OriginationDate == null ? (DateTime?)null : Convert.ToDateTime(obj.OriginationDate);
                problem.TargetCloseDate = obj.TargetCloseDate;
                problem.OriginatorID = (from EMP in _context.Employees
                                        where EMP.FirstName == obj.Originator.Substring(obj.Originator.LastIndexOf(".") + 1, obj.Originator.IndexOf(" ") - 3) &&
                                        EMP.LastName == obj.Originator.Substring(obj.Originator.IndexOf(" ") + 1)
                                        select EMP.EmployeeID).SingleOrDefault();

                problem.OwnerID = (from EMP in _context.Employees
                                   where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                   EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                   select EMP.EmployeeID).SingleOrDefault();

                problem.ExecutiveID = (from EMP in _context.Employees
                                       where EMP.FirstName == obj.Executive.Substring(obj.Executive.LastIndexOf(".") + 1, obj.Executive.IndexOf(" ") - 3) &&
                                       EMP.LastName == obj.Executive.Substring(obj.Executive.IndexOf(" ") + 1)
                                       select EMP.EmployeeID).SingleOrDefault();

                problem.ProblemTypeID = _context.ProblemTypes.Single(PRBTYP => PRBTYP.ProblemType1 == obj.ProblemType).ProblemTypeID;
                problem.SeverityID = obj.Severity == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.Severity).SeverityID;
                problem.ReportDepartmentID = obj.ReportDepartment == string.Empty ? (int?)null : _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.ReportDepartment).UnitID;
                problem.ProblemRelatedDepartmentID = obj.ProblemRelatedDepartment == string.Empty ? (int?)null : _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.ReportDepartment).UnitID;
                problem.RecordModeID = (int)obj.Mode;
                problem.ModifiedDate = DateTime.Now;
                problem.ModifiedBy = HttpContext.Current.User.Identity.Name;


                //if there are any specified approval members, then the status will be set to Pending
                if (obj.Members != null)
                {
                    ProblemApprovalMember member = null;

                    foreach (var app in obj.Members)
                    {
                        if((int)app.Status != 4)
                        {
                            member = new ProblemApprovalMember();
                            member.MemberTypeID = _context.ApprovalMemberTypes.Single(MT => MT.MemberType == app.MemberType).MemberTypeID;
                            member.ApproverID = (from EMP in _context.Employees
                                                 where EMP.FirstName == app.Member.Substring(app.Member.LastIndexOf(".") + 1, app.Member.IndexOf(" ") - 3) &&
                                                 EMP.LastName == app.Member.Substring(app.Member.IndexOf(" ") + 1)
                                                 select EMP.EmployeeID).SingleOrDefault();
                            member.ApprovalStatusID = _context.ApprovalStatus.Single(APP => APP.ApprovalStatus1 == app.ApprovalStatusString).ApprovalStatusID;
                            member.ModifiedDate = DateTime.Now;

                            problem.ProblemApprovalMembers.Add(member);

                        }

                    }

                    //set approval status to pending state
                    problem.StatusID = (int)ProblemStatus.Pending;

                }
                else
                {
                    //set approval status to open state
                    problem.StatusID = (int)ProblemStatus.Open;
                }

                if (obj.Causes != null)
                {
                    var c = obj.Causes.First();
                    var s = obj.SelectedCause.First();

                    Cause cause = null;
                    switch (c.Status)
                    {
                        case RecordsStatus.ADDED:
                            cause = _context.Causes.Where(CUS => CUS.CauseName == c.name && CUS.RootCauseID.HasValue == false).Select(CUS => CUS).SingleOrDefault();
                            if (cause == null)
                            {
                                cause = new Cause();
                                cause.CauseName = c.name;
                                cause.Description = c.Description == string.Empty ? null : c.Description;
                                cause.ModifiedDate = DateTime.Now;
                                cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                searchModifiedCause2(c, cause, s);

                                _context.Causes.InsertOnSubmit(cause);
                                _context.SubmitChanges();

                            }
                            else
                            {
                                throw new Exception("The name of the root cause already exists, the system cannot accept duplicate root causes");
                            }
                            break;
                        case RecordsStatus.MODIFIED:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);
                            cause.CauseName = c.name;
                            cause.Description = c.Description == string.Empty ? null : c.Description;
                            cause.ModifiedDate = DateTime.Now;
                            cause.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            searchModifiedCause2(c, cause, s);

                            break;
                        case RecordsStatus.ORIGINAL:
                            cause = _context.Causes.Single(CU => CU.CauseID == c.CauseID);

                            searchModifiedCause2(c, cause, s);

                            break;
                    }

                    if (c.ParentID == 0)
                        problem.CauseID = c.CauseID;
                    else
                        problem.CauseID = c.ParentID;

                    problem.SubCauseID = s.CauseID;

                }
                if (obj.RiskSubcategory != null)
                {
                    foreach (var subcat in obj.RiskSubcategory)
                    {
                        ProblemRiskSubCategory subcategory = new ProblemRiskSubCategory();
                        subcategory.SubCategoryID = subcat.SubCategoryID;
                        subcategory.ModifiedDate = DateTime.Now;
                        subcategory.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        problem.ProblemRiskSubCategories.Add(subcategory);
                    }
                }

                _context.Problems.InsertOnSubmit(problem);
                _context.SubmitChanges();


                // generate automatic email for each of the approval members

                if (problem.ProblemApprovalMembers.Count > 0)
                {
                    foreach (var member in problem.ProblemApprovalMembers)
                    {
                        // generate automatic email notification for approving problem request
                        automail = new EmailConfiguration();
                        automail.Module = Modules.ProblemManagement;
                        automail.KeyValue = problem.ProblemID;
                        automail.Action = "Approve";

                        //add both the originator and the owner as a recipient
                        automail.Recipients.Add(member.ApproverID);

                        //generate email request
                        automail.GenerateEmail();
                    }
                }

                // generate automatic email notification for adding new problem
                automail = new EmailConfiguration();
                automail.Module = Modules.ProblemManagement;
                automail.KeyValue = problem.ProblemID;
                automail.Action = "Add";

                //add both the originator and the owner as a recipient
                automail.Recipients.Add(problem.OriginatorID);
                automail.Recipients.Add(problem.OwnerID);
                automail.Recipients.Add(problem.ExecutiveID);

                try
                {
                    bool isGenerated = automail.GenerateEmail();
                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("The ID of the problem should be unique");
            }

            return result;
        }

        [WebMethod]
        public IEnumerable enumProblemYears()
        {
            var years = (from PRM in _context.Problems
                         select new { Year = PRM.RaiseDate.Year.ToString() }).Distinct();
            return years;
        }

        
        [WebMethod]
        public string[] loadProblemStatus()
        {
            var problemstatus = (from PRMSTS in _context.ProblemStatus
                                 select PRMSTS.ProblemStatus1).ToArray();
            return problemstatus;
        }

        [WebMethod]
        public string loadProblemType()
        {
            var problemtype = _context.ProblemTypes
               .Select(TYP => new GenericType
               {
                   TypeID=TYP.ProblemTypeID,
                   TypeName=TYP.ProblemType1,
                   Description = TYP.Description == null ? string.Empty : TYP.Description
               }).ToList();

            var xml = new XmlSerializer(typeof(List<GenericType>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problemtype);

            return str.ToString();
        }
        [WebMethod]
        public void removeProblemType(int ID)
        {
            var problemtype = _context.ProblemTypes.Where(PTYP => PTYP.ProblemTypeID == ID)
                .Select(PTYP => PTYP).SingleOrDefault();

            if (problemtype != null)
            {
                _context.ProblemTypes.DeleteOnSubmit(problemtype);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related problem type record");
            }

        }

        

        [WebMethod]
        public void createProblemType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            GenericType obj = serializer.Deserialize<GenericType>(json);

            var problemtype = _context.ProblemTypes.Where(PTYP => PTYP.ProblemType1 == obj.TypeName).Select(PTYP => PTYP).SingleOrDefault();
            if (problemtype == null)
            {
                problemtype = new ProblemType();
                problemtype.ProblemType1 = obj.TypeName;
                problemtype.Description = obj.Description == string.Empty ? null : obj.Description;
                problemtype.ModifiedDate = DateTime.Now;
                problemtype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.ProblemTypes.InsertOnSubmit(problemtype);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the problem type already exists");
            }
        }

        [WebMethod]
        public void updateProblemType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            GenericType obj = serializer.Deserialize<GenericType>(json);

            var problemtype = _context.ProblemTypes.Where(PTYP => PTYP.ProblemTypeID == obj.TypeID).Select(PTYP => PTYP).SingleOrDefault();
            if (problemtype != null)
            {
                problemtype.ProblemType1 = obj.TypeName;
                problemtype.Description = obj.Description == string.Empty ? null : obj.Description;
                problemtype.ModifiedDate = DateTime.Now;
                problemtype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related problem type record");
            }
        }
        [WebMethod]
        public string[] loadProblemActionType()
        {
            var actiontype = (from ACTTYP in _context.ProblemActionTypes
                              select ACTTYP.ActionName).ToArray();

            return actiontype;
        }
        [WebMethod]
        public string getLastCaseID()
        {
            string caseID = null;

            if (_context.Problems.ToList().Count > 0)
            {
                long maxId = _context.Problems.Max(i => i.ProblemID);
                caseID = _context.Problems.Where(PRM => PRM.ProblemID == maxId).Select(PRM => PRM.CaseNo).SingleOrDefault();
            }
            return caseID == null ? string.Empty : caseID;
        }
       
        [WebMethod]
        public bool problemExists(string caseNo)
        {
            var problem = _context.Problems.Where(PRM => PRM.CaseNo == caseNo)
                .Select(PRM => PRM).SingleOrDefault();

            if (problem != null)
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        [WebMethod]
        public string removeAction(int ID)
        {
            string result = String.Empty;

            var action = _context.ProblemActions.Where(ACT => ACT.ProblemActionID == ID)
                .Select(ACT => ACT).SingleOrDefault();

            if (action != null)
            {
                _context.ProblemActions.DeleteOnSubmit(action);
                _context.SubmitChanges();


                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Cannot find the specified action record");
            }

            return result;
        }
        [WebMethod]
        public string filterByStartDate(string json)
        {
            StringWriter strwriter = new StringWriter();

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

          var problems = _context.Problems
          .Select(PRM => new Problem
          {
              CaseNO = PRM.CaseNo,
              Title = PRM.Title,
              ProblemType=PRM.ProblemType.ProblemType1,
              ProblemStatus = (ProblemStatus)PRM.StatusID,
              Actions = PRM.ProblemActions.Where(ACT => ACT.StartDate>=obj.StartDate && ACT.StartDate<=obj.EndDate)
              .Select(ACT => new Action
              {
                  ActionID = ACT.ProblemActionID,
                  name = ACT.Title,
                  ActionType = ACT.ProblemActionType.ActionName,
                  StartDate = ConvertToLocalTime(ACT.StartDate),
                  PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                  ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                  Description = ACT.Description == null ? string.Empty : ACT.Description,
                  ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                  Actionee = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == ACT.OwnerID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                  IsClosed = ACT.IsClosed,
                  Module = Modules.ProblemAction
              }).ToList()
          }).ToList();

            var xml = new XmlSerializer(typeof(List<Problem>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problems);

            return str.ToString();
        }

        [WebMethod]
        public string filterActionsByProblemType(string type)
        {
            var problems = _context.Problems
             .Where(PRM=>PRM.ProblemType.ProblemType1==type)
             .Select(PRM => new Problem
             {
                 CaseNO = PRM.CaseNo,
                 Title = PRM.Title,
                 ProblemType=PRM.ProblemType.ProblemType1,
                 ProblemStatus = (ProblemStatus)PRM.StatusID,
                 Actions = PRM.ProblemActions
                 .Select(ACT => new Action
                 {
                     ActionID = ACT.ProblemActionID,
                     name = ACT.Title,
                     ActionType = ACT.ProblemActionType.ActionName,
                     StartDate = ConvertToLocalTime(ACT.StartDate),
                     PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                     ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                     Description = ACT.Description == null ? string.Empty : ACT.Description,
                     ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                     Actionee = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == ACT.OwnerID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                     IsClosed = ACT.IsClosed,
                     Module = Modules.ProblemAction
                 }).ToList()
             }).ToList();

            var xml = new XmlSerializer(typeof(List<Problem>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problems);

            return str.ToString();
        }
        [WebMethod]
        public string filterActionsByProblemName(string name)
        {
            var problems = _context.Problems            
            .Where(PRM=>PRM.Title.StartsWith(name))
            .Select(PRM => new Problem
            {
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                ProblemType=PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                Actions = PRM.ProblemActions.Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Problem>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problems);

            return str.ToString();
        }
        [WebMethod]
        public string filterByActionType(string type)
        {
            var problems = _context.Problems
            .Select(PRM => new Problem
            {
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                ProblemType=PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                Actions = PRM.ProblemActions.Where(ACT=>ACT.ProblemActionType.ActionName==type)
                .Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Problem>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problems);

            return str.ToString();
        }
       
        [WebMethod]
        public string updateProblemAction(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Action obj = serializer.Deserialize<Action>(json);

            var action = _context.ProblemActions.Where(ACT => ACT.ProblemActionID == obj.ActionID)
            .Select(ACT => ACT).SingleOrDefault();
            if (action != null)
            {
                action.Title = obj.name;
                action.StartDate = obj.StartDate;
                action.PlannedEndDate = obj.PlannedEndDate;
                action.Description = obj.Description == string.Empty ? null : obj.Description;
                action.ActionTypeID = _context.ProblemActionTypes.Single(ACTTYP => ACTTYP.ActionName == obj.ActionType).ActionTypeID;
                action.OwnerID = (from EMP in _context.Employees
                                  where EMP.FirstName == obj.Actionee.Substring(obj.Actionee.LastIndexOf(".") + 1, obj.Actionee.IndexOf(" ") - 3) &&
                                  EMP.LastName == obj.Actionee.Substring(obj.Actionee.IndexOf(" ") + 1)
                                  select EMP.EmployeeID).SingleOrDefault();
                action.ActualCloseDate = obj.ActualCloseDate == null ? (DateTime?)null : Convert.ToDateTime(obj.ActualCloseDate);
                action.ActioneeFeedback = obj.ActioneeFeedback == string.Empty ? null : obj.ActioneeFeedback;
                action.IsClosed = obj.IsClosed;
                action.ModifiedDate = DateTime.Now;
                action.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();


                //setup automatic email configuration
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = obj.Module;
                automail.KeyValue = action.ProblemActionID;
                automail.Action = "Update";

                automail.Recipients.Add(action.OwnerID);

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Could not find the related problem action record");
            }

            return result;
        }
        [WebMethod]
        public string createProblemAction(string json,string caseNo)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Action obj = serializer.Deserialize<Action>(json);

            var problem = _context.Problems.Where(PRM => PRM.CaseNo == caseNo)
                .Select(PRM => PRM).SingleOrDefault();

            if (problem != null)
            {
                var action = problem.ProblemActions.Where(ACT => ACT.Title == obj.name).Select(ACT => ACT).SingleOrDefault();
                if (action == null)
                {
                    action = new ProblemAction();
                    action.Title = obj.name;
                    action.StartDate = obj.StartDate;
                    action.PlannedEndDate = obj.PlannedEndDate;
                    action.Description = obj.Description == string.Empty ? null : obj.Description;
                    action.ActionTypeID = _context.ProblemActionTypes.Single(ACTTYP => ACTTYP.ActionName == obj.ActionType).ActionTypeID;
                    action.OwnerID = (from EMP in _context.Employees
                                      where EMP.FirstName == obj.Actionee.Substring(obj.Actionee.LastIndexOf(".") + 1, obj.Actionee.IndexOf(" ") - 3) &&
                                      EMP.LastName == obj.Actionee.Substring(obj.Actionee.IndexOf(" ") + 1)
                                      select EMP.EmployeeID).SingleOrDefault();
                    action.ModifiedDate = DateTime.Now;
                    action.ModifiedBy = HttpContext.Current.User.Identity.Name;


                    problem.ProblemActions.Add(action);

                    _context.SubmitChanges();

                    //setup automatic email configuration
                    EmailConfiguration automail = new EmailConfiguration();
                    automail.Module = obj.Module;
                    automail.KeyValue = action.ProblemActionID;
                    automail.Action = "Add";

                    automail.Recipients.Add(action.OwnerID);

                    try
                    {
                        bool isGenerated = automail.GenerateEmail();

                        if (isGenerated == true)
                        {
                            result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                        }
                        else
                        {
                            result = "Operation has been committed sucessfully";
                        }
                    }
                    catch (Exception ex)
                    {
                        result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                        result += "\n\n" + ex.Message;
                    }
                }
                else
                {
                    throw new Exception("The name of the action already exists");
                }

            }
            else
            {
                throw new Exception("Could not find the related problem record");
            }
            return result;
        }
        [WebMethod]
        public string loadProblemCauses(int problemID)
        {
            var causes = _context.fn_getProblemCauseChildTree(problemID)
            .Select(C => new Causes
            {
                CauseID = Convert.ToInt32(C.CauseID),
                name = C.Cause,
                Description = C.Description,
                ParentID = Convert.ToInt32(C.ParentID == null ? 0 : C.ParentID),
                Status = RecordsStatus.ORIGINAL,
                SelectedCauseID = Convert.ToInt32(C.SelectedCauseID == null ? 0 : C.SelectedCauseID),
                id = Convert.ToInt32(C.CauseID)
            }).ToList();


            foreach (var cause in causes)
            {
                List<Causes> obj = causes.Where(x => x.ParentID == cause.CauseID).ToList<Causes>();

                if (obj.Count > 0)
                {
                    cause.children = obj;
                }
            }

            for (int i = causes.Count - 1; i >= 0; i--)
            {
                if (causes[i].ParentID != 0)
                {
                    causes.RemoveAt(i);
                }
            }
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string result = serializer.Serialize(causes);

            return result;
        }

        [WebMethod]
        public string filterProblemByOriginationDate(string json)
        {
            
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var problems = _context.Problems
            .Where(PRM => PRM.OriginationDate>= obj.StartDate && PRM.OriginationDate<=obj.EndDate)
            .Select(PRM => new Problem
            {
                ProblemID = PRM.ProblemID,
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                Details = PRM.Description == null ? string.Empty : PRM.Description,
                Remarks = PRM.Remarks == null ? string.Empty : PRM.Remarks,
                RaiseDate = ConvertToLocalTime(PRM.RaiseDate),
                ExternalParty = PRM.AffectedPartyID.HasValue == false ? string.Empty : PRM.Customer.CustomerName,
                OriginationDate = PRM.OriginationDate.HasValue == false ? (DateTime?)null : PRM.OriginationDate,
                TargetCloseDate = ConvertToLocalTime(PRM.TargetCloseDate),
                ActualCloseDate = PRM.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ActualCloseDate.Value),
                AffectedPartyType = PRM.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = PRM.AffectedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit.UnitName,
                AffectedDocument = PRM.AffectedDocumentID.HasValue == false ? string.Empty : PRM.Document.Title,
                ReviewReportIssueDate = PRM.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == PRM.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == PRM.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == PRM.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                ProblemRelatedDepartment = PRM.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit2.UnitName,
                ReportDepartment = PRM.ReportDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit1.UnitName,
                Severity = PRM.SeverityID.HasValue == false ? string.Empty : PRM.Severity.Criteria,
                RiskSubcategory = PRM.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Members = PRM.ProblemApprovalMembers
               .Select(APPR => new ApprovalMember
               {
                   MemberID = APPR.MemberID,
                   Member = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == APPR.ApproverID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APPR.MemberTypeID).MemberType,
                   ApprovalStatus = (ApprovalStatus)APPR.ApprovalStatusID,
                   ApprovalRemarks = APPR.ApprovalRemarks == null ? string.Empty : APPR.ApprovalRemarks,
                   Status = RecordsStatus.ORIGINAL
               }).ToList(),
                Actions = PRM.ProblemActions.Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList(),
                Module = Modules.ProblemManagement,
                Mode = (RecordMode)PRM.RecordModeID

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();

        }

        [WebMethod]
        public string filterProblemByMode(string mode)
        {
            var problems = _context.Problems
            .Where(PRM => PRM.RecordMode.RecordMode1 == mode)
            .Select(PRM => new Problem
            {
                ProblemID = PRM.ProblemID,
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                Details = PRM.Description == null ? string.Empty : PRM.Description,
                Remarks = PRM.Remarks == null ? string.Empty : PRM.Remarks,
                RaiseDate = ConvertToLocalTime(PRM.RaiseDate),
                ExternalParty = PRM.AffectedPartyID.HasValue == false ? string.Empty : PRM.Customer.CustomerName,
                OriginationDate = PRM.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(PRM.TargetCloseDate),
                ActualCloseDate = PRM.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ActualCloseDate.Value),
                AffectedPartyType = PRM.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = PRM.AffectedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit.UnitName,
                AffectedDocument = PRM.AffectedDocumentID.HasValue == false ? string.Empty : PRM.Document.Title,
                ReviewReportIssueDate = PRM.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == PRM.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == PRM.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == PRM.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                ProblemRelatedDepartment = PRM.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit2.UnitName,
                ReportDepartment = PRM.ReportDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit1.UnitName,
                Severity = PRM.SeverityID.HasValue == false ? string.Empty : PRM.Severity.Criteria,
                RiskSubcategory = PRM.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Members = PRM.ProblemApprovalMembers
               .Select(APPR => new ApprovalMember
               {
                   MemberID = APPR.MemberID,
                   Member = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == APPR.ApproverID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APPR.MemberTypeID).MemberType,
                   ApprovalStatus = (ApprovalStatus)APPR.ApprovalStatusID,
                   ApprovalRemarks = APPR.ApprovalRemarks == null ? string.Empty : APPR.ApprovalRemarks,
                   Status = RecordsStatus.ORIGINAL
               }).ToList(),
                Actions = PRM.ProblemActions.Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList(),
                Module = Modules.ProblemManagement,
                Mode = (RecordMode)PRM.RecordModeID

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();

        }
        [WebMethod]
        public string filterProblemBytype(string type)
        {
            var problems = _context.Problems
            .Where(PRM => PRM.ProblemType.ProblemType1==type)
            .Select(PRM => new Problem
            {
                ProblemID = PRM.ProblemID,
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                Details = PRM.Description == null ? string.Empty : PRM.Description,
                Remarks = PRM.Remarks == null ? string.Empty : PRM.Remarks,
                RaiseDate = ConvertToLocalTime(PRM.RaiseDate),
                ExternalParty = PRM.AffectedPartyID.HasValue == false ? string.Empty : PRM.Customer.CustomerName,
                OriginationDate = PRM.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(PRM.TargetCloseDate),
                ActualCloseDate = PRM.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ActualCloseDate.Value),
                AffectedPartyType = PRM.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = PRM.AffectedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit.UnitName,
                AffectedDocument = PRM.AffectedDocumentID.HasValue == false ? string.Empty : PRM.Document.Title,
                ReviewReportIssueDate = PRM.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == PRM.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == PRM.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == PRM.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                ProblemRelatedDepartment = PRM.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit2.UnitName,
                ReportDepartment = PRM.ReportDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit1.UnitName,
                Severity = PRM.SeverityID.HasValue == false ? string.Empty : PRM.Severity.Criteria,
                RiskSubcategory = PRM.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Members = PRM.ProblemApprovalMembers
               .Select(APPR => new ApprovalMember
               {
                   MemberID = APPR.MemberID,
                   Member = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == APPR.ApproverID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APPR.MemberTypeID).MemberType,
                   ApprovalStatus = (ApprovalStatus)APPR.ApprovalStatusID,
                   ApprovalRemarks = APPR.ApprovalRemarks == null ? string.Empty : APPR.ApprovalRemarks,
                   Status = RecordsStatus.ORIGINAL
               }).ToList(),
                Actions = PRM.ProblemActions.Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList(),
                Module = Modules.ProblemManagement,
                Mode = (RecordMode)PRM.RecordModeID

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();

        }

        [WebMethod]
        public string filterProblemByRootCause(int causeID)
        {
            var problems = _context.Problems
            .Where(PRM => PRM.Cause.CauseID==causeID)
            .Select(PRM => new Problem
            {
                ProblemID = PRM.ProblemID,
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                Details = PRM.Description == null ? string.Empty : PRM.Description,
                Remarks = PRM.Remarks == null ? string.Empty : PRM.Remarks,
                RaiseDate = ConvertToLocalTime(PRM.RaiseDate),
                ExternalParty = PRM.AffectedPartyID.HasValue == false ? string.Empty : PRM.Customer.CustomerName,
                OriginationDate = PRM.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(PRM.TargetCloseDate),
                ActualCloseDate = PRM.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ActualCloseDate.Value),
                AffectedPartyType = PRM.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = PRM.AffectedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit.UnitName,
                AffectedDocument = PRM.AffectedDocumentID.HasValue == false ? string.Empty : PRM.Document.Title,
                ReviewReportIssueDate = PRM.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == PRM.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == PRM.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == PRM.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                ProblemRelatedDepartment = PRM.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit2.UnitName,
                ReportDepartment = PRM.ReportDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit1.UnitName,
                Severity = PRM.SeverityID.HasValue == false ? string.Empty : PRM.Severity.Criteria,
                RiskSubcategory = PRM.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Members = PRM.ProblemApprovalMembers
               .Select(APPR => new ApprovalMember
               {
                   MemberID = APPR.MemberID,
                   Member = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == APPR.ApproverID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APPR.MemberTypeID).MemberType,
                   ApprovalStatus = (ApprovalStatus)APPR.ApprovalStatusID,
                   ApprovalRemarks = APPR.ApprovalRemarks == null ? string.Empty : APPR.ApprovalRemarks,
                   Status = RecordsStatus.ORIGINAL
               }).ToList(),
                Actions = PRM.ProblemActions.Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList(),
                Module = Modules.ProblemManagement,
                Mode = (RecordMode)PRM.RecordModeID

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();

        }
        [WebMethod]
        public string filterProblemByName(string title)
        {
            var problems = _context.Problems
            .Where(PRM=>PRM.Title.StartsWith(title))
            .Select(PRM => new Problem
            {
                ProblemID = PRM.ProblemID,
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                Details = PRM.Description == null ? string.Empty : PRM.Description,
                Remarks = PRM.Remarks == null ? string.Empty : PRM.Remarks,
                RaiseDate = ConvertToLocalTime(PRM.RaiseDate),
                ExternalParty = PRM.AffectedPartyID.HasValue == false ? string.Empty : PRM.Customer.CustomerName,
                OriginationDate = PRM.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(PRM.TargetCloseDate),
                ActualCloseDate = PRM.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ActualCloseDate.Value),
                AffectedPartyType = PRM.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = PRM.AffectedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit.UnitName,
                AffectedDocument = PRM.AffectedDocumentID.HasValue == false ? string.Empty : PRM.Document.Title,
                ReviewReportIssueDate = PRM.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == PRM.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == PRM.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == PRM.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                ProblemRelatedDepartment = PRM.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit2.UnitName,
                ReportDepartment = PRM.ReportDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit1.UnitName,
                Severity = PRM.SeverityID.HasValue == false ? string.Empty : PRM.Severity.Criteria,
                RiskSubcategory = PRM.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Members = PRM.ProblemApprovalMembers
               .Select(APPR => new ApprovalMember
               {
                   MemberID = APPR.MemberID,
                   Member = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == APPR.ApproverID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APPR.MemberTypeID).MemberType,
                   ApprovalStatus = (ApprovalStatus)APPR.ApprovalStatusID,
                   ApprovalRemarks = APPR.ApprovalRemarks == null ? string.Empty : APPR.ApprovalRemarks,
                   Status = RecordsStatus.ORIGINAL
               }).ToList(),
                Actions = PRM.ProblemActions.Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList(),
                Module = Modules.ProblemManagement,
                Mode = (RecordMode)PRM.RecordModeID

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();
        
        }

        [WebMethod]
        public string getProblem(string caseNo)
        {
            var problem = _context.Problems
                .Where(PRM => PRM.CaseNo == caseNo)
                .Select(PRM => new Problem
                {
                    ProblemID = PRM.ProblemID,
                    CaseNO = PRM.CaseNo,
                    Title = PRM.Title,
                    Details = PRM.Description == null ? string.Empty : PRM.Description,
                    RaiseDate = ConvertToLocalTime(PRM.RaiseDate),
                    ExternalParty = PRM.Customer.CustomerName.Trim(),
                    OriginationDate = PRM.OriginationDate != null ? ConvertToLocalTime(PRM.OriginationDate.Value) : PRM.OriginationDate,
                    TargetCloseDate = ConvertToLocalTime(PRM.TargetCloseDate),
                    ActualCloseDate = PRM.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ActualCloseDate.Value),
                    ReviewReportIssueDate = PRM.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ReviewReportIssueDate.Value),
                    Originator = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == PRM.OriginatorID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                    Owner = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == PRM.OwnerID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                    Executive = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == PRM.ExecutiveID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    ProblemType = PRM.ProblemType.ProblemType1,
                    ProblemStatus = (ProblemStatus)PRM.StatusID,
                    ProblemRelatedDepartment = PRM.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit1.UnitName,
                    ReportDepartment = PRM.ReportDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit.UnitName,
                    Severity = PRM.SeverityID.HasValue == false ? string.Empty : PRM.Severity.Criteria,
                    RiskSubcategory = PRM.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                    {
                        SubCategoryID = SUBCAT.SubCategoryID,
                        Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                        name = SUBCAT.RiskSubCategory.SubCategory,
                        Status = RecordsStatus.ORIGINAL
                    }).ToList()

                }).SingleOrDefault();

            if (problem == null)
            {
                throw new Exception("Cannot find the related problem record");
            }
            var serializer = new XmlSerializer(typeof(Problem));
            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problem);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadProblemsByApprovalMemberNDDaterange(string firstname, string lastname, string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var problems = _context.ProblemApprovalMembers
            .Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname && MEM.Problem.OriginationDate>=obj.StartDate && MEM.Problem.OriginationDate<=obj.EndDate)
            .Select(MEM => new Problem
            {
                ProblemID = MEM.Problem.ProblemID,
                CaseNO = MEM.Problem.CaseNo,
                Title = MEM.Problem.Title,
                Details = MEM.Problem.Description == null ? string.Empty : MEM.Problem.Description,
                Remarks = MEM.Problem.Remarks == null ? string.Empty : MEM.Problem.Remarks,
                RaiseDate = ConvertToLocalTime(MEM.Problem.RaiseDate),
                ExternalParty = MEM.Problem.AffectedPartyID.HasValue == false ? string.Empty : MEM.Problem.Customer.CustomerName,
                OriginationDate = MEM.Problem.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(MEM.Problem.TargetCloseDate),
                ActualCloseDate = MEM.Problem.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ActualCloseDate.Value),
                AffectedPartyType = MEM.Problem.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = MEM.Problem.AffectedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit.UnitName,
                AffectedDocument = MEM.Problem.AffectedDocumentID.HasValue == false ? string.Empty : MEM.Problem.Document.Title,
                ReviewReportIssueDate = MEM.Problem.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.Problem.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.Problem.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == MEM.Problem.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = MEM.Problem.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)MEM.Problem.StatusID,
                ProblemRelatedDepartment = MEM.Problem.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit2.UnitName,
                ReportDepartment = MEM.Problem.ReportDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit1.UnitName,
                Severity = MEM.Problem.SeverityID.HasValue == false ? string.Empty : MEM.Problem.Severity.Criteria,
                RiskSubcategory = MEM.Problem.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadProblemsByApprovalMemberNDTitle(string firstname, string lastname, string title)
        {
            var problems = _context.ProblemApprovalMembers
            .Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname && MEM.Problem.Title.StartsWith(title))
            .Select(MEM => new Problem
            {
                ProblemID = MEM.Problem.ProblemID,
                CaseNO = MEM.Problem.CaseNo,
                Title = MEM.Problem.Title,
                Details = MEM.Problem.Description == null ? string.Empty : MEM.Problem.Description,
                Remarks = MEM.Problem.Remarks == null ? string.Empty : MEM.Problem.Remarks,
                RaiseDate = ConvertToLocalTime(MEM.Problem.RaiseDate),
                ExternalParty = MEM.Problem.AffectedPartyID.HasValue == false ? string.Empty : MEM.Problem.Customer.CustomerName,
                OriginationDate = MEM.Problem.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(MEM.Problem.TargetCloseDate),
                ActualCloseDate = MEM.Problem.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ActualCloseDate.Value),
                AffectedPartyType = MEM.Problem.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = MEM.Problem.AffectedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit.UnitName,
                AffectedDocument = MEM.Problem.AffectedDocumentID.HasValue == false ? string.Empty : MEM.Problem.Document.Title,
                ReviewReportIssueDate = MEM.Problem.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.Problem.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.Problem.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == MEM.Problem.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = MEM.Problem.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)MEM.Problem.StatusID,
                ProblemRelatedDepartment = MEM.Problem.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit2.UnitName,
                ReportDepartment = MEM.Problem.ReportDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit1.UnitName,
                Severity = MEM.Problem.SeverityID.HasValue == false ? string.Empty : MEM.Problem.Severity.Criteria,
                RiskSubcategory = MEM.Problem.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadProblemsByApprovalMemberNDRootCause(string firstname, string lastname, int causeID)
        {
            var problems = _context.ProblemApprovalMembers
            .Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname && MEM.Problem.Cause.CauseID == causeID)
            .Select(MEM => new Problem
            {
                ProblemID = MEM.Problem.ProblemID,
                CaseNO = MEM.Problem.CaseNo,
                Title = MEM.Problem.Title,
                Details = MEM.Problem.Description == null ? string.Empty : MEM.Problem.Description,
                Remarks = MEM.Problem.Remarks == null ? string.Empty : MEM.Problem.Remarks,
                RaiseDate = ConvertToLocalTime(MEM.Problem.RaiseDate),
                ExternalParty = MEM.Problem.AffectedPartyID.HasValue == false ? string.Empty : MEM.Problem.Customer.CustomerName,
                OriginationDate = MEM.Problem.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(MEM.Problem.TargetCloseDate),
                ActualCloseDate = MEM.Problem.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ActualCloseDate.Value),
                AffectedPartyType = MEM.Problem.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = MEM.Problem.AffectedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit.UnitName,
                AffectedDocument = MEM.Problem.AffectedDocumentID.HasValue == false ? string.Empty : MEM.Problem.Document.Title,
                ReviewReportIssueDate = MEM.Problem.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.Problem.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.Problem.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == MEM.Problem.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = MEM.Problem.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)MEM.Problem.StatusID,
                ProblemRelatedDepartment = MEM.Problem.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit2.UnitName,
                ReportDepartment = MEM.Problem.ReportDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit1.UnitName,
                Severity = MEM.Problem.SeverityID.HasValue == false ? string.Empty : MEM.Problem.Severity.Criteria,
                RiskSubcategory = MEM.Problem.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadProblemsByApprovalMemberNDApprovalStatus(string firstname, string lastname, string status)
        {
            var problems = _context.ProblemApprovalMembers
            .Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname && MEM.ApprovalStatus.ApprovalStatus1 == status)
            .Select(MEM => new Problem
            {
                ProblemID = MEM.Problem.ProblemID,
                CaseNO = MEM.Problem.CaseNo,
                Title = MEM.Problem.Title,
                Details = MEM.Problem.Description == null ? string.Empty : MEM.Problem.Description,
                Remarks = MEM.Problem.Remarks == null ? string.Empty : MEM.Problem.Remarks,
                RaiseDate = ConvertToLocalTime(MEM.Problem.RaiseDate),
                ExternalParty = MEM.Problem.AffectedPartyID.HasValue == false ? string.Empty : MEM.Problem.Customer.CustomerName,
                OriginationDate = MEM.Problem.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(MEM.Problem.TargetCloseDate),
                ActualCloseDate = MEM.Problem.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ActualCloseDate.Value),
                AffectedPartyType = MEM.Problem.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = MEM.Problem.AffectedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit.UnitName,
                AffectedDocument = MEM.Problem.AffectedDocumentID.HasValue == false ? string.Empty : MEM.Problem.Document.Title,
                ReviewReportIssueDate = MEM.Problem.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.Problem.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.Problem.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == MEM.Problem.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = MEM.Problem.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)MEM.Problem.StatusID,
                ProblemRelatedDepartment = MEM.Problem.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit2.UnitName,
                ReportDepartment = MEM.Problem.ReportDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit1.UnitName,
                Severity = MEM.Problem.SeverityID.HasValue == false ? string.Empty : MEM.Problem.Severity.Criteria,
                RiskSubcategory = MEM.Problem.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Problem>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problems);

            return str.ToString();
        }
        [WebMethod]
        public string loadProblemsByApprovalMemberNDType(string firstname, string lastname,string type)
        {
            var problems = _context.ProblemApprovalMembers
            .Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname && MEM.Problem.ProblemType.ProblemType1==type)
            .Select(MEM => new Problem
            {
                ProblemID = MEM.Problem.ProblemID,
                CaseNO = MEM.Problem.CaseNo,
                Title = MEM.Problem.Title,
                Details = MEM.Problem.Description == null ? string.Empty : MEM.Problem.Description,
                Remarks = MEM.Problem.Remarks == null ? string.Empty : MEM.Problem.Remarks,
                RaiseDate = ConvertToLocalTime(MEM.Problem.RaiseDate),
                ExternalParty = MEM.Problem.AffectedPartyID.HasValue == false ? string.Empty : MEM.Problem.Customer.CustomerName,
                OriginationDate = MEM.Problem.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(MEM.Problem.TargetCloseDate),
                ActualCloseDate = MEM.Problem.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ActualCloseDate.Value),
                AffectedPartyType = MEM.Problem.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = MEM.Problem.AffectedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit.UnitName,
                AffectedDocument = MEM.Problem.AffectedDocumentID.HasValue == false ? string.Empty : MEM.Problem.Document.Title,
                ReviewReportIssueDate = MEM.Problem.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.Problem.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.Problem.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == MEM.Problem.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = MEM.Problem.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)MEM.Problem.StatusID,
                ProblemRelatedDepartment = MEM.Problem.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit2.UnitName,
                ReportDepartment = MEM.Problem.ReportDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit1.UnitName,
                Severity = MEM.Problem.SeverityID.HasValue == false ? string.Empty : MEM.Problem.Severity.Criteria,
                RiskSubcategory = MEM.Problem.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Problem>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problems);

            return str.ToString();
        }

        [WebMethod]
        public string loadProblemsByApprovalMember(string firstname, string lastname)
        {
            var problems = _context.ProblemApprovalMembers.Where(MEM => MEM.Employee.FirstName == firstname && MEM.Employee.LastName == lastname)
            .Select(MEM => new Problem
            {
                ProblemID = MEM.Problem.ProblemID,
                CaseNO = MEM.Problem.CaseNo,
                Title = MEM.Problem.Title,
                Details = MEM.Problem.Description == null ? string.Empty : MEM.Problem.Description,
                Remarks = MEM.Problem.Remarks == null ? string.Empty : MEM.Problem.Remarks,
                RaiseDate = ConvertToLocalTime(MEM.Problem.RaiseDate),
                ExternalParty = MEM.Problem.AffectedPartyID.HasValue == false ? string.Empty : MEM.Problem.Customer.CustomerName,
                OriginationDate = MEM.Problem.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(MEM.Problem.TargetCloseDate),
                ActualCloseDate = MEM.Problem.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ActualCloseDate.Value),
                AffectedPartyType = MEM.Problem.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = MEM.Problem.AffectedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit.UnitName,
                AffectedDocument = MEM.Problem.AffectedDocumentID.HasValue == false ? string.Empty : MEM.Problem.Document.Title,
                ReviewReportIssueDate = MEM.Problem.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(MEM.Problem.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.Problem.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == MEM.Problem.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == MEM.Problem.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = MEM.Problem.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)MEM.Problem.StatusID,
                ProblemRelatedDepartment = MEM.Problem.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit2.UnitName,
                ReportDepartment = MEM.Problem.ReportDepartmentID.HasValue == false ? string.Empty : MEM.Problem.OrganizationUnit1.UnitName,
                Severity = MEM.Problem.SeverityID.HasValue == false ? string.Empty : MEM.Problem.Severity.Criteria,
                RiskSubcategory = MEM.Problem.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Member = new ApprovalMember
                {
                    MemberID = MEM.MemberID,
                    Member = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == MEM.ApproverID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == MEM.MemberTypeID).MemberType,
                    ApprovalStatus = (ApprovalStatus)MEM.ApprovalStatusID,
                    ApprovalRemarks = MEM.ApprovalRemarks == null ? string.Empty : MEM.ApprovalRemarks,
                    Status = RecordsStatus.ORIGINAL
                }
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Problem>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, problems);

            return str.ToString();
        }

        [WebMethod]
        public string loadProblems()
        {
            var problems = _context.Problems
            .Select(PRM => new Problem
            {
                ProblemID = PRM.ProblemID,
                CaseNO = PRM.CaseNo,
                Title = PRM.Title,
                Details = PRM.Description == null ? string.Empty : PRM.Description,
                Remarks=PRM.Remarks==null?string.Empty:PRM.Remarks,
                RaiseDate = ConvertToLocalTime(PRM.RaiseDate),
                ExternalParty = PRM.AffectedPartyID.HasValue == false ? string.Empty : PRM.Customer.CustomerName,
                OriginationDate = PRM.OriginationDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.OriginationDate.Value),
                TargetCloseDate = ConvertToLocalTime(PRM.TargetCloseDate),
                ActualCloseDate = PRM.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ActualCloseDate.Value),
                AffectedPartyType = PRM.AffectedPartyType.AffectedPartyType1,
                AffectedDepartment = PRM.AffectedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit.UnitName,
                AffectedDocument = PRM.AffectedDocumentID.HasValue == false ? string.Empty : PRM.Document.Title,
                ReviewReportIssueDate = PRM.ReviewReportIssueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(PRM.ReviewReportIssueDate.Value),
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == PRM.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == PRM.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),


                Executive = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == PRM.ExecutiveID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                ProblemType = PRM.ProblemType.ProblemType1,
                ProblemStatus = (ProblemStatus)PRM.StatusID,
                ProblemRelatedDepartment = PRM.ProblemRelatedDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit2.UnitName,
                ReportDepartment = PRM.ReportDepartmentID.HasValue == false ? string.Empty : PRM.OrganizationUnit1.UnitName,
                Severity = PRM.SeverityID.HasValue == false ? string.Empty : PRM.Severity.Criteria,
                RiskSubcategory = PRM.ProblemRiskSubCategories.Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    Category = SUBCAT.RiskSubCategory.RiskCategory.Category,
                    name = SUBCAT.RiskSubCategory.SubCategory,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),
                Members = PRM.ProblemApprovalMembers
               .Select(APPR => new ApprovalMember
               {
                   MemberID = APPR.MemberID,
                   Member = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == APPR.ApproverID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                   MemberType = _context.ApprovalMemberTypes.Single(APPT => APPT.MemberTypeID == APPR.MemberTypeID).MemberType,
                   ApprovalStatus = (ApprovalStatus)APPR.ApprovalStatusID,
                   ApprovalRemarks = APPR.ApprovalRemarks == null ? string.Empty : APPR.ApprovalRemarks,
                   Status = RecordsStatus.ORIGINAL
               }).ToList(),
                Actions = PRM.ProblemActions.Select(ACT => new Action
                {
                    ActionID = ACT.ProblemActionID,
                    name = ACT.Title,
                    ActionType = ACT.ProblemActionType.ActionName,
                    StartDate = ConvertToLocalTime(ACT.StartDate),
                    PlannedEndDate = ConvertToLocalTime(ACT.PlannedEndDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Description = ACT.Description == null ? string.Empty : ACT.Description,
                    ActioneeFeedback = ACT.ActioneeFeedback == null ? string.Empty : ACT.ActioneeFeedback,
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.OwnerID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed=ACT.IsClosed,
                    Module = Modules.ProblemAction
                }).ToList(),
                Module = Modules.ProblemManagement,
                Mode = (RecordMode)PRM.RecordModeID

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Problem>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, problems);

            return strwriter.ToString();
        }


        [WebMethod]
        public string updateProblemApproval(string json)
        {
            string result = String.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ApprovalMember obj = serializer.Deserialize<ApprovalMember>(json);

            var member = _context.ProblemApprovalMembers.Where(MEM => MEM.MemberID == obj.MemberID)
            .Select(MEM => MEM).SingleOrDefault();

            if (member != null)
            {
                member.ApprovalStatusID = _context.ApprovalStatus.Single(APP => APP.ApprovalStatus1 == obj.ApprovalStatusString).ApprovalStatusID;
                member.ApprovalRemarks = obj.ApprovalRemarks;
                member.ModifiedDate = DateTime.Now;
                member.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();


                //get all approvals of the problem record

                int _approved = 0;
                int _pending = 0;
                int _declined = 0;

                var problem = member.Problem;

                foreach (var m in problem.ProblemApprovalMembers)
                {
                    switch (m.ApprovalStatus.ApprovalStatus1)
                    {
                        case "APPROVED":
                            _approved++;
                            break;
                        case "DECLINED":
                            _declined++;
                            break;
                        case "PENDING":
                            _pending++;
                            break;
                    }
                }

                // if at least one decline and the rest is approved
                if ((_declined != 0 && _approved == problem.ProblemApprovalMembers.Count - 1) || (_declined == problem.ProblemApprovalMembers.Count))
                {
                    //change problem status to cancelled                 
                    if (problem.StatusID != (int)ProblemStatus.Cancelled)
                    {
                        problem.StatusID = (int)ProblemStatus.Cancelled;
                        
                        /*set problem record mode to archived since the problem status is cancelled*/
                        problem.RecordModeID = (int)RecordMode.Archived;
                    }
                }
                else if (_approved == problem.ProblemApprovalMembers.Count)
                {
                    //change problem status from pending to open
                    problem.StatusID = (int)ProblemStatus.Open;
                }

                //commit the document status changes
                _context.SubmitChanges();

                result = "Your decision has been committed sucessfully";

            }
            else
            {
                throw new Exception("Cannot find the approval member record");
            }

            return result;
        }


        #endregion
        #region ProjectManagement
        
        [WebMethod]
        public string getProjectID()
        {
            string projectID = null;

            if (_context.ProjectInformations.ToList().Count > 0)
            {
                int maxId = _context.ProjectInformations.Max(i => i.ProjectId);
                projectID = _context.ProjectInformations.Where(PR => PR.ProjectId == maxId).Select(PR => PR.ProjectNumber).SingleOrDefault();
            }
            return projectID == null ? string.Empty : projectID;
        }
        
        [WebMethod]
        public string createNewProject(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Project obj = serializer.Deserialize<Project>(json);
            string result = string.Empty;

            var project = _context.ProjectInformations.Where(PROJ => PROJ.ProjectName == obj.ProjectName)
                .Select(PROJ => PROJ).SingleOrDefault();

            if (project == null)
            {
                project = _context.ProjectInformations.Where(PROJ => PROJ.ProjectNumber == obj.ProjectNo)
                    .Select(PROJ => PROJ).SingleOrDefault();

                if (project == null)
                {
                    project = new ProjectInformation();
                    project.ProjectNumber = obj.ProjectNo;
                    project.ProjectName = obj.ProjectName;
                    project.ProjectDescription = obj.Description == string.Empty ? null : obj.Description;
                    project.StartDate = obj.StartDate;
                    project.PlannedCloseDate = obj.PlannedCloseDate;
                    project.ProjectValue = obj.ProjectValue;
                    project.ProjectCost = obj.ProjectCost;
                    project.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                    project.ProjectLeaderID = (from EMP in _context.Employees
                                               where EMP.FirstName == obj.ProjectLeader.Substring(obj.ProjectLeader.LastIndexOf(".") + 1, obj.ProjectLeader.IndexOf(" ") - 3) &&
                                               EMP.LastName == obj.ProjectLeader.Substring(obj.ProjectLeader.IndexOf(" ") + 1)
                                               select EMP.EmployeeID).SingleOrDefault();
                    project.ProjectStatusID = (int)obj.ProjectStatus;
                    project.ModifiedDate = DateTime.Now;
                    project.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    _context.ProjectInformations.InsertOnSubmit(project);
                    _context.SubmitChanges();

                    //setup automatic email configuration
                    EmailConfiguration automail = new EmailConfiguration();
                    automail.Module = Modules.ProjectManagement;
                    automail.KeyValue = project.ProjectId;
                    automail.Action = "Add";

                    automail.Recipients.Add(project.ProjectLeaderID);

                    bool isGenerated = automail.GenerateEmail();
                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }

                }
                else
                {
                    throw new Exception("The ID of the project should be unique");
                }
            }
            else
            {
                throw new Exception("The name of the project already exists");
            }

            return result;
        }
        [WebMethod]
        public string[] getProjectLeaders()
        {
            var leaders = (from LDR in _context.fn_GetLeaders()
                             select LDR.EmployeeName).ToArray();
            return leaders;
        }
        [WebMethod]
        public void removeProject(int projectID)
        {
            var project = _context.ProjectInformations.Where(PROJ => PROJ.ProjectId == projectID)
              .Select(PROJ => PROJ).SingleOrDefault();
            if (project != null)
            {
                _context.ProjectInformations.DeleteOnSubmit(project);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related project record");
            }
        }
        [WebMethod]
        public string filterProjectsByStatus(string status)
        {
            var projects = _context.ProjectInformations
            .Where(PRJ => PRJ.ProjectStatus.ProjectStatus1==status)
            .Select(PRJ => new Project
            {
                ProjectID = PRJ.ProjectId,
                ProjectNo = PRJ.ProjectNumber,
                ProjectName = PRJ.ProjectName,
                ProjectLeader = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == PRJ.ProjectLeaderID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = PRJ.ProjectDescription == null ? string.Empty : PRJ.ProjectDescription,
                ProjectStatusStr = PRJ.ProjectStatus.ProjectStatus1,
                StartDate = ConvertToLocalTime(PRJ.StartDate),
                PlannedCloseDate = ConvertToLocalTime(PRJ.PlannedCloseDate),
                ActualCloseDate = PRJ.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(PRJ.ActualCloseDate)),
                Currency = PRJ.Currency.CurrencyCode,
                ProjectValue = PRJ.ProjectValue,
                ProjectCost = PRJ.ProjectCost,
                CostAtCompletion = PRJ.CostAtCompletion.HasValue == false ? 0 : Convert.ToDecimal(PRJ.CostAtCompletion)
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Project>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, projects);

            return str.ToString();

        }
        [WebMethod]
        public string filterProjectsByLeader(string leader)
        {
            var projects = _context.ProjectInformations
            .Where(PRJ => PRJ.ProjectLeaderID==(from EMP in _context.Employees
                                               where EMP.FirstName == leader.Substring(leader.LastIndexOf(".") + 1, leader.IndexOf(" ") - 3) &&
                                               EMP.LastName == leader.Substring(leader.IndexOf(" ") + 1)
                                               select EMP.EmployeeID).SingleOrDefault())
            .Select(PRJ => new Project
            {
                ProjectID = PRJ.ProjectId,
                ProjectNo = PRJ.ProjectNumber,
                ProjectName = PRJ.ProjectName,
                ProjectLeader = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == PRJ.ProjectLeaderID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = PRJ.ProjectDescription == null ? string.Empty : PRJ.ProjectDescription,
                ProjectStatusStr = PRJ.ProjectStatus.ProjectStatus1,
                StartDate = ConvertToLocalTime(PRJ.StartDate),
                PlannedCloseDate = ConvertToLocalTime(PRJ.PlannedCloseDate),
                ActualCloseDate = PRJ.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(PRJ.ActualCloseDate)),
                Currency = PRJ.Currency.CurrencyCode,
                ProjectValue = PRJ.ProjectValue,
                ProjectCost = PRJ.ProjectCost,
                CostAtCompletion = PRJ.CostAtCompletion.HasValue == false ? 0 : Convert.ToDecimal(PRJ.CostAtCompletion)
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Project>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, projects);

            return str.ToString();

        }
        [WebMethod]
        public string filterProjectsByDate(string json)
        {
            StringWriter strwriter = new StringWriter();

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var projects = _context.ProjectInformations
            .Where(PRJ => PRJ.StartDate >= obj.StartDate && PRJ.StartDate <= obj.EndDate)
            .Select(PRJ => new Project
            {
                ProjectID = PRJ.ProjectId,
                ProjectNo = PRJ.ProjectNumber,
                ProjectName = PRJ.ProjectName,
                ProjectLeader = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == PRJ.ProjectLeaderID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = PRJ.ProjectDescription == null ? string.Empty : PRJ.ProjectDescription,
                ProjectStatusStr = PRJ.ProjectStatus.ProjectStatus1,
                StartDate = ConvertToLocalTime(PRJ.StartDate),
                PlannedCloseDate = ConvertToLocalTime(PRJ.PlannedCloseDate),
                ActualCloseDate = PRJ.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(PRJ.ActualCloseDate)),
                Currency = PRJ.Currency.CurrencyCode,
                ProjectValue = PRJ.ProjectValue,
                ProjectCost = PRJ.ProjectCost,
                CostAtCompletion = PRJ.CostAtCompletion.HasValue == false ? 0 : Convert.ToDecimal(PRJ.CostAtCompletion)
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Project>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, projects);

            return str.ToString();
        }
        [WebMethod]
        public string filterProjectsByName(string key)
        {
            var projects = _context.ProjectInformations
            .Where(PRJ => PRJ.ProjectName.StartsWith(key))
            .Select(PRJ => new Project
            {
                ProjectID = PRJ.ProjectId,
                ProjectNo = PRJ.ProjectNumber,
                ProjectName = PRJ.ProjectName,
                ProjectLeader = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == PRJ.ProjectLeaderID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = PRJ.ProjectDescription == null ? string.Empty : PRJ.ProjectDescription,
                ProjectStatusStr = PRJ.ProjectStatus.ProjectStatus1,
                StartDate = ConvertToLocalTime(PRJ.StartDate),
                PlannedCloseDate = ConvertToLocalTime(PRJ.PlannedCloseDate),
                ActualCloseDate = PRJ.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(PRJ.ActualCloseDate)),
                Currency = PRJ.Currency.CurrencyCode,
                ProjectValue = PRJ.ProjectValue,
                ProjectCost = PRJ.ProjectCost,
                CostAtCompletion = PRJ.CostAtCompletion.HasValue == false ? 0 : Convert.ToDecimal(PRJ.CostAtCompletion)
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Project>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, projects);

            return str.ToString();

        }
        [WebMethod]
        public string loadProjects()
        {
            var projects = _context.ProjectInformations
            .Select(PRJ => new Project
            {
                ProjectID = PRJ.ProjectId,
                ProjectNo = PRJ.ProjectNumber,
                ProjectName = PRJ.ProjectName,
                ProjectLeader = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == PRJ.ProjectLeaderID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = PRJ.ProjectDescription == null ? string.Empty : PRJ.ProjectDescription,
                ProjectStatusStr = PRJ.ProjectStatus.ProjectStatus1,
                StartDate = ConvertToLocalTime(PRJ.StartDate),
                PlannedCloseDate = ConvertToLocalTime(PRJ.PlannedCloseDate),
                ActualCloseDate = PRJ.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(PRJ.ActualCloseDate)),
                Currency = PRJ.Currency.CurrencyCode,
                ProjectValue = PRJ.ProjectValue,
                ProjectCost = PRJ.ProjectCost,
                CostAtCompletion = PRJ.CostAtCompletion.HasValue == false ? 0 : Convert.ToDecimal(PRJ.CostAtCompletion)
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Project>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, projects);

            return str.ToString();

        }
        [WebMethod]
        public string updateProject(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Project obj = serializer.Deserialize<Project>(json);
            string result = string.Empty;

            var project = _context.ProjectInformations.Where(PROJ => PROJ.ProjectNumber == obj.ProjectNo)
                .Select(PROJ => PROJ).SingleOrDefault();

            if (project != null)
            {
                project.ProjectName = obj.ProjectName;
                project.ProjectDescription = obj.Description == string.Empty ? null : obj.Description;
                project.StartDate = obj.StartDate;
                project.PlannedCloseDate = obj.PlannedCloseDate;
                project.ActualCloseDate = obj.ActualCloseDate == null ? (DateTime?)null : Convert.ToDateTime(obj.ActualCloseDate);
                project.ProjectValue = obj.ProjectValue;
                project.ProjectCost = obj.ProjectCost;
                project.CostAtCompletion = obj.CostAtCompletion == 0 ? (decimal?)null : obj.CostAtCompletion;
                project.CurrencyID = _context.Currencies.Single(CURR => CURR.CurrencyCode == obj.Currency).CurrencyID;
                project.ProjectLeaderID = (from EMP in _context.Employees
                                           where EMP.FirstName == obj.ProjectLeader.Substring(obj.ProjectLeader.LastIndexOf(".") + 1, obj.ProjectLeader.IndexOf(" ") - 3) &&
                                           EMP.LastName == obj.ProjectLeader.Substring(obj.ProjectLeader.IndexOf(" ") + 1)
                                           select EMP.EmployeeID).SingleOrDefault();
                project.ProjectStatusID = _context.ProjectStatus.Single(STS => STS.ProjectStatus1 == obj.ProjectStatusStr).ProjectStatusID;
                project.ModifiedDate = DateTime.Now;
                project.ModifiedBy = HttpContext.Current.User.Identity.Name;

                 _context.SubmitChanges();

                //setup automatic email configuration
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.ProjectManagement;
                automail.KeyValue = project.ProjectId;
                automail.Action = "Update";

                automail.Recipients.Add(project.ProjectLeaderID);

                bool isGenerated = automail.GenerateEmail();
                if (isGenerated == true)
                {
                    result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                }
                else
                {
                    result = "Operation has been committed sucessfully";
                }

            }
            else
            {
                throw new Exception("Cannot find the related project record");
            }

            return result;
        }


        #endregion
        #region ManagementReviews
        [WebMethod]
        public string getReviewID()
        {
            string reviewID = null;

            if (_context.Reviews.ToList().Count > 0)
            {
                int maxId = _context.Reviews.Max(i => i.ReviewID);
                reviewID = _context.Reviews.Where(REV => REV.ReviewID == maxId).Select(REV => REV.ReviewNo).SingleOrDefault();
            }
            return reviewID == null ? string.Empty : reviewID;
        }


        [WebMethod]
        public string loadTaskActionType()
        {
            var actiontype = _context.ActionTypes
           .Select(ACTTYP => new TaskActionType
           {
               TypeID = ACTTYP.ActionTypeID,
               TypeName = ACTTYP.ActionType1,
               Description = ACTTYP.Description == null ? string.Empty : ACTTYP.Description
           }).ToList();

            var serializer = new XmlSerializer(typeof(List<TaskActionType>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, actiontype);

            return strwriter.ToString();
        }

        [WebMethod]
        public void removeTaskActionType(long actiontypeID)
        {
            var actiontype = _context.ActionTypes.Where(ACTTYP => ACTTYP.ActionTypeID == actiontypeID)
            .Select(ACTTYP => ACTTYP).SingleOrDefault();

            if (actiontype != null)
            {
                _context.ActionTypes.DeleteOnSubmit(actiontype);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related action type record");
            }
        }

        [WebMethod]
        public void updateTaskActionType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            TaskActionType obj = serializer.Deserialize<TaskActionType>(json);

            var actiontype = _context.ActionTypes.Where(ACTTYP => ACTTYP.ActionTypeID == obj.TypeID)
           .Select(ACTTYP => ACTTYP).SingleOrDefault();

            if (actiontype != null)
            {
                actiontype.ActionType1 = obj.TypeName;
                actiontype.Description = obj.Description == string.Empty ? null : obj.Description;
                actiontype.ModifiedDate = DateTime.Now;
                actiontype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related action type record");
            }
        }

        [WebMethod]
        public void createTaskActionType(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            TaskActionType obj = serializer.Deserialize<TaskActionType>(json);

            var actiontype = _context.ActionTypes.Where(ACTTYP => ACTTYP.ActionType1 == obj.TypeName)
            .Select(ACTTYP => ACTTYP).SingleOrDefault();

            if (actiontype == null)
            {
                actiontype = new LINQConnection.ActionType();
                actiontype.ActionType1 = obj.TypeName;
                actiontype.Description = obj.Description == string.Empty ? null : obj.Description;
                actiontype.ModifiedDate = DateTime.Now;
                actiontype.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.ActionTypes.InsertOnSubmit(actiontype);
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("The name of the action type already exists");
            }
        }
       
        [WebMethod]
        public string filterManagementReviewsByCategory(string category)
        {
            StringWriter strwriter = new StringWriter();

            var reviews = _context.Reviews
              .Where(REV => REV.ReviewCategory.ReviewCategory1 ==category)
              .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new Review
            {
                ReviewID = REV.ReviewID,
                ReviewNo = REV.ReviewNo,
                ReviewName = REV.EventName,
                PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                Objectives = REV.Objectives,
                ReviewCategory = REV.ReviewCategory.ReviewCategory1,
                Mode = (RecordMode)REV.RecordModeID,
                Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                {
                    ORGID = UNT.OrganizationUnit.UnitID,
                    name = UNT.OrganizationUnit.UnitName,
                    ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                    Country = UNT.OrganizationUnit.Country.CountryName,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),

                Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                {
                    EmployeeID = ADTR.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == ADTR.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),
                Tasks = REV.Tasks.Select(TSK => new ReviewTask
                {
                    TaskID = TSK.TaskID,
                    TaskName = TSK.TaskName,
                    Description = TSK.Description == null ? string.Empty : TSK.Description,
                    Owner = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == TSK.OwnerID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                    ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                    IsClosed=TSK.IsClosed,
                    Actions = TSK.ReviewActions.Select(ACT => new ManagentReviewAction
                    {
                        ActionID = ACT.ReviewActionID,
                        ActionType = ACT.ActionType.ActionType1,
                        Details = ACT.Details == null ? string.Empty : ACT.Details,
                        FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                        Actionee = (from T in _context.Titles
                                    join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                    from g in empgroup
                                    where g.EmployeeID == ACT.ActioneeID
                                    select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                        TargetClosingDate = ConvertToLocalTime(ACT.TargetCloseDate),
                        CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                        DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                        IsClosed = ACT.IsClosed,
                        Module = Modules.ManagementReviewActions
                    }).ToList()


                }).ToList()

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Review>));

            serializer.Serialize(strwriter, reviews);
            return strwriter.ToString();
        }
        [WebMethod]
        public string filterManagementReviewsByDate(string json)
        {
            StringWriter strwriter = new StringWriter();

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var reviews = _context.Reviews
              .Where(REV => REV.PlannedReviewDate >= obj.StartDate && REV.PlannedReviewDate <= obj.EndDate)
              .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new Review
            {
                ReviewID = REV.ReviewID,
                ReviewNo = REV.ReviewNo,
                ReviewName = REV.EventName,
                PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                Objectives = REV.Objectives,
                ReviewCategory = REV.ReviewCategory.ReviewCategory1,
                Mode = (RecordMode)REV.RecordModeID,
                Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                {
                    ORGID = UNT.OrganizationUnit.UnitID,
                    name = UNT.OrganizationUnit.UnitName,
                    ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                    Country = UNT.OrganizationUnit.Country.CountryName,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),

                Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                {
                    EmployeeID = ADTR.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == ADTR.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),
                Tasks = REV.Tasks.Select(TSK => new ReviewTask
                {
                    TaskID = TSK.TaskID,
                    TaskName = TSK.TaskName,
                    Description = TSK.Description == null ? string.Empty : TSK.Description,
                    Owner = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == TSK.OwnerID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                    ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                    IsClosed=TSK.IsClosed,
                    Actions = TSK.ReviewActions.Select(ACT => new ManagentReviewAction
                    {
                        ActionID = ACT.ReviewActionID,
                        ActionType = ACT.ActionType.ActionType1,
                        Details = ACT.Details == null ? string.Empty : ACT.Details,
                        FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                        Actionee = (from T in _context.Titles
                                    join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                    from g in empgroup
                                    where g.EmployeeID == ACT.ActioneeID
                                    select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                        TargetClosingDate = ConvertToLocalTime(ACT.TargetCloseDate),
                        CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                        DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                        IsClosed = ACT.IsClosed,
                        Module = Modules.ManagementReviewActions
                    }).ToList()


                }).ToList()

            }).ToList();
            var serializer = new XmlSerializer(typeof(List<Review>));

            serializer.Serialize(strwriter, reviews);
            return strwriter.ToString();
        }
        [WebMethod]
        public string filterManagementReviewsByMode(string mode)
        {
            StringWriter strwriter = new StringWriter();

            var reviews = _context.Reviews
            .Where(REV => REV.RecordMode.RecordMode1 == mode)
            .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new Review
            {
                ReviewID = REV.ReviewID,
                ReviewNo = REV.ReviewNo,
                ReviewName = REV.EventName,
                PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                Objectives = REV.Objectives,
                ReviewCategory = REV.ReviewCategory.ReviewCategory1,
                Mode = (RecordMode)REV.RecordModeID,
                Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                {
                    ORGID = UNT.OrganizationUnit.UnitID,
                    name = UNT.OrganizationUnit.UnitName,
                    ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                    Country = UNT.OrganizationUnit.Country.CountryName,
                    Status = RecordsStatus.ORIGINAL
                }).ToList(),

                Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                {
                    EmployeeID = ADTR.EmployeeID,
                    NameFormat = (from T in _context.Titles
                                  join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                  from g in empgroup
                                  where g.EmployeeID == ADTR.EmployeeID
                                  select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                }).ToList(),
                Tasks = REV.Tasks.Select(TSK => new ReviewTask
                {
                    TaskID = TSK.TaskID,
                    TaskName = TSK.TaskName,
                    Description = TSK.Description == null ? string.Empty : TSK.Description,
                    Owner = (from T in _context.Titles
                             join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                             from g in empgroup
                             where g.EmployeeID == TSK.OwnerID
                             select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                    ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                    IsClosed=TSK.IsClosed,
                    Actions = TSK.ReviewActions.Select(ACT => new ManagentReviewAction
                    {
                        ActionID = ACT.ReviewActionID,
                        ActionType = ACT.ActionType.ActionType1,
                        Details = ACT.Details == null ? string.Empty : ACT.Details,
                        FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                        Actionee = (from T in _context.Titles
                                    join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                    from g in empgroup
                                    where g.EmployeeID == ACT.ActioneeID
                                    select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                        TargetClosingDate = ConvertToLocalTime(ACT.TargetCloseDate),
                        CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                        DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                        IsClosed = ACT.IsClosed,
                        Module = Modules.ManagementReviewActions
                    }).ToList()


                }).ToList()

            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Review>));

            serializer.Serialize(strwriter, reviews);
            return strwriter.ToString();
        }

        [WebMethod]
        public string filterManagementReviewsByStatus(string status)
        {
            StringWriter strwriter = new StringWriter();

            var reviews = _context.Reviews
             .Where(REV => REV.ManagementStatus.ManagementStatus1 == status)
             .OrderBy(REV => REV.PlannedReviewDate)
             .Select(REV => new Review
             {
                 ReviewID = REV.ReviewID,
                 ReviewNo = REV.ReviewNo,
                 ReviewName=REV.EventName,
                 PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                 ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                 ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                 Objectives = REV.Objectives,
                 ReviewCategory=REV.ReviewCategory.ReviewCategory1,
                 Mode = (RecordMode)REV.RecordModeID,
                 Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                 {
                     ORGID = UNT.OrganizationUnit.UnitID,
                     name = UNT.OrganizationUnit.UnitName,
                     ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                     Country = UNT.OrganizationUnit.Country.CountryName,
                     Status = RecordsStatus.ORIGINAL
                 }).ToList(),

                 Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                 {
                     EmployeeID = ADTR.EmployeeID,
                     NameFormat = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == ADTR.EmployeeID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                 }).ToList(),
                 Tasks = REV.Tasks.Select(TSK => new ReviewTask
                 {
                     TaskID = TSK.TaskID,
                     TaskName = TSK.TaskName,
                     Description = TSK.Description == null ? string.Empty : TSK.Description,
                     Owner = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == TSK.OwnerID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                     PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                     ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                     IsClosed=TSK.IsClosed,
                     Actions = TSK.ReviewActions.Select(ACT => new ManagentReviewAction
                     {
                         ActionID = ACT.ReviewActionID,
                         ActionType = ACT.ActionType.ActionType1,
                         Details = ACT.Details == null ? string.Empty : ACT.Details,
                         FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                         Actionee = (from T in _context.Titles
                                     join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                     from g in empgroup
                                     where g.EmployeeID == ACT.ActioneeID
                                     select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                         TargetClosingDate = ConvertToLocalTime(ACT.TargetCloseDate),
                         CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                         DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                         IsClosed = ACT.IsClosed,
                         Module = Modules.ManagementReviewActions
                     }).ToList()


                 }).ToList()

             }).ToList();

            var serializer = new XmlSerializer(typeof(List<Review>));

            serializer.Serialize(strwriter, reviews);
            return strwriter.ToString();
        }

        [WebMethod]
        public string filterManagementReviewsByMeetingTitle(string title)
        {
            StringWriter strwriter = new StringWriter();

            var reviews = _context.Reviews
             .Where(REV => REV.EventName.StartsWith(title))
             .OrderBy(REV => REV.PlannedReviewDate)
             .Select(REV => new Review
             {
                 ReviewID = REV.ReviewID,
                 ReviewNo = REV.ReviewNo,
                 ReviewName = REV.EventName,
                 PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                 ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                 ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                 Objectives = REV.Objectives,
                 ReviewCategory = REV.ReviewCategory.ReviewCategory1,
                 Mode = (RecordMode)REV.RecordModeID,
                 Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                 {
                     ORGID = UNT.OrganizationUnit.UnitID,
                     name = UNT.OrganizationUnit.UnitName,
                     ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                     Country = UNT.OrganizationUnit.Country.CountryName,
                     Status = RecordsStatus.ORIGINAL
                 }).ToList(),

                 Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                 {
                     EmployeeID = ADTR.EmployeeID,
                     NameFormat = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == ADTR.EmployeeID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                 }).ToList(),
                 Tasks = REV.Tasks.Select(TSK => new ReviewTask
                 {
                     TaskID = TSK.TaskID,
                     TaskName = TSK.TaskName,
                     Description = TSK.Description == null ? string.Empty : TSK.Description,
                     Owner = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == TSK.OwnerID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                     PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                     ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                     IsClosed=TSK.IsClosed,
                     Actions = TSK.ReviewActions.Select(ACT => new ManagentReviewAction
                     {
                         ActionID = ACT.ReviewActionID,
                         ActionType = ACT.ActionType.ActionType1,
                         Details = ACT.Details == null ? string.Empty : ACT.Details,
                         FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                         Actionee = (from T in _context.Titles
                                     join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                     from g in empgroup
                                     where g.EmployeeID == ACT.ActioneeID
                                     select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                         TargetClosingDate = ConvertToLocalTime(ACT.TargetCloseDate),
                         CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                         DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                         IsClosed = ACT.IsClosed,
                         Module = Modules.ManagementReviewActions
                     }).ToList()


                 }).ToList()

             }).ToList();

            var serializer = new XmlSerializer(typeof(List<Review>));

            serializer.Serialize(strwriter, reviews);
            return strwriter.ToString();
        }

        [WebMethod]
        public string filterManagementReviewsByTaskTitle(string task)
        {
            StringWriter strwriter = new StringWriter();

            var reviews = _context.Reviews
             .OrderBy(REV => REV.PlannedReviewDate)
             .Select(REV => new Review
             {
                 ReviewID = REV.ReviewID,
                 ReviewNo = REV.ReviewNo,
                 ReviewName = REV.EventName,
                 PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                 ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                 ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                 Objectives = REV.Objectives,
                 ReviewCategory = REV.ReviewCategory.ReviewCategory1,
                 Mode = (RecordMode)REV.RecordModeID,
                 Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                 {
                     ORGID = UNT.OrganizationUnit.UnitID,
                     name = UNT.OrganizationUnit.UnitName,
                     ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                     Country = UNT.OrganizationUnit.Country.CountryName,
                     Status = RecordsStatus.ORIGINAL
                 }).ToList(),

                 Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                 {
                     EmployeeID = ADTR.EmployeeID,
                     NameFormat = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == ADTR.EmployeeID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                 }).ToList(),
                 Tasks = REV.Tasks
                 .Where(TSK=>TSK.TaskName.StartsWith(task))
                 .Select(TSK => new ReviewTask
                 {
                     TaskID = TSK.TaskID,
                     TaskName = TSK.TaskName,
                     Description = TSK.Description == null ? string.Empty : TSK.Description,
                     Owner = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == TSK.OwnerID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                     PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                     ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                     IsClosed=TSK.IsClosed,
                     Actions = TSK.ReviewActions.Select(ACT => new ManagentReviewAction
                     {
                         ActionID = ACT.ReviewActionID,
                         ActionType = ACT.ActionType.ActionType1,
                         Details = ACT.Details == null ? string.Empty : ACT.Details,
                         FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                         Actionee = (from T in _context.Titles
                                     join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                     from g in empgroup
                                     where g.EmployeeID == ACT.ActioneeID
                                     select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                         TargetClosingDate = ConvertToLocalTime(ACT.TargetCloseDate),
                         CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                         DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                         IsClosed = ACT.IsClosed,
                         Module = Modules.ManagementReviewActions
                     }).ToList()


                 }).ToList()

             }).ToList();

            var serializer = new XmlSerializer(typeof(List<Review>));

            serializer.Serialize(strwriter, reviews);
            return strwriter.ToString();
        }

        [WebMethod]
        public string getManagementReviewByUniqueNo(string reviewno)
        {
            var review = (from REV in _context.Reviews
                          where REV.ReviewNo == reviewno
                          select new Review
                          {
                              ReviewID = REV.ReviewID,
                              ReviewNo = REV.ReviewNo,
                              ReviewCategory = REV.ReviewCategory.ReviewCategory1,
                              Objectives = REV.Objectives == null ? string.Empty : REV.Objectives,
                              Notes = REV.Notes == null ? string.Empty : REV.Notes,
                              Summary = REV.Summary == null ? string.Empty : REV.Summary,
                              ReviewName = REV.EventName,
                              PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                              ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                              ActualCloseDate = REV.ActualCloseDate != null ? ConvertToLocalTime(REV.ActualCloseDate.Value) : REV.ActualCloseDate,
                              ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,

                              Tasks = REV.Tasks.Select(TSK => new ReviewTask
                              {
                                  TaskID = TSK.TaskID,
                                  TaskName = TSK.TaskName,
                                  Description = TSK.Description == null ? string.Empty : TSK.Description,
                                  PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                                  ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                                   Owner = (from T in _context.Titles
                                           join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                           from g in empgroup
                                           where g.EmployeeID == TSK.OwnerID
                                           select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()

                              }).ToList()
                          }).SingleOrDefault();

            if (review == null)
            {
                throw new Exception("Cannot to find the related management review record");
            }

            var serializer = new XmlSerializer(typeof(Review));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, review);

            return strwriter.ToString();
        }
        [WebMethod]
        public string getManagementReview(int reviewID)
        {
            var review = (from REV in _context.Reviews
                          where REV.ReviewID == reviewID
                          select new Review
                          {
                              ReviewID = REV.ReviewID,
                              ReviewNo = REV.ReviewNo,
                              ReviewCategory = REV.ReviewCategory.ReviewCategory1,
                              Objectives = REV.Objectives == null ? string.Empty : REV.Objectives,
                              Notes = REV.Notes == null ? string.Empty : REV.Notes,
                              Summary = REV.Summary == null ? string.Empty : REV.Summary,
                              ReviewName = REV.EventName,
                              PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                              ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                              ActualCloseDate = REV.ActualCloseDate != null ? ConvertToLocalTime(REV.ActualCloseDate.Value) : REV.ActualCloseDate,
                              ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                              Mode=(RecordMode)REV.RecordModeID,
                              Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                              {
                                  ORGID = UNT.OrganizationUnit.UnitID,
                                  name = UNT.OrganizationUnit.UnitName,
                                  ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                                  Country = UNT.OrganizationUnit.Country.CountryName,
                                  Status = RecordsStatus.ORIGINAL
                              }).ToList(),

                              Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                              {
                                  EmployeeID = ADTR.EmployeeID,
                                  NameFormat = (from T in _context.Titles
                                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                from g in empgroup
                                                where g.EmployeeID == ADTR.EmployeeID
                                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                              }).ToList(),

                              ReviewRecipients = REV.ReviewRecipients.Select(REC => new Employee
                              {
                                  EmployeeID = REC.EmployeeID,
                                  NameFormat = (from T in _context.Titles
                                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                from g in empgroup
                                                where g.EmployeeID == REC.EmployeeID
                                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                              }).ToList(),

                          }).SingleOrDefault();

            if (review == null)
            {
                throw new Exception("Cannot to find the related management review record");
            }

            var serializer = new XmlSerializer(typeof(Review));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, review);

            return strwriter.ToString();
        }
        [WebMethod]
        public string loadManagementReviews()
        {
            StringWriter strwriter = new StringWriter();

            try
            {
                var reviews = _context.Reviews
                .OrderBy(REV => REV.PlannedReviewDate)
                .Select(REV => new Review
                {
                    ReviewID = REV.ReviewID,
                    ReviewNo = REV.ReviewNo,
                    ReviewName=REV.EventName,
                    PlannedReviewDate = ConvertToLocalTime(REV.PlannedReviewDate),
                    ActualReviewDate = REV.ActualReviewDate != null ? ConvertToLocalTime(REV.ActualReviewDate.Value) : REV.ActualReviewDate,
                    ReviewStatusStr = REV.ManagementStatus.ManagementStatus1,
                    Objectives = REV.Objectives,
                    ReviewCategory=REV.ReviewCategory.ReviewCategory1,
                    Mode = (RecordMode)REV.RecordModeID,
                    Units = REV.RelatedReviewUnits.Select(UNT => new ORGUnit
                    {
                        ORGID = UNT.OrganizationUnit.UnitID,
                        name = UNT.OrganizationUnit.UnitName,
                        ORGLevel = UNT.OrganizationUnit.OrganizationLevel.ORGLevel,
                        Country = UNT.OrganizationUnit.Country.CountryName,
                        Status = RecordsStatus.ORIGINAL
                    }).ToList(),

                    Representatives = REV.ManagementRepresentatives.Select(ADTR => new Employee
                    {
                        EmployeeID = ADTR.EmployeeID,
                        NameFormat = (from T in _context.Titles
                                      join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                      from g in empgroup
                                      where g.EmployeeID == ADTR.EmployeeID
                                      select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()
                    }).ToList(),
                    Tasks = REV.Tasks.Select(TSK => new ReviewTask
                    {
                        TaskID = TSK.TaskID,
                        TaskName = TSK.TaskName,
                        Description = TSK.Description == null ? string.Empty : TSK.Description,
                        Owner = (from T in _context.Titles
                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                 from g in empgroup
                                 where g.EmployeeID == TSK.OwnerID
                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                        PlannedCloseDate = ConvertToLocalTime(TSK.PlannedCloseDate),
                        ActualCloseDate = TSK.ActualCloseDate != null ? ConvertToLocalTime(TSK.ActualCloseDate.Value) : TSK.ActualCloseDate,
                        IsClosed=TSK.IsClosed,
                        Actions = TSK.ReviewActions.Select(ACT => new ManagentReviewAction
                        {
                            ActionID = ACT.ReviewActionID,
                            ActionType = ACT.ActionType.ActionType1,
                            Details = ACT.Details == null ? string.Empty : ACT.Details,
                            FollowUpComments = ACT.FollowUpComments == null ? string.Empty : ACT.FollowUpComments,
                            Actionee = (from T in _context.Titles
                                        join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                        from g in empgroup
                                        where g.EmployeeID == ACT.ActioneeID
                                        select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                            TargetClosingDate = ConvertToLocalTime(ACT.TargetCloseDate),
                            CompleteDate = ACT.CompletedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.CompletedDate.Value),
                            DelayedDate = ACT.DelayedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(ACT.DelayedDate.Value),
                            IsClosed = ACT.IsClosed,
                            Module = Modules.ManagementReviewActions
                        }).ToList()

                    }).ToList()

                }).ToList();

                var serializer = new XmlSerializer(typeof(List<Review>));

                serializer.Serialize(strwriter, reviews);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return strwriter.ToString();
        }

        [WebMethod]
        public void removeTask(int taskID)
        {
            var task = _context.Tasks.Where(TSK => TSK.TaskID == taskID).Select(TSK => TSK).SingleOrDefault();
            if (task != null)
            {
                _context.Tasks.DeleteOnSubmit(task);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related task record");
            }
        }

        [WebMethod]
        public void updateTask(string json)
        {
            string result = string.Empty;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ReviewTask obj = serializer.Deserialize<ReviewTask>(json);


            var task = _context.Tasks.Where(TSK => TSK.TaskID == obj.TaskID).Select(TSK => TSK).SingleOrDefault();
            if (task != null)
            {
                task.TaskName = obj.TaskName;
                task.Description = obj.Description == string.Empty ? null : obj.Description;
                task.PlannedCloseDate = obj.PlannedCloseDate;
                task.OwnerID = (from EMP in _context.Employees
                                where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                select EMP.EmployeeID).SingleOrDefault();
                task.ModifiedDate = DateTime.Now;
                task.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.ActualCloseDate != null)
                {
                    /*check if all actions are closed*/

                    task.ActualCloseDate = Convert.ToDateTime(obj.ActualCloseDate);

                    int outstandingactions = 0;
                    foreach (var action in task.ReviewActions)
                    {
                        if (action.IsClosed == false)
                        {
                            outstandingactions++;
                        }
                    }

                    if (outstandingactions > 0)
                    {
                        throw new Exception("The system cannot allow closing the current task record, since there are outstanding actions which must be closed first");
                    }
                    else
                    {
                        task.IsClosed = true;
                    }
                }
                else
                {
                    task.ActualCloseDate = (DateTime?)null;
                    task.IsClosed = false;
                }

                _context.SubmitChanges();


            }
            else
            {
                throw new Exception("Cannot find the related task record");
            }
        }
        

        [WebMethod]
        public void removeTaskAction(int actionID)
        {
            var reviewaction = _context.ReviewActions.Where(ACT => ACT.ReviewActionID == actionID).Select(ACT => ACT).SingleOrDefault();
            if (reviewaction != null)
            {
                _context.ReviewActions.DeleteOnSubmit(reviewaction);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related review action record");
            }
        }
        [WebMethod]
        public string updateTaskAction(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ManagentReviewAction obj = serializer.Deserialize<ManagentReviewAction>(json);
            var result = string.Empty;

            var action = _context.ReviewActions.Where(ACT => ACT.ReviewActionID == obj.ActionID)
                .Select(ACT => ACT).SingleOrDefault();
            if (action != null)
            {
                action.ActionTypeID = _context.ActionTypes.Single(ACTTYP => ACTTYP.ActionType1 == obj.ActionType).ActionTypeID;
                action.Details = (obj.Details == string.Empty ? null : obj.Details);
                action.FollowUpComments = (obj.FollowUpComments == string.Empty ? null : obj.FollowUpComments);
                action.TargetCloseDate = obj.TargetClosingDate;
                action.DelayedDate = (obj.DelayedDate == null ? null : obj.DelayedDate);
                action.CompletedDate = (obj.CompleteDate == null ? null : obj.CompleteDate);
                action.ActioneeID = (from EMP in _context.Employees
                                     where EMP.FirstName == obj.Actionee.Substring(obj.Actionee.LastIndexOf(".") + 1, obj.Actionee.IndexOf(" ") - 3) &&
                                     EMP.LastName == obj.Actionee.Substring(obj.Actionee.IndexOf(" ") + 1)
                                     select EMP.EmployeeID).SingleOrDefault();

                action.IsClosed = obj.IsClosed;
                action.ModifiedDate = DateTime.Now;
                action.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

                // generate automatic email notification for adding new CCN
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.ManagementReviewActions;
                automail.KeyValue = action.ReviewActionID;
                automail.Action = "Update";

                //add actionee as a recipient
                automail.Recipients.Add(action.ActioneeID);

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }

            }
            else
            {
                throw new Exception("Cannot find the related review action record");
            }
            return result;
        }
        [WebMethod]
        public string createTaskAction(string json, int taskID)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ManagentReviewAction obj = serializer.Deserialize<ManagentReviewAction>(json);

            var task = _context.Tasks.Where(TSK => TSK.TaskID == taskID)
                .Select(TSK => TSK).SingleOrDefault();

            if (task != null)
            {
                ReviewAction action=new ReviewAction();
                action.ActionTypeID = _context.ActionTypes.Single(AT => AT.ActionType1 == obj.ActionType).ActionTypeID;
                action.Details = obj.Details == string.Empty ? null : obj.Details;
                action.TargetCloseDate = obj.TargetClosingDate;
                action.ActioneeID = (from EMP in _context.Employees
                                     where EMP.FirstName == obj.Actionee.Substring(obj.Actionee.LastIndexOf(".") + 1, obj.Actionee.IndexOf(" ") - 3) &&
                                  EMP.LastName == obj.Actionee.Substring(obj.Actionee.IndexOf(" ") + 1)
                                  select EMP.EmployeeID).SingleOrDefault();
                action.ModifiedDate = DateTime.Now;
                action.ModifiedBy = HttpContext.Current.User.Identity.Name;


                task.ReviewActions.Add(action);
                _context.SubmitChanges();

                // generate automatic email notification for adding new management review action
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.ManagementReviewActions;
                automail.KeyValue = action.ReviewActionID;
                automail.Action = "Add";

                //add actionee as a recipient
                automail.Recipients.Add(action.ActioneeID);

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Cannot find the related task record");

            }
            return result;
        }
        [WebMethod]
        public string createTask(string json,string reviewno)
        {
            string result = string.Empty;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ReviewTask obj = serializer.Deserialize<ReviewTask>(json);


            var review = _context.Reviews.Where(REV => REV.ReviewNo == reviewno).Select(REV => REV).SingleOrDefault();
            if (review != null)
            {
                var task = review.Tasks.Where(TSK => TSK.TaskName == obj.TaskName).Select(TSK => TSK).SingleOrDefault();
                if (task == null)
                {
                    task = new Task();
                    task.TaskName = obj.TaskName;
                    task.Description = obj.Description == string.Empty ? null : obj.Description;
                    task.PlannedCloseDate = obj.PlannedCloseDate;
                    task.OwnerID = (from EMP in _context.Employees
                                    where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                    EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                    select EMP.EmployeeID).SingleOrDefault();

                    task.ModifiedDate = DateTime.Now;
                    task.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    review.Tasks.Add(task);

                    _context.SubmitChanges();

                    result = "Operation has been committed sucessfully";
                }
                else
                {
                    throw new Exception("The name of the task already exists");
                }

            }
            else
            {
                throw new Exception("Cannot find the related management review record"); 
            }

            return result;
        }
        [WebMethod]
        public void createReviewCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.ReviewCategories.Where(CAT => CAT.ReviewCategory1 == obj.CategoryName).Select(CAT => CAT).SingleOrDefault();
            if (category == null)
            {
                category = new LINQConnection.ReviewCategory();
                category.ReviewCategory1 = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.ReviewCategories.InsertOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the management review category already exists");
            }
        }
        [WebMethod]
        public void updateReviewCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.ReviewCategories.Where(CAT => CAT.ReviewCategoryID == obj.CategoryID).Select(CAT => CAT).SingleOrDefault();
            if (category != null)
            {
                category.ReviewCategory1 = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;


                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related management review category record");
            }
        }
        [WebMethod]
        public void removeReviewCategory(int ID)
        {
            var category = _context.ReviewCategories.Where(CAT => CAT.ReviewCategoryID == ID).Select(CAT => CAT).SingleOrDefault();
            if (category != null)
            {
                _context.ReviewCategories.DeleteOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related management review category record");
            }
        }
        [WebMethod]
        public string loadReviewCategories()
        {
            var categories = _context.ReviewCategories
                .OrderBy(CAT => CAT.ReviewCategory1)
                .Select(CAT => new Category
                {
                    CategoryID = CAT.ReviewCategoryID,
                    CategoryName = CAT.ReviewCategory1,
                    Description = CAT.Description == null ? string.Empty : CAT.Description,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

            var xml = new XmlSerializer(typeof(List<Category>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, categories);

            return str.ToString();
        }

        [WebMethod]
        public string updateReview(string json)
        {
            string result = string.Empty;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Review obj = serializer.Deserialize<Review>(json);

            var review = _context.Reviews.Where(REV => REV.ReviewNo == obj.ReviewNo).Select(REV => REV).SingleOrDefault();
            if (review != null)
            {
                review.ReviewCategoryID = _context.ReviewCategories.Where(REVCAT => REVCAT.ReviewCategory1 == obj.ReviewCategory).Select(REVCAT => REVCAT.ReviewCategoryID).FirstOrDefault() == 0 ? (int?)null : _context.ReviewCategories.Where(REVCAT => REVCAT.ReviewCategory1 == obj.ReviewCategory).Select(REVCAT => REVCAT.ReviewCategoryID).FirstOrDefault();
                review.EventName = obj.ReviewName;
                review.PlannedReviewDate = obj.PlannedReviewDate;
                review.ActualReviewDate = obj.ActualReviewDate.HasValue == false ? null : obj.ActualReviewDate;
                review.Objectives = obj.Objectives == string.Empty ? null : obj.Objectives;
                review.Summary = obj.Summary == string.Empty ? null : obj.Summary;
                review.Notes = obj.Notes == string.Empty ? null : obj.Notes;
                review.ManagementStatusID = _context.ManagementStatus.Single(STS => STS.ManagementStatus1 == obj.ReviewStatusStr).ManagementStatusID;
                review.ModifiedDate = DateTime.Now;
                review.ModifiedBy = HttpContext.Current.User.Identity.Name;


                /*if the actual close date of the management review is set, then the system shall perform the following:
                 * 1- Check if there are outstanding tasks, then abort the update transaction. 
                 * 2- If there are no outstanding tasks, then, set the status of the management review is set to completed.
                 */

                if (obj.ActualCloseDate != null)
                {
                    review.ActualCloseDate = Convert.ToDateTime(obj.ActualCloseDate);

                    int outstandingtasks = 0;

                    foreach (var task in review.Tasks)
                    {
                        if (task.IsClosed == false)
                        {
                            outstandingtasks++;
                        }
                    }

                    if (outstandingtasks > 0)
                    {
                        throw new Exception("The system cannot allow updating and closing the management review record, since there are outstanding tasks which must be closed first");
                    }
                    else
                    {
                        review.ManagementStatusID = (int)ReviewStatus.Completed;
                    }
                }
                else
                {

                    review.ActualCloseDate = (DateTime?)null;
                }

                switch ((ReviewStatus)review.ManagementStatusID)
                {
                    case ReviewStatus.Completed:
                    case ReviewStatus.Cancelled:
                        review.RecordModeID = (int)RecordMode.Archived;
                        break;
                    case ReviewStatus.InProgress:
                    case ReviewStatus.Pending:
                    case ReviewStatus.Rescheduled:
                        review.RecordModeID = (int)RecordMode.Current;
                        break;
                }

                if (obj.Representatives != null)
                {
                    ManagementRepresentative representative = null;
                    foreach (var employee in obj.Representatives)
                    {
                        var employeeID = (from EMP in _context.Employees
                                          where EMP.FirstName == employee.NameFormat.Substring(employee.NameFormat.LastIndexOf(".") + 1, employee.NameFormat.IndexOf(" ") - 3) &&
                                          EMP.LastName == employee.NameFormat.Substring(employee.NameFormat.IndexOf(" ") + 1)
                                          select EMP.EmployeeID).SingleOrDefault();

                        switch (employee.Status)
                        {
                            case RecordsStatus.ADDED:
                                representative = review.ManagementRepresentatives.Where(REPTV => REPTV.EmployeeID == employeeID).Select(REPTV => REPTV).SingleOrDefault();

                                //if (representative == null)
                                //{
                                    representative = new ManagementRepresentative();
                                    representative.EmployeeID = employeeID;
                                    representative.ModifiedDate = DateTime.Now;
                                    representative.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                    review.ManagementRepresentatives.Add(representative);
                               // }
                                break;
                            case RecordsStatus.REMOVED:
                                representative = review.ManagementRepresentatives.Where(REPTV => REPTV.EmployeeID == employeeID).Select(REPTV => REPTV).SingleOrDefault();
                                if (representative != null)
                                {
                                    _context.ManagementRepresentatives.DeleteOnSubmit(representative);
                                }
                                break;
                        }

                    }
                }

                if (obj.Units != null)
                {
                    RelatedReviewUnit relatedunit = null;
                    foreach (var unit in obj.Units)
                    {
                        switch (unit.Status)
                        {
                            case RecordsStatus.ADDED:
                                relatedunit = review.RelatedReviewUnits.Where(UNT => UNT.UnitID == unit.ORGID).Select(UNT => UNT).SingleOrDefault();
                                if (relatedunit == null)
                                {
                                    relatedunit = new RelatedReviewUnit();
                                    relatedunit.UnitID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == unit.name).UnitID;
                                    relatedunit.ModifiedDate = DateTime.Now;
                                    relatedunit.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                    review.RelatedReviewUnits.Add(relatedunit);
                                }
                                break;
                            case RecordsStatus.REMOVED:
                                relatedunit = review.RelatedReviewUnits.Where(UNT => UNT.UnitID == unit.ORGID).Select(UNT => UNT).SingleOrDefault();
                                if (relatedunit != null)
                                {
                                    _context.RelatedReviewUnits.DeleteOnSubmit(relatedunit);
                                }
                                break;
                        }

                    }
                }

                EmailConfiguration automail = null;


                if (obj.Recipients != null)
                {
                    // generate automatic email notification for adding audit record
                    automail = new EmailConfiguration();
                    automail.Module = Modules.ManagementReviews;
                    automail.KeyValue = review.ReviewID;
                    automail.Action = "Update";

                    ReviewRecipient reviewRecipient = null;
                    var query = review.ReviewRecipients.Where(R => R.ReviewID == review.ReviewID).Select(R => R.EmployeeID).ToList();
                    List<int> ids = new List<int>();

                    foreach (var recipient in obj.Recipients)
                    {
                        //add both the originator and the owner as a recipient
                        int employeeID = (from EMP in _context.Employees
                                          where EMP.FirstName == recipient.Employee.Substring(recipient.Employee.LastIndexOf(".") + 1, recipient.Employee.IndexOf(" ") - 3) &&
                                          EMP.LastName == recipient.Employee.Substring(recipient.Employee.IndexOf(" ") + 1)
                                          select EMP.EmployeeID).SingleOrDefault();
                        automail.Recipients.Add(employeeID);

                        ids.Add(employeeID);
                        reviewRecipient = review.ReviewRecipients.Where(R => R.EmployeeID == employeeID).Select(R => R).SingleOrDefault();

                        if(reviewRecipient == null)
                        {
                            ReviewRecipient rec = new ReviewRecipient();
                            rec.EmployeeID = employeeID;
                            rec.ReviewID = review.ReviewID;
                            rec.ModifiedDate = DateTime.Now;
                            rec.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            _context.ReviewRecipients.InsertOnSubmit(rec);
                            review.ReviewRecipients.Add(rec);
                        }
                    }

                    var deleteRecipient = query.Except(ids);
                    foreach (var del in deleteRecipient)
                    {
                        reviewRecipient = review.ReviewRecipients.Where(R => R.EmployeeID == del).SingleOrDefault();
                        _context.ReviewRecipients.DeleteOnSubmit(reviewRecipient);
                    }
                }else
                {
                    var recipient = _context.ReviewRecipients.Where(r => r.ReviewID == review.ReviewID);
                    _context.ReviewRecipients.DeleteAllOnSubmit(recipient);
                }

                _context.SubmitChanges();

                //EmailConfiguration automail = null;

                //if (obj.Recipients != null)
                //{
                //    // generate automatic email notification for modifying review record
                //    automail = new EmailConfiguration();
                //    automail.Module = Modules.ManagementReviews;
                //    automail.KeyValue = review.ReviewID;
                //    automail.Action = "Update";
                //    foreach (var recipient in obj.Recipients)
                //    {
                //        //add both the originator and the owner as a recipient
                //        int employeeID = (from EMP in _context.Employees
                //                          where EMP.FirstName == recipient.Employee.Substring(recipient.Employee.LastIndexOf(".") + 1, recipient.Employee.IndexOf(" ") - 3) &&
                //                          EMP.LastName == recipient.Employee.Substring(recipient.Employee.IndexOf(" ") + 1)
                //                          select EMP.EmployeeID).SingleOrDefault();
                //        automail.Recipients.Add(employeeID);
                //    }
                //}

                if (automail != null)
                {
                    try
                    {
                        bool isGenerated = automail.GenerateEmail();

                        if (isGenerated == true)
                        {
                            result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                        }
                        else
                        {
                            result = "Operation has been committed sucessfully";
                        }
                    }
                    catch (Exception ex)
                    {
                        result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                        result += "\n\n" + ex.Message;
                    }
                }
                else
                {
                    result = "Operation has been committed sucessfully";

                }
            }

            return result;
          
        }
        [WebMethod]
        public string createReview(string json)
        {
            string result = string.Empty;
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Review obj = serializer.Deserialize<Review>(json);

            var review = _context.Reviews.Where(REV => REV.ReviewNo == obj.ReviewNo).Select(REV => REV).SingleOrDefault();
            if (review == null)
            {
                review = new LINQConnection.Review();
                review.ReviewNo = obj.ReviewNo;
                review.ReviewCategoryID = _context.ReviewCategories.Where(REVCAT => REVCAT.ReviewCategory1 == obj.ReviewCategory).Select(REVCAT => REVCAT.ReviewCategoryID).FirstOrDefault() == 0 ? (int?)null : _context.ReviewCategories.Where(REVCAT => REVCAT.ReviewCategory1 == obj.ReviewCategory).Select(REVCAT => REVCAT.ReviewCategoryID).FirstOrDefault();
                review.EventName = obj.ReviewName;
                review.PlannedReviewDate = obj.PlannedReviewDate;
                review.Objectives = obj.Objectives == string.Empty ? null : obj.Objectives;
                review.ManagementStatusID = (int)obj.ReviewStatus;
                review.RecordModeID = (int)obj.Mode;
                review.ModifiedDate = DateTime.Now;
                review.ModifiedBy = HttpContext.Current.User.Identity.Name;

                if (obj.Representatives != null)
                {
                    foreach (var employee in obj.Representatives)
                    {
                        if((int)employee.Status != 4)
                        {
                            ManagementRepresentative representative = new ManagementRepresentative();
                            representative.EmployeeID = (from EMP in _context.Employees
                                                         where EMP.FirstName == employee.NameFormat.Substring(employee.NameFormat.LastIndexOf(".") + 1, employee.NameFormat.IndexOf(" ") - 3) &&
                                                         EMP.LastName == employee.NameFormat.Substring(employee.NameFormat.IndexOf(" ") + 1)
                                                         select EMP.EmployeeID).SingleOrDefault();
                            representative.ModifiedDate = DateTime.Now;
                            representative.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            review.ManagementRepresentatives.Add(representative);
                        }
                        
                    }
                }

                if (obj.Units != null)
                {
                    foreach (var unit in obj.Units)
                    {
                        if((int)unit.Status == 3)
                        {
                            RelatedReviewUnit relatedunit = new RelatedReviewUnit();
                            relatedunit.UnitID = _context.OrganizationUnits.Single(UNT => UNT.UnitName == unit.name).UnitID;
                            relatedunit.ModifiedDate = DateTime.Now;
                            relatedunit.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            review.RelatedReviewUnits.Add(relatedunit);
                        }
                       
                    }
                }

                EmailConfiguration automail = null;

                if (obj.Recipients != null)
                {
                    // generate automatic email notification for adding audit record
                    automail = new EmailConfiguration();
                    automail.Module = Modules.ManagementReviews;
                    automail.KeyValue = review.ReviewID;
                    automail.Action = "Add";

                    ReviewRecipient reviewRecipient = null;
                    var query = review.ReviewRecipients.Where(R => R.ReviewID == review.ReviewID).Select(R => R.EmployeeID).ToList();
                    List<int> ids = new List<int>();

                    foreach (var recipient in obj.Recipients)
                    {
                        //add both the originator and the owner as a recipient
                        int employeeID = (from EMP in _context.Employees
                                          where EMP.FirstName == recipient.Employee.Substring(recipient.Employee.LastIndexOf(".") + 1, recipient.Employee.IndexOf(" ") - 3) &&
                                          EMP.LastName == recipient.Employee.Substring(recipient.Employee.IndexOf(" ") + 1)
                                          select EMP.EmployeeID).SingleOrDefault();
                        automail.Recipients.Add(employeeID);

                        ids.Add(employeeID);
                        reviewRecipient = review.ReviewRecipients.Where(R => R.EmployeeID == employeeID).Select(R => R).SingleOrDefault();

                        if (reviewRecipient == null)
                        {
                            ReviewRecipient rec = new ReviewRecipient();
                            rec.EmployeeID = employeeID;
                            rec.ReviewID = review.ReviewID;
                            rec.ModifiedDate = DateTime.Now;
                            rec.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            _context.ReviewRecipients.InsertOnSubmit(rec);
                            review.ReviewRecipients.Add(rec);
                        }
                        
                    }

                    var deleteRecipient = query.Except(ids);
                    foreach (var del in deleteRecipient)
                    {
                        reviewRecipient = review.ReviewRecipients.Where(R => R.EmployeeID == del).SingleOrDefault();
                        _context.ReviewRecipients.DeleteOnSubmit(reviewRecipient);
                    }

                }

                _context.Reviews.InsertOnSubmit(review);
                _context.SubmitChanges();

                //EmailConfiguration automail = null;

                //if (obj.Recipients != null)
                //{
                //    // generate automatic email notification for adding review record
                //    automail = new EmailConfiguration();
                //    automail.Module = Modules.ManagementReviews;
                //    automail.KeyValue = review.ReviewID;
                //    automail.Action = "Add";
                //    foreach (var recipient in obj.Recipients)
                //    {
                //        //add both the originator and the owner as a recipient
                //        int employeeID = (from EMP in _context.Employees
                //                          where EMP.FirstName == recipient.Employee.Substring(recipient.Employee.LastIndexOf(".") + 1, recipient.Employee.IndexOf(" ") - 3) &&
                //                          EMP.LastName == recipient.Employee.Substring(recipient.Employee.IndexOf(" ") + 1)
                //                          select EMP.EmployeeID).SingleOrDefault();
                //        automail.Recipients.Add(employeeID);
                //    }
                //}

                if (automail != null)
                {
                    try
                    {
                        bool isGenerated = automail.GenerateEmail();

                        if (isGenerated == true)
                        {
                            result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                        }
                        else
                        {
                            result = "Operation has been committed sucessfully";
                        }
                    }
                    catch (Exception ex)
                    {
                        result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                        result += "\n\n" + ex.Message;
                    }
                }
                else
                {
                    result = "Operation has been committed sucessfully";

                }
            }
            else
            {
                throw new Exception("Please enter a unique management review number");
            }
            return result;
        }
        [WebMethod]
        public void removeReview(int ID)
        {
            var review = _context.Reviews.Where(REV => REV.ReviewID == ID).Select(REV => REV).SingleOrDefault();
            if (review != null)
            {
                _context.Reviews.DeleteOnSubmit(review);

                //delete recipients associated with this review
                var recipient = _context.ReviewRecipients.Where(r => r.ReviewID == review.ReviewID);
                _context.ReviewRecipients.DeleteAllOnSubmit(recipient);

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related management review record");
            }
        }

        [WebMethod]
        public string loadManagementReviewSchedule()
        {
            string result = string.Empty;

            var reviews = _context.Reviews
            .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new CalendarData
            {
                id = REV.ReviewID,
                title = REV.EventName + " ( " + REV.ManagementStatus.ManagementStatus1 + " )",
                start = REV.ActualReviewDate.HasValue == true ? Convert.ToDateTime(REV.ActualReviewDate) : REV.PlannedReviewDate,
                modulename=Modules.ManagementReviews.ToString()

            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(reviews);

            return result;
        }

        [WebMethod]
        public string filterManagementReviewScheduleByStatus(string status)
        {
            string result = string.Empty;

            var reviews = _context.Reviews
            .Where(REV => REV.ManagementStatus.ManagementStatus1 == status)
            .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new CalendarData
            {
                id = REV.ReviewID,
                title = REV.EventName + " ( " + REV.ManagementStatus.ManagementStatus1 + " )" ,
                start = REV.ActualReviewDate.HasValue == true ? Convert.ToDateTime(REV.ActualReviewDate) : REV.PlannedReviewDate,
                modulename = Modules.ManagementReviews.ToString()
            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(reviews);

            return result;
        }

        [WebMethod]
        public string filterManagementReviewScheduleByMode(string mode)
        {
            string result = string.Empty;

            var reviews = _context.Reviews
            .Where(REV => REV.RecordMode.RecordMode1==mode)
            .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new CalendarData
            {
                id = REV.ReviewID,
                title = REV.EventName + " ( " + REV.ManagementStatus.ManagementStatus1 + " )",
                start = REV.ActualReviewDate.HasValue == true ? Convert.ToDateTime(REV.ActualReviewDate) : REV.PlannedReviewDate,
                modulename = Modules.ManagementReviews.ToString()
            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(reviews);

            return result;
        }


        [WebMethod]
        public string filterManagementReviewScheduleByCategory(string category)
        {
            string result = string.Empty;

            var reviews = _context.Reviews
            .Where(REV => REV.ReviewCategory.ReviewCategory1 == category)
            .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new CalendarData
            {
                id = REV.ReviewID,
                title = REV.EventName + " ( " + REV.ManagementStatus.ManagementStatus1 + " )",
                start = REV.ActualReviewDate.HasValue == true ? Convert.ToDateTime(REV.ActualReviewDate) : REV.PlannedReviewDate,
                modulename = Modules.ManagementReviews.ToString()
            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(reviews);

            return result;
        }

        [WebMethod]
        public string filterManagementReviewScheduleByTitle(string title)
        {
            string result = string.Empty;

            var reviews = _context.Reviews
            .Where(REV => REV.EventName.StartsWith(title))
            .OrderBy(REV => REV.PlannedReviewDate)
            .Select(REV => new CalendarData
            {
                id = REV.ReviewID,
                title = REV.EventName + " ( " + REV.ManagementStatus.ManagementStatus1 + " )",
                start = REV.ActualReviewDate.HasValue == true ? Convert.ToDateTime(REV.ActualReviewDate) : REV.PlannedReviewDate,
                modulename = Modules.ManagementReviews.ToString()
            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(reviews);

            return result;
        }

        [WebMethod]
        public string filterManagementReviewScheduleByDate(string json)
        {
            StringWriter strwriter = new StringWriter();

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            string result = string.Empty;

            var reviews = _context.Reviews
                   .Where(REV => REV.PlannedReviewDate >= obj.StartDate && REV.PlannedReviewDate <= obj.EndDate)
                   .OrderBy(REV => REV.PlannedReviewDate)
                   .Select(REV => new CalendarData
                   {
                       id = REV.ReviewID,
                       title = REV.EventName + " ( " + REV.ManagementStatus.ManagementStatus1 + " )",
                       start = REV.ActualReviewDate.HasValue == true ? Convert.ToDateTime(REV.ActualReviewDate) : REV.PlannedReviewDate,
                       modulename = Modules.ManagementReviews.ToString()
                   }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(reviews);

            return result;
        }
       
        #endregion
        #region EmployeeTraining
        
        [WebMethod]
        public string getCourseID()
        {
            string courseID = null;

            if (_context.TrainingCourses.ToList().Count > 0)
            {
                long maxId = _context.TrainingCourses.Max(i => i.TrainingCourseId);
                courseID = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == maxId).Select(CRS => CRS.CourseNo).SingleOrDefault();
            }
            return courseID == null ? string.Empty : courseID;
        }
        
        [WebMethod]
        public string[] loadCourseTitle()
        {
            var titles = (from CRS in _context.TrainingCourses
                          where CRS.RecordModeID==(int)RecordMode.Current
                          select CRS.Title).Distinct().ToArray();

            return titles;
        }
        [WebMethod]
        public string loadSessionLocation()
        {
            var location = _context.TrainingCourseLocations
                .Select(VNU => new CourseVenue
                {
                    VenueID = VNU.VenueID,
                    VenueName = VNU.VenueName,
                    AddressLine1 = VNU.AddressLine1,
                    AddressLine2 = VNU.AddressLine2 == null ? string.Empty : VNU.AddressLine2,
                    Country = VNU.Country.CountryName,
                    City = VNU.City,
                    Website = VNU.Website == null ? string.Empty : VNU.Website,
                    NameFormat = VNU.VenueName + ", " + VNU.AddressLine1
                }).ToList();

            var serializer = new XmlSerializer(typeof(List<CourseVenue>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, location);

            return strwriter.ToString();
        }
        [WebMethod]
        public void createSessionLocation(string json)
        {

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            CourseVenue obj = serializer.Deserialize<CourseVenue>(json);

            var venue = _context.TrainingCourseLocations.Where(VNU => VNU.VenueName == obj.VenueName).Select(VNU => VNU).SingleOrDefault();
            if (venue == null)
            {
                venue = new TrainingCourseLocation();
                venue.VenueName = obj.VenueName;
                venue.AddressLine1 = obj.AddressLine1;
                venue.AddressLine2 = obj.AddressLine2 == string.Empty ? null : obj.AddressLine2;
                venue.CountryID = _context.Countries.Single(CNTRY => CNTRY.CountryName == obj.Country).CountryID;
                venue.City = obj.City;
                venue.Website = obj.Website == string.Empty ? null : obj.Website;
                venue.ModifiedDate = DateTime.Now;
                venue.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.TrainingCourseLocations.InsertOnSubmit(venue);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the venue already exists");
            }
        }
        [WebMethod]
        public string filterCourseScheduleByTitle(string title)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS=>CRS.Title==title)
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new CalendarData
                {
                    id = Convert.ToInt32(CRS.TrainingCourseId),
                    title = CRS.Title + " ( " + CRS.TrainingCourseStatus.TrainingStatus + " )",
                    start = ConvertToLocalTime(CRS.StartDate),
                    end = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate
                }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(courses);

            return result;
        }

        [WebMethod]
        public string filterCourseScheduleByStartDate(string json)
        {
            string result = string.Empty;
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var courses = _context.TrainingCourses
            .Where(CRS => CRS.StartDate >= obj.StartDate && CRS.EndDate <= obj.EndDate)
            .OrderBy(CRS => CRS.StartDate)
            .Select(CRS => new CalendarData
            {
                id = Convert.ToInt32(CRS.TrainingCourseId),
                title = CRS.Title + " ( " + CRS.TrainingCourseStatus.TrainingStatus + " )",
                start = ConvertToLocalTime(CRS.StartDate),
                end = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate
            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(courses);

            return result;
        }

        [WebMethod]
        public string filterCourseScheduleByNumber(string courseno)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS => CRS.CourseNo.StartsWith(courseno))
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new CalendarData
                {
                    id = Convert.ToInt32(CRS.TrainingCourseId),
                    title = CRS.Title + " ( " + CRS.TrainingCourseStatus.TrainingStatus + " )",
                    start = ConvertToLocalTime(CRS.StartDate),
                    end = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate
                }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(courses);

            return result;
        }

        [WebMethod]
        public string filterCourseScheduleByMode(string mode)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS => CRS.RecordMode.RecordMode1 == mode)
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new CalendarData
                {
                    id = Convert.ToInt32(CRS.TrainingCourseId),
                    title = CRS.Title + " ( " + CRS.TrainingCourseStatus.TrainingStatus + " )",
                    start = ConvertToLocalTime(CRS.StartDate),
                    end = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate
                }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(courses);

            return result;
        }

        [WebMethod]
        public string filterCourseScheduleByStatus(string status)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS => CRS.TrainingCourseStatus.TrainingStatus == status)
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new CalendarData
                {
                    id = Convert.ToInt32(CRS.TrainingCourseId),
                    title = CRS.Title + " ( " + CRS.TrainingCourseStatus.TrainingStatus + " )",
                    start = ConvertToLocalTime(CRS.StartDate),
                    end = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate
                }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(courses);

            return result;
        }
        [WebMethod]
        public string loadCourseSchedule()
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new CalendarData
                {
                    id = Convert.ToInt32(CRS.TrainingCourseId),
                    title = CRS.Title + " ( " + CRS.TrainingCourseStatus.TrainingStatus + " )",
                    start = ConvertToLocalTime(CRS.StartDate),
                    end = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate
                }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(courses);

            return result;
        }

        [WebMethod]
        public void removeCourse(long ID)
        {
            var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == ID).Select(CRS => CRS).SingleOrDefault();
            if (course != null)
            {
                _context.TrainingCourses.DeleteOnSubmit(course);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related course record");
            }
        }
        [WebMethod]
        public string filterCourseByEnrollerANDStartDate(string firstname, string lastname, string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == firstname &&
                              EMP.LastName == lastname
                              select EMP.EmployeeID).SingleOrDefault();

            var courses = _context.TrainingCourseEnrollments.Where(CRS => CRS.EmployeeId == employeeID && CRS.TrainingCourse.StartDate >= obj.StartDate && CRS.TrainingCourse.StartDate <= obj.EndDate)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourse.TrainingCourseId,
                    CourseNo = CRS.TrainingCourse.CourseNo,
                    CourseTitle = CRS.TrainingCourse.Title,
                    Material = CRS.TrainingCourse.MaterialID.HasValue == false ? string.Empty : CRS.TrainingCourse.Document.Title,
              
                    Description = CRS.TrainingCourse.Description == null ? string.Empty : CRS.TrainingCourse.Description,
                    Notes = CRS.TrainingCourse.Notes == null ? string.Empty : CRS.TrainingCourse.Notes,
                    Capacity = CRS.TrainingCourse.Capacity,
                    Duration = CRS.TrainingCourse.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.TrainingCourse.Duration),
                    Period = CRS.TrainingCourse.PeriodID.HasValue == false ? string.Empty : CRS.TrainingCourse.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.TrainingCourse.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.TrainingCourse.StartDate),
                    EndDate = CRS.TrainingCourse.EndDate != null ? ConvertToLocalTime(CRS.TrainingCourse.EndDate.Value) : CRS.TrainingCourse.EndDate,
                    CourseStatus = (CourseStatus)CRS.TrainingCourse.CourseStatusID,
                    IncludeLunch = CRS.TrainingCourse.Lunch,
                    IncludeRefreshment = CRS.TrainingCourse.Refreshment,
                    IncludeTransporation = CRS.TrainingCourse.Transportation
                }).ToList();
            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }
        [WebMethod]
        public string filterCourseByEnrollerANDTitle(string firstname, string lastname, string title)
        {
            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == firstname &&
                              EMP.LastName == lastname
                              select EMP.EmployeeID).SingleOrDefault();

            var courses = _context.TrainingCourseEnrollments.Where(CRS => CRS.EmployeeId == employeeID && CRS.TrainingCourse.Title.StartsWith(title))
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourse.TrainingCourseId,
                    CourseNo = CRS.TrainingCourse.CourseNo,
                    CourseTitle = CRS.TrainingCourse.Title,
                    Material = CRS.TrainingCourse.MaterialID.HasValue == false ? string.Empty : CRS.TrainingCourse.Document.Title,
              
                    Description = CRS.TrainingCourse.Description == null ? string.Empty : CRS.TrainingCourse.Description,
                    Notes = CRS.TrainingCourse.Notes == null ? string.Empty : CRS.TrainingCourse.Notes,
                    Capacity = CRS.TrainingCourse.Capacity,
                    Duration = CRS.TrainingCourse.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.TrainingCourse.Duration),
                    Period = CRS.TrainingCourse.PeriodID.HasValue == false ? string.Empty : CRS.TrainingCourse.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.TrainingCourse.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.TrainingCourse.StartDate),
                    EndDate = CRS.TrainingCourse.EndDate != null ? ConvertToLocalTime(CRS.TrainingCourse.EndDate.Value) : CRS.TrainingCourse.EndDate,
                    CourseStatus = (CourseStatus)CRS.TrainingCourse.CourseStatusID,
                    IncludeLunch = CRS.TrainingCourse.Lunch,
                    IncludeRefreshment = CRS.TrainingCourse.Refreshment,
                    IncludeTransporation = CRS.TrainingCourse.Transportation
                }).ToList();
            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }
        [WebMethod]
        public string filterCourseByEnrollerANDStatus(string firstname, string lastname,string status)
        {
            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == firstname &&
                              EMP.LastName == lastname
                              select EMP.EmployeeID).SingleOrDefault();

            var courses = _context.TrainingCourseEnrollments.Where(CRS => CRS.EmployeeId == employeeID && CRS.TrainingCourse.TrainingCourseStatus.TrainingStatus==status)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourse.TrainingCourseId,
                    CourseNo = CRS.TrainingCourse.CourseNo,
                    CourseTitle = CRS.TrainingCourse.Title,
                    Material = CRS.TrainingCourse.MaterialID.HasValue == false ? string.Empty : CRS.TrainingCourse.Document.Title,
              
                    Description = CRS.TrainingCourse.Description == null ? string.Empty : CRS.TrainingCourse.Description,
                    Notes = CRS.TrainingCourse.Notes == null ? string.Empty : CRS.TrainingCourse.Notes,
                    Capacity = CRS.TrainingCourse.Capacity,
                    Duration = CRS.TrainingCourse.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.TrainingCourse.Duration),
                    Period = CRS.TrainingCourse.PeriodID.HasValue == false ? string.Empty : CRS.TrainingCourse.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.TrainingCourse.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.TrainingCourse.StartDate),
                    EndDate = CRS.TrainingCourse.EndDate != null ? ConvertToLocalTime(CRS.TrainingCourse.EndDate.Value) : CRS.TrainingCourse.EndDate,
                    CourseStatus = (CourseStatus)CRS.TrainingCourse.CourseStatusID,
                    IncludeLunch = CRS.TrainingCourse.Lunch,
                    IncludeRefreshment = CRS.TrainingCourse.Refreshment,
                    IncludeTransporation = CRS.TrainingCourse.Transportation
                }).ToList();
            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }
        [WebMethod]
        public string filterCourseByEnrollerANDAttendanceStatus(string firstname, string lastname,string attendance)
        {
            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == firstname &&
                              EMP.LastName == lastname
                              select EMP.EmployeeID).SingleOrDefault();

            var courses = _context.TrainingCourseEnrollments.Where(CRS => CRS.EmployeeId == employeeID && CRS.CourseAttendanceStatus.AttendanceStatus==attendance)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourse.TrainingCourseId,
                    CourseNo = CRS.TrainingCourse.CourseNo,
                    CourseTitle = CRS.TrainingCourse.Title,
                    Material = CRS.TrainingCourse.MaterialID.HasValue == false ? string.Empty : CRS.TrainingCourse.Document.Title,
              
                    Description = CRS.TrainingCourse.Description == null ? string.Empty : CRS.TrainingCourse.Description,
                    Notes = CRS.TrainingCourse.Notes == null ? string.Empty : CRS.TrainingCourse.Notes,
                    Capacity = CRS.TrainingCourse.Capacity,
                    Duration = CRS.TrainingCourse.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.TrainingCourse.Duration),
                    Period = CRS.TrainingCourse.PeriodID.HasValue == false ? string.Empty : CRS.TrainingCourse.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.TrainingCourse.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.TrainingCourse.StartDate),
                    EndDate = CRS.TrainingCourse.EndDate != null ? ConvertToLocalTime(CRS.TrainingCourse.EndDate.Value) : CRS.TrainingCourse.EndDate,
                    CourseStatus = (CourseStatus)CRS.TrainingCourse.CourseStatusID,
                    IncludeLunch = CRS.TrainingCourse.Lunch,
                    IncludeRefreshment = CRS.TrainingCourse.Refreshment,
                    IncludeTransporation = CRS.TrainingCourse.Transportation,
                    Enroller = CRS.TrainingCourse.TrainingCourseEnrollments.Where(ENR => ENR.EmployeeId == employeeID)
                    .Select(ENR => new Enroller
                    {
                        AttendanceStatus = ENR.CourseAttendanceStatus.AttendanceStatus,
                        HasProvidedFeedback = ENR.HasProvidedFeedback
                    }).ToList()

                }).ToList();
            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterCourseByEnroller(string firstname,string lastname)
        {
            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == firstname &&
                              EMP.LastName == lastname
                              select EMP.EmployeeID).SingleOrDefault();

            var courses = _context.TrainingCourseEnrollments.Where(CRS => CRS.EmployeeId == employeeID)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourse.TrainingCourseId,
                    CourseNo = CRS.TrainingCourse.CourseNo,
                    CourseTitle = CRS.TrainingCourse.Title,
                    Material = CRS.TrainingCourse.MaterialID.HasValue == false ? string.Empty : CRS.TrainingCourse.Document.Title,
              
                    Description = CRS.TrainingCourse.Description == null ? string.Empty : CRS.TrainingCourse.Description,
                    Notes = CRS.TrainingCourse.Notes == null ? string.Empty : CRS.TrainingCourse.Notes,
                    Capacity = CRS.TrainingCourse.Capacity,
                    Duration = CRS.TrainingCourse.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.TrainingCourse.Duration),
                    Period = CRS.TrainingCourse.PeriodID.HasValue == false ? string.Empty : CRS.TrainingCourse.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.TrainingCourse.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.TrainingCourse.StartDate),
                    EndDate = CRS.TrainingCourse.EndDate != null ? ConvertToLocalTime(CRS.TrainingCourse.EndDate.Value) : CRS.TrainingCourse.EndDate,
                    CourseStatus = (CourseStatus)CRS.TrainingCourse.CourseStatusID,
                    IncludeLunch = CRS.TrainingCourse.Lunch,
                    IncludeRefreshment = CRS.TrainingCourse.Refreshment,
                    IncludeTransporation = CRS.TrainingCourse.Transportation,
                    Enroller= CRS.TrainingCourse.TrainingCourseEnrollments.Where(ENR=>ENR.EmployeeId==employeeID)
                    .Select(ENR=>new Enroller
                    {
                        AttendanceStatus=ENR.CourseAttendanceStatus.AttendanceStatus,
                        HasProvidedFeedback=ENR.HasProvidedFeedback
                    }).ToList()

                }).ToList();
            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterCourseByMode(string mode)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS => CRS.RecordMode.RecordMode1==mode)
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourseId,
                    CourseNo = CRS.CourseNo,
                    CourseTitle = CRS.Title,
                    Material = CRS.MaterialID.HasValue == false ? string.Empty : CRS.Document.Title,
              
                    Description = CRS.Description == null ? string.Empty : CRS.Description,
                    Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                    Capacity = CRS.Capacity,
                    Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                    Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.StartDate),
                    EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                    CourseStatus = (CourseStatus)CRS.CourseStatusID,
                    IncludeLunch = CRS.Lunch,
                    IncludeRefreshment = CRS.Refreshment,
                    IncludeTransporation = CRS.Transportation,
                    Mode = (RecordMode)CRS.RecordModeID
                }).ToList();

            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }
        [WebMethod]
        public string filterCourseByStatus(string status)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS => CRS.TrainingCourseStatus.TrainingStatus==status)
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourseId,
                    CourseNo = CRS.CourseNo,
                    CourseTitle = CRS.Title,
                    Description = CRS.Description == null ? string.Empty : CRS.Description,
                    Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                    Capacity = CRS.Capacity,
                    Material = CRS.MaterialID.HasValue == false ? string.Empty : CRS.Document.Title,
              
                    Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                    Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.StartDate),
                    EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                    CourseStatus = (CourseStatus)CRS.CourseStatusID,
                    IncludeLunch = CRS.Lunch,
                    IncludeRefreshment = CRS.Refreshment,
                    IncludeTransporation = CRS.Transportation,
                    Mode = (RecordMode)CRS.RecordModeID
                }).ToList();

            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterCourseByStartDate(string json)
        {
            string result = string.Empty;
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var courses = _context.TrainingCourses
            .Where(CRS => CRS.StartDate >= obj.StartDate && CRS.StartDate <= obj.EndDate)
            .OrderBy(CRS => CRS.StartDate)
            .Select(CRS => new Course
            {
                CourseID = CRS.TrainingCourseId,
                CourseNo = CRS.CourseNo,
                CourseTitle = CRS.Title,
                Description = CRS.Description == null ? string.Empty : CRS.Description,
                Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                Capacity = CRS.Capacity,
                Material = CRS.MaterialID.HasValue == false ? string.Empty : CRS.Document.Title,

                Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                Coordinator = (from T in _context.Titles
                               join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                               from g in empgroup
                               where g.EmployeeID == CRS.CoordenatorID
                               select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                StartDate = ConvertToLocalTime(CRS.StartDate),
                EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                CourseStatus = (CourseStatus)CRS.CourseStatusID,
                IncludeLunch = CRS.Lunch,
                IncludeRefreshment = CRS.Refreshment,
                IncludeTransporation = CRS.Transportation,
                Mode = (RecordMode)CRS.RecordModeID
            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterCourseByNumber(string courseno)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS => CRS.CourseNo.StartsWith(courseno))
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourseId,
                    CourseNo = CRS.CourseNo,
                    CourseTitle = CRS.Title,
                    Description = CRS.Description == null ? string.Empty : CRS.Description,
                    Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                    Capacity = CRS.Capacity,
                    Material = CRS.MaterialID.HasValue == false ? string.Empty : CRS.Document.Title,

                    Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                    Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.StartDate),
                    EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                    CourseStatus = (CourseStatus)CRS.CourseStatusID,
                    IncludeLunch = CRS.Lunch,
                    IncludeRefreshment = CRS.Refreshment,
                    IncludeTransporation = CRS.Transportation,
                    Mode = (RecordMode)CRS.RecordModeID
                }).ToList();

            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }

        [WebMethod]
        public string filterCourseByTitlePrefix(string title)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses
                .Where(CRS => CRS.Title.StartsWith(title))
                .OrderBy(CRS => CRS.StartDate)
                .Select(CRS => new Course
                {
                    CourseID = CRS.TrainingCourseId,
                    CourseNo = CRS.CourseNo,
                    CourseTitle = CRS.Title,
                    Description = CRS.Description == null ? string.Empty : CRS.Description,
                    Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                    Capacity = CRS.Capacity,
                    Material = CRS.MaterialID.HasValue == false ? string.Empty : CRS.Document.Title,
              
                    Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                    Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                    Coordinator = (from T in _context.Titles
                                   join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                   from g in empgroup
                                   where g.EmployeeID == CRS.CoordenatorID
                                   select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    StartDate = ConvertToLocalTime(CRS.StartDate),
                    EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                    CourseStatus = (CourseStatus)CRS.CourseStatusID,
                    IncludeLunch = CRS.Lunch,
                    IncludeRefreshment = CRS.Refreshment,
                    IncludeTransporation = CRS.Transportation,
                    Mode = (RecordMode)CRS.RecordModeID
                }).ToList();

            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadCourses()
        {
            //load all current courses
            var courses = _context.TrainingCourses
            .Select(CRS => new Course
            {
                CourseID = CRS.TrainingCourseId,
                CourseNo = CRS.CourseNo,
                CourseTitle = CRS.Title,
                Description = CRS.Description == null ? string.Empty : CRS.Description,
                Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                Capacity = CRS.Capacity,
                Material = CRS.MaterialID.HasValue == false ? string.Empty : CRS.Document.Title,

                Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                Coordinator = (from T in _context.Titles
                               join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                               from g in empgroup
                               where g.EmployeeID == CRS.CoordenatorID
                               select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                StartDate = ConvertToLocalTime(CRS.StartDate),
                EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                CourseStatus = (CourseStatus)CRS.CourseStatusID,
                IncludeLunch = CRS.Lunch,
                IncludeRefreshment = CRS.Refreshment,
                IncludeTransporation = CRS.Transportation,
                Mode = (RecordMode)CRS.RecordModeID
            }).ToList();

            var serializer = new XmlSerializer(typeof(List<Course>));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, courses);

            return strwriter.ToString();
        }

        [WebMethod]
        public string loadTimeTable(long courseID)
        {
            string result = string.Empty;

            var courses = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID).Select(CRS => CRS).SingleOrDefault();
            if (courses != null)
            {

                var schedule = courses.TrainingCourseSchedules.Select(SCH => new CalendarData
                {
                    id = SCH.ScheduleID,
                    title = "(" + SCH.TrainingCourse.Title + "), " + SCH.TrainingCourseLocation.VenueName,
                    start = ConvertToLocalTime(SCH.CourseDate),
                    starttime = SCH.StartTime,
                    endtime = SCH.EndTime
                }).ToList();

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                result = serializer.Serialize(schedule);
            }
            else
            {
                throw new Exception("Cannot find the related course record");
            }

            return result;
        }

        [WebMethod]
        public string getCourseByNumber(string courseno)
        {
            var course = _context.TrainingCourses.Where(CRS => CRS.CourseNo == courseno)
            .Select(CRS => new Course
            {
                CourseID = CRS.TrainingCourseId,
                CourseNo = CRS.CourseNo,
                CourseTitle = CRS.Title,
                Description = CRS.Description == null ? string.Empty : CRS.Description,
                Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                Capacity = CRS.Capacity,
                Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                Material = CRS.MaterialID.HasValue == false ? string.Empty : CRS.Document.Title,
                Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                Coordinator = (from T in _context.Titles
                               join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                               from g in empgroup
                               where g.EmployeeID == CRS.CoordenatorID
                               select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                StartDate = ConvertToLocalTime(CRS.StartDate),
                EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                CourseStatus = (CourseStatus)CRS.CourseStatusID,
                IncludeLunch = CRS.Lunch,
                IncludeRefreshment = CRS.Refreshment,
                IncludeTransporation = CRS.Transportation,
                Mode = (RecordMode)CRS.RecordModeID,
                Question = CRS.TrainingCourseQuestions.Select(QUS => new Question
                {
                    QuestionID = QUS.CourseQuestionId,
                    QuestionText = QUS.CourseQuestion.Question,
                    QuestionMode = QUS.CourseQuestion.QuestionMode.QuestionMode1
                }).ToList(),
                Enroller = CRS.TrainingCourseEnrollments.Select(ENRLL => new Enroller
                {
                    Employee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ENRLL.EmployeeId
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),

                    EnrollerLevel = ENRLL.EnrollerLevel.EnrollerLevel1,
                    AttendanceStatus = ENRLL.CourseAttendanceStatus.AttendanceStatus,
                    IsVegan = ENRLL.IsVegan,
                    IsVegetarian = ENRLL.IsVegetarian,
                    SpecialNeeds = ENRLL.SpecialNeeds,
                    OtherNeeds = ENRLL.OtherNeeds,
                    SpecialNeedNotes = ENRLL.SpecialNeedNotes == null ? string.Empty : ENRLL.SpecialNeedNotes,
                    OtherNeedNotes = ENRLL.OtherNeedNotes == null ? string.Empty : ENRLL.OtherNeedNotes,
                    HasProvidedFeedback = ENRLL.HasProvidedFeedback,
                    FeedbackList = CRS.CourseFeedBacks.Where(FD => FD.EmployeeId == ENRLL.Employee.EmployeeID).Select(FD => new Feedback
                    {
                        Question = FD.CourseQuestion.Question,
                        AnswerValue = FD.AnswerValue
                    }).ToList()

                }).ToList()
            }).SingleOrDefault();

            if (course == null)
                throw new Exception("Cannot find the related course record");

            var serializer = new XmlSerializer(typeof(Course));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, course);

            return strwriter.ToString();
        }

        
        [WebMethod]
        public string getSchedule(long scheduleID)
        {
            var schedule = _context.TrainingCourseSchedules.Where(SCH => SCH.ScheduleID == scheduleID)
            .Select(SCH => new CourseSchedule
            {
                ScheduleID = SCH.ScheduleID,
                SessionDate = ConvertToLocalTime(SCH.CourseDate),
                StartTime = SCH.StartTime,
                EndTime = SCH.EndTime,
                IntructorType = SCH.InstructorTypeID.HasValue == false ? string.Empty : SCH.InstructorType.InstructorType1,
                ExternalIntructor = SCH.ExternalInstructorID.HasValue == false ? string.Empty : SCH.Customer.CustomerName,
                Venue = SCH.TrainingCourseLocation.VenueName + ", " + SCH.TrainingCourseLocation.AddressLine1,
                InternalIntructor = SCH.InternalInstructorID.HasValue == false ? string.Empty : (from T in _context.Titles
                                                                                                 join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                                                                                 from g in empgroup
                                                                                                 where g.EmployeeID == SCH.InternalInstructorID
                                                                                                 select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault()

            }).SingleOrDefault();


            if (schedule == null)
                throw new Exception("Cannot find the related course schedule record");

            var serializer = new XmlSerializer(typeof(CourseSchedule));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, schedule);

            return strwriter.ToString();
      
        }
        [WebMethod]
        public string getCourse(long courseID)
        {
            var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID)
            .Select(CRS => new Course
            {
                CourseID = CRS.TrainingCourseId,
                CourseNo = CRS.CourseNo,
                CourseTitle = CRS.Title,
                Description = CRS.Description == null ? string.Empty : CRS.Description,
                Notes = CRS.Notes == null ? string.Empty : CRS.Notes,
                Capacity = CRS.Capacity,
                Duration = CRS.Duration.HasValue == false ? 0 : Convert.ToInt32(CRS.Duration),
                Period = CRS.PeriodID.HasValue == false ? string.Empty : CRS.Period.Period1,
                Material=CRS.MaterialID.HasValue==false?string.Empty:CRS.Document.Title,
                Coordinator = (from T in _context.Titles
                               join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                               from g in empgroup
                               where g.EmployeeID == CRS.CoordenatorID
                               select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                StartDate = ConvertToLocalTime(CRS.StartDate),
                EndDate = CRS.EndDate != null ? ConvertToLocalTime(CRS.EndDate.Value) : CRS.EndDate,
                CourseStatus = (CourseStatus)CRS.CourseStatusID,
                Mode = (RecordMode)CRS.RecordModeID,
                IncludeLunch = CRS.Lunch,
                IncludeRefreshment = CRS.Refreshment,
                IncludeTransporation = CRS.Transportation

            }).SingleOrDefault();

            if (course == null)
                throw new Exception("Cannot find the related course record");

            var serializer = new XmlSerializer(typeof(Course));

            StringWriter strwriter = new StringWriter();
            serializer.Serialize(strwriter, course);

            return strwriter.ToString();
        }
        [WebMethod]
        public string updateCourse(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Course obj = serializer.Deserialize<Course>(json);

            var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == obj.CourseID).Select(CRS => CRS).SingleOrDefault();
            if (course != null)
            {
                course.Title = obj.CourseTitle;
                course.Description = obj.Description == string.Empty ? null : obj.Description;
                course.Notes = obj.Notes == string.Empty ? null : obj.Notes;
                course.StartDate = obj.StartDate;
                course.Duration = obj.Duration == 0 ? (int?)null : obj.Duration;
                course.PeriodID = obj.Period == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.Period).PeriodID;
                course.MaterialID = obj.Material == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.Material).DocumentId;
                
                course.EndDate = obj.EndDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.EndDate);
                course.CoordenatorID = (from EMP in _context.Employees
                                        where EMP.FirstName == obj.Coordinator.Substring(obj.Coordinator.LastIndexOf(".") + 1, obj.Coordinator.IndexOf(" ") - 3) &&
                                        EMP.LastName == obj.Coordinator.Substring(obj.Coordinator.IndexOf(" ") + 1)
                                        select EMP.EmployeeID).SingleOrDefault();
                course.Capacity = obj.Capacity;
                course.Lunch = obj.IncludeLunch;
                course.Transportation = obj.IncludeTransporation;
                course.Refreshment = obj.IncludeRefreshment;
                course.CourseStatusID = _context.TrainingCourseStatus.Single(STS => STS.TrainingStatus == obj.CourseStatusStr).TrainingStatusID;
                
                switch ((CourseStatus)course.CourseStatusID)
                {
                    case CourseStatus.Cancelled:
                    case CourseStatus.Completed:
                        course.RecordModeID = (int)RecordMode.Archived;
                        break;
                    case CourseStatus.Created:
                    case CourseStatus.Scheduled:
                    case CourseStatus.Active:
                        course.RecordModeID = (int)RecordMode.Current;
                        break;
                }

                course.ModifiedDate = DateTime.Now;
                course.ModifiedBy = HttpContext.Current.User.Identity.Name;


                _context.SubmitChanges();

                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.EmployeeTraining;
                automail.KeyValue = course.TrainingCourseId;
                automail.Action = "Update";

                //add course coordinator as a recipient
                automail.Recipients.Add(course.CoordenatorID);

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Cannot find the related course record");
            }

            return result;
        }
        [WebMethod]
        public void removeCourseSession(long scheduleID)
        {
            var schedule = _context.TrainingCourseSchedules.Where(SCH => SCH.ScheduleID == scheduleID).Select(SCH => SCH).SingleOrDefault();
            if (schedule != null)
            {
                _context.TrainingCourseSchedules.DeleteOnSubmit(schedule);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related schedule record");
            }
        }
        [WebMethod]
        public void updateCourseSession(string json)
        {

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            CourseSchedule obj = serializer.Deserialize<CourseSchedule>(json);

            var schedule = _context.TrainingCourseSchedules.Where(SCH => SCH.ScheduleID == obj.ScheduleID).Select(SCH => SCH).SingleOrDefault();
            if (schedule != null)
            {
                schedule.CourseDate = obj.SessionDate;
                schedule.StartTime = obj.StartTime;
                schedule.EndTime = obj.EndTime;
                schedule.InstructorTypeID = obj.IntructorType == string.Empty ? (int?)null : _context.InstructorTypes.SingleOrDefault(TYP => TYP.InstructorType1 == obj.IntructorType).InstructorTypeID;
                schedule.ExternalInstructorID = obj.ExternalIntructor == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExternalIntructor).CustomerID;
                schedule.InternalInstructorID = obj.InternalIntructor == string.Empty ? (int?)null : (from EMP in _context.Employees
                                                                                                      where EMP.FirstName == obj.InternalIntructor.Substring(obj.InternalIntructor.LastIndexOf(".") + 1, obj.InternalIntructor.IndexOf(" ") - 3) &&
                                                                                                      EMP.LastName == obj.InternalIntructor.Substring(obj.InternalIntructor.IndexOf(" ") + 1)

                                                                                                      select EMP.EmployeeID).SingleOrDefault();
                schedule.VenueID = _context.TrainingCourseLocations.Single(LOC => LOC.VenueName == obj.Venue).VenueID;
                schedule.ModifiedDate = DateTime.Now;
                schedule.ModifiedBy = HttpContext.Current.User.Identity.Name;


                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related course schedule record");
            }
        }

        [WebMethod]
        public void removeEnroller(string employee, string courseNo)
        {
            var employeeID=(from EMP in _context.Employees
                                 where EMP.FirstName == employee.Substring(employee.LastIndexOf(".") + 1, employee.IndexOf(" ") - 3) &&
                                 EMP.LastName == employee.Substring(employee.IndexOf(" ") + 1)
                                 select EMP.EmployeeID).SingleOrDefault();

            var enroller = _context.TrainingCourseEnrollments.Where(ENRLL => ENRLL.TrainingCourse.CourseNo == courseNo && ENRLL.EmployeeId == employeeID).Select(ENRLL => ENRLL).SingleOrDefault();
            if (enroller != null)
            {
                _context.TrainingCourseEnrollments.DeleteOnSubmit(enroller);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related participant record");
            }
        }

        [WebMethod]
        public void withdrawCourse(string firstname, string lastname, long courseID)
        {
            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == firstname &&
                              EMP.LastName == lastname
                              select EMP.EmployeeID).SingleOrDefault();


            var enroller = _context.TrainingCourseEnrollments.Where(ENRLL => ENRLL.EmployeeId == employeeID && ENRLL.TrainingCourseId == courseID).Select(ENRLL => ENRLL).SingleOrDefault();
            if (enroller != null)
            {
                _context.TrainingCourseEnrollments.DeleteOnSubmit(enroller);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related employee record");
            }
        }

        [WebMethod]
        public void addCourseFeedback(string firstname, string lastname, long courseID, string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Feedback> obj = serializer.Deserialize<List<Feedback>>(json);

            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == firstname &&
                              EMP.LastName == lastname
                              select EMP.EmployeeID).SingleOrDefault();

            var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID).Select(CRS => CRS).SingleOrDefault();
            if (course != null)
            {
                if (obj != null)
                {
                    foreach (var fd in obj)
                    {
                        var feedback = new CourseFeedBack();
                        feedback.CourseQuestionId = _context.CourseQuestions.Single(QUS => QUS.Question == fd.Question).CourseQuestionId;
                        feedback.EmployeeId = employeeID;
                        feedback.AnswerValue = fd.AnswerValue;
                        feedback.ModifiedDate = DateTime.Now;
                        feedback.ModifiedBy = HttpContext.Current.User.Identity.Name;

                        course.CourseFeedBacks.Add(feedback);
                    }

                    //set Has Provided Feedback flag to true


                    var enroller = course.TrainingCourseEnrollments.Where(ENRLL => ENRLL.EmployeeId == employeeID).Select(ENRLL => ENRLL).SingleOrDefault();
                    if (enroller != null)
                    {
                        enroller.HasProvidedFeedback = true;
                        
                    }

                    _context.SubmitChanges();
                }
                else
                {
                    throw new Exception("There is no questions in the list to submit");
                }
            }
            else
            {
                throw new Exception("Cannot find the related training course record");
            }

        }
        [WebMethod]
        public void addTrainingCourseQuestion(string json, long courseID)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Question obj = serializer.Deserialize<Question>(json);

            var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID).Select(CRS => CRS).SingleOrDefault();
            if (course != null)
            {
                var question = _context.TrainingCourseQuestions.Where(QUS => QUS.CourseQuestion.Question == obj.QuestionText && QUS.TrainingCourseId==courseID).Select(QUS => QUS).SingleOrDefault();
                if (question == null)
                {

                    question = new TrainingCourseQuestion();
                    question.CourseQuestionId = _context.CourseQuestions.Single(QUS => QUS.Question == obj.QuestionText).CourseQuestionId;
                    question.ModifiedDate = DateTime.Now;
                    question.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    course.TrainingCourseQuestions.Add(question);
                    _context.SubmitChanges();
                }
                else
                {
                    throw new Exception("The question is already associated to the course");
                }
            }
            else
            {
                throw new Exception("Cannot find the related course record");
            }
            
        }


        [WebMethod]
        public void updateTrainingCourseQuestion(string json, long courseID)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Question obj = serializer.Deserialize<Question>(json);

            var questionID = _context.CourseQuestions.Single(QUS => QUS.Question == obj.QuestionText).CourseQuestionId;

            var coursequestion = _context.TrainingCourseQuestions.Where(CRSQUS => CRSQUS.CourseQuestionId == obj.QuestionID && CRSQUS.TrainingCourseId == courseID).Select(CRSQUS => CRSQUS).SingleOrDefault();
            if (coursequestion != null)
            {
               
                //delete this current row first
                _context.TrainingCourseQuestions.DeleteOnSubmit(coursequestion);
                _context.SubmitChanges();

                //add a new row with a new value

                var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID).Select(CRS => CRS).SingleOrDefault();
                
                TrainingCourseQuestion question = new TrainingCourseQuestion();
                question.CourseQuestionId = _context.CourseQuestions.Single(QUS => QUS.Question == obj.QuestionText).CourseQuestionId;
                question.ModifiedDate = DateTime.Now;
                question.ModifiedBy = HttpContext.Current.User.Identity.Name;

                course.TrainingCourseQuestions.Add(question);
                _context.SubmitChanges();

            }
            else
            {
                throw new Exception("Cannot find the related question record");
            }
        }
        [WebMethod]
        public void removeTrainingCourseQuestion(string courseNo, long questionID)
        {
            
            var coursequestion = _context.TrainingCourseQuestions.Where(TRN => TRN.CourseQuestionId==questionID && TRN.TrainingCourse.CourseNo==courseNo).Select(TRN => TRN).SingleOrDefault();
            if (coursequestion != null)
            {
                _context.TrainingCourseQuestions.DeleteOnSubmit(coursequestion);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related training course question record");
            }
        }

        [WebMethod]
        public void updateEnroller(string json, string oldemployee,long courseID)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Enroller obj = serializer.Deserialize<Enroller>(json);


           
            var employeeID = (from EMP in _context.Employees
                              where EMP.FirstName == oldemployee.Substring(oldemployee.LastIndexOf(".") + 1, oldemployee.IndexOf(" ") - 3) &&
                              EMP.LastName == oldemployee.Substring(oldemployee.IndexOf(" ") + 1)
                              select EMP.EmployeeID).SingleOrDefault();

            var enroller = _context.TrainingCourseEnrollments.Where(ENRLL => ENRLL.EmployeeId == employeeID && ENRLL.TrainingCourse.TrainingCourseId == courseID).Select(ENRLL => ENRLL).SingleOrDefault();
            if (enroller != null)
            {


                if (oldemployee != obj.Employee)
                {
                    //delete this current row first
                    _context.TrainingCourseEnrollments.DeleteOnSubmit(enroller);
                    _context.SubmitChanges();

                    //add a new row with a new value
                    var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID).Select(CRS => CRS).SingleOrDefault();

                    enroller = new TrainingCourseEnrollment();
                    enroller.EmployeeId = (from EMP in _context.Employees
                                           where EMP.FirstName == obj.Employee.Substring(obj.Employee.LastIndexOf(".") + 1, obj.Employee.IndexOf(" ") - 3) &&
                                           EMP.LastName == obj.Employee.Substring(obj.Employee.IndexOf(" ") + 1)
                                           select EMP.EmployeeID).SingleOrDefault();

                    enroller.EnrollerLevelId = _context.EnrollerLevels.Single(LVL => LVL.EnrollerLevel1 == obj.EnrollerLevel).EnrollerLevelId;
                    enroller.AttendanceStatusID = DateTime.Now < enroller.TrainingCourse.StartDate ? (int)AttendanceStatus.Undetermined : _context.CourseAttendanceStatus.Single(STS => STS.AttendanceStatus == obj.AttendanceStatus).CourseAttendanceStatusID;
                    enroller.IsVegan = obj.IsVegan;
                    enroller.IsVegetarian = obj.IsVegetarian;
                    enroller.OtherNeeds = obj.OtherNeeds;
                    enroller.SpecialNeeds = obj.SpecialNeeds;
                    enroller.OtherNeedNotes = obj.OtherNeedNotes == string.Empty ? null : obj.OtherNeedNotes;
                    enroller.SpecialNeedNotes = obj.SpecialNeedNotes == string.Empty ? null : obj.SpecialNeedNotes;
                    enroller.ModifiedDate = DateTime.Now;
                    enroller.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    course.TrainingCourseEnrollments.Add(enroller);
                    _context.SubmitChanges();

                }
                else
                {
                    enroller.EnrollerLevelId = _context.EnrollerLevels.Single(LVL => LVL.EnrollerLevel1 == obj.EnrollerLevel).EnrollerLevelId;
                    enroller.AttendanceStatusID = DateTime.Now < enroller.TrainingCourse.StartDate ? (int)AttendanceStatus.Undetermined : _context.CourseAttendanceStatus.Single(STS => STS.AttendanceStatus == obj.AttendanceStatus).CourseAttendanceStatusID;
                    enroller.IsVegan = obj.IsVegan;
                    enroller.IsVegetarian = obj.IsVegetarian;
                    enroller.OtherNeeds = obj.OtherNeeds;
                    enroller.SpecialNeeds = obj.SpecialNeeds;
                    enroller.OtherNeedNotes = obj.OtherNeedNotes == string.Empty ? null : obj.OtherNeedNotes;
                    enroller.SpecialNeedNotes = obj.SpecialNeedNotes == string.Empty ? null : obj.SpecialNeedNotes;
                    enroller.ModifiedDate = DateTime.Now;
                    enroller.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    _context.SubmitChanges();
                }


            }
            else
            {
                throw new Exception("Cannot find the related employee participation record");
            }

           
        }

        [WebMethod]
        public void createNewEnroller(string json, long courseID)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Enroller obj = serializer.Deserialize<Enroller>(json);

            var employeeID=(from EMP in _context.Employees
                                 where EMP.FirstName == obj.Employee.Substring(obj.Employee.LastIndexOf(".") + 1, obj.Employee.IndexOf(" ") - 3) &&
                                 EMP.LastName == obj.Employee.Substring(obj.Employee.IndexOf(" ") + 1)
                                 select EMP.EmployeeID).SingleOrDefault();
            
            var enroller = _context.TrainingCourseEnrollments.Where(ENRLL => ENRLL.EmployeeId == employeeID && ENRLL.TrainingCourseId == courseID).Select(ENRLL => ENRLL).SingleOrDefault();
            if (enroller == null)
            {
                var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID).Select(CRS => CRS).SingleOrDefault();
                if (course != null)
                {
                    enroller = new TrainingCourseEnrollment();
                    enroller.EmployeeId = employeeID;
                    enroller.EnrollerLevelId = _context.EnrollerLevels.Single(LVL => LVL.EnrollerLevel1 == obj.EnrollerLevel).EnrollerLevelId;
                    enroller.IsVegan = obj.IsVegan;
                    enroller.IsVegetarian = obj.IsVegetarian;
                    enroller.OtherNeeds = obj.OtherNeeds;
                    enroller.SpecialNeeds = obj.SpecialNeeds;
                    enroller.OtherNeedNotes = obj.OtherNeedNotes == string.Empty ? null : obj.OtherNeedNotes;
                    enroller.SpecialNeedNotes = obj.SpecialNeedNotes == string.Empty ? null : obj.SpecialNeedNotes;
                    enroller.ModifiedDate = DateTime.Now;
                    enroller.ModifiedBy = HttpContext.Current.User.Identity.Name;

                    if (DateTime.Now < course.StartDate)
                    {

                        enroller.AttendanceStatusID = (int)AttendanceStatus.Undetermined;

                    }
                    else
                    {
                        enroller.AttendanceStatusID = _context.CourseAttendanceStatus.Single(STS => STS.AttendanceStatus == obj.AttendanceStatus).CourseAttendanceStatusID;
                    
                    }
                  

                    course.TrainingCourseEnrollments.Add(enroller);
                    _context.SubmitChanges();

                }
            }
            else
            {
                throw new Exception("The employee has already enrolled in the course");
            }

         
        }
        [WebMethod]
        public string createCourseSession(string json, long courseID)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            CourseSchedule obj = serializer.Deserialize<CourseSchedule>(json);


            var course = _context.TrainingCourses.Where(CRS => CRS.TrainingCourseId == courseID).Select(CRS => CRS).SingleOrDefault();
            if (course != null)
            {
                TrainingCourseSchedule schedule = new TrainingCourseSchedule();
                schedule.CourseDate = obj.SessionDate;
                schedule.StartTime = obj.StartTime;
                schedule.EndTime = obj.EndTime;
                schedule.InstructorTypeID = obj.IntructorType == string.Empty ? (int?)null : _context.InstructorTypes.SingleOrDefault(TYP => TYP.InstructorType1 == obj.IntructorType).InstructorTypeID;
                schedule.ExternalInstructorID = obj.ExternalIntructor == string.Empty ? (int?)null : _context.Customers.Single(CUST => CUST.CustomerName == obj.ExternalIntructor).CustomerID;
                schedule.InternalInstructorID = obj.InternalIntructor == string.Empty ? (int?)null : (from EMP in _context.Employees
                                                                                                      where EMP.FirstName == obj.InternalIntructor.Substring(obj.InternalIntructor.LastIndexOf(".") + 1, obj.InternalIntructor.IndexOf(" ") - 3) &&
                                                                                                      EMP.LastName == obj.InternalIntructor.Substring(obj.InternalIntructor.IndexOf(" ") + 1)

                                                                                                      select EMP.EmployeeID).SingleOrDefault();
                schedule.VenueID = _context.TrainingCourseLocations.Single(LOC => LOC.VenueName == obj.Venue).VenueID;
                schedule.ModifiedDate = DateTime.Now;
                schedule.ModifiedBy = HttpContext.Current.User.Identity.Name;


                course.TrainingCourseSchedules.Add(schedule);
                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";
            }
            else
            {
                throw new Exception("Cannot find the related course record");
            }
            return result;
        }

        [WebMethod]
        public string createNewCourse(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Course obj = serializer.Deserialize<Course>(json);

            var course = _context.TrainingCourses.Where(CRS => CRS.CourseNo == obj.CourseNo).Select(CRS => CRS).SingleOrDefault();
            if (course == null)
            {
                course = new TrainingCourse();
                course.CourseNo = obj.CourseNo;
                course.Title = obj.CourseTitle;
                course.Description = obj.Description == string.Empty ? null : obj.Description;
                course.StartDate = obj.StartDate;
                course.Duration = obj.Duration == 0 ? (int?)null : obj.Duration;
                course.PeriodID = obj.Period == string.Empty ? (int?)null : _context.Periods.Single(PRD => PRD.Period1 == obj.Period).PeriodID;
                course.MaterialID = obj.Material == string.Empty ? (long?)null : _context.Documents.Single(DOC => DOC.Title == obj.Material).DocumentId;
                course.EndDate = obj.EndDate.HasValue == false ? (DateTime?)null : Convert.ToDateTime(obj.EndDate);
                course.CoordenatorID = (from EMP in _context.Employees
                                        where EMP.FirstName == obj.Coordinator.Substring(obj.Coordinator.LastIndexOf(".") + 1, obj.Coordinator.IndexOf(" ") - 3) &&
                                        EMP.LastName == obj.Coordinator.Substring(obj.Coordinator.IndexOf(" ") + 1)
                                        select EMP.EmployeeID).SingleOrDefault();
                course.Capacity = obj.Capacity;
                course.Lunch = obj.IncludeLunch;
                course.Transportation = obj.IncludeTransporation;
                course.Refreshment = obj.IncludeRefreshment;
                course.CourseStatusID = (int)obj.CourseStatus;
                course.RecordModeID = (int)obj.Mode;

                course.ModifiedDate = DateTime.Now;
                course.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.TrainingCourses.InsertOnSubmit(course);
                _context.SubmitChanges();

                /*if today is less than the start date of the course, then, set the status to Scheduled. 
                 * Otherwise, the default status for the course is set to Created*/
                if (DateTime.Now < course.StartDate)
                {
                    course.CourseStatusID=(int)CourseStatus.Scheduled;
                }

                //add all standard questions to the question list of the course by default
                var questions = _context.CourseQuestions.Where(QUS => QUS.QuestionMode.QuestionMode1 == "Standard")
                    .Select(QUS => QUS).ToList();

                if (questions.Count > 0)
                {
                    try
                    {
                        foreach (var question in questions)
                        {
                            TrainingCourseQuestion tq = new TrainingCourseQuestion();
                            tq.TrainingCourseId = course.TrainingCourseId;
                            tq.CourseQuestionId = question.CourseQuestionId;
                            tq.ModifiedDate = DateTime.Now;
                            tq.ModifiedBy = HttpContext.Current.User.Identity.Name;


                            _context.TrainingCourseQuestions.InsertOnSubmit(tq);

                        }
                    }
                    finally
                    {
                        _context.SubmitChanges();
                    }
                }

                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.EmployeeTraining;
                automail.KeyValue = course.TrainingCourseId;
                automail.Action = "Add";

                //add course coordinator as a recipient
                automail.Recipients.Add(course.CoordenatorID);

                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Course number should have a unique identifier");
            }
            return result;
        }
       
        [WebMethod]
        public void createCourseQuestion(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Question obj = serializer.Deserialize<Question>(json);

            var question = _context.CourseQuestions.Where(QUS => QUS.Question == obj.QuestionText).Select(QUS => QUS).SingleOrDefault();
            if (question == null)
            {
                question = new CourseQuestion();
                question.Question = obj.QuestionText;
                question.QuestionModeID = _context.QuestionModes.Single(MOD => MOD.QuestionMode1 == obj.QuestionMode).QuestionModeID;
                question.ModifiedDate = DateTime.Now;
                question.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.CourseQuestions.InsertOnSubmit(question);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The question already exists");
            }

        }
        
        #endregion
        
        #region RiskManagement

        [WebMethod]
        public string getRiskID()
        {
            string riskID = null;

            if (_context.Risks.ToList().Count > 0)
            {
                long maxId = _context.Risks.Max(i => i.RiskId);
                riskID = _context.Risks.Where(RSK => RSK.RiskId == maxId).Select(RSK => RSK.RiskNo).SingleOrDefault();
            }
            return riskID == null ? string.Empty : riskID;
        }

        [WebMethod]
        public string getRiskByID(string riskno)
        {
            //get all current risk records
            var risk = _context.Risks
            .Where(RSK=> RSK.RiskNo == riskno)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID)
            }).SingleOrDefault();

            if (risk == null)
            {
                throw new Exception("Cannot find the related risk record");
            }

            var xml = new XmlSerializer(typeof(Risk));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risk);

            return str.ToString();
        }

        [WebMethod]
        public void removeRiskCriteria(int criteriaID)
        {
            var ceriteria = _context.RiskCriterias.Where(CRT => CRT.RiskCriteriaID == criteriaID)
            .Select(CRT => CRT).SingleOrDefault();

            if (ceriteria != null)
            {
                _context.RiskCriterias.DeleteOnSubmit(ceriteria);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk criteria record");
            }
        }

        [WebMethod]
        public void createScoreCriteria(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ScoreCriteria obj = serializer.Deserialize<ScoreCriteria>(json);

            var score = new LINQConnection.RiskScoreCriteria();
            score.ComparatorID = _context.AT_RAGSigns.Single(S => S.Sign == obj.Comparator).SignID;
            score.ComparatorValue = obj.ComparatorValue;
            score.Rank = obj.Rank;
            score.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
            score.Description = obj.Description == string.Empty ? null : obj.Description;
            score.ModifiedDate = DateTime.Now;
            score.ModifiedBy = HttpContext.Current.User.Identity.Name;

            _context.RiskScoreCriterias.InsertOnSubmit(score);
            _context.SubmitChanges();
        }

        [WebMethod]
        public int getRiskScoreRating(decimal score)
        {

            int rating = 0;

            List<RiskScoreCriteria> criteria =_context.RiskScoreCriterias.Select(S=>S).ToList();

            for (int i = 0; i < criteria.Count; i++)
            {
                RiskScoreCriteria c = criteria[i];

                switch (c.AT_RAGSign.Sign.Trim())
                {
                    case "=":
                        if (score == c.ComparatorValue)
                        {
                            rating = c.Rank;
                        }
                        break;
                    case ">=":
                        if (score >= c.ComparatorValue)
                        {
                            rating = c.Rank;
                        }
                        break;
                    case ">":
                        if (score > c.ComparatorValue)
                        {
                            rating = c.Rank;

                        }
                        break;
                    case "<":
                        if (score < c.ComparatorValue)
                        {
                            rating = c.Rank;
                        }
                        break;
                    case "<=":
                        if (score <= c.ComparatorValue)
                        {
                            rating = c.Rank;
                        }
                        break;
                }
            }

            return rating;
        }
        [WebMethod]
        public void updateScoreCriteria(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ScoreCriteria obj = serializer.Deserialize<ScoreCriteria>(json);

            var score = _context.RiskScoreCriterias.Where(SCRT => SCRT.RiskScoreCriteriaID == obj.ScoreCriteriaID).Select(SCRT => SCRT).SingleOrDefault();
            if (score != null)
            {
                score.ComparatorID = _context.AT_RAGSigns.Single(S => S.Sign == obj.Comparator).SignID;
                score.ComparatorValue = obj.ComparatorValue;
                score.Rank = obj.Rank;
                score.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
                score.Description = obj.Description == string.Empty ? null : obj.Description;
                score.ModifiedDate = DateTime.Now;
                score.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk score criteria record");
            }
        }

        [WebMethod]
        public void removeRiskScoreCriteria(int ID)
        {
             var score = _context.RiskScoreCriterias.Where(SCRT => SCRT.RiskScoreCriteriaID == ID).Select(SCRT => SCRT).SingleOrDefault();
             if (score != null)
             {

                 _context.RiskScoreCriterias.DeleteOnSubmit(score);
                 _context.SubmitChanges();
             }
             else
             {
                 throw new Exception("Cannot find the related risk score criteria record");
             }
        }


        [WebMethod]
        public void createCriteria(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            RiskCriteria obj = serializer.Deserialize<RiskCriteria>(json);

            var criteria = _context.RiskCriterias.Where(CRT => CRT.RiskCriteria1 == obj.Criteria).Select(CRT => CRT).SingleOrDefault();
            if (criteria == null)
            {
                criteria = new LINQConnection.RiskCriteria();
                criteria.RiskCriteria1 = obj.Criteria;
                criteria.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
                criteria.Description = obj.Description == string.Empty ? null : obj.Description;
                criteria.ModifiedDate = DateTime.Now;
                criteria.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.RiskCriterias.InsertOnSubmit(criteria);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the risk criteria should be unique for a particular risk type");
            }
        }

        [WebMethod]
        public void updateCriteria(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            RiskCriteria obj = serializer.Deserialize<RiskCriteria>(json);

            var criteria = _context.RiskCriterias.Where(CRT => CRT.RiskCriteriaID == obj.RiskCriteriaID).Select(CRT => CRT).SingleOrDefault();
            if (criteria != null)
            {
                criteria.RiskCriteria1 = obj.Criteria;
                criteria.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
                criteria.Description = obj.Description == string.Empty ? null : obj.Description;
                criteria.ModifiedDate = DateTime.Now;
                criteria.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk criteria record");
            }
        }

       
        [WebMethod]
        public string loadRiskCriteria()
        {
            var criteria = _context.RiskCriterias
            .Select(CRT => new RiskCriteria
            {
                RiskCriteriaID=CRT.RiskCriteriaID,
                RiskType=CRT.RiskType.RiskType1,
                Criteria=CRT.RiskCriteria1,
                Description=CRT.Description == null ? string.Empty : CRT.Description
            }).ToList();

            var xml = new XmlSerializer(typeof(List<RiskCriteria>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, criteria);

            return str.ToString();
        }

        [WebMethod]
        public string loadRiskRateCriteria()
        {
            string result = string.Empty;

            var rate = _context.RiskRatingCriterias
            .Select(RT => new RateCriteria
            {
                RateCriteriaID = RT.RatingCriteriaID,
                Rate = RT.Rating,
                Comparator=RT.AT_RAGSign.Sign,
                Description = RT.Description == null ? string.Empty : RT.Description
            }).ToList();

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(rate);

            return result;
        }

        [WebMethod]
        public string filterCriteriaByRiskType(string risktype)
        {
            var criteria = _context.RiskCriterias
            .Where(CRT=>CRT.RiskType.RiskType1==risktype)
            .Select(CRT => new RiskCriteria
            {
                RiskCriteriaID = CRT.RiskCriteriaID,
                RiskType = CRT.RiskType.RiskType1,
                Criteria = CRT.RiskCriteria1,
                Description = CRT.Description == null ? string.Empty : CRT.Description
            }).ToList();

            var xml = new XmlSerializer(typeof(List<RiskCriteria>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, criteria);

            return str.ToString();
        }

        [WebMethod]
        public string filterRiskScoreCriteriaByType(string risktype)
        {
            var score = _context.RiskScoreCriterias
            .Where(RSKTYP=>RSKTYP.RiskType.RiskType1==risktype)
            .Select(SCRCRT => new ScoreCriteria
            {
                ScoreCriteriaID = SCRCRT.RiskScoreCriteriaID,
                Comparator=SCRCRT.AT_RAGSign.Sign,
                ComparatorValue=SCRCRT.ComparatorValue,
                Rank=SCRCRT.Rank,
                RiskType = SCRCRT.RiskType.RiskType1,
                Description = SCRCRT.Description == null ? string.Empty : SCRCRT.Description
            }).ToList();

            var xml = new XmlSerializer(typeof(List<ScoreCriteria>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, score);

            return str.ToString();
        }
        [WebMethod]
        public string loadRiskScoreCriteria()
        {
            var score = _context.RiskScoreCriterias
            .Select(SCRCRT => new ScoreCriteria
            {
                ScoreCriteriaID = SCRCRT.RiskScoreCriteriaID,
                Comparator = SCRCRT.AT_RAGSign.Sign,
                ComparatorValue = SCRCRT.ComparatorValue,
                Rank = SCRCRT.Rank,
                RiskType = SCRCRT.RiskType.RiskType1,
                Description = SCRCRT.Description == null ? string.Empty : SCRCRT.Description
            }).ToList();

            var xml = new XmlSerializer(typeof(List<ScoreCriteria>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, score);

            return str.ToString();
        }

        [WebMethod]
        public string[] loadRiskCriteriaArray()
        {
            var criteria = (from C in _context.RiskCriterias
                            select C.RiskCriteria1).ToArray();

            return criteria;
        }

        [WebMethod]
        public void uploadProbabilityMatrix(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<MatrixCell> obj = serializer.Deserialize<List<MatrixCell>>(json);

            for (int i = 0; i < obj.Count; i++)
            {
              
                //loop through first column
                if (obj[i].Y == 0 && obj[i].X != 0)
                {
                    var probability = obj[i].Value.ToString();

                    //loop through first row
                    for (int j = obj.Count - 1; j >= 0; j--)
                    {
                        if (obj[j].X == 0)
                        {
                            var impact = obj[j].Value.ToString();

                            var result = getProbability(obj, obj[i].X, obj[j].Y);


                            RiskImpactProbabilityMatrix matrix;

                            switch (result.Status)
                            {
                                case RecordsStatus.ADDED:
                                    matrix = new RiskImpactProbabilityMatrix();
                                    matrix.ProbabilityCriteriaID = _context.RiskCriterias.Single(C => C.RiskCriteria1 == probability).RiskCriteriaID;
                                    matrix.ImpactCriteriaID = _context.RiskCriterias.Single(C => C.RiskCriteria1 == impact).RiskCriteriaID;
                                    matrix.Probability = Convert.ToDecimal(result.Value);
                                    matrix.ModifiedDate = DateTime.Now;
                                    matrix.ModifiedBy = HttpContext.Current.User.Identity.Name;

                                    _context.RiskImpactProbabilityMatrixes.InsertOnSubmit(matrix);
                                    break;

                                case RecordsStatus.MODIFIED:
                                    matrix = _context.RiskImpactProbabilityMatrixes.Where(M => M.RiskCriteria.RiskCriteria1 == probability && M.RiskCriteria1.RiskCriteria1 == impact).Select(M => M).SingleOrDefault();
                                    if (matrix != null)
                                    {
                                        matrix.ProbabilityCriteriaID = _context.RiskCriterias.Single(C => C.RiskCriteria1 == probability).RiskCriteriaID;
                                        matrix.ImpactCriteriaID = _context.RiskCriterias.Single(C => C.RiskCriteria1 == impact).RiskCriteriaID;
                                        matrix.Probability = Convert.ToDecimal(result.Value);
                                        matrix.ModifiedDate = DateTime.Now;
                                        matrix.ModifiedBy = HttpContext.Current.User.Identity.Name;
                                    }
                                    break;
                            }
                        }
                    }
                }

            }

            _context.SubmitChanges();

        }

        public MatrixCell getProbability(List<MatrixCell> obj, int x, int y)
        {
            MatrixCell result=null;

            for (int i = 0; i < obj.Count; i++)
            {
                if (obj[i].X == x && obj[i].Y == y)
                {
                    result = obj[i];

                    break;
                }
            }

            return result;
        }
        [WebMethod]
        public string loadProbabilityMatrix(string risktype)
        {
            string result = string.Empty;

            var criteria = _context.RiskCriterias.Where(C=>C.RiskType.RiskType1==risktype).Select(C => C).ToList();

            if (criteria.Count > 0)
            {
                List<MatrixCell> firstcolumn = new List<MatrixCell>();

                List<MatrixCell> firstrow = new List<MatrixCell>();

                List<MatrixCell> matrix = new List<MatrixCell>();

                /* reserve the first column and the first row to store the header values*/
                for (int i = 0; i < criteria.Count; i++)
                {
                    firstrow.Add(new MatrixCell(i + 1, 0, criteria[i].RiskCriteria1));

                    firstcolumn.Add(new MatrixCell(0, i + 1, criteria[i].RiskCriteria1));
                }

                /* algorithm for storing the probability values in the matrix*/
                for (int i = 0; i < firstrow.Count; i++)
                {
                    for (int j = 0; j < firstcolumn.Count; j++)
                    {
                        MatrixCell p1 = firstrow[i];
                        MatrixCell p2 = firstcolumn[j];

                        if (p1.Y == p2.X && p1.Y == 0)
                        {
                            var probability = _context.RiskImpactProbabilityMatrixes.Where(P => P.RiskCriteria.RiskCriteria1 == p1.Value.ToString() && P.RiskCriteria1.RiskCriteria1 == p2.Value.ToString()).Select(P => P).SingleOrDefault();


                            MatrixCell newpair;
                            if (probability != null)
                            {
                                newpair = new MatrixCell(p1.X, p2.Y, probability.Probability);
                            }
                            else
                            {
                                newpair = new MatrixCell(p1.X, p2.Y, 0.00, RecordsStatus.ADDED);
                            }

                            matrix.Add(newpair);
                        }
                    }

                }

                /*set location (0,0) in the matrix to empty, as we dont need it*/
                firstrow.Insert(0, new MatrixCell(0, 0, string.Empty));

                firstcolumn.ForEach(MergeColumns => firstrow.Add(MergeColumns));
                matrix.ForEach(MergeRows => firstrow.Add(MergeRows));

                firstcolumn = null;
                matrix = null;

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                result = serializer.Serialize(firstrow);
            }
            else
            {
                throw new Exception("There are no defined risk criterias, which matches the selected risk type, where the associated probability materix can be defined");
            }

            return result;
        }

        [WebMethod]
        public string[] loadRiskType()
        {
            var type = (from RSKTYP in _context.RiskTypes
                        select RSKTYP.RiskType1).ToArray();
            return type;
          
        }

        [WebMethod]
        public string[] loadRiskStatus()
        {
            var status = (from RSKSTS in _context.RiskStatus
                        select RSKSTS.RiskStatus1).ToArray();
            return status;

        }

        [WebMethod]
        public string[] loadRiskMode()
        {
            var mode = (from RSKMOD in _context.RiskModes
                        select RSKMOD.RiskMode1).ToArray();
            return mode;

        }

        [WebMethod]
        public string[] loadISO30000RiskType()
        {
            List<int> obj = new List<int>();
            obj.Add((int)RiskType.ORI);

            var type = (from RSKTYP in _context.RiskTypes
                        where obj.Contains(RSKTYP.RiskTypeID)
                        select RSKTYP.RiskType1).ToArray();
            return type;

        }


        [WebMethod]
        public string[] loadRiskParameters(string risktype)
        {
            var parameters = (from RSKPARAM in _context.RiskFormulaParameters
                              where RSKPARAM.RiskType.RiskType1 == risktype
                              select RSKPARAM.ParameterText).ToArray();
            return parameters;
        }

        [WebMethod]
        public string filterRiskFormulasByType(string risktype)
        {
            var formulas = _context.RiskFormulas
            .Where(FRM=>FRM.RiskType.RiskType1==risktype)
            .Select(FRM => new RiskFormula
            {
                FormulaID = FRM.FormulaID,
                Formula = FRM.Formula,
                RiskType = FRM.RiskType.RiskType1
            }).ToList();

            var xml = new XmlSerializer(typeof(List<RiskFormula>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, formulas);

            return str.ToString();
        }

        [WebMethod]
        public string loadRiskFormulas()
        {
            var formulas = _context.RiskFormulas
            .Select(FRM => new RiskFormula
            {
                FormulaID=FRM.FormulaID,
                Formula=FRM.Formula,
                RiskType=FRM.RiskType.RiskType1
            }).ToList();

            var xml = new XmlSerializer(typeof(List<RiskFormula>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, formulas);

            return str.ToString();
        }

        [WebMethod]
        public string getFormulaDBAttribute(string parameter, string risktype)
        {
            var attribute = _context.RiskFormulaParameters.Where(PRM => PRM.RiskType.RiskType1 == risktype && PRM.ParameterText == parameter)
                .Select(PRM => PRM.ParameterValue).SingleOrDefault();

            return attribute;
        }

        [WebMethod]
        public void removeRiskFormula(int formulaID)
        {
            var formula = _context.RiskFormulas.Where(FRM => FRM.FormulaID == formulaID)
            .Select(FRM => FRM).SingleOrDefault();

            if (formula != null)
            {
                _context.RiskFormulas.DeleteOnSubmit(formula);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk formula record");
            }
        }

        [WebMethod]
        public string loadRiskCategory()
        {
            var category = _context.RiskCategories
           .Select(CAT => new Category
           {
               CategoryID = CAT.RiskCategoryID,
               CategoryName = CAT.Category,
               Description = CAT.Description == null ? string.Empty : CAT.Description
           }).ToList();

            var xml = new XmlSerializer(typeof(List<Category>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, category);

            return str.ToString();
        }


        [WebMethod]
        public void removeRiskCategory(long ID)
        {
            var category = _context.RiskCategories.Where(CAT => CAT.RiskCategoryID == ID).Select(CAT => CAT).SingleOrDefault();
            if (category != null)
            {
                _context.RiskCategories.DeleteOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk category record");
            }
        }

        [WebMethod]
        public string loadSubcategories(string categoryname)
        {
            string result = string.Empty;

            var category = _context.RiskCategories.Where(CAT => CAT.Category == categoryname)
                .Select(CAT => CAT).SingleOrDefault();

            if (category != null)
            {
                var subcategory = _context.RiskSubCategories
                .Where(SUBCAT => SUBCAT.RiskCategory.Category == categoryname)
                .Select(SUBCAT => new RiskSubcategory
                {
                    SubCategoryID = SUBCAT.SubCategoryID,
                    name = SUBCAT.SubCategory,
                    Category = categoryname,
                    Description = SUBCAT.Description == null ? string.Empty : SUBCAT.Description,
                    Status = RecordsStatus.ORIGINAL
                }).ToList();

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                result = serializer.Serialize(subcategory);
            }
            else
            {
                throw new Exception("Cannot find the related risk category record");
            }
            return result;
        }

        [WebMethod]
        public string UploadSubcategories(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<RiskSubcategory> obj = serializer.Deserialize<List<RiskSubcategory>>(json);

            LINQConnection.RiskSubCategory subcategory = null;

            string result = string.Empty;

            try
            {
                foreach (RiskSubcategory subobj in obj)
                {
                    switch (subobj.Status)
                    {
                        case RecordsStatus.ADDED:

                            subcategory = new LINQConnection.RiskSubCategory();
                            subcategory.SubCategory = subobj.name;
                            subcategory.CategoryID = _context.RiskCategories.Single(CAT => CAT.Category == subobj.Category).RiskCategoryID;
                            subcategory.Description = subobj.Description == string.Empty ? null : subobj.Description;
                            subcategory.ModifiedDate = DateTime.Now;
                            subcategory.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            _context.RiskSubCategories.InsertOnSubmit(subcategory);
                            break;
                        case RecordsStatus.MODIFIED:
                            subcategory = _context.RiskSubCategories.Where(RSKCAT => RSKCAT.SubCategoryID == subobj.SubCategoryID).SingleOrDefault();
                            subcategory.SubCategory = subobj.name;
                            subcategory.CategoryID = _context.RiskCategories.Single(CAT => CAT.Category == subobj.Category).RiskCategoryID;
                            subcategory.Description = subobj.Description == string.Empty ? null : subobj.Description;
                            subcategory.ModifiedDate = DateTime.Now;
                            subcategory.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            break;
                    }
                }

                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";

            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return result;
        }

        [WebMethod]
        public void removeRiskSubCategory(int subcategoryID)
        {
            var subcategory = _context.RiskSubCategories.Where(SUB => SUB.SubCategoryID == subcategoryID)
                .Select(SUB => SUB).SingleOrDefault();

            if (subcategory != null)
            {
                _context.RiskSubCategories.DeleteOnSubmit(subcategory);
                _context.SubmitChanges();
            }
        }

        [WebMethod]
        public void createNewRiskCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.RiskCategories.Where(CAT => CAT.Category == obj.CategoryName)
            .Select(CAT => CAT).SingleOrDefault();

            if (category == null)
            {
                category = new RiskCategory();
                category.Category = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.RiskCategories.InsertOnSubmit(category);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the risk category already exists");
            }
        }

        [WebMethod]
        public void updateRiskCategory(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Category obj = serializer.Deserialize<Category>(json);

            var category = _context.RiskCategories.Where(CAT => CAT.RiskCategoryID == obj.CategoryID)
           .Select(CAT => CAT).SingleOrDefault();

            if (category != null)
            {
                category.Category = obj.CategoryName;
                category.Description = obj.Description == string.Empty ? null : obj.Description;
                category.ModifiedDate = DateTime.Now;
                category.ModifiedBy = HttpContext.Current.User.Identity.Name;

            
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk category record");
            }
        }

        [WebMethod]
        public void createNewRiskFormula(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            RiskFormula obj = serializer.Deserialize<RiskFormula>(json);

            var riskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
            var query = _context.RiskFormulas.Where(RSKFORM => RSKFORM.RiskTypeID == riskTypeID).FirstOrDefault();

            if(query == null)
            {
                var formula = new LINQConnection.RiskFormula();
                formula.Formula = obj.Formula;
                formula.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
                formula.ModifiedDate = DateTime.Now;
                formula.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.RiskFormulas.InsertOnSubmit(formula);
                _context.SubmitChanges();
            }else
            {
                throw new Exception("Formula for the selected risk type already exists.");
            }

        }

        [WebMethod]
        public void updateRiskFormula(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            RiskFormula obj = serializer.Deserialize<RiskFormula>(json);

            var formula = _context.RiskFormulas.Where(RSKF => RSKF.FormulaID == obj.FormulaID).Select(RSKF => RSKF).SingleOrDefault();
            if (formula != null)
            {
                formula.Formula = obj.Formula;
                formula.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
                formula.ModifiedDate = DateTime.Now;
                formula.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk formula record");
            }
        }

        [WebMethod]
        public string loadProbability(string risktype)
        {
            string result = string.Empty;
            
            var criteria = _context.RiskCriterias.Where(C=>C.RiskType.RiskType1==risktype).Select(C => C).ToList();

            if (criteria.Count > 0)
            {
                List<RiskProbability> probability = new List<RiskProbability>();

                foreach (var c in criteria)
                {
                    var p = _context.RiskProbabilities.Where(P => P.RiskCriteria.RiskCriteria1 == c.RiskCriteria1).Select(P => P).SingleOrDefault();
                    if (p != null)
                    {
                        probability.Add(new RiskProbability
                        {
                            RiskProbabilityID = p.RiskProbabilityId,
                            Probability = p.Probability,
                            Criteria = p.RiskCriteria.RiskCriteria1,
                            Status = RecordsStatus.ORIGINAL

                        });
                    }
                    else
                    {
                        probability.Add(new RiskProbability
                        {
                            Probability = 0,
                            Criteria = c.RiskCriteria1,
                            Status = RecordsStatus.ADDED

                        });

                    }
                }
                JavaScriptSerializer serializer = new JavaScriptSerializer();
                result = serializer.Serialize(probability);
            }
            else
            {
                throw new Exception("There are no defined risk criterias, which matches the defined risk type");
            }

            return result;
        }

        [WebMethod]
        public string loadCostImpactGuidLines(string risktype)
        {
            string result = string.Empty;

            var criteria = _context.RiskCriterias.Where(C=>C.RiskType.RiskType1==risktype).Select(C => C).ToList();

            List<Impact> impact = new List<Impact>();

            foreach (var c in criteria)
            {
                var pci = _context.RiskImpacts.Where(IMP => IMP.RiskCriteria.RiskCriteria1 == c.RiskCriteria1 && IMP.RiskImpactTypeID == (int)ImpactType.Cost).Select(IMP => IMP).SingleOrDefault();
                if (pci != null)
                {
                    impact.Add(new Impact
                    {
                        ImpactID = pci.RiskImpactID,
                        ImpactType = (ImpactType)pci.RiskImpactTypeID,
                        RiskCriteria = pci.RiskCriteria.RiskCriteria1,
                        Description1 = pci.Description1 == null ? string.Empty : pci.Description1,
                        Description2 = pci.Description2 == null ? string.Empty : pci.Description2,
                        Status = RecordsStatus.ORIGINAL

                    });
                }
                else
                {
                    impact.Add(new Impact
                    {
                        ImpactType = ImpactType.Cost,
                        RiskCriteria = c.RiskCriteria1,
                        Description1 = string.Empty,
                        Description2 = string.Empty,
                        Status = RecordsStatus.ADDED

                    });

                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(impact);

            return result;
        }

        [WebMethod]
        public string loadTimeImpactGuidLines(string risktype)
        {
            string result = string.Empty;

            var criteria = _context.RiskCriterias.Where(C=>C.RiskType.RiskType1==risktype).Select(C => C).ToList();


            List<Impact> impact = new List<Impact>();

            foreach (var c in criteria)
            {
                var pti = _context.RiskImpacts.Where(IMP => IMP.RiskCriteria.RiskCriteria1 == c.RiskCriteria1 && IMP.RiskImpactTypeID == (int)ImpactType.Time).Select(IMP => IMP).SingleOrDefault();
                if (pti != null)
                {
                    impact.Add(new Impact
                    {
                        ImpactID = pti.RiskImpactID,
                        ImpactType = (ImpactType)pti.RiskImpactTypeID,
                        RiskCriteria = pti.RiskCriteria.RiskCriteria1,
                        Description1 = pti.Description1 == null ? string.Empty : pti.Description1,
                        Description2 = pti.Description2 == null ? string.Empty : pti.Description2,
                        Status = RecordsStatus.ORIGINAL

                    });
                }
                else
                {
                    impact.Add(new Impact
                    {
                        ImpactType = ImpactType.Time,
                        RiskCriteria = c.RiskCriteria1,
                        Description1 = string.Empty,
                        Description2 = string.Empty,
                        Status = RecordsStatus.ADDED

                    });
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(impact);

            return result;
        }

        [WebMethod]
        public string loadQOSImpactGuidLines(string risktype)
        {
            string result = string.Empty;

            var criteria = _context.RiskCriterias.Where(C => C.RiskType.RiskType1 == risktype).Select(C => C).ToList();

            List<Impact> impact = new List<Impact>();

            foreach (var c in criteria)
            {
                var qos = _context.RiskImpacts.Where(IMP => IMP.RiskCriteria.RiskCriteria1 == c.RiskCriteria1 && IMP.RiskImpactTypeID == (int)ImpactType.QOS).Select(IMP => IMP).SingleOrDefault();
                if (qos != null)
                {
                    impact.Add(new Impact
                    {
                        ImpactID = qos.RiskImpactID,
                        ImpactType = (ImpactType)qos.RiskImpactTypeID,
                        RiskCriteria = qos.RiskCriteria.RiskCriteria1,
                        Description1 = qos.Description1 == null ? string.Empty : qos.Description1,
                        Description2 = qos.Description2 == null ? string.Empty : qos.Description2,
                        Status = RecordsStatus.ORIGINAL

                    });
                }
                else
                {
                    impact.Add(new Impact
                    {
                        ImpactType = ImpactType.QOS,
                        RiskCriteria = c.RiskCriteria1,
                        Description1 = string.Empty,
                        Description2 = string.Empty,
                        Status = RecordsStatus.ADDED

                    });
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(impact);

            return result;
        }

        [WebMethod]
        public string loadSTDCostImpactGuidLines(string risktype)
        {
            string result = string.Empty;

            var STDCost = _context.RiskCriterias.Where(C => C.RiskType.RiskType1 == risktype).Select(C => C).ToList();

            List<StandardCost> stdcost = new List<StandardCost>();

            foreach (var c in STDCost)
            {
                var cost = _context.StandardCostImpacts.Where(C => C.RiskCriteria.RiskCriteria1 == c.RiskCriteria1 && C.RiskCriteria.RiskType.RiskType1==risktype).Select(C => C).SingleOrDefault();
                if (cost != null)
                {
                    stdcost.Add(new StandardCost
                    {
                        STDCostID=cost.CostImpactID,
                        STDCost=cost.StandardCost,
                        RiskCriteria = cost.RiskCriteria.RiskCriteria1,
                        Status = RecordsStatus.ORIGINAL

                    });
                }
                else
                {
                    stdcost.Add(new StandardCost
                    {
                        STDCost = 0,
                        RiskCriteria = c.RiskCriteria1,
                        Status = RecordsStatus.ADDED
                    });
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            result = serializer.Serialize(stdcost);

            return result;
        }

        [WebMethod]
        public string UploadRateCriteria(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<RateCriteria> obj = serializer.Deserialize<List<RateCriteria>>(json);

            LINQConnection.RiskRatingCriteria rate = null;

            string result = string.Empty;

            try
            {
                foreach (RateCriteria r in obj)
                {
                    switch (r.Status)
                    {
                        case RecordsStatus.ADDED:

                            rate = new LINQConnection.RiskRatingCriteria();
                            rate.ComparatorID = _context.AT_RAGSigns.Single(S => S.Sign == Server.HtmlDecode(r.Comparator)).SignID;
                            rate.Rating = r.Rate;
                            rate.Description = r.Description == string.Empty ? null : r.Description;
                            rate.ModifiedDate = DateTime.Now;
                            rate.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            _context.RiskRatingCriterias.InsertOnSubmit(rate);
                            break;
                        case RecordsStatus.MODIFIED:
                            rate = _context.RiskRatingCriterias.Where(R => R.RatingCriteriaID == r.RateCriteriaID).SingleOrDefault();
                            rate.ComparatorID = _context.AT_RAGSigns.Single(S => S.Sign == Server.HtmlDecode(r.Comparator)).SignID;
                            rate.Rating = r.Rate;
                            rate.Description = r.Description == string.Empty ? null : r.Description;
                            rate.ModifiedDate = DateTime.Now;
                            rate.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            break;
                        case RecordsStatus.REMOVED:
                            rate = _context.RiskRatingCriterias.Where(R => R.RatingCriteriaID == r.RateCriteriaID).SingleOrDefault();
                            _context.RiskRatingCriterias.DeleteOnSubmit(rate);
                            break;

                    }
                }

                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";

            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return result;
        }
        [WebMethod]
        public string UploadImpactGuidlines(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<Impact> obj = serializer.Deserialize<List<Impact>>(json);

            LINQConnection.RiskImpact impact = null;

            string result = string.Empty;

            try
            {
                foreach (Impact imp in obj)
                {
                    switch (imp.Status)
                    {
                        case RecordsStatus.ADDED:

                           impact = new LINQConnection.RiskImpact();
                           impact.RiskImpactTypeID = (int)imp.ImpactType;
                           impact.RiskCriteriaID = _context.RiskCriterias.Single(CRT => CRT.RiskCriteria1 == imp.RiskCriteria).RiskCriteriaID;
                           impact.Description1 = imp.Description1 == string.Empty ? null : imp.Description1;
                           impact.Description2 = imp.Description2 == string.Empty ? null : imp.Description2;
                           impact.ModifiedDate = DateTime.Now;
                           impact.ModifiedBy = HttpContext.Current.User.Identity.Name;

                           _context.RiskImpacts.InsertOnSubmit(impact);
                            break;
                        case RecordsStatus.MODIFIED:
                            impact = _context.RiskImpacts.Where(IMP => IMP.RiskImpactID == imp.ImpactID).SingleOrDefault();
                            impact.RiskImpactTypeID = (int)imp.ImpactType;
                            impact.RiskCriteriaID = _context.RiskCriterias.Single(CRT => CRT.RiskCriteria1 == imp.RiskCriteria).RiskCriteriaID;
                            impact.Description1 = imp.Description1 == string.Empty ? null : imp.Description1;
                            impact.Description2 = imp.Description2 == string.Empty ? null : imp.Description2;
                            impact.ModifiedDate = DateTime.Now;
                            impact.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            break;
                        case RecordsStatus.REMOVED:
                            impact = _context.RiskImpacts.Where(IMP => IMP.RiskImpactID == imp.ImpactID).SingleOrDefault();
                            _context.RiskImpacts.DeleteOnSubmit(impact);
                            break;

                    }
                }

                _context.SubmitChanges();

                result = "Operation has been committed sucessfully";

            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

            return result;
        }

        [WebMethod]
        public void UploadSTDCostImpactGuidlines(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<StandardCost> obj = serializer.Deserialize<List<StandardCost>>(json);

            LINQConnection.StandardCostImpact costimpact = null;

            string result = string.Empty;

            try
            {
                foreach (StandardCost imp in obj)
                {
                    switch (imp.Status)
                    {
                        case RecordsStatus.ADDED:
                            costimpact = new LINQConnection.StandardCostImpact();
                            costimpact.RiskCriteriaID = _context.RiskCriterias.Single(CRT => CRT.RiskCriteria1 == imp.RiskCriteria).RiskCriteriaID;
                            costimpact.StandardCost = imp.STDCost;
                            costimpact.ModifiedDate = DateTime.Now;
                            costimpact.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            _context.StandardCostImpacts.InsertOnSubmit(costimpact);
                            break;
                        case RecordsStatus.MODIFIED:
                            costimpact = _context.StandardCostImpacts.Where(STDIMP => STDIMP.CostImpactID == imp.STDCostID).SingleOrDefault();
                            costimpact.RiskCriteriaID = _context.RiskCriterias.Single(CRT => CRT.RiskCriteria1 == imp.RiskCriteria).RiskCriteriaID;
                            costimpact.StandardCost = imp.STDCost;
                            costimpact.ModifiedDate = DateTime.Now;
                            costimpact.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            break;
                        case RecordsStatus.REMOVED:
                            costimpact = _context.StandardCostImpacts.Where(STDIMP => STDIMP.CostImpactID == imp.STDCostID).SingleOrDefault();
                            _context.StandardCostImpacts.DeleteOnSubmit(costimpact);
                            break;

                    }
                }

                _context.SubmitChanges();

     
            }
            catch (SqlException ex)
            {
                throw new Exception(ex.Message);
            }

        }

        [WebMethod]
        public decimal getProbabilityPercentage(string criteria)
        {
            decimal result = 0;

            var probability = _context.RiskProbabilities.Where(P => P.RiskCriteria.RiskCriteria1 == criteria).Select(P => P).SingleOrDefault();
            if (probability != null)
            {
                result = probability.Probability;
            }
            else
            {
                throw new Exception("There is no associated probability value for the selected risk criteria");

            }

            return result;
        }

        [WebMethod]
        public decimal getStandardCost(string criteria)
        {
            decimal result = 0;

            var stdcost = _context.StandardCostImpacts.Where(STD => STD.RiskCriteria.RiskCriteria1 == criteria).Select(STD => STD).SingleOrDefault();
            if (stdcost != null)
            {
                result = stdcost.StandardCost;
            }
            else
            {
                throw new Exception("There is no associated standard cost for the selected cost of impact criteria");

            }

            return result;
        }
        [WebMethod]
        public void uploadProbabilityValues(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            List<RiskProbability> obj = serializer.Deserialize<List<RiskProbability>>(json);

            if (obj != null)
            {
                LINQConnection.RiskProbability probability = null;

                foreach (var prob in obj)
                {
                    switch (prob.Status)
                    {
                        case RecordsStatus.ADDED:

                            probability = new LINQConnection.RiskProbability();
                            probability.Probability = prob.Probability;
                            probability.RiskCriteriaID = _context.RiskCriterias.Single(C => C.RiskCriteria1 == prob.Criteria).RiskCriteriaID;
                            probability.ModifiedDate = DateTime.Now;
                            probability.ModifiedBy = HttpContext.Current.User.Identity.Name;

                            _context.RiskProbabilities.InsertOnSubmit(probability);
                     
                            break;
                        case RecordsStatus.MODIFIED:
                            probability = _context.RiskProbabilities.Where(P => P.RiskProbabilityId == prob.RiskProbabilityID).Select(P => P).SingleOrDefault();
                            if (probability != null)
                            {
                                probability.Probability = prob.Probability;
                                probability.RiskCriteriaID = _context.RiskCriterias.Single(C => C.RiskCriteria1 == prob.Criteria).RiskCriteriaID;
                                probability.ModifiedDate = DateTime.Now;
                                probability.ModifiedBy = HttpContext.Current.User.Identity.Name;
                            }
                            break;
                        case RecordsStatus.REMOVED:
                            probability = _context.RiskProbabilities.Where(P => P.RiskProbabilityId == prob.RiskProbabilityID).Select(P => P).SingleOrDefault();
                            if (probability != null)
                            {
                                _context.RiskProbabilities.DeleteOnSubmit(probability);
                            }
                            break;
                    }
                }
            }

            _context.SubmitChanges();
        }

        [WebMethod]
        public string loadISO14001Guide()
        {
         
            var guideline = _context.ISO14001AssessmentGuidelines
            .Select(G => new ISO14001Guide
            {
                GuideID = G.AssessmentGuidelineID,
                Guideline = G.AssessmentGuideline,
                Category = G.ISO14001AssessmentCategory.AssessmentCategory,
                Value = G.Value,
                Score=G.Score.HasValue==false?0:Convert.ToDecimal(G.Score),
                Status = RecordsStatus.ORIGINAL
            }).ToList();

            var xml = new XmlSerializer(typeof(List<ISO14001Guide>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, guideline);

            return str.ToString();
         
        }

        [WebMethod]
        public string filterISO14001GuideByCategory(string category)
        {
            var guideline = _context.ISO14001AssessmentGuidelines.Where(G=>G.ISO14001AssessmentCategory.AssessmentCategory==category)
            .Select(G => new ISO14001Guide
            {
                GuideID = G.AssessmentGuidelineID,
                Guideline = G.AssessmentGuideline,
                Category = G.ISO14001AssessmentCategory.AssessmentCategory,
                Value = G.Value,
                Score = G.Score.HasValue == false ? 0 : Convert.ToDecimal(G.Score),
                Status = RecordsStatus.ORIGINAL
            }).ToList();

            var xml = new XmlSerializer(typeof(List<ISO14001Guide>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, guideline);

            return str.ToString();
         
        }

        [WebMethod]
        public string[] loadAssessmentCategory()
        {
            var category = (from CAT in _context.ISO14001AssessmentCategories
                            select CAT.AssessmentCategory).ToArray();
            return category;

        }

        [WebMethod]
        public void removeISO14001Guide(int guideID)
        {
            var guideline = _context.ISO14001AssessmentGuidelines.Where(G => G.AssessmentGuidelineID == guideID).Select(G => G).SingleOrDefault();
            if (guideline != null)
            {
                _context.ISO14001AssessmentGuidelines.DeleteOnSubmit(guideline);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related ISO 14001 Assessment Guide Record");
            }
           
        }

        [WebMethod]
        public void createISO14001Guide(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ISO14001Guide obj = serializer.Deserialize<ISO14001Guide>(json);

            var guide = new LINQConnection.ISO14001AssessmentGuideline();
            guide.AssessmentGuideline = obj.Guideline;
            guide.AssessmentCategoryID = _context.ISO14001AssessmentCategories.Single(CAT => CAT.AssessmentCategory == obj.Category).AssessmentCategoryID;
            guide.Value = obj.Value;
            guide.Score = obj.Score;

            guide.ModifiedDate = DateTime.Now;
            guide.ModifiedBy = HttpContext.Current.User.Identity.Name;

            _context.ISO14001AssessmentGuidelines.InsertOnSubmit(guide);
            _context.SubmitChanges();
        }

        [WebMethod]
        public void updateISO14001Guide(string json)
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            ISO14001Guide obj = serializer.Deserialize<ISO14001Guide>(json);

            var guide = _context.ISO14001AssessmentGuidelines.Where(G => G.AssessmentGuidelineID == obj.GuideID).Select(G => G).SingleOrDefault();
            if (guide != null)
            {
                guide.AssessmentGuideline = obj.Guideline;
                guide.AssessmentCategoryID = _context.ISO14001AssessmentCategories.Single(CAT => CAT.AssessmentCategory == obj.Category).AssessmentCategoryID;
                guide.Value = obj.Value;
                guide.Score = obj.Score;

                guide.ModifiedDate = DateTime.Now;
                guide.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related ISO 14001 Assessment Guide Record");
            }
        }

        [WebMethod]
        public void removeRisk(long riskID)
        {
            var risk = _context.Risks.Where(RSK => RSK.RiskId == riskID).Select(RSK => RSK).SingleOrDefault();
            if (risk != null)
            {
                _context.Risks.DeleteOnSubmit(risk);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk record");
            }
        }

        [WebMethod]
        public string createNewRisk(string json)
        {
            string result = String.Empty;


            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Risk obj = serializer.Deserialize<Risk>(json);
            var risk = _context.Risks.Where(RSK => RSK.RiskNo == obj.RiskNo).Select(RSK => RSK).SingleOrDefault();
            if (risk == null)
            {
                risk = new LINQConnection.Risk();
                risk.RiskNo = obj.RiskNo;
                risk.RiskName = obj.RiskName;
                risk.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
                risk.RiskModeID = _context.RiskModes.Single(RSKMOD => RSKMOD.RiskMode1 == obj.RiskMode).RiskModeID;
                risk.RiskCategoryID = _context.RiskCategories.Single(RSKCAT => RSKCAT.Category == obj.RiskCategory).RiskCategoryID;
                risk.Description = obj.Description == string.Empty ? null : obj.Description;
                risk.RegisterDate = obj.RegisterDate;
                risk.RiskProbabilityID = _context.RiskProbabilities.Single(P => P.RiskCriteria.RiskCriteria1 == obj.RiskProbability).RiskProbabilityId;
                risk.OwnerID = (from EMP in _context.Employees
                                where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                select EMP.EmployeeID).SingleOrDefault();
                risk.ProjectID = obj.ProjectName == string.Empty ? (int?)null : _context.ProjectInformations.Single(PROJ => PROJ.ProjectName == obj.ProjectName).ProjectId;
                risk.TimeImpactID = obj.TimeImpact == string.Empty ? (int?)null : _context.RiskImpacts.Single(I => I.RiskCriteria.RiskCriteria1 == obj.TimeImpact && I.RiskImpactTypeID == (int)ImpactType.Time).RiskImpactID;
                risk.CostImpactID = obj.CostImpact == string.Empty ? (int?)null : _context.RiskImpacts.Single(I => I.RiskCriteria.RiskCriteria1 == obj.CostImpact && I.RiskImpactTypeID == (int)ImpactType.Cost).RiskImpactID;
                risk.QOSImpactID = obj.QOSImpact == string.Empty ? (int?)null : _context.RiskImpacts.Single(I => I.RiskCriteria.RiskCriteria1 == obj.CostImpact && I.RiskImpactTypeID == (int)ImpactType.QOS).RiskImpactID;
                risk.CostCentre1ID = obj.CostCentre1 == string.Empty ? (int?)null : _context.CostCentres.Single(C => C.CostCentreName == obj.CostCentre1).CostCentreID;
                risk.CostCentre2ID = obj.CostCentre2 == string.Empty ? (int?)null : _context.CostCentres.Single(C => C.CostCentreName == obj.CostCentre2).CostCentreID;
                risk.AdjustedImpactCost = obj.AdjustedCostImpact == 0 ? (decimal?)null : obj.AdjustedCostImpact;
                risk.SeverityID = obj.Severity == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.Severity).SeverityID;
                risk.SeverityHumanID = obj.SeverityHuman == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.SeverityHuman).SeverityID;
                risk.SeverityEnvironmentID = obj.SeverityEnvironment == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.SeverityEnvironment).SeverityID;
                risk.CiticalLimitSignID=obj.LimitSign==string.Empty?(long?)null:_context.AT_RAGSigns.Single(S=>S.Sign==obj.LimitSign).SignID;
                risk.CriticalLimit = obj.CriticalLimit == 0 ? (decimal?)null : obj.CriticalLimit;
                risk.Score = obj.Score;

                risk.OperationalComplexityID = obj.OperationalComplexity == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.OperationalComplexity).AssessmentGuidelineID;
                risk.NusianceID = obj.Nusiance == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.Nusiance).AssessmentGuidelineID;
                risk.RegularityID = obj.Regularity == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.Regularity).AssessmentGuidelineID;
                risk.InterestedPartyID = obj.InterestedParties == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.InterestedParties).AssessmentGuidelineID;
                risk.LackInformationID = obj.LackInformation == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.LackInformation).AssessmentGuidelineID;
                risk.PolicyIssueID = obj.PolicyIssue == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.PolicyIssue).AssessmentGuidelineID;
                risk.RecordModeID = (int)obj.Mode;
                risk.RiskStatusID = (int)obj.RiskStatus;
                risk.SIR = obj.SIR == -1 ? (decimal?)null : obj.SIR;


                risk.ModifiedDate = DateTime.Now;
                risk.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.Risks.InsertOnSubmit(risk);
                _context.SubmitChanges();


                // generate automatic email notification for adding a new risk
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.RiskManagement;
                automail.KeyValue = risk.RiskId;
                automail.Action = "Add";

                //add the owner as a recipient
                automail.Recipients.Add(risk.OwnerID);


                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("The ID of the risk must be unique");
            }
            return result;
        }

        [WebMethod]
        public void updateRisk(string json)
        {
            string result = String.Empty;


            JavaScriptSerializer serializer = new JavaScriptSerializer();
            Risk obj = serializer.Deserialize<Risk>(json);

            var risk = _context.Risks.Where(RSK => RSK.RiskId == obj.RiskID).Select(RSK => RSK).SingleOrDefault();
            if (risk != null)
            {
                risk.RiskNo = obj.RiskNo;
                risk.RiskName = obj.RiskName;
                risk.RiskTypeID = _context.RiskTypes.Single(RSKTYP => RSKTYP.RiskType1 == obj.RiskType).RiskTypeID;
                risk.RiskModeID = _context.RiskModes.Single(RSKMOD => RSKMOD.RiskMode1 == obj.RiskMode).RiskModeID;
                risk.RiskCategoryID = _context.RiskCategories.Single(RSKCAT => RSKCAT.Category == obj.RiskCategory).RiskCategoryID;
                risk.Description = obj.Description == string.Empty ? null : obj.Description;
                risk.RegisterDate = obj.RegisterDate;
                risk.DueDate = obj.DueDate == null ? (DateTime?)null : Convert.ToDateTime(obj.DueDate);
                risk.AssessedDate = obj.AssessedDate == null ? (DateTime?)null : Convert.ToDateTime(obj.AssessedDate);
                risk.RiskProbabilityID = _context.RiskProbabilities.Single(P => P.RiskCriteria.RiskCriteria1 == obj.RiskProbability).RiskProbabilityId;
                
                risk.OwnerID = (from EMP in _context.Employees
                                where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                select EMP.EmployeeID).SingleOrDefault();
                
                risk.ProjectID = obj.ProjectName == string.Empty ? (int?)null : _context.ProjectInformations.Single(PROJ => PROJ.ProjectName == obj.ProjectName).ProjectId;
                risk.TimeImpactID = obj.TimeImpact == string.Empty ? (int?)null : _context.RiskImpacts.Single(I => I.RiskCriteria.RiskCriteria1 == obj.TimeImpact && I.RiskImpactTypeID == (int)ImpactType.Time).RiskImpactID;
                risk.CostImpactID = obj.CostImpact == string.Empty ? (int?)null : _context.RiskImpacts.Single(I => I.RiskCriteria.RiskCriteria1 == obj.CostImpact && I.RiskImpactTypeID == (int)ImpactType.Cost).RiskImpactID;
                risk.QOSImpactID = obj.QOSImpact == string.Empty ? (int?)null : _context.RiskImpacts.Single(I => I.RiskCriteria.RiskCriteria1 == obj.CostImpact && I.RiskImpactTypeID == (int)ImpactType.QOS).RiskImpactID;
                risk.CostCentre1ID = obj.CostCentre1 == string.Empty ? (int?)null : _context.CostCentres.Single(C => C.CostCentreName == obj.CostCentre1).CostCentreID;
                risk.CostCentre2ID = obj.CostCentre2 == string.Empty ? (int?)null : _context.CostCentres.Single(C => C.CostCentreName == obj.CostCentre2).CostCentreID;
                risk.AdjustedImpactCost = obj.AdjustedCostImpact == 0 ? (decimal?)null : obj.AdjustedCostImpact;
                risk.SeverityID = obj.Severity == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.Severity).SeverityID;
                risk.SeverityHumanID = obj.SeverityHuman == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.SeverityHuman).SeverityID;
                risk.SeverityEnvironmentID = obj.SeverityEnvironment == string.Empty ? (int?)null : _context.Severities.Single(SVR => SVR.Criteria == obj.SeverityEnvironment).SeverityID;
                risk.CiticalLimitSignID = obj.LimitSign == string.Empty ? (long?)null : _context.AT_RAGSigns.Single(S => S.Sign == obj.LimitSign).SignID;
                risk.CriticalLimit = obj.CriticalLimit == 0 ? (decimal?)null : obj.CriticalLimit;
                risk.Score = obj.Score;

                risk.OperationalComplexityID = obj.OperationalComplexity == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.OperationalComplexity).AssessmentGuidelineID;
                risk.NusianceID = obj.Nusiance == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.Nusiance).AssessmentGuidelineID;
                risk.RegularityID = obj.Regularity == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.Regularity).AssessmentGuidelineID;
                risk.InterestedPartyID = obj.InterestedParties == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.InterestedParties).AssessmentGuidelineID;
                risk.LackInformationID = obj.LackInformation == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.LackInformation).AssessmentGuidelineID;
                risk.PolicyIssueID = obj.PolicyIssue == string.Empty ? (int?)null : _context.ISO14001AssessmentGuidelines.Single(CAT => CAT.AssessmentGuideline == obj.PolicyIssue).AssessmentGuidelineID;
                risk.RiskStatusID = _context.RiskStatus.Single(RSKSTS=>RSKSTS.RiskStatus1==obj.RiskStatusString).StatusId;
                risk.SIR = obj.SIR == -1 ? (decimal?)null : obj.SIR;


                risk.ModifiedDate = DateTime.Now;
                risk.ModifiedBy = HttpContext.Current.User.Identity.Name;


                if (obj.ClosureDate != null)
                {
                    risk.ClosureDate = Convert.ToDateTime(obj.ClosureDate);

                    //set the status of the risk to close
                    risk.RiskStatusID = (int)RiskStatus.Closed;
                }
                else
                {

                    risk.ClosureDate = (DateTime?)null;
                }

                /*send the risk record to archive if the status is closed or cancelled
                 */ 
                switch ((RiskStatus)risk.RiskStatusID)
                {
                    case RiskStatus.Closed:
                    case RiskStatus.Cancelled:
                        risk.RecordModeID = (int)RecordMode.Archived;
                        break;
                    case RiskStatus.Open:
                    case RiskStatus.Active:
                    case RiskStatus.Dormant:
                        risk.RecordModeID = (int)RecordMode.Current;
                        break;
                }

                _context.SubmitChanges();


                // generate automatic email notification for adding a new risk
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.RiskManagement;
                automail.KeyValue = risk.RiskId;
                automail.Action = "Update";

                //add the owner as a recipient
                automail.Recipients.Add(risk.OwnerID);

                
                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Cannot find the related risk record");
            }
        }

        

        [WebMethod]
        public string loadRiskList()
        {
            //get all current risk records
            var risks = _context.Risks
            .Select(RSK => new Risk
            {
                RiskID=RSK.RiskId,
                RiskNo=RSK.RiskNo,
                RiskName=RSK.RiskName,
                RiskType=RSK.RiskType.RiskType1,
                RiskMode=RSK.RiskMode.RiskMode1,
                RiskCategory=RSK.RiskCategory.Category,
                RiskStatusString=RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description=RSK.Description==null?string.Empty:RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate=ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate=RSK.AssessedDate.HasValue==false?(DateTime?)null: ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate=RSK.DueDate.HasValue==false?(DateTime?)null: ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate=RSK.ClosureDate.HasValue==false?(DateTime?)null: ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability=RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact=RSK.TimeImpactID.HasValue==false?string.Empty:RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1=RSK.CostCentre1ID.HasValue==false?string.Empty:RSK.CostCentre.CostCentreName,
                CostCentre2=RSK.CostCentre2ID.HasValue==false?string.Empty:RSK.CostCentre1.CostCentreName,
                CriticalLimit=RSK.CriticalLimit.HasValue==false?0:Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign=RSK.CiticalLimitSignID.HasValue==false?string.Empty:RSK.AT_RAGSign.Sign,
                AdjustedCostImpact=RSK.AdjustedImpactCost.HasValue==false?0:Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment=RSK.SeverityEnvironmentID.HasValue==false?string.Empty:RSK.Severity1.Criteria,
                SeverityHuman=RSK.SeverityHumanID.HasValue==false?string.Empty:RSK.Severity2.Criteria,
                Severity=RSK.SeverityID.HasValue==false?string.Empty:RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity=RSK.RegularityID.HasValue==false?string.Empty:RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties=RSK.InterestedPartyID.HasValue==false?string.Empty:RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance=RSK.NusianceID.HasValue==false?string.Empty:RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation=RSK.LackInformationID.HasValue==false?string.Empty:RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score=RSK.Score,
                SIR=RSK.SIR.HasValue==false?0:Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }

        [WebMethod]
        public string filterRiskByType(string type)
        {
            //get all current risk records
            var risks = _context.Risks
            .Where(RSKTYP=>RSKTYP.RiskType.RiskType1==type)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }

        [WebMethod]
        public string filterRiskByMode(string mode)
        {
            //get all current risk records
            var risks = _context.Risks
            .Where(RSKMOD => RSKMOD.RiskMode.RiskMode1 == mode)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }

        [WebMethod]
        public string filterRiskByCategory(string category)
        {
            //get all current risk records
            var risks = _context.Risks
            .Where(RSKCAT => RSKCAT.RiskCategory.Category == category)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }

        [WebMethod]
        public string filterRiskByStatus(string status)
        {
            //get all current risk records
            var risks = _context.Risks
            .Where(RSKSTS => RSKSTS.RiskStatus.RiskStatus1 == status)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }


        [WebMethod]
        public string filterRiskByRecordMode(string mode)
        {
            //get all current risk records
            var risks = _context.Risks
            .Where(RM => RM.RecordMode.RecordMode1 == mode)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }

        [WebMethod]
        public string filterRiskByRegisterDate(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var risks = _context.Risks
            .Where(RDT => RDT.RegisterDate >= obj.StartDate && RDT.RegisterDate <= obj.EndDate)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }

        [WebMethod]
        public string filterRiskByClosureDate(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var risks = _context.Risks
            .Where(CDT => CDT.ClosureDate >= obj.StartDate && CDT.ClosureDate <= obj.EndDate)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }


        [WebMethod]
        public string filterRiskByDueDate(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var risks = _context.Risks
            .Where(DDT => DDT.DueDate >= obj.StartDate && DDT.DueDate <= obj.EndDate)
            .Select(RSK => new Risk
            {
                RiskID = RSK.RiskId,
                RiskNo = RSK.RiskNo,
                RiskName = RSK.RiskName,
                RiskType = RSK.RiskType.RiskType1,
                RiskMode = RSK.RiskMode.RiskMode1,
                RiskCategory = RSK.RiskCategory.Category,
                RiskStatusString = RSK.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Description == null ? string.Empty : RSK.Description,
                ProjectName = RSK.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.RegisterDate),
                AssessedDate = RSK.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.AssessedDate)),
                DueDate = RSK.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.DueDate)),
                ClosureDate = RSK.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.ClosureDate)),
                RiskProbability = RSK.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.TimeImpactID.HasValue == false ? string.Empty : RSK.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.QOSImpactID.HasValue == false ? string.Empty : RSK.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.CostImpactID.HasValue == false ? string.Empty : RSK.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.CostCentre1ID.HasValue == false ? string.Empty : RSK.CostCentre.CostCentreName,
                CostCentre2 = RSK.CostCentre2ID.HasValue == false ? string.Empty : RSK.CostCentre1.CostCentreName,
                CriticalLimit = RSK.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.CriticalLimit),
                LimitSign = RSK.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.AdjustedImpactCost),
                SeverityEnvironment = RSK.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Severity1.Criteria,
                SeverityHuman = RSK.SeverityHumanID.HasValue == false ? string.Empty : RSK.Severity2.Criteria,
                Severity = RSK.SeverityID.HasValue == false ? string.Empty : RSK.Severity.Criteria,
                OperationalComplexity = RSK.OperationalComplexityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.PolicyIssueID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.RegularityID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.InterestedPartyID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.NusianceID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.LackInformationID.HasValue == false ? string.Empty : RSK.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Score,
                SIR = RSK.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.SIR),
                Mode = ((RecordMode)RSK.RecordModeID),
                Actions = RSK.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }

        [WebMethod]
        public string loadMitigationTypes()
        {
            var actiontype = _context.RiskMitigationTypes.Select(MTGTYP => new MitigationType
            {
                TypeID = MTGTYP.MitigationTypeID,
                Type = MTGTYP.MitigationType,
                Description = MTGTYP.Description == null ? string.Empty : MTGTYP.Description

            }).ToList();

            var xml = new XmlSerializer(typeof(List<MitigationType>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, actiontype);

            return str.ToString();
        }

        [WebMethod]
        public void createNewMitigationType(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            MitigationType obj = jsonserializer.Deserialize<MitigationType>(json);

            var type = _context.RiskMitigationTypes.Where(TYP => TYP.MitigationType == obj.Type).Select(TYP => TYP).SingleOrDefault();
            if (type == null)
            {
                type = new RiskMitigationType();
                type.MitigationType = obj.Type;
                type.Description = obj.Description == string.Empty ? null : obj.Description;
                type.ModifiedDate = DateTime.Now;
                type.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.RiskMitigationTypes.InsertOnSubmit(type);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("The name of the mitigation type already exists");
            }
        }

        [WebMethod]
        public string updateMitigationAction(string json)
        {
            string result = string.Empty;

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            MitigationAction obj = jsonserializer.Deserialize<MitigationAction>(json);

            var action = _context.RiskMitigationActions.Where(ACT => ACT.MitigationActionID == obj.ActionID).Select(ACT => ACT).SingleOrDefault();
            if (action != null)
            {
                action.MitigationTypeID = obj.MitigationType == string.Empty ? (int?)null : _context.RiskMitigationTypes.Single(MTYP => MTYP.MitigationType == obj.MitigationType).MitigationTypeID;
                action.PotentialImpact = obj.PotentialImpact == string.Empty ? null : obj.PotentialImpact;
                action.Countermeasures = obj.Countermeasures == string.Empty ? null : obj.Countermeasures;
                action.TargetCloseDate = obj.TargetCloseDate;
                action.ActualCloseDate = obj.ActualCloseDate == null ? (DateTime?)null : Convert.ToDateTime(obj.ActualCloseDate);
                action.Actions = obj.Actions == string.Empty ? null : obj.Actions;
                action.ActioneeID = (from EMP in _context.Employees
                                     where EMP.FirstName == obj.Actionee.Substring(obj.Actionee.LastIndexOf(".") + 1, obj.Actionee.IndexOf(" ") - 3) &&
                                     EMP.LastName == obj.Actionee.Substring(obj.Actionee.IndexOf(" ") + 1)
                                     select EMP.EmployeeID).SingleOrDefault();
                action.IsClosed = obj.IsClosed;
                action.ModifiedDate = DateTime.Now;
                action.ModifiedBy = HttpContext.Current.User.Identity.Name;

                _context.SubmitChanges();

                // generate automatic email notification for adding a new risk mitigation action
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.RiskMitigationAction;
                automail.KeyValue = action.MitigationActionID;
                automail.Action = "Update";

                //add the actionee as a recipient
                automail.Recipients.Add(action.ActioneeID);


                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }


            }
            else
            {
                throw new Exception("Cannot find the related risk mitigation action record");
            }

            return result;
        }

        [WebMethod]
        public string createNewMitigationAction(string json,string riskno)
        {
            string result = string.Empty;

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            MitigationAction obj = jsonserializer.Deserialize<MitigationAction>(json);

            var risk = _context.Risks.Where(RSK => RSK.RiskNo == riskno).Select(RSK => RSK).SingleOrDefault();
            if (risk != null)
            {

                RiskMitigationAction action = new RiskMitigationAction();
                action.MitigationTypeID = obj.MitigationType == string.Empty ? (int?)null : _context.RiskMitigationTypes.Single(MTYP => MTYP.MitigationType == obj.MitigationType).MitigationTypeID;
                action.PotentialImpact = obj.PotentialImpact == string.Empty ? null : obj.PotentialImpact;
                action.Countermeasures = obj.Countermeasures == string.Empty ? null : obj.Countermeasures;
                action.TargetCloseDate = obj.TargetCloseDate;
                action.Actions = obj.Actions == string.Empty ? null : obj.Actions;
                action.ActioneeID = (from EMP in _context.Employees
                                     where EMP.FirstName == obj.Actionee.Substring(obj.Actionee.LastIndexOf(".") + 1, obj.Actionee.IndexOf(" ") - 3) &&
                                     EMP.LastName == obj.Actionee.Substring(obj.Actionee.IndexOf(" ") + 1)
                                     select EMP.EmployeeID).SingleOrDefault();
                action.ModifiedDate = DateTime.Now;
                action.ModifiedBy = HttpContext.Current.User.Identity.Name;

                risk.RiskMitigationActions.Add(action);
                _context.SubmitChanges();

                // generate automatic email notification for adding a new risk mitigation action
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.RiskMitigationAction;
                automail.KeyValue = action.MitigationActionID;
                automail.Action = "Add";

                //add the actionee as a recipient
                automail.Recipients.Add(action.ActioneeID);


                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }
            }
            else
            {
                throw new Exception("Cannot find the related risk record");
            }

            return result;
        }

        [WebMethod]
        public void removeMitigationAction(int actionID)
        {
            var action = _context.RiskMitigationActions.Where(ACT => ACT.MitigationActionID == actionID).Select(ACT => ACT).SingleOrDefault();
            if (action != null)
            {
                _context.RiskMitigationActions.DeleteOnSubmit(action);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related risk mitigation action record");
            }
        }

        [WebMethod]
        public string filterRiskMitigationActionsByTargetCloseDate(string json)
        {
            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var risks = _context.RiskMitigationActions.Where(RSK => RSK.TargetCloseDate >= obj.StartDate && RSK.TargetCloseDate <= obj.EndDate)
            .Select(RSK => new Risk
            {
                
                RiskID = RSK.Risk.RiskId,
                RiskNo = RSK.Risk.RiskNo,
                RiskName = RSK.Risk.RiskName,
                RiskType = RSK.Risk.RiskType.RiskType1,
                RiskMode = RSK.Risk.RiskMode.RiskMode1,
                RiskCategory = RSK.Risk.RiskCategory.Category,
                RiskStatusString = RSK.Risk.RiskStatus.RiskStatus1,
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == RSK.Risk.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Description = RSK.Risk.Description == null ? string.Empty : RSK.Risk.Description,
                ProjectName = RSK.Risk.ProjectID.HasValue == false ? string.Empty : _context.ProjectInformations.Single(PRJ => PRJ.ProjectId == RSK.Risk.ProjectID).ProjectName,
                RegisterDate = ConvertToLocalTime(RSK.Risk.RegisterDate),
                AssessedDate = RSK.Risk.AssessedDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.Risk.AssessedDate)),
                DueDate = RSK.Risk.DueDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.Risk.DueDate)),
                ClosureDate = RSK.Risk.ClosureDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(RSK.Risk.ClosureDate)),
                RiskProbability = RSK.Risk.RiskProbability.RiskCriteria.RiskCriteria1,
                TimeImpact = RSK.Risk.TimeImpactID.HasValue == false ? string.Empty : RSK.Risk.RiskImpact2.RiskCriteria.RiskCriteria1,
                QOSImpact = RSK.Risk.QOSImpactID.HasValue == false ? string.Empty : RSK.Risk.RiskImpact1.RiskCriteria.RiskCriteria1,
                CostImpact = RSK.Risk.CostImpactID.HasValue == false ? string.Empty : RSK.Risk.RiskImpact.RiskCriteria.RiskCriteria1,
                CostCentre1 = RSK.Risk.CostCentre1ID.HasValue == false ? string.Empty : RSK.Risk.CostCentre.CostCentreName,
                CostCentre2 = RSK.Risk.CostCentre2ID.HasValue == false ? string.Empty : RSK.Risk.CostCentre1.CostCentreName,
                CriticalLimit = RSK.Risk.CriticalLimit.HasValue == false ? 0 : Convert.ToDecimal(RSK.Risk.CriticalLimit),
                LimitSign = RSK.Risk.CiticalLimitSignID.HasValue == false ? string.Empty : RSK.Risk.AT_RAGSign.Sign,
                AdjustedCostImpact = RSK.Risk.AdjustedImpactCost.HasValue == false ? 0 : Convert.ToDecimal(RSK.Risk.AdjustedImpactCost),
                SeverityEnvironment = RSK.Risk.SeverityEnvironmentID.HasValue == false ? string.Empty : RSK.Risk.Severity1.Criteria,
                SeverityHuman = RSK.Risk.SeverityHumanID.HasValue == false ? string.Empty : RSK.Risk.Severity2.Criteria,
                Severity = RSK.Risk.SeverityID.HasValue == false ? string.Empty : RSK.Risk.Severity.Criteria,
                OperationalComplexity = RSK.Risk.OperationalComplexityID.HasValue == false ? string.Empty : RSK.Risk.ISO14001AssessmentGuideline3.AssessmentGuideline,
                PolicyIssue = RSK.Risk.PolicyIssueID.HasValue == false ? string.Empty : RSK.Risk.ISO14001AssessmentGuideline4.AssessmentGuideline,
                Regularity = RSK.Risk.RegularityID.HasValue == false ? string.Empty : RSK.Risk.ISO14001AssessmentGuideline5.AssessmentGuideline,
                InterestedParties = RSK.Risk.InterestedPartyID.HasValue == false ? string.Empty : RSK.Risk.ISO14001AssessmentGuideline.AssessmentGuideline,
                Nusiance = RSK.Risk.NusianceID.HasValue == false ? string.Empty : RSK.Risk.ISO14001AssessmentGuideline2.AssessmentGuideline,
                LackInformation = RSK.Risk.LackInformationID.HasValue == false ? string.Empty : RSK.Risk.ISO14001AssessmentGuideline1.AssessmentGuideline,
                Score = RSK.Risk.Score,
                SIR = RSK.Risk.SIR.HasValue == false ? 0 : Convert.ToDecimal(RSK.Risk.SIR),
                Mode = ((RecordMode)RSK.Risk.RecordModeID),
                Actions = RSK.Risk.RiskMitigationActions.Select(ACT => new MitigationAction
                {
                    ActionID = ACT.MitigationActionID,
                    MitigationType = ACT.MitigationTypeID.HasValue == false ? string.Empty : ACT.RiskMitigationType.MitigationType,
                    PotentialImpact = ACT.PotentialImpact == null ? string.Empty : ACT.PotentialImpact,
                    Countermeasures = ACT.Countermeasures == null ? string.Empty : ACT.Countermeasures,
                    Actions = ACT.Actions == null ? string.Empty : ACT.Actions,
                    TargetCloseDate = ConvertToLocalTime(ACT.TargetCloseDate),
                    ActualCloseDate = ACT.ActualCloseDate.HasValue == false ? (DateTime?)null : ConvertToLocalTime(Convert.ToDateTime(ACT.ActualCloseDate)),
                    Actionee = (from T in _context.Titles
                                join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                                from g in empgroup
                                where g.EmployeeID == ACT.ActioneeID
                                select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                    IsClosed = ACT.IsClosed
                }).ToList()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<Risk>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, risks);

            return str.ToString();
        }
        #endregion

        #region QualityRecords
        
        [WebMethod]
        public string getLastQualityRecordID()
        {
            string recordID = null;

            if (_context.Records.ToList().Count > 0)
            {
                int maxId = _context.Records.Max(i => i.RecordID);
                recordID = _context.Records.Single(QR => QR.RecordID == maxId).RecordNo;
            }
            return recordID == null ? string.Empty : recordID;
        }

        [WebMethod]
        public string[] loadQualityRecordStatus()
        {
            var status = (from STS in _context.QualityRecordStatus
                          select STS.RecordStatus
                        ).ToArray();

            return status;
        }

        [WebMethod]
        public string loadQualityRecordList()
        {

            var records = _context.Records
            .Where(QR=>QR.RecordModeID==(int)RecordMode.Current)
            .Select(QR => new QualityRecord
            {
                RecordID = QR.RecordID,
                RecordNo = QR.RecordNo,
                Title = QR.Title,
                Department = QR.OrganizationUnit.UnitName,
                IssueDate = ConvertToLocalTime(QR.IssueDate),
                ReviewDate = QR.ReviewDate != null ? ConvertToLocalTime(QR.ReviewDate.Value) : QR.ReviewDate,
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == QR.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == QR.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                RecordFileURL = QR.RecordFileURL == null ? string.Empty : QR.RecordFileURL,
                RecordFileName = QR.RecordFileName == null ? string.Empty : QR.RecordFileName,
                Remarks = QR.Remarks == null ? string.Empty : QR.Remarks,
                ReviewDuration = QR.ReviewDuration,
                ReviewPeriod = QR.Period1.Period1,
                RetentionDuration = QR.RetentionDuration,
                RetentionPeriod = QR.Period.Period1,
                ModeString = QR.RecordMode.RecordMode1,
                RecordFileType=QR.DocumentFileType.FileType,
                RecordStatusString = QR.QualityRecordStatus.RecordStatus,
                ModuleName = Modules.QualityRecords.ToString()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<QualityRecord>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, records);

            return str.ToString();
        }

        [WebMethod]
        public string filterQualityRecordByName(string title)
        {

            var records = _context.Records
            .Where(QR => QR.Title.StartsWith(title) && QR.RecordModeID==(int)RecordMode.Current)
            .Select(QR => new QualityRecord
            {
                RecordID = QR.RecordID,
                RecordNo = QR.RecordNo,
                Title = QR.Title,
                Department = QR.OrganizationUnit.UnitName,
                IssueDate = ConvertToLocalTime(QR.IssueDate),
                ReviewDate = QR.ReviewDate != null ? ConvertToLocalTime(QR.ReviewDate.Value) : QR.ReviewDate,
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == QR.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == QR.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                RecordFileURL = QR.RecordFileURL == null ? string.Empty : QR.RecordFileURL,
                RecordFileName = QR.RecordFileName == null ? string.Empty : QR.RecordFileName,
                Remarks = QR.Remarks == null ? string.Empty : QR.Remarks,
                ReviewDuration = QR.ReviewDuration,
                ReviewPeriod = QR.Period1.Period1,
                RetentionDuration = QR.RetentionDuration,
                RetentionPeriod = QR.Period.Period1,
                ModeString = QR.RecordMode.RecordMode1,
                RecordFileType = QR.DocumentFileType.FileType,
                RecordStatusString = QR.QualityRecordStatus.RecordStatus,
                ModuleName = Modules.QualityRecords.ToString()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<QualityRecord>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, records);

            return str.ToString();
        }

        [WebMethod]
        public string filterQualityRecordByOrganization(string unit)
        {

            var records = _context.Records
            .Where(QR => QR.OrganizationUnit.UnitName==unit && QR.RecordModeID==(int)RecordMode.Current)
            .Select(QR => new QualityRecord
            {
                RecordID = QR.RecordID,
                RecordNo = QR.RecordNo,
                Title = QR.Title,
                Department = QR.OrganizationUnit.UnitName,
                IssueDate = ConvertToLocalTime(QR.IssueDate),
                ReviewDate = QR.ReviewDate != null ? ConvertToLocalTime(QR.ReviewDate.Value) : QR.ReviewDate,
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == QR.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == QR.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                RecordFileURL = QR.RecordFileURL == null ? string.Empty : QR.RecordFileURL,
                RecordFileName = QR.RecordFileName == null ? string.Empty : QR.RecordFileName,
                Remarks = QR.Remarks == null ? string.Empty : QR.Remarks,
                ReviewDuration = QR.ReviewDuration,
                ReviewPeriod = QR.Period1.Period1,
                RetentionDuration = QR.RetentionDuration,
                RetentionPeriod = QR.Period.Period1,
                ModeString = QR.RecordMode.RecordMode1,
                RecordFileType = QR.DocumentFileType.FileType,
                RecordStatusString = QR.QualityRecordStatus.RecordStatus,
                ModuleName = Modules.QualityRecords.ToString()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<QualityRecord>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, records);

            return str.ToString();
        }

        [WebMethod]
        public string filterQualityRecordByMode(string mode)
        {

            var records = _context.Records
            .Where(QR => QR.RecordMode.RecordMode1==mode)
            .Select(QR => new QualityRecord
            {
                RecordID = QR.RecordID,
                RecordNo = QR.RecordNo,
                Title = QR.Title,
                Department = QR.OrganizationUnit.UnitName,
                IssueDate = ConvertToLocalTime(QR.IssueDate),
                ReviewDate = QR.ReviewDate != null ? ConvertToLocalTime(QR.ReviewDate.Value) : QR.ReviewDate,
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == QR.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == QR.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                RecordFileURL = QR.RecordFileURL == null ? string.Empty : QR.RecordFileURL,
                RecordFileName = QR.RecordFileName == null ? string.Empty : QR.RecordFileName,
                Remarks = QR.Remarks == null ? string.Empty : QR.Remarks,
                ReviewDuration = QR.ReviewDuration,
                ReviewPeriod = QR.Period1.Period1,
                RetentionDuration = QR.RetentionDuration,
                RetentionPeriod = QR.Period.Period1,
                ModeString = QR.RecordMode.RecordMode1,
                RecordFileType = QR.DocumentFileType.FileType,
                RecordStatusString = QR.QualityRecordStatus.RecordStatus,
                ModuleName = Modules.QualityRecords.ToString()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<QualityRecord>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, records);

            return str.ToString();
        }

        [WebMethod]
        public string filterQualityRecordByStatus(string status)
        {

            var records = _context.Records
            .Where(QR => QR.QualityRecordStatus.RecordStatus == status && QR.RecordModeID==(int)RecordMode.Current)
            .Select(QR => new QualityRecord
            {
                RecordID = QR.RecordID,
                RecordNo = QR.RecordNo,
                Title = QR.Title,
                Department = QR.OrganizationUnit.UnitName,
                IssueDate = ConvertToLocalTime(QR.IssueDate),
                ReviewDate = QR.ReviewDate != null ? ConvertToLocalTime(QR.ReviewDate.Value) : QR.ReviewDate,
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == QR.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == QR.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                RecordFileURL = QR.RecordFileURL == null ? string.Empty : QR.RecordFileURL,
                RecordFileName = QR.RecordFileName == null ? string.Empty : QR.RecordFileName,
                Remarks = QR.Remarks == null ? string.Empty : QR.Remarks,
                ReviewDuration = QR.ReviewDuration,
                ReviewPeriod = QR.Period1.Period1,
                RetentionDuration = QR.RetentionDuration,
                RetentionPeriod = QR.Period.Period1,
                ModeString = QR.RecordMode.RecordMode1,
                RecordFileType = QR.DocumentFileType.FileType,
                RecordStatusString = QR.QualityRecordStatus.RecordStatus,
                ModuleName = Modules.QualityRecords.ToString()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<QualityRecord>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, records);

            return str.ToString();
        }

        [WebMethod]
        public string filterQualityRecordByIssueDate(string json)
        {

            JavaScriptSerializer jsonserializer = new JavaScriptSerializer();
            DateParam obj = jsonserializer.Deserialize<DateParam>(json);

            var records = _context.Records
            .Where(QR => QR.IssueDate>=obj.StartDate && QR.IssueDate<=obj.EndDate)
            .Select(QR => new QualityRecord
            {
                RecordID = QR.RecordID,
                RecordNo = QR.RecordNo,
                Title = QR.Title,
                Department = QR.OrganizationUnit.UnitName,
                IssueDate = ConvertToLocalTime(QR.IssueDate),
                ReviewDate = QR.ReviewDate != null ? ConvertToLocalTime(QR.ReviewDate.Value) : QR.ReviewDate,
                Originator = (from T in _context.Titles
                              join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                              from g in empgroup
                              where g.EmployeeID == QR.OriginatorID
                              select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                Owner = (from T in _context.Titles
                         join EMP in _context.Employees on T.TitleID equals EMP.TitleID into empgroup
                         from g in empgroup
                         where g.EmployeeID == QR.OwnerID
                         select g.Title.Title1.Trim() + "." + g.FirstName + " " + g.LastName).SingleOrDefault(),
                RecordFileURL = QR.RecordFileURL == null ? string.Empty : QR.RecordFileURL,
                RecordFileName = QR.RecordFileName == null ? string.Empty : QR.RecordFileName,
                Remarks = QR.Remarks == null ? string.Empty : QR.Remarks,
                ReviewDuration = QR.ReviewDuration,
                ReviewPeriod = QR.Period1.Period1,
                RetentionDuration = QR.RetentionDuration,
                RetentionPeriod = QR.Period.Period1,
                ModeString = QR.RecordMode.RecordMode1,
                RecordFileType = QR.DocumentFileType.FileType,
                RecordStatusString = QR.QualityRecordStatus.RecordStatus,
                ModuleName=Modules.QualityRecords.ToString()
            }).ToList();

            var xml = new XmlSerializer(typeof(List<QualityRecord>));

            StringWriter str = new StringWriter();
            xml.Serialize(str, records);

            return str.ToString();
        }

        [WebMethod]
        public string createNewQualityRecord(string json)
        {
            string result = String.Empty;


            JavaScriptSerializer serializer = new JavaScriptSerializer();
            QualityRecord obj = serializer.Deserialize<QualityRecord>(json);

            var record = _context.Records.Where(QR => QR.RecordNo == obj.RecordNo).Select(QR => QR).SingleOrDefault();
            if (record == null)
            {
                record = _context.Records.Where(QR => QR.Title == obj.Title)
                    .Select(QR => QR).SingleOrDefault();

                if (record == null)
                {
                    record = new Record();
                    record.RecordNo = obj.RecordNo;
                    record.Title = obj.Title;
                    record.ReviewDuration = obj.ReviewDuration;
                    record.ReviewPeriodID = _context.Periods.Single(PRD => PRD.Period1 == obj.ReviewPeriod).PeriodID;
                    record.RetentionDuration = obj.RetentionDuration;
                    record.RetentionPeriodID = _context.Periods.Single(PRD => PRD.Period1 == obj.RetentionPeriod).PeriodID;
                    record.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
                    record.RecordStatusID = (int)obj.RecordStatus;
                    record.DepartmentID = _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.Department).UnitID;
                    record.RecordModeID = (int)obj.Mode;
                    record.OriginatorID = (from EMP in _context.Employees
                                         where EMP.FirstName == obj.Originator.Substring(obj.Originator.LastIndexOf(".") + 1, obj.Originator.IndexOf(" ") - 3) &&
                                         EMP.LastName == obj.Originator.Substring(obj.Originator.IndexOf(" ") + 1)
                                         select EMP.EmployeeID).SingleOrDefault();

                    record.OwnerID = (from EMP in _context.Employees
                                      where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                    EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                    select EMP.EmployeeID).SingleOrDefault();
                    record.RecordFileURL = obj.RecordFileURL == string.Empty ? null : obj.RecordFileURL;
                    record.IssueDate = obj.IssueDate;
                    record.RecordFileTypeID = _context.DocumentFileTypes.Single(DF => DF.FileType == obj.RecordFileType).DocumentFileTypeId;
                    record.ModifiedDate = DateTime.Now;
                    record.ModifiedBy = HttpContext.Current.User.Identity.Name;
                   
                    if (obj.RecordFile != string.Empty)
                    {
                        try
                        {
                            record.RecordFile = File.ReadAllBytes(obj.RecordFile);
                            record.RecordFileName = obj.RecordFileName;
                        }
                        finally
                        {
                            File.Delete(obj.RecordFile);
                        }
                    }


                    
                    _context.Records.InsertOnSubmit(record);
                    _context.SubmitChanges();


                    // generate automatic email notification for adding a new quality record
                    EmailConfiguration automail = new EmailConfiguration();
                    automail.Module = Modules.QualityRecords;
                    automail.KeyValue = record.RecordID;
                    automail.Action = "Add";

                    //add both the originator and the owner as a recipient
                    automail.Recipients.Add(record.OriginatorID);
                    automail.Recipients.Add(record.OwnerID);


                    try
                    {
                        bool isGenerated = automail.GenerateEmail();

                        if (isGenerated == true)
                        {
                            result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                        }
                        else
                        {
                            result = "Operation has been committed sucessfully";
                        }
                    }
                    catch (Exception ex)
                    {
                        result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                        result += "\n\n" + ex.Message;
                    }
                }
                else
                {
                    throw new Exception("The name of the quality record already exists");
                }
            }
            else
            {
                throw new Exception("The ID of the quality record must be unique");
            }
            return result;
        }


        [WebMethod]
        public string updateQualityRecord(string json)
        {
            string result = String.Empty;


            JavaScriptSerializer serializer = new JavaScriptSerializer();
            QualityRecord obj = serializer.Deserialize<QualityRecord>(json);

            var record = _context.Records.Where(QR => QR.RecordID == obj.RecordID).Select(QR => QR).SingleOrDefault();
            if (record != null)
            {
                record.RecordNo = obj.RecordNo;
                record.Title = obj.Title;
                record.ReviewDuration = obj.ReviewDuration;
                record.ReviewPeriodID = _context.Periods.Single(PRD => PRD.Period1 == obj.ReviewPeriod).PeriodID;
                record.RetentionDuration = obj.RetentionDuration;
                record.RetentionPeriodID = _context.Periods.Single(PRD => PRD.Period1 == obj.RetentionPeriod).PeriodID;
                record.Remarks = obj.Remarks == string.Empty ? null : obj.Remarks;
                record.RecordStatusID = _context.QualityRecordStatus.Single(STS => STS.RecordStatus == obj.RecordStatusString).RecordStatusID;
                record.DepartmentID = _context.OrganizationUnits.Single(ORG => ORG.UnitName == obj.Department).UnitID;
                record.OriginatorID = (from EMP in _context.Employees
                                       where EMP.FirstName == obj.Originator.Substring(obj.Originator.LastIndexOf(".") + 1, obj.Originator.IndexOf(" ") - 3) &&
                                       EMP.LastName == obj.Originator.Substring(obj.Originator.IndexOf(" ") + 1)
                                       select EMP.EmployeeID).SingleOrDefault();

                record.OwnerID = (from EMP in _context.Employees
                                  where EMP.FirstName == obj.Owner.Substring(obj.Owner.LastIndexOf(".") + 1, obj.Owner.IndexOf(" ") - 3) &&
                                EMP.LastName == obj.Owner.Substring(obj.Owner.IndexOf(" ") + 1)
                                  select EMP.EmployeeID).SingleOrDefault();
                record.RecordFileURL = obj.RecordFileURL == string.Empty ? null : obj.RecordFileURL;
                record.IssueDate = obj.IssueDate;
                record.ReviewDate = obj.ReviewDate;
                record.RecordFileTypeID = _context.DocumentFileTypes.Single(DF => DF.FileType == obj.RecordFileType).DocumentFileTypeId;
                record.ModifiedDate = DateTime.Now;
                record.ModifiedBy = HttpContext.Current.User.Identity.Name;

                //update the record's mode according to the status of the quality record
                switch ((QualityRecordStatus)record.RecordStatusID)
                {
                    case QualityRecordStatus.Cancelled:
                    case QualityRecordStatus.Disposed:
                        record.RecordModeID = (int)RecordMode.Archived;
                        break;
                    case QualityRecordStatus.Retained:
                        record.RecordModeID = (int)RecordMode.Current;
                        break;
                }

                if (obj.RecordFile != string.Empty)
                {
                    try
                    {
                        record.RecordFile = File.ReadAllBytes(obj.RecordFile);
                        record.RecordFileName = obj.RecordFileName;
                    }
                    finally
                    {
                        File.Delete(obj.RecordFile);
                    }
                }

                _context.SubmitChanges();


                // generate automatic email notification for adding a new quality record
                EmailConfiguration automail = new EmailConfiguration();
                automail.Module = Modules.QualityRecords;
                automail.KeyValue = record.RecordID;
                automail.Action = "Update";

                //add both the originator and the owner as a recipient
                automail.Recipients.Add(record.OriginatorID);
                automail.Recipients.Add(record.OwnerID);


                try
                {
                    bool isGenerated = automail.GenerateEmail();

                    if (isGenerated == true)
                    {
                        result = "Operation has been committed sucessfully, An auto generated email has been sent to the related employees";
                    }
                    else
                    {
                        result = "Operation has been committed sucessfully";
                    }
                }
                catch (Exception ex)
                {
                    result = "The operation has been committed successfully. However, the following message was thrown when generating the email for recipients: ";
                    result += "\n\n" + ex.Message;
                }

            }
            else
            {
                throw new Exception("Cannot find the related quality record file");
            }

            return result;
        }

        [WebMethod]
        public void removeQualityRecord(int recordID)
        {
            var record = _context.Records.Where(QR => QR.RecordID == recordID).Select(QR => QR).SingleOrDefault();
            if (record != null)
            {
                _context.Records.DeleteOnSubmit(record);
                _context.SubmitChanges();
            }
            else
            {
                throw new Exception("Cannot find the related Quality record file");
            }
        }



        #endregion

        #region TimeZone
        [WebMethod(EnableSession = true)]
        public DateTime ConvertToUTC(DateTime inputDate)
        {
            string localTimeZone = HttpContext.Current.Session["CurrentTimeZone"].ToString(); //Session["CurrentTimeZone"] != null ? Session["CurrentTimeZone"].ToString() : "";

            TimeZoneInfo timeZoneInfoPST = TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time");
            TimeZoneInfo timeZoneInfoLocal = TimeZoneInfo.FindSystemTimeZoneById(localTimeZone);

            //return TimeZoneInfo.ConvertTimeBySystemTimeZoneId(inputDate, timeZoneInfoLocal.Id, timeZoneInfoPST.Id);
            //DateTime newDate = TimeZoneInfo.ConvertTime(inputDate, timeZoneInfoPST);

            //DateTime newDate = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(inputDate, timeZoneInfoLocal.Id, timeZoneInfoPST.Id);


            //var info = timeZoneInfoLocal;//TimeZoneInfo.FindSystemTimeZoneById("Tokyo Standard Time");

            ////DateTimeOffset localServerTime = DateTimeOffset.Now;

            //DateTimeOffset usersTime = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(inputDate, info.Id);

            //DateTimeOffset utc = usersTime.ToUniversalTime();

            //DateTime newDate = TimeZoneInfo.ConvertTimeToUtc(inputDate, timeZoneInfoLocal);

            DateTime usersTime = TimeZoneInfo.ConvertTime(inputDate, timeZoneInfoLocal);

            DateTime utc = usersTime.ToUniversalTime();
            ////DateTime toUTC = TimeZoneInfo.ConvertTimeToUtc(inputDate, timeZoneInfoLocal);

            DateTime newDate = TimeZoneInfo.ConvertTimeFromUtc(utc, timeZoneInfoPST);

            //DateTime date = TimeZoneInfo.ConvertTimeToUtc(inputDate, timeZoneInfoLocal);


            //DateTime userTime = DateTime.SpecifyKind(inputDate, DateTimeKind.Unspecified);
            //TimeZoneInfo UserTimeZone = TimeZoneInfo.FindSystemTimeZoneById(localTimeZone);
            //TimeZoneInfo TargetTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time");
            //DateTime newTime = TimeZoneInfo.ConvertTime(userTime, UserTimeZone, TargetTimeZone);

            return newDate;
        }

        [WebMethod(EnableSession = true)]
        public DateTime ConvertToLocalTime(DateTime inputDate)
        {
            //string localTimeZone = Session["CurrentTimeZone"].ToString(); //!= null ? Session["CurrentTimeZone"].ToString() : "";

            TimeZone zone = TimeZone.CurrentTimeZone;
            string localTimeZone = QMSRS.Utilities.WebConfigurationManager.GetTimeZone();//zone.StandardName;

            TimeZoneInfo timeZoneInfoPST = TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time");
            TimeZoneInfo timeZoneInfoLocal = TimeZoneInfo.FindSystemTimeZoneById(localTimeZone);

            DateTime toUTC = TimeZoneInfo.ConvertTimeToUtc(inputDate, timeZoneInfoPST);
            DateTime newDate = TimeZoneInfo.ConvertTimeFromUtc(toUTC, timeZoneInfoLocal);
            return newDate;
        }
        #endregion
    }

}
