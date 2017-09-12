using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class ManageRiskCriteria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable criteria = new DataTable();
                criteria.Columns.Add("CriteriaID");
                criteria.Columns.Add("RiskType");
                criteria.Columns.Add("RiskCriteria");
                criteria.Columns.Add("Description");

                criteria.Rows.Add();

                this.gvRiskCriteria.DataSource = criteria;
                this.gvRiskCriteria.DataBind();
            }
        }
    }
}