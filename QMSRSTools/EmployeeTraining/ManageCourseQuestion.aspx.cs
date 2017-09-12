using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeTraining
{
    public partial class ManageCourseQuestion : System.Web.UI.Page
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



                DataTable question = new DataTable();
                question.Columns.Add("Question");
                question.Columns.Add("QuestionMode");
                question.Rows.Add();

                this.gvQuestions.DataSource = question;
                this.gvQuestions.DataBind();
            }
        }
    }
}