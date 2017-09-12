using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.EmployeeTraining
{
    public partial class UserCourseVenueSchedule : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["courseid"] != null)
                {
                    //load securables
                    ScriptManager.RegisterStartupScript(Page, GetType(), "LoadTimeTable", "loadTimeTable(" + Convert.ToInt32(Request.QueryString["courseid"]) + ");", true);
                }
            }
        }
    }
}