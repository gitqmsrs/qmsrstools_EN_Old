using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.AuditManagement
{
    public partial class Findings : System.Web.UI.Page
    {
        string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        private DBService service = new DBService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.YRCBox.DataSource = service.enumAuditYears();
                this.YRCBox.DataBind();
                this.YRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RTCUSCBox.DataSource = _context.Causes;
                this.RTCUSCBox.DataTextField = "CauseName";
                this.RTCUSCBox.DataValueField = "CauseID";
                this.RTCUSCBox.DataBind();
                this.RTCUSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RECMODCBox.DataSource = _context.RecordModes;
                this.RECMODCBox.DataTextField = "RecordMode1";
                this.RECMODCBox.DataValueField = "RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                Dictionary<string, string> ListOfFields = FilterByYear(DateTime.Now.Year, _DisplayFields);
                this.lstFields.Items.Clear();
                foreach (KeyValuePair<string, string> obj in ListOfFields)
                {
                    this.lstFields.Items.Insert(0, new ListItem(obj.Key, obj.Key));
                }
                FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);
            }
        }
    
        protected void FillChart(Dictionary<string, string> data, int year)
        {
            Session["Guid"] = "";
       
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


                oXml_Manager.columns.Add(oColumn);


                oColumn = new Xml_Manager.Column();
                index++;
            }

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Annual Findings Per Type", "Year " + year.ToString(), "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected Dictionary<string, string> FilterByYear(int year, List<string> _DisplayFields)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();


            var findingtypes = _context.FindingTypes.Select(FNDTYP => FNDTYP);
            foreach (var ftype in findingtypes)
            {
                var findings = _context.Findings
                    .Where(FND => FND.Audit.PlannedAuditDate.Year == year && FND.FindingType.FindingType1==ftype.FindingType1 && FND.Audit.RecordModeID==(int)RecordMode.Current).Select(FND => FND);

                if (findings.Count() > 0)
                {
                    if (_DisplayFields != null)
                    {
                        if (_DisplayFields.First() == "ALL" && !statistics.ContainsKey(ftype.FindingType1))
                            statistics.Add(ftype.FindingType1, findings.Count().ToString());
                        else
                        {
                            if (_DisplayFields.Contains(ftype.FindingType1) && !statistics.ContainsKey(ftype.FindingType1))
                                statistics.Add(ftype.FindingType1, findings.Count().ToString());
                        }
                    }

                    
                }
            }
         
            return statistics;
        }

        protected Dictionary<string, string> FilterByRootCause(int causeID, List<string> _DisplayFields, int _year)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();


            var findingtypes = _context.FindingTypes.Select(FNDTYP => FNDTYP);
            foreach (var ftype in findingtypes)
            {
                var findings = _context.Findings
                    .Where(FND => FND.Audit.PlannedAuditDate.Year == _year && FND.FindingType.FindingType1 == ftype.FindingType1 && FND.RootCauseID == causeID && FND.Audit.RecordModeID == (int)RecordMode.Current)
                    .Select(FND => FND);

                if (findings.Count() > 0)
                {
                    if (_DisplayFields.First() == "ALL" && !statistics.ContainsKey(ftype.FindingType1))
                        statistics.Add(ftype.FindingType1, findings.Count().ToString());
                    else
                    {
                        if (_DisplayFields.Contains(ftype.FindingType1) && !statistics.ContainsKey(ftype.FindingType1))
                            statistics.Add(ftype.FindingType1, findings.Count().ToString());
                    }
                    
                }
            }

            return statistics;
        }

        protected Dictionary<string, string> FilterByReordMode(int modeID, List<string> _DisplayFields,int _year)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();


            var findingtypes = _context.FindingTypes.Select(FNDTYP => FNDTYP);
            foreach (var ftype in findingtypes)
            {
                var findings = _context.Findings
                    .Where(FND => FND.Audit.PlannedAuditDate.Year == _year && FND.FindingType.FindingType1 == ftype.FindingType1 && FND.Audit.RecordModeID == modeID)
                    .Select(FND => FND);

                if (findings.Count() > 0)
                {
                    if (_DisplayFields.First() == "ALL" && !statistics.ContainsKey(ftype.FindingType1))
                        statistics.Add(ftype.FindingType1, findings.Count().ToString());
                    else
                    {
                        if (_DisplayFields.Contains(ftype.FindingType1) && !statistics.ContainsKey(ftype.FindingType1))
                            statistics.Add(ftype.FindingType1, findings.Count().ToString());
                    }

                   
                }
            }

            return statistics;
        }
        protected void Alias_Click(object sender, EventArgs e)
        {

            this.dropdownchange.Value = "reset";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = FilterByYear(DateTime.Now.Year, _DisplayFields);
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj.Key, obj.Key));
            }
            FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);
        }
        protected void YRCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "YRCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = this.YRCBox.SelectedItem.Value.ToString() == "-1" ? FilterByYear(DateTime.Now.Year, _DisplayFields) : FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text), _DisplayFields);
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj.Key, obj.Key));
            }
            if (this.YRCBox.SelectedItem.Value.ToString() == "-1")
                FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);
            else
                FillChart(FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text), _DisplayFields), Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));
        }

        protected void RTCUSCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "RTCUSCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = this.YRCBox.SelectedItem.Value.ToString() == "-1" ? FilterByRootCause(Convert.ToInt32(this.RTCUSCBox.SelectedValue), _DisplayFields, DateTime.Now.Year) : FilterByRootCause(Convert.ToInt32(this.RTCUSCBox.SelectedValue), _DisplayFields, Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj.Key, obj.Key));
            }
            if (this.YRCBox.SelectedItem.Value.ToString() == "-1")
                FillChart(FilterByRootCause(Convert.ToInt32(this.RTCUSCBox.SelectedValue), _DisplayFields, DateTime.Now.Year), DateTime.Now.Year);
            else
                FillChart(FilterByRootCause(Convert.ToInt32(this.RTCUSCBox.SelectedValue),_DisplayFields, Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString())), Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));


            //FillChart(FilterByRootCause(int.Parse(this.YRCBox.SelectedItem.Value)), DateTime.Now.Year);
        }

        protected void RECMODCBox_SelectedIndexChanged(object sender, EventArgs e)
        {

            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "RECMODCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = this.YRCBox.SelectedItem.Value.ToString() == "-1" ? FilterByReordMode(Convert.ToInt32(this.RECMODCBox.SelectedValue), _DisplayFields, DateTime.Now.Year) : FilterByReordMode(Convert.ToInt32(this.RECMODCBox.SelectedValue), _DisplayFields, Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj.Key, obj.Key));
            }
            if (this.YRCBox.SelectedItem.Value.ToString() == "-1")
                FillChart(FilterByReordMode(Convert.ToInt32(this.RECMODCBox.SelectedValue), _DisplayFields, DateTime.Now.Year), DateTime.Now.Year);
                
            else
                FillChart(FilterByReordMode(Convert.ToInt32(this.RECMODCBox.SelectedValue), _DisplayFields, Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString())), Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));


           // FillChart(FilterByReordMode(int.Parse(this.YRCBox.SelectedItem.Value)), DateTime.Now.Year);
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
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
                if (this.YRCBox.SelectedItem.Value.ToString() == "-1")
                    FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);
                else
                    FillChart(FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text), _DisplayFields), Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));
            }
            else if (_activedropdown == "RTCUSCBox")
            {
                if (this.YRCBox.SelectedItem.Value.ToString() == "-1")
                    FillChart(FilterByRootCause(Convert.ToInt32(this.RTCUSCBox.SelectedValue), _DisplayFields, DateTime.Now.Year), DateTime.Now.Year);
                else
                    FillChart(FilterByRootCause(Convert.ToInt32(this.RTCUSCBox.SelectedValue), _DisplayFields, Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString())), Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));


            }
            else if (_activedropdown == "RECMODCBox")
            {
                if (this.YRCBox.SelectedItem.Value.ToString() == "-1")
                    FillChart(FilterByReordMode(Convert.ToInt32(this.RECMODCBox.SelectedValue), _DisplayFields, DateTime.Now.Year), DateTime.Now.Year);

                else
                    FillChart(FilterByReordMode(Convert.ToInt32(this.RECMODCBox.SelectedValue), _DisplayFields, Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString())), Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));

            }
            else
            {
                FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);
            }


        }
    }
}