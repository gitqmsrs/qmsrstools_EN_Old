using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;

namespace QMSRSTools.MasterPage
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session != null)
            {
                SessionContext context = new SessionContext();
                context.UserName = HttpContext.Current.User.Identity.Name;
                context.SessionID = Session.SessionID;

                this.userID.Text = "Welcome " + context.UserName;
                //this.accessTime.Text = "Date and Access Time: " + HttpContext.Current.Timestamp.ToString();
                //this.accessTime.Text = "Date and Access Time: " + TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, TimeZoneInfo.Local);

                string localTimeZone = "Arab Standard Time"; //Session["CurrentTimeZone"].ToString();
                TimeZoneInfo timeZoneInfoLocal = TimeZoneInfo.FindSystemTimeZoneById(localTimeZone);

                //DateTime userTime = DateTime.SpecifyKind(DateTime.Now, DateTimeKind.Unspecified);
                //TimeZoneInfo UserTimeZone = TimeZoneInfo.FindSystemTimeZoneById(localTimeZone);
                //TimeZoneInfo TargetTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Pacific Standard Time");
                //DateTime newTime = TimeZoneInfo.ConvertTime(userTime, UserTimeZone, TargetTimeZone);
                TimeZone zone = TimeZone.CurrentTimeZone;
                this.accessTime.Text = "Date and Access Time: " + TimeZoneInfo.ConvertTimeFromUtc(DateTime.UtcNow, timeZoneInfoLocal);
                //this.accessTime.Text = localTimeZone + " userTime: " + userTime + " newTime: " + newTime;

                //this.accessTime.Text = zone.StandardName;

                //ReadOnlyCollection<TimeZoneInfo> zones = TimeZoneInfo.GetSystemTimeZones();

                ScriptManager.RegisterStartupScript(Page, GetType(), "HomeVisio", "viewHomeProcess();", true);
            }
        }

        
        protected void signout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/TerminateSession.aspx?redirect=true", true);
        }

        protected enum ResolveType { MapPath, ResolveUrl, ResolveClientUrl };
        //------------------------------------------------------------------------------------
        // gets the file date of the currently displayed content page so it can be displayed
        // in the footer.
        //------------------------------------------------------------------------------------
        protected string ResolvePath(string relPath, ResolveType resolveType)
        {
            string path = relPath;
            switch (resolveType)
            {
                case ResolveType.ResolveClientUrl: path = Page.ResolveClientUrl(path); break;
                case ResolveType.ResolveUrl: path = Page.ResolveUrl(path); break;
                case ResolveType.MapPath: path = MapPath(path); break;
            }
            return path;
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}