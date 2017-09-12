using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.Administration
{
    public partial class ManageCustomer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable customers = new DataTable();

                customers.Columns.Add("CustomerNo");
                customers.Columns.Add("CustomerType");
                customers.Columns.Add("CustomerName");
                customers.Columns.Add("ContactPerson");
                customers.Columns.Add("EmailAddress");
                customers.Rows.Add();

                this.gvCustomers.DataSource = customers;
                this.gvCustomers.DataBind();


                DataTable partytype = new DataTable();
                partytype.Columns.Add("PartyTypeID");
                partytype.Columns.Add("PartyType");
                partytype.Columns.Add("Description");

                partytype.Rows.Add();

                this.gvPartyType.DataSource = partytype;
                this.gvPartyType.DataBind();
            }
        }
    }
}