using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Session["Permissions"] != null)
                {
                    this.PRMSS.Value = Session["Permissions"].ToString();

                    string permissions = Session["Permissions"].ToString();

                    //load securables
                    ScriptManager.RegisterStartupScript(Page, GetType(), "PermissionLoad", "refreshMain('" + permissions + "');", true);
                }

                else
                {
                    //redirect to login page
                    Response.Redirect("~/Login.aspx", true);
                }
                
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}