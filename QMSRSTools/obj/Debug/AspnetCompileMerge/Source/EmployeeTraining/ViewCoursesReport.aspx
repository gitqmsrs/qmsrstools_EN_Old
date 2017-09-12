<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewCoursesReport.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.ViewCoursesReport" %>
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
                <li id="byStatus">Filter by Course Status</li>
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="bySTRTDT">Filter by Course Start Date</li>
            </ul>
        </div>       
    </div> 

    <div id="CourseStatusContainer" class="filter">
        <div id="CourseStatusFLabel" class="filterlabel">Course Status:</div>
        <div id="CourseStatusFField" class="filterfield">
            <asp:DropDownList ID="CSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="StartDateFilterContainer" class="filter">
        <div id="StartDateFLabel" class="filterlabel">Start Date:</div>
        <div id="StartDateFField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>

    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px; display:none;" OnClick="Search_Click"  />

    <rsweb:reportviewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%">
    </rsweb:reportviewer>
</div>

<script type="text/javascript" language="javascript">
        $(function ()
        {
            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

           
    
            $("#byStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#CourseStatusContainer").show();

              });

            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#RecordModeContainer").show();

            });

            $("#bySTRTDT").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                 $("#StartDateFilterContainer").show();
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
