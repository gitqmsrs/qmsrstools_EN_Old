using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.QualityRecords
{
    public partial class ManageRecords : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable qr = new DataTable();
                qr.Columns.Add("RecordNo");
                qr.Columns.Add("Title");
                qr.Columns.Add("Department");
                qr.Columns.Add("Originator");
                qr.Columns.Add("Owner");
                qr.Columns.Add("IssueDate");
                qr.Columns.Add("ReviewDate");
                qr.Columns.Add("ReviewDuration");
                qr.Columns.Add("RetentionDuration");
                qr.Columns.Add("Status");
                qr.Rows.Add();


                this.gvQR.DataSource = qr;
                this.gvQR.DataBind();
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}