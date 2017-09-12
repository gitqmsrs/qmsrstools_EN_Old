<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageTaskActionType.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ManageTaskActionType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper" class="modulewrapper">
        <div id="ActionType_Header" class="moduleheader">Manage Task Action Type</div>
    
        <div class="toolbox">
            <img id="newtype" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Create new action type" alt=""/>  
            <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refersh data" alt="" />
        </div>

        <div id="ACTTYPloader" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>

        <div id="scrollbar" class="gridscroll">
            <asp:GridView id="gvActionType" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="ActionTypeID" HeaderText="ID" />
                <asp:BoundField DataField="ActionType" HeaderText="Finding Type" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
            </Columns>
            </asp:GridView>
        </div>

        <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">

            <div id="header" class="modalHeader">Action Type Details<span id="close" class="modalclose" title="Close">X</span></div>
            
            <div id="SaveTooltip" class="tooltip">
                <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
                <p>Saving...</p>
	        </div>

             <div id="validation_dialog_actiontype">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="ActionType" />
            </div>

            <input id="ActionTypeID" type="hidden" value="" />
      
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ActionTypeLabel" class="requiredlabel">Action Type:</div>
                <div id="ActionTypeField" class="fielddiv" style="width:200px;">
                    <asp:TextBox ID="ACTTYPTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
                </div>
                <div id="ACTTYPlimit" class="textremaining"></div>
        
                <asp:RequiredFieldValidator ID="ACTTYPTxtVal" runat="server" Display="None" ControlToValidate="ACTTYPTxt" ErrorMessage="Enter the type of the audit action" ValidationGroup="ActionType"></asp:RequiredFieldValidator> 
                
                <asp:CustomValidator id="ACTTYPTxtFVal" runat="server"
                ControlToValidate = "ACTTYPTxt" Display="None" ValidationGroup="ActionType" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>    
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DescriptionLabel" class="labeldiv">Description:</div>
                <div id="DescriptionField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <asp:CustomValidator id="DESCTxtFVal" runat="server" Display="None" ValidationGroup="ActionType"
                ControlToValidate = "DESCTxt" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
            <div class="buttondiv">
                <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
                <input id="cancel" type="button" class="button" value="Cancel" />
            </div>   
    </asp:Panel>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <input id="MODE" type="hidden" value="" /> 
</div>
<script type="text/javascript" language="javascript">

    $(function () {
        var empty = $("#<%=gvActionType.ClientID%> tr:last-child").clone(true);

        /*load all cost centres*/
        refresh(empty);

        $("#refresh").bind('click', function () {
            refresh(empty);
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#newtype").bind('click', function () {

            resetGroup('.modalPanel');

            addWaterMarkText('The description of the action type', '#<%=DESCTxt.ClientID%>');

            /*set modal mode to add*/
            $("#MODE").val('ADD');

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#save").click(function ()
        {
            var isPageValid = Page_ClientValidate('ActionType');
            if (isPageValid)
            {
                if (!$("#validation_dialog_actiontype").is(":hidden")) {
                    $("#validation_dialog_actiontype").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);


                        if ($("#MODE").val() == 'ADD') {
                            var actiontype =
                            {
                                TypeName: $("#<%=ACTTYPTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(actiontype) + "\'}",
                                url: getServiceURL().concat('createTaskActionType'),
                                success: function (data) {
                                    $("#cancel").trigger('click');
                                    refresh(empty);
                                },
                                error: function (xhr, status, error) {
                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                }
                            });
                        }
                        else if ($("#MODE").val() == 'EDIT') {
                            var actiontype =
                            {
                                TypeID: $("#ActionTypeID").val(),
                                TypeName: $("#<%=ACTTYPTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(actiontype) + "\'}",
                                url: getServiceURL().concat('updateTaskActionType'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        refresh(empty);
                                    });
                                },
                                error: function (xhr, status, error) {
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
                $("#validation_dialog_actiontype").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });
    });
    function removeActionType(ID, empty)
    {
        var result = confirm("Are you sure you would like to remove the selected action type record?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'actiontypeID':'" + ID + "'}",
                url: getServiceURL().concat("removeTaskActionType"),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    refresh(empty);
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
    function refresh(empty)
    {
        $("#ACTTYPloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadTaskActionType"),
                success: function (data) {
                    $("#ACTTYPloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var xml = $.parseXML(data.d);

                        var row = empty;

                        $("#<%=gvActionType.ClientID%> tr").not($("#<%=gvActionType.ClientID%> tr:first-child")).remove();

                        $(xml).find("TaskActionType").each(function (index, value) {
                            $("td", row).eq(0).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
                            $("td", row).eq(1).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'  />");
                            $("td", row).eq(2).html($(this).attr("TypeID"));
                            $("td", row).eq(3).html($(this).attr("TypeName"));
                            $("td", row).eq(4).html(shortenText($(this).attr("Description")));

                            $("#<%=gvActionType.ClientID%>").append(row);

                            $(row).find('img').each(function () {
                                if ($(this).attr('id').search('delete') != -1) {
                                    $(this).bind('click', function () {
                                        removeActionType($(value).attr("TypeID"), empty);
                                    });
                                }
                                else if ($(this).attr('id').search('edit') != -1) {
                                    $(this).bind('click', function ()
                                    {
                                        resetGroup('.modalPanel');


                                        /*set the mode to edit*/
                                        $("#MODE").val('EDIT');

                                        /* bind the ID of the Action Type*/
                                        $("#ActionTypeID").val($(value).attr("TypeID"));

                                        /*bind the name of the action type*/
                                        $("#<%=ACTTYPTxt.ClientID%>").val($(value).attr("TypeName"));

                                        /*bind the description of the status*/
                                        if ($(value).attr("Description") == '') {
                                            addWaterMarkText('The description of the action type', '#<%=DESCTxt.ClientID%>');
                                        }
                                        else {
                                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                                            }

                                            $("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text();
                                        }

                                        /*attach action type to limit plugin*/
                                        $('#<%=ACTTYPTxt.ClientID%>').limit({ id_result: 'ACTTYPlimit', alertClass: 'alertremaining', limit: 100 });

                                        /*trigger action type keyup event to calculate the number of characters*/
                                        $('#<%=ACTTYPTxt.ClientID%>').keyup();

                                        /*trigger model popup extender*/
                                        $("#<%=alias.ClientID%>").trigger('click');
                                    });
                                }
                            });

                            row = $("#<%=gvActionType.ClientID%> tr:last-child").clone(true);
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTTYPloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
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


    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
</script>
</asp:Content>
