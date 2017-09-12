using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeTraining
{
    public partial class CourseFeedbackStatistics : System.Web.UI.Page
    {
        string[] Colors = { "ff0000", "ffcc00", "33cc00", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
    
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.CRSNMCBox.DataSource = _context.TrainingCourses;
                this.CRSNMCBox.DataTextField = "Title";
                this.CRSNMCBox.DataValueField = "CourseNo";
                this.CRSNMCBox.DataBind();
                this.CRSNMCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");

                GetStatisticsByCourseNumber("-1", _DisplayFields);

            }
        }

        protected void GetStatisticsByCourseNumber(string courseno, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable FeedStatistics = new DataTable();
            FeedStatistics.Columns.Add("Feedback");
            FeedStatistics.Columns.Add("Count");

            double provided = 0;
            double notprovided = 0;



            var course = _context.TrainingCourses.Where(CRS => CRS.CourseNo == courseno).Select(CRS => CRS).SingleOrDefault();

            if (course != null)
            {
                foreach (var enroller in course.TrainingCourseEnrollments)
                {
                    if (enroller.HasProvidedFeedback == true)
                    {
                        provided += 1;
                    }
                    else
                    {
                        notprovided += 1;
                    }
                }
            }

            double Total = provided + notprovided;

            DataRow row;

           


            if (_DisplayFields != null)
            {
                if (_DisplayFields.First() == "ALL")
                {
                    row = FeedStatistics.NewRow();
                    row["Feedback"] = "Provided Feedback";
                    row["Count"] = String.Format("{0:0.00}", provided == 0.0 ? 0.0 : ((provided / Total) * 100));
                    FeedStatistics.Rows.Add(row);

                    row = FeedStatistics.NewRow();
                    row["Feedback"] = "Didn't Provided Feedback";
                    row["Count"] = String.Format("{0:0.00}", notprovided == 0.0 ? 0.0 : ((notprovided / Total) * 100));
                    FeedStatistics.Rows.Add(row);

                }
                else
                {
                   
                    if (_DisplayFields.Contains("Provided Feedback"))
                    {
                        row = FeedStatistics.NewRow();
                        row["Feedback"] = "Provided Feedback";
                        row["Count"] = String.Format("{0:0.00}", provided == 0.0 ? 0.0 : ((provided / Total) * 100));
                        FeedStatistics.Rows.Add(row);

                    }
                    if (_DisplayFields.Contains("Didn't Provided Feedback"))
                    {

                        row = FeedStatistics.NewRow();
                        row["Feedback"] = "Didn't Provided Feedback";
                        row["Count"] = String.Format("{0:0.00}", notprovided == 0.0 ? 0.0 : ((notprovided / Total) * 100));
                        FeedStatistics.Rows.Add(row);

                    }
                

                }
            }


            PieXml_Manager oXml_Manager = new PieXml_Manager();
            PieXml_Manager.Column oColumn = new PieXml_Manager.Column();

            int index = 0;

            //int indexcol = 0;
            if (FeedStatistics.Rows.Count > 0)
            {
                foreach (DataRow r in FeedStatistics.Rows)
                {
                    if (index > 19)
                    {
                        index = 0;
                    }

                    oColumn = new PieXml_Manager.Column();
                    oColumn.Color = Colors[index++];
                    oColumn.Name = r.ItemArray[0].ToString();
                    oColumn.Value = r.ItemArray[1].ToString();
                    oXml_Manager.columns.Add(oColumn);
                }
            }

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Statistics of Course Feedback", "", "", "");
            Session["Guid"] = oXml_Manager.strGuid;
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

            GetStatisticsByCourseNumber(this.CRSNMCBox.SelectedItem.Value, _DisplayFields);

        }


        protected void Reset_Click(object sender, EventArgs e)
        {
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");

            GetStatisticsByCourseNumber("-1", _DisplayFields);
        
        }

        protected void CRSNMCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
           
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");

            DropDownList obj = (DropDownList)sender;
            GetStatisticsByCourseNumber(obj.SelectedItem.Value, _DisplayFields);
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}