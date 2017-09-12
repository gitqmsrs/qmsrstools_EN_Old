<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageCauses.aspx.cs" Inherits="QMSRSTools.Administration.ManageCauses" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Causes_Header" class="moduleheader">Manage Causes</div>

    <div class="toolbox">
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt="" />
     
        <div id="new_div">
            <img id="new" src="../Images/new_file.png" alt=""/>
            <ul class="contextmenu">
                <li id="addparent">Create New Root Cause</li>
                <li id="addchild">Create New Child Cause</li>
            </ul>
        </div>

        <img id="refresh" src="../Images/refresh.png" alt=""  class="imgButton" title="Refresh Data"/>
        <img id="delete" src="../Images/deletenode.png" class="imgButton" title="Remove Selected Cause" alt=""/>
    </div>

    <div id="causestreemenu" class="menucontainer" style="border: 1px solid #052556; width:25%; overflow:visible; margin-top:10px;">
    
        <div id="Causewait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>
        <div id="causetree"></div>
    </div>

    <div id="causesdatafield" class="modulecontainer" style="border: 1px solid #052556; width:74%; overflow:visible; margin-top:10px;">
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="NameLabel" class="requiredlabel">Cause Name:</div>
            <div id="NameField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="CAUSNMTxt" runat="server" CssClass="textbox treefield" Width="240px"></asp:TextBox>
            </div>
            <div id="CAUSNMlimit" class="textremaining"></div>      
            
          
            <asp:CustomValidator id="CAUSNMTxtFVal" runat="server" ValidationGroup="cause" 
            ControlToValidate = "CAUSNMTxt" CssClass="validator" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="ParentCauseLabel" class="labeldiv">Related to:</div>
            <div id="ParentCauseField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="PRNTCAUSTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="240px"></asp:TextBox>
            </div>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="CauseDetailLabel" class="labeldiv">Description:</div>
            <div id="CauseDetailField" class="fielddiv" style="width:400px; height:200px;">
                <asp:TextBox ID="CAUSDESCTxt" runat="server" CssClass="textbox treefield" Width="390px" Height="190px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="CAUSDESCTxtVal" runat="server" ValidationGroup="cause" 
            ControlToValidate = "CAUSDESCTxt" CssClass="validator" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>   
    </div>

    
    <asp:Panel ID="Panel1" runat="server" CssClass="loadpanel" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="Panel1" PopupControlID="Panel1" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>
</div>
<script type="text/javascript" language="javascript">
        $(function ()
        {
            /* load all causes in the database*/
            loadCauses();

            $("#refresh").bind('click', function ()
            {
                var result = confirm("Reloading causes might cause modifications to be lost, are you sure you would like to continue?");
                if (result == true) {
                    loadCauses();
                }
            });

            $(".textbox").focus(function () {
                $(this).select();

                // Work around Chrome's little problem
                $(this).mouseup(function () {
                    // Prevent further mouseup intervention
                    $(this).unbind("mouseup");
                    return false;
                });
            });

            $("#addparent").bind('click', function ()
            {
                $("#causetree").tree('appendNode',
                    {
                        label: 'new root cause',
                        Description: '',
                        Status: 3

                    });
            });
       
            $("#addchild").bind('click', function ()
            {
                var node = $('#causetree').tree('getSelectedNode');

                if (node != null && node != false) {
                    $("#causetree").tree('appendNode',
                    {
                        label: 'new sub cause',
                        Description: '',
                        Status: 3
                    }, node);
                }
                else {
                    alert("Please Select a Cause");
                }
            });

            $('#causetree').bind('tree.click', function (event)
            {
                var isPageValid = Page_ClientValidate('cause');
                if (isPageValid) {

                    var node = event.node;
                    if (node != null && node != false)
                    {
                        /*Activate All Fields*/
                        ActivateAll(true);

   
                        $("#<%=CAUSNMTxt.ClientID%>").val(node.name);
                        $("#<%=PRNTCAUSTxt.ClientID%>").val(node.parent.name);
                        $("#<%=CAUSDESCTxt.ClientID%>").html(node.Description).text();


                        /*attach cause name to limit plugin*/
                        $('#<%=CAUSNMTxt.ClientID%>').limit({ id_result: 'CAUSNMlimit', alertClass: 'alertremaining', limit: 100 });
                        
                    }
                }
                else
                {
                    alert("Please correct the details in the input fields");
                    return false;
                }
            });


            $("#<%=CAUSDESCTxt.ClientID%>").keyup(function (event)
            {
                var node = $('#causetree').tree('getSelectedNode');
                if (node != null && node != false) {
                    if (node.Status != 3) {
                        $('#causetree').tree('updateNode', node,
                        {
                            Description: escapeHtml($(this).val()),
                            Status: 2
                        });
                    }
                    else {
                        $('#causetree').tree('updateNode', node,
                        {
                            Description: escapeHtml($(this).val())
                        });
                    }
                }
                else {
                    return false;
                }
            });

            $("#<%=CAUSNMTxt.ClientID%>").keyup(function (event)
            {
                var node = $('#causetree').tree('getSelectedNode');
                if (node != null && node != false)
                {
                    if (node.Status != 3)
                    {
                        $('#causetree').tree('updateNode', node,
                        {
                            name: $(this).val(),
                            Status: 2
                        });
                    }
                    else
                    {
                        $('#causetree').tree('updateNode', node,
                        {
                            name: $(this).val()
                        });
                    }
                }
                else {
                    return false;
                }
            });


            $("#delete").bind('click', function ()
            {
                var node = $('#causetree').tree('getSelectedNode');
                if (node != null && node != false)
                {
                    removeCause(node);
                }
                else {
                    alert("Please Select a Cause");
                }

            });

            $("#save").bind('click', function ()
            {
                var isCauseValid = Page_ClientValidate('cause');
                if (isCauseValid) {
                    var Json = $('#causetree').tree('toJson');
                    if (Json != null) {
                        var result = confirm("Are you sure you would like to commit changes?");
                        if (result == true) {
                            saveData(Json);
                        }
                    }
                    else
                    {
                        alert("There are no causes which can be submitted");
                    }
                }
                else
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                }
            });
            

        });

        function saveData(jsondata)
        {
            var jsonparam = JSON.stringify({ json: jsondata });
            jsonparam = jsonparam.replace(new RegExp(/\//g), '\\\\/');
            jsonparam = jsonparam.replace("{}", "null");

            $find('<%= SaveExtender.ClientID %>').show();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: jsonparam,
                url: getServiceURL().concat("UploadCauses"),
                success: function (data)
                {
                    $find('<%= SaveExtender.ClientID %>').hide();

                    alert(data.d);
                    loadCauses();
                },
                error: function (xhr, status, error) {
                    $find('<%= SaveExtender.ClientID %>').hide();
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }

        function removeCause(selected)
        {
            if (selected != false) {
                if (selected.children.length > 0)
                {
                    alert("Cannot remove the cause(" + selected.name + ") because there is/are (" + selected.children.length + ") assciated cause(s) which must be removed first");
                }
                else
                {
                    if (selected.Status == 3)
                    {
                        $('#causetree').tree('removeNode', selected);
                        ActivateAll(false);
                    }
                    else
                    {
                        var result = confirm("Are you sure you would like to remove the cause (" + selected.name + ") ?");
                        if (result == true)
                        {
                            $(".modulewrapper").css("cursor", "wait");

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{'causeID':'" + selected.CauseID + "'}",
                                url: getServiceURL().concat("removeCause"),
                                success: function (data)
                                {
                                    $(".modulewrapper").css("cursor", "default");

                                    loadCauses();
                                },
                                error: function (xhr, status, error) {
                                    $(".modulewrapper").css("cursor", "default");

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);
                                }
                            });
                        }
                    }
                }
            }
        }
        function loadCauses()
        {

            /*Deactivate all fields to prevent modification*/
            ActivateAll(false);

            $("#Causewait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadAllCauses"),
                    success: function (data) {
                        if (data) {
                            $("#Causewait").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                var existingjson = $('#causetree').tree('toJson');

                                if (existingjson == null) {
                                    $('#causetree').tree(
                                    {
                                        data: $.parseJSON(data.d),
                                        slide: true,
                                        autoOpen: false
                                    });
                                }
                                else {
                                    $('#causetree').tree('loadData', $.parseJSON(data.d));
                                }
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        $("#Causewait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
        function ActivateAll(isactive) {
            if (isactive == false) {
                $(".treefield").each(function () {
                    $(this).val('');
                    $(this).removeClass("textbox");
                    $(this).addClass("readonly");
                    $(this).attr('readonly', true);
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
            }
        }
    </script>
</asp:Content>
