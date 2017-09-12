using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageDocumentFileType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable doctype = new DataTable();
                doctype.Columns.Add("DocFTypeID");
                doctype.Columns.Add("ContentType");
                doctype.Columns.Add("Extension");
                doctype.Columns.Add("FileType");
                doctype.Rows.Add();

                this.gvDocFType.DataSource = doctype;
                this.gvDocFType.DataBind();
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}