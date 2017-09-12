using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class ViewActionStatistics : System.Web.UI.Page
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

                this.RTCUSCBox.DataSource = _context.Causes;
                this.RTCUSCBox.DataTextField = "CauseName";
                this.RTCUSCBox.DataValueField = "CauseID";
                this.RTCUSCBox.DataBind();
                this.RTCUSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

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


                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");

                FillChart(GetStatistics(), _DisplayFields);
            }
        }

        protected void alias_Click(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "reset";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            FillChart(GetStatistics(), _DisplayFields);
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
            
            foreach (KeyValuePair<string,string> obj in data)
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

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Statistics of Open/Closed Problem Actions", "", "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected Dictionary<string, string> FilterStatisticsByTargetDate(string start, string end)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            DateTime startdate = DateTime.Parse(start);
            DateTime enddate = DateTime.Parse(end);

            var actions = _context.ProblemActions.Where(ACT => ACT.Problem.TargetCloseDate >= startdate && ACT.Problem.TargetCloseDate <= enddate)
                .Select(ACT => ACT).ToList();

            int _opened = 0;
            int _closed = 0;

            foreach (var obj in actions)
            {
                switch (obj.IsClosed)
                {
                    case true:
                        _closed++;
                        break;
                    case false:
                        _opened++;
                        break;
                }
            }

            statistics.Add("Open", _opened.ToString());
            statistics.Add("Close", _closed.ToString());


            return statistics;

        }
        protected Dictionary<string, string> FilterStatisticsByType(string type)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var actions = _context.ProblemActions.Where(ACT => ACT.Problem.ProblemType.ProblemType1 == type && ACT.Problem.RecordModeID == (int)RecordMode.Current)
                .Select(ACT => ACT).ToList();

            int _opened = 0;
            int _closed = 0;

            foreach (var obj in actions)
            {
                switch (obj.IsClosed)
                {
                    case true:
                        _closed++;
                        break;
                    case false:
                        _opened++;
                        break;
                }
            }

            statistics.Add("Open", _opened.ToString());
            statistics.Add("Close", _closed.ToString());

            return statistics;
  
        }
        protected Dictionary<string, string> FilterStatisticsByStatus(string status)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var actions = _context.ProblemActions.Where(ACT => ACT.Problem.ProblemStatus.ProblemStatus1 == status && ACT.Problem.RecordModeID == (int)RecordMode.Current)
                .Select(ACT => ACT).ToList();

            int _opened = 0;
            int _closed = 0;

            foreach (var obj in actions)
            {
                switch (obj.IsClosed)
                {
                    case true:
                        _closed++;
                        break;
                    case false:
                        _opened++;
                        break;
                }
            }

            statistics.Add("Open", _opened.ToString());
            statistics.Add("Close", _closed.ToString());

            return statistics;

        }

        protected Dictionary<string, string> FilterStatisticsByRoot(int causeID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var actions = _context.ProblemActions.Where(ACT => ACT.Problem.CauseID == causeID && ACT.Problem.RecordModeID==(int)RecordMode.Current)
                .Select(ACT => ACT).ToList();

            int _opened = 0;
            int _closed = 0;

            foreach (var obj in actions)
            {
                switch (obj.IsClosed)
                {
                    case true:
                        _closed++;
                        break;
                    case false:
                        _opened++;
                        break;
                }
            }

            statistics.Add("Open", _opened.ToString());
            statistics.Add("Close", _closed.ToString());

            return statistics;

        }

        protected Dictionary<string, string> FilterStatisticsByPartyType(int partyID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var actions = _context.ProblemActions.Where(ACT => ACT.Problem.ProblemTypeID == partyID && ACT.Problem.RecordModeID == (int)RecordMode.Current)
                .Select(ACT => ACT).ToList();

            int _opened = 0;
            int _closed = 0;

            foreach (var obj in actions)
            {
                switch (obj.IsClosed)
                {
                    case true:
                        _closed++;
                        break;
                    case false:
                        _opened++;
                        break;
                }
            }

            statistics.Add("Open", _opened.ToString());
            statistics.Add("Close", _closed.ToString());

            return statistics;

        }

        protected Dictionary<string, string> FilterStatisticsByRecordMode(int recordmodeID)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var actions = _context.ProblemActions.Where(ACT => ACT.Problem.RecordModeID == recordmodeID)
                .Select(ACT => ACT).ToList();

            int _opened = 0;
            int _closed = 0;

            foreach (var obj in actions)
            {
                switch (obj.IsClosed)
                {
                    case true:
                        _closed++;
                        break;
                    case false:
                        _opened++;
                        break;
                }
            }

            statistics.Add("Open", _opened.ToString());
            statistics.Add("Close", _closed.ToString());

            return statistics;

        }
        protected Dictionary<string, string> GetStatistics()
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var actions = _context.ProblemActions
                .Select(ACT => ACT).ToList();

            int _opened=0;
            int _closed = 0;

            foreach (var obj in actions)
            {
                switch (obj.IsClosed)
                {
                    case true:
                        _closed++;
                        break;
                    case false:
                        _opened++;
                        break;
                }
            }

            statistics.Add("Open", _opened.ToString());
            statistics.Add("Close", _closed.ToString());


            return statistics;
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
                FillChart(FilterStatisticsByType(obj.SelectedItem.Text), _DisplayFields);
            }


            
        }

        protected void PRMSTSCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "PRMSTSCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            DropDownList obj = (DropDownList)sender;

            if (Convert.ToInt32(obj.SelectedItem.Value) != -1)
            {
                FillChart(FilterStatisticsByStatus(obj.SelectedItem.Text), _DisplayFields);
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
               FillChart(FilterStatisticsByRoot(int.Parse(obj.SelectedItem.Value)),_DisplayFields);
            }



           
        }

        protected void PRTYPCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "PRTYPCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            DropDownList obj = (DropDownList)sender;

            if (Convert.ToInt32(obj.SelectedItem.Value) != -1)
            {
                FillChart(FilterStatisticsByPartyType(int.Parse(obj.SelectedItem.Value)), _DisplayFields);
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
                FillChart(FilterStatisticsByRecordMode(int.Parse(obj.SelectedItem.Value)), _DisplayFields);
            }


       
        }

        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
           
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");

            if (this.FDTTxt.Text!="" && this.TDTTxt.Text!="")
            {
                this.dropdownchange.Value = "changed";
                this.activedropdown.Value = "FDTTxt";
            FillChart(FilterStatisticsByTargetDate(this.FDTTxt.Text, this.TDTTxt.Text), _DisplayFields);
            }
            else
                FillChart(GetStatistics(), _DisplayFields);
        }


        protected void Search2_Click(object sender, ImageClickEventArgs e)
        {
           // FillChart(FilterStatisticsByTargetDate(this.FDTTxt.Text, this.TDTTxt.Text));
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
                    FillChart(FilterStatisticsByType(this.PRMTYPCBox.SelectedItem.Value), _DisplayFields);
                    
                }

            }
            else if (_activedropdown == "PRMSTSCBox")
            {
                if (Convert.ToInt32(this.PRMSTSCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterStatisticsByStatus(this.PRMSTSCBox.SelectedItem.Value), _DisplayFields);
                }

            }

            else if (_activedropdown == "RTCUSCBox")
            {
                if (Convert.ToInt32(this.RTCUSCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterStatisticsByRoot(int.Parse(this.RTCUSCBox.SelectedItem.Value)), _DisplayFields);
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

            else if (_activedropdown == "FDTTxt")
            {
                if (this.FDTTxt.Text != "" && this.TDTTxt.Text != "")
                {
                    FillChart(FilterStatisticsByTargetDate(this.FDTTxt.Text, this.TDTTxt.Text), _DisplayFields);
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