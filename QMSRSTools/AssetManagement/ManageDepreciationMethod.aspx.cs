using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AssetManagement
{
    public partial class ManageDepreciationMethod : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable method = new DataTable();
                method.Columns.Add("MethodID");
                method.Columns.Add("MethodName");
                method.Columns.Add("Description");

                method.Rows.Add();

                this.gvDepreciation.DataSource = method;
                this.gvDepreciation.DataBind();
            }
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }

    }
}