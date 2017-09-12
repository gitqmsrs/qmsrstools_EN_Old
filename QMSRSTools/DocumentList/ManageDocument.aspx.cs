using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.DocumentList
{
    public partial class ManageDocument : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable documents = new DataTable();
                documents.Columns.Add("DOCNo");
                documents.Columns.Add("DOCFType");
                documents.Columns.Add("DOCType");
                documents.Columns.Add("DOCTitle");
                documents.Columns.Add("DOCRev");
                documents.Columns.Add("IssueDate");
                documents.Columns.Add("LastReviewDate");
                documents.Columns.Add("NextReviewDate");
                documents.Columns.Add("DOCStatusString");
                documents.Columns.Add("RECMode");

                documents.Rows.Add();

                this.gvDocuments.DataSource = documents;
                this.gvDocuments.DataBind();
            }
        }
    }
}