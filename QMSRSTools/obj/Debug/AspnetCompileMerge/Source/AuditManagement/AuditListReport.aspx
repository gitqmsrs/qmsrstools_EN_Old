<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="AuditListReport.aspx.cs" Inherits="QMSRSTools.AuditManagement.AuditListReport" %>
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
                <li id="byAuditor">Filter by Auditor</li>
                <li id="byUnit">Filter by Organization unit</li>
                <li id="byAuditStatus">Filter by Audit Status</li>
                <li id="byAUDTType">Filter by Audit type</li>
            </ul>
        </div>        
    </div>
        
    <div id="AuditorContainer" class="filter">
        <div id="AuditorLabel" class="filterlabel">Auditor:</div>
        <div id="AuditorField" class="filterfield">
            <asp:DropDownList ID="AUDTRCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>
       
    <div id="AuditTypeContainer" class="filter">
        <div id="AuditTypeFilterLabel" class="filterlabel">Audit Type:</div>
        <div id="AuditTypeFilterField" class="filterfield">
            <asp:DropDownList ID="AUDTTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="UnitContainer" class="filter">
        <div id="UnitLabelFilterLabel" class="filterlabel">Org. Unit:</div>
        <div id="UnitLabelFilterField" class="filterfield">
            <asp:DropDownList ID="UNTCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>

    <div id="AuditStatusContainer" class="filter">
        <div id="AuditStatusLabel" class="filterlabel">Audit Status:</div>
        <div id="AuditStatusField" class="filterfield">
            <asp:DropDownList ID="AUDTSTSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
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

            $("#byAuditor").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#AuditorContainer").show();
            });


            $("#byUnit").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#UnitContainer").show();

            });

            $("#byAuditStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#AuditStatusContainer").show();
            });

             $("#byAUDTType").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#AuditTypeContainer").show();
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
