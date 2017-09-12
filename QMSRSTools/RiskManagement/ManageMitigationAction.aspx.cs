﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace QMSRSTools.RiskManagement
{
    public partial class ManageMitigationAction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                DataTable actions = new DataTable();
                actions.Columns.Add("RSKTitle");
                actions.Columns.Add("MitigationType");
                actions.Columns.Add("TargetCloseDate");
                actions.Columns.Add("ActualCloseDate");
                actions.Columns.Add("Actionee");
                actions.Columns.Add("Status");
                actions.Rows.Add();

                this.gvActions.DataSource = actions;
                this.gvActions.DataBind();
            }
        }
    }
}