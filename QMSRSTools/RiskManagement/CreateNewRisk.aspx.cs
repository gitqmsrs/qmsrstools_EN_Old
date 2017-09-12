using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class CreateNewRisk : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable projects = new DataTable();
                projects.Columns.Add("PROJNo");
                projects.Columns.Add("PROJName");
                projects.Columns.Add("StartDate");
                projects.Columns.Add("PlannedCloseDate");
                projects.Columns.Add("ActualCloseDate");
                projects.Columns.Add("Leader");
                projects.Columns.Add("Value");
                projects.Columns.Add("Cost");
                projects.Columns.Add("Status");

                projects.Rows.Add();

                this.gvProjects.DataSource = projects;
                this.gvProjects.DataBind();

                DataTable guideline = new DataTable();
                guideline.Columns.Add("GuideID");
                guideline.Columns.Add("Category");
                guideline.Columns.Add("Assessment");
                guideline.Columns.Add("Value");
                guideline.Columns.Add("Score");

                guideline.Rows.Add();

                this.gvAssessmentGuide.DataSource = guideline;
                this.gvAssessmentGuide.DataBind();
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}