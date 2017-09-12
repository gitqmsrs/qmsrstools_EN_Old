<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="ManageSMTP.aspx.cs" Inherits="QMSRSTools.Administration.ManageSMTP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="SMTP_Header" class="moduleheader">Manage SMTP Servers</div>
    
    <div class="toolbox">
        <img id="newSMTP" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="" alt=""/>   
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="" alt="" />
    </div>

    <div id="waitloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvSMTPServer" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="SMTPID" HeaderText="ID" />
            <asp:BoundField DataField="SMTPServer" HeaderText="SMTP Server" />
        </Columns>
        </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" style="display:none">
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="SMTPServerLabel" class="requiredlabel">SMTP Server</div>
            <div id="SMTPServerField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="SMTPSRVTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
            </div> 
            
            <asp:RequiredFieldValidator ID="SMTPSRVTxtVal" runat="server" Display="Dynamic" ValidationGroup="popup" ControlToValidate="SMTPSRVTxt" CssClass="validator" ErrorMessage="Enter the name of the SMTP server"></asp:RequiredFieldValidator>
            
            <asp:RegularExpressionValidator ID="SMTPSRVFVal" runat="server" ControlToValidate="SMTPSRVTxt"
            Display="Dynamic" ErrorMessage="Only alphabets and numeric values are allowed (e.g. mail.co.uk)" ValidationGroup="popup" CssClass="validator" ValidationExpression="^[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*$"></asp:RegularExpressionValidator> 
        </div>
        <p style="margin-top:20px; float:left">Press Esc to Close the Dialog</p>
    </asp:Panel>

    <input id="MODE" type="hidden" value="" />
    <input id="DATA" type="hidden" value="" />
</div>

<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvSMTPServer.ClientID%> tr:last-child").clone(true);

        loadSMTP(empty);

        $("#newSMTP").bind('click', function () {
            if ($("#MODE").val() != 'LOAD')
                $("#MODE").val('LOAD');

            showSMTPDialog(empty);
        });

        $("#refresh").bind('click', function () {
            loadSMTP(empty);
        });

    });

    function showSMTPDialog(empty) {
        $("#<%=panel1.ClientID%>").dialog(
        {
            width: 550,
            show: "slow",
            title: 'Add New SMTP Server',
            modal: true,
            height: 200,
            hide: "highlight",
            buttons:
            [
               {
                   text: "Submit",
                   click: function () {

                       var isPageValid = Page_ClientValidate('popup');
                       if (isPageValid) {
                           if ($("#MODE").val() == 'LOAD') {
                               var smtpserver =
                               {
                                   SMTP: $("#<%=SMTPSRVTxt.ClientID%>").val()
                               }

                               $.ajax(
                               {
                                   type: "POST",
                                   contentType: "application/json; charset=utf-8",
                                   dataType: "json",
                                   data: "{\'json\':\'" + JSON.stringify(smtpserver) + "\'}",
                                   url: getServiceURL().concat("createSMTPServer"),
                                   success: function (data) {
                                       $("#<%=panel1.ClientID%>").dialog("close");
                                   },
                                   error: function (xhr, status, error) {
                                       var r = jQuery.parseJSON(xhr.responseText);
                                       showErrorNotification(r.Message);
                                   }
                               });
                           }
                           else {
                               var smtpserver =
                               {
                                   SMTPServerID: $("#DATA").val(),
                                   SMTP: $("#<%=SMTPSRVTxt.ClientID%>").val()
                               }

                               $.ajax(
                               {
                                   type: "POST",
                                   contentType: "application/json; charset=utf-8",
                                   dataType: "json",
                                   data: "{\'json\':\'" + JSON.stringify(smtpserver) + "\'}",
                                   url: getServiceURL().concat("updateSMTPServer"),
                                   success: function (data) {
                                       $("#<%=panel1.ClientID%>").dialog("close");
                                   },
                                   error: function (xhr, status, error) {
                                       var r = jQuery.parseJSON(xhr.responseText);
                                       showErrorNotification(r.Message);
                                   }
                               });
                           }
                       }
                       else {
                          
                       }
                   }
               },
               {
                   text: "Cancel",
                   click: function () {
                       $(this).dialog("close");
                   }
               }
            ],
            close: function (event, ui) {
                $("#refresh").trigger('click');
                $(this).dialog("destroy");
            }
        });
    }
    function removeServer(id, empty) {
        var result = confirm("Removing SMTP Server record might cause related Email Templates (if any) to lose reference, do you want to continue?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'serverid':'" + id + "'}",
                url: getServiceURL().concat("removeSMTPServer"),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");
                    $("#refresh").trigger('click');

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
            function loadSMTP(empty) {
                $("#waitloader").stop(true).hide().fadeIn(500, function () {
                    $(".modulewrapper").css("cursor", "wait");
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        url: getServiceURL().concat("getSMTPServer"),
                        success: function (data)
                        {
                            $("#waitloader").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                loadGridView(data.d, empty);
                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#waitloader").fadeOut(500, function () {
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

                $("#<%=gvSMTPServer.ClientID%> tr").not($("#<%=gvSMTPServer.ClientID%> tr:first-child")).remove();

                $(xml).find("SMTPServer").each(function (index, value) {
                    $("td", row).eq(0).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
                    $("td", row).eq(1).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'  />");
                    $("td", row).eq(2).html($(this).attr("SMTPServerID"));
                    $("td", row).eq(3).html($(this).attr("SMTP"));

                    $("#<%=gvSMTPServer.ClientID%>").append(row);

                    $(row).find('img').each(function () {
                        if ($(this).attr('id').search('edit') != -1) {
                            $(this).bind('click', function () {
                                $("#DATA").val($(value).attr("SMTPServerID"));

                                if ($("#MODE").val() != 'EDIT')
                                    $("#MODE").val('EDIT');

                                $("#<%=SMTPSRVTxt.ClientID%>").val($(value).attr("SMTP"));
                                showSMTPDialog(empty);
                            });
                        }
                        else if ($(this).attr('id').search('delete') != -1) {
                            $(this).bind('click', function () {
                                removeServer(parseInt($(value).attr('SMTPServerID')), empty);
                            });
                        }

                    });

                    row = $("#<%=gvSMTPServer.ClientID%> tr:last-child").clone(true);
                });
            }

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }

</script>

</asp:Content>
