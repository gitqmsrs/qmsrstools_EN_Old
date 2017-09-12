using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class CreateMitigationAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable risks = new DataTable();
                risks.Columns.Add("RiskNo");
                risks.Columns.Add("RiskName");
                risks.Columns.Add("RiskType");
                risks.Columns.Add("RiskMode");
                risks.Columns.Add("RegisterDate");
                risks.Columns.Add("Status");

                risks.Rows.Add();

                this.gvRisks.DataSource = risks;
                this.gvRisks.DataBind();
            }
        }
    }
}