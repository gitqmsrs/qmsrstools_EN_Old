using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using QMSRS.Utilities;

namespace QMSRSTools.AuditManagement
{
    public partial class AuditListReport : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
            //    string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
            //    string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

            //    CustomReportCredentials obj = new CustomReportCredentials("AuditList", reportpath, domain);
            //    obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
            //    obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];

                this.AUDTRCBox.DataSource = context.fn_GetAuditors();
                this.AUDTRCBox.DataTextField = "EmployeeName";
                this.AUDTRCBox.DataValueField = "EmployeeID";
                this.AUDTRCBox.DataBind();
                this.AUDTRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.AUDTSTSCBox.DataSource = context.AuditStatus;
                this.AUDTSTSCBox.DataTextField = "AuditStatus1";
                this.AUDTSTSCBox.DataValueField = "AuditStatusID";
                this.AUDTSTSCBox.DataBind();
                this.AUDTSTSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.AUDTTYPFCBox.DataSource = context.AuditTypes;
                this.AUDTTYPFCBox.DataTextField = "AuditType1";
                this.AUDTTYPFCBox.DataValueField = "AuditTypeId";
                this.AUDTTYPFCBox.DataBind();
                this.AUDTTYPFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.UNTCBox.DataSource = context.OrganizationUnits;
                this.UNTCBox.DataTextField = "UnitName";
                this.UNTCBox.DataValueField = "UnitID";
                this.UNTCBox.DataBind();
                this.UNTCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.EnableHyperlinks = true;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\AuditList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.GetAllAuditRecordsTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetAllAuditRecordsTableAdapter();

                this.ReportViewer1.AsyncRendering = false;
                this.ReportViewer1.HyperlinkTarget = "_blank";

                QMSRSToolsENRDLCDataSet.GetAllAuditRecordsDataTable _DT = new QMSRSToolsENRDLCDataSet.GetAllAuditRecordsDataTable();

                _DT = _TableAdapter.GetData(-1,-1,-1,-1);
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                {
                    Name = "DataSet1",
                    Value = _DT

                });

                ReportParameter _param = new ReportParameter("BaseUrl", WebConfigurationManager.GetSitePath());
                this.ReportViewer1.LocalReport.SetParameters(_param);
                this.ReportViewer1.LocalReport.Refresh();


            //    this.ReportViewer1.ProcessingMode = ProcessingMode.Remote;

            //    this.ReportViewer1.ShowCredentialPrompts = false;
            //    this.ReportViewer1.ShowParameterPrompts = false;

            //    this.ReportViewer1.ServerReport.ReportServerCredentials = obj;

            //#if DEBUG
            //    this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(domain);
            //#else
                     
            //        this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(obj.ReportServerURL);
            //#endif

            //   // this.ReportViewer1.ServerReport.ReportServerUrl = new Uri(obj.ReportServerURL);


            //    this.ReportViewer1.ServerReport.ReportPath = obj.ReportPath;

            //    this.ReportViewer1.ServerReport.Refresh();
            }

        }
        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            List<ReportParameter> param = new List<ReportParameter>();
            param.Add(new ReportParameter("auditorID", this.AUDTRCBox.SelectedValue));
            param.Add(new ReportParameter("orgunitID", this.UNTCBox.SelectedValue));
            param.Add(new ReportParameter("statusID", this.AUDTSTSCBox.SelectedValue));
            param.Add(new ReportParameter("type", this.AUDTTYPFCBox.SelectedValue));

            ReportParameter paramFields = new ReportParameter("pDisplayFields");

            int auditorID = Int32.Parse(this.AUDTRCBox.SelectedValue.ToString());
            int orgunitID = Int32.Parse(this.UNTCBox.SelectedValue.ToString());
            int statusID = Int32.Parse(this.AUDTSTSCBox.SelectedValue.ToString());
            int type = Int32.Parse(this.AUDTTYPFCBox.SelectedValue.ToString());

            List<string> l = new List<string>();

            foreach (ListItem listitems in lstFields.Items)
            {
                if (listitems.Selected == true)
                    l.Add(listitems.Value);
            }

            if (l.Count == 0)
            {
                l.Add("Nothing");
            }
            // string[] values = new string[] { "Description", "PurchasePrice", "CurrencyCode", "PurchaseDate", "Owner" };
            string[] values = l.ToArray();
            paramFields.Values.AddRange(values);
            param.Add(paramFields);


            this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
            LocalReport _localReport = this.ReportViewer1.LocalReport;
           
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\AuditList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.GetAllAuditRecordsTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetAllAuditRecordsTableAdapter();

            this.ReportViewer1.AsyncRendering = false;
            
            this.ReportViewer1.LocalReport.EnableHyperlinks = true;

            QMSRSToolsENRDLCDataSet.GetAllAuditRecordsDataTable _DT = new QMSRSToolsENRDLCDataSet.GetAllAuditRecordsDataTable();

            _DT = _TableAdapter.GetData(auditorID,orgunitID,statusID, type);
            this.ReportViewer1.LocalReport.DataSources.Clear();

            this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
            {
                Name = "DataSet1",
                Value = _DT

            });

            this.ReportViewer1.LocalReport.EnableHyperlinks = true;
               this.ReportViewer1.AsyncRendering = false;

               this.ReportViewer1.HyperlinkTarget = "_self";
            this.ReportViewer1.LocalReport.SetParameters(param);
            this.ReportViewer1.LocalReport.Refresh();
        
        }
    }
}