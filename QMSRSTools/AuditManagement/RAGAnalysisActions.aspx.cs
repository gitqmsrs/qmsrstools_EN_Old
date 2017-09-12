using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AuditManagement
{
    public partial class RAGAnalysisActions : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        string[] Colors = { "ff0000", "ffcc00", "33cc00", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.ACTEECBox.DataSource = _context.fn_GetActionees1();
                this.ACTEECBox.DataTextField = "EmployeeName";
                this.ACTEECBox.DataValueField = "EmployeeID";
                this.ACTEECBox.DataBind();
              

                this.ACTCBox.DataSource = _context.AuditActionTypes;
                this.ACTCBox.DataTextField = "Name";
                this.ACTCBox.DataValueField = "AuditActionTypeId";
                this.ACTCBox.DataBind();
              

                this.UNTCBox.DataSource = _context.OrganizationUnits;
                this.UNTCBox.DataTextField = "UnitName";
                this.UNTCBox.DataValueField = "UnitID";
                this.UNTCBox.DataBind();


                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChart(_DisplayFields);

              
            }
        }


        protected void Search_Click(object sender, ImageClickEventArgs e)
        {

            List<string> _DisplayFields = new List<string>();
            this.dropdownchange.Value = "CLICK";
            string _activedropdown = this.activedropdown.Value;

            foreach (ListItem listitems in lstFields.Items)
            {
                if (listitems.Selected == true)
                    _DisplayFields.Add(listitems.Value);

            }
            if (_DisplayFields.Count == 0)
            {
                _DisplayFields = null;
            }

            if (_activedropdown == "UNTCBox")
            {
                FillChartByUnit(Convert.ToInt32(this.UNTCBox.SelectedValue), this.UNTCBox.SelectedItem.Text, _DisplayFields);
            }
            else if (_activedropdown == "ACTEECBox")
            {
                FillChartByActionee(Convert.ToInt32(this.ACTEECBox.SelectedValue), this.ACTEECBox.SelectedItem.Text, _DisplayFields);
               
            }
            else if (_activedropdown == "ACTCBox")
            {
                FillChartByAction(Convert.ToInt32(this.ACTCBox.SelectedValue), this.ACTCBox.SelectedItem.Text, _DisplayFields);

            }
            else
            {
                FillChart(_DisplayFields);
            }


        }
        protected void Reset_Click(object sender, ImageClickEventArgs e)
        {
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            FillChart(_DisplayFields);

        }
        protected void FillChartByAction(int actiontypeID, string actiontype, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;



            var actions = _context.AuditActions.Where(ACT => ACT.AuditActionTypeId == actiontypeID).Select(ACT => ACT);
            foreach (var action in actions)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditAction.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.AuditAction.ToString(), Convert.ToInt32(action.AuditActionId));

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
             if (_DisplayFields != null) // display field can be null if nothing is selected.
            {
                if (_DisplayFields.Contains("Red") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Red";
            ragrow["Count"] = String.Format("{0:0.00}", red == 0.0 ? 0.0 : ((red / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                        }

                if (_DisplayFields.Contains("Amber") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Amber";
            ragrow["Count"] = String.Format("{0:0.00}", amber == 0.0 ? 0.0 : ((amber / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                     }

                if (_DisplayFields.Contains("Green") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Green";
            ragrow["Count"] = String.Format("{0:0.00}", green == 0.0 ? 0.0 : ((green / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                }

            }
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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Audit Actions", "Filtered By Action Type(" + actiontype + ")", "", "");
            Session["Guid"] = oXml_Manager.strGuid;

        }
        protected void FillChartByActionee(int actioneeID, string actionee, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;


          
                var actions = _context.AuditActions.Where(ACT => ACT.ActioneeId==actioneeID).Select(ACT => ACT);
                foreach (var action in actions)
                {

                    List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditAction.ToString())
                    .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                    RAGProcessor processor;
                    foreach (var equation in equations)
                    {
                        processor = new RAGProcessor();
                        processor.ProcessTokens(equation.Condition, Modules.AuditAction.ToString(), Convert.ToInt32(action.AuditActionId));

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
              if (_DisplayFields != null) // display field can be null if nothing is selected.
            {
                if (_DisplayFields.Contains("Red") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Red";
            ragrow["Count"] = String.Format("{0:0.00}", red == 0.0 ? 0.0 : ((red / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                      }

                if (_DisplayFields.Contains("Amber") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Amber";
            ragrow["Count"] = String.Format("{0:0.00}", amber == 0.0 ? 0.0 : ((amber / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                     }

                if (_DisplayFields.Contains("Green") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Green";
            ragrow["Count"] = String.Format("{0:0.00}", green == 0.0 ? 0.0 : ((green / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                }

            }
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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Audit Actions", "Filtered By Actionee(" + actionee + ")", "", "");
            Session["Guid"] = oXml_Manager.strGuid;

        }
        protected void FillChartByUnit(int unitID, string unitname, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;


            var units = _context.RelatedAuditUnits.Where(UNT => UNT.UnitID == unitID).Select(UNT => UNT);
            foreach (var unit in units)
            {
                var actions = _context.AuditActions.Where(ACT => ACT.Finding.Audit.AuditId == unit.AuditID).Select(ACT => ACT);
                foreach (var action in actions)
                {

                    List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditAction.ToString())
                    .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                    RAGProcessor processor;
                    foreach (var equation in equations)
                    {
                        processor = new RAGProcessor();
                        processor.ProcessTokens(equation.Condition, Modules.AuditAction.ToString(), Convert.ToInt32(action.AuditActionId));

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
            }
           
            Total = red + amber + green;

            DataRow ragrow;

            if (_DisplayFields != null) // display field can be null if nothing is selected.
            {
                if (_DisplayFields.Contains("Red") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Red";
            ragrow["Count"] = String.Format("{0:0.00}", red == 0.0 ? 0.0 : ((red / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                }

                if (_DisplayFields.Contains("Amber") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Amber";
            ragrow["Count"] = String.Format("{0:0.00}", amber == 0.0 ? 0.0 : ((amber / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                 }

                if (_DisplayFields.Contains("Green") || _DisplayFields.First() == "ALL")
                {
            ragrow = RAGStatistics.NewRow();
            ragrow["RAG"] = "Green";
            ragrow["Count"] = String.Format("{0:0.00}", green == 0.0 ? 0.0 : ((green / Total) * 100));
            RAGStatistics.Rows.Add(ragrow);
                }

            }
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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Audit Actions", "Filtered By " + unitname, "", "");
            Session["Guid"] = oXml_Manager.strGuid;
   
        }
        protected void FillChart(List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;


            var auditactions = _context.AuditActions.Select(AUDT => AUDT).ToList();

            foreach (var audit in auditactions)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditAction.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.AuditAction.ToString(), Convert.ToInt32(audit.AuditActionId));

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


            if (_DisplayFields != null) // display field can be null if nothing is selected.
            {
                if (_DisplayFields.Contains("Red") || _DisplayFields.First() == "ALL")
                {
                    ragrow = RAGStatistics.NewRow();
                    ragrow["RAG"] = "Red";
                    ragrow["Count"] = String.Format("{0:0.00}", red == 0.0 ? 0.0 : ((red / Total) * 100));
                    RAGStatistics.Rows.Add(ragrow);
                }

                if (_DisplayFields.Contains("Amber") || _DisplayFields.First() == "ALL")
                {
                    ragrow = RAGStatistics.NewRow();
                    ragrow["RAG"] = "Amber";
                    ragrow["Count"] = String.Format("{0:0.00}", amber == 0.0 ? 0.0 : ((amber / Total) * 100));
                    RAGStatistics.Rows.Add(ragrow);
                }

                if (_DisplayFields.Contains("Green") || _DisplayFields.First() == "ALL")
                {
                    ragrow = RAGStatistics.NewRow();
                    ragrow["RAG"] = "Green";
                    ragrow["Count"] = String.Format("{0:0.00}", green == 0.0 ? 0.0 : ((green / Total) * 100));
                    RAGStatistics.Rows.Add(ragrow);
                }

            }

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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Audit Actions", "", "", "");
            Session["Guid"] = oXml_Manager.strGuid;
        }

        private string getRAG(LINQConnection.RAGCondition condition)
        {
            var symbol = _context.RAGConditionSymbols.Where(RAG => RAG.RAGSymbolID == condition.RAGSymbolID)
            .Select(RAG => RAG.RAGSymbol).SingleOrDefault();

            return symbol;
        }

        protected void UNTCBox_SelectedIndexChanged(object sender, EventArgs e)
        {

            DropDownList obj = (DropDownList)sender;

            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "UNTCBox";
            if (obj.SelectedItem.Value == "-1")
                FillChartByUnit(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, null);
            else
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChartByUnit(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, _DisplayFields);
            }
        }

        protected void ACTEECBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "ACTEECBox";
            DropDownList obj = (DropDownList)sender;

            if (obj.SelectedItem.Value == "-1")
                FillChartByActionee(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text,null);
            else
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChartByActionee(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, _DisplayFields);
            }
            
        }

        protected void ACTCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "ACTCBox";
            DropDownList obj = (DropDownList)sender;

            if (obj.SelectedItem.Value == "-1")
                FillChartByAction(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text,null);
            else
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChartByAction(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, _DisplayFields);
            }
          
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}