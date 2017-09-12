<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageCostCentre.aspx.cs" Inherits="QMSRSTools.Administration.ManageCostCentre" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="CostCentre_Header" class="moduleheader">Manage Cost Centre</div>

    <div class="toolbox">
        <img id="newcostcentre" src="../Images/new_file.png" class="imgButton" title="Create new cost centre" alt=""/>  
        <img id="refreshcentre" src="../Images/refresh.png" class="imgButton" title="Refersh date" alt="" />
    </div>

    <div id="CENTREloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvCentre" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="CentreID" HeaderText="ID" />
                <asp:BoundField DataField="CentreName" HeaderText="Cost Centre Name" />
                <asp:BoundField DataField="Unit" HeaderText="Allocated for Unit" />
                <asp:BoundField DataField="Manager" HeaderText="Manager" />
        </Columns>
        </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
       <div id="header" class="modalHeader">Cost Centre Details<span id="close" class="modalclose" title="Close">X</span></div>
       
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>
       <input id="CentreID" type="hidden" value="" />
      
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CentreNameLabel" class="requiredlabel">Cost Centre Name:</div>
            <div id="CentreNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="CTRNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
        
            <div id="CNTRlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="CTRNMTxtVal" runat="server" Display="None" ControlToValidate="CTRNMTxt" ErrorMessage="Enter the name of the cost centre" ValidationGroup="General"></asp:RequiredFieldValidator> 
            
            <asp:CustomValidator id="CTRNMTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CTRNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
       </div>

       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OrganizationUnitLabel" class="requiredlabel">ORG. Unit:</div>
            <div id="OrganizationUnitField" class="fielddiv" style="width:300px;">
                <asp:DropDownList ID="ORGUNTCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>    
            <div id="UNIT_LD" class="control-loader"></div>   
        
            <asp:RequiredFieldValidator ID="ORGUNTTxtVal" runat="server" Display="None" ControlToValidate="ORGUNTCBox" ErrorMessage="Select an organization unit" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
            <asp:CompareValidator ID="ORGUNTVal" runat="server" ControlToValidate="ORGUNTCBox" ValidationGroup="General"
            Display="None" ErrorMessage="Select an organization unit" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
       </div>
        
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ManagerLabel" class="requiredlabel">Manager:</div>
            <div id="ManagerField" class="fielddiv" style="width:300px;">
                <asp:DropDownList ID="MGRCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>    
            <div id="EMP_LD" class="control-loader"></div>   
        
            <asp:RequiredFieldValidator ID="MGRCBoxTxtVal" runat="server" Display="None" ControlToValidate="MGRCBox" ErrorMessage="Select a manager" ValidationGroup="General"></asp:RequiredFieldValidator>         
            
            <asp:CompareValidator ID="MGRCBoxVal" runat="server" ControlToValidate="MGRCBox" ValidationGroup="General"
            Display="None" ErrorMessage="Select a manager" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
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

    $(function ()
    {
        var empty = $("#<%=gvCentre.ClientID%> tr:last-child").clone(true);

        /*load all cost centres*/
        refresh(empty);

        $("#refreshcentre").bind('click', function () {
            refresh(empty);
        });

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var controls = new Array();
                controls.push('#<%=MGRCBox.ClientID%>');
                loadParamComboboxAjax('getDepEmployees', controls, "'unit':'" + $(this).val() + "'", "#EMP_LD");
            }
        });

        $("#newcostcentre").bind('click', function ()
        {
            $("#validation_dialog_general").hide();

            reset();

            loadComboboxAjax('getOrganizationUnits', '#<%=ORGUNTCBox.ClientID%>',"#UNIT_LD");

            $('#<%=MGRCBox.ClientID%>').empty();

            /*attach cost centre name to limit plugin*/
            $("#<%=CTRNMTxt.ClientID%>").limit({ id_result: 'CNTRlimit', alertClass: 'alertremaining', limit: 100 });

            /*set modal mode to add*/
            $("#MODE").val('ADD');

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#save").click(function ()
        {
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


                        if ($("#MODE").val() == 'ADD') {
                            var costcentre =
                            {
                                CostCentreName: $("#<%=CTRNMTxt.ClientID%>").val(),
                                ORGUnit: $("#<%=ORGUNTCBox.ClientID%>").val(),
                                Manager: $("#<%=MGRCBox.ClientID%>").val()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(costcentre) + "\'}",
                                url: getServiceURL().concat('createCostCentre'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refreshcentre").trigger('click');
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
                        else if ($("#MODE").val() == 'EDIT') {
                            var costcentre =
                            {
                                CostCentreID: $("#CentreID").val(),
                                CostCentreName: $("#<%=CTRNMTxt.ClientID%>").val(),
                                ORGUnit: $("#<%=ORGUNTCBox.ClientID%>").val(),
                                Manager: $("#<%=MGRCBox.ClientID%>").val()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(costcentre) + "\'}",
                                url: getServiceURL().concat('updateCostCentre'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refreshcentre").trigger('click');
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
    function removeCostCentre(centreid, empty)
    {
        var result = confirm("Are you sure you would like to remove the current cost centre record?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               data: "{'ID':'" + centreid + "'}",
               url: getServiceURL().concat("removeCostCentre"),
               success: function (data)
               {
                   $(".modulewrapper").css("cursor", "default");

                   refresh(empty);
               },
               error: function (xhr, status, error) {
                   $(".modulewrapper").css("cursor", "default");

                   var r = jQuery.parseJSON(xhr.responseText);
                   alert(r.Message);
               }
           });
        }
    }
    function refresh(empty)
    {
        $("#CENTREloader").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCostCentres"),
                success: function (data) {
                    $("#CENTREloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");
                        loadGridView(data.d, empty);
                    });

                },
                error: function (xhr, status, error) {
                    $("#CENTREloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvCentre.ClientID%> tr").not($("#<%=gvCentre.ClientID%> tr:first-child")).remove();


        $(xml).find("CostCentre").each(function (index, value) {

            $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'  />");
            $("td", row).eq(2).html($(this).attr("CostCentreID"));
            $("td", row).eq(3).html($(this).attr("CostCentreName"));
            $("td", row).eq(4).html($(this).attr("ORGUnit"));
            $("td", row).eq(5).html($(this).attr("Manager"));


            $("#<%=gvCentre.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeCostCentre($(value).attr("CostCentreID"), empty);
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function ()
                    {
                        $("#validation_dialog_general").hide();

                        reset();

                        /*set the mode to edit*/
                        $("#MODE").val('EDIT');

                        /* bind the ID of the cost centre*/
                        $("#CentreID").val($(value).attr("CostCentreID"));

                        /*bind the name of the cost centre*/
                        $("#<%=CTRNMTxt.ClientID%>").val($(value).attr("CostCentreName"));

                        /*bind organization unit*/
                        bindComboboxAjax('getOrganizationUnits', '#<%=ORGUNTCBox.ClientID%>', $(value).attr('ORGUnit'), "#UNIT_LD");

                        /*bind manager*/
                        bindParamComboboxAjax('getDepEmployees', '#<%=MGRCBox.ClientID%>', "'unit':'" + $(value).attr('ORGUnit') + "'", $(value).attr("Manager"), "#EMP_LD");

                        /*attach cost centre name to limit plugin*/
                        $("#<%=CTRNMTxt.ClientID%>").limit({ id_result: 'CNTRlimit', alertClass: 'alertremaining', limit: 100 });

                        $("#<%=CTRNMTxt.ClientID%>").keyup();

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvCentre.ClientID%> tr:last-child").clone(true);
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
