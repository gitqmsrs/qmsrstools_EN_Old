<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageFindingType.aspx.cs" Inherits="QMSRSTools.AuditManagement.ManageFindingType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
   
    <div id="FindingType_Header" class="moduleheader">Manage Finding Type</div>
    
    <div class="toolbox">
        <img id="newtype" src="/Images/new_file.png" class="imgButton" title="Create new finding type" alt=""/>  
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refersh data" alt="" />
    </div>

    <div id="FNDTYPloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
    <asp:GridView id="gvFindingType" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="FindingTypeID" HeaderText="ID" />
                <asp:BoundField DataField="FindingType" HeaderText="Finding Type" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
        </Columns>
    </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
    <div id="header" class="modalHeader">Finding Type Details<span id="close" class="modalclose" title="Close">X</span></div>
       
        <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <input id="FindingTypeID" type="hidden" value="" />
      
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="FindingTypeLabel" class="requiredlabel">Finding Type:</div>
            <div id="FindingTypeField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="FNDTYPTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            <div id="FNDTYPlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="FNDTYPTxtVal" runat="server" Display="None" ControlToValidate="FNDTYPTxt" ErrorMessage="Enter the type of the finding" ValidationGroup="General"></asp:RequiredFieldValidator> 

            <asp:CustomValidator id="FNDTYPTxtFVal" runat="server" ValidationGroup="General"
            ControlToValidate = "FNDTYPTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

      <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtFVal" runat="server" ValidationGroup="General"
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
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
        var empty = $("#<%=gvFindingType.ClientID%> tr:last-child").clone(true);

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

            addWaterMarkText('The description of the finding type', '#<%=DESCTxt.ClientID%>');

            /*attach finding type to limit plugin*/
            $("#<%=FNDTYPTxt.ClientID%>").limit({ id_result: 'FNDTYPlimit', alertClass: 'alertremaining', limit: 50 });

            /*set modal mode to add*/
            $("#MODE").val('ADD');

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#save").click(function ()
        {
            var isPageValid = Page_ClientValidate('General');
            if (isPageValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD') {

                            var findingtype =
                            {
                                TypeName: $("#<%=FNDTYPTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(findingtype) + "\'}",
                                url: getServiceURL().concat('createFindingType'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        refresh(empty);
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
                        else if ($("#MODE").val() == 'EDIT')
                        {
                            var findingtype =
                            {
                                TypeID: $("#FindingTypeID").val(),
                                TypeName: $("#<%=FNDTYPTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(findingtype) + "\'}",
                                url: getServiceURL().concat('updateFindingType'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);
                                        showSuccessNotification(data.d);

                                        $("#cancel").trigger('click');
                                        refresh(empty);
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
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });
    });
    function removeFindingType(ID, empty)
    {
        var result = confirm("Are you sure you would like to remove the selected finding type record?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'findingtypeID':'" + ID + "'}",
                url: getServiceURL().concat("removeFindingType"),
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
        $("#FNDTYPloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadFindingType"),
                success: function (data)
                {
                    $("#FNDTYPloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var xml = $.parseXML(data.d);

                        var row = empty;

                        $("#<%=gvFindingType.ClientID%> tr").not($("#<%=gvFindingType.ClientID%> tr:first-child")).remove();

                        $(xml).find("ActionFindingType").each(function (index, value) {
                            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
                            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'  />");
                            $("td", row).eq(2).html($(this).attr("TypeID"));
                            $("td", row).eq(3).html($(this).attr("TypeName"));
                            $("td", row).eq(4).html(shortenText($(this).attr("Description")));

                            $("#<%=gvFindingType.ClientID%>").append(row);

                            $(row).find('img').each(function () {
                                if ($(this).attr('id').search('delete') != -1) {
                                    $(this).bind('click', function () {
                                        removeFindingType($(value).attr("TypeID"), empty);
                                    });
                                }
                                else if ($(this).attr('id').search('edit') != -1) {
                                    $(this).bind('click', function ()
                                    {
                                        resetGroup('.modalPanel');

                                        /*set the mode to edit*/
                                        $("#MODE").val('EDIT');

                                        /* bind the ID of the Finding Type*/
                                        $("#FindingTypeID").val($(value).attr("TypeID"));

                                        /*bind the name of the finding type*/
                                        $("#<%=FNDTYPTxt.ClientID%>").val($(value).attr("TypeName"));

                                        /*bind the description of the status*/
                                        if ($(value).attr("Description") == '') {
                                            addWaterMarkText('The description of the finding type', '#<%=DESCTxt.ClientID%>');
                                        }
                                        else {
                                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                                            }

                                            $("#<%=DESCTxt.ClientID%>").val($("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text());
                                        }

                                        /*attach finding type to limit plugin*/
                                        $("#<%=FNDTYPTxt.ClientID%>").limit({ id_result: 'FNDTYPlimit', alertClass: 'alertremaining', limit: 50 });

                                        /*trigger finding type keyup event*/
                                        $("#<%=FNDTYPTxt.ClientID%>").keyup();

                                        /*trigger model popup extender*/
                                        $("#<%=alias.ClientID%>").trigger('click');
                                    });
                                }
                            });

                            row = $("#<%=gvFindingType.ClientID%> tr:last-child").clone(true);
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#FNDTYPloader").fadeOut(500, function ()
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
