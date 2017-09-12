﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ISOClauses.aspx.cs" Inherits="QMSRSTools.AuditManagement.ISOClauses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox" style="margin-top:0;">
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="../../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byYear">Filter by Year</li>
            </ul>
        </div>
        <div id="YearContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="YearLabel" style="width:100px;">Year:</div>
            <div id="YearField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="YRCBox" runat="server" Width="150px" AutoPostBack="true" CssClass="combobox" OnSelectedIndexChanged="YRCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div> 
        </div>
    </div>
    
    <asp:Button ID="Alias" runat="server" style="display:none;" OnClick="Alias_Click"  />
        
    <div style="float:left; width:100%; height:500px; margin-top:15px;">         
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="500">
            <param name="movie" value="../../Reports/Flash/fcp-bars.swf" />
            <param name="bgcolor" value="#ffffff" />
            <param name="quality" value="high" />
            <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
            <embed type="application/x-shockwave-flash" src="../../Reports/Flash/fcp-bars.swf" width="900"
            height="500" name="flashchart" bgcolor="#ffffff" quality="high" flashvars='xml_file=<%=Session["Guid"] %>' />
        </object>
    </div>
    <script type="text/javascript" language="javascript">
        $(function () {
            $("#byYear").bind('click', function () {
                hideAll();
                $("#YearContainer").show();
            });


            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Alias.ClientID%>").trigger('click');
               });
        });

        function hideAll() {
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
        }
    </script>

</asp:Content>
 