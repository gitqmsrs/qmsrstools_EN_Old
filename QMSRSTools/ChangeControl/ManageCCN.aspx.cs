using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ChangeControl
{
    public partial class ManageCCN : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable ccn = new DataTable();
                ccn.Columns.Add("DocumentNo");
                ccn.Columns.Add("Title");
                ccn.Columns.Add("DCRType");
                ccn.Columns.Add("Originator");
                ccn.Columns.Add("Owner");
                ccn.Columns.Add("OrginationDate");
                ccn.Columns.Add("DCRStatus");
                ccn.Columns.Add("RECMode");
                ccn.Rows.Add();


                this.gvDCR.DataSource = ccn;
                this.gvDCR.DataBind();
            }
        }

    }
}