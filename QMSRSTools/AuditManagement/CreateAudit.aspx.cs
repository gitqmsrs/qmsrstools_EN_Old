using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AuditManagement
{
    public partial class CreateAudit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable auditors = new DataTable();
                auditors.Columns.Add("EmployeeName");
                auditors.Rows.Add();

                this.gvAuditors.DataSource = auditors;
                this.gvAuditors.DataBind();

                DataTable suppliers = new DataTable();
                suppliers.Columns.Add("CustomerNo");
                suppliers.Columns.Add("CustomerType");
                suppliers.Columns.Add("CustomerName");
                suppliers.Columns.Add("EmailAddress");
             

                suppliers.Rows.Add();

                this.gvSuppliers.DataSource = suppliers;
                this.gvSuppliers.DataBind();

                DataTable projects = new DataTable();
                projects.Columns.Add("PROJNo");
                projects.Columns.Add("PROJName");
                projects.Columns.Add("StartDate");
                projects.Columns.Add("PlannedCloseDate");
                projects.Columns.Add("ActualCloseDate");
                projects.Columns.Add("Leader");
                projects.Columns.Add("Value");
                projects.Columns.Add("Cost");
                projects.Columns.Add("Status");

                projects.Rows.Add();

                this.gvProjects.DataSource = projects;
                this.gvProjects.DataBind();
            }
        }
    }
}