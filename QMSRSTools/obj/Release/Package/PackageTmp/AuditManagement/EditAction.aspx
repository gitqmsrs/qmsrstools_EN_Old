<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="EditAction.aspx.cs" Inherits="QMSRSTools.AuditManagement.EditAction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="AUDTACT_Header" class="moduleheader">Manage Audit Actions</div>

    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byAUDTTYP">Filter by Audit Type</li>
                <li id="byAUDTSTS">Filter by Audit Status</li>
                <li id="byFNDTYP">Filter by Finding Type</li>
                <li id="byAUDTDT">Filter by Planned Audit Date</li>
                <li id="byAUDTRTCAUS">Filter by Root Cause</li>
            </ul>

        </div>
    </div>

    <div id="AuditYearContainer" class="menutoolfield" style="display:block;">
        <div id="AuditYearLabel" class="filterlabel">Audit Year:</div>
        <div id="AuditYearField" class="filterfield">
            <asp:DropDownList ID="AUDTYRCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>

        <div id="ADTYRF_LD" class="control-loader"></div>

        <span id="REFAUDTYR" class="refreshcontrol" runat="server" style="margin-left:10px" title="Reload Audit Year List"></span>

    </div>

    <div id="PlannedDateContainer" class="filter">
        <div id="StartDateLabel" class="filterlabel">Planned Audit Date:</div>
        <div id="StartDateField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>
    
    <div id="AuditTypeContainer" class="filter">
        <div id="AuditTypeFLabel" class="filterlabel">Audit Type:</div>
        <div id="AudittypeFField" class="filterfield">
            <asp:DropDownList ID="AUDTTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ADTFTYP_LD" class="control-loader"></div>
    </div>

    <div id="AuditStatusContainer" class="filter">
        <div id="AuditStatusFLabel" class="filterlabel">Audit Status:</div>
        <div id="AuditStatusFField" class="filterfield">
            <asp:DropDownList ID="AUDTSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ADTFSTS_LD" class="control-loader"></div>
    </div>

    <div id="FindingTypeContainer" class="filter">
        <div id="FindingTypeFLabel" class="filterlabel">Finding Type:</div>
        <div id="FindingTypeFField" class="filterfield">
            <asp:DropDownList ID="FNDTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="FNDTYPF_LD" class="control-loader"></div>
    </div>

    <div id="RootCauseFContainer"class="filter">
        <div id="RootCauseFLabel" class="filterlabel">Root Cause:</div>
        <div id="RootCauseFField" class="filterfield">
            <asp:DropDownList ID="RTCAUSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RTCAUSF_LD" class="control-loader"></div>
    </div>

    <div id="RAGTooltip" class="tooltip" style="margin-top:20px; background-color:transparent;"> 
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="RED" src="http://www.qmsrs.com/qmsrstools/Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: Action has passed its target close date.</p>
        </div>
        
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="GREEN" src="http://www.qmsrs.com/qmsrstools/Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: Action is on schedule.</p>
        </div>
        
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="AMBER" src="http://www.qmsrs.com/qmsrstools/Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: Action will be overdue soon.</p>
        </div>
    </div>
    	
    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="ACTwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="ActionHeader" class="modalHeader">Action Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="validation_dialog_edit">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Edit" />
        </div>

        <div id="ActionTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
    
        <input id="ACTID" type="hidden" value="" />    
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActionTypeLabel" class="requiredlabel">Action Type:</div>
            <div id="ActionTypeField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="ACTTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            
            <div id="ACTTYP_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="ACTTYPTTxtVal" runat="server" Display="None" ErrorMessage="Select action type" ControlToValidate="ACTTYPCBox" ValidationGroup="Edit">
            </asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="ACTTYPVal" runat="server" ControlToValidate="ACTTYPCBox"
            Display="None" ErrorMessage="Select action type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Edit"></asp:CompareValidator>
        </div>   
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActioneeLabel" class="requiredlabel">Actionee:</div>
            <div id="ActioneeField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="ACTEETxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>
            <span id="ACTEESelect" class="searchactive" style="margin-left:10px" runat="server"></span>
        
            <asp:RequiredFieldValidator ID="ACTEEVal" runat="server" Display="None" ControlToValidate="ACTEETxt" ErrorMessage="Select the name of the actionee" ValidationGroup="Edit"></asp:RequiredFieldValidator>     
        </div>    

        <div id="SelectActionee" class="selectbox" style="top:140px;">
            <div id="closeActionee" class="selectboxclose"></div>
            
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNT_LD" class="control-loader"></div> 
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="EMPNameLabel" class="labeldiv" style="width:100px;">Employee Name:</div>
                <div id="EMPNameField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="EMPCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="EMP_LD" class="control-loader"></div> 
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActionDetailsLabel" class="labeldiv">Details:</div>
            <div id="ActionDetailsField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="ACTDTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="ACTDTLVal" runat="server" ValidationGroup="Edit"  Display="None"
            ControlToValidate = "ACTDTLTxt" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:125px;">
            <div id="TRGTDateLabel" class="requiredlabel">Target Close Date:</div>
            <div id="TRGTDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="TRGTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="TRGTDTVal" runat="server" Display="None" ControlToValidate="TRGTDTTxt" ErrorMessage="Enter the Target Date of the Action" ValidationGroup="Edit"></asp:RequiredFieldValidator>   
        
            <asp:RegularExpressionValidator ID="TRGTDTTxtFVal" runat="server" ControlToValidate="TRGTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Edit"></asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="TRGTDTF2Val" runat="server" ValidationGroup="Edit" Display="None"
            ControlToValidate = "TRGTDTTxt" ErrorMessage = "Target close date should be greater than or equals the planned date of the audit"
            ClientValidationFunction="comparePlannedAuditDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="TRGTDTF3Val" runat="server" ValidationGroup="Edit" 
            ControlToValidate = "TRGTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DelayedDateLabel" class="labeldiv">Delayed Date:</div>
            <div id="DelatedDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="DLYDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
  
            <asp:RegularExpressionValidator ID="DLYDTTxtFVal" runat="server" ControlToValidate="DLYDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Edit"></asp:RegularExpressionValidator>  
  
            <asp:CompareValidator ID="DLYDTTxtF2Val" runat="server" ControlToCompare="TRGTDTTxt"  ValidationGroup="Edit"
            ControlToValidate="DLYDTTxt" ErrorMessage="Delayed date should be greater than target close date"
            Operator="GreaterThan" Type="Date"
            Display="None"></asp:CompareValidator>   
            
            <asp:CustomValidator id="DLYDTTxtF3Val" runat="server" ValidationGroup="Edit" 
            ControlToValidate = "DLYDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>  
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CompletedDateLabel" class="labeldiv">Completion Date:</div>
            <div id="CompletedDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CMPLTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>

            <asp:RegularExpressionValidator ID="CMPLTDTTxtFval" runat="server" ControlToValidate="CMPLTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" CssClass="validator" ValidationGroup="Edit"></asp:RegularExpressionValidator>  
             
            <asp:CustomValidator id="CMPLTDTF2Val" runat="server" ValidationGroup="Edit" 
            ControlToValidate = "CMPLTDTTxt" Display="None" ErrorMessage = "Complete date shouldn't be in future"
            ClientValidationFunction="comparePast">
            </asp:CustomValidator>

            <asp:CustomValidator id="CMPLTDTF3Val" runat="server" ValidationGroup="Edit" 
            ControlToValidate = "CMPLTDTTxt" Display="None" ErrorMessage = "Complete date should be greater than or equals the planned date of the audit"
            ClientValidationFunction="comparePlannedAuditDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="CMPLTDTF4Val" runat="server" ValidationGroup="Edit" 
            ControlToValidate = "CMPLTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator> 
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="FollowCommentLabel" class="labeldiv">Follow Up Comments:</div>
            <div id="FollowCommentField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="FLLCOMTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
        
            <asp:CustomValidator id="FLLCOMFVal" runat="server" ValidationGroup="Edit" 
            ControlToValidate = "FLLCOMTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
    
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <div id="ActionScrollbar" class="gridscroll">
        <asp:GridView id="gvActions" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
        <Columns>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="AuditType" HeaderText="Audit Type" />
            <asp:BoundField DataField="PlannedAuditDate" HeaderText="Planned Audit Date" />
            <asp:BoundField DataField="Finding" HeaderText="Related Finding" />
            <asp:BoundField DataField="ActionType" HeaderText="Action Type" />
            <asp:BoundField DataField="TargetClosingDate" HeaderText="Target Close Date" />
            <asp:BoundField DataField="DelayedDate" HeaderText="Delayed To Date" />
            <asp:BoundField DataField="CompletedDate" HeaderText="Completed Date" />
            <asp:BoundField DataField="Actionee" HeaderText="Actionee" />
            <asp:BoundField DataField="AuditStatus" HeaderText="Audit Status" />
            <asp:BoundField DataField="ActionStatus" HeaderText="Action Status" />
        </Columns>
        </asp:GridView>
    </div>

    <input id="auditdate" type="hidden" />
    <input id="audityear" type="hidden" value="" /> 
    <input id="filtermode" type="hidden" value="" /> 
</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);

        $("#<%=REFAUDTYR.ClientID%>").bind('click', function ()
        {
            loadComboboxAjax('enumAuditYears', "#<%=AUDTYRCBox.ClientID%>", "#ADTYRF_LD");
        });

        $("#byAUDTTYP").bind('click', function ()
        {
            hideAll();
            /*load audit type*/
            loadComboboxAjax('loadAuditType', '#<%=AUDTTYPFCBox.ClientID%>', "#ADTFTYP_LD");

            $("#AuditTypeContainer").show();

            /*set filter mode to audit type*/
            $("#filtermode").val('AuditType');
        });

        $("#byAUDTSTS").bind('click', function ()
        {
            hideAll();
            /*load audit status*/
            loadComboboxAjax('loadAuditStatus', '#<%=AUDTSTSFCBox.ClientID%>', "#ADTFSTS_LD");

            $("#AuditStatusContainer").show();

            /*set filter mode to audit status*/
            $("#filtermode").val('AuditStatus');
        });

        $("#byFNDTYP").bind('click', function ()
        {
            hideAll();

            /*load finding type*/
            loadFindingType("#FNDTYPF_LD", "#<%=FNDTYPFCBox.ClientID%>");

            $("#FindingTypeContainer").show();

            /*set filter mode to finding type*/
            $("#filtermode").val('FindingType');
        });

        $("#byAUDTRTCAUS").bind('click', function () {
            hideAll();

            loadRootCauses("#RTCAUSF_LD", "#<%=RTCAUSFCBox.ClientID%>");

            $("#RootCauseFContainer").show();

            /*set filter mode to root cause*/
            $("#filtermode").val('RootCause');
        });

        $("#byAUDTDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#PlannedDateContainer").show();
        });

        /*filter by audit type*/
        $("#<%=AUDTTYPFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterByAuditType($(this).val(), $("#audityear").val(), empty);
            }
        });

        /*filter by audit status*/
        $("#<%=AUDTSTSFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterByAuditStatus($(this).val(), $("#audityear").val(), empty);
            }
        });

        /*filter by finding type*/
        $("#<%=FNDTYPFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterByFindingType($(this).val(), $("#audityear").val(), empty);
            }
        });

        /*filter by root cause*/
        $("#<%=RTCAUSFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var vals = $(this).val().split(" ");

                filterByRootCause(vals[1], $("#audityear").val(), empty);
            }
        });

        $("#refresh").bind('click', function ()
        {
            hideAll();

            /*reload audit years*/
            $("#<%=REFAUDTYR.ClientID%>").trigger('click');

            filterActionsByYear(empty, new Date().getFullYear());

            /*set filter mode to none*/
            $("#filtermode").val('None');

            /* set the year of the audit to current as a default*/
            $("#audityear").val(new Date().getFullYear());

        });

        $("#<%=AUDTYRCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {
                switch ($("#filtermode").val())
                {
                    case "None":
                        filterActionsByYear(empty, $(this).val());
                        break;
                    case "AuditType":
                        filterByAuditType($("#<%=AUDTTYPFCBox.ClientID%>").val(), $(this).val(), empty);
                        break;
                    case "AuditStatus":
                        filterByAuditStatus($("#<%=AUDTSTSFCBox.ClientID%>").val(), $(this).val(), empty);
                        break;
                    case "FindingType":
                        filterByFindingType($("#<%=FNDTYPFCBox.ClientID%>").val(), $(this).val(), empty);
                        break;
                    case "RootCause":
                        var vals = $("#<%=RTCAUSFCBox.ClientID%>").val().split(" ");
                        filterByRootCause(vals[1], $(this).val(), empty);
                        break;
                }

                /* set the year of the audit*/
                $("#audityear").val($(this).val());

            }
        });

        $("#refresh").trigger('click');


        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#cancel").trigger('click');
            }
        });

        $("#<%=ACTEESelect.ClientID%>").bind('click', function ()
        {
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
            $("#<%=EMPCBox.ClientID%>").empty();

            $("#SelectActionee").show();
        });

        $("#closeActionee").bind('click', function ()
        {
            $("#SelectActionee").hide('800');
        });

        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterAuditByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);

        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterAuditByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });


        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            loadcontrols.push("#<%=EMPCBox.ClientID%>");
            loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, $("#EMP_LD"));
        });

        $("#<%=EMPCBox.ClientID%>").change(function () {

            $("#<%=ACTEETxt.ClientID%>").val($(this).val());
            $("#SelectActionee").hide('800');
        });

        $("#<%=TRGTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
            }
        });

        $("#<%=DLYDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
            }
        });

        $("#<%=CMPLTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
            }
        });

        $("#save").bind('click', function () {

            var isPageValid = Page_ClientValidate("Edit");
            if (isPageValid)
            {
                if (!$("#validation_dialog_edit").is(":hidden")) {
                    $("#validation_dialog_edit").hide();
                }
                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);


                        var TRGTDTParts = getDatePart($("#<%=TRGTDTTxt.ClientID%>").val());
                        var DLYDTParts = getDatePart($("#<%=DLYDTTxt.ClientID%>").val());
                        var COMPLTDTParts = getDatePart($("#<%=CMPLTDTTxt.ClientID%>").val());

                        var action =
                        {
                            ActionID: $("#ACTID").val(),
                            ActionType: $("#<%=ACTTYPCBox.ClientID%>").find('option:selected').text(),
                            Details: $("#<%=ACTDTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTDTLTxt.ClientID%>").val()),
                            Actionee: $("#<%=ACTEETxt.ClientID%>").val(),
                            FollowUpComments: $("#<%=FLLCOMTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=FLLCOMTxt.ClientID%>").val()),
                            TargetClosingDate: new Date(TRGTDTParts[2], (TRGTDTParts[1] - 1), TRGTDTParts[0]),
                            DelayedDate: $("#<%=DLYDTTxt.ClientID%>").val() == '' ? null : new Date(DLYDTParts[2], (DLYDTParts[1] - 1), DLYDTParts[0]),
                            CompleteDate: $("#<%=CMPLTDTTxt.ClientID%>").val() == '' ? null : new Date(COMPLTDTParts[2], (COMPLTDTParts[1] - 1), COMPLTDTParts[0])
                        }
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(action) + "\'}",
                            url: getServiceURL().concat('updateAuditAction'),
                            success: function (data)
                            {
                                $("#SaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    showSuccessNotification(data.d);

                                    $("#cancel").trigger('click');
                                    $("#refresh").trigger('click');
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#SaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                });
                            }
                        });
                    });
                }
            }
            else
            {
                $("#validation_dialog_edit").stop(true).hide().fadeIn(500, function ()
                {
                    
                });
            }
        });

        /* show RAG tooltip */
        if ($("#RAGTooltip").is(":hidden")) {
            $("#RAGTooltip").slideDown(800, 'easeOutBounce');
        }
    });

    function loadRootCauses(loader, control)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRootCauses"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Causes', 'name', $(control));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });

    }

    function comparePlannedAuditDate(sender, args)
    {
        var targetdatepart = getDatePart(args.Value);
        var planneddatepart = getDatePart(new Date($("#auditdate").val()).format('dd/MM/yyyy'));


        var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
        var planneddate = new Date(planneddatepart[2], (planneddatepart[1] - 1), planneddatepart[0]);

        if (targetdate < planneddate) {
            args.IsValid = false;
        }
        else {
            args.IsValid = true;
        }

        return args.IsValid;
    }

    function loadFindingType(loader, control) {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadFindingType"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {

                        var xml = $.parseXML(data.d);

                        loadComboboxXML(xml, 'ActionFindingType', 'TypeName', control);
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByRootCause(cause, year, empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            var vals = $(this).val().split(" ");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'causeID':'" + cause + "','year':'" + year + "'}",
                url: getServiceURL().concat('filterByAuditByFindingRootCause'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function () {
                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of all actions filtered by their finding root cause and registered in year " + year);

                            if (data) {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterAuditByDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {

            var dateparam =
            {
                StartDate: startdate,
                EndDate: enddate
            }

            $("#ACTwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('filterAuditsByDate'),
                    success: function (data) {
                        $("#ACTwait").fadeOut(500, function ()
                        {
                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(".modulewrapper").css("cursor", "default");

                                $(this).find('p').text("List of actions where the planned audit date range between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));

                                if (data) {
                                    loadActionGridView(data.d, empty);
                                }
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#ACTwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByAuditStatus(status, year, empty)
    {
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'status':'" + status + "','year':'" + year + "'}",
                url: getServiceURL().concat('filterByAuditStatus'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of all actions filtered by audit status and registered in year " + year);

                            if (data)
                            {
                                loadActionGridView(data.d, empty);
                            }
                        });
                       
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByFindingType(type, year, empty)
    {
        $("#ACTwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'type':'" + type + "','year':'" + year + "'}",
                url: getServiceURL().concat('filterByAuditByFindingType'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function () {
                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of all actions filtered by finding and registered in year " + year);

                            if (data)
                            {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }
    function filterByAuditType(type, year, empty)
    {
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'type':'" + type + "','year':'" + year + "'}",
                url: getServiceURL().concat('filterByAuditType'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function () {
                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                        {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of all actions filtered by audit type and registered in year " + year);

                            if (data)
                            {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterActionsByYear(empty,year)
    {
        $("#ACTwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'year':'" + year + "'}",
                url: getServiceURL().concat('getAuditsByYear'),
                success: function (data)
                {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                        {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of all actions registered in year " + year);

                            if (data) {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }



    function loadActionGridView(data, empty)
    {
        loadComboboxAjax('loadActionType', "#<%=ACTTYPCBox.ClientID%>");

        var xmlAudits = $.parseXML(data);

        var row = empty;

        $("#<%=gvActions.ClientID%> tr").not($("#<%=gvActions.ClientID%> tr:first-child")).remove();

        $(xmlAudits).find('AuditRecord').each(function (i, audit)
        {
            var xmlFinding = $.parseXML($(this).attr('RelatedXmlFindings'));

            $(xmlFinding).find("AuditFinding").each(function (j, finding)
            {
                var xmlActions = $.parseXML($(this).attr('XMLAuditActions'));

                $(xmlActions).find("AuditActions").each(function (k, action)
                {
                    /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                    var date = new Date();

                    $("td", row).eq(0).html("<img id='icon_" + k + "' src='http://www.qmsrs.com/qmsrstools/RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('ActionID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
                    $("td", row).eq(1).html("<img id='delete_" + k + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton'/>");
                    $("td", row).eq(2).html("<img id='edit_" + k + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");
                    $("td", row).eq(3).html($(audit).attr("AuditType"));
                    $("td", row).eq(4).html(new Date($(audit).attr("PlannedAuditDate")).format("dd/MM/yyyy"));
                    $("td", row).eq(5).html($(finding).attr("Finding"));
                    $("td", row).eq(6).html($(this).attr("ActionType"));
                    $("td", row).eq(7).html(new Date($(this).attr("TargetClosingDate")).format("dd/MM/yyyy"));
                    $("td", row).eq(8).html($(this).find("DelayedDate").text() == '' ? '' : new Date($(this).find("DelayedDate").text()).format("dd/MM/yyyy"));
                    $("td", row).eq(9).html($(this).find("CompleteDate").text() == '' ? '' : new Date($(this).find("CompleteDate").text()).format("dd/MM/yyyy"));
                    $("td", row).eq(10).html($(this).attr("Actionee"));
                    $("td", row).eq(11).html($(audit).attr("AuditStatusString"));
                    $("td", row).eq(12).html($(this).attr("IsClosed") == 'true' ? 'Closed' : 'Open');

                    $("#<%=gvActions.ClientID%>").append(row);

                    $(row).find('img').each(function ()
                    {
                        if ($(this).attr('id').search('edit') != -1)
                        {
                            $(this).bind('click', function ()
                            {
                                /*clear all fields*/
                                resetGroup('.modalPanel');

                                $("#ACTID").val($(action).attr("ActionID"));

                                /*bind the type of the action*/
                                bindAuditActionType($(action).attr("ActionType"));

                                /* temporarily store the planned date of the audit record for validation purposes*/
                                $("#auditdate").val($(audit).attr("PlannedAuditDate"));

                                $("#<%=ACTEETxt.ClientID%>").val($(action).attr("Actionee"));
                                $("#<%=TRGTDTTxt.ClientID%>").val(new Date($(action).attr("TargetClosingDate")).format("dd/MM/yyyy"));
                                $("#<%=DLYDTTxt.ClientID%>").val($(action).find("DelayedDate").text() == '' ? '' : new Date($(action).find("DelayedDate").text()).format("dd/MM/yyyy"));
                                $("#<%=CMPLTDTTxt.ClientID%>").val($(action).find("CompleteDate").text() == '' ? '' : new Date($(action).find("CompleteDate").text()).format("dd/MM/yyyy"));

                                /*bind the details of the finding*/
                                if ($(action).attr("Details") == '') {
                                    addWaterMarkText('Brief Description of the Action', '#<%=ACTDTLTxt.ClientID%>');
                                }
                                else {
                                    if ($("#<%=ACTDTLTxt.ClientID%>").hasClass("watermarktext")) {
                                        $("#<%=ACTDTLTxt.ClientID%>").val('').removeClass("watermarktext");
                                    }

                                    $("#<%=ACTDTLTxt.ClientID%>").html($(action).attr("Details")).text();
                                }

                                if ($(action).attr("FollowUpComments") == '') {
                                    addWaterMarkText('Follow up Comment in the Support of the Action', '#<%=FLLCOMTxt.ClientID%>');

                                }
                                else {
                                    if ($("#<%=FLLCOMTxt.ClientID%>").hasClass("watermarktext")) {
                                        $("#<%=FLLCOMTxt.ClientID%>").val('').removeClass("watermarktext");
                                    }
                                    $("#<%=FLLCOMTxt.ClientID%>").html($(action).attr("FollowUpComments")).text();
                                }

                               
                                if ($(audit).attr('AuditStatusString') == 'Completed' || $(audit).attr('AuditStatusString') == 'Cancelled') {
                                    $("#ActionTooltip").find('p').text("Changes cannot take place since the audit is " + $(audit).attr('AuditStatusString'));

                                    if ($("#ActionTooltip").is(":hidden")) {
                                        $("#ActionTooltip").slideDown(800, 'easeOutBounce');
                                    }

                                    /*disable all modal controls*/
                                    ActivateAll(false);
                                }
                                else if ($(action).attr("IsClosed") == 'true')
                                {
                                    $("#ActionTooltip").find('p').text("Cannot apply changes on the current action since it is closed");

                                    if ($("#ActionTooltip").is(":hidden")) {
                                        $("#ActionTooltip").slideDown(800, 'easeOutBounce');
                                    }

                                    /*disable all modal controls*/
                                    ActivateAll(false);
                                }
                                else
                                {
                                    $("#ActionTooltip").hide();

                                    /*enable all modal controls for editing*/
                                    ActivateAll(true);
                                }

                                $("#<%=alias.ClientID%>").trigger('click');
                            });
                        }
                        else if ($(this).attr('id').search('delete') != -1)
                        {
                            $(this).bind('click', function ()
                            {
                                removeAuditAction(parseInt($(action).attr('ActionID')), empty);
                            });
                        }
                    });

                    row = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);
                });
            });
        });
    }

    function bindAuditActionType(value)
    {
        $("#ACTTYP_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadAuditActionType"),
                success: function (data)
                {
                    $("#ACTTYP_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var xml = $.parseXML(data.d);

                        bindComboboxXML(xml, 'ActionFindingType', 'TypeName', value, '#<%=ACTTYPCBox.ClientID%>');
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ACTTYP_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function removeAuditAction(ID, empty) {
        var result = confirm("Are you sure you would like to remove the current action?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'actionID':'" + ID + "'}",
                url: getServiceURL().concat('removeAuditAction'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");
                    $("#refresh").trigger('click');
                },
                error: function (xhr, status, error)
                {
                    $(".modulewrapper").css("cursor", "default");
                    var r = jQuery.parseJSON(xhr.responseText);
                    showDialog('Error', r.Message);
                }
            });
        }
    }

    function ActivateAll(isactive) {
        if (isactive == false) {
            $(".modalPanel").children().each(function () {

                $(".textbox").each(function () {
                    $(this).removeClass("textbox");
                    $(this).addClass("readonlycontrolled");
                    $(this).attr('readonly', true);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', true);
                });

                $(".combobox").each(function () {
                    $(this).attr('disabled', true);
                });

                $(".textremaining").each(function () {
                    $(this).html('');
                });
            });

            $('#save').attr("disabled", true);
            $("#save").css({ opacity: 0.5 });

        }
        else {
            $(".modalPanel").children().each(function () {

                $(".readonlycontrolled").each(function () {
                    $(this).removeClass("readonlycontrolled");
                    $(this).addClass("textbox");
                    $(this).attr('readonly', false);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', false);
                });

                $(".combobox").each(function () {
                    $(this).attr('disabled', false);
                });
            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }

    function ActivateSave(isactive)
    {
        if (isactive == false) {
            $(".modalPanel").css("cursor", "wait");

            $('.button').attr("disabled", true);
            $('.button').css({ opacity: 0.5 });
        }
        else {
            $(".modalPanel").css("cursor", "default");

            $('.button').attr("disabled", false);
            $('.button').css({ opacity: 100 });
        }
    }

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
</script>
</asp:Content>
