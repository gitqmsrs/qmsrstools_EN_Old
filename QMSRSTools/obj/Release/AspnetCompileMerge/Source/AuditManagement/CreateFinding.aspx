﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateFinding.aspx.cs" Inherits="QMSRSTools.AuditManagement.CreateFinding" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="FND_Header" class="moduleheader">Create a New Finding</div>

    <div class="toolbox">
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt="" />
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="AUDTIDLabel" class="requiredlabel">Audit ID:</div>
        <div id="AUDTIDField" class="fielddiv" style="width:250px">
            <asp:TextBox ID="AUDTIDTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
        </div>
  
        <span id="AUDTIDSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for an audit record"></span>
  
        <div id="AUDTID_LD" class="control-loader"></div>
  
        <asp:RequiredFieldValidator ID="AUDTIDVal" runat="server" Display="None" ControlToValidate="AUDTIDTxt" ErrorMessage="Enter the ID of the audit" ValidationGroup="ID"></asp:RequiredFieldValidator>  
    </div>

    <div id="SearchAudit" class="selectbox" style="width:600px; height:250px; top:80px; left:150px;">
        <div class="toolbox">
            <div id="filter_div">
                <img id="filter" src="../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byPLNAUDT">Planned Audit Date</li>
                </ul>
            </div>
       
            <img id="deletefilter" src="../Images/filter-delete-icon.png" class="selectBoxImg" alt=""/>
    
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

    <div id="FindingGroupHeader" class="groupboxheader">Finding Details</div>
    <div id="FindingGroupField" class="groupbox" style="height:520px;">
        
        <ul id="tabul">
            <li id="Details" class="ntabs">Details</li>
            <li id="Causes" class="ntabs">Related Causes</li>
        </ul>
        
        <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">

            <div id="validation_dialog_general" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="FindingDescriptionLabel" class="requiredlabel">Finding:</div>
                <div id="FindingDescriptionField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="FDESCTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
            
                <div id="DESClimit" class="textremaining"></div>

                <asp:RequiredFieldValidator ID="FDESCVal" runat="server" ControlToValidate="FDESCTxt" ErrorMessage="Enter the name of the finding" Display="None" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:CustomValidator id="FDESCTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "FDESCTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>    
            </div>        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="FindingTypeLabel" class="requiredlabel">Finding Type:</div>
                <div id="FindingTypeField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="FNDTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="FNDTYP_LD" class="control-loader"></div>
  
                <img id="FNDTYPADD" class="imgButton" src="../Images/add.png" style="margin-left:2px" runat="server" title="Create a new finding type" alt=""/>
           
                <asp:RequiredFieldValidator ID="FNDTYPEMPTVal" runat="server" Display="None" ErrorMessage="Select finding type" ControlToValidate="FNDTYPCBox" ValidationGroup="General">
                </asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="FNDTYPVal" runat="server" ControlToValidate="FNDTYPCBox" Display="None"
                ErrorMessage="Select finding type" Operator="NotEqual" Style="position: static" ValidationGroup="General"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="FindingDetailsLabel" class="labeldiv">Additional Details:</div>
                <div id="FindingDetailsField" class="fielddiv" style="width:400px">
                    <asp:TextBox ID="DTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
            
                <asp:CustomValidator id="DTLTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "DTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:125px;">
                <div id="ISOClauseLabel" class="labeldiv">Select ISO Clause:</div>
                <div id="ISOClauseField" class="fielddiv" style="width:250px">
                    <div id="ISOCHK" class="checklist" style="height:120px"></div>
                </div>
                <div id="ISO_LD" class="control-loader"></div>
            </div>

        </div>

        <div id="CausesTB" class="tabcontent" style="display:none; height:450px;">
            <div class="toolbox">
                <img id="undo" src="../Images/undo.png" class="imgButton" title="Undo Causes" alt="" />
                <img id="delete" src="../Images/deletenode.png" alt="" class="imgButton" title="Remove Cause"/>
                <img id="new" src="../Images/new_file.png" alt="" class="imgButton" title="New Child Cause"/> 

                <div id="RootCauseContainer" style=" float:left;width:400px; margin-left:10px; height:20px; margin-top:3px;">
                    <div id="RootCauseLabel" style="width:100px;">Root Cause:</div>
                    <div id="RootCauseField" style="width:250px; left:0; float:left;">
                        <asp:DropDownList ID="RTCAUSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="RTCAUS_LD" class="control-loader"></div>
                </div>

            </div>

            <div id="treemenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible;">
                <div id="CAUSwait" class="loader">
                    <div class="waittext">Please Wait...</div>
                </div>

                <div id="causetree"></div>
            </div>

            <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; overflow:visible;">
            
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="CUSTitleLabel" class="requiredlabel">Cause:</div>
                    <div id="CUSTitleField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="CUSTTLTxt" runat="server" CssClass="textbox treefield" Width="240px"></asp:TextBox>
                    </div>
                    <div id="CUSTTLlimit" class="textremaining"></div>
                </div>
            
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ParentCauseLabel" class="labeldiv">Related to Cause:</div>
                    <div id="ParentCauseField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="PCUSTxt" runat="server" ReadOnly="true" CssClass="readonly" Width="240px"></asp:TextBox>
                    </div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="CUSDetailsLabel" class="labeldiv">More Information:</div>
                    <div id="CUSDetailsField" class="fielddiv" style="width:400px; height:190px;">
                        <asp:TextBox ID="CUSDTLTxt" runat="server" CssClass="textbox treefield" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
            </div>  
        </div>    
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="header" class="modalHeader">Finding Type Details<span id="close" class="modalclose" title="Close">X</span></div>
        
         <div id="validation_dialog_popup" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="popup" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="FindingTYPLabel" class="requiredlabel">Finding Type:</div>
            <div id="FindingTYPField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="FNDTYPTxt" runat="server" Width="240px" CssClass="textbox"></asp:TextBox>
            </div>

            <asp:RequiredFieldValidator ID="FNDTYPTxtVal" runat="server" Display="None" ValidationGroup="popup" ControlToValidate="FNDTYPTxt" ErrorMessage="Enter finding type"></asp:RequiredFieldValidator>
        
            <asp:CustomValidator id="FNDTYPTxtFVal" runat="server" ValidationGroup="popup" 
            ControlToValidate = "FNDTYPTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>    
         </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="popup" 
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
    
        <div class="buttondiv">
            <input id="savefindingtype" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>   

    </asp:Panel>


    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

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

        addWaterMarkText('Additional Details in the Support of the Finding', '#<%=DTLTxt.ClientID%>');

        /*attach finding description to limit plugin*/
        $("#<%=FDESCTxt.ClientID%>").limit({ id_result: 'DESClimit', alertClass: 'alertremaining' });

        navigate("Details");

        /*Deactivate all controls*/
        ActivateAll(false);

        /*Deactivate tree fields*/
        ActivateTreeField(false);

        $("#deletefilter").bind('click', function ()
        {
            hideAll();
            refreshAudits(empty);
        });

        /* Undo any loaded cause tree by refrshing it with a new and default tree*/
        $("#undo").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to undo all modified causes?");
            if (result == true)
            {
                refreshCauses();
                loadRootCauses();
            }
        });

        $("#byPLNAUDT").bind('click', function ()
        {
            hideAll();
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#AuditDateContainer").show();
        });

        $("#<%=AUDTIDSRCH.ClientID%>").bind('click', function ()
        {
            refreshAudits(empty);
            $("#SearchAudit").show();
        });

        $("#closeBox").bind('click', function () {
            $("#SearchAudit").hide('800');
        });


        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#cancel").trigger('click');
            }
        });

        $("#savefindingtype").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('popup');
            if (isPageValid)
            {
                if (!$("#validation_dialog_popup").is(":hidden")) {
                    $("#validation_dialog_popup").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    var findingtype =
                    {
                        TypeName: $("#<%=FNDTYPTxt.ClientID%>").val(),
                        Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json",
                        dataType: "json",
                        data: "{'json':'" + JSON.stringify(findingtype) + "'}",
                        url: getServiceURL().concat('createFindingType'),
                        success: function (data) {
                            refreshFindingType();

                            $("#cancel").trigger('click');
                        },
                        error: function (xhr, status, error) {
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        }
                    });
                }

            }
            else
            {
                $("#validation_dialog_popup").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                filterAudit(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                filterAudit($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#save").bind('click', function ()
        {
            var isIDValid = Page_ClientValidate("ID");
            if (isIDValid)
            {
                var isPageValid = Page_ClientValidate('General');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_general").is(":hidden"))
                    {
                        $("#validation_dialog_general").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $find('<%= SaveExtender.ClientID %>').show();

                        var finding =
                        {
                            Finding: $("#<%=FDESCTxt.ClientID%>").val(),
                            FindingType: $("#<%=FNDTYPCBox.ClientID%>").find('option:selected').text(),
                            Details: $("#<%=DTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DTLTxt.ClientID%>").val()),
                            Causes: JSON.parse($('#causetree').tree('toJson')),
                            CheckList: getChecklistJSON()
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'json':'" + JSON.stringify(finding) + "','auditno':'" + $("#<%=AUDTIDTxt.ClientID%>").val() + "'}",
                            url: getServiceURL().concat('createFinding'),
                            success: function (data)
                            {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                alert(data.d);

                                reset();

                                navigate("Details");

                                refreshCauses();

                                /*restore watermarks*/
                                addWaterMarkText('Additional Details in the Support of the Finding', '#<%=DTLTxt.ClientID%>');

                                /*Deactivate all controls*/
                                ActivateAll(false);

                                $("#ISOCHK").empty();

                                $(".textbox").each(function ()
                                {
                                    $(this).keyup();
                                });
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
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                    {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                        navigate('Details');
                    });
                }
            }
            else
            {
                alert('Please enter or select the ID of the audit');
            }
        });

        $("#<%=FNDTYPADD.ClientID%>").bind('click', function ()
        {
            $("#<%=FNDTYPTxt.ClientID%>").val('');
            $("#<%=DESCTxt.ClientID%>").val('');

            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == false)
            {
                addWaterMarkText('Description of the finding type', '#<%=DESCTxt.ClientID%>');
            }
            
            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#<%=FDTTxt.ClientID%>").keyup(function ()
        {
            filterAudit($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function ()
        {
            filterAudit($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=RTCAUSCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var vals = $(this).val().split(" ");

                loadCauses(parseInt(vals[1]));
            }
        });


        $("#<%=AUDTIDTxt.ClientID%>").keydown(function (event)
        {
            var $obj = $(this);

            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13')
            {
                var text = $(this).val();

                $("#AUDTID_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $(".modulewrapper").css("cursor", "wait");

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json",
                        dataType: "json",
                        data: "{'auditno':'" + text + "'}",
                        url: getServiceURL().concat('getAudit'),
                        success: function (data) 
                        {
                            $("#AUDTID_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                var xml = $.parseXML(data.d);

                                var auditstatus = $(xml).find('AuditRecord').attr('AuditStatusString');
                                if (auditstatus == 'Completed' || auditstatus == 'Cancelled')
                                {
                                    alert("Cannot create finding record on " + auditstatus + " audit");

                                    $("#<%=AUDTIDTxt.ClientID%>").val('');

                                    ActivateAll(false);

                                    /*trigger finding description keyup event*/
                                    $("#<%=FDESCTxt.ClientID%>").keyup();

                                }
                                else {
                                    loadISOChecklist(text);
                                    refreshFindingType();
                                    refreshCauses();

                                    ActivateAll(true);

                                    /*load all root causes*/
                                    loadRootCauses();

                                    /*attach finding description to limit plugin*/
                                    $("#<%=FDESCTxt.ClientID%>").limit({ id_result: 'DESClimit', alertClass: 'alertremaining' });


                                }
                            });

                        },
                        error: function (xhr, status, error)
                        {
                            $("#AUDTID_LD").fadeOut(500, function () {

                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);

                                $("#<%=AUDTIDTxt.ClientID%>").val('');

                                ActivateAll(false);

                                /*trigger finding description keyup event*/
                                $("#<%=FDESCTxt.ClientID%>").keyup();

                                /*clear number of character values of the tree fields*/
                                $("#CUSTTLlimit").html('');
                            });
                        }
                    });
                });
            }
        });


        $("#tabul li").bind("click", function () {
            var isCausesValid = Page_ClientValidate('Causes');
            if (isCausesValid) {
                navigate($(this).attr("id"));
            }
            else {
                alert('Please make sure that the details of the cause name is in the correct format');
                return false;
            }

        });

        $("#new").bind('click', function ()
        {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                $("#causetree").tree('appendNode',
                {
                    name: 'new sub cause',
                    Description: '',
                    Status: 3
                }, node);
            }
            else {
                alert('Please select a cause');
            }
        });


        $("#delete").bind('click', function ()
        {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false)
            {

                if (node.children.length > 0) {
                    alert("Cannot remove the cause (" + node.name + ") because there is/are (" + node.children.length + ") assciated sub cause(s) which must be removed first");
                }
                else if (node.getLevel() == 1) {
                    alert("At least a main cause should be included when creating a finding for a particular audit");
                }
                else
                {
                    if (node.Status == 3)
                    {
                        $('#causetree').tree('removeNode', node);

                        ActivateTreeField(false);

                        /*clear number of character values of the tree fields*/
                        $("#CUSTTLlimit").html('');
                    }
                    else
                    {
                        removeCause(node);
                    }
                }
            }
            else
            {
                alert('Please select a cause');
            }
        });

        /*bind the details of the selected node*/
        $('#causetree').bind('tree.select', function (event) { // The clicked node is 'event.node'
            var node = event.node;

            if (node != null && node != false) {
                var isPageValid = Page_ClientValidate('Causes');
                if (isPageValid)
                {
                    /*activate all textboxes in the causes menu*/
                    ActivateTreeField(true);

                    $("#<%=CUSTTLTxt.ClientID%>").val(node.name);
                    $("#<%=PCUSTxt.ClientID%>").val(node.parent.name);
                    $("#<%=CUSDTLTxt.ClientID%>").html(node.Description).text();


                    /*attach finding description to limit plugin*/
                    $("#<%=CUSTTLTxt.ClientID%>").limit({ id_result: 'CUSTTLlimit', alertClass: 'alertremaining', limit: 100 });

                }
                else
                {
                    alert("Please make sure that the details of the cause name is in the correct format");
                    event.preventDefault();
                }
            }
        });

        $("#<%=CUSTTLTxt.ClientID%>").keyup(function (event) {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if ($(this).val() != '')
                {
                    if (node.Status == 3) {
                        $('#causetree').tree('updateNode', node, { name: $(this).val() });
                    }
                    else
                    {
                        $('#causetree').tree('updateNode', node, { name: $(this).val(), Status: 2 });
                    }
                }
            }
            else
            {
                event.preventDefault();
            }
        });
        $("#<%=CUSDTLTxt.ClientID%>").keyup(function (event)
        {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if (node.Status == 3)
                {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()) });
                }
                else
                {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()), Status: 2 });
                }
            }
            else
            {
                event.preventDefault();
            }
        });
    });

    function loadRootCauses()
    {
        $("#RTCAUS_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRootCauses"),
                success: function (data)
                {
                    $("#RTCAUS_LD").fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Causes', 'name', $("#<%=RTCAUSCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RTCAUS_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadCauses(ID)
    {
        $("#CAUSwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            /*Deactivate all textboxes in the causes*/
            ActivateTreeField(false);

            /*clear number of character values of the tree fields*/
            $("#CUSTTLlimit").html('');


            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeid':'" + ID + "'}",
                url: getServiceURL().concat('loadChildCauseTree'),
                success: function (data)
                {
                    $("#CAUSwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var existingjson = $('#causetree').tree('toJson');
                        if (existingjson == null) {
                            $('#causetree').tree(
                            {
                                data: $.parseJSON(data.d),
                                slide: true,
                                autoOpen: true
                            });
                        }
                        else {
                            $('#causetree').tree('loadData', $.parseJSON(data.d));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#CAUSwait").fadeOut(500, function ()
                    {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function removeCause(selectednode)
    {
        var result = confirm("Are you sure you would like to remove the selected cause?");
        if (result == true)
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeID':'" + selectednode.CauseID + "'}",
                url: getServiceURL().concat('removeCause'),
                success: function (data)
                {
                    var vals = $("#<%=RTCAUSCBox.ClientID%>").val().split(" ");
                    loadCauses(parseInt(vals[1]));
                },
                error: function (xhr, status, error)
                {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
    }

    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
            $(".groupbox").children().each(function ()
            {
                $(this).find('.textbox').each(function ()
                {
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

                $(".imgButton").each(function () {
                    $(this).attr("disabled", true);

                });

                $(".textremaining").each(function () {
                    $(this).html('');
                });
            });


            $('#save').attr("disabled", true);
        }
        else
        {
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
   
    function getChecklistJSON() {
        var checklist = null;

        $("#ISOCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function (index, value) {
                if ($(value).is(":checked") == true) {
                    checklist =
                    {
                        ISOProcessID: $(value).val(),
                        name: $(value).attr('id')
                    };
                }
            });
        });

        return checklist;
    }

    function refreshCauses()
    {

        /*Deactivate tree fields*/
        ActivateTreeField(false);

        /*clear number of character values of the tree fields*/
        $("#CUSTTLlimit").html('');

        var cause =
        [{
            name: 'new root cause',
            description: '',
            Status: 3,
            children:
            [
                { name: 'new sub cause', description: '', Status: 3 }
            ]
        }];

        var existingjson = $('#causetree').tree('toJson');
        if (existingjson == null) {
            $('#causetree').tree(
            {
                data: cause,
                slide: true,
                autoOpen: true
            });
        }
        else {
            $('#causetree').tree('loadData', cause);
        }

    }
  
    function refreshFindingType()
    {
        $("#FNDTYP_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadFindingType"),
                success: function (data)
                {
                    $("#FNDTYP_LD").fadeOut(500, function () {

                        var xml = $.parseXML(data.d);

                        loadComboboxXML(xml, 'ActionFindingType', 'TypeName', '#<%=FNDTYPCBox.ClientID%>');
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#FNDTYP_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadISOChecklist(auditno)
    {
        $("#ISO_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'auditno':'" + auditno + "'}",
                url: getServiceURL().concat("loadISOChecklist"),
                success: function (data)
                {
                    $("#ISO_LD").fadeOut(500, function ()
                    {
                        if (data) {
                            var checklist = JSON.parse(data.d);
                            var html = '';

                            $("#ISOCHK").empty();

                            $(checklist).each(function (index, value) {
                                html += "<div class='checkitem'>";
                                html += "<input type='radio' id='" + value.name + "' name='checklist' value='" + value.ISOProcessID + "'/><div class='checkboxlabel'>" + value.name + "</div>";
                                html += "</div>";
                            });

                            $("#ISOCHK").append(html);
                        }
                        else {
                            $("#ISOCHK").empty();
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ISO_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function filterAudit(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true)
        {
  
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

                            loadGridView(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function ()
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
    function refreshAudits(empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
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

                        loadGridView(data.d, empty);
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

        $("#<%=gvAudits.ClientID%> tr").not($("#<%=gvAudits.ClientID%> tr:first-child")).each(function () {
            $(this).bind('click', function () {

                $("#SearchAudit").hide('800');

                $("#<%=AUDTIDTxt.ClientID%>").val($("td", $(this)).eq(0).html());

                var e = jQuery.Event("keydown");
                e.which = 13; // # Some key code value
                $("#<%=AUDTIDTxt.ClientID%>").trigger(e);

            });
        });

    }
   

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function ActivateTreeField(isactive) {
        if (isactive == false) {
            $(".treefield").each(function ()
            {
                $(this).val('');
                $(this).removeClass("textbox");
                $(this).addClass("readonly");
                $(this).attr('readonly', true);
            });

            $(".textremaining").each(function () {
                $(this).html('');
            });
        }
        else {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("readonly");
                $(this).addClass("textbox");
                $(this).attr('readonly', false);
            });
        }
    }
    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>