<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManagementReviewList.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ManagementReviewList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox">
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                 <li id="byRepresentatives">Filter by Representative</li>
                 <li id="byUnit">Filter by Organization unit</li>
                 <li id="byReviewStatus">Filter by Review Status</li>
                 <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
    
        <div id="RepresentativeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RepresentativeLabel" style="width:100px;">Auditor:</div>
            <div id="RepresentativeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="REPRCBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
        </div>
            
        <div id="UnitContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="UnitLabel" style="width:100px;">Org. Unit:</div>
            <div id="UnitField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="UNTCBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
        </div>

        <div id="ReviewStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ReviewStatusFLabel" style="width:100px;">Course Status:</div>
            <div id="ReviewStatusFField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="REVSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
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
    
    <rsweb:reportviewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%">
    </rsweb:reportviewer>
            
    <script type="text/javascript" language="javascript">
        $(function () {
            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

            $("#byRepresentatives").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#RepresentativeContainer").show();
            });


            $("#byUnit").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#UnitContainer").show();

            });

            $("#byReviewStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#ReviewStatusContainer").show();
            });

            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#RecordModeContainer").show();
            });


            $("#byCAT").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#ReviewCategoryContainer").show();
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
