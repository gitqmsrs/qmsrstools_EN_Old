using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AuditManagement
{
    public partial class CreateFinding : System.Web.UI.Page
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
                audits.Columns.Add("Mode");

                audits.Rows.Add();


                this.gvAudits.DataSource = audits;
                this.gvAudits.DataBind();
            }

        }
    }
}