using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.AssetManagement
{
    public partial class ElectricalTestStatusStatistics : System.Web.UI.Page
    {
        private string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private PieXml_Manager oXml_Manager = new PieXml_Manager();
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                for (int i = 0; i < _context.AssetElectricalTestStatus.ToArray().Count(); i++)
                {
                    var status = _context.AssetElectricalTestStatus.ToArray()[i];
                    this.lstFields.Items.Insert(0, new ListItem(status.ElectricalTestStatus, status.ElectricalTestStatus));
                }



                List<string> _DisplayFields = new List<string>();
                _DisplayFields.Add("ALL");
                FillChart(_DisplayFields);

            }
        }

        protected void FillChart(List<string> _DisplayFields)
        {
            Session["Guid"] = null;

            for (int i = 0; i < _context.AssetElectricalTestStatus.ToArray().Count(); i++)
            {
                var status = _context.AssetElectricalTestStatus.ToArray()[i];
                int assets = status.Assets.Count();
                int total = _context.Assets.Count();

                double AVG = (Convert.ToDouble(assets) / Convert.ToDouble(total)) * 100;

                PieXml_Manager.Column oColumn = new PieXml_Manager.Column();
                oColumn.Color = Colors[i];
                oColumn.Name = status.ElectricalTestStatus;
                oColumn.Value = String.Format("{0:0.00}", AVG);

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

            oXml_Manager.CraeteXmlFile(Server.MapPath(""), "Average of Assets Per Electrical Test Status", "", "", "");

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