using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageSMTP : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable servers = new DataTable();
                servers.Columns.Add("SMTPID");
                servers.Columns.Add("SMTPServer");

                servers.Rows.Add();

                this.gvSMTPServer.DataSource = servers;
                this.gvSMTPServer.DataBind();
            }
        }
    }
}