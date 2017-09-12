using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageEmailTemplate : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable emails = new DataTable();
                emails.Columns.Add("EmailID");
                emails.Columns.Add("Module");
                emails.Columns.Add("Action");
                emails.Columns.Add("Subject");
                emails.Columns.Add("EmailFrom");
                emails.Columns.Add("SMTPServer");

                emails.Rows.Add();

                this.gvEmails.DataSource = emails;
                this.gvEmails.DataBind();
            }
        }
    }
}