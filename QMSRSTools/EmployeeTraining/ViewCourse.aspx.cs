using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeTraining
{
    public partial class ViewCourse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.EMPTxt.Text = HttpContext.Current.User.Identity.Name;

                DataTable course = new DataTable();
                course.Columns.Add("CourseNo");
                course.Columns.Add("Title");
                course.Columns.Add("StartDate");
                course.Columns.Add("EndDate");
                course.Columns.Add("Duration");
                course.Columns.Add("Capacity");
                course.Columns.Add("Coordinator");
                course.Columns.Add("Status");
                course.Columns.Add("ATTStatus");
                course.Columns.Add("Feedback");
                course.Rows.Add();

                this.gvCourses.DataSource = course;
                this.gvCourses.DataBind();
            }
        }
    }
}