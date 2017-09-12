﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QMSRSTools.AssetManagement
{
    public partial class AssetCategoryBySupplier : System.Web.UI.Page
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
        private string[] Colors = { "175BE3", "FFB31A", "3C3C3C", "FFFD1A", "FF1A68", "74F418", "FF6E1A", "8215D3", "9966CC", "000000", "0090FF", "66FF00", "996666", "FF00FF", "80B880", "FF00CC", "CCCCFF", "CC99CC", "003366", "FF7028", "FFCC99", "1C39BB", "CC3333", "FFCC00", "8048A8", "8B8B00", "32CD32", "53868B", "B9D3EE", "6A5ACD" };
        private Xml_Manager oXml_Manager = new Xml_Manager();
        private Xml_Manager.Column oColumn = new Xml_Manager.Column();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.ASSTSUPPFCBox.DataSource = _context.Customers;
                this.ASSTSUPPFCBox.DataTextField = "CustomerName";
                this.ASSTSUPPFCBox.DataValueField = "CustomerID";
                this.ASSTSUPPFCBox.DataBind();
                this.ASSTSUPPFCBox.Items.Insert(0, new ListItem("Select Value", "-1"));

                FillChart(GetStatisticsBySupplier(this.ASSTSUPPFCBox.SelectedValue,null));
            }
        }
        protected Dictionary<string, string> GetStatisticsBySupplier(object customerID, List<string> _DisplayFields)
        {
            Dictionary<string, string> statistics = new Dictionary<string, string>();

            var assets = from supp in _context.Assets
                         where supp.SupplierId== Convert.ToInt32(customerID)
                         group (_context.Assets.Where(ASST => ASST.AssetCategoryId == supp.AssetCategoryId
                         && ASST.SupplierId == Convert.ToInt32(customerID)).ToArray().Count()) by supp.AssetCategory.CategoryName into g
                         select new { Category = g.Key, Count = g };

            foreach (var g in assets)
            {
                if (g.Category != null)
                {
                    if (_DisplayFields == null && !statistics.ContainsKey(g.Category))
                    {
                        statistics.Add(g.Category, g.Count.First().ToString());
                    }
                    else
                    {
                        if (_DisplayFields.Contains(g.Category) && !statistics.ContainsKey(g.Category))
                            statistics.Add(g.Category, g.Count.First().ToString());
                    }
                }
            }
            return statistics;
        }


        protected void Search_Click(object sender, ImageClickEventArgs e)
        {
            List<string> _DisplayFields = new List<string>();
            this.dropdownchange.Value = "CLICK";
            foreach (ListItem listitems in lstFields.Items)
            {
                if (listitems.Selected == true)
                    _DisplayFields.Add(listitems.Value);
            }

            if (_DisplayFields.Count == 0)
            {
                _DisplayFields = null;
             
                FillChart(GetStatisticsBySupplier("-1", null));  // null means ALL Fields

            }
            else
                FillChart(GetStatisticsBySupplier(this.ASSTSUPPFCBox.SelectedValue, _DisplayFields));  // null means ALL Fields
            


        }
        protected void FillChart(Dictionary<string, string> data)
        {
            Session["Guid"] = "";

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
                oXml_Manager.columns.Add(oColumn);
                oColumn = new Xml_Manager.Column();
                index++;
            }

            oXml_Manager.CreateXmlFile(Server.MapPath(""), "Count of Assets Filtered By Supplier", "Grouped By Asset Category", "", "", ColWidth, "0");

            Session["Guid"] = oXml_Manager.strGuid;
        }

        protected void ASSTSUPPFCBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList obj = (DropDownList)sender;
            if (obj.SelectedItem.Value != "-1")
            {
                this.dropdownchange.Value = "changed";

                var assets = from supp in _context.Assets
                             where supp.SupplierId == Convert.ToInt32(obj.SelectedValue)
                             group (_context.Assets.Where(ASST => ASST.AssetCategoryId == supp.AssetCategoryId
                             && ASST.SupplierId == Convert.ToInt32(obj.SelectedValue)).ToArray().Count()) by supp.AssetCategory.CategoryName into g
                             select new { Category = g.Key, Count = g };
                this.lstFields.Items.Clear();
                foreach (var g in assets)
                {
                    this.lstFields.Items.Insert(0, new ListItem(g.Category, g.Category));
                }
                FillChart(GetStatisticsBySupplier(obj.SelectedValue, null));  // null means ALL Fields
            }
            else {
                this.dropdownchange.Value = "NOT";
                FillChart(GetStatisticsBySupplier(obj.SelectedValue, null));  // null means ALL Fields
            }
        }

        protected string GetSitePath()
        {
            return QMSRS.Utilities.WebConfigurationManager.GetSitePath();
        }
    }
}