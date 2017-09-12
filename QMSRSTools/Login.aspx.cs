using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using LINQConnection;
using LicenseLINQConnection;
namespace QMSRSTools
{
    public partial class Login : System.Web.UI.Page
    {
        private QMSRSContextDataContext _context = new QMSRSContextDataContext();
        private LicenseMGRDataContext _licensecontext = new LicenseMGRDataContext();

        private PasswordHash _hash = new PasswordHash();
        private string _permissions;
        private SystemUser _userrecord = null;
        private DBService service = new DBService();

     
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.USRTYPCBox.DataSource = _context.SystemUserTypes;
                this.USRTYPCBox.DataTextField = "UserType";
                this.USRTYPCBox.DataValueField = "UserTypeID";
                this.USRTYPCBox.DataBind();
                this.USRTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));
            }
        }


        private bool validateUser()
        {

            bool validated = false;

            if (this.USRTYPCBox.SelectedItem.Text == "Employee Account")
            {
                _userrecord = _context.SystemUsers.Where(USR => USR.Employee.PersonnelID == this.loginusr.Text.Trim() && USR.UserTypeID == Convert.ToInt32(this.USRTYPCBox.SelectedItem.Value))
               .Select(USR => USR).SingleOrDefault();
            }
            else
            {
                _userrecord = _context.SystemUsers.Where(USR => USR.UserName == this.loginusr.Text.Trim() && USR.UserTypeID == Convert.ToInt32(this.USRTYPCBox.SelectedItem.Value))
               .Select(USR => USR).SingleOrDefault();
            }

            if (_userrecord != null)
            {
                List<SystemUserPermission> permissions = _context.SystemUserPermissions.Where(PRM => PRM.UserID == _userrecord.UserID)
                .Select(PRM => PRM).ToList();

                for (int i = 0; i < permissions.Count; i++)
                {
                    if (i == 0)
                    {
                        _permissions += permissions[i].SecurityKeyID;
                    }
                    else
                    {
                        _permissions += "," + permissions[i].SecurityKeyID;
                    }
                }

                if (this._hash.VerifyPassword(this.loginpw.Text, _userrecord.UserPassword.ToArray()))
                {
                    validated = true;
                }
                else
                {
                    validated = false;
                }
            }
            else
            {
                validated = false;
            }
            return validated;
        }

        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            if (validateUser())
            {
                //if (service.getTotalUsers() > service.getCurrentUsers())
                //{
                    FormsAuthenticationTicket ticket;

                    if (this.USRTYPCBox.SelectedItem.Text == "Employee Account")
                    {


                        var employee = _context.Employees.Where(EMP => EMP.PersonnelID == this.loginusr.Text.Trim())
                            .Select(EMP => EMP).SingleOrDefault();


                        FormsAuthentication.SetAuthCookie(employee.FirstName + " " + employee.LastName, false);

                        ticket = new FormsAuthenticationTicket(1,
                                                                                employee.FirstName + " " + employee.LastName,
                                                                                DateTime.Now,
                                                                                DateTime.Now.AddMinutes(29),
                                                                                false,
                                                                                "");

                        //store the ID of the employee throughout the lifecycle of the session;
                        Session["EmployeeID"] = employee.EmployeeID;

                        //store the current session ID for the employee
                        service.activateEmployeeSession(Convert.ToInt32(Session["EmployeeID"]));

                    }
                    else
                    {
                        FormsAuthentication.SetAuthCookie(this.loginusr.Text.Trim(), false);

                        ticket = new FormsAuthenticationTicket(1,
                                                                                this.loginusr.Text.Trim(),
                                                                                DateTime.Now,
                                                                                DateTime.Now.AddMinutes(29),
                                                                                false,
                                                                                "");

                    }

                    HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName,
                                                    FormsAuthentication.Encrypt(ticket));

                    Response.Cookies.Add(cookie);

                    string returnURL;

                    if (Request.QueryString["ReturnUrl"] == null)
                    {
                        returnURL = "~/Default.aspx";
                    }
                    else
                    {
                        returnURL = Request.QueryString["ReturnUrl"];
                    }

                    Session["Permissions"] = _permissions;

                    string timeZone = hfTimeZone.Value.ToString();
                    if (timeZone == "Russia Standard Time")
                    {
                        timeZone = "Russian Standard Time";
                    }
                    Session["CurrentTimeZone"] = timeZone;

                    //TimeZone zone = TimeZone.CurrentTimeZone;
                    //HttpContext.Current.Session["CurrentTimeZone"] = timeZone;
                    Response.Redirect(returnURL);
                //}
                //else
                //{
                //    this.Error.Text = "The current active users has exceeded the user quote";
                //}
            }
            else
            {
                this.Error.Text = "Invalid User Name or Password";
            }
        }
    }
}