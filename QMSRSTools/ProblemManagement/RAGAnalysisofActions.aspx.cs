using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace QMSRSTools.ProblemManagement
{
    public partial class RAGAnalysisofActions : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        string[] Colors = { "ff0000", "ffcc00", "33cc00", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        
        protected void Page_Load(object sender, EventArgs e)
        {
            FillChart();
        }

        protected void FillChart()
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;


            var problemactions = _context.ProblemActions.Select(PRM => PRM).ToList();

            foreach (var action in problemactions)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.ProblemAction.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.ProblemAction.ToString(), action.ProblemActionID);

                    if (processor.Result == true)
                    {
                        string RAG = getRAG(equation);

                        switch (RAG)
                        {
                            case "RED":
                                red += 1;
                                break;
                            case "AMBER":
                                amber += 1;
                                break;
                            case "GREEN":
                                green += 1;
                                break;
                        }
                    }
                }
            }

            Total = red + amber + green;

           
    
            DataRow ragrow;

            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Red";
            ragrow["Count"] = String.Format("{0:0.00}", red == 0.0 ? 0.0 : ((red / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);

            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Amber";
            ragrow["Count"] = String.Format("{0:0.00}", amber == 0.0 ? 0.0 : ((amber / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);

            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Green";
            ragrow["Count"] = String.Format("{0:0.00}", green == 0.0 ? 0.0 : ((green / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);

            PieXml_Manager oXml_Manager = new PieXml_Manager();
            PieXml_Manager.Column oColumn = new PieXml_Manager.Column();
   
            int index = 0;
            //int indexcol = 0;
            if (RAGStatistics.Rows.Count > 0)
            {
                foreach (DataRow RAG in RAGStatistics.Rows)
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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Problem Actions", "", "", "");
            Session["Guid"] = oXml_Manager.strGuid;
        }

        private string getRAG(LINQConnection.RAGCondition condition)
        {
            var symbol = _context.RAGConditionSymbols.Where(RAG => RAG.RAGSymbolID == condition.RAGSymbolID)
            .Select(RAG => RAG.RAGSymbol).SingleOrDefault();

            return symbol;
        }

    }
}