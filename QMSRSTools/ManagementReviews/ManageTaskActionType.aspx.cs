using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ManagementReviews
{
    public partial class ManageTaskActionType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable type = new DataTable();
                type.Columns.Add("ActionTypeID");
                type.Columns.Add("ActionType");
                type.Columns.Add("Description");

                type.Rows.Add();

                this.gvActionType.DataSource = type;
                this.gvActionType.DataBind();
            }
        }
    }
}