using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.DocumentList
{
    public partial class ViewDocuments : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("DocumentList", reportpath, domain);
//                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
//                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];


                this.DOCTYPCBox.DataSource = context.DocumentFileTypes;
                this.DOCTYPCBox.DataTextField = "FileType";
                this.DOCTYPCBox.DataValueField = "DocumentFileTypeId";
                this.DOCTYPCBox.DataBind();
                this.DOCTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.DOCSTSCBox.DataSource = context.DocumentStatus;
                this.DOCSTSCBox.DataTextField = "DocumentStatus1";
                this.DOCSTSCBox.DataValueField = "DocumentStatusID";
                this.DOCSTSCBox.DataBind();
                this.DOCSTSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.UNTCBox.DataSource = context.OrganizationUnits;
                this.UNTCBox.DataTextField = "UnitName";
                this.UNTCBox.DataValueField = "UnitID";
                this.UNTCBox.DataBind();
                this.UNTCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.PRJCBox.DataSource = context.ProjectInformations;
                this.PRJCBox.DataTextField = "ProjectName";
                this.PRJCBox.DataValueField = "ProjectId";
                this.PRJCBox.DataBind();
                this.PRJCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

               
                this.OVRDUECBox.Items.Insert(0, new ListItem("Over 1 Month", "30"));
                this.OVRDUECBox.Items.Insert(0, new ListItem("Over 2 Months", "60"));
                this.OVRDUECBox.Items.Insert(0, new ListItem("Over 3 Months", "90"));

                this.OVRDUECBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\DocumentList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.GetDocumentsTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetDocumentsTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.GetDocumentsDataTable _DT = new QMSRSToolsENRDLCDataSet.GetDocumentsDataTable();

                _DT = _TableAdapter.GetData(-1, -1, -1,-1,-1);
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

//                this.ReportViewer1.ServerReport.Refresh();
            }
        }
        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            List<ReportParameter> param = new List<ReportParameter>();
            param.Add(new ReportParameter("type", this.DOCTYPCBox.SelectedValue));
            param.Add(new ReportParameter("status", this.DOCSTSCBox.SelectedValue));
            param.Add(new ReportParameter("project", this.PRJCBox.SelectedValue));
            param.Add(new ReportParameter("unit", this.UNTCBox.SelectedValue));
            param.Add(new ReportParameter("duration", this.OVRDUECBox.SelectedValue));


            ReportParameter paramFields = new ReportParameter("pDisplayFields");

            int type = Int32.Parse(this.DOCTYPCBox.SelectedValue.ToString());
            int status = Int32.Parse(this.DOCSTSCBox.SelectedValue.ToString());
            int project = Int32.Parse(this.PRJCBox.SelectedValue.ToString());
            int unit = Int32.Parse(this.UNTCBox.SelectedValue.ToString());
            int duration = Int32.Parse(this.OVRDUECBox.SelectedValue.ToString());

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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\DocumentList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.GetDocumentsTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetDocumentsTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.GetDocumentsDataTable _DT = new QMSRSToolsENRDLCDataSet.GetDocumentsDataTable();

            _DT = _TableAdapter.GetData(type, status, project, unit, duration);
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