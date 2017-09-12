<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageRiskFormulas.aspx.cs" Inherits="QMSRSTools.RiskManagement.ManageRiskFormulas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="RISKFORM_Header" class="moduleheader">Manage Risk Formulas</div>
      
    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="new" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Add New Formula" alt=""/>    
      
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byRiskType">Filter by Risk Type</li>
            </ul>
        </div>
    </div>

    <div id="RiskTypeContainer" class="filter" >
        <div id="RiskTypeFilterLabel" class="filterlabel">Risk Type:</div>
        <div id="RiskTypeFilterField" class="filterfield">
            <asp:DropDownList ID="RSKTYPFCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
         </div>
         <div id="RSKTYPF_LD" class="control-loader"></div>
    </div>
      
    <div id="formulaloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="FormulaScrollbar" class="gridscroll">
        <asp:GridView id="gvFormula" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="FormulaID" HeaderText="ID" />
            <asp:BoundField DataField="Formula" HeaderText="Formula" />
            <asp:BoundField DataField="RiskType" HeaderText="Risk Type" />
        </Columns>
        </asp:GridView>
    </div>

     
    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel" style="height:550px;">
        <div id="header" class="modalHeader">Formula Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
    
        <div id="validation_dialog_formula">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Formula" />
        </div>

        <input id="FormulaID" type="hidden" value="" />


        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="RiskTypeLabel" class="requiredlabel">Risk Type:</div>
            <div id="RiskTypeField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="RSKTYPCBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="RSKTYP_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="RSKTYPVal" runat="server" Display="None" ControlToValidate="RSKTYPCBox" ErrorMessage="Select a Risk Type" ValidationGroup="Formula"></asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="RSKTYPTxtVal" runat="server" ControlToValidate="RSKTYPCBox"
            Display="None" ErrorMessage="Select a Risk Type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Formula"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="FormulaMenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible; height:390px; width:37%">
                <div style="float:left; width:100%; height:20px; margin-top:2px;">
                    <div id="AttributeLabel" class="labeldiv" style="width:80px;">Attribute:</div>
                    <div id="AttributeField" class="fielddiv" style="width:150px;">
                        <asp:DropDownList ID="ATTRCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="ATTR_LD" class="control-loader"></div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="OperatorLabel" class="labeldiv" style="width:80px;">Operator:</div>
                    <div id="OperatorField" class="fielddiv" style="width:150px;">
                        <asp:DropDownList ID="OPRCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="OPR_LD" class="control-loader"></div>
                </div>
            </div>

            <div id="FormulaContainer" class="modulecontainer" style="border: 1px solid #052556; overflow:visible; height:390px; width:60%;">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="SyntaxLabel" class="requiredlabel">Formula Syntax:</div>
                    <div id="SyntaxField" class="fielddiv" style="width:400px; height:190px;">
                        <asp:TextBox ID="SNTXTxt" runat="server" CssClass="textbox" Width="390px" Height="187px" style="text-align:left; direction:ltr;" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="SYNTXVal" runat="server" Display="None" ControlToValidate="SNTXTxt" ErrorMessage="Build the Risk Formula" ValidationGroup="Formula"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
    
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <asp:Button ID="alias" runat="server" style="visibility:hidden" />

    <ajax:ModalPopupExtender ID="FormulaExtender" BehaviorID="FormulaExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" BackgroundCssClass="modalBackground" CancelControlID="cancel">
    </ajax:ModalPopupExtender>

    <input id="MODE" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvFormula.ClientID%> tr:last-child").clone(true);

        loadFormulas(empty);

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#<%=ATTRCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                attachAttribute($(this).val(), "#<%=SNTXTxt.ClientID%>", $("#<%=RSKTYPCBox.ClientID%>").val());
                $(this).val(0);
            }
        });

        $("#<%=OPRCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {
                addText($(this).val(), "#<%=SNTXTxt.ClientID%>");
                $(this).val(0);
            }
        });

        $("#new").bind('click', function ()
        {
            /* clear all text and combo fields*/
            resetGroup(".modalPanel");

            if ($("#MODE").val() != 'ADD')
                $("#MODE").val('ADD');

            $("#<%=ATTRCBox.ClientID%>").empty();
            $("#<%=OPRCBox.ClientID%>").empty();

            loadComboboxAjax('loadRiskType', "#<%=RSKTYPCBox.ClientID%>", "#RSKTYP_LD");
            $("#<%=alias.ClientID%>").trigger('click');

        });

        $("#<%=RSKTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var typeparam = "'risktype':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=ATTRCBox.ClientID%>");
                       
                loadParamComboboxAjax('loadRiskParameters', loadcontrols, typeparam, "#ATTR_LD");

                loadComboboxAjax('loadOperators', "#<%=OPRCBox.ClientID%>", "#OPR_LD");
            }
        });

        $("#refresh").bind('click', function () {
            hideAll();

            loadFormulas(empty);
        });


        $("#byRiskType").bind('click', function ()
        {
            hideAll();

            loadComboboxAjax('loadRiskType', "#<%=RSKTYPFCBox.ClientID%>", "#RSKTYPF_LD");
            $("#RiskTypeContainer").show();
        });


        $("#<%=RSKTYPFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterFormulasByRiskType($(this).val(), empty);
            }
        });

        $("#save").bind('click', function ()
        {
            var isFormulaValid = Page_ClientValidate('Formula');
            if (isFormulaValid)
            {
                if (!$("#validation_dialog_formula").is(":hidden"))
                {
                    $("#validation_dialog_formula").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD')
                        {
                           var formula =
                           {
                               Formula: $("#<%=SNTXTxt.ClientID%>").val(),
                               RiskType: $("#<%=RSKTYPCBox.ClientID%>").val()
                           }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(formula) + "\'}",
                                url: getServiceURL().concat('createNewRiskFormula'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

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
                        }
                        else if ($("#MODE").val() == 'EDIT')
                        {

                           var formula =
                           {
                               FormulaID: $("#FormulaID").val(),
                               Formula: $("#<%=SNTXTxt.ClientID%>").val(),
                               RiskType: $("#<%=RSKTYPCBox.ClientID%>").val()
                           }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(formula) + "\'}",
                                url: getServiceURL().concat('updateRiskFormula'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

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
                        }
                    });
                }
            }
        });
    });
    
    function filterFormulasByRiskType(type, empty)
    {

        $("#formulaloader").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + type + "'}",
                url: getServiceURL().concat('filterRiskFormulasByType'),
                success: function (data) {
                    $("#formulaloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(empty, data.d);
                    });
                },
                error: function (xhr, status, error) {
                    $("#formulaloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadFormulas(empty) {

        $("#formulaloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadRiskFormulas'),
                success: function (data)
                {
                    $("#formulaloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(empty, data.d);
                    });
                },
                error: function (xhr, status, error) {
                    $("#formulaloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }


    function loadGridView(empty, data)
    {
        var xmlFormulas = $.parseXML(data);

        var row = empty;

        //remove all previous records
        $("#<%=gvFormula.ClientID%> tr").not($("#<%=gvFormula.ClientID%> tr:first-child")).remove();

        $(xmlFormulas).find('RiskFormula').each(function (index, value)
        {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'  />");
      
            $("td", row).eq(2).html($(this).attr("FormulaID"));
            $("td", row).eq(3).html($(this).attr("Formula"));
            $("td", row).eq(4).html($(this).attr("RiskType"));

            $("#<%=gvFormula.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {

                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function ()
                    {
                        removeFormula($(value).attr('FormulaID'));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        /* clear all text and combo fields*/
                        resetGroup(".modalPanel");

                        if ($("#MODE").val() != 'EDIT')
                            $("#MODE").val('EDIT');

                        var typeparam = "'risktype':'" + $(value).attr("RiskType") + "'";
                        var loadcontrols = new Array();

                        loadcontrols.push("#<%=ATTRCBox.ClientID%>");
                        
                        bindComboboxAjax('loadRiskType', "#<%=RSKTYPCBox.ClientID%>", $(value).attr('RiskType'), "#RSKTYP_LD");
                        
                        loadParamComboboxAjax('loadRiskParameters', loadcontrols, typeparam, "#ATTR_LD");

                        loadComboboxAjax('loadOperators', "#<%=OPRCBox.ClientID%>", "#OPR_LD");

                        $("#<%=SNTXTxt.ClientID%>").val($(value).attr('Formula'));

                        $("#FormulaID").val($(value).attr('FormulaID'));

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvFormula.ClientID%> tr:last-child").clone(true);

        });
    }

    function removeFormula(ID)
    {
        var result = confirm("Are you sure you would like to remove the current formula?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'formulaID':'" + ID + "'}",
                url: getServiceURL().concat('removeRiskFormula'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    $("#refresh").trigger('click');
                },
                error: function (xhr, status, error) {

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

    function attachAttribute(param, control, type) {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'parameter':'" + param + "','risktype':'" + type + " '}",
            url: getServiceURL().concat('getFormulaDBAttribute'),
            success: function (data) {
                addText(data.d, control);
            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);
            }
        });
    }

    function addText(value, control) {
        var text = $(control).val();

        if (isNaN(value) == true || (isNaN(value) == false && value.length == 1)) {
            if (text.substring(text.length - 1) != " ") {
                text += " " + $.trim(value);
            }
            else {
                text += $.trim(value);
            }
        }
        else {
            text += $.trim(value.substring(value.length - 1));
        }

        $(control).val(text);
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
