using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class ApproveProblem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.EMPTxt.Text = HttpContext.Current.User.Identity.Name;


                DataTable problem = new DataTable();
                problem.Columns.Add("CaseNo");
                problem.Columns.Add("PRMTitle");
                problem.Columns.Add("PRMType");
                problem.Columns.Add("AFFCTPRTYType");
                problem.Columns.Add("Originator");
                problem.Columns.Add("OriginationDate");
                problem.Columns.Add("TargetCloseDate");
                problem.Columns.Add("ActualCloseDate");
                problem.Columns.Add("Status");
                problem.Columns.Add("RECMode");
                problem.Rows.Add();


                this.gvProblems.DataSource = problem;
                this.gvProblems.DataBind();
            }
        }
    }
}