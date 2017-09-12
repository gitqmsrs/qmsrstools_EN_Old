using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ManagementReviews
{
    public partial class CreateTaskAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable reviews = new DataTable();
                reviews.Columns.Add("ReviewNo");
                reviews.Columns.Add("EventName");
                reviews.Columns.Add("PlannedReviewDate");
                reviews.Columns.Add("ActualReviewDate");
                reviews.Columns.Add("ActualCloseDate");
                reviews.Columns.Add("ReviewStatus");

                reviews.Rows.Add();


                this.gvReviews.DataSource = reviews;
                this.gvReviews.DataBind();
            }
        }
    }
}