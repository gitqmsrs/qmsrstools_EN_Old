using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.OrganizationManagement
{
    public partial class ManagePosition : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable positions = new DataTable();
                positions.Columns.Add("PositionID");
                positions.Columns.Add("Title");
                positions.Columns.Add("OpenDate");
                positions.Columns.Add("CloseDate");
                positions.Columns.Add("Supervisor");
                positions.Columns.Add("PositionStatus");
                positions.Rows.Add();

                this.gvPositions.DataSource = positions;
                this.gvPositions.DataBind();
            }
        }
    }
}