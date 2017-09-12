﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateProblemAction.aspx.cs" Inherits="QMSRSTools.ProblemManagement.CreateProblemAction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper" class="modulewrapper">
        <div id="ProblemAction_Header" class="moduleheader">Create a New Problem Action</div>

        <div class="toolbox">
            <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt="Save Changes" /> 
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProblemNoLabel" class="requiredlabel">Problem No:</div>
            <div id="ProblemNoField" class="fielddiv" style="width:170px;">
                <asp:TextBox ID="CaseNoTxt" runat="server" CssClass="textbox" Width="160px"></asp:TextBox>
            </div>
    
            <span id="CaseSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
    
            <div id="Case_LD" class="control-loader"></div> 

            <asp:RequiredFieldValidator ID="CaseNoVal" runat="server" Display="None" ControlToValidate="CaseNoTxt" ErrorMessage="Enter a unique case number" ValidationGroup="ID"></asp:RequiredFieldValidator>
        </div>

         <div id="ProblemTooltip" class="tooltip" style="margin-top:10px;">
            <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p></p>
        </div>

        <div id="SearchProblem" class="selectbox">
            <div class="toolbox">
                <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />

                <div id="filter_div">
                    <img id="filter" src="/Images/filter.png" alt=""/>
                    <ul class="contextmenu">
                        <li id="byPRM">Filter by Problem Title</li>
                        <li id="byPRMTYP">Filter by Problem Type</li>
                        <li id="byORGIDT">Filter by Origination Date</li>
                        <li id="byPRMRTCAUS">Filter by Root Cause</li>
                        <li id="byRECMOD">Filter by Record Mode</li>
                    </ul>
                </div>

                <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
            </div>

            <div id="OriginationDateContainer" class="filter">
                <div id="OriginationDateLabel" class="filterlabel">Origination Date:</div>
                <div id="OriginationDateField" class="filterfield">
                    <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
            </div>

            <div id="ProblemContainer" class="filter">
                <div id="ProblemNameLabel" class="filterlabel">Title:</div>
                <div id="ProblemNameField" class="filterfield">
                    <asp:TextBox ID="PRMNMFTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
                </div>
            </div>
    
            <div id="RootCauseContainer"class="filter">
                <div id="RootCauseLabel" class="filterlabel">Root Cause:</div>
                <div id="RootCauseField" class="filterfield">
                    <asp:DropDownList ID="RTCUSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RTCUS_LD" class="control-loader"></div>
            </div>

            <div id="ProblemTypeContainer" class="filter">
                <div id="ProblemTypeFLabel" class="filterlabel">Problem Type:</div>
                <div id="ProblemtypeFField" class="filterfield">
                    <asp:DropDownList ID="PRMTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="PRMTYPF_LD" class="control-loader"></div>
            </div>

            <div id="RecordModeContainer" class="filter">
                <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
                <div id="RecordModeField" class="filterfield">
                    <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RECMODF_LD" class="control-loader"></div>
            </div>
            
            <div id="FLTR_LD" class="control-loader"></div> 

            <div id="scrollbar" class="gridscroll">
                <asp:GridView id="gvProblems" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                    <Columns>
                        <asp:BoundField DataField="CaseNo" HeaderText="Problem No." />
                        <asp:BoundField DataField="ProblemType" HeaderText="Type" />
                        <asp:BoundField DataField="Title" HeaderText="Problem" />
                        <asp:BoundField DataField="OriginationDate" HeaderText="Origination Date" />
                        <asp:BoundField DataField="TargetCloseDate" HeaderText="Target Close Date" />
                        <asp:BoundField DataField="Originator" HeaderText="Problem Originator" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                        <asp:BoundField DataField="Mode" HeaderText="Record Mode" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    <div id="ActionGroupHeader" class="groupboxheader">Problem Action Details</div>
    <div id="ActionGroupField" class="groupbox" style="height:520px;">
   
        <div id="validation_dialog_action">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Action" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;" class="field">
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
   
        <div style="float:left; width:100%; height:20px; margin-top:15px;" class="field">
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

        <div style="float:left; width:100%; height:20px; margin-top:15px;" class="field">
            <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
            <div id="StartDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="STRTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            <asp:RequiredFieldValidator ID="STRTDTTxtVal" runat="server" Display="None" ControlToValidate="STRTDTTxt" ErrorMessage="Enter the start date of the action"  ValidationGroup="Action"></asp:RequiredFieldValidator>
        
            <asp:RegularExpressionValidator ID="STRTDTFVal" runat="server" ControlToValidate="STRTDTTxt"
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

        <div style="float:left; width:100%; height:20px; margin-top:15px;" class="field">
            <div id="EndDateLabel" class="requiredlabel">Planned End Date:</div>
            <div id="EndDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ENDDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            <asp:RequiredFieldValidator ID="ENDDTTxtVal" runat="server" Display="None" ControlToValidate="ENDDTTxt" ErrorMessage="Enter the planned end date of the problem"  ValidationGroup="Action"></asp:RequiredFieldValidator>  
        
            <asp:RegularExpressionValidator ID="ENDDTTxtFVal" runat="server" ControlToValidate="ENDDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator>  
          
            <asp:CompareValidator ID="ENDDTVal" runat="server" ControlToCompare="STRTDTTxt"  ValidationGroup="Action"
            ControlToValidate="ENDDTTxt" ErrorMessage="Planned end date should be greater or equals start date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator> 

            <asp:CustomValidator id="ENDDTF2Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "ENDDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
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
            
            <asp:CompareValidator ID="ACTEEBoxVal" runat="server" ControlToValidate="ACTEECBox" ValidationGroup="Action"
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
                <div id="ORG_LD" class="control-loader"></div>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;" class="field">
            <div id="ActionDescriptionLabel" class="labeldiv">Description:</div>
            <div id="ActionDescriptionField" class="fielddiv" style="width:400px; height:190px;">
                <asp:TextBox ID="ACTDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
            </div>
       
            <asp:CustomValidator id="ACTDESCTxtVal" runat="server" ValidationGroup="Action" 
            ControlToValidate = "ACTDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
    </div>



    <asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    <input id="ORGDT" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);

        ActivateAll(false);

        $("#<%=CaseSelect.ClientID%>").bind('click',function (e)
        {
            hideAll();

            showProblemDialog(e.pageX, e.pageY, empty);
        });

        $("#refresh").bind('click', function ()
        {
            hideAll();
            loadProblems(empty);
        });

        $("#byPRMTYP").bind('click', function ()
        {
            hideAll();

            /*load problem type*/
            loadProblemType();

            $("#ProblemTypeContainer").show();
        });

        $("#byPRMRTCAUS").bind('click', function ()
        {
            hideAll();

            $("#RootCauseContainer").show();

            loadRootCauses("#RTCUS_LD", "#<%=RTCUSCBox.ClientID%>");
        });

        $("#byORGIDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#OriginationDateContainer").show();
         });


        $("#byPRM").bind('click', function ()
        {
            hideAll();
            /*Clear text value*/
            $("#<%=PRMNMFTxt.ClientID%>").val('');

            $("#ProblemContainer").show();

        });

        $("#byRECMOD").bind('click', function () {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        /*filter by problem type*/
        $("#<%=PRMTYPFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByProblemType($(this).val(), empty);
            }
        });

        $("#<%=RECMODCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByProblemMode($(this).val(), empty);
            }
        });

        /*filter by problem title*/
        $("#<%=PRMNMFTxt.ClientID%>").keyup(function () {
            filterByProblemTitle($(this).val(), empty);
        });


        $("#<%=RTCUSCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var vals = $(this).val().split(" ");

                filterByProblemCause(vals[1], empty);
            }
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
            onSelect: function (date) {
                filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });


        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });


        $("#<%=CaseNoTxt.ClientID%>").keydown(function (event)
        {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13')
            {
                var text = $(this).val();

                $("#SearchProblem").hide();

                $("#Case_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $.ajax(
                     {
                         type: "POST",
                         contentType: "application/json",
                         dataType: "json",
                         data: "{'caseNo':'" + text + "'}",
                         url: getServiceURL().concat('getProblem'),
                         success: function (data)
                         {
                             $("#Case_LD").fadeOut(500, function ()
                             {
                                 var xmlProblem = $.parseXML(data.d);

                                 var problem = $(xmlProblem).find("Problem");

                                 if (problem.attr('ProblemStatus') == 'Closed' || problem.attr('ProblemStatus') == 'Cancelled')
                                 {
                                     $("#ProblemTooltip").stop(true).hide().fadeIn(500, function ()
                                     {
                                         $(this).find('p').html("Cannot create a a new action since the problem is " + problem.attr('ProblemStatus'));

                                         ActivateAll(false);

                                         resetGroup(".modulewrapper");
                                     });
                                 }
                                 else if (problem.attr('ProblemStatus') == 'Pending')
                                 {
                                     $("#ProblemTooltip").stop(true).hide().fadeIn(500, function ()
                                     {
                                         $(this).find('p').html("Cannot create a new action before the problem is approved first.");

                                         ActivateAll(false);

                                         resetGroup(".modulewrapper");
                                     });
                                 }
                                 else if (problem.find("OriginationDate").text() != '')
                                 {
                                     $("#ProblemTooltip").stop(true).hide().fadeIn(500, function () {
                                         $(this).find('p').text("Note: The origination date of the problem for this action is on " + new Date(problem.find("OriginationDate").text()).format("dd/MM/yyyy"));

                                         /* temporarily store the origination date of the problem for validation purposes*/
                                         $("#ORGDT").val(problem.find("OriginationDate").text());

                                         /*attach action title to limit plugin*/
                                         $('#<%=ACTNMTxt.ClientID%>').limit({ id_result: 'ACTTTLlimit', alertClass: 'alertremaining', limit: 50 });

                                         /*load the action type*/
                                         loadComboboxAjax('loadProblemActionType', "#<%=ACTTYPCBox.ClientID%>", "#ACTYP_LD");

                                         addWaterMarkText('Description of the action', '#<%=ACTDESCTxt.ClientID%>');

                                         ActivateAll(true);
                                     });
                                 }
                                 else
                                 {
                                     $("#ProblemTooltip").stop(true).hide().fadeIn(500, function () {
                                         $(this).find('p').text("Note: Cannot create a new action for the selected problem, since the origination date has not been set");

                                         ActivateAll(false);
                                     });
                                 }
                             });
                         },
                         error: function (xhr, status, error)
                         {
                             $("#Case_LD").fadeOut(500, function ()
                             {
                                 var r = jQuery.parseJSON(xhr.responseText);
                                 showErrorNotification(r.Message);

                                 resetGroup(".modulewrapper");

                                 ActivateAll(false);

                             });
                         }
                     });
                });
            }
        });

        $("#closeBox").bind('click', function ()
        {
            $("#SearchProblem").hide('800');
        });

        /*populate the employees in actionee cbox*/
        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            var loadcontrols = new Array();
            loadcontrols.push("#<%=ACTEECBox.ClientID%>");

            loadParamComboboxAjax('getDepEmployees', loadcontrols, "'unit':'" + $(this).val() + "'", "#ACTEMP_LD");
            $("#SelectORG").hide('800');
        });

        $("#<%=ACTEESelect.ClientID%>").bind('click', function (e)
        {
            $("#invoker").val('Executive');
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


        $("#save").bind('click', function ()
        {
            var isGeneralValid = Page_ClientValidate('ID');
            if (isGeneralValid)
            {
                var isActionValid = Page_ClientValidate('Action');
                if (isActionValid)
                {
                    if (!$("#validation_dialog_action").is(":hidden")) {
                        $("#validation_dialog_action").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $find('<%= SaveExtender.ClientID %>').show();

                        var startdate = getDatePart($("#<%=STRTDTTxt.ClientID%>").val());
                        var enddate = getDatePart($("#<%=ENDDTTxt.ClientID%>").val());

                        var action =
                        {
                            name: $("#<%=ACTNMTxt.ClientID%>").val(),
                            Description: $("#<%=ACTDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTDESCTxt.ClientID%>").val()),
                            StartDate: new Date(startdate[2], (startdate[1] - 1), startdate[0]),
                            PlannedEndDate: new Date(enddate[2], (enddate[1] - 1), enddate[0]),
                            ActionType: $("#<%=ACTTYPCBox.ClientID%>").val(),
                            Actionee: $("#<%=ACTEECBox.ClientID%>").val()
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'json':'" + JSON.stringify(action) + "','caseNo':'" + $.trim($("#<%=CaseNoTxt.ClientID%>").val()) + "'}",
                            url: getServiceURL().concat('createProblemAction'),
                            success: function (data)
                            {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                showSuccessNotification(data.d);

                                /*reset default values*/
                                resetGroup(".modulewrapper");

                                ActivateAll(false);

                                /*restore watermarks*/
                                if (!$("#<%=ACTDESCTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    addWaterMarkText('Description of the action', '#<%=ACTDESCTxt.ClientID%>');
                                }
                            },
                            error: function (xhr, status, error)
                            {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            }
                        });
                    }
                }
                else
                {
                    $("#validation_dialog_action").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
            }
            else
            {
                alert("Enter a unique problem case number");
            }
        });
    });

    function loadProblemType()
    {
        $("#PRMTYPF_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemType"),
                success: function (data)
                {
                    $("#PRMTYPF_LD").fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $("#<%=PRMTYPFCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PRMTYPF_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function compareOriginationDate(sender, args)
    {
        var targetdatepart = getDatePart(args.Value);
        var originationdatepart = getDatePart(new Date($("#ORGDT").val()).format('dd/MM/yyyy'));


        var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
        var originationdate = new Date(originationdatepart[2], (originationdatepart[1] - 1), originationdatepart[0]);

        if (targetdate < originationdate)
        {
            args.IsValid = false;
        }
        else {
            args.IsValid = true;
        }

        return args.IsValid;
    }

    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x, top: y });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
        $("#SelectORG").show();
    }

    function filterByProblemTitle(title, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat('filterProblemByName'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });

                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByProblemMode(mode, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterProblemByMode'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }


    function filterByProblemCause(cause, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'causeID':'" + cause + "'}",
                url: getServiceURL().concat('filterProblemByRootCause'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                var dateparam =
                {
                    StartDate: startdate,
                    EndDate: enddate
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('filterProblemByOriginationDate'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {

                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
    }
    function filterByProblemType(type, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterProblemBytype'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });

                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadProblems(empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadProblems'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadGridView(data, empty)
    {
        var xmlProblems = $.parseXML(data);

        var row = empty;

        $("#<%=gvProblems.ClientID%> tr").not($("#<%=gvProblems.ClientID%> tr:first-child")).remove();

        $(xmlProblems).find("Problem").each(function (index, value) {
            $("td", row).eq(0).html($(this).attr("CaseNo"));
            $("td", row).eq(1).html($(this).attr("ProblemType"));
            $("td", row).eq(2).html($(this).attr("Title"));

            var originationdate = new Date($(this).find("OriginationDate").text());
            originationdate.setMinutes(originationdate.getMinutes() + originationdate.getTimezoneOffset());

            $("td", row).eq(3).html($(this).find("OriginationDate").text() == '' ? '' : originationdate.format("dd/MM/yyyy"));

            var targetclosedate = new Date($(this).attr("TargetCloseDate"));
            targetclosedate.setMinutes(targetclosedate.getMinutes() + targetclosedate.getTimezoneOffset());

            $("td", row).eq(4).html(targetclosedate.format("dd/MM/yyyy"));
            $("td", row).eq(5).html($(this).attr("Originator"));
            $("td", row).eq(6).html($(this).attr("ProblemStatus"));
            $("td", row).eq(7).html($(this).attr("ModeString"));

            $("#<%=gvProblems.ClientID%>").append(row);
            row = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);
        });

        $("#<%=gvProblems.ClientID%> tr").not($("#<%=gvProblems.ClientID%> tr:first-child")).bind('click', function ()
        {
            $("#SearchProblem").hide('800');

            $("#<%=CaseNoTxt.ClientID%>").val($("td", $(this)).eq(0).html());

            var e = jQuery.Event("keydown");
            e.which = 13; // # Some key code value
            $("#<%=CaseNoTxt.ClientID%>").trigger(e);
        });
    }

    function ActivateAll(isactive)
    {
        if (isactive == false) {
            $(".groupbox").children().each(function () {
                $(this).find('.textbox').each(function () {
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
        }
        else {
            $(".groupbox").each(function () {
                $(this).find('.readonlycontrolled').each(function () {
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
        }
    }

    function showProblemDialog(x, y, empty)
    {
        loadProblems(empty);

        $("#SearchProblem").css({ left: x - 280, top: y + 10 });
        $("#SearchProblem").css({ width: 700, height: 250 });
        $("#SearchProblem").show();
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
</script>
</asp:Content>
