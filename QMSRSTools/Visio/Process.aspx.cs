using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.Visio
{
    public partial class Process : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string visiosource = string.Empty;

                if (Request.QueryString["source"] != null)
                {
                    visiosource = Request.QueryString["source"];
                }

                ScriptManager.RegisterStartupScript(Page, GetType(), "RunViewer", "setVisioDiagram('" + visiosource + "');", true);
            }
        }
    }
}