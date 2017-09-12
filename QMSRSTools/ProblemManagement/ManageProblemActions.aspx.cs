using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class ManageProblemActions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable actions = new DataTable();
                actions.Columns.Add("ACTTitle");
                actions.Columns.Add("PRMTitle");
                actions.Columns.Add("PRMType");
                actions.Columns.Add("ACTType");
                actions.Columns.Add("StartDate");
                actions.Columns.Add("PLNDEndDate");
                actions.Columns.Add("ACTUCLSDate");
                actions.Columns.Add("Actionee");
                actions.Columns.Add("Status");
                actions.Columns.Add("RECMode");

                actions.Rows.Add();

                this.gvActions.DataSource = actions;
                this.gvActions.DataBind();
            }
        }
    }
}