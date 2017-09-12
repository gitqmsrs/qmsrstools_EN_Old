<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ViewRisks.aspx.cs" Inherits="QMSRSTools.RiskManagement.ViewRisks" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <div class="toolbox">
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                 <li id="byRSKSTS">Filter by Risk Status</li>
                 <li id="byRSKCAT">Filter by Risk Category</li>
                 <li id="byRSKMOD">Filter by Risk Mode</li>
                 <li id="byRSKTYP">Filter by Risk Type</li>
                 <li id="byACTEE">Filter by Actionee</li>
                 <li id="byCCNTR1">Filter by Cost Centre</li>
                 <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
        
        <div id="ActioneeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ActioneeLabel" style="width:100px;">Actionee:</div>
            <div id="ActioneeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="ACTEECBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
        </div>
            
        <div id="RiskModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RiskModeLabel" style="width:100px;">Risk Mode:</div>
            <div id="RiskModeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RSKMODCBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
        </div>

        <div id="RiskStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RiskStatusLabel" style="width:100px;">Risk Status:</div>
            <div id="RiskStatusField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RSKSTSCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
        </div>

        <div id="RiskCategoryContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RiskCategoryLabel" style="width:100px;">Risk Category:</div>
            <div id="RiskCategoryField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RSKCATCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
        </div>

        <div id="RiskTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RiskTypeLabel" style="width:100px;">Risk Type:</div>
            <div id="RiskTypeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RSKTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
        </div>

        <div id="CostCentreContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CostCentreLabel" style="width:100px;">Cost Centre:</div>
            <div id="CostCentreField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="CCNTRCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
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


            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

        
            $("#byACTEE").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#ActioneeContainer").show();
            });


            $("#byRSKSTS").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#RiskStatusContainer").show();

            });

            $("#byRSKCAT").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#RiskCategoryContainer").show();
            });

            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#RecordModeContainer").show();
            });


            $("#byRSKMOD").bind('click', function ()
            {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#RiskModeContainer").show();
            });

            $("#byRSKTYP").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#RiskTypeContainer").show();
            });

            $("#byCCNTR1").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#CostCentreContainer").show();
            });


            $("#byMeeting").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#RiskNameContainer").show();
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
