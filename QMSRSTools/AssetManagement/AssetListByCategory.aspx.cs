using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

namespace QMSRSTools.AssetManagement
{
    public partial class AssetListByCategory : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext context = new LINQConnection.QMSRSContextDataContext();


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
//                string reportpath = System.Configuration.ConfigurationManager.AppSettings["ReportPath"];
//                string domain = System.Configuration.ConfigurationManager.AppSettings["ReportServerUrl"];

//                CustomReportCredentials obj = new CustomReportCredentials("AssetListByCategory", reportpath, domain);
//                obj.UserName = System.Configuration.ConfigurationManager.AppSettings["ReportServerUserName"];
//                obj.Password = System.Configuration.ConfigurationManager.AppSettings["ReportServerPassword"];

                this.ASSTCATFCBox.DataSource = context.AssetCategories;
                this.ASSTCATFCBox.DataTextField = "CategoryName";
                this.ASSTCATFCBox.DataValueField = "AssetCategoryId";
                this.ASSTCATFCBox.DataBind();
                this.ASSTCATFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.ASSTSTSFCBox.DataSource = context.AssetStatus;
                this.ASSTSTSFCBox.DataTextField = "AssetStatus1";
                this.ASSTSTSFCBox.DataValueField = "AssetStatusID";
                this.ASSTSTSFCBox.DataBind();
                this.ASSTSTSFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.ORGUNTFCBox.DataSource = context.OrganizationUnits;
                this.ORGUNTFCBox.DataTextField = "UnitName";
                this.ORGUNTFCBox.DataValueField = "UnitID";
                this.ORGUNTFCBox.DataBind();
                this.ORGUNTFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.RECMODCBox.DataSource = context.RecordModes;
                this.RECMODCBox.DataTextField = "RecordMode1";
                this.RECMODCBox.DataValueField = "RecordModeID";
                this.RECMODCBox.DataBind();
                this.RECMODCBox.Items.Insert(0, new ListItem("Select Value", "-1"));



               this.ReportViewer1.ProcessingMode = ProcessingMode.Local;

                this.ReportViewer1.AsyncRendering = false;

                this.ReportViewer1.ShowCredentialPrompts = false;
                this.ReportViewer1.ShowParameterPrompts = false;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\AssetListByCategory.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.AssetListTableAdapter DS = new QMSRSToolsENRDLCDataSetTableAdapters.AssetListTableAdapter();


                QMSRSToolsENRDLCDataSet.AssetListDataTable _DT = new QMSRSToolsENRDLCDataSet.AssetListDataTable();
                _DT = DS.GetData(-1, -1, -1, -1);
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                {
                    Name = "DataSet1",
                    Value = _DT

                });
                this.ReportViewer1.LocalReport.Refresh();



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

            try
            {
                List<ReportParameter> param = new List<ReportParameter>();
                param.Add(new ReportParameter("category", this.ASSTCATFCBox.SelectedValue));
                param.Add(new ReportParameter("status", this.ASSTSTSFCBox.SelectedValue));
                param.Add(new ReportParameter("department", this.ORGUNTFCBox.SelectedValue));
                param.Add(new ReportParameter("mode", this.RECMODCBox.SelectedValue));

                ReportParameter paramFields = new ReportParameter("pDisplayFields");


                //get values of ListBox Fields





                int _cat = Convert.ToInt32(this.ASSTCATFCBox.SelectedValue);
                int _stat = Convert.ToInt32(this.ASSTSTSFCBox.SelectedValue);
                int _dept = Convert.ToInt32(this.ORGUNTFCBox.SelectedValue);
                int _mode = Convert.ToInt32(this.RECMODCBox.SelectedValue);
                //get values of ListBox Fields


                List<string> l = new List<string>();

                foreach (ListItem listitems in lstFields.Items)
                {
                    if (listitems.Selected == true)
                        l.Add(listitems.Value);
                }

                if (l.Count == 0)
                {
                    l.Add("Category");
                }
                // string[] values = new string[] { "Description", "PurchasePrice", "CurrencyCode", "PurchaseDate", "Owner" };
                string[] values = l.ToArray();
                paramFields.Values.AddRange(values);
                param.Add(paramFields);
                //   this.ReportViewer1.ServerReport.SetParameters(param);



                this.ReportViewer1.ProcessingMode = ProcessingMode.Local;
                LocalReport _localReport = this.ReportViewer1.LocalReport;
                _localReport.ReportPath = System.Web.HttpContext.Current.Server.MapPath(@"~\Reports\SSRS\AssetListByCategory.rdlc");

                QMSRSToolsENRDLCDataSetTableAdapters.AssetListTableAdapter DS = new QMSRSToolsENRDLCDataSetTableAdapters.AssetListTableAdapter();

                this.ReportViewer1.AsyncRendering = false;


                QMSRSToolsENRDLCDataSet.AssetListDataTable _DT = new QMSRSToolsENRDLCDataSet.AssetListDataTable();
                _DT = DS.GetData(_cat, _stat, _dept, _mode);
                this.ReportViewer1.LocalReport.DataSources.Clear();

                this.ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource()
                {
                    Name = "DataSet1",
                    Value = _DT

                });

                this.ReportViewer1.LocalReport.SetParameters(param);


                this.ReportViewer1.LocalReport.Refresh();



            }
            catch (Exception ex)
            {

            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}