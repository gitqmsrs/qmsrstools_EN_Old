<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateAction.aspx.cs" Inherits="QMSRSTools.AuditManagement.CreateAction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div id="wrapper" class="modulewrapper">

    <div id="AUDTACT_Header" class="moduleheader">Create a New Audit Action</div>

    <div class="toolbox">
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt="" />
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="AUDTIDLabel" class="requiredlabel">Audit ID:</div>
        <div id="AUDTIDField" class="fielddiv" style="width:250px">
            <asp:TextBox ID="AUDTIDTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
        </div>

        <span id="AUDTIDSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for audit record"></span>
    
        <div id="AUDTID_LD" class="control-loader"></div> 
        
        <asp:RequiredFieldValidator ID="AUDTIDVal" runat="server" Display="Dynamic" ControlToValidate="AUDTIDTxt" ErrorMessage="Enter the ID of the audit" ValidationGroup="ID" CssClass="validator">
        </asp:RequiredFieldValidator>       
    </div>
    
    <div id="SearchAudit" class="selectbox" style="width:600px; height:250px; top:80px; left:150px;">
        <div class="toolbox">
            <img id="deletefilter" src="../Images/filter-delete-icon.png" class="selectBoxImg" alt=""/>
            <div id="filter_div">
                <img id="filter" src="../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byPLNAUDT">Planned Audit Date</li>
                </ul>
            </div>
            <div id="AuditDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                <div id="PlannedDateLabel" style="width:120px;">Planned Audit Date:</div>
                <div id="PlannedDateField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
            </div>

            <div id="closeBox" class="selectboxclose"></div>
        </div>
        <div id="FLTR_LD" class="control-loader"></div> 
        <div id="scrollbar" style="height:250px; width:96%; overflow:auto; margin-top:15px; float:left">
            <asp:GridView id="gvAudits" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:BoundField DataField="AuditNo" HeaderText="Audit No." />
                    <asp:BoundField DataField="AuditType" HeaderText="Type" />
                    <asp:BoundField DataField="PlannedAuditDate" HeaderText="Planned Date" />
                    <asp:BoundField DataField="ActualAuditDate" HeaderText="Actual Date" />
                    <asp:BoundField DataField="AuditStatus" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="FindingDescriptionLabel" class="requiredlabel">Select Finding:</div>
        <div id="FindingDescriptionField" class="fielddiv" style="width:400px">
            <asp:TextBox ID="FNDTxt" runat="server"  CssClass="readonly" Width="390px" Height="100px" TextMode="MultiLine"></asp:TextBox>
        </div>
        <input id="SRCHFNDB" class="button" type="button" value="Search" style="margin-left:5px; width:85px" />
        <asp:RequiredFieldValidator ID="FDESCVal" runat="server" Display="Dynamic" ControlToValidate="FNDTxt" ErrorMessage="Select finding" ValidationGroup="Finding" CssClass="validator">
        </asp:RequiredFieldValidator>   
    </div>

    <div id="ActionGroupHeader" class="groupboxheader" style=" margin-top:105px;">Action Details</div>
    <div id="ActionGroupField" class="groupbox" style="height:400px">

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActionTypeLabel" class="requiredlabel">Action Type:</div>
            <div id="ActionTypeField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="ACTTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
        
            <div id="ACTTYP_LD" class="control-loader"></div> 

            <asp:RequiredFieldValidator ID="ACTTYPTTxtVal" runat="server" Display="None" ErrorMessage="Select action type" ControlToValidate="ACTTYPCBox" ValidationGroup="General">
            </asp:RequiredFieldValidator>

            <asp:CompareValidator ID="ACTTYPVal" runat="server" ControlToValidate="ACTTYPCBox" Display="None"
            ErrorMessage="Select action type" Operator="NotEqual" Style="position: static" ValidationGroup="General"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActioneeLabel" class="requiredlabel">Actionee:</div>
            <div id="ActioneeField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="ACTEETxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>
            <span id="ACTEESelect" class="searchactive" style="margin-left:10px" runat="server"></span>
        
            <asp:RequiredFieldValidator ID="ACTEEVal" runat="server" ControlToValidate="ACTEETxt" ErrorMessage="Select the name of the actionee" Display="None" ValidationGroup="General"></asp:RequiredFieldValidator>     
        </div>
    
        <div id="SelectActionee" class="selectbox" style="top:300px; left:160px;">
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
            </div>
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActionDetailsLabel" class="labeldiv">Details:</div>
            <div id="ActionDetailsField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="ACTDTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
     
            <asp:CustomValidator id="ACTDTLVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "ACTDTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:125px;">
            <div id="TRGTDateLabel" class="requiredlabel">Target Close Date:</div>
            <div id="TRGTDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="TRGTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="TRGTDTVal" runat="server" Display="None" ControlToValidate="TRGTDTTxt" ErrorMessage="Enter the target close date of the action" ValidationGroup="General"></asp:RequiredFieldValidator>   
       
            <asp:RegularExpressionValidator ID="TRGTDTxtFVal" runat="server" ControlToValidate="TRGTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General">
            </asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="TRGTDTF2Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "TRGTDTTxt" Display="None" ErrorMessage = "Target close date should be greater than or equals the planned date of the audit"
            ClientValidationFunction="comparePlannedAuditDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="TRGTDTF3Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "TRGTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator> 

        </div>
    </div>

    <div id="FindingDialog" title="Related Findings" style="display:none;">
        <div id="data"></div>
    </div>

    <input id="findingid" type="hidden" value="" /> 
    <input id="auditdate" type="hidden" />

    <asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvAudits.ClientID%> tr:last-child").clone(true);

        addWaterMarkText('Brief Description of the Action', '#<%=ACTDTLTxt.ClientID%>');

        /*deactivate all controls*/
        ActivateAll(false);

        $("#deletefilter").bind('click', function ()
        {
            hideAll();
            refreshAudits(empty);
        });

        $("#byPLNAUDT").bind('click', function ()
        {
            hideAll();

            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#AuditDateContainer").show();
        });

        $("#<%=AUDTIDSRCH.ClientID%>").bind('click', function () {
            refreshAudits(empty);

            $("#SearchAudit").show();
        });

        $("#closeBox").bind('click', function () {
            $("#SearchAudit").hide('800');
        });

        $("#<%=ACTEESelect.ClientID%>").bind('click', function ()
        {
            var isFindingValid = Page_ClientValidate("Finding");
            if (isFindingValid)
            {
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
                $("#<%=EMPCBox.ClientID%>").empty();
                $("#SelectActionee").show();
            }
            else
            {
                alert("Please select a finding");
            }
        });


        $("#closeActionee").bind('click', function () {
            $("#SelectActionee").hide('800');
        });

        $("#<%=TRGTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
            }
        });

        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterAudit($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterAudit($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterAudit(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterAudit($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        
        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            loadcontrols.push("#<%=EMPCBox.ClientID%>");
            loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, $("#ORGUNT_LD"));
        });

        $("#<%=EMPCBox.ClientID%>").change(function () {
            $("#<%=ACTEETxt.ClientID%>").val($(this).val());
            $("#SelectActionee").hide('800');
        });


        $("#<%=AUDTIDTxt.ClientID%>").keydown(function (event)
        {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13')
            {
                loadFindings($(this).val());
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('General');
            if (isPageValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }
                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {
                    $find('<%= SaveExtender.ClientID %>').show();

                    var CLSDTParts = getDatePart($("#<%=TRGTDTTxt.ClientID%>").val());
                    var action =
                    {
                        ActionType: $("#<%=ACTTYPCBox.ClientID%>").find('option:selected').text(),
                        Details: $("#<%=ACTDTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTDTLTxt.ClientID%>").val()),
                        Actionee: $("#<%=ACTEETxt.ClientID%>").val(),
                        TargetClosingDate: new Date(CLSDTParts[2], (CLSDTParts[1] - 1), CLSDTParts[0])
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'json':'" + JSON.stringify(action) + "','findingID':'" + $("#findingid").val() + "'}",
                        url: getServiceURL().concat("createAuditAction"),
                        success: function (data) {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            alert(data.d);

                            reset();

                            /*restore watermark for the action details*/
                            addWaterMarkText('Brief Description of the Action', '#<%=ACTDTLTxt.ClientID%>');

                            ActivateAll(false);

                            $("#data").empty();
                        },
                        error: function (xhr, status, error) {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        }
                    });
                }
            }
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

        $("#SRCHFNDB").bind('click', function () {
            showFindingDialog();
        });

    });

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

    function refreshActionType()
    {
        $("#ACTTYP_LD").stop(true).hide().fadeIn(500, function ()
        {
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
                        var xml = $.parseXML(data.d);

                        loadComboboxXML(xml, 'ActionFindingType', 'TypeName', '#<%=ACTTYPCBox.ClientID%>');
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ACTTYP_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });

    }

    function loadFindings(auditno)
    {
        $("#AUDTID_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            /*clear all previous finding records*/
            $("#data").empty();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'auditno':'" + $("#<%=AUDTIDTxt.ClientID%>").val() + "'}",
                url: getServiceURL().concat("loadFindings"),
                success: function (data) {
                    $("#AUDTID_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var xml = $.parseXML(data.d);
                            $(xml).find("AuditRecord").each(function (i, audit) {

                                if ($(audit).attr('AuditStatusString') == 'Completed' || $(audit).attr('AuditStatusString') == 'Cancelled') {
                                    alert("Changes cannot take place since the audit is " + $(audit).attr('AuditStatusString'));
                                    reset();

                                    ActivateAll(false);
                                }
                                else {
                                    //activate search button
                                    $(".button").each(function () {
                                        $(this).attr("disabled", false);
                                        $(this).css({ opacity: 1 });
                                    });

                                    /* temporarily store the planned date of the audit record for validation purposes*/
                                    $("#auditdate").val($(audit).attr('PlannedAuditDate'));

                                    var findings = $.parseXML($(this).attr("RelatedXmlFindings"));

                                    if ($(findings).find("AuditFinding").length > 0) {
                                        $(findings).find("AuditFinding").each(function (j, finding) {
                                            var sb = new StringBuilder('');

                                            sb.append("<div id='row_" + j + "' class='datarow' title=''>");

                                            sb.append("<h3>(" + (j + 1) + ") Finding");
                                            sb.append("</h3>");

                                            sb.append("<div class='content'>");

                                            sb.append("<div style='float:left; width:100%; height:20px; margin-top:2px;'>");
                                            sb.append("<div class='labeldiv'>Finding ID</div>");
                                            sb.append("<div class='fielddiv'>");
                                            sb.append("<div class='label'>" + $(finding).attr('FindingID') + "</div>");
                                            sb.append("</div>");
                                            sb.append("</div>");

                                            sb.append("<div style='float:left; width:100%; height:20px; margin-top:2px;'>");
                                            sb.append("<div class='labeldiv'>Finding</div>");
                                            sb.append("<div class='fielddiv' style='width:50%; height:auto;'>");
                                            sb.append("<div class='label' style='width:100%; height:auto;'>" + $(finding).attr('Finding') + "</div>");
                                            sb.append("</div>");
                                            sb.append("</div>");

                                            sb.append("</div>");
                                            sb.append("</div>");

                                            $("#data").append(sb.toString());

                                            $("#row_" + j).bind('click', function () {
                                                $("#<%=FNDTxt.ClientID%>").val($(finding).attr('Finding'));
                                                $("#findingid").val($(finding).attr('FindingID'));

                                                refreshActionType();

                                                ActivateAll(true);


                                                $("#FindingDialog").dialog("close");
                                            });
                                        });
                                    }
                                    else {
                                        alert("There are no findings for the current audit record to create a corresponding action");
                                        reset();

                                        ActivateAll(false);
                                    }
                                }
                            });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#AUDTID_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);

                        reset();
                        ActivateAll(false);
                    });
                }
            });
        });
    }
    function showFindingDialog() {
        $("#FindingDialog").dialog(
        {
            width: 550,
            show: "slow",
            modal: true,
            height: 300,
            hide: "highlight",
            buttons:
            [
                 {
                     text: "Cancel",
                     click: function () {
                         $(this).dialog("close");
                     }
                 }
            ],
            close: function (event, ui) {
                $(this).dialog("destroy");
            }

        });
    }
    function ActivateAll(isactive) {
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
            });


            $(".button").each(function () {
                $(this).attr("disabled", true);
                $(this).css({ opacity: 0.5 });
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
            });

            $(".button").each(function () {
                $(this).attr("disabled", false);
                $(this).css({ opacity: 1 });
            });

            $('#save').attr("disabled", false);
        }
    }
    function filterAudit(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true) {
            
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                var dateparam =
                {
                    StartDate: plannedstartdate,
                    EndDate: plannedenddate
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('filterAuditsByDate'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data)
                            {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }
    function refreshAudits(empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadAudits'),
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
                        alert(r.Message);
                    });

                }
            });
        });
    }
    function loadGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvAudits.ClientID%> tr").not($("#<%=gvAudits.ClientID%> tr:first-child")).remove();

            $(xml).find("AuditRecord").each(function (index, value) {

                $("td", row).eq(0).html($(this).attr("AuditNo"));
                $("td", row).eq(1).html($(this).attr("AuditType"));
                $("td", row).eq(2).html(new Date($(this).attr("PlannedAuditDate")).format("dd/MM/yyyy"));
                $("td", row).eq(3).html($(this).find("ActualAuditDate").text() == '' ? '' : new Date($(this).find("ActualAuditDate").text()).format("dd/MM/yyyy"));
                $("td", row).eq(4).html($(this).attr("AuditStatusString"));

                $("#<%=gvAudits.ClientID%>").append(row);

                row = $("#<%=gvAudits.ClientID%> tr:last-child").clone(true);
            });

            $("#<%=gvAudits.ClientID%> tr").not($("#<%=gvAudits.ClientID%> tr:first-child")).bind('click', function () {

                $("#SearchAudit").hide('800');
                $("#<%=AUDTIDTxt.ClientID%>").val($("td", $(this)).eq(0).html());

                var e = jQuery.Event("keydown");
                e.which = 13; // # Some key code value
                $("#<%=AUDTIDTxt.ClientID%>").trigger(e);

            });

    }
    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
