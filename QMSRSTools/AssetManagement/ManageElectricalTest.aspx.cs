using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AssetManagement
{
    public partial class ManageElectricalTest : System.Web.UI.Page
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
                assets.Columns.Add("HasElectrical");
                assets.Columns.Add("Status");
                assets.Columns.Add("RECMode");
                assets.Rows.Add();

                this.gvAssets.DataSource = assets;
                this.gvAssets.DataBind();

                DataTable suppliers = new DataTable();
                suppliers.Columns.Add("CustomerNo");
                suppliers.Columns.Add("CustomerType");
                suppliers.Columns.Add("CustomerName");


                suppliers.Rows.Add();

                this.gvSuppliers.DataSource = suppliers;
                this.gvSuppliers.DataBind();

            }
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }

    }
}