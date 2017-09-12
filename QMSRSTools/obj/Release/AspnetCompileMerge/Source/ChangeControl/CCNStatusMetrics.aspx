<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CCNStatusMetrics.aspx.cs" Inherits="QMSRSTools.ChangeControl.CCNStatusMetrics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox">
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt="" />
       
        <div class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="MonthLabel"  style="width:100px;">Select Month</div>
            <div id="MonthField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="MNTHCBox" AutoPostBack="true" runat="server" Width="150px" CssClass="combobox" OnSelectedIndexChanged="MNTHCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>
    </div>
    
    <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />

    <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500px" width="100%">
        <param name="movie" value="../../Reports/Flash/fcp-bars.swf"/>
        <param name="bgcolor" value="#ffffff"/>
        <param name="quality" value="high"/>
        <param name="flashvars" value='xml_file=<%=Session["Guid"] %>'/>
        <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500" name="flashchart" quality="high" src="../../Reports/Flash/fcp-bars.swf" type="application/x-shockwave-flash" width="900"></embed>
        <param name="wmode" value="opaque" /></object>
     </div>

    <script type="text/javascript" language="javascript">
        $(function ()
        {
            $("#deletefilter").bind('click', function ()
            {
                $("#<%=alias.ClientID%>").trigger('click');
            });
        });
    </script>
</asp:Content>
