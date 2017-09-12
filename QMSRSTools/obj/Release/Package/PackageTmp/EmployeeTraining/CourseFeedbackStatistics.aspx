<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="CourseFeedbackStatistics.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.CourseFeedbackStatistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper" class="modulewrapper">
    
    <div id="CourseNameContainer" class="filter" style="display:block;">
        <div id="CourseNameLabel" class="filterlabel">Course Number:</div>
        <div id="CourseNameField" class="filterfield">
            <asp:DropDownList ID="CRSNMCBox" AutoPostBack="true" runat="server" Width="300px" CssClass="comboboxfilter" OnSelectedIndexChanged="CRSNMCBox_SelectedIndexChanged">
            </asp:DropDownList>

        </div> 
    </div>
           
    <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500" width="100%">
            <param name="movie" value="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-pie-chart.swf" />
            <param name="bgcolor" value="#ffffff" />
            <param name="quality" value="high" />
            <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
            <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500"
            name="flashchart" quality="high" src="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-pie-chart.swf" type="application/x-shockwave-flash"
            width="900"></embed>
         </object>
    </div>
</div>
   
</asp:Content>
