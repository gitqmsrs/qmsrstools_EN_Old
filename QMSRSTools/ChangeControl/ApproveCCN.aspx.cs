using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ChangeControl
{
    public partial class ApproveCCN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.EMPTxt.Text = HttpContext.Current.User.Identity.Name;

                DataTable ccn = new DataTable();
                ccn.Columns.Add("Version");
                ccn.Columns.Add("CCNType");
                ccn.Columns.Add("Originator");
                ccn.Columns.Add("Owner");
                ccn.Columns.Add("OrginationDate");
                ccn.Columns.Add("ApprovalStatus");
                ccn.Columns.Add("CCNStatus");
                ccn.Rows.Add();


                this.gvCCN.DataSource = ccn;
                this.gvCCN.DataBind();
            }
        }
    }
}