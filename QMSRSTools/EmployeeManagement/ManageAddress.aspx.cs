using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeManagement
{
    public partial class ManageAddress : System.Web.UI.Page
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

                DataTable address = new DataTable();
                address.Columns.Add("Address1");
                address.Columns.Add("Address2");
                address.Columns.Add("Country");
                address.Columns.Add("City");
                address.Columns.Add("PostalCode");
                address.Rows.Add();

                this.gvAddress.DataSource = address;
                this.gvAddress.DataBind();
            }
        }
    }
}