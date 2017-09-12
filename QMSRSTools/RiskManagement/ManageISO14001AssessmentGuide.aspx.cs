using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class ManageISO14001AssessmentGuide : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable guideline = new DataTable();
                guideline.Columns.Add("GuideID");
                guideline.Columns.Add("Category");
                guideline.Columns.Add("Assessment");
                guideline.Columns.Add("Value");
            
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