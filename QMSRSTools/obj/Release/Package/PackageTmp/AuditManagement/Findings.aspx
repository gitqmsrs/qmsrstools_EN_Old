<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="Findings.aspx.cs" Inherits="QMSRSTools.AuditManagement.Findings" %>
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
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="byFNDRTCAUS">Filter by Root Cause</li>
            </ul>
        </div>
    </div>
        
    <div id="YearContainer" class="filter">
        <div id="YearLabel" class="filterlabel">Year:</div>
        <div id="YearField" class="filterfield">
            <asp:DropDownList ID="YRCBox" runat="server" Width="140px" AutoPostBack="true" CssClass="comboboxfilter" OnSelectedIndexChanged="YRCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>          
    </div>

    <div id="RootCauseContainer"class="filter">
        <div id="RootCauseLabel" class="filterlabel">Root Cause:</div>
        <div id="RootCauseField" class="filterfield">
            <asp:DropDownList ID="RTCUSCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter"  OnSelectedIndexChanged="RTCUSCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>    
    </div>

     <div id="RecordModeContainer" class="filter">
            <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
            <div id="RecordModeField" class="filterfield">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="RECMODCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>

    
     <asp:Button ID="Alias" runat="server" style="display:none;" OnClick="Alias_Click"  />
        
        <div style="float:left; width:100%; height:500px; margin-top:15px;">
            <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="500">
                <param name="movie" value="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-bars.swf" />
                <param name="bgcolor" value="#ffffff" />
                <param name="quality" value="high" />
                <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
                <embed type="application/x-shockwave-flash" src="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-bars.swf" width="900"
                height="500" name="flashchart" bgcolor="#ffffff" quality="high" flashvars='xml_file=<%=Session["Guid"] %>' />
            </object>
       </div>
</div>

<script type="text/javascript" language="javascript">
           $(function () {
               $("#byYear").bind('click', function ()
               {
                   hideAll();
                   $("#YearContainer").show();
               });

               $("#byFNDRTCAUS").bind('click', function () {
                   hideAll();
                   $("#RootCauseContainer").show();
               });

               $("#byRECMOD").bind('click', function () {
                   hideAll();
                   $("#RecordModeContainer").show();
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