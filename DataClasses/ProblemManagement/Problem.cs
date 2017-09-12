using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Linq;
using System.Collections.Generic;
using System.IO;
using System.Web.Script.Serialization;
namespace QMSRSTools
{
    public enum ProblemStatus
    {
        Open = 1,
        Closed = 2,
        Cancelled = 3,
        Pending = 4
    }

    [XmlType(TypeName = "Problem")]
    public class Problem
    {
        private long _problemID;
        
        private string _problemtype;
        private string _affectedpartytype;
        private string _affecteddepartment;
        private string _affecteddocument;
        private string _externalparty;
        private string _caseno;
        private string _title;
        private string _details;
        private string _originator;
        private string _owner;
        private string _executive;
        private string _remarks;
        private string _reportdepartment;
        private string _problemrelateddepartment;
        private string _severity;
        private string _problemstatusstr;
        private string _xmlactions;
        private string _xmlsubcategories;
        private string _modulename;
        private string _modestring;
        private string _jsonmembers;
        private string _memberstr;

        private DateTime _raisedate;
        private DateTime? _originationdate;
        private DateTime _targetCloseDate;
        private DateTime? _actualCloseDate;
        private DateTime? _reviewreportissuedate;
        
        private List<RiskSubcategory> _risksubcategory;
        private List<Causes> _causes;
        private List<Causes> _selected;
        private List<Action> _actions;

        private ApprovalMember _member;
        private List<ApprovalMember> _members;

        private ProblemStatus _problemstatus;
        private RecordsStatus _status;
        private Modules _module;
        private RecordMode _mode;
    
        public Problem()
        {
            this._problemstatus = ProblemStatus.Open;
            this._status = RecordsStatus.ORIGINAL;
            this.Module = Modules.ProblemManagement;
            this.Mode = RecordMode.Current;
        }

        [XmlAttribute(AttributeName = "AffectedPartyType")]
        public string AffectedPartyType
        {
            get
            {
                return this._affectedpartytype;
            }
            set
            {
                this._affectedpartytype = value;
            }
        }

        [XmlAttribute(AttributeName = "AffectedDepartment")]
        public string AffectedDepartment
        {
            get
            {
                return this._affecteddepartment;
            }
            set
            {
                this._affecteddepartment = value;
            }
        }

        [XmlAttribute(AttributeName = "AffectedDocument")]
        public string AffectedDocument
        {
            get
            {
                return this._affecteddocument;
            }
            set
            {
                this._affecteddocument = value;
            }
        }

        [XmlAttribute(AttributeName = "ProblemID")]
        public long ProblemID
        {
            get
            {
                return _problemID;
            }
            set
            {
                _problemID = value;
            }
        }

        [XmlAttribute(AttributeName = "CaseNo")]
        public string CaseNO
        {
            get
            {
                return _caseno;
            }
            set
            {
                _caseno = value;
            }
        }
        
        [XmlAttribute(AttributeName = "Title")]
        public string Title
        {
            get
            {
                return this._title;
            }
            set
            {
                this._title = value;
            }
        }

        [XmlAttribute(AttributeName = "ProblemType")]
        public string ProblemType
        {
            get
            {
                return _problemtype;
            }
            set
            {
                _problemtype = value;
            }
        }
        [XmlAttribute(AttributeName = "Details")]
        public string Details
        {
            get
            {
                return this._details;
            }
            set
            {
                this._details = value;
            }
        }

        [XmlAttribute(AttributeName = "Remarks")]
        public string Remarks
        {
            get
            {
                return this._remarks;
            }
            set
            {
                this._remarks = value;
            }

        }
        [XmlAttribute(AttributeName = "Originator")]
        public string Originator
        {
            get
            {
                return _originator;
            }
            set
            {
                _originator = value;
            }
        }

        [XmlAttribute(AttributeName = "Owner")]
        public string Owner
        {
            get
            {
                return this._owner;
            }
            set
            {
                this._owner = value;
            }
        }
        [XmlAttribute(AttributeName = "Executive")]
        public string Executive
        {
            get
            {
                return this._executive;
            }
            set
            {
                this._executive = value;
            }
        }

        [XmlAttribute(AttributeName = "ReportDepartment")]
        public string ReportDepartment
        {
            get
            {
                return _reportdepartment;
            }
            set
            {
                _reportdepartment = value;
            }
        }

        [XmlAttribute(AttributeName = "ProblemRelatedDepartment")]
        public string ProblemRelatedDepartment
        {
            get
            {
                return _problemrelateddepartment;
            }
            set
            {
                _problemrelateddepartment = value;
            }
        }
        [XmlAttribute(AttributeName = "Severity")]
        public string Severity
        {
            get
            {
                return _severity;
            }
            set
            {
                _severity = value;
            }
        }
        [XmlAttribute(AttributeName = "ExternalParty")]
        public string ExternalParty
        {
            get
            {
                return _externalparty;
            }
            set
            {
                _externalparty = value;
            }
        }
        [XmlAttribute(AttributeName = "RaiseDate")]
        public DateTime RaiseDate
        {
            get
            {
                return this._raisedate;
            }
            set
            {
                this._raisedate = value;
            }
        }


        [XmlElement(ElementName = "OriginationDate")] 
        public DateTime? OriginationDate
        {
            get
            {
                return this._originationdate;
            }
            set
            {
                this._originationdate = value;
            }
        }
        [XmlAttribute(AttributeName = "TargetCloseDate")]
        public DateTime TargetCloseDate
        {
            get
            {
                return this._targetCloseDate;
            }
            set
            {
                this._targetCloseDate = value;
            }
        }
        [XmlElement(ElementName = "ActualCloseDate")] 
        public DateTime? ActualCloseDate
        {
            get
            {
                return this._actualCloseDate;
            }
            set
            {
                _actualCloseDate = value;
            }
        }

        [XmlElement(ElementName = "ReviewReportIssueDate")] 
        public DateTime? ReviewReportIssueDate
        {
            get
            {
                return _reviewreportissuedate;
            }
            set
            {
                _reviewreportissuedate = value;
            }
        }
        [XmlIgnore]
        public RecordsStatus Status
        {
            get
            {
                return _status;
            }
            set
            {
                _status = value;
            }
        }

        [XmlIgnore]
        public List<Causes> Causes
        {
            get
            {
                return _causes;
            }
            set
            {
                _causes = value;
            }
        }

        [XmlIgnore]
        public List<Causes> SelectedCause
        {
            get
            {
                return _selected;
            }
            set
            {
                _selected = value;
            }
        }

        [XmlIgnore]
        public List<RiskSubcategory> RiskSubcategory
        {
            get
            {
                return _risksubcategory;
            }
            set
            {
                _risksubcategory = value;
                this.XMLSubcategories=serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLSubcategories")]
        public string XMLSubcategories
        {
            get
            {
                return _xmlsubcategories;
            }
            set
            {
                _xmlsubcategories=value;
            }
        }
        
        [XmlIgnore]
        public List<Action> Actions
        {
            get
            {
                return _actions;
            }
            set
            {
                _actions = value;
                this.XMLActions = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "Actions")]
        public string XMLActions
        {
            get
            {
                return _xmlactions;
            }
            set
            {
                _xmlactions = value;
            }
        }
        [XmlIgnore]
        public ProblemStatus ProblemStatus
        {
            get
            {
                return _problemstatus;
            }
            set
            {
                _problemstatus = value;
                this.ProblemStatusString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ProblemStatus")]
        public string ProblemStatusString
        {
            get
            {
                return _problemstatusstr;
            }
            set
            {
                _problemstatusstr = value;
            }
        }
        [XmlIgnore]
        public RecordMode Mode
        {
            get
            {
                return _mode;
            }
            set
            {
                _mode = value;
                this.ModeString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ModeString")]
        public string ModeString
        {
            get
            {
                return _modestring;
            }
            set
            {
                _modestring = value;
            }
        }

        [XmlIgnore]
        public ApprovalMember Member
        {
            get
            {
                return _member;
            }
            set
            {
                _member = value;
                this.MemberString = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "MemberString")]
        public string MemberString
        {
            get
            {
                return _memberstr;
            }
            set
            {
                _memberstr = value;
            }
        }

        [XmlIgnore]
        public List<ApprovalMember> Members
        {
            get
            {
                return _members;
            }
            set
            {
                _members = value;
                this.JSONMembers = serializeToJSon(value);
            }
        }

        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                try
                {
                    if (obj is List<Action>)
                    {
                        serializer = new XmlSerializer(typeof(List<Action>));
                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                    else if (obj is List<RiskSubcategory>)
                    {
                        serializer = new XmlSerializer(typeof(List<RiskSubcategory>));
                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                    else if (obj is ApprovalMember)
                    {
                        serializer = new XmlSerializer(typeof(ApprovalMember));

                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                  
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.InnerException.Message);
                }
            }
            else
            {
                writer = new StringWriter();
            }
            return writer.ToString();
        }

        private string serializeToJSon(object obj)
        {
            string result = string.Empty;

            if (obj != null)
            {
                try
                {
                    if (obj is List<ApprovalMember>)
                    {
                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        result = serializer.Serialize(obj);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.InnerException.Message);
                }
            }
            return result;
        }

        [XmlIgnore]
        public Modules Module
        {
            get
            {
                return _module;
            }
            set
            {
                _module = value;
                this.ModuleName = value.ToString();
            }
        }

        [XmlAttribute(AttributeName = "ModuleName")]
        public string ModuleName
        {
            get
            {
                return _modulename;
            }
            set
            {
                _modulename = value;
            }
        }

        [XmlAttribute(AttributeName = "JSONMembers")]
        public string JSONMembers
        {
            get
            {
                return this._jsonmembers;
            }
            set
            {
                this._jsonmembers = value;
            }
        }
    }
}