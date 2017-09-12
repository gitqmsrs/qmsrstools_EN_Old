using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.ProblemManagement
{
    public partial class ProblemBySeverity : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
   
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
               
                var severityList = _context.Severities.Select(SVR => SVR).ToList();

                foreach (var svr in severityList)
                {
                    int count = _context.Problems.Where(PRM => PRM.SeverityID == svr.SeverityID && PRM.RecordModeID == (int)RecordMode.Current).Count();
                    if (count > 0)
                    {
                        this.lstFields.Items.Insert(0, new ListItem(svr.Criteria + "(" + svr.Score + "%)", svr.Criteria + "(" + svr.Score + "%)"));

                       
                    }
                }


                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");

                FillChart(GetStatistics(), _DisplayFields);
            }
        }
        protected void FillChart(Dictionary<string, string> data, List<string> _DisplayFields)
        {
            int ColNo = data.Count;
            int ColW;

            string ColWidth = "50";

            if (ColNo > 7)
            {
                ColW = (700 / ColNo) / 2;
                ColWidth = ColW.ToString();
            }


            int index = 0;

            Xml_Manager.Column oColumn = new Xml_Manager.Column();
            Xml_Manager oXml_Manager = new Xml_Manager();

            foreach (KeyValuePair<string, string> obj in data)
            {
                oColumn.Color = Colors[index];
                oColumn.Name = obj.Key;
                oColumn.Value = obj.Value.ToString();


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
              


                oColumn = new Xml_Manager.Column();
                index++;
            }

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Statistics of Problems Grouped By Severity", "", "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected Dictionary<string, string> GetStatistics()
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var severityList = _context.Severities.Select(SVR => SVR).ToList();

            foreach (var svr in severityList)
            {
                int count =_context.Problems.Where(PRM=>PRM.SeverityID==svr.SeverityID && PRM.RecordModeID==(int)RecordMode.Current).Count();
                if (count > 0)
                {
                    statistics.Add(svr.Criteria + "(" + svr.Score + "%)", count.ToString());
                }
            }

            return statistics;
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

            FillChart(GetStatistics(), _DisplayFields);
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }


    }
}