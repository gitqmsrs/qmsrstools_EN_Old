using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.ChangeControl
{
    public partial class CCNStatusBieChart : System.Web.UI.Page
    {
        private string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private PieXml_Manager oXml_Manager = new PieXml_Manager();
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();

        private int _cancelled;
        private int _opened;
        private int _closed;
        private int _total;

        private double _openedAVG;
        private double _closedAVG;
        private double _cancelledAVG;

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
            Session["Guid"] = null;

            #region Calculations

            _total = _context.ChangeControlNotes.Count();
            _cancelled = GetCancelledCCN();
            _closed = GetClosedCCN();
            _opened = GetOpenedCCN();

            _closedAVG = (Convert.ToDouble(_closed) / Convert.ToDouble(_total)) * 100;
            _openedAVG = (Convert.ToDouble(_opened) / Convert.ToDouble(_total)) * 100;
            _cancelledAVG = (Convert.ToDouble(_cancelled) / Convert.ToDouble(_total)) * 100;

            #endregion

          


            if (_DisplayFields != null)
            {
                if (_DisplayFields.First() == "ALL")
                {
                    PieXml_Manager.Column oColumn = new PieXml_Manager.Column();
                    oColumn.Color = Colors[0];
                    oColumn.Name = "Open";
                    oColumn.Value = String.Format("{0:0.00}", _openedAVG);
                    oXml_Manager.columns.Add(oColumn);

                    oColumn = new PieXml_Manager.Column();
                    oColumn.Color = Colors[1];
                    oColumn.Name = "Closed";
                    oColumn.Value = String.Format("{0:0.00}", _closedAVG);
                    oXml_Manager.columns.Add(oColumn);

                    oColumn = new PieXml_Manager.Column();
                    oColumn.Color = Colors[2];
                    oColumn.Name = "Cancelled";
                    oColumn.Value = String.Format("{0:0.00}", _cancelledAVG);
                    oXml_Manager.columns.Add(oColumn);
                }
                else
                {
                    PieXml_Manager.Column oColumn = new PieXml_Manager.Column();
                    if (_DisplayFields.Contains("Open"))
                    {
                       
                        oColumn.Color = Colors[0];
                        oColumn.Name = "Open";
                        oColumn.Value = String.Format("{0:0.00}", _openedAVG);
                        oXml_Manager.columns.Add(oColumn);
                    }
                    if (_DisplayFields.Contains("Closed"))
                    {
                        oColumn = new PieXml_Manager.Column();
                        oColumn.Color = Colors[1];
                        oColumn.Name = "Closed";
                        oColumn.Value = String.Format("{0:0.00}", _closedAVG);
                        oXml_Manager.columns.Add(oColumn);
                    }
                    if (_DisplayFields.Contains("Cancelled"))
                    {
                        oColumn = new PieXml_Manager.Column();
                        oColumn.Color = Colors[2];
                        oColumn.Name = "Cancelled";
                        oColumn.Value = String.Format("{0:0.00}", _cancelledAVG);
                        oXml_Manager.columns.Add(oColumn);
                    }
                       
                }
            }
           

            oXml_Manager.CraeteXmlFile(Server.MapPath(""), "Average of Opened, Closed, or Cancelled", "Document Change Requests", "", "");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected int GetOpenedCCN()
        {
            var opened = _context.ChangeControlNotes
                .Where(CCN => CCN.ChangeControlNoteStatus.CCNStatusID == (int)CCNStatus.Open && CCN.Document.RecordModeID==(int)RecordMode.Current)
                .Select(CCN => CCN).ToList().Count();

            return opened;
        }
        protected int GetClosedCCN()
        {
            var closed = _context.ChangeControlNotes
                .Where(CCN => CCN.ChangeControlNoteStatus.CCNStatusID == (int)CCNStatus.Closed && CCN.Document.RecordModeID == (int)RecordMode.Current)
                .Select(CCN => CCN).ToList().Count();

            return closed;
        }
        protected int GetCancelledCCN()
        {
            var cancelled = _context.ChangeControlNotes
                .Where(CCN => CCN.ChangeControlNoteStatus.CCNStatusID == (int)CCNStatus.Cancelled && CCN.Document.RecordModeID == (int)RecordMode.Current)
                .Select(CCN => CCN).ToList().Count();

            return cancelled;
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
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
        protected void alias_Click(object sender, EventArgs e)
        {
            List<string> _DisplayFields = new List<string>();
            _DisplayFields.Add("ALL");
            FillChart(_DisplayFields);
        }
    }
}