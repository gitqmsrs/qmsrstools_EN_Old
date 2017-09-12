using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.AuditManagement
{
    public partial class AuditReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["AuditID"] != null)
                {
                    //string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
                    //string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

                    //CustomReportCredentials obj = new CustomReportCredentials("AuditRecord", reportpath, domain);
                    //obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
                    //obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];

     

                    this.ReportViewer1.ProcessingMode = ProcessingMode.Local;

                    this.ReportViewer1.ShowCredentialPrompts = false;
                    this.ReportViewer1.ShowParameterPrompts = false;

                    LocalReport _localReport = this.ReportViewer1.LocalReport;
                    _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\AuditRecord.rdlc");

                    QMSRSToolsENRDLCDataSetTableAdapters.AssetListTableAdapter DS = new QMSRSToolsENRDLCDataSetTableAdapters.AssetListTableAdapter();

                    this.ReportViewer1.AsyncRendering = false;


                    int _AuditID = Int32.Parse(Request.QueryString["AuditID"]);
                    QMSRSToolsENRDLCDataSetTableAdapters.GetAuditActionsTableAdapter _AuditActionsTA = new QMSRSToolsENRDLCDataSetTableAdapters.GetAuditActionsTableAdapter();
                      QMSRSToolsENRDLCDataSetTableAdapters.GetAuditAuditorsTableAdapter _AuditAuditorsTA = new QMSRSToolsENRDLCDataSetTableAdapters.GetAuditAuditorsTableAdapter();
                      QMSRSToolsENRDLCDataSetTableAdapters.GetAuditFindingsTableAdapter _AuditFindingsTA = new QMSRSToolsENRDLCDataSetTableAdapters.GetAuditFindingsTableAdapter();
                      QMSRSToolsENRDLCDataSetTableAdapters.GetAuditRecordTableAdapter _AuditRecordsTA = new QMSRSToolsENRDLCDataSetTableAdapters.GetAuditRecordTableAdapter();



                    QMSRSToolsENRDLCDataSet.GetAuditActionsDataTable _AuditActions = _AuditActionsTA.GetData(_AuditID);
                    QMSRSToolsENRDLCDataSet.GetAuditAuditorsDataTable _AuditAuditors = _AuditAuditorsTA.GetData(_AuditID);
                    QMSRSToolsENRDLCDataSet.GetAuditFindingsDataTable _AuditFindings = _AuditFindingsTA.GetData(_AuditID);
                    QMSRSToolsENRDLCDataSet.GetAuditRecordDataTable _AuditRecords = _AuditRecordsTA.GetData(_AuditID);

                    this.ReportViewer1.LocalReport.DataSources.Clear();

                    this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                    {
                        Name = "DataSet4",
                        Value = _AuditActions

                    });

                    this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                    {
                        Name = "DataSet2",
                        Value = _AuditAuditors

                    });

                    this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                    {
                        Name = "DataSet3",
                        Value = _AuditFindings

                    });

                    this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                    {
                        Name = "DataSet1",
                        Value = _AuditRecords

                    });

                    this.ReportViewer1.LocalReport.Refresh();


                    //this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(obj.ReportServerURL);
                    //this.ReportViewer1.ServerReport.ReportPath = obj.ReportPath;

                    //List<ReportParameter> param = new List<ReportParameter>();
                    //param.Add(new ReportParameter("auditID", Request.QueryString["AuditID"]));

                    //this.ReportViewer1.ServerReport.SetParameters(param);
                    //this.ReportViewer1.ServerReport.Refresh();

                }
            }
        }
    }
}