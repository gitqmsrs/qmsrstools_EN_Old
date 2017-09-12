using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class ManageProblemType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable type = new DataTable();
                type.Columns.Add("TypeID");
                type.Columns.Add("TypeName");
                type.Columns.Add("Description");

                type.Rows.Add();

                this.gvProblemType.DataSource = type;
                this.gvProblemType.DataBind();
            }
        }
    }
}