﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="EditFinding.aspx.cs" Inherits="QMSRSTools.AuditManagement.EditFinding" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="FND_Header" class="moduleheader">Manage Findings</div>

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
   
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byAUDTTYP">Filter by Audit Type</li>
                <li id="byAUDTSTS">Filter by Audit Status</li>
                <li id="byAUDTDT">Filter by Planned Audit Date</li>
            </ul>
        </div>

        <div id="PlannedDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
            <div id="StartDateLabel" style="width:120px;">Planned Audit Date:</div>
            <div id="StartDateField" style="width:270px; left:0; float:left;">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>
    
        <div id="AuditTypeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AuditTypeFLabel" style="width:100px;">Audit Type:</div>
            <div id="AudittypeFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="AUDTTYPFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ADTFTYP_LD" class="control-loader"></div>
        </div>

        <div id="AuditStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AuditStatusFLabel" style="width:100px;">Audit Status:</div>
            <div id="AuditStatusFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="AUDTSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ADTFSTS_LD" class="control-loader"></div>
        </div>

    </div>

    <div id="FNDwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="FindingScrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvFinding" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="AuditID" HeaderText="Audit No." />
                <asp:BoundField DataField="AuditType" HeaderText="Audit Type" />
                <asp:BoundField DataField="PlannedAuditDate" HeaderText="Planned Audit Date" />
                <asp:BoundField DataField="Finding" HeaderText="Finding" />
                <asp:BoundField DataField="FindingType" HeaderText="Finding Type" />
                <asp:BoundField DataField="ISOChecklist" HeaderText="Related ISO Checklist" />
                <asp:BoundField DataField="AuditStatus" HeaderText="Audit Status" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="FindingHeader" class="modalHeader">Finding Details<span id="FindingClose" class="modalclose" title="Close">X</span></div>

        <div id="FindingTooltip" class="tooltip">
            <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <ul id="tabul">
                <li id="Details" class="ntabs">Details</li>
                <li id="Causes" class="ntabs">Related Causes</li>
            </ul>
            <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">
            
                <div id="validation_dialog_general" style="display: none">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
                </div>
                
                <input id="FNDID"  type="hidden" value="" />
            
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="FindingDescriptionLabel" class="requiredlabel">Finding:</div>
                    <div id="FindingDescriptionField" class="fielddiv" style="width:250px">
                        <asp:TextBox ID="FDESCTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                    </div>
                
                    <div id="DESClimit" class="textremaining"></div>
         
                    <asp:RequiredFieldValidator ID="FDESCVal" runat="server" Display="Dynamic" ControlToValidate="FDESCTxt" ErrorMessage="Enter the details of the finding" CssClass="validator" ValidationGroup="General"></asp:RequiredFieldValidator>   

                    <asp:CustomValidator id="FDESCTxtFVal" runat="server" ValidationGroup="General" 
                    ControlToValidate = "FDESCTxt" CssClass="validator" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator>
                </div>        
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="FindingTypeLabel" class="requiredlabel">Finding Type:</div>
                    <div id="FindingTypeField" class="fielddiv" style="width:250px">
                        <asp:DropDownList ID="FNDTYPCBox" AutoPostBack="false" runat="server" Width="230px" CssClass="combobox">
                        </asp:DropDownList>    
                    </div>
                
                    <div id="FNDTYP_LD" class="control-loader"></div>
  
                    <asp:RequiredFieldValidator ID="FNDTYPEMPTVal" runat="server" Display="Dynamic" ErrorMessage="Select finding type" ControlToValidate="FNDTYPCBox" CssClass="validator" ValidationGroup="General">
                    </asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="FNDTYPVal" runat="server" ControlToValidate="FNDTYPCBox" CssClass="validator"
                    Display="Dynamic" ErrorMessage="Select finding type" Operator="NotEqual" Style="position: static" ValidationGroup="General"
                    ValueToCompare="0"></asp:CompareValidator>
                </div>
                
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="FindingDetailsLabel" class="labeldiv">Additional Details:</div>
                    <div id="FindingDetailsField" class="fielddiv" style="width:400px">
                        <asp:TextBox ID="DTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                
                    <asp:CustomValidator id="DTLTxtVal" runat="server" ValidationGroup="General" 
                    ControlToValidate = "DTLTxt" CssClass="validator" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                    ClientValidationFunction="validateSpecialCharactersLongText">
                    </asp:CustomValidator>
                </div>
            
                <div style="float:left; width:100%; height:20px; margin-top:121px;">
                    <div id="ISOClauseLabel" class="labeldiv">Select ISO Clause:</div>
                    <div id="ISOClauseField" class="fielddiv" style="width:250px">
                        <div id="ISOCHK" class="checklist" style="height:120px;"></div>
                    </div>
                    <div id="ISO_LD" class="control-loader"></div>
                </div>
            </div>
            <div id="CausesTB" class="tabcontent" style="display:none; height:450px;">
                <div class="toolbox">
                    <img id="undo" src="../Images/undo.png" class="imgButton" title="Undo Causes" alt="" />
                    <img id="delete" src="../Images/deletenode.png" alt="" class="imgButton" title=""/>
                    <img id="new" src="../Images/new_file.png" alt="" class="imgButton" title=""/> 

                    <div id="RootCauseContainer" style=" float:left;width:400px; margin-left:10px; height:20px; margin-top:3px;">
                        <div id="RootCauseLabel" style="width:100px;">Root Cause:</div>
                        <div id="RootCauseField" style="width:250px; left:0; float:left;">
                            <asp:DropDownList ID="RTCAUSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="RTCAUS_LD" class="control-loader"></div>
                    </div>
                </div>
                <div id="treemenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible; height:365px;">
                    <div id="CAUSwait" class="loader">
                        <div class="waittext">Please Wait...</div>
                    </div>
                    
                    <div id="causetree"></div>
                </div>
                <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; overflow:visible; height:365px;">
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
                        <div id="CUSDetailsField" class="fielddiv" style="width:350px;">
                            <asp:TextBox ID="CUSDTLTxt" runat="server" CssClass="textbox treefield" Width="340px" Height="75px" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>
    
    <input id="auditno" type="hidden" value="" /> 
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvFinding.ClientID%> tr:last-child").clone(true);

        /*load all findings in the system*/
        loadFindings(empty);

        $("#deletefilter").bind('click', function () {
            hideAll();
            loadFindings(empty);
        });

        $("#refresh").bind('click', function () {
            hideAll();
            loadFindings(empty);
        });

        $("#byAUDTDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#PlannedDateContainer").show();
        });

        /*close modal popup extender*/
        $("#FindingClose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#findingcancel").trigger('click');
            }
        });

        $("#byAUDTTYP").bind('click', function () {
            hideAll();
            /*load audit type*/
            loadComboboxAjax('loadAuditType', '#<%=AUDTTYPFCBox.ClientID%>', "#ADTFTYP_LD");

            $("#AuditTypeContainer").show();
        });

        /*filter by audit type*/
        $("#<%=AUDTTYPFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByAuditType($(this).val(), empty);
            }
        });

        $("#byAUDTSTS").bind('click', function () {
            hideAll();
            /*load audit status*/
            loadComboboxAjax('loadAuditStatus', '#<%=AUDTSTSFCBox.ClientID%>', "#ADTFSTS_LD");

            $("#AuditStatusContainer").show();
        });

        /*filter by audit status*/
        $("#<%=AUDTSTSFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByAuditStatus($(this).val(), empty);
            }
        });

        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterAuditByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(),empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterAuditByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
           inline: true,
           dateFormat: "dd/mm/yy",
           onSelect: function (date) {
               filterAuditByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
           }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterAuditByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        /* Undo any loaded cause tree by refrshing it with a new and default tree*/
        $("#undo").bind('click', function () {
            var result = confirm("Are you sure you would like to undo all modified causes?");
            if (result == true)
            {
                /*load original cause tree*/
                bindCauses($("#FNDID").val());

                loadRootCauses();
            }
        });

        $("#<%=RTCAUSCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var vals = $(this).val().split(" ");

                loadCauses(parseInt(vals[1]));
            }
        });

        //bind the details of the selected node
        $('#causetree').bind('tree.select', function (event) {
            // The clicked node is 'event.node'
            var node = event.node;

            if (node != null && node != false)
            {
                var isPageValid = Page_ClientValidate('Causes');
                if (isPageValid) {

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
            if (node != null && node != false) {
                if ($(this).val() != '') {
                    if (node.Status == 3) {
                        $('#causetree').tree('updateNode', node, { name: $(this).val() });
                    }
                    else {
                        $('#causetree').tree('updateNode', node, { name: $(this).val(), Status: 2 });
                    }
                }
                else {
                    alert("Cannot accept empty values");
                    event.preventDefault();
                }
            }
            else {
                alert('Please select a cause');
            }
        });

        $("#<%=CUSDTLTxt.ClientID%>").keyup(function (event) {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status == 3) {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()) });
                }
                else {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()), Status: 2 });
                }
            }
            else {
                alert('Please select a cause');
            }
        });

        $("#new").bind('click', function () {
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

        $("#delete").bind('click', function () {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.children.length > 0) {
                    alert("There are (" + node.children.length + ") assciated sub cause(s) which require removal first!");
                }
                else if (node.getLevel() == 1) {
                    alert("At least a main cause should be included when creating a finding for a particular audit");
                }
                else {
                    if (node.Status == 3) {
                        $('#causetree').tree('removeNode', node);
                    }
                    else {
                        removeFindingCause(node, parseInt($("#FNDID").val()));
                    }

                    ActivateTreeField(false);

                    /*clear number of character values of the tree fields*/
                    $("#CUSTTLlimit").html('');
                }
            }
            else
            {
                alert('Please select a cause');
            }
        });
        $("#tabul li").bind("click", function () {
            var isCausesValid = Page_ClientValidate('Causes')
            if (isCausesValid) {
                navigate($(this).attr("id"));
            }
            else {
                alert('Please make sure that the details of the cause name is in the correct format');
                return false;
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('General');
            if (isPageValid)
            {
                if (!$("#validation_dialog_general").is(":hidden"))
                {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        var finding =
                        {
                            FindingID: $("#FNDID").val(),
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
                            data: "{\'json\':\'" + JSON.stringify(finding) + "\'}",
                            url: getServiceURL().concat('updateFinding'),
                            success: function (data)
                            {
                                $("#SaveTooltip").fadeOut(500, function ()
                                {
                                    ActivateSave(true);

                                    $("#cancel").trigger('click');
                                    $("#refresh").trigger('click');
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#SaveTooltip").fadeOut(500, function ()
                                {
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
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    navigate('Details');
                });
            }
        });

    });
    function getChecklistJSON() {
        var checklist = {};
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
    function filterAuditByDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {

            $("#FNDwait").stop(true).hide().fadeIn(500, function ()
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
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('loadFindingByPlannedAuditDate'),
                    success: function (data) {
                        $("#FNDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadFindingGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FNDwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }
    function filterByAuditStatus(status, empty) {
        $("#FNDwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat('loadFindingByAuditStatus'),
                success: function (data)
                {
                    $("#FNDwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");
                        loadFindingGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FNDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterByAuditType(type, empty) {
        $("#FNDwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('loadFindingByAuditType'),
                success: function (data) {
                    $("#FNDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadFindingGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FNDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadFindings(empty)
    {
        $("#FNDwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                url: getServiceURL().concat('loadFinding'),
                success: function (data)
                {
                    $("#FNDwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        loadFindingGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#FNDwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function refreshAudits() {
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

                        loadAuditGridView(data.d);
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

    function loadFindingGridView(data, empty)
    {
        var xmlAudits = $.parseXML(data);

        var row = empty;

        $("#<%=gvFinding.ClientID%> tr").not($("#<%=gvFinding.ClientID%> tr:first-child")).remove();

        $(xmlAudits).find('AuditRecord').each(function (i, audit)
        {
            var xmlFinding = $.parseXML($(this).attr('RelatedXmlFindings'));

            $(xmlFinding).find("AuditFinding").each(function (index, finding) {
                $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton'/>");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html($(audit).attr("AuditNo"));
                $("td", row).eq(3).html($(audit).attr("AuditType"));
                $("td", row).eq(4).html(new Date($(audit).attr("PlannedAuditDate")).format("dd/MM/yyyy"));
                $("td", row).eq(5).html(shortenText($(this).attr("Finding")));
                $("td", row).eq(6).html($(this).attr("FindingType"));
                $("td", row).eq(7).html($(this).attr("ISOChecklistString") == '' ? '' : $(this).attr("ISOChecklistString"));
                $("td", row).eq(8).html($(audit).attr("AuditStatusString"));

                $("#<%=gvFinding.ClientID%>").append(row);

                $(row).find('img').each(function () {
                    if ($(this).attr('id').search('edit') != -1) {
                        $(this).bind('click', function () {
                            $("#validation_dialog_general").hide();

                            /*load causes tree*/
                            bindCauses($(finding).attr('FindingID'));

                            /*load iso standards*/
                            loadISOChecklist($(audit).attr("AuditNo"), ($(finding).attr("ISOChecklistString") == '' ? '' : $(finding).attr("ISOChecklistString")));

                            /*bind the ID of the finding*/
                            $("#FNDID").val($(finding).attr('FindingID'));

                            /*bind the description of the finding*/
                            $("#<%=FDESCTxt.ClientID%>").val($(finding).attr('Finding'));

                            /*bind the type of the finding*/
                            bindFindingType($(finding).attr('FindingType'));

                            /*bind the details of the finding*/
                            if ($(finding).attr("Details") == '') {
                                addWaterMarkText('Additional Details in the Support of the Finding', '#<%=DTLTxt.ClientID%>');
                            }
                            else {
                                if ($("#<%=DTLTxt.ClientID%>").hasClass("watermarktext")) {
                                    $("#<%=DTLTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=DTLTxt.ClientID%>").html($(finding).attr("Details")).text();
                            }

                            /*attach finding description to limit plugin*/
                            $("#<%=FDESCTxt.ClientID%>").limit({ id_result: 'DESClimit', alertClass: 'alertremaining' });

                            /*trigger finding description keyup event*/
                            $("#<%=FDESCTxt.ClientID%>").keyup();

                            /*load all root causes*/
                            loadRootCauses();

                            /*Deactivate tree fields*/
                            ActivateTreeField(false);

                            /*navigate to the first TAB*/
                            navigate('Details');

                            if ($(audit).attr('AuditStatusString') == 'Completed' || $(audit).attr('AuditStatusString') == 'Cancelled') {
                                $("#FindingTooltip").find('p').text("Changes cannot take place since the audit is " + $(audit).attr('AuditStatusString'));

                                if ($("#FindingTooltip").is(":hidden")) {
                                    $("#FindingTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else {
                                $("#FindingTooltip").hide();

                                /*enable all modal controls for editing*/
                                ActivateAll(true);
                            }

                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                    else if ($(this).attr('id').search('delete') != -1) {
                        $(this).bind('click', function () {
                            removeAuditFinding($(finding).attr('FindingID'), empty);
                        });
                    }
                });
                row = $("#<%=gvFinding.ClientID%> tr:last-child").clone(true);

            });
        });

    }

    function loadRootCauses()
    {
        $("#RTCAUS_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRootCauses"),
                success: function (data)
                {
                    $("#RTCAUS_LD").fadeOut(500, function ()
                    {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Causes', 'name', $("#<%=RTCAUSCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
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
                    $("#CAUSwait").fadeOut(500, function () {

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
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }


    function bindFindingType(value)
    {
        $("#FNDTYP_LD").stop(true).hide().fadeIn(500, function () {
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

                        bindComboboxXML(xml, 'ActionFindingType', 'TypeName', value, '#<%=FNDTYPCBox.ClientID%>');
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

    function ActivateAll(isactive) {
        if (isactive == false) {
            $(".modalPanel").children().each(function () {
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

                $(this).find('.groupbox').each(function () {
                    $(this).attr('disabled', true);
                });

            });

            $('#save').attr("disabled", true);
            $("#save").css({ opacity: 0.5 });
        }
        else {
            $(".modalPanel").children().each(function () {

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

                $(this).find('.groupbox').each(function () {
                    $(this).attr('disabled', false);
                });

            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }

    function loadISOChecklist(auditno, isoname)
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

                            $("#ISOCHK").empty();

                            $(checklist).each(function (index, value) {
                                var sb = new StringBuilder('');

                                sb.append("<div class='checkitem'>");
                                sb.append("<input type='radio' id='" + value.name + "' name='checklist' value='" + value.ISOProcessID + "' /><div class='checkboxlabel'>" + value.name + "</div>");
                                sb.append("</div>");

                                $("#ISOCHK").append(sb.toString());
                            });

                            $("#ISOCHK").children(".checkitem").each(function () {
                                $(this).find('input').each(function (index, value) {
                                    if ($(value).attr('id') == isoname) {
                                        $(value).prop('checked', true);
                                    }
                                });
                            });
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
    function bindCauses(ID)
    {
        $("#CAUSwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modalPanel").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'findingid':'" + ID + "'}",
                url: getServiceURL().concat('loadFindingCauses'),
                success: function (data)
                {
                    $("#CAUSwait").fadeOut(500, function ()
                    {
                        $(".modalPanel").css("cursor", "default");

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
                    $("#CAUSwait").fadeOut(500, function () {
                        $(".modalPanel").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function removeFindingCause(selectednode, findingid)
    {
        var result = confirm("Are you sure you would like to remove the selected cause?");
        if (result == true) {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeID':'" + selectednode.CauseID + "'}",
                url: getServiceURL().concat('removeCause'),
                success: function (data) {
                    bindCauses(findingid);
                },
                error: function (xhr, status, error) {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
    }

    function removeAuditFinding(ID, empty)
    {
        var result = confirm("Removing finding record might cause any associated actions to be removed, as well as any its corresponsing causes and actions, do you want to continue?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'findingid':'" + ID + "'}",
                url: getServiceURL().concat('removeFinding'),
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
    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
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

    function ActivateTreeField(isactive) {
        if (isactive == false) {
            $(".treefield").each(function () {
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
</script>

</asp:Content>