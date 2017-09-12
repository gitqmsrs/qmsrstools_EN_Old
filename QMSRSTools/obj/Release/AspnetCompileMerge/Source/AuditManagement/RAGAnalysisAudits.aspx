<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="RAGAnalysisAudits.aspx.cs" Inherits="QMSRSTools.AuditManagement.RAGAnalysisAudits" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox" style="margin-top:0;">
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="../../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byAuditors">Filter by Auditors</li>
                <li id="byUnit">Filter by Organization unit</li>    
            </ul>
        </div>
        <div id="AuditorContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AuditorLabel" style="width:100px;">Auditors:</div>
            <div id="AuditorField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="AUDTRCBox" runat="server" Width="150px" CssClass="combobox" AutoPostBack="true" OnSelectedIndexChanged="AUDTRCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div> 
        </div>
            
        <div id="UnitContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="UnitLabel" style="width:100px;">Org. Unit:</div>
            <div id="UnitField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="UNTCBox" runat="server" Width="150px" CssClass="combobox" AutoPostBack="true" OnSelectedIndexChanged="UNTCBox_SelectedIndexChanged" >
                </asp:DropDownList>
            </div> 
        </div>
        
        <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; display:none;" OnClick="Search_Click"  />
    </div>
    <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500" width="100%">
            <param name="movie" value="../../Reports/Flash/fcp-pie-chart.swf" />
            <param name="bgcolor" value="#ffffff" />
            <param name="quality" value="high" />
            <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
            <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500"
            name="flashchart" quality="high" src="../../Reports/Flash/fcp-pie-chart.swf" type="application/x-shockwave-flash"
            width="900"></embed>
         </object>
    </div>
        <script type="text/javascript" language="javascript">
            $(function () {
                $("#deletefilter").bind('click', function () {
                    hideAll();
                    $("#<%=Search.ClientID%>").trigger('click');

            });

            $("#byAuditors").bind('click', function () {
                hideAll();

                $("#AuditorContainer").show();
            });


            $("#byUnit").bind('click', function () {
                hideAll();

                $("#UnitContainer").show();

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

            $(".filter").each(function () {
                $(this).css('display', 'none');
            });

            reset();
        }
    </script>

</asp:Content>
