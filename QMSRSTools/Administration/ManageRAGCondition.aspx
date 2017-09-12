<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageRAGCondition.aspx.cs" Inherits="QMSRSTools.Administration.ManageRAGCondition" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="MNGRAG_Header" class="moduleheader">Manage Red, Amber, and Green Indicators (RAG)</div>

    <div class="toolbox">
        <img id="conditionrefresh" src="/Images/refresh.png" class="imgButton" title="" alt="" />
        <img id="newcondition" src="/Images/new_file.png" class="imgButton" title="" alt=""/>    
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <img id="helpfilter" src="/Images/help.png" class="imgButton" alt=""/>
   
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byModule">Filter by Module</li>
                <li id="bySymbol">Filter by RAG Symbol</li>
            </ul>
        </div>
    </div>

    <div id="ModuleContainer" class="filter">
        <div id="ModuleFilterLabel" class="filterlabel">Module Name:</div>
        <div id="ModuleFilterField" class="filterfield">
            <asp:DropDownList ID="MDLFLTRCBox" runat="server" Width="140px" AutoPostBack="false"  CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="MODULF_LD" class="control-loader"></div>
    </div>

    <div id="RAGContainer" class="filter">
        <div id="RAGFilterLabel" class="filterlabel">RAG Symbol:</div>
        <div id="RAGFilterField" class="filterfield">
            <asp:DropDownList ID="RAGFLTRCBox" runat="server" Width="140px" AutoPostBack="false"  CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
        <div id="RAGF_LD" class="control-loader"></div>
    </div>

    <div id="conditionloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="RAGScrollbar" class="gridscroll">
        <asp:GridView id="gvCondition" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="RAGID" HeaderText="ID" />
                <asp:BoundField DataField="Module" HeaderText="Module" />
                <asp:BoundField DataField="Condition" HeaderText="Condition" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel" style="height:550px;">
        <div id="header" class="modalHeader">Condition Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
    
        <div id="validation_dialog_condition">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Condition" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="SelectModuleLabel" class="requiredlabel">Select Module:</div>
            <div id="SelectModuleField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="MODULCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="MODUL_LD" class="control-loader"></div>
        
            <asp:RequiredFieldValidator ID="MODULTxtVal" runat="server" Display="None" ControlToValidate="MODULCBox" ErrorMessage="Select a Module" ValidationGroup="Condition"></asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="MODULDVal" runat="server" ControlToValidate="MODULCBox"
            Display="None" ErrorMessage="Select a Module" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Condition"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="SelectRAGLabel" class="requiredlabel">Select RAG Symbol:</div>
            <div id="SelectRAGField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="RAGCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList> 
            </div>
            <div id="RAG_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="RAGVal" runat="server" Display="None" ControlToValidate="RAGCBox" ErrorMessage="Select a RAG Symbol" ValidationGroup="Condition"></asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="RAGTxtVal" runat="server" ControlToValidate="RAGCBox"
            Display="None" ErrorMessage="Select a RAG Symbol" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Condition"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ConditionMenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible; height:390px; width:37%">
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
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ValueLabel" class="labeldiv" style="width:80px;">Duration:</div>
                    <div id="ValueField" class="fielddiv" style="width:150px;">
                        <asp:TextBox ID="VALTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                    </div>
                </div>
            </div>
            
            <div id="ConditionContainer" class="modulecontainer" style="border: 1px solid #052556; overflow:visible; height:390px; width:60%;">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="SyntaxLabel" class="requiredlabel">Condition Syntax:</div>
                    <div id="SyntaxField" class="fielddiv" style="width:400px; height:190px;">
                        <asp:TextBox ID="SNTXTxt" runat="server" CssClass="textbox" Width="390px" Height="187px" style="text-align:left; direction:ltr;" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="SYNTXVal" runat="server" Display="None" ControlToValidate="SNTXTxt" ErrorMessage="Build an Equation!" ValidationGroup="Condition"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
    
        <div class="buttondiv">
            <input id="OK" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
</asp:Panel>

<asp:Button ID="alias" runat="server" style="visibility:hidden" />

<ajax:ModalPopupExtender ID="ConditionExtender" BehaviorID="ConditionExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" BackgroundCssClass="modalBackground" CancelControlID="cancel">
</ajax:ModalPopupExtender>

<input id="MODE" type="hidden" value="" />
<input id="ConditionID" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvCondition.ClientID%> tr:last-child").clone(true);

        loadConditions(empty);

        
        $("#newcondition").bind('click', function ()
        {
            resetGroup('.modalPanel');


            if ($("#MODE").val() != 'ADD')
                $("#MODE").val('ADD');

            loadComboboxAjax('loadModules', "#<%=MODULCBox.ClientID%>","#MODUL_LD");
            loadComboboxAjax('loadRAGSymbols', "#<%=RAGCBox.ClientID%>", "#RAG_LD");

            $("#<%=alias.ClientID%>").trigger('click');

        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#OK").bind('click', function () {
            var isValid = Page_ClientValidate("Condition");
            if (isValid)
            {
                if (!$("#validation_dialog_condition").is(":hidden")) {
                    $("#validation_dialog_condition").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == "ADD") {
                            var condition =
                            {
                                Module: $("#<%=MODULCBox.ClientID%>").val(),
                                RAG: $("#<%=RAGCBox.ClientID%>").val(),
                                Condition: $("#<%=SNTXTxt.ClientID%>").val()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(condition) + "\'}",
                                url: getServiceURL().concat('createRAGCondition'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);


                                        $("#cancel").trigger('click');
                                        $("#conditionrefresh").trigger('click');
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
                        }
                        else {
                            var condition =
                            {
                                RAGConditionID: $("#ConditionID").val(),
                                Module: $("#<%=MODULCBox.ClientID%>").val(),
                                RAG: $("#<%=RAGCBox.ClientID%>").val(),
                                Condition: $("#<%=SNTXTxt.ClientID%>").val()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(condition) + "\'}",
                                url: getServiceURL().concat('updateRAGCondition'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);


                                        $("#cancel").trigger('click');
                                        $("#conditionrefresh").trigger('click');
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
                        }
                    });
                }
            }
            else
            {
                $("#validation_dialog_condition").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });

        $("#conditionrefresh").bind('click', function ()
        {
            hideAll();
            loadConditions(empty);
        });

        $("#<%=MODULCBox.ClientID%>").change(function () {
            if ($(this).val() != 0)
            {
                var module = "'module':'" + $(this).val() + "'";
                var loadcontrols = new Array();
                loadcontrols.push("#<%=ATTRCBox.ClientID%>");

                loadParamComboboxAjax('getModuleParameters', loadcontrols, module, "#ATTR_LD");
                loadComboboxAjax('loadOperators', "#<%=OPRCBox.ClientID%>", "#OPR_LD");
            }
        });

        $("#<%=ATTRCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                attachAttribute($(this).val(), "#<%=SNTXTxt.ClientID%>", $("#<%=MODULCBox.ClientID%>").val());
                $(this).val(0);
            }
        });

        $("#<%=OPRCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                addText($(this).val(), "#<%=SNTXTxt.ClientID%>");
                $(this).val(0);
            }
        });


        $("#<%=VALTxt.ClientID%>").keyup(function (event)
        {
            if ($(this).val().match(/[^0-9]/g))
            {
                $(this).val($(this).val().replace(/[^0-9]/g, ''));
            }
            else
            {
                addText($(this).val(), "#<%=SNTXTxt.ClientID%>");
            }
        });

        $("#byModule").bind('click', function ()
        {
            hideAll();

            loadComboboxAjax('loadModules', "#<%=MDLFLTRCBox.ClientID%>", "#MODULF_LD");
            $("#ModuleContainer").show();
         
        });

        $("#bySymbol").bind('click', function () {
            hideAll();

            loadComboboxAjax('loadRAGSymbols', "#<%=RAGFLTRCBox.ClientID%>", "#RAGF_LD");
            $("#RAGContainer").show();
        });

        //$(".toolbox div").bind('click', function ()
        //{
        //    $(".contextmenu").stop(true).hide().fadeIn(500, function () {
        //    });
        //});

        $("#<%=MDLFLTRCBox.ClientID%>").change(function () {
            filterConditions(empty, $(this).val(), null);
        });

        $("#<%=RAGFLTRCBox.ClientID%>").change(function () {
            filterConditions(empty, null, $(this).val());
        });

    });

    function filterConditions(empty, module, rag) {

        $("#conditionloader").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'module':'" + module + "','symbol':'" + rag + "'}",
                url: getServiceURL().concat('filterRAGConditions'),
                success: function (data) {
                    $("#conditionloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");
                        loadGridView(empty, data.d);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#conditionloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function attachAttribute(param, control, module) {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'parameter':'" + param + "','module':'" + module + " '}",
            url: getServiceURL().concat('getDBAttribute'),
            success: function (data) {
                addText(data.d, control);
            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                showErrorNotification(r.Message);
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

    function loadConditions(empty) {

        $("#conditionloader").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadRAGConditions'),
                success: function (data) {
                    $("#conditionloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(empty, data.d);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#conditionloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function loadGridView(empty, data) {
        var xmlConditions = $.parseXML(data);

        var row = empty;

        //remove all previous records
        $("#<%=gvCondition.ClientID%> tr").not($("#<%=gvCondition.ClientID%> tr:first-child")).remove();

        /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
        var date = new Date();

        $(xmlConditions).find('RAGCondition').each(function (index, value) {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'  />");
            $("td", row).eq(2).html("<img id='icon_" + index + "' src='/ImageHandler.ashx?query=select RAGIcon from dbo.RAGConditionSymbol where RAGSymbol=@value&width=20&height=20&value=" + $(this).attr('RAG') + "&date=" + date.getSeconds() + "' />");

            $("td", row).eq(3).html($(this).attr("RAGConditionID"));
            $("td", row).eq(4).html($(this).attr("Module"));
            $("td", row).eq(5).html(shortenText($(this).attr("Condition")));

            $("#<%=gvCondition.ClientID%>").append(row);

            $(row).find('img').each(function () {

                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeRAGCondition($(value).attr('RAGConditionID'), empty);
                    });
                }
                else if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        resetGroup('.modalPanel');


                        if ($("#MODE").val() != 'EDIT')
                            $("#MODE").val('EDIT');

                        $("#ConditionID").val($(value).attr('RAGConditionID'));

                        //bind data
                        bindComboboxAjax('loadModules', "#<%=MODULCBox.ClientID%>", $(value).attr('Module'), "#MODUL_LD");
                        bindComboboxAjax('loadRAGSymbols', "#<%=RAGCBox.ClientID%>", $(value).attr('RAG'), "#RAG_LD");
                        $("#<%=SNTXTxt.ClientID%>").val($(value).attr('Condition'));

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });
            row = $("#<%=gvCondition.ClientID%> tr:last-child").clone(true);

        });
    }
    function removeRAGCondition(ID, empty) {
        var result = confirm("Are you sure you would like to remove the current RAG condition?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'RAGID':'" + ID + "'}",
                url: getServiceURL().concat('removeRAGCondition'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    $("#conditionrefresh").trigger('click');
                },
                error: function (xhr, status, error)
                {

                    $(".modulewrapper").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }
    }

    //function hideAll()
    //{

    //    $(".filter").each(function () {
    //        $(this).css('display', 'none');
    //    });

    //    $(".contextmenu").fadeOut();
        
    //}

    // Added by JP - Override the CSS Hover in contextmenu. 
    $("#filterList").hover(function () {
        $('#filterList').removeAttr('style');
    });

    // Added by JP - Hide the contextMenu after click
    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
        $('#filterList').attr('style', 'display:none  !important');
        reset();
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

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
 </script>
</asp:Content>
