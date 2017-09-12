<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="RAGAnalysisAudits.aspx.cs" Inherits="QMSRSTools.AuditManagement.RAGAnalysisAudits" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox">
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byAuditors">Filter by Auditors</li>
                <li id="byUnit">Filter by Organization unit</li>  
                <li id="byAUDTTYP">Filter by Audit Type</li>
                <li id="byAUDTSTS">Filter by Audit Status</li>  
            </ul>
        </div>
    </div>
    
    <div id="AuditorContainer" class="filter">
        <div id="AuditorLabel" class="filterlabel">Auditors:</div>
        <div id="AuditorField" class="filterfield">
            <asp:DropDownList ID="AUDTRCBox" runat="server" Width="140px" CssClass="comboboxfilter" AutoPostBack="true" OnSelectedIndexChanged="AUDTRCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="UnitContainer" class="filter">
        <div id="UnitLabel" class="filterlabel">Org. Unit:</div>
        <div id="UnitField" class="filterfield">
            <asp:DropDownList ID="UNTCBox" runat="server" Width="140px" CssClass="comboboxfilter" AutoPostBack="true" OnSelectedIndexChanged="UNTCBox_SelectedIndexChanged" >
            </asp:DropDownList>
        </div> 
    </div>

    <div id="AuditTypeContainer" class="filter">
        <div id="AuditTypeFilterLabel" class="filterlabel">Audit Type:</div>
        <div id="AuditTypeFilterField" class="filterfield">
            <asp:DropDownList ID="AUDTTYPCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="AUDTTYPCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        
    </div>

    <div id="AuditStatusContainer" class="filter">
        <div id="AuditStatusFilterLabel" class="filterlabel">Audit Status:</div>
        <div id="AuditStatusFilterField" class="filterfield">
            <asp:DropDownList ID="AUDTSTSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="AUDTSTSCBox_SelectedIndexChanged">
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
        <script type="text/javascript" language="javascript">
            $(function () {
                $("#deletefilter").bind('click', function () {
                    hideAll();

                });

                $("#byAuditors").bind('click', function () {
                    hideAll();

                    $("#AuditorContainer").show();
                });


                $("#byUnit").bind('click', function () {
                    hideAll();

                    $("#UnitContainer").show();

                });

                $("#byAUDTTYP").bind('click', function () {
                    hideAll();

                    $("#AuditTypeContainer").show();

                });

                $("#byAUDTSTS").bind('click', function () {
                    hideAll();

                    $("#AuditStatusContainer").show();

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
