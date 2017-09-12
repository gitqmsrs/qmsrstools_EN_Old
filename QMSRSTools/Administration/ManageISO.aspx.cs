using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageISO : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable standard = new DataTable();
                standard.Columns.Add("StandardID");
                standard.Columns.Add("Standard");
                standard.Columns.Add("Description");
                standard.Rows.Add();

                this.gvISOStandards.DataSource = standard;
                this.gvISOStandards.DataBind();
            }
        }
    }
}