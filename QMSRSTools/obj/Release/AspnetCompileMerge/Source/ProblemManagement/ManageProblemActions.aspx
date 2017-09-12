<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageProblemActions.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ManageProblemActions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper" class="modulewrapper">
    <div id="ProblemAction_Header" class="moduleheader">Manage Problem Actions</div>

<div class="toolbox">
    <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
    
    <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
    <div id="filter_div">
        <img id="filter" src="../Images/filter.png" alt=""/>
        <ul class="contextmenu">
            <li id="byACTTYP">Filter by Action Type</li>
            <li id="bySTDT">Filter by Start Date</li>
            <li id="byPRM">Filter by Problem Title</li>
            <li id="byPRMTYP">Filter by Problem Type</li>
        </ul>
    </div>

    <div id="ACTTYPContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ActionTypeFLabel" style="width:100px;">Action Type:</div>
        <div id="ActionTypeFField" style="width:170px; left:0; float:left;">
            <asp:DropDownList ID="ACTTYPFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ACTTYPF_LD" class="control-loader"></div>
    </div>

    <div id="StartdateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
        <div id="StartDateFLabel" style="width:120px;">Start Date:</div>
        <div id="StartDateFField" style="width:270px; left:0; float:left;">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>
    
    <div id="ProblemContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemNameLabel" style="width:100px;">Title:</div>
        <div id="ProblemNameField" style="width:150px; left:0; float:left;">
            <asp:TextBox ID="PRMNMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
        </div>
    </div>
    
    <div id="ProblemTypeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemTypeLabel" style="width:100px;">Problem Type:</div>
        <div id="ProblemtypeField" style="width:170px; left:0; float:left;">
            <asp:DropDownList ID="PRMTYPFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="PRMTYPF_LD" class="control-loader"></div>
    </div>

 </div>

<div id="RAGTooltip" class="tooltip" style="margin-top:20px; background-color:transparent;"> 
    <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
        <img id="RED" src="../Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: Problem action has passed target close date.</p>
    </div>
    <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
        <img id="GREEN" src="../Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: Problem action is on schedule.</p>
    </div>
    <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
        <img id="AMBER" src="../Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: Problem action will be overdue soon.</p>
    </div>
</div>	


<div id="ACTwait" class="loader">
    <div class="waittext">Retrieving Data, Please Wait...</div>
</div>

<div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
   <asp:GridView id="gvActions" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
    GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
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
            <asp:BoundField DataField="ACTTitle" HeaderText="Action Title" />
            <asp:BoundField DataField="PRMTitle" HeaderText="Related to Problem" />
            <asp:BoundField DataField="ACTType" HeaderText="Action Type" />
            <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
            <asp:BoundField DataField="PLNDEndDate" HeaderText="Planned Close Date" />
            <asp:BoundField DataField="ACTUCLSDate" HeaderText="Actual Close date" />
            <asp:BoundField DataField="Actionee" HeaderText="Actionee" />         
            <asp:BoundField DataField="Status" HeaderText="Status" />
        </Columns>
    </asp:GridView>
</div>

<asp:Button ID="alias" runat="server" style="display:none" />

<ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
</ajax:ModalPopupExtender>

<asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
<div id="header" class="modalHeader">Action Details<span id="close" class="modalclose" title="Close">X</span></div>
    
    <div id="ACTTooltip" class="tooltip">
        <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
        <p></p>
	</div>	
    
    <div id="SaveTooltip" class="tooltip">
        <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
        <p>Saving...</p>
	</div>

     
    <div id="validation_dialog_action" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Action" />
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="ActionTitleLabel" class="requiredlabel">Action Title:</div>
        <div id="ActionTitleField" class="fielddiv" style="width:300px;">
            <asp:TextBox ID="ACTNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
        </div>
        <div id="ACTTTLlimit" class="textremaining"></div>
      
        <asp:RequiredFieldValidator ID="ACTNMVal" runat="server" Display="None" ControlToValidate="ACTNMTxt" ErrorMessage="Enter the title of the action" ValidationGroup="Action"></asp:RequiredFieldValidator>

        <asp:CustomValidator id="ACTNMTxtFVal" runat="server" ValidationGroup="Action" 
        ControlToValidate = "ACTNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
        ClientValidationFunction="validateSpecialCharacters">
        </asp:CustomValidator> 
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="ActionDescriptionLabel" class="labeldiv">Description:</div>
        <div id="ActionDescriptionField" class="fielddiv" style="width:400px; height:133px;">
            <asp:TextBox ID="ACTDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="130px" TextMode="MultiLine"></asp:TextBox>
        </div>
        
        <asp:CustomValidator id="ACTDESCTxtVal" runat="server" ValidationGroup="Action"
        ControlToValidate = "ACTDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
        ClientValidationFunction="validateSpecialCharactersLongText">
        </asp:CustomValidator>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:135px;">
        <div id="ActionTypeLabel" class="requiredlabel">Action Type:</div>
        <div id="ActionTypeField" class="fielddiv" style="width:250px;">
            <asp:DropDownList ID="ACTTYPCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="ACTYP_LD" class="control-loader"></div>

        <asp:RequiredFieldValidator ID="ACTYPTxtVal" runat="server" Display="None" ControlToValidate="ACTTYPCBox" ErrorMessage="Select the type of the action" ValidationGroup="Action"></asp:RequiredFieldValidator>
       
        <asp:CompareValidator ID="ACTTYPVal" runat="server" ControlToValidate="ACTTYPCBox"
        Display="None" ErrorMessage="Select the type of the action" Operator="NotEqual" Style="position: static"
        ValueToCompare="0" ValidationGroup="Action"></asp:CompareValidator>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
        <div id="StartDateField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="STRTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
        </div>      
        <asp:RequiredFieldValidator ID="STRTDTTxtVal" runat="server" Display="None" ControlToValidate="STRTDTTxt" ErrorMessage="Enter the start date of the action"  ValidationGroup="Action"></asp:RequiredFieldValidator>  
        
        <asp:RegularExpressionValidator ID="STRTDTTxtFVal" runat="server" ControlToValidate="STRTDTTxt"
        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator>  

        <asp:CustomValidator id="STRTDTF2Val" runat="server" ValidationGroup="Action" 
        ControlToValidate = "STRTDTTxt" Display="None" ErrorMessage = "Start date should be greater than or equals the origination date of the problem"
        ClientValidationFunction="compareOriginationDate">
        </asp:CustomValidator>

        <asp:CustomValidator id="STRTDTF3Val" runat="server" ValidationGroup="Action" 
        ControlToValidate = "STRTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
        ClientValidationFunction="validateDate">
        </asp:CustomValidator>

    </div> 

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="EndDateLabel" class="requiredlabel">Planned Close Date:</div>
        <div id="EndDateField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="ENDDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
           
        </div>      
        <asp:RequiredFieldValidator ID="ENDDTTxtVal" runat="server" Display="None" ControlToValidate="ENDDTTxt" ErrorMessage="Enter the planned end date of the problem"  ValidationGroup="Action"></asp:RequiredFieldValidator>  
        
        <asp:CompareValidator ID="ENDDTVal" runat="server" ControlToCompare="STRTDTTxt"  ValidationGroup="Action"
        ControlToValidate="ENDDTTxt" ErrorMessage="Planned end date should be greater or equals start date"
        Operator="GreaterThanEqual" Type="Date"
        Display="None"></asp:CompareValidator> 
        
        <asp:RegularExpressionValidator ID="ENDDTFVal" runat="server" ControlToValidate="ENDDTTxt"
        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator> 
        
        <asp:CustomValidator id="ENDDTF2Val" runat="server" ValidationGroup="Action" 
        ControlToValidate = "ENDDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
        ClientValidationFunction="validateDate">
        </asp:CustomValidator> 
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="ActualCloseDateLabel" class="labeldiv">Actual Close Date:</div>
        <div id="ActualCloseDateField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="ACTCLSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy" ></asp:TextBox>
        </div>      

        <asp:CustomValidator id="ACTCLSDTFVal" runat="server" ValidationGroup="Action" 
        ControlToValidate = "ACTCLSDTTxt" Display="None" ErrorMessage = "Actual close date shouldn't be in future"
        ClientValidationFunction="comparePast">
        </asp:CustomValidator>

        <asp:CompareValidator ID="ACTCLSDTF2Val" runat="server" ControlToCompare="STRTDTTxt"  ValidationGroup="Action"
        ControlToValidate="ACTCLSDTTxt" ErrorMessage="Actual close date should be greater or equals start date"
        Operator="GreaterThanEqual" Type="Date"
        Display="None"></asp:CompareValidator> 

        <asp:RegularExpressionValidator ID="ACTCLSDTTxtFVal" runat="server" ControlToValidate="ACTCLSDTTxt"
        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator>  

        <asp:CustomValidator id="ACTCLSDTF3Val" runat="server" ValidationGroup="Action" 
        ControlToValidate = "ACTCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
        ClientValidationFunction="validateDate">
        </asp:CustomValidator> 
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;" class="field">
        <div id="ActioneeLabel" class="requiredlabel">Actionee:</div>
        <div id="ActioneeField" class="fielddiv" style="width:250px;">
            <asp:DropDownList ID="ACTEECBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="ACTEMP_LD" class="control-loader"></div>

        <span id="ACTEESelect" class="searchactive" style="margin-left:10px" runat="server"></span>
        
        <asp:RequiredFieldValidator ID="ACTEECBoxTxtVal" runat="server" Display="None" ControlToValidate="ACTEECBox" ErrorMessage="Select the actionee" ValidationGroup="Action"></asp:RequiredFieldValidator>
        
        <asp:CompareValidator ID="ACTEEBoxVal" runat="server" ControlToValidate="ACTEECBox"  ValidationGroup="Action"
        Display="None" ErrorMessage="Select the actionee" Operator="NotEqual" Style="position: static"
        ValueToCompare="0"></asp:CompareValidator>
    </div>

    <div id="SelectORG" class="selectbox">
        <div id="closeORG" class="selectboxclose"></div>
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
            <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                </asp:DropDownList> 
            </div>
            <div id="ORGUNT_LD" class="control-loader"></div> 
        </div>
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="ActioneeFeedbackLabel" class="labeldiv">Actionee Feedback:</div>
        <div id="ActioneeFeedbackField" class="fielddiv" style="width:400px; height:133px;">
            <asp:TextBox ID="ACTEEFEEDTxt" runat="server" CssClass="textbox" Width="390px" Height="130px" TextMode="MultiLine"></asp:TextBox>
        </div>

        <asp:CustomValidator id="ACTEEFEEDTxtFVal" runat="server" ValidationGroup="Action"
        ControlToValidate = "ACTEEFEEDTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
        ClientValidationFunction="validateSpecialCharactersLongText">
        </asp:CustomValidator>
      
    </div>
    
    <div class="buttondiv">
        <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
        <input id="cancel" type="button" class="button" value="Cancel" />
   </div>
</asp:Panel>

<input id="ActionID" type="hidden" value="" />
<input id="ORGDT" type="hidden" value="" />

</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);

        /* show module tooltip */

        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
            $(this).slideDown(800, 'easeOutBounce');
        });

        /*initial loading of the actions in the system*/
        loadActions(empty);

        $("#deletefilter").bind('click', function () {
            hideAll();
            loadActions(empty);
        });

        $("#refresh").bind('click', function ()
        {
            hideAll();
            loadActions(empty);
        });

        $("#byACTTYP").bind('click', function () {
            hideAll();
            loadComboboxAjax('loadProblemActionType', '#<%=ACTTYPFCBox.ClientID%>',"#ACTTYPF_LD");
            $("#ACTTYPContainer").show();

        });

        $("#bySTDT").bind('click', function () {
            hideAll();
            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#StartdateContainer").show();
        });

        $("#byPRM").bind('click', function () {
            hideAll();
            /*Clear filter text*/
            $("#<%=PRMNMTxt.ClientID%>").val('');
            $("#ProblemContainer").show();
        });

        $("#byPRMTYP").bind('click', function ()
        {
            hideAll();

            loadFilterProblemType();

            $("#ProblemTypeContainer").show();
        });

        /*filter by start date range*/
        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });


        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        /*filter by problem title*/
        $("#<%=PRMNMTxt.ClientID%>").keyup(function () {
            filterByProblemTitle($(this).val(), empty);
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        /*filter by problem type*/
        $("#<%=PRMTYPFCBox.ClientID%>").change(function () {

            if ($(this).val() != 0) {
                filterByProblemType($(this).val(), empty);
            }
        });

        /*filter by action type*/
        $("#<%=ACTTYPFCBox.ClientID%>").change(function () {

            if ($(this).val() != 0) {
                filterByActionType($(this).val(), empty);
            }
        });

        /*populate the employees in actionee cbox*/
        $("#<%=ORGUNTCBox.ClientID%>").change(function ()
        {
            var loadcontrols = new Array();
            loadcontrols.push("#<%=ACTEECBox.ClientID%>");
            loadParamComboboxAjax('getDepEmployees', loadcontrols, "'unit':'" + $(this).val() + "'", "#ACTEMP_LD");

            $("#SelectORG").hide('800');
        });

        $("#<%=ACTEESelect.ClientID%>").bind('click',function (e) {
            showORGDialog(e.pageX, e.pageY);
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        $("#<%=STRTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=ENDDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=ACTCLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#save").bind('click', function () {
            var isPageValid = Page_ClientValidate('Action');
            if (isPageValid)
            {
                if (!$("#validation_dialog_action").is(":hidden")) {
                    $("#validation_dialog_action").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);


                        var startdate = getDatePart($("#<%=STRTDTTxt.ClientID%>").val());
                        var enddate = getDatePart($("#<%=ENDDTTxt.ClientID%>").val());
                        var actual = getDatePart($("#<%=ACTCLSDTTxt.ClientID%>").val());

                        var action =
                        {
                            ActionID: $("#ActionID").val(),
                            name: $("#<%=ACTNMTxt.ClientID%>").val(),
                            Description: $("#<%=ACTDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTDESCTxt.ClientID%>").val()),
                            StartDate: new Date(startdate[2], (startdate[1] - 1), startdate[0]),
                            PlannedEndDate: new Date(enddate[2], (enddate[1] - 1), enddate[0]),
                            ActualCloseDate: actual == '' ? null : new Date(actual[2], (actual[1] - 1), actual[0]),
                            ActionType: $("#<%=ACTTYPCBox.ClientID%>").val(),
                            Actionee: $("#<%=ACTEECBox.ClientID%>").val(),
                            ActioneeFeedback: $("#<%=ACTEEFEEDTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTEEFEEDTxt.ClientID%>").val())
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'json':'" + JSON.stringify(action) + "'}",
                            url: getServiceURL().concat('updateProblemAction'),
                            success: function (data)
                            {
                                $("#SaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    alert(data.d);

                                    $("#cancel").trigger('click');
                                    $("#refresh").trigger('click');
                                });

                            },
                            error: function (xhr, status, error)
                            {
                                $("#SaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);
                                });
                            }
                        });
                    });
                }
            }
            else
            {
                $("#validation_dialog_action").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });
    });
    function compareOriginationDate(sender, args)
    {
        var targetdatepart = getDatePart(args.Value);
        var originationdatepart = getDatePart(new Date($("#ORGDT").val()).format('dd/MM/yyyy'));


        var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
        var originationdate = new Date(originationdatepart[2], (originationdatepart[1] - 1), originationdatepart[0]);

        if (targetdate < originationdate) {
            args.IsValid = false;
        }
        else {
            args.IsValid = true;
        }

        return args.IsValid;
    }

    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 300, top: y - 40 });

        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
        $("#SelectORG").show();
    }

    function filterByDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#ACTwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                var dateparam =
                {
                    StartDate: startdate,
                    EndDate: enddate
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('filterByStartDate'),
                    success: function (data) {
                        $("#ACTwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#ACTwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }

    function loadFilterProblemType() {
        $("#PRMTYPF_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemType"),
                success: function (data) {
                    $("#PRMTYPF_LD").fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $("#<%=PRMTYPFCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMTYPF_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterByProblemType(type, empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterActionsByProblemType'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterByProblemTitle(title, empty)
    {
        $("#ACTwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'name':'" + title + "'}",
                url: getServiceURL().concat('filterActionsByProblemName'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterByActionType(type, empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterByActionType'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ACTwait").fadeOut(500, function ()
                    {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadActions(empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadProblemActions'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadGridView(data, empty) {
        var xmlProblem = $.parseXML(data);

        var row = empty;

        $("#<%=gvActions.ClientID%> tr").not($("#<%=gvActions.ClientID%> tr:first-child")).remove();


        $(xmlProblem).find("Problem").each(function (i, problem) {
            var xmlActions = $.parseXML($(this).attr('Actions'));

            $(xmlActions).find('Action').each(function (j, action) {
                /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                var date = new Date();

                $("td", row).eq(0).html("<img id='icon_" + j + "' src='../RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('ActionID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
                $("td", row).eq(1).html("<img id='delete_" + j + "' src='../Images/deletenode.png' class='imgButton' />");
                $("td", row).eq(2).html("<img id='edit_" + j + "' src='../Images/edit.png' class='imgButton'/>");

                $("td", row).eq(3).html($(this).attr("name"));
                $("td", row).eq(4).html($(problem).attr("Title"));

                $("td", row).eq(5).html($(this).attr("ActionType"));
                $("td", row).eq(6).html(new Date($(this).attr("StartDate")).format("dd/MM/yyyy"));
                $("td", row).eq(7).html(new Date($(this).attr("PlannedEndDate")).format("dd/MM/yyyy"));
                $("td", row).eq(8).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
                $("td", row).eq(9).html($(this).attr("Actionee"));
                $("td", row).eq(10).html($(this).attr("IsClosed") == 'true' ? 'Closed' : 'Open');

                $("#<%=gvActions.ClientID%>").append(row);

                $(row).find('img').each(function () {
                    if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            $("#validation_dialog_action").hide();

                            /* temporarily store the origination date of the problem for validation purposes*/
                            $("#ORGDT").val($(action).attr('OriginationDate'));

                            /*clear all fields*/
                            reset();
                            /*bind action title*/
                            $("#<%=ACTNMTxt.ClientID%>").val($(action).attr("name"));

                            /*bind action type*/
                            bindComboboxAjax('loadProblemActionType', '#<%=ACTTYPCBox.ClientID%>', $(action).attr("ActionType"), "#ACTYP_LD");

                            /*bind action start date*/
                            $("#<%=STRTDTTxt.ClientID%>").val(new Date($(action).attr("StartDate")).format("dd/MM/yyyy"));

                            /*bind action target close date*/
                            $("#<%=ENDDTTxt.ClientID%>").val(new Date($(action).attr("PlannedEndDate")).format("dd/MM/yyyy"));

                            /*bind action actial close date*/
                            $("#<%=ACTCLSDTTxt.ClientID%>").val($(action).find("ActualCloseDate").text() == '' ? '' : new Date($(action).find("ActualCloseDate").text()).format("dd/MM/yyyy"));

                            /*bind action description*/
                            if ($(action).attr("Description") == '')
                            {
                                addWaterMarkText('Description of the action', '#<%=ACTDESCTxt.ClientID%>');
                            }
                            else
                            {
                                if ($("#<%=ACTDESCTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    $("#<%=ACTDESCTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=ACTDESCTxt.ClientID%>").html($(action).attr("Description")).text();

                            }

                            /*bind actionee*/
                            bindComboboxAjax('loadEmployees', '#<%=ACTEECBox.ClientID%>', $(action).attr("Actionee"), "#ACTEMP_LD");

                            /*bind actionee feedback*/
                            if ($(action).attr("ActioneeFeedback") == '')
                            {
                                addWaterMarkText('Provide feedback for the action', '#<%=ACTEEFEEDTxt.ClientID%>');
                            }
                            else
                            {
                                if ($("#<%=ACTEEFEEDTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    $("#<%=ACTEEFEEDTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=ACTEEFEEDTxt.ClientID%>").html($(action).attr("ActioneeFeedback")).text();

                            }

                            /*set the ID of the action for update reference*/
                            $("#ActionID").val($(action).attr('ActionID'));


                            $('#<%=ACTNMTxt.ClientID%>').limit({ id_result: 'ACTTTLlimit', alertClass: 'alertremaining', limit: 50 });    
                      
                            $('#<%=ACTNMTxt.ClientID%>').keyup();
                         
                            /*Check if the document is withdrawn or pending so that it may enable or disable changes*/
                            if ($(problem).attr('ProblemStatus') == 'Closed' || $(problem).attr('ProblemStatus') == 'Withdrawn') {
                                $("#ACTTooltip").find('p').text("Changes cannot take place on the action record since the problem is " + $(problem).attr('ProblemStatus'));

                                if ($("#ACTTooltip").is(":hidden")) {
                                    $("#ACTTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else if ($(action).attr("IsClosed") == 'true')
                            {
                                $("#ACTTooltip").find('p').text("Changes cannot take place on the action record since it is closed");

                                if ($("#ACTTooltip").is(":hidden")) {
                                    $("#ACTTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);

                            }
                            else
                            {
                                $("#ACTTooltip").hide();

                                /*enable all modal controls for editing*/
                                ActivateAll(true);
                            }

                            /*trigger modal popup extender*/
                            $("#<%=alias.ClientID%>").trigger('click');

                        });
                    }
                    else if ($(this).attr('id').search('delete') != -1) {
                        $(this).bind('click', function () {
                            removeAction($(action).attr('ActionID'), empty);
                        });
                    }
                });
                row = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);
            });
        });
    }

    function removeAction(actionID, empty)
    {
        var result = confirm("Are you sure you would like to remove the selected action?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'ID':'" + actionID + "'}",
                url: getServiceURL().concat('removeAction'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    $("#refresh").trigger('click');
                },
                error: function (xhr, status, error)
                {
                    $(".modulewrapper").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
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

                $(this).find('.imgButton').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.combobox').each(function () {
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

                $(this).find('.combobox').each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('.imgButton').each(function () {
                    $(this).attr('disabled', false);
                });
            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }


    function ActivateSave(isactive) {
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

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
