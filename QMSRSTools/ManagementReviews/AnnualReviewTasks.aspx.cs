using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.ManagementReviews
{
    public partial class AnnualReviewTasks : System.Web.UI.Page
    {
        private string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private PieXml_Manager oXml_Manager = new PieXml_Manager();
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                this.YRCBox.DataSource = _context.fn_GetPlannedClosedTasksByYear();
                this.YRCBox.DataTextField = "Year";
                this.YRCBox.DataValueField = "Year";
                this.YRCBox.DataBind();
                this.YRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChart(FilterByYear(DateTime.Now.Year), DateTime.Now.Year, _DisplayFields);
            }
        }

        protected void FillChart(Dictionary<string, string> data, int year, List<string> _DisplayFields)
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

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Annual Review Task Status", "Year " + year.ToString(), "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected Dictionary<string, string> FilterByYear(int year)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var causeList = _context.Causes.Where(CUS => CUS.RootCauseID == null).Select(CUS => CUS).ToList();

            int _open = _context.Tasks.Where(TSK => TSK.IsClosed == false && TSK.PlannedCloseDate.Year==year).Count();
            int _closed = _context.Tasks.Where(TSK => TSK.IsClosed == true && TSK.PlannedCloseDate.Year == year).Count();

            statistics.Add("Open", _open.ToString());
            statistics.Add("Closed", _closed.ToString());

           
            return statistics;
        }

        protected void YRCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "YRCBox";

            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            if (this.YRCBox.SelectedValue!= "-1")
                FillChart(FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text)), Convert.ToInt32(this.YRCBox.SelectedItem.Text), _DisplayFields);
            else
                FillChart(FilterByYear(DateTime.Now.Year), DateTime.Now.Year, _DisplayFields);
        }

        protected void alias_Click(object sender, EventArgs e)
        {
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            FillChart(FilterByYear(DateTime.Now.Year), DateTime.Now.Year, _DisplayFields);
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
                if (Convert.ToInt32(this.YRCBox.SelectedItem.Value) != -1)
                {
                    FillChart(FilterByYear(Convert.ToInt32(this.YRCBox.SelectedItem.Text)), Convert.ToInt32(this.YRCBox.SelectedItem.Text), _DisplayFields);
                }

            }
            else
            {
                FillChart(FilterByYear(DateTime.Now.Year), DateTime.Now.Year, _DisplayFields);
            }

        }

    }
}