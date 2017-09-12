<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CCNStatusBieChart.aspx.cs" Inherits="QMSRSTools.ChangeControl.CCNStatusBieChart" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
   <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" alt="" />
   </div>

   <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />

   <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500px" width="100%">
        <param name="movie" value="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-pie-chart.swf"/>
        <param name="bgcolor" value="#ffffff"/>
        <param name="quality" value="high"/>
        <param name="flashvars" value='xml_file=<%=Session["Guid"] %>'/>
        <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500" name="flashchart" quality="high" src="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-pie-chart.swf" type="application/x-shockwave-flash" width="900"></embed>
        <param name="wmode" value="opaque" />
        </object>
   </div>
</div>

<script type="text/javascript" language="javascript">
       $(function ()
       {
           $("#refresh").bind('click', function () {
               $("#<%=alias.ClientID%>").trigger('click');
           });
       });
</script>
</asp:Content>
