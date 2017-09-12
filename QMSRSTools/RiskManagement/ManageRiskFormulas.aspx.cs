using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class ManageRiskFormulas : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable formula = new DataTable();
                formula.Columns.Add("FormulaID");
                formula.Columns.Add("Formula");
                formula.Columns.Add("RiskType");
                formula.Rows.Add();

                this.gvFormula.DataSource = formula;
                this.gvFormula.DataBind();
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}