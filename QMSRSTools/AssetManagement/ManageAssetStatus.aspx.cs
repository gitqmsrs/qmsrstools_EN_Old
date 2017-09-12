using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AssetManagement
{
    public partial class ManageAssetStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable status = new DataTable();
                status.Columns.Add("StatusID");
                status.Columns.Add("Status");
                status.Columns.Add("Description");

                status.Rows.Add();

                this.gvStatus.DataSource = status;
                this.gvStatus.DataBind();
            }
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}