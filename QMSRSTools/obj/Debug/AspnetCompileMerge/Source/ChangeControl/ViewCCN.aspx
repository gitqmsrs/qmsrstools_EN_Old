<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.ViewCCN" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox">
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt="" />
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="ByDOCTYP">Filter by Document Type</li>
                <li id="byDCRType">Filter by DCR Type</li>
                <li id="byDCRStatus">Filter by DCR Status</li>
            </ul>
        </div>
    </div>

    <div id="DOCTypeContainer" class="filter">
        <div id="DocumentTypeLabel" class="filterlabel">Document Type:</div>
        <div id="DocumentTypeField" class="filterfield">
            <asp:DropDownList ID="DOCTYPCBox" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="DCRStatusContainer" class="filter">
        <div id="DCRStatusLabel" class="filterlabel">DCR Status:</div>
        <div id="DCRStatusField" class="filterfield">
            <asp:DropDownList ID="DCRSTSCBox" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="DCRtypeContainer" class="filter">
        <div id="DCRTypeLabel" class="filterlabel">DCR Type:</div>
        <div id="DCRTypeField" class="filterfield">
            <asp:DropDownList ID="DCRTYPCBox" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>
        
    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px; display:none;" OnClick="Search_Click"  />
        
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%">
    </rsweb:ReportViewer>
</div>   

<script type="text/javascript" language="javascript">

    $(function ()
    {
        $("#deletefilter").bind('click', function () {
            hideAll();
            $("#<%=Search.ClientID%>").trigger('click');
        });

        $("#byDCRType").bind('click', function () {

            hideAll();

            $("#<%=Search.ClientID%>").show();
            $("#DCRtypeContainer").show();
        });

        $("#ByDOCTYP").bind('click', function () {
            hideAll();

            $("#<%=Search.ClientID%>").show();

            $("#DOCTypeContainer").show();
        });

        $("#byDCRStatus").bind('click', function () {
            hideAll();

            $("#<%=Search.ClientID%>").show();

            $("#DCRStatusContainer").show();
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
        $("#<%=Search.ClientID%>").hide();

          $(".filter").each(function () {
              $(this).css('display', 'none');
          });

          reset();
      }
    </script>
</asp:Content>
