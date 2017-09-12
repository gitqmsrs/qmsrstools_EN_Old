using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ContractManagement
{
    public partial class ManageContractGroup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable groups = new DataTable();
                groups.Columns.Add("GroupID");
                groups.Columns.Add("GroupName");
                groups.Columns.Add("Duration");
                groups.Columns.Add("IsConstraint");

                groups.Rows.Add();

                this.gvGroup.DataSource = groups;
                this.gvGroup.DataBind();
            }
        }
    }
}