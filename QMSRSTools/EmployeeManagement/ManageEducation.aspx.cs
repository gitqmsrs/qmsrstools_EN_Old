using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeManagement
{
    public partial class ManageEducation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable employees = new DataTable();
                employees.Columns.Add("PersonnelID");
                employees.Columns.Add("CompleteName");
                employees.Columns.Add("KnownAs");
                employees.Columns.Add("DOB");
                employees.Columns.Add("COB");
                employees.Columns.Add("Gender");
                employees.Columns.Add("Religion");
                employees.Columns.Add("Marital");
                employees.Columns.Add("EmailAddress");
                employees.Rows.Add();

                this.gvEmployees.DataSource = employees;
                this.gvEmployees.DataBind();

                DataTable education = new DataTable();
                education.Columns.Add("Degree");
                education.Columns.Add("Award");
                education.Columns.Add("Mode");
                education.Columns.Add("Institute");
                education.Columns.Add("Duration");
                education.Columns.Add("Grade");
                education.Columns.Add("Location");
                education.Rows.Add();

                this.gvEducation.DataSource = education;
                this.gvEducation.DataBind();
            }
        }
    }
}