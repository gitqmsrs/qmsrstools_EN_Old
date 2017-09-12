using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageAuthorization : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable users = new DataTable();
                users.Columns.Add("UserID");
                users.Columns.Add("Employee");
                users.Columns.Add("UserName");
                users.Columns.Add("AccountType");
                users.Columns.Add("Permissions");
                users.Rows.Add();

                this.gvUsers.DataSource = users;
                this.gvUsers.DataBind();
            }
        }
    }
}