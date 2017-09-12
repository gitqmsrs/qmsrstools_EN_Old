using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.ProblemManagement
{
    public partial class AnnualProblems : System.Web.UI.Page
    {
        string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        private DBService service = new DBService();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
      
                this.YRCBox.DataSource = service.enumProblemYears();
                this.YRCBox.DataTextField = "Year";
                this.YRCBox.DataValueField = "Year";
                this.YRCBox.DataBind();
                this.YRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.PRMTYPCBox.DataSource = _context.ProblemTypes;
                this.PRMTYPCBox.DataTextField="ProblemType1"; 
                this.PRMTYPCBox.DataValueField="ProblemTypeID";
                this.PRMTYPCBox.DataBind();
                this.PRMTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RTCUSCBox.DataSource = _context.Causes;
                this.RTCUSCBox.DataTextField = "CauseName";
                this.RTCUSCBox.DataValueField = "CauseID";
                this.RTCUSCBox.DataBind();
                this.RTCUSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RECMODCBox.DataSource = _context.RecordModes;
                this.RECMODCBox.DataTextField="RecordMode1";
                this.RECMODCBox.DataValueField="RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");

                FillChart(GetStatistics(), "Year (" + DateTime.Now.Year.ToString() + ")", _DisplayFields);
            }
        }

        protected void FillChart(Dictionary<string, string> data, string title, List<string> _DisplayFields)
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

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Statistics of Annual Problems", title, "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected Dictionary<string, string> FilterByProblemType(int problemtypeID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();


            statistics.Add("January", "0");
            statistics.Add("February", "0");
            statistics.Add("March", "0");
            statistics.Add("April", "0");
            statistics.Add("May", "0");
            statistics.Add("June", "0");
            statistics.Add("July", "0");
            statistics.Add("August", "0");
            statistics.Add("September", "0");
            statistics.Add("October", "0");
            statistics.Add("November", "0");
            statistics.Add("December", "0");

            var problems = _context.Problems.Where(PRM => PRM.ProblemTypeID == problemtypeID && PRM.RaiseDate.Year == DateTime.Now.Year && PRM.RecordModeID==(int)RecordMode.Current)
                .Select(PRM => PRM);

            foreach (var problem in problems)
            {
                switch (problem.RaiseDate.Month)
                {
                    case 1:
                        statistics["January"] = (int.Parse(statistics["January"]) + 1).ToString();
                        break;
                    case 2:
                        statistics["February"] = (int.Parse(statistics["February"]) + 1).ToString();
                        break;
                    case 3:
                        statistics["March"] = (int.Parse(statistics["March"]) + 1).ToString();
                        break;
                    case 4:
                        statistics["April"] = (int.Parse(statistics["April"]) + 1).ToString();
                        break;
                    case 5:
                        statistics["May"] = (int.Parse(statistics["May"]) + 1).ToString();
                        break;
                    case 6:
                        statistics["June"] = (int.Parse(statistics["June"]) + 1).ToString();
                        break;
                    case 7:
                        statistics["July"] = (int.Parse(statistics["July"]) + 1).ToString();
                        break;
                    case 8:
                        statistics["August"] = (int.Parse(statistics["August"]) + 1).ToString();
                        break;
                    case 9:
                        statistics["September"] = (int.Parse(statistics["September"]) + 1).ToString();
                        break;
                    case 10:
                        statistics["October"] = (int.Parse(statistics["October"]) + 1).ToString();
                        break;
                    case 11:
                        statistics["November"] = (int.Parse(statistics["November"]) + 1).ToString();
                        break;
                    case 12:
                        statistics["December"] = (int.Parse(statistics["December"]) + 1).ToString();
                        break;
                }
            }
            return statistics;
        }

        protected Dictionary<string, string> FilterByRootCause(int rootcauseID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();


            statistics.Add("January", "0");
            statistics.Add("February", "0");
            statistics.Add("March", "0");
            statistics.Add("April", "0");
            statistics.Add("May", "0");
            statistics.Add("June", "0");
            statistics.Add("July", "0");
            statistics.Add("August", "0");
            statistics.Add("September", "0");
            statistics.Add("October", "0");
            statistics.Add("November", "0");
            statistics.Add("December", "0");

            var problems = _context.Problems.Where(PRM => PRM.CauseID == rootcauseID && PRM.RaiseDate.Year == DateTime.Now.Year && PRM.RecordModeID == (int)RecordMode.Current)
                .Select(PRM => PRM);

            foreach (var problem in problems)
            {
                switch (problem.RaiseDate.Month)
                {
                    case 1:
                        statistics["January"] = (int.Parse(statistics["January"]) + 1).ToString();
                        break;
                    case 2:
                        statistics["February"] = (int.Parse(statistics["February"]) + 1).ToString();
                        break;
                    case 3:
                        statistics["March"] = (int.Parse(statistics["March"]) + 1).ToString();
                        break;
                    case 4:
                        statistics["April"] = (int.Parse(statistics["April"]) + 1).ToString();
                        break;
                    case 5:
                        statistics["May"] = (int.Parse(statistics["May"]) + 1).ToString();
                        break;
                    case 6:
                        statistics["June"] = (int.Parse(statistics["June"]) + 1).ToString();
                        break;
                    case 7:
                        statistics["July"] = (int.Parse(statistics["July"]) + 1).ToString();
                        break;
                    case 8:
                        statistics["August"] = (int.Parse(statistics["August"]) + 1).ToString();
                        break;
                    case 9:
                        statistics["September"] = (int.Parse(statistics["September"]) + 1).ToString();
                        break;
                    case 10:
                        statistics["October"] = (int.Parse(statistics["October"]) + 1).ToString();
                        break;
                    case 11:
                        statistics["November"] = (int.Parse(statistics["November"]) + 1).ToString();
                        break;
                    case 12:
                        statistics["December"] = (int.Parse(statistics["December"]) + 1).ToString();
                        break;
                }
            }
            return statistics;
        }


        protected Dictionary<string, string> FilterByRecordMode(int recordmodeID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();


            statistics.Add("January", "0");
            statistics.Add("February", "0");
            statistics.Add("March", "0");
            statistics.Add("April", "0");
            statistics.Add("May", "0");
            statistics.Add("June", "0");
            statistics.Add("July", "0");
            statistics.Add("August", "0");
            statistics.Add("September", "0");
            statistics.Add("October", "0");
            statistics.Add("November", "0");
            statistics.Add("December", "0");

            var problems = _context.Problems.Where(PRM => PRM.RecordModeID == recordmodeID && PRM.RaiseDate.Year == DateTime.Now.Year)
                .Select(PRM => PRM);

            foreach (var problem in problems)
            {
                switch (problem.RaiseDate.Month)
                {
                    case 1:
                        statistics["January"] = (int.Parse(statistics["January"]) + 1).ToString();
                        break;
                    case 2:
                        statistics["February"] = (int.Parse(statistics["February"]) + 1).ToString();
                        break;
                    case 3:
                        statistics["March"] = (int.Parse(statistics["March"]) + 1).ToString();
                        break;
                    case 4:
                        statistics["April"] = (int.Parse(statistics["April"]) + 1).ToString();
                        break;
                    case 5:
                        statistics["May"] = (int.Parse(statistics["May"]) + 1).ToString();
                        break;
                    case 6:
                        statistics["June"] = (int.Parse(statistics["June"]) + 1).ToString();
                        break;
                    case 7:
                        statistics["July"] = (int.Parse(statistics["July"]) + 1).ToString();
                        break;
                    case 8:
                        statistics["August"] = (int.Parse(statistics["August"]) + 1).ToString();
                        break;
                    case 9:
                        statistics["September"] = (int.Parse(statistics["September"]) + 1).ToString();
                        break;
                    case 10:
                        statistics["October"] = (int.Parse(statistics["October"]) + 1).ToString();
                        break;
                    case 11:
                        statistics["November"] = (int.Parse(statistics["November"]) + 1).ToString();
                        break;
                    case 12:
                        statistics["December"] = (int.Parse(statistics["December"]) + 1).ToString();
                        break;
                }
            }
            return statistics;
        }
        protected Dictionary<string, string> FilterByYear(int year)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();


            statistics.Add("January", "0");
            statistics.Add("February", "0");
            statistics.Add("March", "0");
            statistics.Add("April", "0");
            statistics.Add("May", "0");
            statistics.Add("June", "0");
            statistics.Add("July", "0");
            statistics.Add("August", "0");
            statistics.Add("September", "0");
            statistics.Add("October", "0");
            statistics.Add("November", "0");
            statistics.Add("December", "0");

            var problems = _context.Problems.Where(PRM => PRM.RaiseDate.Year == year && PRM.RecordModeID==(int)RecordMode.Current)
                .Select(PRM => PRM);

            foreach (var problem in problems)
            {
                switch (problem.RaiseDate.Month)
                {
                    case 1:
                        statistics["January"] = (int.Parse(statistics["January"]) + 1).ToString();
                        break;
                    case 2:
                        statistics["February"] = (int.Parse(statistics["February"]) + 1).ToString();
                        break;
                    case 3:
                        statistics["March"] = (int.Parse(statistics["March"]) + 1).ToString();
                        break;
                    case 4:
                        statistics["April"] = (int.Parse(statistics["April"]) + 1).ToString();
                        break;
                    case 5:
                        statistics["May"] = (int.Parse(statistics["May"]) + 1).ToString();
                        break;
                    case 6:
                        statistics["June"] = (int.Parse(statistics["June"]) + 1).ToString();
                        break;
                    case 7:
                        statistics["July"] = (int.Parse(statistics["July"]) + 1).ToString();
                        break;
                    case 8:
                        statistics["August"] = (int.Parse(statistics["August"]) + 1).ToString();
                        break;
                    case 9:
                        statistics["September"] = (int.Parse(statistics["September"]) + 1).ToString();
                        break;
                    case 10:
                        statistics["October"] = (int.Parse(statistics["October"]) + 1).ToString();
                        break;
                    case 11:
                        statistics["November"] = (int.Parse(statistics["November"]) + 1).ToString();
                        break;
                    case 12:
                        statistics["December"] = (int.Parse(statistics["December"]) + 1).ToString();
                        break;
                }
            }
            return statistics;
        }
        protected Dictionary<string, string> GetStatistics()
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

           
                statistics.Add("January", "0");
                statistics.Add("February", "0");
                statistics.Add("March", "0");
                statistics.Add("April", "0");
                statistics.Add("May", "0");
                statistics.Add("June", "0");
                statistics.Add("July", "0");
                statistics.Add("August", "0");
                statistics.Add("September", "0");
                statistics.Add("October", "0");
                statistics.Add("November", "0");
                statistics.Add("December", "0");

                var problems = _context.Problems.Where(PRM => PRM.RaiseDate.Year == DateTime.Now.Year && PRM.RecordModeID == (int)RecordMode.Current)
                .Select(PRM => PRM);

            foreach (var problem in problems)
            {
                switch (problem.RaiseDate.Month)
                {
                    case 1:
                        statistics["January"] = (int.Parse(statistics["January"]) + 1).ToString();
                        break;
                    case 2:
                        statistics["February"] = (int.Parse(statistics["February"]) + 1).ToString();
                        break;
                    case 3:
                        statistics["March"] = (int.Parse(statistics["March"]) + 1).ToString();
                        break;
                    case 4:
                        statistics["April"] = (int.Parse(statistics["April"]) + 1).ToString();
                        break;
                    case 5:
                        statistics["May"] = (int.Parse(statistics["May"]) + 1).ToString();
                        break;
                    case 6:
                        statistics["June"] = (int.Parse(statistics["June"]) + 1).ToString();
                        break;
                    case 7:
                        statistics["July"] = (int.Parse(statistics["July"]) + 1).ToString();
                        break;
                    case 8:
                        statistics["August"] = (int.Parse(statistics["August"]) + 1).ToString();
                        break;
                    case 9:
                        statistics["September"] = (int.Parse(statistics["September"]) + 1).ToString();
                        break;
                    case 10:
                        statistics["October"] = (int.Parse(statistics["October"]) + 1).ToString();
                        break;
                    case 11:
                        statistics["November"] = (int.Parse(statistics["November"]) + 1).ToString();
                        break;
                    case 12:
                        statistics["December"] = (int.Parse(statistics["December"]) + 1).ToString();
                        break;
                }
            }
            return statistics;
        }

        protected void Alias_Click(object sender, ImageClickEventArgs e)
        {
            this.dropdownchange.Value = "reset";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            FillChart(GetStatistics(), "Year (" + DateTime.Now.Year.ToString() + ")", _DisplayFields);
        }

        protected void YRCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "YRCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            DropDownList obj = (DropDownList)sender;
            if (Convert.ToInt32(obj.SelectedItem.Value) != -1)
            {
                FillChart(FilterByYear(int.Parse(obj.SelectedItem.Text)), "Year (" + obj.SelectedItem.Value + ")", _DisplayFields);
            }
        }

        protected void PRMTYPCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "PRMTYPCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            DropDownList obj = (DropDownList)sender;
          
            if (Convert.ToInt32(obj.SelectedItem.Value) != -1)
            {
                FillChart(FilterByProblemType(int.Parse(obj.SelectedItem.Value)), "Problem Type (" + obj.SelectedItem.Text + ")", _DisplayFields);
            }
        }

        protected void RTCUSCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "RTCUSCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            DropDownList obj = (DropDownList)sender;
            if (Convert.ToInt32(obj.SelectedItem.Value) != -1)
            {
                FillChart(FilterByRootCause(int.Parse(obj.SelectedItem.Value)), "Root Cause (" + obj.SelectedItem.Text + ")", _DisplayFields);
            }
        }

        protected void RECMODCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "RECMODCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            DropDownList obj = (DropDownList)sender;
            if (Convert.ToInt32(obj.SelectedItem.Value) != -1)
            {
                FillChart(FilterByRecordMode(int.Parse(obj.SelectedItem.Value)), "Record Mode (" + obj.SelectedItem.Text + ")", _DisplayFields);
            }
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

            if (_activedropdown == "YRCBox")
            {
                if (Convert.ToInt32(this.YRCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterByYear(int.Parse(this.YRCBox.SelectedItem.Text)), "Year (" + this.YRCBox.SelectedItem.Value + ")", _DisplayFields);
                }

            }
            else if (_activedropdown == "PRMTYPCBox")
            {
                if (Convert.ToInt32(this.PRMTYPCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterByProblemType(int.Parse(this.PRMTYPCBox.SelectedItem.Value)), "Problem Type (" + this.PRMTYPCBox.SelectedItem.Text + ")", _DisplayFields);
                }

            }

            else if (_activedropdown == "RTCUSCBox")
            {
                if (Convert.ToInt32(this.RTCUSCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterByRootCause(int.Parse(this.RTCUSCBox.SelectedItem.Value)), "Root Cause (" + this.RTCUSCBox.SelectedItem.Text + ")", _DisplayFields);
                }

            }

            else if (_activedropdown == "RECMODCBox")
            {
                if (Convert.ToInt32(this.RECMODCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterByRecordMode(int.Parse(this.RECMODCBox.SelectedItem.Value)), "Record Mode (" + this.RECMODCBox.SelectedItem.Text + ")", _DisplayFields);
                }

            }

            else
            {
                FillChart(GetStatistics(), "Year (" + DateTime.Now.Year.ToString() + ")", _DisplayFields);
            }



        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }


    }
}