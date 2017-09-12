using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security;
using System.Web.Security;

namespace QMSRSTools
{
    public partial class TerminateSession : System.Web.UI.Page
    {
        private DBService _service = new DBService();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] != null)
            {
                _service.deactivateEmployeeSession(Convert.ToInt32(Session["EmployeeID"]));
            }

            //Abandon Session, this will trigger event session_end in global.asax
            Session.Abandon();

            FormsAuthentication.SignOut();
   
            if (Request.QueryString["redirect"] != null && Convert.ToBoolean(Request.QueryString["redirect"]) == true)
            {
                Response.Redirect("~/Login.aspx", true);
            }
        }
    }
}