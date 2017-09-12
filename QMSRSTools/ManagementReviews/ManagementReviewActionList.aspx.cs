using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

namespace QMSRSTools.ManagementReviews
{
    public partial class ManagementReviewActionList : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("ReviewActionList", reportpath, domain);
//                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
//                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];



                this.ACTEECBox.DataSource = context.fn_GetActionees2();
                this.ACTEECBox.DataTextField = "EmployeeName";
                this.ACTEECBox.DataValueField = "EmployeeID";
                this.ACTEECBox.DataBind();
                this.ACTEECBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.ACTTYPFCBox.DataSource = context.ActionTypes;
                this.ACTTYPFCBox.DataTextField = "ActionType1";
                this.ACTTYPFCBox.DataValueField = "ActionTypeID";
                this.ACTTYPFCBox.DataBind();
                this.ACTTYPFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


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


                List<ReportParameter> param = new List<ReportParameter>();
                param.Add(new ReportParameter("eventname", this.REVMTTxt.Text));
                param.Add(new ReportParameter("orgunitID", this.UNTCBox.SelectedValue));
                param.Add(new ReportParameter("actioneeID", this.ACTEECBox.SelectedValue));
                param.Add(new ReportParameter("actiontypeID", this.ACTTYPFCBox.SelectedValue));
                param.Add(new ReportParameter("mode", this.RECMODCBox.SelectedValue));


                ReportParameter paramFields = new ReportParameter("pDisplayFields");

                string eventname = this.REVMTTxt.Text;
                int orgunitID = Int32.Parse(this.UNTCBox.SelectedValue.ToString());
                int actioneeID = Int32.Parse(this.ACTEECBox.SelectedValue.ToString());
                int actiontypeID = Int32.Parse(this.ACTTYPFCBox.SelectedValue.ToString());
                int mode = Int32.Parse(this.RECMODCBox.SelectedValue.ToString());

                //get values of ListBox Fields


                ////List<string> l = new List<string>();

                ////foreach (ListItem listitems in lstFields.Items)
                ////{
                ////    if (listitems.Selected == true)
                ////        l.Add(listitems.Value);
                ////}

                ////if (l.Count == 0)
                ////{
                ////    l.Add("NOTHING");
                ////}

              
                string[] values = new string[] { "ActionType", "TargetDate", "DelayedTo", "Completed", "Details" ,"Status"};
                //string[] values = l.ToArray();
                paramFields.Values.AddRange(values);
                param.Add(paramFields);
                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ReviewActionList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.ReviewActionListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.ReviewActionListTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.ReviewActionListDataTable _DT = new QMSRSToolsENRDLCDataSet.ReviewActionListDataTable();

                _DT = _TableAdapter.GetData(eventname, orgunitID, actioneeID, actiontypeID, mode);
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                {
                    Name = "DataSet1",
                    Value = _DT

                });

                this.ReportViewer1.LocalReport.SetParameters(param);


                this.ReportViewer1.LocalReport.Refresh();


               // this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
               // LocalReport _localReport = this.ReportViewer1.LocalReport;
               // _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ReviewActionList.rdlc");

               // QMSRSToolsENRDLCDataSetTableAdapters.ReviewActionListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.ReviewActionListTableAdapter();

               // this.ReportViewer1.AsyncRendering = false;


               // QMSRSToolsENRDLCDataSet.ReviewActionListDataTable _DT = new QMSRSToolsENRDLCDataSet.ReviewActionListDataTable();

               // _DT = _TableAdapter.GetData("",-1, -1, -1,-1);
               //this.ReportViewer1.LocalReport.DataSources.Clear();

               // this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
               // {
               //     Name = "DataSet1",
               //     Value = _DT

               // });

               // //this.ReportViewer1.LocalReport.SetParameters(param);


               // this.ReportViewer1.LocalReport.Refresh();


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
            param.Add(new ReportParameter("eventname", this.REVMTTxt.Text));
            param.Add(new ReportParameter("orgunitID", this.UNTCBox.SelectedValue));
            param.Add(new ReportParameter("actioneeID", this.ACTEECBox.SelectedValue));
            param.Add(new ReportParameter("actiontypeID", this.ACTTYPFCBox.SelectedValue));
            param.Add(new ReportParameter("mode", this.RECMODCBox.SelectedValue));


            ReportParameter paramFields = new ReportParameter("pDisplayFields");

            string eventname = this.REVMTTxt.Text;
            int orgunitID = Int32.Parse(this.UNTCBox.SelectedValue.ToString());
            int actioneeID = Int32.Parse(this.ACTEECBox.SelectedValue.ToString());
            int actiontypeID = Int32.Parse(this.ACTTYPFCBox.SelectedValue.ToString());
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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ReviewActionList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.ReviewActionListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.ReviewActionListTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.ReviewActionListDataTable _DT = new QMSRSToolsENRDLCDataSet.ReviewActionListDataTable();

            _DT = _TableAdapter.GetData(eventname, orgunitID, actioneeID, actiontypeID, mode);
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