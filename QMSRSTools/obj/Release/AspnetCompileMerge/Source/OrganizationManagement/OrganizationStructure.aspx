<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="OrganizationStructure.aspx.cs" Inherits="QMSRSTools.OrganizationManagement.OrganizationStructure" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="ORG_Header" class="moduleheader">Manage Organization Structure</div>

    <div class="toolbox">
        <img id="save" src="../Images/save.png" alt="" title="Save Changes" class="imgButton" />
        <img id="refresh" src="../Images/refresh.png" alt="Refresh Data"  class="imgButton"/>
        <img id="delete" src="../Images/deletenode.png" alt="Remove Unit" class="imgButton" />

        <div id="new_div">
            <img id="new" src="../../Images/new_file.png" alt=""/>
            <ul class="contextmenu">
                <li id="addparent">Add New Main Unit</li>
                <li id="addchild">Add New Child Unit </li>
            </ul>
        </div>
    </div>
    <div id="orgtreemenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible; margin-top:10px; height:400px;">
        <div id="ORGwait" class="loader">
            <div class="waittext">Please Wait...</div>
        </div>
        <div id="orgtree"></div>
    </div>
    <div id="datafield" class="modulecontainer"  style="border: 1px solid #052556; overflow:visible; margin-top:10px; height:400px;">

         <div id="validation_dialog_unit" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Unit" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="UnitCodeLabel" class="requiredlabel">Unit Code:</div>
            <div id="UnitCodeField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="UNTCODETxt" runat="server" Width="140px" CssClass="textbox treefield"></asp:TextBox>
            </div>
            <div id="UNTCODElimit" class="textremaining"></div> 
        
            <asp:CustomValidator id="UNTCODETxtFVal" runat="server" ValidationGroup="Unit" 
            ControlToValidate = "UNTCODETxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="UnitNameLabel" class="requiredlabel">Unit Name:</div>
            <div id="UnitNameField" class="fielddiv" style="width:300px;">
                <asp:TextBox ID="UNTNMTxt" runat="server" CssClass="textbox treefield" Width="290px"></asp:TextBox>
            </div>
            <div id="UNTNMlimit" class="textremaining"></div> 
        
            <asp:CustomValidator id="UNTNMTxtFVal" runat="server" ValidationGroup="Unit" 
            ControlToValidate = "UNTNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CreateDateLabel" class="requiredlabel">Origination Date:</div>
            <div id="CreateDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CDATETxt" runat="server" Width="140px" CssClass="textbox treefield" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>    

            <asp:RegularExpressionValidator ID="CDATETxtFVal" runat="server" ControlToValidate="CDATETxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Unit"></asp:RegularExpressionValidator> 
            
            <asp:CustomValidator id="CDATETxtF2Val" runat="server" ValidationGroup="Unit" 
            ControlToValidate = "CDATETxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ParentUnitLabel" class="labeldiv">Related To:</div>
            <div id="ParentUnitField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="PRNTTxt" runat="server" ReadOnly="true" CssClass="readonly" Width="240px"></asp:TextBox>
            </div>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="HierarchyLevelLabel" class="labeldiv">Hierarchy Level:</div>
            <div id="HierarchyLevelField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="HIRLVLTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OrganizationLevelLabel" class="requiredlabel">Organization Level:</div>
            <div id="OrganizationLevelField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="ORGLVLCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="ORGLVL_LD" class="control-loader"></div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RegionLabel" class="requiredlabel">Location:</div>
            <div id="RegionField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="LOCCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="LOC_LD" class="control-loader"></div>
        </div>
    </div>
    
    <asp:Panel ID="Panel1" runat="server" CssClass="loadpanel" style="display:none">
        <div style="padding:8px">
            <h2>Save Changes...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="Panel1" PopupControlID="Panel1" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>
</div>
<script type="text/javascript" language="javascript">

    $(function ()
    {
        loadOrganizationUnit();

        $("#refresh").bind('click', function () {
            var result = confirm("Refreshing organization units might cause changes to be lost, are you sure you would like to continue?");
            if (result == true) {
                loadOrganizationUnit();
            }
        });


        $('#orgtree').bind('tree.click', function (event)
        {
            var node = event.node;
            var isPageValid = Page_ClientValidate('Unit');
            if (isPageValid) 
            {
                if (!$("#validation_dialog_unit").is(":hidden")) {
                    $("#validation_dialog_unit").hide();
                }

                if (node != null && node != false) {
                    ActivateAll(true);

                    $("#<%=UNTCODETxt.ClientID%>").val(node.Code);
                    $("#<%=UNTNMTxt.ClientID%>").val(node.name);
                    $("#<%=HIRLVLTxt.ClientID%>").val(node.Depth);

                    try {
                        $("#<%=CDATETxt.ClientID%>").val(new Date(parseInt(node.CreateDate.substr(6))).format("dd/MM/yyyy"));
                    }
                    catch (err) {
                        $("#<%=CDATETxt.ClientID%>").val(isNaN(node.CreateDate) == true ? '' : new Date(node.CreateDate).format("dd/MM/yyyy"));
                    }

                    $("#<%=PRNTTxt.ClientID%>").val(node.parent.name);

                    bindComboboxAjax('loadCountries', '#<%=LOCCBox.ClientID%>', node.Country, "#LOC_LD");
                    bindComboboxAjax('loadOrganizationLevel', '#<%=ORGLVLCBox.ClientID%>', node.ORGLevel, "#ORGLVL_LD");
                }
            }
            else
            {
                $("#validation_dialog_unit").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure the details in the input field are in the correct format");
                });

                return false;
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('Unit');
            if (isPageValid)
            {
                if (!$("#validation_dialog_unit").is(":hidden")) {
                    $("#validation_dialog_unit").hide();
                }

                var Json = $('#orgtree').tree('toJson');
                if (Json != null) {
                    var result = confirm('Are you sure you would like to save changes?');
                    if (result == true) {
                        saveData(Json);
                    }
                }
                else {
                    alert("There are no organization units which can be submitted");
                }
            }
            else
            {
                $("#validation_dialog_unit").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure the details in the input field are in the correct format");
                });
            }
        });

        $("#delete").bind('click', function () {
            var node = $('#orgtree').tree('getSelectedNode');
            if (node != null && node != false) {
                removeUnit(node);
            }
            else {
                alert("Please select organization unit");
            }
        });

        $("#<%=ORGLVLCBox.ClientID%>").change(function () {
            var node = $('#orgtree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status != 3) {
                    $('#orgtree').tree('updateNode', node,
                    {
                        ORGLevel: $(this).find('option:selected').text(),
                        Status: 2
                    });
                }
                else {
                    $('#orgtree').tree('updateNode', node,
                    {
                        ORGLevel: $(this).find('option:selected').text()
                    });
                }
            }
            else {
                alert("Please select organization unit");
                $(this).val(0);
            }

        });

        $("#<%=LOCCBox.ClientID%>").change(function ()
        {
            var node = $('#orgtree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if (node.Status != 3)
                {
                    $('#orgtree').tree('updateNode', node,
                    {
                        Country: $(this).find('option:selected').text(),
                        Status: 2
                    });
                }
                else {
                    $('#orgtree').tree('updateNode', node,
                    {
                        Country: $(this).find('option:selected').text()
                    });
                }
            }
            else
            {
                alert("Please select organization unit");

                $(this).val(0);
            }

        });

        $("#<%=UNTCODETxt.ClientID%>").keyup(function (event) {
            var node = $('#orgtree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status != 3) {
                    $('#orgtree').tree('updateNode', node,
                    {
                        Code: $(this).val(),
                        Status: 2
                    });
                }
                else {
                    $('#orgtree').tree('updateNode', node,
                    {
                        Code: $(this).val()
                    });
                }
            }
            else {
                return false;
            }
        });

        $("#<%=UNTNMTxt.ClientID%>").keyup(function (event) {
            var node = $('#orgtree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status != 3) {

                    $('#orgtree').tree('updateNode', node,
                    {
                        name: $(this).val(),
                        Status: 2
                    });
                }
                else {

                    $('#orgtree').tree('updateNode', node,
                    {
                        name: $(this).val(),
                    });
                }
            }
            else {
                return false;
            }
        });

        $("#<%=CDATETxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                var node = $('#orgtree').tree('getSelectedNode');
                if (node != null && node != false) {
                    var dateParts = date.split("/");

                    if (node.Status == 1) {
                        $('#orgtree').tree('updateNode', node,
                        {
                            CreateDate: new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]),
                            Status: 2
                        });

                    }
                    else {
                        $('#orgtree').tree('updateNode', node,
                        {
                            CreateDate: new Date(dateParts[2], (dateParts[1] - 1), dateParts[0])
                        });
                    }
                }
                else {
                    alert("Please select organization unit");
                    return false;
                }
            }
        });

        $("#<%=CDATETxt.ClientID%>").keyup(function (event) {
            var node = $('#orgtree').tree('getSelectedNode');
            if (node != null && node != false) {
                var dateParts = $(this).val().split("/");

                if (node.Status != 3) {
                    $('#orgtree').tree('updateNode', node,
                    {
                        CreateDate: new Date(dateParts[2], (dateParts[1] - 1), dateParts[0]),
                        Status: 2
                    });
                }
                else {
                    $('#orgtree').tree('updateNode', node,
                    {
                        CreateDate: new Date(dateParts[2], (dateParts[1] - 1), dateParts[0])
                    });
                }
            }
            else {
                alert("Please select organization unit");
                return false;
            }
        });


        $("#addparent").bind('click', function () {
            var todaypart = getDatePart(new Date().format("dd/MM/yyyy"));
            var today = new Date(todaypart[2], (todaypart[1] - 1), todaypart[0]);

            $("#orgtree").tree('appendNode',
            {
                label: 'new organization unit',
                Code: '',
                ORGLevel: '',
                Country: '',
                Depth: 1,
                CreateDate: today,
                Status: 3
            });
        });

        $("#addchild").bind('click', function () {
            var todaypart = getDatePart(new Date().format("dd/MM/yyyy"));
            var today = new Date(todaypart[2], (todaypart[1] - 1), todaypart[0]);

            var node = $('#orgtree').tree('getSelectedNode');
            if (node != null && node != false) {
                $("#orgtree").tree('appendNode',
                {
                    label: 'new related organization',
                    Depth: node.getLevel() + 1,
                    Code: '',
                    ORGLevel: '',
                    Country: '',
                    CreateDate: today,
                    Status: 3
                }, node);
            }
            else {
                alert("Please select organization unit");
            }
        });

    });

    function saveData(jsondata) {
        var jsonparam = JSON.stringify({ json: jsondata });
        jsonparam = jsonparam.replace(new RegExp(/\//g), '\\\\/');
        jsonparam = jsonparam.replace("{}", "null");

        $find('<%= ModalPopupExtender1.ClientID %>').show();

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: jsonparam,
            url: getServiceURL().concat("UploadOrganizationUnit"),
            success: function (data) {
                $find('<%= ModalPopupExtender1.ClientID %>').hide();
                alert(data.d);

                loadOrganizationUnit();
            },
            error: function (xhr, status, error) {
                $find('<%= ModalPopupExtender1.ClientID %>').hide();
                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);
            }
        });
    }

    function loadOrganizationUnit() {
        $("#ORGwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadOrganizationUnit"),
                success: function (data) {
                    $("#ORGwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            ActivateAll(false);

                            var existingjson = $('#orgtree').tree('toJson');
                            if (existingjson == null) {
                                $('#orgtree').tree(
                                {
                                    data: $.parseJSON(data.d),
                                    slide: false,
                                    autoOpen: true
                                });
                            }
                            else {
                                $('#orgtree').tree('loadData', $.parseJSON(data.d));
                            }
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ORGwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function removeUnit(selected) {
        if (selected.children.length > 0) {
            alert("Cannot remove the unit (" + selected.name + ") because there are related units which must be removed first");
        }
        else {
            if (selected.Status == 3) {
                $('#orgtree').tree('removeNode', selected);
                ActivateAll(false);
            }
            else {
                var result = confirm("Are you sure you would like to remove the unit (" + selected.name + ")?");
                if (result == true)
                {
                    $(".modulewrapper").css("cursor", "wait");

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'ID':'" + selected.ORGID + "'}",
                        url: getServiceURL().concat("RemoveOrganziationUnit"),
                        success: function (data)
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#refresh").trigger('click');
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
        }
    }

    function ActivateAll(isactive) {
        if (isactive == false) {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("textbox");
                $(this).addClass("readonly");
                $(this).attr('readonly', true);
            });

            $(".combobox").each(function () {
                $(this).attr('disabled', true);

            });

            $(".textremaining").each(function () {
                $(this).html('');
            });

        }
        else {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("readonly");
                $(this).addClass("textbox");

                $(this).attr('readonly', false);
            });


            $(".combobox").each(function () {
                $(this).attr('disabled', false);

            });
        }
    }

</script>
</asp:Content>
