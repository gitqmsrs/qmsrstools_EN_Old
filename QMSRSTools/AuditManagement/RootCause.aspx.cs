using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.AuditManagement
{
    public partial class RootCause : System.Web.UI.Page
    {
        string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        private DBService obj = new DBService();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.YRCBox.DataSource = obj.enumAuditYears();
                this.YRCBox.DataBind();
                this.YRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                Dictionary<string, string> ListOfFields = FilterByYear(DateTime.Now.Year, _DisplayFields);
                this.lstFields.Items.Clear();
                foreach (KeyValuePair<string, string> obj2 in ListOfFields)
                {
                    this.lstFields.Items.Insert(0, new ListItem(obj2.Key, obj2.Key));
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

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Annual Findings Per Root Cause", "Year " + year.ToString(), "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected Dictionary<string, string> FilterByYear(int year, List<string> _DisplayFields)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();
          
            foreach (var cause in causeList)
            {
              
                var findings = _context.Findings
                    .Where(FND => FND.Audit.PlannedAuditDate.Year == year && FND.RootCauseID == cause.CauseID).Select(FND => FND);

                if (findings.Count() > 0)
                {
                    if (_DisplayFields.First() == "ALL" && !statistics.ContainsKey(cause.CauseName))
                    {
                      
                            statistics.Add(cause.CauseName, findings.Count().ToString());
                      
                      
                    }
                    else
                    {
                        if (_DisplayFields.Contains(cause.CauseName) && !statistics.ContainsKey(cause.CauseName))
                        {
                          statistics.Add(cause.CauseName, findings.Count().ToString());
                          
                        }
                    }

                    


                }
            }

            return statistics;
        }

        protected void Alias_Click(object sender, EventArgs e)
        {

            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = FilterByYear(DateTime.Now.Year, _DisplayFields);
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj.Key, obj.Key));
            }
            FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);


            //FillChart(FilterByYear(DateTime.Now.Year), DateTime.Now.Year);
        }
        protected void YRCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "YRCBox";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = this.YRCBox.SelectedItem.Value.ToString() == "-1" ? FilterByYear(DateTime.Now.Year, _DisplayFields) : FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text), _DisplayFields);
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj2 in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj2.Key, obj2.Key));
            }
            if (this.YRCBox.SelectedItem.Value.ToString() == "-1")
                FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);
            else
                FillChart(FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text), _DisplayFields), Convert.ToInt32(this.YRCBox.SelectedItem.Text.ToString()));


          //  FillChart(FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text)), Convert.ToInt32(this.YRCBox.SelectedItem.Text));
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

            else
            {
                FillChart(FilterByYear(DateTime.Now.Year, _DisplayFields), DateTime.Now.Year);
            }


        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }

    }
}