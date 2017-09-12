<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ViewActions.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ViewActions" %>
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
                    <li id="byProblemType">Filter by Problem Type</li>
                    <li id="byActionType">Filter by Action Type</li>
                    <li id="byProblemStatus">Filter by Problem Status</li>
                    <li id="byActionee">Filter by Actionee</li>
                </ul>
            </div>
     </div>
     
     
     <div id="ProblemTypeContainer" class="filter">
        <div id="ProblemTypeLabel" class="filterlabel">Problem Type:</div>
        <div id="ProblemTypeField" class="filterfield">
            <asp:DropDownList ID="PRMTYPCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
     </div>
            
     <div id="ActionTypeContainer" class="filter">
        <div id="ActionTypeLabel" class="filterlabel">Action Type:</div>
        <div id="ActionTypeField" class="filterfield">
            <asp:DropDownList ID="ACTTYPCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
     </div>
     
     <div id="ProblemStatusContainer" class="filter">
        <div id="ProblemStatusLabel" class="filterlabel">Problem Status:</div>
        <div id="ProblemStatusField" class="filterfield">
            <asp:DropDownList ID="PRMSTSCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
     </div>
      
     <div id="ActioneeContainer" class="filter">
        <div id="ActioneeLabel" class="filterlabel">Actionee:</div>
        <div id="ActioneeField" class="filterfield">
            <asp:DropDownList ID="ACTEECBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
     </div>  
        
     <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px; display:none;" OnClick="Search_Click"  />
        
     <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%">
     </rsweb:ReportViewer>

</div>
        
     <script type="text/javascript" language="javascript">
         $(function () {
             $("#deletefilter").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").trigger('click');
             });

             $("#byProblemType").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();
                 $("#ProblemTypeContainer").show();
             });


             $("#byProblemStatus").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#ProblemStatusContainer").show();
             });

             $("#byActionType").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#ActionTypeContainer").show();
             });

             $("#byActionee").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#ActioneeContainer").show();
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

         function hideAll() {
             $(".filter").each(function () {
                 $(this).css('display', 'none');
             });

             reset();
         }
    </script>

</asp:Content>

   