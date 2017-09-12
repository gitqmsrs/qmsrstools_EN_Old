<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ProblemsByRootCause.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ProblemsByRootCause" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
     <div class="toolbox">
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byProblemType">Filter by Problem Type</li>
                <li id="byProblemStatus">Filter by Problem Status</li>
                <li id="byPartyType">Filter by Affected Party Type</li>
                <li id="byRecordMode">Filter by Record Mode</li>
            </ul>
        </div>
    </div>

    <div id="ProblemTypeContainer" class="filter">
        <div id="ProblemTypeLabel" class="filterlabel">Problem Type:</div>
        <div id="ProblemTypeField" class="filterfield">
            <asp:DropDownList ID="PRMTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRMTYPCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="ProblemStatusContainer" class="filter">
        <div id="ProblemStatusLabel" class="filterlabel">Problem Status:</div>
        <div id="ProblemStatusField" class="filterfield">
            <asp:DropDownList ID="PRMSTSCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRMSTSCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div> 
    </div>  

    <div id="PartyTypeContainer" class="filter">
        <div id="PartyTypeLabel" class="filterlabel">Affected Party Type:</div>
        <div id="PartyTypeField" class="filterfield">
            <asp:DropDownList ID="PRTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRTYPCBox_SelectedIndexChanged">
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

    <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />
    

       
</div> 

<script type="text/javascript" language="javascript">
    $(function ()
    {
        $("#deletefilter").bind('click', function () {
            hideAll();

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#byProblemType").bind('click', function () {
            hideAll();
            $("#ProblemTypeContainer").show();
        });


        $("#byProblemStatus").bind('click', function () {
            hideAll();
            $("#ProblemStatusContainer").show();
        });
   
        $("#byPartyType").bind('click', function () {
            hideAll();

            $("#PartyTypeContainer").show();
        });

        $("#byRecordMode").bind('click', function () {
            hideAll();

            $("#RecordModeContainer").show();
        });

    });
    function reset() {
        $(".filtertext").each(function () {
            $(this).val('');
        });

        $(".comboboxfilter").each(function () {

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