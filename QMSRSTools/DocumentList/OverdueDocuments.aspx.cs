using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace QMSRSTools.DocumentList
{
    public partial class OverdueDocuments : System.Web.UI.Page
    {
        private string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private Xml_Manager oXml_Manager = new Xml_Manager();
        private Xml_Manager.Column oColumn = new Xml_Manager.Column();
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Session["Guid"] = "";

                int ColNo = 7;
                int ColW;
                string ColWidth = "50";
                if (ColNo > 7)
                {
                    ColW = (700 / ColNo) / 2;
                    ColWidth = ColW.ToString();
                }
                int index = 0;
                int indexcol = 0;

                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");


                DataTable data = GetData(_DisplayFields);

                if (data.Rows.Count > 0)
                {
                    foreach (DataRow Row in data.Rows)
                    {
                        foreach (DataColumn Col in data.Columns)
                        {
                            #region

                            if (index > 19)
                            {
                                index = 0;
                            }
                            #endregion

                            oColumn = new Xml_Manager.Column();
                            oColumn.Color = Colors[index++];
                            oColumn.Name = Col.ColumnName;
                            oColumn.Value = Row.ItemArray[indexcol++].ToString();


                            oXml_Manager.columns.Add(oColumn);


                        }
                    }
                    oXml_Manager.CreateXmlFile(Server.MapPath(""), "Overdue Documents Over Range Of Periods ", "", "Range Of Periods ", "", ColWidth, "0");
                    Session["Guid"] = oXml_Manager.strGuid;
                }
            }
        }
        protected DataTable GetData(List<string> _DisplayFields)
        {
            DataTable data = new DataTable();
            data.Columns.Add(new DataColumn("Total Overdue"));
            data.Columns.Add(new DataColumn("Over 1 Month"));
            data.Columns.Add(new DataColumn("Over 2 Months"));
            data.Columns.Add(new DataColumn("Over 3 Months"));

         



            List<LINQConnection.Document> documents = _context.Documents.Where(DOC=>DOC.RecordModeID==(int)RecordMode.Current)
            .Select(DOC => DOC).ToList();

            int _totaloverdue = 0;
            int _overonemonth = 0;
            int _overtwomonth = 0;
            int _overthreemonth = 0;

            foreach (var obj in documents)
            {
                if (obj.LastReviewDate.HasValue == true)
                {
                    if (DateTime.Now >= obj.LastReviewDate.Value.AddDays(Convert.ToDouble(obj.ReviewDurationDays)))
                    {
                        _totaloverdue++;
                    }
                    if (DateTime.Now >= obj.LastReviewDate.Value.AddDays(Convert.ToDouble(obj.ReviewDurationDays)) && DateTime.Now < obj.LastReviewDate.Value.AddDays(Convert.ToDouble(obj.ReviewDurationDays) + 30))
                    {
                        _overonemonth++;
                    }
                    if (DateTime.Now >= obj.LastReviewDate.Value.AddDays(Convert.ToDouble(obj.ReviewDurationDays) + 30) && DateTime.Now < obj.LastReviewDate.Value.AddDays(Convert.ToDouble(obj.ReviewDurationDays) + 60))
                    {
                        _overtwomonth++;
                    }
                    if (DateTime.Now >= obj.LastReviewDate.Value.AddDays(Convert.ToDouble(obj.ReviewDurationDays) + 60) && DateTime.Now < obj.LastReviewDate.Value.AddDays(Convert.ToDouble(obj.ReviewDurationDays) + 90))
                    {
                        _overthreemonth++;
                    }
                }
            }

            DataRow row = data.NewRow();

            row["Total Overdue"] = _totaloverdue;
            row["Over 1 Month"] = _overonemonth;
            row["Over 2 Months"] = _overtwomonth;
            row["Over 3 Months"] = _overthreemonth;
          


          

            data.Rows.Add(row);

            return data;
        }

        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            List<string> _DisplayFields = new List<string>();

            foreach (ListItem listitems in lstFields.Items)
            {
                if (listitems.Selected == true)
                    _DisplayFields.Add(listitems.Value);
            }

            if (_DisplayFields.Count == 0)
            {
                _DisplayFields = null;
            }

            int ColNo = 7;
            int ColW;
            string ColWidth = "50";
            if (ColNo > 7)
            {
                ColW = (700 / ColNo) / 2;
                ColWidth = ColW.ToString();
            }
            int index = 0;
            int indexcol = 0;

          


            DataTable data = GetData(_DisplayFields);

            if (data.Rows.Count > 0)
            {
                foreach (DataRow Row in data.Rows)
                {
                    foreach (DataColumn Col in data.Columns)
                    {
                        #region

                        if (index > 19)
                        {
                            index = 0;
                        }
                        #endregion

                        oColumn = new Xml_Manager.Column();
                        oColumn.Color = Colors[index++];
                        oColumn.Name = Col.ColumnName;
                        oColumn.Value = Row.ItemArray[indexcol++].ToString();
                        if (_DisplayFields != null)
                        {
                            if (_DisplayFields.First() == "ALL")
                                oXml_Manager.columns.Add(oColumn);
                            else
                            {
                                if (_DisplayFields.Contains(oColumn.Name))
                                    oXml_Manager.columns.Add(oColumn);
                            }
                        }

                      


                    }
                }
                oXml_Manager.CreateXmlFile(Server.MapPath(""), "Overdue Documents Over Range Of Periods ", "", "Range Of Periods ", "", ColWidth, "0");
                Session["Guid"] = oXml_Manager.strGuid;
            }


         //   FillChart(_DisplayFields);
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
        
    }
}