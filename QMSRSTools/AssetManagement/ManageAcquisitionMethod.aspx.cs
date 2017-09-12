using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AssetManagement
{
    public partial class ManageAcquisitionMethod : System.Web.UI.Page
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

                this.gvAcquisition.DataSource = method;
                this.gvAcquisition.DataBind();
            }
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }

    }
}