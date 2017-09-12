using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageSeverity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable severity = new DataTable();
                severity.Columns.Add("SeverityID");
                severity.Columns.Add("Criteria");
                severity.Columns.Add("Value");
                severity.Columns.Add("Score");
                severity.Rows.Add();

                this.gvSeverity.DataSource = severity;
                this.gvSeverity.DataBind();
            }
        }
    }
}