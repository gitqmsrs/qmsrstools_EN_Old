using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.ProblemManagement
{
    public partial class ViewProblems : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
                //                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

                //                CustomReportCredentials obj = new CustomReportCredentials("ProblemList", reportpath, domain);
                //                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
                //                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];


                this.PRMTYPCBox.DataSource = context.ProblemTypes;
                this.PRMTYPCBox.DataTextField = "ProblemType1";
                this.PRMTYPCBox.DataValueField = "ProblemTypeID";
                this.PRMTYPCBox.DataBind();
                this.PRMTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.PRMSTSCBox.DataSource = context.ProblemStatus;
                this.PRMSTSCBox.DataTextField = "ProblemStatus1";
                this.PRMSTSCBox.DataValueField = "ProblemStatusID";
                this.PRMSTSCBox.DataBind();
                this.PRMSTSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RTCUSCBox.DataSource = context.Causes;
                this.RTCUSCBox.DataTextField = "CauseName";
                this.RTCUSCBox.DataValueField = "CauseID";
                this.RTCUSCBox.DataBind();
                this.RTCUSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RECMODCBox.DataSource = context.RecordModes;
                this.RECMODCBox.DataTextField = "RecordMode1";
                this.RECMODCBox.DataValueField = "RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.PRTYPCBox.DataSource = context.AffectedPartyTypes;
                this.PRTYPCBox.DataTextField = "AffectedPartyType1";
                this.PRTYPCBox.DataValueField = "AffectedPartyTypeID";
                this.PRTYPCBox.DataBind();
                this.PRTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ProblemList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.GetProblemListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetProblemListTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.GetProblemListDataTable _DT = new QMSRSToolsENRDLCDataSet.GetProblemListDataTable();

                _DT = _TableAdapter.GetData(-1, -1, -1, -1, -1);
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
            param.Add(new ReportParameter("partytypeID", this.PRTYPCBox.SelectedValue));
            param.Add(new ReportParameter("problemTypeID", this.PRMTYPCBox.SelectedValue));
            param.Add(new ReportParameter("problemStatusID", this.PRMSTSCBox.SelectedValue));
            param.Add(new ReportParameter("rootcauseID", this.RTCUSCBox.SelectedValue));
            param.Add(new ReportParameter("recordmodeID", this.RECMODCBox.SelectedValue));


            ReportParameter paramFields = new ReportParameter("pDisplayFields");


            int partytypeID = Int32.Parse(this.PRTYPCBox.SelectedValue.ToString());
            int problemTypeID = Int32.Parse(this.PRMTYPCBox.SelectedValue.ToString());
            int problemStatusID = Int32.Parse(this.PRMSTSCBox.SelectedValue.ToString());
            int rootcauseID = Int32.Parse(this.RTCUSCBox.SelectedValue.ToString());
            int recordmodeID = Int32.Parse(this.RECMODCBox.SelectedValue.ToString());

         
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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ProblemList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.GetProblemListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetProblemListTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.GetProblemListDataTable _DT = new QMSRSToolsENRDLCDataSet.GetProblemListDataTable();

            _DT = _TableAdapter.GetData(partytypeID, problemTypeID, problemStatusID, rootcauseID, recordmodeID);
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