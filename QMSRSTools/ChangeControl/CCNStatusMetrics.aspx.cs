using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace QMSRSTools.ChangeControl
{
    public partial class CCNStatusMetrics : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        private string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private Xml_Manager oXml_Manager = new Xml_Manager();
        private Xml_Manager.Column oColumn = new Xml_Manager.Column();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.MNTHCBox.DataSource = _context.fn_GetOriginationDateByMonth();
                this.MNTHCBox.DataTextField = "Month";
                this.MNTHCBox.DataValueField = "Month";
                this.MNTHCBox.DataBind();
                this.MNTHCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                Dictionary<string, string> ListOfFields = GetStatistics(null, _DisplayFields);
                this.lstFields.Items.Clear();
                foreach (KeyValuePair<string, string> obj2 in ListOfFields)
                {
                    this.lstFields.Items.Insert(0, new ListItem(obj2.Key, obj2.Key));
                }



                FillChart(GetStatistics(null, _DisplayFields), _DisplayFields);
            }
        }

        protected Dictionary<string, string> GetStatistics(object date, List<string> _DisplayFields)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            int _totalclosed = 0;
            int _totalcancelled = 0;
            int _totalopened = 0;

            List<LINQConnection.ChangeControlNote> obj;

            if (date == null)
            {
                obj = _context.ChangeControlNotes.Select(CCN => CCN).ToList();
            }
            else
            {
                obj = _context.ChangeControlNotes.Where(CCN => CCN.OriginationDate.Month == ((DateTime)date).Month && CCN.OriginationDate.Year == ((DateTime)date).Year).Select(CCN => CCN).ToList();
            }

            foreach (var ccn in obj)
            {
                switch ((CCNStatus)ccn.CCNStatusID)
                {
                    case CCNStatus.Open:
                        _totalopened += 1;
                        break;
                    case CCNStatus.Closed:
                        _totalclosed += 1;
                        break;
                    case CCNStatus.Cancelled:
                        _totalcancelled += 1;
                        break;
                }
            }

            if (_DisplayFields != null)
            {
                if (_DisplayFields.First() == "ALL")
                {
                    statistics.Add("Open", _totalopened.ToString());
                    statistics.Add("Closed", _totalclosed.ToString());
                    statistics.Add("Cancelled", _totalcancelled.ToString());
                }
                else
                {
                    if (_DisplayFields.Contains("Open"))
                        statistics.Add("Open", _totalopened.ToString());

                    if (_DisplayFields.Contains("Closed"))
                        statistics.Add("Closed", _totalclosed.ToString());
                    if (_DisplayFields.Contains("Cancelled"))
                        statistics.Add("Cancelled", _totalcancelled.ToString());
                }
            }



           

            return statistics;
        }

        protected void FillChart(Dictionary<string, string> data ,List<string> _DisplayFields)
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

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "DCR Metrics Per Status", "", "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected void MNTHCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = GetStatistics(null, _DisplayFields);
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj2 in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj2.Key, obj2.Key));
            }

            DropDownList obj = (DropDownList)sender;
            if (obj.SelectedItem.Value != "-1")
            {
                DateTime orgdate = DateTime.Parse(obj.SelectedValue);
                FillChart(GetStatistics(orgdate, _DisplayFields), _DisplayFields);
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
            if (this.MNTHCBox.SelectedItem.Value != "-1")
            {
                DateTime orgdate = DateTime.Parse(this.MNTHCBox.SelectedItem.Value);
                FillChart(GetStatistics(orgdate, _DisplayFields), _DisplayFields);

            }
            else
                FillChart(GetStatistics(null, _DisplayFields), _DisplayFields);
        }
        protected void alias_Click(object sender, EventArgs e)
        {
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            Dictionary<string, string> ListOfFields = GetStatistics(null, _DisplayFields);
            this.lstFields.Items.Clear();
            foreach (KeyValuePair<string, string> obj in ListOfFields)
            {
                this.lstFields.Items.Insert(0, new ListItem(obj.Key, obj.Key));
            }
          
            FillChart(GetStatistics(null, _DisplayFields), _DisplayFields);
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}