using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AssetManagement
{
    public partial class ManageDepreciation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable assets = new DataTable();
                assets.Columns.Add("TAG");
                assets.Columns.Add("Model");
                assets.Columns.Add("AssetCategory");
                assets.Columns.Add("PurchasePrice");
                assets.Columns.Add("Manufacturer");
                assets.Columns.Add("Status");
                assets.Columns.Add("RECMode");

                assets.Rows.Add();


                this.gvAssets.DataSource = assets;
                this.gvAssets.DataBind();

                DataTable depreciation = new DataTable();
                depreciation.Columns.Add("DepreciationDate");
                depreciation.Columns.Add("Amount");
                depreciation.Columns.Add("CurrentAssetValue");
                depreciation.Columns.Add("AccumulativeDepreciation");
                depreciation.Columns.Add("Currency");
                depreciation.Rows.Add();


                this.gvDepreciation.DataSource = depreciation;
                this.gvDepreciation.DataBind();
            }
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}