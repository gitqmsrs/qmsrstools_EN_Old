<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageProblemType.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ManageProblemType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="ProblemType_Header" class="moduleheader">Manage Problem Type</div>

    <div class="toolbox">
        <img id="new" src="/Images/new_file.png" class="imgButton" title="Create new problem type" alt=""/>  
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refersh data" alt="" />
    </div>

    <div id="PTYPloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
    <asp:GridView id="gvProblemType" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="TypeID" HeaderText="ID" />
                <asp:BoundField DataField="TypeName" HeaderText="Problem Type" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
        </Columns>
    </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
    <div id="header" class="modalHeader">Problem Type Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
        </div>

        <div id="validation_dialog_problemtype">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="ProblemType" />
        </div>

        <input id="TypeID" type="hidden" value="" />
      
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="TypeNameLabel" class="requiredlabel">Type Name:</div>
            <div id="TypeNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="TYPNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            
            <div id="TYPlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="TYPNMVal" runat="server" Display="None" ControlToValidate="TYPNMTxt" ErrorMessage="Enter the name of the problem type" ValidationGroup="ProblemType"></asp:RequiredFieldValidator>
            
            <asp:CustomValidator id="TYPNMFVal" runat="server" 
            ControlToValidate = "TYPNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters" ValidationGroup="ProblemType">
            </asp:CustomValidator>    
        </div>

      <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtVal" runat="server"
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText" ValidationGroup="ProblemType">
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
        var empty = $("#<%=gvProblemType.ClientID%> tr:last-child").clone(true);

        /*load calibration status*/
        refresh(empty);

        $("#refresh").bind('click', function () {
            refresh(empty);
        });

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#new").bind('click', function ()
        {

            resetGroup('.modalPanel');

            addWaterMarkText('The description of the problem type', '#<%=DESCTxt.ClientID%>');

            /*attach problem type to limit plugin*/
            $('#<%=TYPNMTxt.ClientID%>').limit({ id_result: 'TYPlimit', alertClass: 'alertremaining', limit: 100 });

            /*set modal mode to add*/
            $("#MODE").val('ADD');

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#save").click(function ()
        {
            var isPageValid = Page_ClientValidate('ProblemType');
            if (isPageValid)
            {
                if (!$("#validation_dialog_problemtype").is(":hidden")) {
                    $("#validation_dialog_problemtype").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD') {
                            var type =
                            {
                                TypeName: $("#<%=TYPNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(type) + "\'}",
                                url: getServiceURL().concat('createProblemType'),
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
                        else if ($("#MODE").val() == 'EDIT') {
                            var type =
                            {
                                TypeID: $("#TypeID").val(),
                                TypeName: $("#<%=TYPNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(type) + "\'}",
                                url: getServiceURL().concat('updateProblemType'),
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
                $("#validation_dialog_problemtype").stop(true).hide().fadeIn(500, function ()
                {
                    
                });
            }
        });
    });
    function removeProblemType(ID, empty)
    {
        var result = confirm("Removing the selected problem type might cause any related problem to lose reference, are you sure you would like to continue?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               data: "{'ID':'" + ID + "'}",
               url: getServiceURL().concat("removeProblemType"),
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
        $("#PTYPloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemType"),
                success: function (data) {
                    $("#PTYPloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var xml = $.parseXML(data.d);

                        var row = empty;

                        $("#<%=gvProblemType.ClientID%> tr").not($("#<%=gvProblemType.ClientID%> tr:first-child")).remove();


                        $(xml).find("GenericType").each(function (index, value) {
                            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
                            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'  />");
                            $("td", row).eq(2).html($(this).attr("TypeID"));
                            $("td", row).eq(3).html($(this).attr("TypeName"));
                            $("td", row).eq(4).html(shortenText($(this).attr("Description")));

                            $("#<%=gvProblemType.ClientID%>").append(row);

                            $(row).find('img').each(function () {
                                if ($(this).attr('id').search('delete') != -1) {
                                    $(this).bind('click', function () {
                                        removeProblemType($(value).attr("TypeID"), empty);
                                    });
                                }
                                else if ($(this).attr('id').search('edit') != -1) {
                                    $(this).bind('click', function ()
                                    {
                                        resetGroup('.modalPanel');

                                        /*set the mode to edit*/
                                        $("#MODE").val('EDIT');

                                        /* bind the ID of the problem type*/
                                        $("#TypeID").val($(value).attr("TypeID"));

                                        /*bind the name of the problem type*/
                                        $("#<%=TYPNMTxt.ClientID%>").val($(value).attr("TypeName"));

                                        /*attach problem type to limit plugin*/
                                        $('#<%=TYPNMTxt.ClientID%>').limit({ id_result: 'TYPlimit', alertClass: 'alertremaining', limit: 100 });

                                        $('#<%=TYPNMTxt.ClientID%>').keyup();

                                        /*bind the description of the problem type*/
                                        if ($(value).attr("Description") == '') {
                                            addWaterMarkText('The description of the problem type', '#<%=DESCTxt.ClientID%>');
                                        }
                                        else {
                                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                                            }

                                            $("#<%=DESCTxt.ClientID%>").val($("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text());
                                        }

                                        $("#<%=alias.ClientID%>").trigger('click');
                                    });
                                }
                            });

                            row = $("#<%=gvProblemType.ClientID%> tr:last-child").clone(true);
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#PTYPloader").fadeOut(500, function () {

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
