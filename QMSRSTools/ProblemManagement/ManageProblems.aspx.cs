using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class ManageProblems : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable problems = new DataTable();
                problems.Columns.Add("CaseNo");
                problems.Columns.Add("PRMTitle");
                problems.Columns.Add("PRMType");
                problems.Columns.Add("AFFCTPRTYType");
                problems.Columns.Add("Originator");
                problems.Columns.Add("OriginationDate");
                problems.Columns.Add("TargetCloseDate");
                problems.Columns.Add("ActualCloseDate");
                problems.Columns.Add("Status");
                problems.Columns.Add("RECMode");

                problems.Rows.Add();

                this.gvProblems.DataSource = problems;
                this.gvProblems.DataBind();


                DataTable customers = new DataTable();
                customers.Columns.Add("CustomerNo");
                customers.Columns.Add("CustomerType");
                customers.Columns.Add("CustomerName");
                customers.Columns.Add("EmailAddress");

                customers.Rows.Add();


                this.gvCustomers.DataSource = customers;
                this.gvCustomers.DataBind();
            }
        }
    }
}