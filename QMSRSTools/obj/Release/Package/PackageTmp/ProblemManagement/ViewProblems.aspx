<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ViewProblems.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ViewProblems" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
     <div class="toolbox">
            <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byPartyType">Filter by Affected Party Type</li>
                    <li id="byProblemType">Filter by Problem Type</li>
                    <li id="byRootCause">Filter by Root Cause</li>
                    <li id="byProblemStatus">Filter by Problem Status</li>
                    <li id="byRecordMode">Filter by Record Mode</li>
                </ul>
            </div>
     </div>

     <div id="ProblemTypeContainer" class="filter">
        <div id="ProblemTypeLabel" class="filterlabel">Problem Type:</div>
        <div id="ProblemTypeField" class="filterfield">
            <asp:DropDownList ID="PRMTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

     <div id="RootCauseContainer"class="filter">
        <div id="RootCauseLabel" class="filterlabel">Root Cause:</div>
        <div id="RootCauseField" class="filterfield">
            <asp:DropDownList ID="RTCUSCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>    
     </div>

     <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

     <div id="ProblemStatusContainer" class="filter">
        <div id="ProblemStatusLabel" class="filterlabel">Problem Status:</div>
        <div id="ProblemStatusField" class="filterfield">
            <asp:DropDownList ID="PRMSTSCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

     <div id="PartyTypeContainer" class="filter">
        <div id="PartyTypeLabel" class="filterlabel">Affected Party Type:</div>
        <div id="PartyTypeField" class="filterfield">
            <asp:DropDownList ID="PRTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

     <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px; display:none;" OnClick="Search_Click"  />
        
     <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%">
     </rsweb:ReportViewer>

        <script type="text/javascript" language="javascript">
            $(function () {
                $("#deletefilter").bind('click', function ()
                {
                    hideAll();
                    $("#<%=Search.ClientID%>").trigger('click');
                });

                $("#byPartyType").bind('click', function ()
                {
                    hideAll();

                    $("#<%=Search.ClientID%>").show();
                    $("#PartyTypeContainer").show();
                });


                $("#byProblemStatus").bind('click', function ()
                {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#ProblemStatusContainer").show();
                });

                $("#byProblemType").bind('click', function () {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#ProblemTypeContainer").show();
                });

                $("#byRootCause").bind('click', function () {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#RootCauseContainer").show();
                });

                $("#byRecordMode").bind('click', function () {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#RecordModeContainer").show();
                });

            });

         function reset() {
             $(".filtertext").each(function () {
                 $(this).val('');
             });

             $(".comboboxfilter").each(function () {

                 $(this).val(-1);
             });
         }

         function hideAll() {
             $(".filter").each(function () {
                 $(this).css('display', 'none');
             });

             reset();
         }
    </script>

</div>
</asp:Content>
