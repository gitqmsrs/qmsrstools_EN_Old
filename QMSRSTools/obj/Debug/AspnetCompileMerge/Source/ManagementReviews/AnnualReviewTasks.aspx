<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="AnnualReviewTasks.aspx.cs" Inherits="QMSRSTools.ManagementReviews.AnnualReviewTasks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" alt="" />
       
        <div class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="YearLabel"  style="width:100px;">Select Year</div>
            <div id="YearField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="YRCBox" AutoPostBack="true" runat="server" Width="150px" CssClass="combobox" OnSelectedIndexChanged="YRCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>
   </div>
     
   <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />

    <div style="float:left; width:100%; height:500px; margin-top:15px;">         
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="500">
            <param name="movie" value="http://www.qmsrs.com/qmsrstools/http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-bars.swf" />
            <param name="bgcolor" value="#ffffff" />
            <param name="quality" value="high" />
            <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
            <embed type="application/x-shockwave-flash" src="http://www.qmsrs.com/qmsrstools/http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-bars.swf" width="900"
            height="500" name="flashchart" bgcolor="#ffffff" quality="high" flashvars='xml_file=<%=Session["Guid"] %>' />
        </object>
    </div>
     <script type="text/javascript" language="javascript">
         $(function () {
             $("#refresh").bind('click', function () {
                 $("#<%=alias.ClientID%>").trigger('click');
           });
       });
    </script>
</asp:Content>
