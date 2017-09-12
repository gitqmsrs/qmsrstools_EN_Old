using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AuditManagement
{
    public partial class EditAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable actions = new DataTable();
                actions.Columns.Add("AuditID");
                actions.Columns.Add("FindingID");
                actions.Columns.Add("ActionID");
                actions.Columns.Add("AuditType");
                actions.Columns.Add("PlannedAuditDate");
                actions.Columns.Add("Finding");
                actions.Columns.Add("ActionType");
                actions.Columns.Add("TargetClosingDate");
                actions.Columns.Add("DelayedDate");
                actions.Columns.Add("CompletedDate");
                actions.Columns.Add("Actionee");
                actions.Columns.Add("AuditStatus");
                actions.Columns.Add("ActionStatus");
                actions.Rows.Add();

                this.gvActions.DataSource = actions;
                this.gvActions.DataBind();
            }
        }
    }
}