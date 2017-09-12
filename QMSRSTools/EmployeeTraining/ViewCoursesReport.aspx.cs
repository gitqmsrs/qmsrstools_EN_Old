using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
namespace QMSRSTools.EmployeeTraining
{
    public partial class ViewCoursesReport : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("CourseList", reportpath, domain);
//                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
//                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];


                this.CSTSFCBox.DataSource = context.TrainingCourseStatus;
                this.CSTSFCBox.DataTextField = "TrainingStatus";
                this.CSTSFCBox.DataValueField = "TrainingStatusID";
                this.CSTSFCBox.DataBind();
                this.CSTSFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RECMODCBox.DataSource = context.RecordModes;
                this.RECMODCBox.DataTextField = "RecordMode1";
                this.RECMODCBox.DataValueField = "RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));



                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\CourseList.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.GetCoursesTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetCoursesTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.GetCoursesDataTable _DT = new QMSRSToolsENRDLCDataSet.GetCoursesDataTable();
                DateTime _endDate = new DateTime (DateTime.Now.Year, 12, 31) ;
                DateTime _startdate = new DateTime (DateTime.Now.Year,1,1);

                _DT = _TableAdapter.GetData(-1, -1, _startdate, _endDate);
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
            param.Add(new ReportParameter("status", this.CSTSFCBox.SelectedValue));
            param.Add(new ReportParameter("mode", this.RECMODCBox.SelectedValue));
             param.Add(new ReportParameter("startdate", this.FDTTxt.Text == string.Empty || this.FDTTxt.Text == "__/__/____" ? new DateTime(DateTime.Now.Year, 1, 1).ToString("dd/MM/yyyy") : Convert.ToDateTime(this.FDTTxt.Text).ToString("dd/MM/yyyy")));
            param.Add(new ReportParameter("enddate", this.TDTTxt.Text == string.Empty || this.TDTTxt.Text == "__/__/____" ? new DateTime(DateTime.Now.Year, 12, 31).ToString("dd/MM/yyyy") : Convert.ToDateTime(this.TDTTxt.Text).ToString("dd/MM/yyyy")));
 

            ReportParameter paramFields = new ReportParameter("pDisplayFields");

            int status = Int32.Parse(this.CSTSFCBox.SelectedValue.ToString());
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
            _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\CourseList.rdlc");

            QMSRSToolsENRDLCDataSetTableAdapters.GetCoursesTableAdapter _TableAdapter = new QMSRSToolsENRDLCDataSetTableAdapters.GetCoursesTableAdapter();

            this.ReportViewer1.AsyncRendering = false;


         
            QMSRSToolsENRDLCDataSet.GetCoursesDataTable _DT = new QMSRSToolsENRDLCDataSet.GetCoursesDataTable();
            DateTime _endDate = this.TDTTxt.Text == string.Empty || this.TDTTxt.Text == "__/__/____" ? new DateTime(DateTime.Now.Year, 12, 31) : Convert.ToDateTime(this.TDTTxt.Text);
            DateTime _startdate = this.FDTTxt.Text == string.Empty || this.FDTTxt.Text == "__/__/____" ? new DateTime(DateTime.Now.Year, 1, 1) : Convert.ToDateTime(this.FDTTxt.Text);

            _DT = _TableAdapter.GetData(status, mode, _startdate, _endDate);
            this.ReportViewer1.LocalReport.DataSources.Clear();

            this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
            {
                Name = "DataSet1",
                Value = _DT

            });

            this.ReportViewer1.LocalReport.SetParameters(param);


            this.ReportViewer1.LocalReport.Refresh();


           // this.ReportViewer1.ServerReport.SetParameters(param);
           // this.ReportViewer1.ServerReport.Refresh();
        }
    }
}