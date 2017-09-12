using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AuditManagement
{
    public partial class EditFinding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable finding = new DataTable();
                finding.Columns.Add("AuditID");
                finding.Columns.Add("FindingID");
                finding.Columns.Add("AuditType");
                finding.Columns.Add("PlannedAuditDate");
                finding.Columns.Add("Finding");
                finding.Columns.Add("FindingType");
                finding.Columns.Add("ISOChecklist");
                finding.Columns.Add("AuditStatus");
                finding.Columns.Add("Mode");
                finding.Rows.Add();

                this.gvFinding.DataSource = finding;
                this.gvFinding.DataBind();
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}