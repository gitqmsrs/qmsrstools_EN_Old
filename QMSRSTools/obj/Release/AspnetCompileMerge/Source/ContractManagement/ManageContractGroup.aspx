<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageContractGroup.aspx.cs" Inherits="QMSRSTools.ContractManagement.ManageContractGroup" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">     
    <div id="ContractGroup_Header" class="moduleheader">Manage Contract Group</div>

     <div class="toolbox">
        <img id="newgroup" src="../Images/new_file.png" class="imgButton" title="Create new contract group" alt=""/>   
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refersh Data" alt="" />
     </div>

     <div id="GRPWait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
     </div>

     <div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
     
     <asp:GridView id="gvGroup" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="GroupID" HeaderText="ID" />
            <asp:BoundField DataField="GroupName" HeaderText="Group Name" />
            <asp:BoundField DataField="Duration" HeaderText="Duration" />
            <asp:BoundField DataField="IsConstraint" HeaderText="Is Maturity Constraint " />
        </Columns>
        </asp:GridView>
     </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="ModalExtender" runat="server" TargetControlID="alias" PopupControlID="modal" CancelControlID="cancel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>


    <asp:Panel ID="modal" runat="server" CssClass="modalPanel" style="height:350px;">
        <div id="header" class="modalHeader">Contract Group Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="GroupNameLabel" class="requiredlabel">Group Name:</div>
            <div id="GroupNameField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="GRPNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
            </div> 
            <div id="GRPlimit" class="textremaining"></div>
          
            <asp:RequiredFieldValidator ID="GRPNMVal" runat="server" Display="None" ControlToValidate="GRPNMTxt" ErrorMessage="Enter the name of the contract group" ValidationGroup="General" ></asp:RequiredFieldValidator>
        
            <asp:CustomValidator id="GRPNMTxtFVal" runat="server" Display="None" ValidationGroup="General" 
            ControlToValidate = "GRPNMTxt" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>  
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CNSMTRCheckLabel" class="labeldiv">Is a Constraint Maturity:</div>
            <div id="CNSMTRCheckField" class="fielddiv" style="width:250px;">
                <asp:CheckBox ID="CNSMTRCHK" runat="server" AutoPostBack="false" CssClass="checkbox" />
            </div>    
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ContractDurationLabel" class="labeldiv">Contract Duration:</div>
            <div id="ContractDurationField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="CONTDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:DropDownList ID="CONTPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                </asp:DropDownList>     
            </div>

            <div id="CONTRPRD_LD" class="control-loader"></div> 

            <ajax:FilteredTextBoxExtender ID="DURFEXT" runat="server" TargetControlID="CONTDURTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>
            
            <asp:CustomValidator id="CONTDURZVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CONTDURTxt" Display="None" ErrorMessage = "The duration of the contract group should be greater than zero"
            ClientValidationFunction="validateZero">
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


    <input id="MODE" type="hidden" value="" /> 
    <input id="GROUPID" type="hidden" value="" /> 
</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvGroup.ClientID%> tr:last-child").clone(true);

        /*load initial contract groups*/
        loadContractGroups(empty);

        /*refresh contract groups*/
        $("#refresh").bind('click', function ()
        {
            loadContractGroups(empty);
        });

        $("#<%=CNSMTRCHK.ClientID%>").change(function ()
        {
            if ($(this).is(":checked") == false)
            {
                $("#ContractDurationField").attr("disabled", true);
                $("#<%=CONTDURTxt.ClientID%>").val('');
                $("#<%=CONTDURTxt.ClientID%>").attr('readonly', true);
                $("#<%=CONTPRDCBox.ClientID%>").empty();

            }
            else
            {
                $("#ContractDurationField").attr("disabled", false);
                $("#<%=CONTDURTxt.ClientID%>").attr('readonly', false);

                loadComboboxAjax('loadPeriod', '#<%=CONTPRDCBox.ClientID%>',"#CONTRPRD_LD");
            }
        });

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#cancel").trigger('click');
            }
        });

        $("#newgroup").bind('click', function ()
        {
            $("#validation_dialog_general").hide();

            /*set the modification mode to add*/
            $("#MODE").val('ADD');
            reset();

            $("#<%=CNSMTRCHK.ClientID%>").empty();

            addWaterMarkText('The description of the contract group', '#<%=DESCTxt.ClientID%>');

            /*attach group name to limit plugin*/
            $("#<%=GRPNMTxt.ClientID%>").limit({ id_result: 'GRPlimit', alertClass: 'alertremaining', limit: 100 });

            $("#ContractDurationField").attr("disabled", true);
            $("#<%=CONTDURTxt.ClientID%>").val('');
            $("#<%=CONTDURTxt.ClientID%>").attr('readonly', true);
            $("#<%=CONTPRDCBox.ClientID%>").empty();

            /*trigger modal popup extender*/
            $("#<%=alias.ClientID%>").trigger('click');
        });


        $("#save").click(function ()
        {
            var isDetailsValid = Page_ClientValidate('General');
            if (isDetailsValid)
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
                            var group =
                            {
                                GroupName: $("#<%=GRPNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val()),
                                Duration: $("#<%=CONTDURTxt.ClientID%>").val() == '' ? 0 : $("#<%=CONTDURTxt.ClientID%>").val(),
                                Period: ($("#<%=CONTPRDCBox.ClientID%>").val() == 0 || $("#<%=CONTPRDCBox.ClientID%>").val() == null ? '' : $("#<%=CONTPRDCBox.ClientID%>").val()),
                                IsConstraint: $("#<%=CNSMTRCHK.ClientID%>").is(':checked')
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(group) + "\'}",
                                url: getServiceURL().concat('createContractGroup'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        loadContractGroups(empty);
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(r.Message);
                                    });
                                }
                            });
                        }
                        else {
                            var group =
                            {
                                GroupID: $("#GROUPID").val(),
                                GroupName: $("#<%=GRPNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val()),
                                Duration: $("#<%=CONTDURTxt.ClientID%>").val() == '' ? 0 : $("#<%=CONTDURTxt.ClientID%>").val(),
                                Period: ($("#<%=CONTPRDCBox.ClientID%>").val() == 0 || $("#<%=CONTPRDCBox.ClientID%>").val() == null ? '' : $("#<%=CONTPRDCBox.ClientID%>").val()),
                                IsConstraint: $("#<%=CNSMTRCHK.ClientID%>").is(':checked')
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(group) + "\'}",
                                url: getServiceURL().concat('updateContractGroup'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        loadContractGroups(empty);
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
    });

    function loadContractGroups(empty)
    {

        $("#GRPWait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadContractGroup'),
                success: function (data) {
                    $("#GRPWait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#GRPWait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvGroup.ClientID%> tr").not($("#<%=gvGroup.ClientID%> tr:first-child")).remove();

        $(xml).find("ContractGroup").each(function (index, value)
        {
            /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
            var date = new Date();

            $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");

            $("td", row).eq(2).html($(this).attr("GroupID"));
            $("td", row).eq(3).html($(this).attr("GroupName"));
            $("td", row).eq(4).html($(this).attr("Duration") == 0 ? '' : $(this).attr("Duration") + " " + $(this).attr("Period"));
            $("td", row).eq(5).html($(this).attr("IsConstraint") == 'true' ? 'Yes' : 'No');

            $("#<%=gvGroup.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        $("#validation_dialog_general").hide();

                        /*clear all fields*/
                        reset();

                        /*bind group ID for update purpose*/
                        $("#GROUPID").val($(value).attr("GroupID"));

                        /*bind the name of the group*/
                        $("#<%=GRPNMTxt.ClientID%>").val($(value).attr("GroupName"));

                        /*attach group name to limit plugin*/
                        $("#<%=GRPNMTxt.ClientID%>").limit({ id_result: 'GRPlimit', alertClass: 'alertremaining', limit: 100 });
                        $("#<%=GRPNMTxt.ClientID%>").keyup();

                        /*bind the duration of the group*/
                        $("#<%=CONTDURTxt.ClientID%>").val($(value).attr("Duration") == 0 ? '' : $(value).attr("Duration"));

                        /*bind review period*/
                        bindComboboxAjax('loadPeriod', '#<%=CONTPRDCBox.ClientID%>', $(value).attr("Period"), "#CONTRPRD_LD");

                        /*bind group description*/
                        if ($(value).attr("Description") == '') {
                            addWaterMarkText('The description of the contract group', '#<%=DESCTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text();
                        }

                       
                        if ($(value).attr("IsConstraint") == 'true')
                        {
                            $("#<%=CNSMTRCHK.ClientID%>").attr('checked', true);
                            $("#ContractDurationField").attr("disabled", false);
                            $("#<%=CONTDURTxt.ClientID%>").attr('readonly', false);
                        }
                        else
                        {
                            $("#<%=CNSMTRCHK.ClientID%>").attr('checked', false);
                            $("#ContractDurationField").attr("disabled", true);

                            $("#<%=CONTDURTxt.ClientID%>").val('');
                            $("#<%=CONTDURTxt.ClientID%>").attr('readonly', true);
                            $("#<%=CONTPRDCBox.ClientID%>").empty();
                        }

               
                        /* set the modification mode to update*/
                        $("#MODE").val('EDIT');

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }
                else if ($(this).attr('id').search('delete') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        removeContractGroup($(value).attr("GroupID"),empty);
                    });
                }
            });
            row = $("#<%=gvGroup.ClientID%> tr:last-child").clone(true);
        });
    }
    function removeContractGroup(groupID, empty)
    {
        var result = confirm("Are you sure you would like to remove the selected contract group?");
        if (result == true) {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'groupID':'" + groupID + "'}",
                url: getServiceURL().concat('removeContractGroup'),
                success: function (data)
                {
                    loadContractGroups(empty);
                },
                error: function (xhr, status, error)
                {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
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
