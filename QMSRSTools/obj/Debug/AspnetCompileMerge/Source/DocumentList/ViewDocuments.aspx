<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewDocuments.aspx.cs" Inherits="QMSRSTools.DocumentList.ViewDocuments" %>
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
                <li id="byType">Filter by Document Type</li>
                <li id="byUnit">Filter by Organization Unit</li>
                <li id="byProject">Filter by Porject Name</li>
                <li id="byStatus">Filter by Document Status</li>
                <li id="byOverDue">Filter by Overdue Duration</li>
            </ul>
        </div>
    </div>

    <div id="DOCTypeContainer" class="filter">
        <div id="DocumentTypeLabel" class="filterlabel">Document Type:</div>
        <div id="DocumentTypeField" class="filterfield">
            <asp:DropDownList ID="DOCTYPCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="UnitContainer" class="filter">
        <div id="UnitLabel" class="filterlabel">Org. Unit:</div>
        <div id="UnitField" class="filterfield">
            <asp:DropDownList ID="UNTCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>

    <div id="ProjectContainer" class="filter">
        <div id="ProjectNameLabel" class="filterlabel">Project Name:</div>
        <div id="ProjectNameField" class="filterfield">
            <asp:DropDownList ID="PRJCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>

    <div id="OverdueContainer" class="filter">
        <div id="OverdueDurationLabel" class="filterlabel">Overdue Duration:</div>
        <div id="OverdueDurationField" class="filterfield">
            <asp:DropDownList ID="OVRDUECBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>

    <div id="DocumentStatusContainer" class="filter">
        <div id="DocumentStatusLabel" class="filterlabel">Document Status:</div>
        <div id="DocumentStatusField" class="filterfield">
            <asp:DropDownList ID="DOCSTSCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>  
    
    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="display:none;" OnClick="Search_Click"  />
 
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%">
     </rsweb:ReportViewer>
</div>         
<script type="text/javascript" language="javascript">
        $(function () {
            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

            $("#byType").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#DOCTypeContainer").show();
            });


            $("#byUnit").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#UnitContainer").show();

            });

            $("#byProject").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#ProjectContainer").show();

            });

            $("#byOverDue").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#OverdueContainer").show();

            });

            $("#byStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#DocumentStatusContainer").show();
            });
        });

        function reset()
        {
            $(".filtertext").each(function () {
                $(this).val('');
            });

            $(".comboboxfilter").each(function () {

                $(this).val(-1);
            });
        }

        function hideAll()
        {
            $("#<%=Search.ClientID%>").hide();

            $(".filter").each(function ()
            {
                $(this).css('display', 'none');
            });

            reset();
        }
    </script>
</asp:Content>
