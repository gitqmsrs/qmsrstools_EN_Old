<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="HeldCourses.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.HeldCourses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div class="toolbox">
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>

        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            
            <ul class="contextmenu">
                <li id="byYear">Filter by Year</li>
            </ul>
        </div>
   </div>

   <div id="YearContainer" class="filter">
        <div id="YearLabel" class="filterlabel">Select Year</div>
        <div id="YearField" class="filterfield">
            <asp:DropDownList ID="YRCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="YRCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
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
           $("#deletefilter").bind('click', function () {
               hideAll();
               $("#<%=alias.ClientID%>").trigger('click');
           });

           $("#byYear").bind('click', function () {
               hideAll();
               $("#YearContainer").show();
           });
       });

       function hideAll() {
           $(".filter").each(function () {
               $(this).css('display', 'none');
           });

           reset();
       }

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
