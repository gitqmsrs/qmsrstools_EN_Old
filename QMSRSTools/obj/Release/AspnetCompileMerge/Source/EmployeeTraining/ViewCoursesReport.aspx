<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewCoursesReport.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.ViewCoursesReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox">
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byTitle">Filter by Course Title</li>
                <li id="byStatus">Filter by Course Status</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
    
        <div id="CourseTitleContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CourseTitleFLabel" style="width:100px;">Course Title:</div>
            <div id="CourseTitleFField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="CTTLTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
             </div>
        </div>

        <div id="CourseStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CourseStatusFLabel" style="width:100px;">Course Status:</div>
            <div id="CourseStatusFField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="CSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
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
        $(function ()
        {
            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

            $("#byTitle").bind('click', function ()
            {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#CourseTitleContainer").show();
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
