<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageAssetStatus.aspx.cs" Inherits="QMSRSTools.AssetManagement.ManageAssetStatus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="wrapper" class="modulewrapper">

    <div id="AssetStatus_Header" class="moduleheader">Manage Asset Status</div>

    <div class="toolbox">
        <img id="newstatus" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Create new asset status" alt=""/>  
        <img id="refreshstatus" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refersh data" alt="" />
    </div>

    <div id="MSTSloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
    <asp:GridView id="gvStatus" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="StatusID" HeaderText="ID" />
                <asp:BoundField DataField="Status" HeaderText="Status Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
        </Columns>
    </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
    <div id="header" class="modalHeader">Asset Status Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
        </div>

        <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <input id="StatusID" type="hidden" value="" />
      
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="StatusNameLabel" class="requiredlabel">Status Name:</div>
            <div id="StatusNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="STSNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            
            <div id="STSlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="STSNMVal" runat="server" Display="None" ControlToValidate="STSNMTxt" ErrorMessage="Enter the name of the asset status" ValidationGroup="General"></asp:RequiredFieldValidator>
            
             <asp:CustomValidator id="STSNMTxtFVal" runat="server" ValidationGroup="General" Display="None"
             ControlToValidate = "STSNMTxt" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
             ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

      <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="General" 
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
        var empty = $("#<%=gvStatus.ClientID%> tr:last-child").clone(true);

        /*load calibration status*/
        refresh(empty);

        $("#refreshstatus").bind('click', function () {
            refresh(empty);
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#newstatus").bind('click', function ()
        {
            resetGroup('.modalPanel');

            addWaterMarkText('The description of the calibration status', '#<%=DESCTxt.ClientID%>');

            /*attach status to limit plugin*/
            $('#<%=STSNMTxt.ClientID%>').limit({ id_result: 'STSlimit', alertClass: 'alertremaining', limit: 50 });

            /*set modal mode to add*/
            $("#MODE").val('ADD');

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#save").click(function () {
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
                            var status =
                            {
                                StatusName: $("#<%=STSNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(status) + "\'}",
                                url: getServiceURL().concat('createAssetStatus'),
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
                        else if ($("#MODE").val() == 'EDIT')
                        {
                            var status =
                            {
                                StatusID: $("#StatusID").val(),
                                StatusName: $("#<%=STSNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(status) + "\'}",
                                url: getServiceURL().concat('updateAssetStatus'),
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
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });
    });
    function removeStatus(ID, empty)
    {
        var result = confirm("Are you sure you would like to remove the current asset status record?");
        if (result == true)
        {

            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'ID':'" + ID + "'}",
                url: getServiceURL().concat("removeAssetStatus"),
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
    function refresh(empty) {
        $("#MSTSloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadAssetListStatus"),
                success: function (data)
                {
                    $("#MSTSloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var xml = $.parseXML(data.d);

                        var row = empty;

                        $("#<%=gvStatus.ClientID%> tr").not($("#<%=gvStatus.ClientID%> tr:first-child")).remove();


                        $(xml).find("Status").each(function (index, value) {
                            $("td", row).eq(0).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
                            $("td", row).eq(1).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'  />");
                            $("td", row).eq(2).html($(this).attr("StatusID"));
                            $("td", row).eq(3).html($(this).attr("StatusName"));
                            $("td", row).eq(4).html(shortenText($(this).attr("Description")));

                            $("#<%=gvStatus.ClientID%>").append(row);

                            $(row).find('img').each(function () {
                                if ($(this).attr('id').search('delete') != -1) {
                                    $(this).bind('click', function () {
                                        removeStatus($(value).attr("StatusID"), empty);
                                    });
                                }
                                else if ($(this).attr('id').search('edit') != -1) {
                                    $(this).bind('click', function ()
                                    {
                                        resetGroup('.modalPanel');

                                        /*set the mode to edit*/
                                        $("#MODE").val('EDIT');

                                        /* bind the ID of the Calibration Status*/
                                        $("#StatusID").val($(value).attr("StatusID"));

                                        /*bind the name of the status*/
                                        $("#<%=STSNMTxt.ClientID%>").val($(value).attr("StatusName"));

                                        /*attach status to limit plugin*/
                                        $('#<%=STSNMTxt.ClientID%>').limit({ id_result: 'STSlimit', alertClass: 'alertremaining', limit: 50 });

                                        $('#<%=STSNMTxt.ClientID%>').keyup();

                                        /*bind the description of the status*/
                                        if ($(value).attr("Description") == '') {
                                            addWaterMarkText('The description of the asset status', '#<%=DESCTxt.ClientID%>');
                                        }
                                        else {
                                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                                            }

                                            $("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text();
                                        }

                                        $("#<%=alias.ClientID%>").trigger('click');
                                    });
                                }
                            });

                            row = $("#<%=gvStatus.ClientID%> tr:last-child").clone(true);
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#MSTSloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function ActivateSave(isactive)
    {
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
