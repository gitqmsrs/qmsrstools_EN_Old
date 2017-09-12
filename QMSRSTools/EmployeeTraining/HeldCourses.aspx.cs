using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.EmployeeTraining
{
    public partial class HeldCourses : System.Web.UI.Page
    {

        private string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private PieXml_Manager oXml_Manager = new PieXml_Manager();
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();

        private int _completed;
        private int _notcompleted;
        private int _total;


        private double _heldAVG;
        private double _notheldAVG;
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                this.YRCBox.DataSource = _context.fn_GetStartDateByYear();
                this.YRCBox.DataTextField = "Year";
                this.YRCBox.DataValueField = "Year";
                this.YRCBox.DataBind();
                this.YRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");

                FillChart(null, _DisplayFields);
            }
        }
        protected void FillChart(object year, List<string> _DisplayFields)
        {
            Session["Guid"] = null;

            if (year != null)
            {
                _completed = _context.TrainingCourses.Where(CRS => CRS.CourseStatusID == (int)CourseStatus.Completed && CRS.StartDate.Year == Convert.ToInt32(year))
                .Select(CRS => CRS).ToList().Count();

                _notcompleted = _context.TrainingCourses.Where(CRS => CRS.CourseStatusID != (int)CourseStatus.Completed && CRS.StartDate.Year == Convert.ToInt32(year))
                .Select(CRS => CRS).ToList().Count();

                _total = _context.TrainingCourses.Where(CRS=>CRS.StartDate.Year==Convert.ToInt32(year)).Count();
           
            }
            else
            {
                _completed = _context.TrainingCourses.Where(CRS => CRS.CourseStatusID == (int)CourseStatus.Completed && CRS.StartDate.Year == DateTime.Now.Year)
                .Select(CRS => CRS).ToList().Count();

                _notcompleted = _context.TrainingCourses.Where(CRS => CRS.CourseStatusID != (int)CourseStatus.Completed && CRS.StartDate.Year == DateTime.Now.Year)
                .Select(CRS => CRS).ToList().Count();

                _total = _context.TrainingCourses.Where(CRS => CRS.StartDate.Year == DateTime.Now.Year).Count();
    
            }
            #region Calculations

           
            _heldAVG = (Convert.ToDouble(_completed) / Convert.ToDouble(_total)) * 100;
            _notheldAVG = (Convert.ToDouble(_notcompleted) / Convert.ToDouble(_total)) * 100;

            #endregion

            PieXml_Manager.Column oColumn = new PieXml_Manager.Column();
          
            if (_DisplayFields != null)
            {
                if (_DisplayFields.First() == "ALL")
                {
                        oColumn.Color = Colors[0];
                        oColumn.Name = "Held";
                        oColumn.Value = String.Format("{0:0.00}", _heldAVG);
                        oXml_Manager.columns.Add(oColumn);

                        oColumn = new PieXml_Manager.Column();
                        oColumn.Color = Colors[1];
                        oColumn.Name = "Not Held (Covers Active, Cancelled, Created, and Scheduled)";
                        oColumn.Value = String.Format("{0:0.00}", _notheldAVG);
                        oXml_Manager.columns.Add(oColumn);

                }

                else
                {

                    if (_DisplayFields.Contains("Held"))
                    {
                        oColumn.Color = Colors[0];
                        oColumn.Name = "Held";
                        oColumn.Value = String.Format("{0:0.00}", _heldAVG);
                        oXml_Manager.columns.Add(oColumn);


                    }
                    if (_DisplayFields.Contains("Not Held"))
                    {

                        oColumn = new PieXml_Manager.Column();
                        oColumn.Color = Colors[1];
                        oColumn.Name = "Not Held (Covers Active, Cancelled, Created, and Scheduled)";
                        oColumn.Value = String.Format("{0:0.00}", _notheldAVG);
                        oXml_Manager.columns.Add(oColumn);
                    }


                }
            }


            if (year == null)
            {
                oXml_Manager.CraeteXmlFile(Server.MapPath(""), "Average of Held/Not Held Training Courses", "Current Year", "", "");
            }
            else
            {
                oXml_Manager.CraeteXmlFile(Server.MapPath(""), "Average of Held/Not Held Training Courses", "Year " + Convert.ToInt32(year), "", "");
           
            }
            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected void YRCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";

            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");

            DropDownList obj = (DropDownList)sender;
            if (obj.SelectedItem.Value != "-1")
            {
                FillChart(Convert.ToInt32(obj.SelectedValue), _DisplayFields);
            }

        }
        protected void alias_Click(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "reset";

            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            FillChart(null, _DisplayFields);
        }


        protected void Search_Click(object sender, ImageClickEventArgs e)
        {

            List<string> _DisplayFields = new List<string>();
            this.dropdownchange.Value = "CLICK";


            foreach (ListItem listitems in lstFields.Items)
            {
                if (listitems.Selected == true)
                    _DisplayFields.Add(listitems.Value);

            }
            if (_DisplayFields.Count == 0)
            {
                _DisplayFields = null;
            }

            FillChart(Convert.ToInt32(this.YRCBox.SelectedValue), _DisplayFields);

        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}