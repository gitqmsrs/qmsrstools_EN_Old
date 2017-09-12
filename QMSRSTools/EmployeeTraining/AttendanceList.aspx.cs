using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.EmployeeTraining
{
    public partial class AttendanceList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
                //string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

                //CustomReportCredentials obj = new CustomReportCredentials("AttendanceList", reportpath, domain);
                //obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
                //obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];


                //this.ReportViewer1.ProcessingMode = ProcessingMode.Remote;

                //this.ReportViewer1.ShowCredentialPrompts = false;
                //this.ReportViewer1.ShowParameterPrompts = false;
                //this.ReportViewer1.ServerReport.ReportServerCredentials = obj;

                //#if DEBUG
                //                this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(domain);
                //#else
                     
                //                    this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(obj.ReportServerURL);
                //#endif


                //this.ReportViewer1.ServerReport.ReportPath = obj.ReportPath;

                //this.ReportViewer1.ServerReport.Refresh();

                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\AttendanceList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.AttendanceListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.AttendanceListTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.AttendanceListDataTable _DT = new QMSRSToolsENRDLCDataSet.AttendanceListDataTable();

                _DT = _TableAdapter.GetData("");
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                {
                    Name = "DataSet1",
                    Value = _DT

                });

                //this.ReportViewer1.LocalReport.SetParameters(param);


                this.ReportViewer1.LocalReport.Refresh();


            }
        }

        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            List<ReportParameter> param = new List<ReportParameter>();
            param.Add(new ReportParameter("title", this.CTTLTxt.Text));

            ReportParameter paramFields = new ReportParameter("pDisplayFields");


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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\AttendanceList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.AttendanceListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.AttendanceListTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.AttendanceListDataTable _DT = new QMSRSToolsENRDLCDataSet.AttendanceListDataTable();

            _DT = _TableAdapter.GetData(this.CTTLTxt.Text);
            this.ReportViewer1.LocalReport.DataSources.Clear();

            this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
            {
                Name = "DataSet1",
                Value = _DT

            });
            this.ReportViewer1.AsyncRendering = false;


            this.ReportViewer1.LocalReport.SetParameters(param);
            this.ReportViewer1.LocalReport.Refresh();
        }
    }
   
}