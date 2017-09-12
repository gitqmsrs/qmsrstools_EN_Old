using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.ManagementReviews
{
    public partial class ManagementReviewList : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context=new LINQConnection.QMSRSContextDataContext();
     
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("ReviewList", reportpath, domain);
//                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
//                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];

                this.REPRCBox.DataSource = context.fn_GetRepresentatives();
                this.REPRCBox.DataTextField = "EmployeeName";
                this.REPRCBox.DataValueField = "EmployeeID";
                this.REPRCBox.DataBind();
                this.REPRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.REVSTSFCBox.DataSource = context.ManagementStatus;
                this.REVSTSFCBox.DataTextField = "ManagementStatus1";
                this.REVSTSFCBox.DataValueField = "ManagementStatusID";
                this.REVSTSFCBox.DataBind();
                this.REVSTSFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.UNTCBox.DataSource = context.OrganizationUnits;
                this.UNTCBox.DataTextField = "UnitName";
                this.UNTCBox.DataValueField = "UnitID";
                this.UNTCBox.DataBind();
                this.UNTCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.RECMODCBox.DataSource = context.RecordModes;
                this.RECMODCBox.DataTextField = "RecordMode1";
                this.RECMODCBox.DataValueField = "RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ReviewList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.GetReviewRecordsTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetReviewRecordsTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.GetReviewRecordsDataTable _DT = new QMSRSToolsENRDLCDataSet.GetReviewRecordsDataTable();

                _DT = _TableAdapter.GetData(-1, -1, -1,-1);
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                {
                    Name = "DataSet1",
                    Value = _DT

                });

                //this.ReportViewer1.LocalReport.SetParameters(param);


                this.ReportViewer1.LocalReport.Refresh();

//                this.ReportViewer1.ProcessingMode = ProcessingMode.Remote;

//                this.ReportViewer1.ShowCredentialPrompts = false;
//                this.ReportViewer1.ShowParameterPrompts = false;
//                this.ReportViewer1.ServerReport.ReportServerCredentials = obj;

//#if DEBUG
//                this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(domain);
//#else
                     
//                    this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(obj.ReportServerURL);
//#endif
//                this.ReportViewer1.ServerReport.ReportPath = obj.ReportPath;
            }

        }
        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            List<ReportParameter> param = new List<ReportParameter>();
            param.Add(new ReportParameter("representativeID", this.REPRCBox.SelectedValue));
            param.Add(new ReportParameter("orgunitID", this.UNTCBox.SelectedValue));
            param.Add(new ReportParameter("statusID", this.REVSTSFCBox.SelectedValue));
            param.Add(new ReportParameter("mode", this.RECMODCBox.SelectedValue));


            ReportParameter paramFields = new ReportParameter("pDisplayFields");

            int representativeID = Int32.Parse(this.REPRCBox.SelectedValue.ToString());
            int orgunitID = Int32.Parse(this.UNTCBox.SelectedValue.ToString());
            int statusID = Int32.Parse(this.REVSTSFCBox.SelectedValue.ToString());
            int mode = Int32.Parse(this.RECMODCBox.SelectedValue.ToString());


            //get values of ListBox Fields


            List<string> l = new List<string>();

            foreach (ListItem listitems in lstFields.Items)
            {
                if (listitems.Selected == true)
                    l.Add(listitems.Value);
            }

            if (l.Count == 0)
            {
                l.Add("NOTHING");
            }
            // string[] values = new string[] { "Description", "PurchasePrice", "CurrencyCode", "PurchaseDate", "Owner" };
            string[] values = l.ToArray();
            paramFields.Values.AddRange(values);
            param.Add(paramFields);

            this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
            LocalReport _localReport = this.ReportViewer1.LocalReport;
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ReviewList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.GetReviewRecordsTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetReviewRecordsTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.GetReviewRecordsDataTable _DT = new QMSRSToolsENRDLCDataSet.GetReviewRecordsDataTable();

            _DT = _TableAdapter.GetData(representativeID, orgunitID, statusID, mode);
            this.ReportViewer1.LocalReport.DataSources.Clear();

            this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
            {
                Name = "DataSet1",
                Value = _DT

            });

            this.ReportViewer1.LocalReport.SetParameters(param);


            this.ReportViewer1.LocalReport.Refresh();

        }
    }
}