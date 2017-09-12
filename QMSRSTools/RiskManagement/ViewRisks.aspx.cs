using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.RiskManagement
{
    public partial class ViewRisks : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("RiskList", reportpath, domain);
//                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
//                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];


                this.RSKCATCBox.DataSource = context.RiskCategories;
                this.RSKCATCBox.DataTextField = "Category";
                this.RSKCATCBox.DataValueField = "RiskCategoryID";
                this.RSKCATCBox.DataBind();
                this.RSKCATCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.ACTEECBox.DataSource = context.fn_GetActionees3();
                this.ACTEECBox.DataTextField = "EmployeeName";
                this.ACTEECBox.DataValueField = "EmployeeID";
                this.ACTEECBox.DataBind();
                this.ACTEECBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RSKMODCBox.DataSource = context.RiskModes;
                this.RSKMODCBox.DataTextField = "RiskMode1";
                this.RSKMODCBox.DataValueField = "RiskModeID";
                this.RSKMODCBox.DataBind();
                this.RSKMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RSKTYPCBox.DataSource = context.RiskTypes;
                this.RSKTYPCBox.DataTextField = "RiskType1";
                this.RSKTYPCBox.DataValueField = "RiskTypeID";
                this.RSKTYPCBox.DataBind();
                this.RSKTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RSKSTSCBox.DataSource = context.RiskStatus;
                this.RSKSTSCBox.DataTextField = "RiskStatus1";
                this.RSKSTSCBox.DataValueField = "StatusId";
                this.RSKSTSCBox.DataBind();
                this.RSKSTSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RECMODCBox.DataSource = context.RecordModes;
                this.RECMODCBox.DataTextField = "RecordMode1";
                this.RECMODCBox.DataValueField = "RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.CCNTRCBox.DataSource = context.CostCentres;
                this.CCNTRCBox.DataTextField = "CostCentreName";
                this.CCNTRCBox.DataValueField = "CostCentreID";
                this.CCNTRCBox.DataBind();
                this.CCNTRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));



                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\RiskList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.RiskListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.RiskListTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.RiskListDataTable _DT = new QMSRSToolsENRDLCDataSet.RiskListDataTable();

                _DT = _TableAdapter.GetData(-1, -1, -1,-1,-1,-1,"-1");
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
            param.Add(new ReportParameter("status", this.RSKSTSCBox.SelectedValue));
            param.Add(new ReportParameter("category", this.RSKCATCBox.SelectedValue));
            param.Add(new ReportParameter("mode", this.RSKMODCBox.SelectedValue));
            param.Add(new ReportParameter("type", this.RSKTYPCBox.SelectedValue));
            param.Add(new ReportParameter("actionee", this.ACTEECBox.SelectedValue));
            param.Add(new ReportParameter("centre1", this.CCNTRCBox.SelectedValue));
            param.Add(new ReportParameter("recordmode", this.RECMODCBox.SelectedValue));


            ReportParameter paramFields = new ReportParameter("pDisplayFields");


            //get values of ListBox Fields

            int status = Int32.Parse(this.RSKSTSCBox.SelectedValue.ToString());
            int category = Int32.Parse(this.RSKCATCBox.SelectedValue.ToString());
            int mode = Int32.Parse(this.RSKMODCBox.SelectedValue.ToString());
            int type = Int32.Parse(this.RSKTYPCBox.SelectedValue.ToString());
            int actionee = Int32.Parse(this.ACTEECBox.SelectedValue.ToString());
            int centre1 = Int32.Parse(this.CCNTRCBox.SelectedValue.ToString());
            int recordmode = Int32.Parse(this.RECMODCBox.SelectedValue.ToString());

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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\RiskList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.RiskListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.RiskListTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.RiskListDataTable _DT = new QMSRSToolsENRDLCDataSet.RiskListDataTable();

            _DT = _TableAdapter.GetData(status, category, mode, type, centre1, recordmode, actionee.ToString());
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