<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ViewActionStatistics.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ViewActionStatistics" %>
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
                <li id="byTargetClose">Filter by Target Close Date</li>
                <li id="byProblemStatus">Filter by Problem Status</li>
                <li id="byProblemRCause">Filter by Root Cause</li>
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

    <div id="TargetDateContainer" class="filter">
        <div id="TargetDateLabel" class="filterlabel">Target Close Date:</div>
        <div id="TargetDateField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
        </div>

        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
               
        <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />
    </div>

    <div id="PartyTypeContainer" class="filter">
        <div id="PartyTypeLabel" class="filterlabel">Affected Party Type:</div>
        <div id="PartyTypeField" class="filterfield">
            <asp:DropDownList ID="PRTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRTYPCBox_SelectedIndexChanged">
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
    $(function () {
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

        $("#byTargetClose").bind('click', function () {
            hideAll();

            $("#TargetDateContainer").show();
        });

        $("#byProblemRCause").bind('click', function () {
            hideAll();

            $("#RootCauseContainer").show();
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
    
