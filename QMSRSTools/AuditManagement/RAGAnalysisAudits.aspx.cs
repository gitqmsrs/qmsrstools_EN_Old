using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.AuditManagement
{
    public partial class RAGAnalysisAudits : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        string[] Colors = { "ff0000", "ffcc00", "33cc00", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
       
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.AUDTRCBox.DataSource = _context.fn_GetAuditors();
                this.AUDTRCBox.DataTextField = "EmployeeName";
                this.AUDTRCBox.DataValueField = "EmployeeID";
                this.AUDTRCBox.DataBind();
                this.AUDTRCBox.Items.Insert(0, new ListItem("Select Value", "-1"));


                this.UNTCBox.DataSource = _context.OrganizationUnits;
                this.UNTCBox.DataTextField = "UnitName";
                this.UNTCBox.DataValueField = "UnitID";
                this.UNTCBox.DataBind();
                this.UNTCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.AUDTTYPCBox.DataSource = _context.AuditTypes;
                this.AUDTTYPCBox.DataTextField = "AuditType1";
                this.AUDTTYPCBox.DataValueField = "AuditTypeId";
                this.AUDTTYPCBox.DataBind();
                this.AUDTTYPCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                this.AUDTSTSCBox.DataSource = _context.AuditStatus;
                this.AUDTSTSCBox.DataTextField = "AuditStatus1";
                this.AUDTSTSCBox.DataValueField = "AuditStatusID";
                this.AUDTSTSCBox.DataBind();
                this.AUDTSTSCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChart(_DisplayFields);
            }
        }
        protected void FilterChartByUnits(int unitID, string unit, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;



            var audits = _context.Audits.Join(_context.RelatedAuditUnits,
            AUDT => AUDT.AuditId, UNT => UNT.AuditID, (AUDT, UNT) => new { AUDT, UNT })
            .Where(UNTREC => UNTREC.UNT.UnitID == unitID)
            .Select(UNTREC => UNTREC);


            foreach (var audit in audits)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditManagement.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.AuditManagement.ToString(), Convert.ToInt32(audit.AUDT.AuditId));

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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Internal Audit Records", "Filtered By (" + unit + ")", "", "");
            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected void FilterChartByAuditors(int auditorID, string auditor, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;



            var audits = _context.Audits.Join(_context.Auditors,
            AUDT => AUDT.AuditId, AUDTR => AUDTR.AuditID, (AUDT, AUDTR) => new { AUDT, AUDTR })
            .Where(AUDTRREC => AUDTRREC.AUDTR.AuditorID == auditorID)
            .Select(AUDTRREC => AUDTRREC);

   
            foreach (var audit in audits)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditManagement.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.AuditManagement.ToString(), Convert.ToInt32(audit.AUDT.AuditId));

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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Internal Audit Records", "Filtered By Auditor(" + auditor + ")", "", "");
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


            var audits = _context.Audits.Select(AUDT => AUDT).ToList();

            foreach (var audit in audits)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditManagement.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.AuditManagement.ToString(), Convert.ToInt32(audit.AuditId));

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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Internl Audit Records", "", "", "");
            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected void FilterChartByAuditType(int audittypeID, string audittype, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;



            var audits = _context.Audits.Join(_context.Auditors,
            AUDT => AUDT.AuditId, AUDTR => AUDTR.AuditID, (AUDT, AUDTR) => new { AUDT, AUDTR })
            .Where(AUDTRREC => AUDTRREC.AUDT.AuditTypeId==audittypeID)
            .Select(AUDTRREC => AUDTRREC);


            foreach (var audit in audits)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditManagement.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.AuditManagement.ToString(), Convert.ToInt32(audit.AUDT.AuditId));

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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Internal Audit Records", "Filtered By Audit Type(" + audittype + ")", "", "");
            Session["Guid"] = oXml_Manager.strGuid;
        }


        protected void FilterChartByAuditStatus(int auditstatusID, string auditstatus, List<string> _DisplayFields)
        {
            Session["Guid"] = "";

            DataTable RAGStatistics = new DataTable();
            RAGStatistics.Columns.Add("RAG");
            RAGStatistics.Columns.Add("Count");

            double green = 0;
            double amber = 0;
            double red = 0;
            double Total = 0;



            var audits = _context.Audits.Join(_context.Auditors,
            AUDT => AUDT.AuditId, AUDTR => AUDTR.AuditID, (AUDT, AUDTR) => new { AUDT, AUDTR })
            .Where(AUDTRREC => AUDTRREC.AUDT.AuditStatusID == auditstatusID)
            .Select(AUDTRREC => AUDTRREC);


            foreach (var audit in audits)
            {

                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == Modules.AuditManagement.ToString())
                .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                RAGProcessor processor;
                foreach (var equation in equations)
                {
                    processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, Modules.AuditManagement.ToString(), Convert.ToInt32(audit.AUDT.AuditId));

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

            oXml_Manager.CraeteXmlFile((Server.MapPath("")), "Rag Analysis of Internal Audit Records", "Filtered By Audit Status(" + auditstatus + ")", "", "");
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
                 FilterChartByUnits(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text,null);
            else
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FilterChartByUnits(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, _DisplayFields);
            }

        }

        protected void AUDTRCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList obj = (DropDownList)sender;

            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "AUDTRCBox";
            if (obj.SelectedItem.Value == "-1")
                 FilterChartByAuditors(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text,null);
            else
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FilterChartByAuditors(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, _DisplayFields);
            }
        }

        protected void AUDTTYPCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList obj = (DropDownList)sender;
            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "AUDTTYPCBox";
            if (obj.SelectedItem.Value == "-1")
                 FilterChartByAuditType(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text,null);
            else
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FilterChartByAuditType(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, _DisplayFields);
            }
        }

        protected void AUDTSTSCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList obj = (DropDownList)sender;

            this.dropdownchange.Value = "changed";
            this.activedropdown.Value = "AUDTSTSCBox";
            if (obj.SelectedItem.Value == "-1")
                 FilterChartByAuditStatus(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text,null);
            else
            {
                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FilterChartByAuditStatus(Convert.ToInt32(obj.SelectedItem.Value), obj.SelectedItem.Text, _DisplayFields);
            }
        }

        protected void Reset_Click(object sender, ImageClickEventArgs e)
        {
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            FillChart(_DisplayFields);

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
                FilterChartByUnits(Convert.ToInt32(this.UNTCBox.SelectedValue), this.UNTCBox.SelectedItem.Text, _DisplayFields);
            }
            else if (_activedropdown == "AUDTRCBox")
            {
                FilterChartByAuditors(Convert.ToInt32(this.AUDTRCBox.SelectedValue), this.AUDTRCBox.SelectedItem.Text, _DisplayFields);

            }
            else if (_activedropdown == "AUDTTYPCBox")
            {
                FilterChartByAuditType(Convert.ToInt32(this.AUDTTYPCBox.SelectedValue), this.AUDTTYPCBox.SelectedItem.Text, _DisplayFields);

            }
            else if (_activedropdown == "AUDTSTSCBox")
            {
                FilterChartByAuditStatus(Convert.ToInt32(this.AUDTSTSCBox.SelectedValue), this.AUDTSTSCBox.SelectedItem.Text, _DisplayFields);

            }
            else
            {
                FillChart(_DisplayFields);
            }
        }
        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}