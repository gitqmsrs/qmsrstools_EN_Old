using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AuditManagement
{
    public partial class ManageFindingType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable type = new DataTable();
                type.Columns.Add("FindingTypeID");
                type.Columns.Add("FindingType");
                type.Columns.Add("Description");

                type.Rows.Add();

                this.gvFindingType.DataSource = type;
                this.gvFindingType.DataBind();
            }
        }
    }
}