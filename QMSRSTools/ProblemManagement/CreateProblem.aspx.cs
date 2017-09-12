using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class CreateProblem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
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