using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

namespace QMSRSTools.AuditManagement
{
    public partial class CreateAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable audits = new DataTable();
                audits.Columns.Add("AuditNo");
                audits.Columns.Add("AuditType");
                audits.Columns.Add("PlannedAuditDate");
                audits.Columns.Add("ActualAuditDate");
                audits.Columns.Add("AuditStatus");

                audits.Rows.Add();


                this.gvAudits.DataSource = audits;
                this.gvAudits.DataBind();
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}