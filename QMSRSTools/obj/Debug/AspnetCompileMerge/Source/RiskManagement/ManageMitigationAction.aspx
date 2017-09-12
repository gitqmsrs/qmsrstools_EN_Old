<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageMitigationAction.aspx.cs" Inherits="QMSRSTools.RiskManagement.ManageMitigationAction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper" class="modulewrapper">
        
        <div id="RSKACT_Header" class="moduleheader">Manage Risk Mitigation Action</div>

        <div class="toolbox">
            <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
    
            <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>

                <ul class="contextmenu">
                    <li id="byRSKTYP">Filter by Risk Type</li>
                    <li id="byTRGTDT">Filter by Target Close Date</li>
                </ul>
            </div>

            <div id="RSKTYPContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RiskTypeFLabel" style="width:100px;">Risk Type:</div>
                <div id="RiskTypeFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RSKTYPFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RSKTYPF_LD" class="control-loader"></div>
            </div>

            <div id="TargetCloseDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                <div id="TargetDateFLabel" style="width:120px;">Target Close Date:</div>
                <div id="TargetDateFField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
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
                <asp:BoundField DataField="RSKTitle" HeaderText="Risk Name" />
                <asp:BoundField DataField="MitigationType" HeaderText="Mitigation Type" />
                <asp:BoundField DataField="TargetCloseDate" HeaderText="Target Close Date" />
                <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
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
                <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
                <p></p>
	        </div>	
    
            <div id="SaveTooltip" class="tooltip">
                <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
                <p>Saving...</p>
	        </div>

            <div id="validation_dialog_action" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Action" />
            </div>
            
            <input id="mitigationactionID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="MitigationTypeLabel" class="labeldiv">Mitigation Type:</div>
                <div id="MitigationTypeField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="MTGTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
        
                <div id="MTGTYP_LD" class="control-loader"></div> 
            </div>
    
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="PotentialImpactLabel" class="labeldiv">Potential Impact:</div>
                <div id="PotentialImpactField" class="fielddiv" style="width:400px">
                    <asp:TextBox ID="PIMPTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                </div>
     
                <asp:CustomValidator id="PIMPTxtVal" runat="server" ValidationGroup="Action" 
                ControlToValidate = "PIMPTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:92px;">
                <div id="CountermeasuresLabel" class="labeldiv">Countermeasures:</div>
                <div id="CountermeasuresField" class="fielddiv" style="width:400px">
                    <asp:TextBox ID="CMSURTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                </div>
     
                <asp:CustomValidator id="CMSURTxtVal" runat="server" ValidationGroup="Action" 
                ControlToValidate = "CMSURTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:92px;">
                <div id="ActionLabel" class="labeldiv">Actions:</div>
                <div id="ActionField" class="fielddiv" style="width:400px">
                    <asp:TextBox ID="ACTTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                </div>
     
                <asp:CustomValidator id="ACTTxtVal" runat="server" ValidationGroup="Action" 
                ControlToValidate = "ACTTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:92px;">
                <div id="TargetCloseDateLabel" class="requiredlabel">Target Close Date:</div>
                <div id="TargetCloseDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="TRGTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
                
                <asp:RequiredFieldValidator ID="TRGTDTVal" runat="server" Display="None" ControlToValidate="TRGTDTTxt" ErrorMessage="Enter the target close date of the mitigation action"  ValidationGroup="Action"></asp:RequiredFieldValidator>  
        
                <asp:RegularExpressionValidator ID="TRGTDTFVal" runat="server" ControlToValidate="TRGTDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator> 
        
                <asp:CustomValidator id="TRGTDTF2Val" runat="server" ValidationGroup="Action" 
                ControlToValidate = "TRGTDTTxt" Display="None" ErrorMessage = "Target close date should be greater than or equals the register date of the risk"
                ClientValidationFunction="compareRegisterDate">
                </asp:CustomValidator>
                
                <asp:CustomValidator id="TRGTDTF3Val" runat="server" ValidationGroup="Action" 
                ControlToValidate = "TRGTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
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

                <asp:RegularExpressionValidator ID="ACTCLSDTTxtFVal" runat="server" ControlToValidate="ACTCLSDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator>  
                    
                <asp:CustomValidator id="ACTCLSDTF3Val" runat="server" ValidationGroup="Action" 
                ControlToValidate = "ACTCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
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
            
            <div class="buttondiv">
                <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
                <input id="cancel" type="button" class="button" value="Cancel" />
            </div>
        </asp:Panel>
    </div>

    <input id="registerdate" type="hidden" />

    <script type="text/javascript" language="javascript">
        $(function () {
            var empty = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);

            loadRiskActions(empty);

            $("#refresh").bind('click', function ()
            {
                hideAll();
                loadRiskActions(empty);
            });

            $("#deletefilter").bind('click', function ()
            {
                hideAll();
                loadRiskActions(empty);
            });

            $("#<%=ACTEESelect.ClientID%>").bind('click', function (e) {
                showORGDialog(e.pageX, e.pageY);
            });

            $("#closeORG").bind('click', function () {
                $("#SelectORG").hide('800');
            });

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#<%=ORGUNTCBox.ClientID%>").bind('click', function () {
                if ($(this).val() != 0) {
                    unitparam = "'unit':'" + $(this).val() + "'";
                    var loadcontrols = new Array();

                    loadcontrols.push("#<%=ACTEECBox.ClientID%>");
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, $("#ACTEMP_LD"));

                    $("#SelectORG").hide('800');
                }
            });

            $("#byRSKTYP").bind('click', function () {
                hideAll();

                $("#RSKTYPContainer").show();

                /*load risk type*/
                loadComboboxAjax('loadRiskType', "#<%=RSKTYPFCBox.ClientID%>", "#RSKTYPF_LD");
            });


            $("#byTRGTDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#TargetCloseDateContainer").show();
            });



            $("#<%=RSKTYPFCBox.ClientID%>").change(function () {

                filterRiskActionsByRiskType($(this).val(), empty);
            });


            /*filter by target date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByTargetDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByTargetDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByTargetDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
                }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByTargetDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $("#<%=TRGTDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {

                }
            });

            $("#<%=ACTCLSDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {

                }
            });


            $("#save").bind('click', function ()
            {

                var isPageValid = Page_ClientValidate('Action');
                if (isPageValid) {
                    if (!$("#validation_dialog_action").is(":hidden")) {
                        $("#validation_dialog_action").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {
                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            var actual = getDatePart($("#<%=ACTCLSDTTxt.ClientID%>").val());
                            var target = getDatePart($("#<%=TRGTDTTxt.ClientID%>").val());

                            var action =
                            {
                                ActionID: $("#mitigationactionID").val(),
                                MitigationType: $("#<%=MTGTYPCBox.ClientID%>").val() == 0 || $("#<%=MTGTYPCBox.ClientID%>").val() == null ? '' : $("#<%=MTGTYPCBox.ClientID%>").val(),
                                Countermeasures: $("#<%=CMSURTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=CMSURTxt.ClientID%>").val()),
                                PotentialImpact: $("#<%=PIMPTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=PIMPTxt.ClientID%>").val()),
                                Actions: $("#<%=ACTTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTTxt.ClientID%>").val()),
                                Actionee: $("#<%=ACTEECBox.ClientID%>").val(),
                                TargetCloseDate: new Date(target[2], (target[1] - 1), target[0]),
                                ActualCloseDate: actual == '' ? null : new Date(actual[2], (actual[1] - 1), actual[0])
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{'json':'" + JSON.stringify(action) + "'}",
                                url: getServiceURL().concat("updateMitigationAction"),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        alert(data.d);

                                        $("#cancel").trigger('click');
                                        $("#refresh").trigger('click');
                                    });

                                },
                                error: function (xhr, status, error) {
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
                else {
                    $("#validation_dialog_action").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
            });
        });

        function compareRegisterDate(sender, args)
        {
            var targetdatepart = getDatePart(args.Value);
            var planneddatepart = getDatePart(new Date($("#registerdate").val()).format('dd/MM/yyyy'));


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

        function showORGDialog(x, y)
        {
            $("#SelectORG").css({ left: x - 300, top: y - 90 });
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
            $("#SelectORG").show();
        }

        function bindMitigationType(type)
        {
            $("#MTGTYP_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadMitigationTypes"),
                    success: function (data)
                    {
                        $("#MTGTYP_LD").fadeOut(500, function () {
                            if (data)
                            {
                                bindComboboxXML($.parseXML(data.d), 'MitigationType', 'Type',type, $("#<%=MTGTYPCBox.ClientID%>"));
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#MTGTYP_LD").fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
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

        function loadRiskActions(empty)
        {
            $("#ACTwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat('loadRiskList'),
                    success: function (data)
                    {
                        $("#ACTwait").fadeOut(500, function () 
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data)
                            {
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

        function filterRiskActionsByRiskType(type, empty)
        {
            $("#ACTwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'type':'" + type + "'}",
                    url: getServiceURL().concat('filterRiskByType'),
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

        function filterByTargetDateRange(start, end, empty) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true) {
                $("#ACTwait").stop(true).hide().fadeIn(800, function () {
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
                        url: getServiceURL().concat('filterRiskMitigationActionsByTargetCloseDate'),
                        success: function (data) {
                            $("#ACTwait").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                loadGridView(data.d, empty);
                            });

                        },
                        error: function (xhr, status, error) {
                            $("#ACTwait").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);

                            })
                        }
                    });
                });
            }
        }

        function loadGridView(data, empty)
        {
            var xmlRisk = $.parseXML(data);

            var row = empty;

            $("#<%=gvActions.ClientID%> tr").not($("#<%=gvActions.ClientID%> tr:first-child")).remove();


            $(xmlRisk).find("Risk").each(function (i, risk)
            {
                var xmlActions = $.parseXML($(this).attr('Actions'));

                $(xmlActions).find('MitigationAction').each(function (j, action)
                {
                    /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                    var date = new Date();

                    $("td", row).eq(0).html("<img id='delete_" + j + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
                    $("td", row).eq(1).html("<img id='edit_" + j + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");
                    $("td", row).eq(2).html($(risk).attr("RiskName"));
                    $("td", row).eq(3).html($(this).attr("MitigationType"));
                    $("td", row).eq(4).html(new Date($(this).attr("TargetCloseDate")).format("dd/MM/yyyy"));
                    $("td", row).eq(5).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
                    $("td", row).eq(6).html($(this).attr("Actionee"));
                    $("td", row).eq(7).html($(this).attr("IsClosed") == 'true' ? 'Closed' : 'Open');

                    $("#<%=gvActions.ClientID%>").append(row);

                    $(row).find('img').each(function ()
                    {
                        if ($(this).attr('id').search('edit') != -1)
                        {
                            $(this).bind('click', function ()
                            {
                                $("#validation_dialog_action").hide();

                                /*set the ID of the action for update reference*/
                                $("#mitigationactionID").val($(action).attr('ActionID'));


                                /* temporarily store the registeration date of the risk for validation purposes*/
                                $("#registerdate").val($(risk).attr('RegisterDate'));

                                /*clear all fields*/
                                resetGroup('.modalPanel');
                             
                                /*bind mitigation type*/
                                bindMitigationType($(action).attr("MitigationType"));

                                /*bind target start date*/
                                $("#<%=TRGTDTTxt.ClientID%>").val(new Date($(action).attr("TargetCloseDate")).format("dd/MM/yyyy"));

                                /*bind action actial close date*/
                                $("#<%=ACTCLSDTTxt.ClientID%>").val($(action).find("ActualCloseDate").text() == '' ? '' : new Date($(action).find("ActualCloseDate").text()).format("dd/MM/yyyy"));

                                /*bind potential impact description*/
                                if ($(action).attr("PotentialImpact") == '')
                                {
                                    addWaterMarkText('The description of the potential impact', '#<%=PIMPTxt.ClientID%>');
                                     
                                }
                                else
                                {
                                    if ($("#<%=PIMPTxt.ClientID%>").hasClass("watermarktext"))
                                    {
                                        $("#<%=PIMPTxt.ClientID%>").val('').removeClass("watermarktext");
                                    }

                                    $("#<%=PIMPTxt.ClientID%>").html($(action).attr("PotentialImpact")).text();
                                }

                                /*bind countermeasures*/
                                if ($(action).attr("Countermeasures") == '')
                                {
                                    addWaterMarkText('The description of the countermeasures', '#<%=CMSURTxt.ClientID%>');
                                }
                                else
                                {
                                    if ($("#<%=CMSURTxt.ClientID%>").hasClass("watermarktext"))
                                    {
                                        $("#<%=CMSURTxt.ClientID%>").val('').removeClass("watermarktext");
                                    }

                                    $("#<%=CMSURTxt.ClientID%>").html($(action).attr("Countermeasures")).text();

                                }

                                /*bind actions*/
                                if ($(action).attr("Actions") == '')
                                {
                                    addWaterMarkText('The description of the actions', '#<%=ACTTxt.ClientID%>');
                                }
                                else
                                {
                                    if ($("#<%=ACTTxt.ClientID%>").hasClass("watermarktext"))
                                    {
                                        $("#<%=ACTTxt.ClientID%>").val('').removeClass("watermarktext");
                                    }

                                    $("#<%=ACTTxt.ClientID%>").html($(action).attr("Actions")).text();

                                }

                                /*bind actionee*/
                                bindComboboxAjax('loadEmployees', '#<%=ACTEECBox.ClientID%>', $(action).attr("Actionee"), "#ACTEMP_LD");

                                if ($(risk).attr('RiskStatusString') == 'Closed' || $(risk).attr('RiskStatusString') == 'Cancelled')
                                {
                                    $("#ACTTooltip").find('p').text("Changes cannot take place since the risk is " + $(value).attr('RiskStatusString'));

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
                        else if ($(this).attr('id').search('delete') != -1)
                        {
                            $(this).bind('click', function ()
                            {
                                removeMitigationAction($(action).attr('ActionID'));
                            });
                        }
                    });
                    row = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);
                });
            });
        }

        function removeMitigationAction(actionID)
        {
            var result = confirm("Are you sure you would like to remove the selected action?");
            if (result == true) {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'actionID':'" + actionID + "'}",
                    url: getServiceURL().concat('removeMitigationAction'),
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

        function hideAll() {
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
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
    </script>
</asp:Content>
