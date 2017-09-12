<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="AttendanceList.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.AttendanceList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="toolbox">
        <div id="CourseTitleContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="CourseTitleFLabel" style="width:100px;">Course Title:</div>
            <div id="CourseTitleFField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="CTTLTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
             </div>
        </div>

        &nbsp;&nbsp;
        <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />
       
    </div>
    <rsweb:reportviewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%">
    </rsweb:reportviewer>
       
    <script type="text/javascript" language="javascript">
        $(function () {
            
            $("#byTitle").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#CourseTitleContainer").show();
            });
        });

    </script>
</asp:Content>
