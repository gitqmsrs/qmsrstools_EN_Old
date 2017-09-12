<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="ManageSeverity.aspx.cs" Inherits="QMSRSTools.Administration.ManageSeverity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Severity_Header" class="moduleheader">Manage Severity</div>

    <div class="toolbox">
        <img id="newseverity" src="/Images/new_file.png" class="imgButton" title="Create new severity" alt=""/>  
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refersh data" alt="" />
    </div>

    <div id="severitywait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvSeverity" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="SeverityID" HeaderText="ID" />
            <asp:BoundField DataField="Criteria" HeaderText="Criteria" />
            <asp:BoundField DataField="Value" HeaderText="Value" />
            <asp:BoundField DataField="Score" HeaderText="Score" />
        </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="ModalExtender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:250px;">
        <div id="header" class="modalHeader">Severity Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
    
        <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>    
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CriteriaLabel" class="requiredlabel">Criteria</div>
            <div id="CriteriaField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="CRTTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div> 
             <div id="CRITlimit" class="textremaining"></div>   
       
            <asp:RequiredFieldValidator ID="CRTVal" runat="server" Display="None" ControlToValidate="CRTTxt" ErrorMessage="Enter the criteria of the severity" ValidationGroup="General"></asp:RequiredFieldValidator> 
            
            <asp:CustomValidator id="CRTTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CRTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
  
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="SeverityValueLabel" class="requiredlabel">Severity Value</div>
            <div id="SeverityField" class="fielddiv">
                <asp:TextBox ID="SVRVALTxt" CssClass="textbox" runat="server"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="SVRVval" runat="server" Display="None" ControlToValidate="SVRVALTxt" ErrorMessage="Enter the value of the severity" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <ajax:FilteredTextBoxExtender ID="SVRVALFExt" runat="server" TargetControlID="SVRVALTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>

            <asp:CustomValidator id="SVRVALZVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "SVRVALTxt" Display="None" ErrorMessage = "The value of the severity should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator>   
       
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="SeverityScoreLabel" class="requiredlabel">Severity Score</div>
            <div id="SeverityScoreField" class="fielddiv">
                <asp:TextBox ID="SVRSCRTxt" CssClass="textbox" runat="server" placeholder="e.g. 00.00"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="SVRSCRVal" runat="server" Display="None" ControlToValidate="SVRSCRTxt" ErrorMessage="Enter the score of the severity" ValidationGroup="General"></asp:RequiredFieldValidator>   
        
            <asp:RegularExpressionValidator ID="SVRSCRFVal" runat="server" ControlToValidate="SVRSCRTxt"
            Display="None" ErrorMessage="Enter a decimal number (e.g. 22.10)" ValidationExpression="^[0-9]+\.[0-9]{2}$" ValidationGroup="General"></asp:RegularExpressionValidator> 
        </div>
        
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <input id="MODE" type="hidden" value="" />
    <input id="SEVERITYID" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvSeverity.ClientID%> tr:last-child").clone(true);

        /*load all severity records*/
        loadSeverities(empty);

        $("#refresh").bind('click', function () {
            loadSeverities(empty);
        });

        $("#newseverity").bind('click', function ()
        {

            $("#validation_dialog_general").hide();

            /*clear all fields*/
            reset();

            /*attach criteria file type to limit plugin*/
            $("#<%=CRTTxt.ClientID%>").limit({ id_result: 'CRITlimit', alertClass: 'alertremaining', limit: 100 });
                        
            /*set modal popup mode to add*/
            $("#MODE").val('ADD');

            /*trigger modal popup extender*/
            $("#<%=alias.ClientID%>").trigger('click');

        });

        /*Close modal popup extender*/
        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#save").bind('click', function () {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD')
                        {
                            var severity =
                            {
                                Criteria: $("#<%=CRTTxt.ClientID%>").val(),
                                SeverityValue: $("#<%=SVRVALTxt.ClientID%>").val(),
                                Score: $("#<%=SVRSCRTxt.ClientID%>").val()
                            }
                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(severity) + "\'}",
                                url: getServiceURL().concat("createSeverity"),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refresh").trigger('click');
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
                            var severity =
                            {
                                SeverityID: $("#SEVERITYID").val(),
                                Criteria: $("#<%=CRTTxt.ClientID%>").val(),
                                SeverityValue: $("#<%=SVRVALTxt.ClientID%>").val(),
                                Score: $("#<%=SVRSCRTxt.ClientID%>").val()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(severity) + "\'}",
                                url: getServiceURL().concat("updateSeverity"),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refresh").trigger('click');
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
    function loadSeverities(empty) {
        $("#severitywait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadSeverity'),
                success: function (data)
                {
                    $("#severitywait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#severitywait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadGridView(data, empty) {
        var xml = $.parseXML(data);
        var row = empty;

        $("#<%=gvSeverity.ClientID%> tr").not($("#<%=gvSeverity.ClientID%> tr:first-child")).remove();

        $(xml).find("Severity").each(function (index, value) {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'  />");
            $("td", row).eq(2).html($(this).attr("SeverityID"));
            $("td", row).eq(3).html($(this).attr("Criteria"));
            $("td", row).eq(4).html($(this).attr("SeverityValue"));
            $("td", row).eq(5).html($(this).attr("Score"));
            $("td", row).eq(6).html(new Date($(this).attr("ModifiedDate")).format("dd/MM/yyyy"));
            $("td", row).eq(7).html($(this).attr("ModifiedBy"));

            $("#<%=gvSeverity.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeSeverity($(value).attr("SeverityID"), empty);
                    });
                }
                else if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        resetGroup('.modalPanel');

                        /*temprarly store the ID of the severity*/
                        $("#SEVERITYID").val($(value).attr("SeverityID"));

                        /*bind the criteria value of the severity*/
                        $("#<%=CRTTxt.ClientID%>").val($(value).attr("Criteria"));

                        /*bind the value of the severity*/
                        $("#<%=SVRVALTxt.ClientID%>").val($(value).attr("SeverityValue"));

                        /*bind the score of the severity*/
                        $("#<%=SVRSCRTxt.ClientID%>").val($(value).attr("Score"));


                        /*attach criteria file type to limit plugin*/
                        $("#<%=CRTTxt.ClientID%>").limit({ id_result: 'CRITlimit', alertClass: 'alertremaining', limit: 100 });
                        $("#<%=CRTTxt.ClientID%>").keyup();

                        /*set modal popup mode to edit*/
                        $("#MODE").val('EDIT');

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });
            row = $("#<%=gvSeverity.ClientID%> tr:last-child").clone(true);
        });
    }
    function removeSeverity(ID, empty) {
        var result = confirm("Removing severity record might cause related Problem Management records (if any) to lose reference of the severity, do you want to continue?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'severityID':'" + ID + "'}",
                url: getServiceURL().concat('removeSeverity'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    loadSeverities(empty);
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

    function ActivateSave(isactive)
    {
        if (isactive == false)
        {
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
