<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="AttendanceList.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.AttendanceList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox">
         <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
    </div>   

    <div id="CourseTitleContainer" class="filter" style="display:block;">
        <div id="CourseTitleFLabel" class="filterlabel">Course Title:</div>
        <div id="CourseTitleFField" class="filterfield">
            <asp:TextBox ID="CTTLTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>
    
    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px;" OnClick="Search_Click"  />
  
       
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%">
    </rsweb:ReportViewer>

</div>   
<script type="text/javascript" language="javascript">
    $(function ()
    {
        $("#deletefilter").bind('click', function ()
        {
            reset();
            $("#<%=Search.ClientID%>").trigger('click');
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

    </script>
</asp:Content>
