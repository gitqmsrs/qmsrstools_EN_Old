using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageRAGCondition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable conditions = new DataTable();
                conditions.Columns.Add("RAGID");
                conditions.Columns.Add("Module");
                conditions.Columns.Add("Condition");

                conditions.Rows.Add();

                this.gvCondition.DataSource = conditions;
                this.gvCondition.DataBind();
            }
        }
    }
}