using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

namespace QMSRSTools.ProblemManagement
{
    public partial class ViewActions : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("ProblemActionList", reportpath,domain);
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

                this.ACTTYPCBox.DataSource = context.ProblemActionTypes;
                this.ACTTYPCBox.DataTextField = "ActionName";
                this.ACTTYPCBox.DataValueField = "ActionTypeID";
                this.ACTTYPCBox.DataBind();
                this.ACTTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.ACTEECBox.DataSource = context.fn_GetActionees();
                this.ACTEECBox.DataTextField = "EmployeeName";
                this.ACTEECBox.DataValueField = "EmployeeID";
                this.ACTEECBox.DataBind();
                this.ACTEECBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ProblemActionList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.GetProblemActionListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetProblemActionListTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.GetProblemActionListDataTable _DT = new QMSRSToolsENRDLCDataSet.GetProblemActionListDataTable();

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

//                this.ReportViewer1.ServerReport.Refresh();
            }
        }

        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            List<ReportParameter> param = new List<ReportParameter>();
            param.Add(new ReportParameter("problemTypeID", this.PRMTYPCBox.SelectedValue));
            param.Add(new ReportParameter("problemStatusID", this.PRMSTSCBox.SelectedValue));
            param.Add(new ReportParameter("actiontypeID", this.ACTTYPCBox.SelectedValue));
            param.Add(new ReportParameter("actioneeID", this.ACTEECBox.SelectedValue));


            ReportParameter paramFields = new ReportParameter("pDisplayFields");


            //get values of ListBox Fields

            int problemTypeID = Int32.Parse(this.PRMTYPCBox.SelectedValue.ToString());
            int problemStatusID = Int32.Parse(this.PRMSTSCBox.SelectedValue.ToString());
            int actiontypeID = Int32.Parse(this.ACTTYPCBox.SelectedValue.ToString());
            int actioneeID = Int32.Parse(this.ACTEECBox.SelectedValue.ToString());

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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\ProblemActionList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.GetProblemActionListTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetProblemActionListTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


            QMSRSToolsENRDLCDataSet.GetProblemActionListDataTable _DT = new QMSRSToolsENRDLCDataSet.GetProblemActionListDataTable();

            _DT = _TableAdapter.GetData(problemTypeID, problemStatusID, actiontypeID, actioneeID);
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