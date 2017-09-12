<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="AssetList.aspx.cs" Inherits="QMSRSTools.AssetManagement.AssetList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="toolbox" style="margin-top:0;">
            <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byCAT">Filter by Asset Category</li>
                    <li id="byASSTSTS">Filter by Asset Status</li>
                    <li id="byORG">Filter by Organization Unit</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>

            <div id="AssetCategoryContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="AssetCategoryFLabel" style="width:100px;">Asset Category:</div>
                <div id="AssetCategoryFField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ASSTCATFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            </div>

            <div id="AssetOrganizationUnitContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="AssetOrganizationFLabel" style="width:100px;">Organization Unit:</div>
                <div id="AssetOrganizationFField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            </div>

            <div id="AssetStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="AssetStatusFLabel" style="width:100px;">Asset Status:</div>
                <div id="AssetStatusFField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ASSTSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            </div>

            <div id="RecordModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
                <div id="RecordModeField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            </div>
     
            &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; display:none;" OnClick="Search_Click"  />
        </div>
         
       <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%">
       </rsweb:ReportViewer>
       <script type="text/javascript" language="javascript">
         $(function () {
             $("#deletefilter").bind('click', function ()
             {
                 hideAll();
                 $("#<%=Search.ClientID%>").trigger('click');
             });

             $("#byCAT").bind('click', function ()
             {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();
                 $("#AssetCategoryContainer").show();
             });


             $("#byUnit").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();
                 $("#UnitContainer").show();

             });

             $("#byASSTSTS").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#AssetStatusContainer").show();
             });

             $("#byORG").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#AssetOrganizationUnitContainer").show();
             });

             $("#byRECMOD").bind('click', function ()
             {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#RecordModeContainer").show();
             });
         });
         function reset() {
             $(".textbox").each(function () {
                 $(this).val('');
             });
             $(".combobox").each(function () {

                 $(this).val(-1);
             });
         }
         function hideAll() {
             $("#<%=Search.ClientID%>").hide();

            $(".filter").each(function () {
                $(this).css('display', 'none');
            });

            reset();
        }
    </script>
</asp:Content>
