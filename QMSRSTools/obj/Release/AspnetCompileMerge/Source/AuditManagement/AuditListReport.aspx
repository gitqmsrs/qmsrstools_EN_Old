<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="AuditListReport.aspx.cs" Inherits="QMSRSTools.AuditManagement.AuditListReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="toolbox" style="margin-top:0;">
            <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="../../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byAuditor">Filter by Auditor</li>
                    <li id="byUnit">Filter by Organization unit</li>
                    <li id="byAuditStatus">Filter by Audit Status</li>
                    <li id="byAUDTType">Filter by Audit type</li>
            
                </ul>
            </div>
            <div id="AuditorContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="AuditorLabel" style="width:100px;">Auditor:</div>
                 <div id="AuditorField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="AUDTRCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>

            
            <div id="AuditTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="AuditTypeFilterLabel" style="width:100px;">Audit Type:</div>
                <div id="AuditTypeFilterField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="AUDTTYPFCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
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

            <div id="AuditStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="AuditStatusLabel" style="width:100px;">Audit Status:</div>
                 <div id="AuditStatusField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="AUDTSTSCBox" runat="server" Width="150px" CssClass="combobox">
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
