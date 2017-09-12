using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ManagementReviews
{
    public partial class ManageTask : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable tasks = new DataTable();
                tasks.Columns.Add("ReviewNo");
                tasks.Columns.Add("EventName");
                tasks.Columns.Add("PlannedReviewDate");
                tasks.Columns.Add("TaskName");
                tasks.Columns.Add("Owner");
                tasks.Columns.Add("PlannedCloseDate");
                tasks.Columns.Add("ActualCloseDate");
                tasks.Columns.Add("IsClosed");
                tasks.Columns.Add("RECMode");
                tasks.Rows.Add();

                this.gvTasks.DataSource = tasks;
                this.gvTasks.DataBind();
            }
        }
    }
}