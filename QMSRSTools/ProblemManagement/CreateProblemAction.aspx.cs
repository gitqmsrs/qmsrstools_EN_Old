using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class CreateProblemAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable problems = new DataTable();
                problems.Columns.Add("CaseNo");
                problems.Columns.Add("ProblemType");
                problems.Columns.Add("Title");
                problems.Columns.Add("OriginationDate");
                problems.Columns.Add("TargetCloseDate");
                problems.Columns.Add("Originator");
                problems.Columns.Add("Status");
                problems.Columns.Add("Mode");

                problems.Rows.Add();

                this.gvProblems.DataSource = problems;
                this.gvProblems.DataBind();
            }
        }
    }
}