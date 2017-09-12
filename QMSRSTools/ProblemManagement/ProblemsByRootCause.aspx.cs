using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.ProblemManagement
{
    public partial class ProblemsByRootCause : System.Web.UI.Page
    {
        string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
      
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.PRMTYPCBox.DataSource = _context.ProblemTypes;
                this.PRMTYPCBox.DataTextField = "ProblemType1";
                this.PRMTYPCBox.DataValueField = "ProblemTypeID";
                this.PRMTYPCBox.DataBind();
                this.PRMTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.PRMSTSCBox.DataSource = _context.ProblemStatus.ToList();
                this.PRMSTSCBox.DataTextField = "ProblemStatus1";
                this.PRMSTSCBox.DataValueField = "ProblemStatusID";
                this.PRMSTSCBox.DataBind();
                this.PRMSTSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.PRTYPCBox.DataSource = _context.AffectedPartyTypes;
                this.PRTYPCBox.DataTextField = "AffectedPartyType1";
                this.PRTYPCBox.DataValueField = "AffectedPartyTypeID";
                this.PRTYPCBox.DataBind();
                this.PRTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RECMODCBox.DataSource = _context.RecordModes;
                this.RECMODCBox.DataTextField = "RecordMode1";
                this.RECMODCBox.DataValueField = "RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));



                var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
                foreach (var cause in causeList)
                {
                       int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.RecordModeID==(int)RecordMode.Current).Count();
                       if (count > 0)
                       {
                           this.lstFields.Items.Insert(0, new ListItem(cause.CauseName, cause.CauseName));
                       }
                }


                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");


                FillChart(GetStatistics(), _DisplayFields);
            }
        }
        protected void FillChart(Dictionary<string, string> data, List<string> _DisplayFields)
        {
            int ColNo = data.Count;
            int ColW;

            string ColWidth = "50";

            if (ColNo > 7)
            {
                ColW = (700 / ColNo) / 2;
                ColWidth = ColW.ToString();
            }


            int index = 0;

            Xml_Manager.Column oColumn = new Xml_Manager.Column();
            Xml_Manager oXml_Manager = new Xml_Manager();
        
            foreach (KeyValuePair<string, string> obj in data)
            {
                oColumn.Color = Colors[index];
                oColumn.Name = obj.Key;
                oColumn.Value = obj.Value.ToString();

                if (_DisplayFields != null)
                {
                    if (_DisplayFields.First() == "ALL")
                        oXml_Manager.columns.Add(oColumn);
                    else
                    {
                        if (_DisplayFields.Contains(oColumn.Name))
                            oXml_Manager.columns.Add(oColumn);
                    }
                }


                
                oColumn = new Xml_Manager.Column();
                index++;
            }

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Statistics of Root Cause Frequency", "", "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }
        protected Dictionary<string, string> GetStatistics()
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.RecordModeID==(int)RecordMode.Current).Count();
                if (count > 0)
                {
                    if (statistics.ContainsKey(cause.CauseName) == false)
                    {
                        statistics.Add(cause.CauseName, count.ToString());
                    }
                    else
                    {
                        statistics[cause.CauseName] = (int.Parse(statistics[cause.CauseName]) + count).ToString();
                    }
                }
            }

            return statistics;
        }

        protected Dictionary<string, string> FilterStatisticsByType(int typeID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.ProblemTypeID == typeID && PRM.RecordModeID == (int)RecordMode.Current)
                    .Count();
                if (count > 0)
                {
                    if (statistics.ContainsKey(cause.CauseName) == false)
                    {
                        statistics.Add(cause.CauseName, count.ToString());
                    }
                    else
                    {
                        statistics[cause.CauseName] = (int.Parse(statistics[cause.CauseName]) + count).ToString();
                    }
                }
            }

            return statistics;
        }

        protected Dictionary<string, string> FilterStatisticsByStatus(int statusID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.StatusID == statusID && PRM.RecordModeID == (int)RecordMode.Current)
                    .Count();
                if (count > 0)
                {
                    if (statistics.ContainsKey(cause.CauseName) == false)
                    {
                        statistics.Add(cause.CauseName, count.ToString());
                    }
                    else
                    {
                        statistics[cause.CauseName] = (int.Parse(statistics[cause.CauseName]) + count).ToString();
                    }
                }
            }

            return statistics;
        }


        protected Dictionary<string, string> FilterStatisticsByPartyType(int typeID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.AffectedPartyTypeID == typeID && PRM.RecordModeID == (int)RecordMode.Current)
                    .Count();
                if (count > 0)
                {
                    if (statistics.ContainsKey(cause.CauseName) == false)
                    {
                        statistics.Add(cause.CauseName, count.ToString());
                    }
                    else
                    {
                        statistics[cause.CauseName] = (int.Parse(statistics[cause.CauseName]) + count).ToString();
                    }
                }
            }

            return statistics;
        }

        protected Dictionary<string, string> FilterStatisticsByRecordMode(int modeID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.RecordModeID == modeID)
                    .Count();
                if (count > 0)
                {
                    if (statistics.ContainsKey(cause.CauseName) == false)
                    {
                        statistics.Add(cause.CauseName, count.ToString());
                    }
                    else
                    {
                        statistics[cause.CauseName] = (int.Parse(statistics[cause.CauseName]) + count).ToString();
                    }
                }
            }

            return statistics;
        }

        protected void PRMTYPCBox_SelectedIndexChanged(object sender, EventArgs e)
        {

            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "PRMTYPCBox";
            this.lstFields.Items.Clear();
               DropDownList obj = (DropDownList)sender;
            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.ProblemTypeID == int.Parse(obj.SelectedItem.Value) && PRM.RecordModeID == (int)RecordMode.Current)
                    .Count();
                    if (count > 0)
                    {
                        this.lstFields.Items.Insert(0, new ListItem(cause.CauseName, cause.CauseName));
                    }
            }
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");


         
            FillChart(FilterStatisticsByType(int.Parse(obj.SelectedItem.Value)), _DisplayFields);
        }

        protected void PRMSTSCBox_SelectedIndexChanged(object sender, EventArgs e)
        {

            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "PRMSTSCBox";
            this.lstFields.Items.Clear();

            DropDownList obj = (DropDownList)sender;
            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.StatusID == int.Parse(obj.SelectedItem.Value) && PRM.RecordModeID == (int)RecordMode.Current)
                    .Count();
                  if (count > 0)
                  {
                      this.lstFields.Items.Insert(0, new ListItem(cause.CauseName, cause.CauseName));
                  }
            }
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");

            FillChart(FilterStatisticsByStatus(int.Parse(obj.SelectedItem.Value)), _DisplayFields);
        }

        protected void PRTYPCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "PRTYPCBox";
            this.lstFields.Items.Clear();
            DropDownList obj = (DropDownList)sender;
            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.AffectedPartyTypeID == int.Parse(obj.SelectedItem.Value) && PRM.RecordModeID == (int)RecordMode.Current)
                    .Count();
                 if (count > 0)
                 {
                     this.lstFields.Items.Insert(0, new ListItem(cause.CauseName, cause.CauseName));
                 }
            }
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
         
            FillChart(FilterStatisticsByPartyType(int.Parse(obj.SelectedItem.Value)), _DisplayFields);
        }

        protected void RECMODCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "RECMODCBox";
            this.lstFields.Items.Clear();
            DropDownList obj = (DropDownList)sender;
            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.RecordModeID == int.Parse(obj.SelectedItem.Value))
                    .Count();
                   if (count > 0)
                   {
                       this.lstFields.Items.Insert(0, new ListItem(cause.CauseName, cause.CauseName));
                   }
            }
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");

         
            FillChart(FilterStatisticsByRecordMode(int.Parse(obj.SelectedItem.Value)), _DisplayFields);
        }
        protected void alias_Click(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "reset";
            this.lstFields.Items.Clear();
            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
            foreach (var cause in causeList)
            {
                     int count = _context.Problems.Where(PRM => PRM.CauseID == cause.CauseID && PRM.RecordModeID==(int)RecordMode.Current).Count();
                     if (count > 0)
                     {
                         this.lstFields.Items.Insert(0, new ListItem(cause.CauseName, cause.CauseName));
                     }
            }

            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");

            FillChart(GetStatistics(), _DisplayFields);
        }
        protected void Search_Click(object sender, ImageClickEventArgs e)
        {

            List<string> _DisplayFields = new List<string>();
            this.dropdownchange.Value = "CLICK";
            string _activedropdown = this.activedropdown.Value;

            foreach (ListItem listitems in lstFields.Items)
            {
                if (listitems.Selected == true)
                    _DisplayFields.Add(listitems.Value);

            }
            if (_DisplayFields.Count == 0)
            {
                _DisplayFields = null;
            }

            if (_activedropdown == "PRMTYPCBox")
            {
                if (Convert.ToInt32(this.PRMTYPCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterStatisticsByType(int.Parse(this.PRMTYPCBox.SelectedItem.Value)), _DisplayFields);
                }

            }
            else if (_activedropdown == "PRMSTSCBox")
            {
                if (Convert.ToInt32(this.PRMSTSCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterStatisticsByStatus(int.Parse(this.PRMSTSCBox.SelectedItem.Value)), _DisplayFields);
                }

            }

            else if (_activedropdown == "PRTYPCBox")
            {
                if (Convert.ToInt32(this.PRTYPCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterStatisticsByPartyType(int.Parse(this.PRTYPCBox.SelectedItem.Value)), _DisplayFields);
                }

            }

            else if (_activedropdown == "RECMODCBox")
            {
                if (Convert.ToInt32(this.RECMODCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterStatisticsByRecordMode(int.Parse(this.RECMODCBox.SelectedItem.Value)), _DisplayFields);
                }

            }

            else
            {
                FillChart(GetStatistics(), _DisplayFields);
            }

        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}