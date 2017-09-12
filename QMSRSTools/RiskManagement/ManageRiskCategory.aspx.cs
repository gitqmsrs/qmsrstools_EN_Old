using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class ManageRiskCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable category = new DataTable();
                category.Columns.Add("CategoryID");
                category.Columns.Add("Category");
                category.Columns.Add("Description");
                category.Rows.Add();

                this.gvCategories.DataSource = category;
                this.gvCategories.DataBind();
            }
        }
    }
}