using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.ProblemManagement
{
    public partial class ProblemsByStatus : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        string[] Colors = { "ff0000", "ffcc00", "33cc00", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChart(_DisplayFields);
            }
        }

        protected void FillChart(List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable statistics = new DataTable();
            statistics.Columns.Add("Status");
            statistics.Columns.Add("Count");

            double open = 0;
            double closed = 0;
            double withdrawn = 0;
            double pending = 0;
            double Total = 0;


            var problems = _context.Problems
            .Where(PRM=>PRM.RecordModeID==(int)RecordMode.Current)
            .Select(PRM => PRM).ToList();

            foreach (var problem in problems)
            {
                switch ((ProblemStatus)problem.StatusID)
                {
                    case ProblemStatus.Closed:
                        closed++;
                        break;
                    case ProblemStatus.Open:
                        open++;
                        break;
                    case ProblemStatus.Cancelled:
                        withdrawn++;
                        break;
                    case ProblemStatus.Pending:
                        pending++;
                        break;
                }
            }

            Total = open + closed + withdrawn + pending;



            DataRow ragrow;

            if (_DisplayFields != null)
            {
                if (_DisplayFields.First() == "ALL")
                {
                    ragrow = statistics.NewRow();
                    ragrow["Status"] = ProblemStatus.Closed.ToString();
                    ragrow["Count"] = String.Format("{0:0.00}", closed == 0.0 ? 0.0 : ((closed / Total) * 100));
                    statistics.Rows.Add(ragrow);

                    ragrow = statistics.NewRow();
                    ragrow["Status"] = ProblemStatus.Open.ToString();
                    ragrow["Count"] = String.Format("{0:0.00}", open == 0.0 ? 0.0 : ((open / Total) * 100));
                    statistics.Rows.Add(ragrow);

                    ragrow = statistics.NewRow();
                    ragrow["Status"] = ProblemStatus.Cancelled.ToString();
                    ragrow["Count"] = String.Format("{0:0.00}", withdrawn == 0.0 ? 0.0 : ((withdrawn / Total) * 100));
                    statistics.Rows.Add(ragrow);

                    ragrow = statistics.NewRow();
                    ragrow["Status"] = ProblemStatus.Pending.ToString();
                    ragrow["Count"] = String.Format("{0:0.00}", pending == 0.0 ? 0.0 : ((pending / Total) * 100));
                    statistics.Rows.Add(ragrow);
                }
                else
                {
                    if (_DisplayFields.Contains("Closed"))
                    {
                        ragrow = statistics.NewRow();
                        ragrow["Status"] = ProblemStatus.Closed.ToString();
                        ragrow["Count"] = String.Format("{0:0.00}", closed == 0.0 ? 0.0 : ((closed / Total) * 100));
                        statistics.Rows.Add(ragrow);
                    }
                    if (_DisplayFields.Contains("Open"))
                    {
                        ragrow = statistics.NewRow();
                        ragrow["Status"] = ProblemStatus.Open.ToString();
                        ragrow["Count"] = String.Format("{0:0.00}", open == 0.0 ? 0.0 : ((open / Total) * 100));
                        statistics.Rows.Add(ragrow);
                    }
                    if (_DisplayFields.Contains("Cancelled"))
                    {
                        ragrow = statistics.NewRow();
                        ragrow["Status"] = ProblemStatus.Cancelled.ToString();
                        ragrow["Count"] = String.Format("{0:0.00}", withdrawn == 0.0 ? 0.0 : ((withdrawn / Total) * 100));
                        statistics.Rows.Add(ragrow);
                    }

                    if (_DisplayFields.Contains("Pending"))
                    {
                        ragrow = statistics.NewRow();
                        ragrow["Status"] = ProblemStatus.Pending.ToString();
                        ragrow["Count"] = String.Format("{0:0.00}", pending == 0.0 ? 0.0 : ((pending / Total) * 100));
                        statistics.Rows.Add(ragrow);
                    }


                }

            }
            PieXml_Manager oXml_Manager = new PieXml_Manager();
            PieXml_Manager.Column oColumn = new PieXml_Manager.Column();

            int index = 0;
            //int indexcol = 0;
            if (statistics.Rows.Count > 0)
            {
                foreach (DataRow RAG in statistics.Rows)
                {
                    if (index > 19)
                    {
                        index = 0;
                    }

                    oColumn = new PieXml_Manager.Column();
                    oColumn.Color = Colors[index++];
                    oColumn.Name = RAG.ItemArray[0].ToString();
                    oColumn.Value = RAG.ItemArray[1].ToString();
                    oXml_Manager.columns.Add(oColumn);
                }
            }

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Statistics of Problems Per Status", "", "", "");
            Session["Guid"] = oXml_Manager.strGuid;
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

            FillChart(_DisplayFields);
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }


    }
}