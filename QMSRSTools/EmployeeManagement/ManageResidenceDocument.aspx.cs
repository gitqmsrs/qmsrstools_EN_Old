using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeManagement
{
    public partial class ManageResidenceDocument : System.Web.UI.Page
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

                DataTable residence = new DataTable();
                residence.Columns.Add("DocumentID");
                residence.Columns.Add("ValidFrom");
                residence.Columns.Add("ValidTo");
                residence.Columns.Add("ResidenceType");
                residence.Columns.Add("ResidenceStatus");
                residence.Rows.Add();

                this.gvResidence.DataSource = residence;
                this.gvResidence.DataBind();
            }
        }
    }
}