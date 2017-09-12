using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ManagementReviews
{
    public partial class ManageTaskAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable actions = new DataTable();
                actions.Columns.Add("EventName");
                actions.Columns.Add("PlannedReviewDate");
                actions.Columns.Add("Task");
                actions.Columns.Add("ActionType");
                actions.Columns.Add("TargetClosingDate");
                actions.Columns.Add("DelayedDate");
                actions.Columns.Add("CompletedDate");
                actions.Columns.Add("Actionee");
                actions.Columns.Add("ActionStatus");
                actions.Columns.Add("RECMode");
                actions.Rows.Add();

                this.gvActions.DataSource = actions;
                this.gvActions.DataBind();
            }
        }
    }
}