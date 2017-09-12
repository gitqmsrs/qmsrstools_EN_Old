using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.EmployeeManagement
{
    public partial class CreateEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable contacts = new DataTable();
            contacts.Columns.Add("ID"); 
            contacts.Columns.Add("ContactNo");
            contacts.Columns.Add("ContactType");
            contacts.Rows.Add();

            this.gvContacts.DataSource = contacts;
            this.gvContacts.DataBind();

        }
    }
}