using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageCostCentre : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable centre = new DataTable();
                centre.Columns.Add("CentreID");
                centre.Columns.Add("CentreName");
                centre.Columns.Add("Unit");
                centre.Columns.Add("Manager");

                centre.Rows.Add();

                this.gvCentre.DataSource = centre;
                this.gvCentre.DataBind();
            }
        }
    }
}