using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AssetManagement
{
    public partial class ManageAsset : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable assets = new DataTable();
                assets.Columns.Add("TAG");
                assets.Columns.Add("Category");
                assets.Columns.Add("Supplier");
                assets.Columns.Add("Owner");
                assets.Columns.Add("Price");
                assets.Columns.Add("PurchaseDate");
                assets.Columns.Add("InstallationDate");
                assets.Columns.Add("Unit");
                assets.Columns.Add("Status");
                assets.Columns.Add("RECMode");
                assets.Rows.Add();

                this.gvAsset.DataSource = assets;
                this.gvAsset.DataBind();
            }
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}