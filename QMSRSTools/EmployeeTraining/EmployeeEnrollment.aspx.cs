using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeTraining
{
    public partial class EmployeeEnrollment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable course = new DataTable();
                course.Columns.Add("CourseNo");
                course.Columns.Add("Title");
                course.Columns.Add("StartDate");
                course.Columns.Add("EndDate");
                course.Columns.Add("Duration");
                course.Columns.Add("Capacity");
                course.Columns.Add("Coordinator");
                course.Columns.Add("Status");
                course.Columns.Add("Mode");
                course.Rows.Add();


                this.gvCourses.DataSource = course;
                this.gvCourses.DataBind();


                DataTable enrollers = new DataTable();
                enrollers.Columns.Add("CourseNo");
                enrollers.Columns.Add("Title");
                enrollers.Columns.Add("StartDate");
                enrollers.Columns.Add("Enroller");
                enrollers.Columns.Add("EnrollerLevel");
                enrollers.Columns.Add("AttendanceStatus");
                enrollers.Columns.Add("Feedback");
                enrollers.Rows.Add();


                this.gvEnrollers.DataSource = enrollers;
                this.gvEnrollers.DataBind();
            }
        }
    }
}