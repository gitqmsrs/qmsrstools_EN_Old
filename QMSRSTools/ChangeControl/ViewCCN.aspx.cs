using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.ChangeControl
{
    public partial class ViewCCN : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("DCRList", reportpath, domain);
//                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
//                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];



                this.DCRTYPCBox.DataSource = context.ChangeControlTypes;
                this.DCRTYPCBox.DataTextField = "CCNType";
                this.DCRTYPCBox.DataValueField = "CCNTypeID";
                this.DCRTYPCBox.DataBind();

                this.DCRTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.DCRSTSCBox.DataSource = context.ChangeControlNoteStatus;
                this.DCRSTSCBox.DataTextField = "CCNStatus";
                this.DCRSTSCBox.DataValueField = "CCNStatusID";
                this.DCRSTSCBox.DataBind();

                this.DCRSTSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.DOCTYPCBox.DataSource = context.DocumentTypes;
                this.DOCTYPCBox.DataTextField = "DocumentType1";
                this.DOCTYPCBox.DataValueField = "DocumentTypeID";
                this.DOCTYPCBox.DataBind();

                this.DOCTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));





                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\DCRList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.GetDCRRecordTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetDCRRecordTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.GetDCRRecordDataTable _DT = new QMSRSToolsENRDLCDataSet.GetDCRRecordDataTable();

                _DT = _TableAdapter.GetData(-1, -1, -1);
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
            param.Add(new ReportParameter("type", this.DCRTYPCBox.SelectedValue));
            param.Add(new ReportParameter("status", this.DCRSTSCBox.SelectedValue));
            param.Add(new ReportParameter("doctype", this.DOCTYPCBox.SelectedValue));

            ReportParameter paramFields = new ReportParameter("pDisplayFields");

            int type = Int32.Parse(this.DCRTYPCBox.SelectedValue.ToString());
            int status = Int32.Parse(this.DCRSTSCBox.SelectedValue.ToString());
            int doctype = Int32.Parse(this.DOCTYPCBox.SelectedValue.ToString());
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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\DCRList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.GetDCRRecordTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetDCRRecordTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.GetDCRRecordDataTable _DT = new QMSRSToolsENRDLCDataSet.GetDCRRecordDataTable();

            _DT = _TableAdapter.GetData(type, status, doctype);
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