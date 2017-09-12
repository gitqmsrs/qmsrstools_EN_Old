using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class ManageRiskScoreCriteria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable score = new DataTable();
                score.Columns.Add("ScoreCriteriaID");
                score.Columns.Add("RiskType");
                score.Columns.Add("RiskScoreCriteria");
                score.Columns.Add("Rank");
                score.Columns.Add("Description");

                score.Rows.Add();

                this.gvRiskScoreCriteria.DataSource = score;
                this.gvRiskScoreCriteria.DataBind();
            }
        }
    }
}