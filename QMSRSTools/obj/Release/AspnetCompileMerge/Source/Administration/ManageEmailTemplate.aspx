<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageEmailTemplate.aspx.cs" Inherits="QMSRSTools.Administration.ManageEmailTemplate" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Email_Header" class="moduleheader">Manage Email Templates</div>

    <div class="toolbox">
        <img id="emailrefresh" src="../Images/refresh.png" class="imgButton" title="" alt="" />
        <img id="newEmail" src="../Images/new_file.png" class="imgButton" title="" alt=""/>   
    </div>

    <div id="emailloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="EmailScrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvEmails" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="EmailID" HeaderText="ID" />
            <asp:BoundField DataField="Module" HeaderText="Module" />
            <asp:BoundField DataField="Action" HeaderText="Action" />
            <asp:BoundField DataField="Subject" HeaderText="Subject" />
            <asp:BoundField DataField="EmailFrom" HeaderText="Email From" />
            <asp:BoundField DataField="SMTPServer" HeaderText="SMTP Server" /> 
        </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EmailExtender" runat="server" BehaviorID="EmailExtender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground" OnCancelScript="hideTooltip();">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Email Template Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="emailtooltip" class="tooltip">
            <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
            <p>Select attributes to create subject or body context.</p>
	    </div>	
       
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <div id="validation_dialog_email" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Email" />
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="SMTPServerLabel" class="requiredlabel">SMTP Server:</div>
            <div id="SMTPServerField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="SMTPSRVCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="SMTP_LD" class="control-loader"></div> 
            
            <asp:RequiredFieldValidator ID="SMTPSRVTxtVal" runat="server" Display="None" ControlToValidate="SMTPSRVCBox" ErrorMessage="Select SMTP Server" ValidationGroup="Email"></asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="SMTPSRVVal" runat="server" ControlToValidate="SMTPSRVCBox"  
            Display="None" ErrorMessage="Select SMTP Server" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Email"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ModuleLabel" class="requiredlabel">Module Name:</div>
            <div id="ModuleField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="MODULCBox" AutoPostBack="false" Width="240px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="MODUL_LD" class="control-loader"></div> 
            
            <asp:RequiredFieldValidator ID="MODULTxtVal" runat="server" Display="None" ControlToValidate="MODULCBox" ErrorMessage="Select a Module" ValidationGroup="Email"></asp:RequiredFieldValidator>

            <asp:CompareValidator ID="MODULVal" runat="server" ControlToValidate="MODULCBox"
            Display="None" ErrorMessage="Select a Module" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Email"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="ActionLabel" class="requiredlabel">Select Action:</div>
            <div id="ActionField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="ACTCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
        
            <div id="ACT_LD" class="control-loader"></div> 

            <asp:RequiredFieldValidator ID="ACTTxtVal" runat="server" Display="None" ControlToValidate="ACTCBox" ErrorMessage="Select an Action" ValidationGroup="Email"></asp:RequiredFieldValidator>

            <asp:CompareValidator ID="ACTVal" runat="server" ControlToValidate="ACTCBox" ValidationGroup="Email"
            Display="None" ErrorMessage="Select an Action" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="EmailFromLabel" class="requiredlabel">Sender:</div>
            <div id="EmailFromField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="SNDRTxt" Width="240px" runat="server" CssClass="textbox">
                </asp:TextBox>
            </div>

            <asp:RequiredFieldValidator ID="SNDRVal" runat="server" Display="None" ControlToValidate="SNDRTxt" ErrorMessage="Enter the email of the sender" ValidationGroup="Email"></asp:RequiredFieldValidator>  
            
            <asp:RegularExpressionValidator ID="SNDRFVal" runat="server" ControlToValidate="SNDRTxt" ValidationGroup="Email"
            Display="None" ErrorMessage="Incorrect email format of the sender" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>    
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="menu" class="menucontainer" style="border: 1px solid #052556; overflow:visible; height:300px; width:37%">
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="AttributesLabel" class="labeldiv" style="width:80px;">Attributes:</div>
                    <div id="AttributesField" class="fielddiv" style="width:150px;">
                        <asp:DropDownList ID="ATTRCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="ATTR_LD" class="control-loader"></div> 
                </div>
            </div>
            <div id="emailcontainer" class="modulecontainer" style="border: 1px solid #052556; overflow:visible; height:300px; width:60%;">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="SubjectLabel" class="requiredlabel">Subject:</div>
                    <div id="SubjectField" class="fielddiv" style="width:150px;">
                        <asp:TextBox ID="SBJTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="SBJVal" runat="server" Display="None" ControlToValidate="SBJTxt" ErrorMessage="Enter the subject of the email"  ValidationGroup="Email"></asp:RequiredFieldValidator> 
                </div>
                <div style="float:left; width:100%; height:20px; margin-top:20px;">
                    <div id="BodyLabel" class="requiredlabel">Body:</div>
                    <div id="BodyField" class="fielddiv" style="width:350px; height:190px;">
                        <asp:TextBox ID="BDYTxt" runat="server" CssClass="textbox" Width="340px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="BDYVal" runat="server" Display="None" ControlToValidate="BDYTxt" ErrorMessage="Enter the body of the email" ValidationGroup="Email"></asp:RequiredFieldValidator>
                </div>          
            </div>
       </div>
       <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
       </div>
    </asp:Panel>

    <input id="MODE" type="hidden" value="" />
    <input id="FOCUS" type="hidden" value="" />
    <input id="EMAILID" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvEmails.ClientID%> tr:last-child").clone(true);

        loadTemplates(empty);

        $("#emailrefresh").bind('click', function () {
            loadTemplates(empty);
        });

        $("#newEmail").bind('click', function ()
        {
            if ($("#MODE").val() != 'LOAD')
                $("#MODE").val('LOAD');

            loadComboboxAjax('loadSMTPServers', "#<%=SMTPSRVCBox.ClientID%>","#SMTP_LD");
            loadComboboxAjax('loadModules', "#<%=MODULCBox.ClientID%>", "#MODUL_LD");

            //reset all controls
            reset();


            $("#<%=ACTCBox.ClientID%>").empty();

            // show module tooltip
            if ($("#emailtooltip").is(":hidden")) {
                $("#emailtooltip").slideDown(800, 'easeOutBounce');
            }

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#<%=MODULCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {

                var module = "'name':'" + $(this).val() + "'";

                var controls = new Array();
                controls.push("#<%=ATTRCBox.ClientID%>");
                loadParamComboboxAjax('getModuleAttributes', controls, module, "#ATTR_LD");

                controls = new Array();
                controls.push("#<%=ACTCBox.ClientID%>");

                loadParamComboboxAjax('getModuleActions', controls, module, "#ACT_LD");
            }
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#save").bind('click', function () {
            var isPageValid = Page_ClientValidate('Email');
            if (isPageValid)
            {
                if (!$("#validation_dialog_email").is(":hidden")) {
                    $("#validation_dialog_email").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'LOAD') {
                            var emailtemplate =
                            {
                                Module: $("#<%=MODULCBox.ClientID%>").find('option:selected').text(),
                                Action: $("#<%=ACTCBox.ClientID%>").find('option:selected').text(),
                                Subject: $("#<%=SBJTxt.ClientID%>").val(),
                                Body: $("#<%=BDYTxt.ClientID%>").val(),
                                EmailFrom: $("#<%=SNDRTxt.ClientID%>").val(),
                                SMTPServer: $("#<%=SMTPSRVCBox.ClientID%>").find('option:selected').text()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(emailtemplate) + "\'}",
                                url: getServiceURL().concat("createEmailTemplate"),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        loadTemplates(empty);

                                        $("#cancel").trigger('click');
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(r.Message);
                                    });
                                }
                            });
                        }
                        else {
                            var emailtemplate =
                            {
                                EmailID: $("#EMAILID").val(),
                                Module: $("#<%=MODULCBox.ClientID%>").find('option:selected').text(),
                                Action: $("#<%=ACTCBox.ClientID%>").find('option:selected').text(),
                                Subject: $("#<%=SBJTxt.ClientID%>").val(),
                                Body: $("#<%=BDYTxt.ClientID%>").val(),
                                EmailFrom: $("#<%=SNDRTxt.ClientID%>").val(),
                                SMTPServer: $("#<%=SMTPSRVCBox.ClientID%>").find('option:selected').text()
                            }


                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(emailtemplate) + "\'}",
                                url: getServiceURL().concat("updateEmailTemplate"),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        loadTemplates(empty);

                                        $("#cancel").trigger('click');
                                    });
                                },
                                error: function (xhr, status, error)
                                {
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
            else {
                $("#validation_dialog_email").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

        $("#<%=ATTRCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var focusID = $("#FOCUS").val();
                if (focusID != '') {
                    var text = $("#" + focusID).val();
                    text += " " + $(this).val();
                    $("#" + focusID).val(text);
                }
                else {
                    alert('Select either the subject or the body of the email');
                }

                $(this).val(0);
            }
        });

        $("#<%=SBJTxt.ClientID%>").focus(function (event) {
            event.preventDefault();

            $("#FOCUS").val($(this).attr('id'));
        });

        $("#<%=BDYTxt.ClientID%>").focus(function (event) {
            event.preventDefault();
            $("#FOCUS").val($(this).attr('id'));
        });

        $("#close").bind('click', function () {
            $("#cancel").trigger('click');
        });
    });

    function removeEmailTemplate(ID, empty) {
        var result = confirm("Are you sure you would like to remove the selected email template?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'emailID':'" + ID + "'}",
                url: getServiceURL().concat('removeEmailTemplate'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    loadTemplates(empty);
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

    function loadTemplates(empty) {
        $("#emailloader").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadEmailTemplates'),
                success: function (data) {
                    $("#emailloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#emailloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function hideTooltip() {
        $(".tooltip").hide();
    }
    function loadGridView(data, empty) {
        var xml = $.parseXML(data);
        var row = empty;

        $("#<%=gvEmails.ClientID%> tr").not($("#<%=gvEmails.ClientID%> tr:first-child")).remove();


        $(xml).find("EmailTemplate").each(function (index, value) {

            $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton'/>");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");
            $("td", row).eq(2).html($(this).attr("EmailID"));
            $("td", row).eq(3).html($(this).attr("Module") == null ? '' : $(this).attr("Module"));
            $("td", row).eq(4).html($(this).attr("Action") == null ? '' : $(this).attr("Action"));
            $("td", row).eq(5).html($(this).attr("Subject") == null ? '' : shortenText($(this).attr("Subject")));
            $("td", row).eq(6).html($(this).attr("EmailFrom") == null ? '' : $(this).attr("EmailFrom"));
            $("td", row).eq(7).html($(this).attr("SMTPServer") == null ? '' : $(this).attr("SMTPServer"));

            $("#<%=gvEmails.ClientID%>").append(row);


            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeEmailTemplate($(value).attr("EmailID"), empty);
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function () {
                        if ($("#MODE").val() != 'EDIT')
                            $("#MODE").val('EDIT');

                        $("#EMAILID").val($(value).attr('EmailID'));

                        //bind email template data
                        var module = "'name':'" + $(value).attr("Module") + "'";

                        bindComboboxAjax('loadModules', '#<%=MODULCBox.ClientID%>', $(value).attr('Module'),"#MODUL_LD");
                        bindComboboxAjax('loadSMTPServers', '#<%=SMTPSRVCBox.ClientID%>', $(value).attr('SMTPServer'),"#SMTP_LD");
                        bindParamComboboxAjax('getModuleActions', "#<%=ACTCBox.ClientID%>", module, $(value).attr("Action"),"#ACT_LD");

                        $("#<%=SNDRTxt.ClientID%>").val($(value).attr("EmailFrom"));
                        $("#<%=SBJTxt.ClientID%>").val($(value).attr("Subject"));
                        $("#<%=BDYTxt.ClientID%>").val($(value).attr("Body"));

                        var controls = new Array();
                        controls.push("#<%=ATTRCBox.ClientID%>");
                        loadParamComboboxAjax('getModuleAttributes', controls, module, "#ATTR_LD");

                        // show module tooltip
                        if ($("#emailtooltip").is(":hidden")) {
                            $("#emailtooltip").slideDown(800, 'easeOutBounce');
                        }

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvEmails.ClientID%> tr:last-child").clone(true);
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
</script>
</asp:Content>
