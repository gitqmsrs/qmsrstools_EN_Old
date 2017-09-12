using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ManagementReviews
{
    public partial class CreateReview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable representatives = new DataTable();
                representatives.Columns.Add("EmployeeName");
                representatives.Rows.Add();

                this.gvReprsentative.DataSource = representatives;
                this.gvReprsentative.DataBind();
            }
        }
    }
}