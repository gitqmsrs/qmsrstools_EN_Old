<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageAuthorization.aspx.cs" Inherits="QMSRSTools.Administration.ManageAuthorization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Authorization_Header" class="moduleheader">Manage Authorization</div>

    <div class="toolbox">
        <img id="refreshauth" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="newauth" src="../Images/new_file.png" class="imgButton" title="Create new account" alt=""/>   
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
            
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byACCTYP">Filter By Account Type</li>
            </ul>
        </div>
        
        <div id="AccountContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AccountFilterLabel" style="width:100px;">Account Type:</div>
            <div id="AccountFilterField" style="width:170px; right:0; float:right;">
                <asp:DropDownList ID="ACCFLTRCBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
            <div id="ACCFLTR_LD" class="control-loader"></div>
        </div>
    </div>
    

    <div id="AUTHloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvUsers" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="UserID" HeaderText="ID" />
            <asp:BoundField DataField="Employee" HeaderText="Employee Name" />
            <asp:BoundField DataField="UserName" HeaderText="User Name" />
            <asp:BoundField DataField="AccountType" HeaderText="Account Type" />
            <asp:BoundField DataField="Permissions" HeaderText="Permissions" />
        </Columns>
        </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:550px;">
        <div id="header" class="modalHeader">User Details<span id="close" class="modalclose" title="Close">X</span></div>
        
         <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <input id="UserID" type="hidden" value="" />
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="AccountTypeLabel" class="requiredlabel">Account Type:</div>
            <div id="AccountTypeField" class="fielddiv" style="width:200px;">
                <asp:DropDownList ID="ACCCBox" runat="server" Width="200px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
            <div id="ACCTYP_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="ACCCTxtVal" runat="server" Display="None" ValidationGroup="General" ControlToValidate="ACCCBox" ErrorMessage="Select account type"></asp:RequiredFieldValidator>
            
            <asp:CompareValidator ID="ACCCVal" runat="server" ControlToValidate="ACCCBox" ValidationGroup="General" 
            Display="None" ErrorMessage="Select account type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        
       </div>

       <div id="EMP" style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="EmployeeNameLabel" class="requiredlabel">Employee:</div>
            <div id="EmployeeNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="EMPTxt" CssClass="readonly" Width="190px" runat="server"></asp:TextBox>
            </div>
            <span id="EMPSelect" class="searchactive" style="margin-left:10px" runat="server"></span>         
        </div>


       <div id="SLCTEMP" class="selectbox">
            <div id="delete" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="ORGUNTLabel" class="labeldiv" style="width:70px;">ORG. Unit</div>
                <div id="ORGUNTField" class="fielddiv" style="width:130px">
                    <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNT_LD" class="control-loader"></div>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="EmployeeLabel" class="labeldiv" style="width:70px;">Employee</div>
                <div id="EmployeeField" class="fielddiv" style="width:130px">
                    <asp:DropDownList ID="EMPCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="EMP_LD" class="control-loader"></div>
            </div>
        </div>
              
        <div id="USR" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
            <div id="UserNameLabel" class="requiredlabel">User Name:</div>
            <div id="UserNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="USRNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="NewPasswordLabel" class="requiredlabel">New Password:</div>
            <div id="NewPasswordField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="PWDTxt" CssClass="textbox" TextMode="Password" Width="190px" runat="server"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="PWDVal" runat="server" Display="None" ControlToValidate="PWDTxt" ErrorMessage="The password field cannot be empty" ValidationGroup="General" ></asp:RequiredFieldValidator>   
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ConfirmPasswordLabel" class="requiredlabel">Confirm Password:</div>
            <div id="ConfirmPasswordField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="CPWDTxt" CssClass="textbox" TextMode="Password" Width="190px" runat="server"></asp:TextBox>
            </div>
        
            <asp:RequiredFieldValidator ID="CPWDVal" runat="server" Display="None" ControlToValidate="CPWDTxt" ErrorMessage="Please confirm the new password" ValidationGroup="General" ></asp:RequiredFieldValidator>   
            <asp:CompareValidator id="comparePasswords" runat="server" ControlToCompare="PWDTxt" ControlToValidate="CPWDTxt" ErrorMessage="Passwords must match" Display="None" ValidationGroup="General"  />
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="PermissionsListLabel" class="labeldiv">Select Permissions:</div>
            <div id="PermissionsListField" class="fielddiv" style="width:250px">
                <div id="PRMCHK" class="checklist"></div>
            </div>
            <div id="PRM_LD" class="control-loader"></div>
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
<input id="DATA" type="hidden" value="" />

</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvUsers.ClientID%> tr:last-child").clone(true);

        /*load user records*/
        refreshUsers(empty);

        $("#newauth").bind('click', function ()
        {
            $("#validation_dialog_general").hide();

            $("#MODE").val('ADD');

            reset();

            loadComboboxAjax('loadUserType', "#<%=ACCCBox.ClientID%>", "#ACCTYP_LD");


            loadPermissions();

            $("#<%=alias.ClientID%>").trigger('click');

        });

        $("#deletefilter").bind('click', function () {
            hideAll();

            refreshUsers(empty);
        });
        $("#byACCTYP").bind('click', function () {
            hideAll();
            loadComboboxAjax('loadUserType', '#<%=ACCFLTRCBox.ClientID%>',"#ACCFLTR_LD");
            $("#AccountContainer").show();
        });

        $('#<%=ACCFLTRCBox.ClientID%>').change(function () {
            if ($(this).val() != 0) {
                filterByAccountType($(this).val(), empty);
            }
        });

        $("#<%=ACCCBox.ClientID%>").change(function () {
            if ($(this).val() == 'Employee Account') {
                $("#USR").hide();
                $("#EMP").show();

            }
            else if ($(this).val() == 'System Account') {
                $("#USR").show();
                $("#EMP").hide();
            }
        });
        $("#refreshauth").bind('click', function () {
            refreshUsers(empty);
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#<%=EMPSelect.ClientID%>").bind('click',function () {
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
            $("#SLCTEMP").show();
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            loadcontrols.push("#<%=EMPCBox.ClientID%>");
            loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EMP_LD");

        });

        $("#save").bind('click', function () 
        {
            var isPageValid = Page_ClientValidate('General');
            if (isPageValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD') {
                            var user =
                            {
                                Employee: $("#<%=EMPTxt.ClientID%>").val(),
                                Password: $("#<%=PWDTxt.ClientID%>").val(),
                                UserName: $("#<%=USRNMTxt.ClientID%>").val(),
                                AccountType: $("#<%=ACCCBox.ClientID%>").val(),
                                Permissions: getChecklistJSON()
                            }

                         
                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(user) + "\'}",
                                url: getServiceURL().concat('createNewUser'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refreshauth").trigger('click');
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(xhr.responseText);
                                    });
                                }
                            });

                        }
                        else
                        {
                            var user =
                            {
                                UserID: $("#UserID").val(),
                                Employee: $("#<%=EMPTxt.ClientID%>").val(),
                                Password: $("#<%=PWDTxt.ClientID%>").val(),
                                UserName: $("#<%=USRNMTxt.ClientID%>").val(),
                                UserName: $("#<%=USRNMTxt.ClientID%>").val(),
                                AccountType: $("#<%=ACCCBox.ClientID%>").val(),
                                Permissions: getChecklistJSON()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(user) + "\'}",
                                url: getServiceURL().concat('updateUser'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refreshauth").trigger('click');
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
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

        $("#delete").bind('click', function () {
            $("#SLCTEMP").hide('800');
        });

        $("#<%=EMPCBox.ClientID%>").change(function () {
            $("#SLCTEMP").hide('800');
            $("#<%=EMPTxt.ClientID%>").val($(this).val());
        });


    });
    function getChecklistJSON() {
        var checklist = new Array();
        $("#PRMCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function (index, value) {
                var Permission = null;

                if ($("#MODE").val() == 'ADD') {
                    if ($(value).is("[type=checkbox]")) {
                        if ($(value).is(":checked") == true) {
                            Permission =
                            {
                                KeyID: $(value).attr('id'),
                                Key: $(value).val()
                            };

                            checklist.push(Permission);
                        }
                    }
                }
                else {
                    if ($(value).is("[type=checkbox]")) {
                        if ($(value).parent().find('[type=hidden]').val() == 3 || $(value).parent().find('[type=hidden]').val() == 4) {
                            Permission =
                            {
                                KeyID: $(value).attr('id'),
                                Key: $(value).val(),
                                Status: $(value).parent().find('[type=hidden]').val()
                            };

                            checklist.push(Permission);
                        }
                    }
                }

            });
        });
        if (checklist.length == 0)
            return null;

        return checklist;
    }
    function bindPermissions(param)
    {
        $("#PRM_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");
            var permissions = $.parseXML(param);

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadPermissionsKey"),
                success: function (data)
                {
                    $("#PRM_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var checklist = $.parseXML(data.d);
                            $("#PRMCHK").empty();

                            $(checklist).find('Permission').each(function (index, value) {
                                var html = '';

                                html += "<div class='checkitem'>";
                                html += "<input type='checkbox' id='" + $(this).attr('KeyID') + "' name='checklist' value='" + $(this).attr('Key') + "'/><div class='checkboxlabel'>" + $(this).attr('Key') + "</div>";
                                html += "<input type='hidden' value='" + $(this).Status + "'/>";
                                html += "</div>";

                                $("#PRMCHK").append(html);

                                $(permissions).find('Permission').each(function (index, permission) {

                                    if ($(permission).attr('Key') == $(value).attr('Key')) {
                                        $("#" + $(value).attr('KeyID')).prop('checked', true);
                                    }
                                });

                                $("#" + $(value).attr('KeyID')).click(function () {
                                    if ($(this).is(':checked') == true) {
                                        $(this).parent().find('[type=hidden]').val(3);
                                    }
                                    else {
                                        $(this).parent().find('[type=hidden]').val(4);
                                    }
                                });

                            });

                        }
                        else {
                            $("#PRMCHK").empty();
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PRM_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });

    }
    function loadPermissions()
    {
        $("#PRM_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadPermissionsKey"),
                success: function (data)
                {
                    $("#PRM_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var checklist = $.parseXML(data.d);
                            var html = '';

                            $("#PRMCHK").empty();

                            $(checklist).find('Permission').each(function (index, value) {
                                html += "<div class='checkitem'>";
                                html += "<input type='checkbox' id='" + $(this).attr('KeyID') + "' name='checklist' value='" + $(this).attr('Key') + "'/><div class='checkboxlabel'>" + $(this).attr('Key') + "</div>";
                                html += "</div>";
                            });

                            $("#PRMCHK").append(html);
                        }
                        else
                        {
                            $("#PRMCHK").empty();
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PRM_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function removeUser(ID, empty) {
        var result = confirm("Are you sure you would like to remove the selected user?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'userID':'" + ID + "'}",
                url: getServiceURL().concat('removeUser'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");
                    $("#refreshauth").trigger('click');
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
    function filterByAccountType(type, empty)
    {
        $("#AUTHloader").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterByUserType'),
                success: function (data) {
                    $("#AUTHloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");
                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#AUTHloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showDialog('Error', r.Message);
                    });
                }
            });
        });
    }

    function refreshUsers(empty) {
        $("#AUTHloader").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('refreshUsers'),
                success: function (data) {
                    $("#AUTHloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#AUTHloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");


                        var r = jQuery.parseJSON(xhr.responseText);
                        showDialog('Error', r.Message);
                    });
                }
            });
        });
    }

    function loadGridView(data, empty) {
        var xmlUsers = $.parseXML(data);
        var row = empty;

        $("#<%=gvUsers.ClientID%> tr").not($("#<%=gvUsers.ClientID%> tr:first-child")).remove();

        $(xmlUsers).find('Users').each(function (i, user) {
            $("td", row).eq(0).html("<img id='delete_" + i + "' src='../Images/deletenode.png' class='imgButton'/>");
            $("td", row).eq(1).html("<img id='edit_" + i + "' src='../Images/edit.png' class='imgButton'/>");
            $("td", row).eq(2).html($(this).attr('UserID'));
            $("td", row).eq(3).html($(this).attr('Employee'));
            $("td", row).eq(4).html($(this).attr('UserName'));
            $("td", row).eq(5).html($(this).attr('AccountType'));  
            $("td", row).eq(6).html(formatPermessions($(this).attr('PermissionsString')));

            $("#<%=gvUsers.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeUser(parseInt($(user).attr("UserID")), empty);
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function ()
                    {
                        $("#validation_dialog_general").hide();

                        $("#UserID").val($(user).attr('UserID'));

                        if ($(user).attr('AccountType') == 'Employee Account') {
                            $("#USR").hide();
                            $("#EMP").show();

                            $("#<%=EMPTxt.ClientID%>").val($(user).attr('Employee'));
                        }
                        else if ($(user).attr('AccountType') == 'System Account') {
                            $("#USR").show();
                            $("#EMP").hide();

                            $("#<%=USRNMTxt.ClientID%>").val($(user).attr('UserName'));
                        }

                        bindComboboxAjax('loadUserType', "#<%=ACCCBox.ClientID%>", $(user).attr('AccountType'),"#ACCTYP_LD");

                        bindPermissions($(user).attr('PermissionsString'));

                        $("#MODE").val('EDIT');

                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }

            });
            row = $("#<%=gvUsers.ClientID%> tr:last-child").clone(true);
        });
    }
    function formatPermessions(data) {
        var xmlPermissions = $.parseXML(data);
        var result = '';

        $(xmlPermissions).find('Permission').each(function (index, value) {
            if (index == 0) {
                result += $(this).attr('Key');
            }
            else {
                result += "; " + $(this).attr('Key');
            }
        });

        return result;
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
</script>
</asp:Content>
