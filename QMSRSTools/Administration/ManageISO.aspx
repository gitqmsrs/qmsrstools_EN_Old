<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageISO.aspx.cs" Inherits="QMSRSTools.Administration.ManageISO" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="ISO_Header" class="moduleheader">Manage ISO Standards</div>
    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" />
     
        <div id="new_div">
            <img id="new" src="/Images/new_file.png" alt=""/>
            <ul class="contextmenu">
                <li id="addparent">Create New Root Process</li>
                <li id="addchild">Create New Child Process</li>
            </ul>
        </div>

        <img id="refresh" src="/Images/refresh.png" alt=""  class="imgButton" title="Refresh Data"/>
        <img id="delete" src="/Images/deletenode.png" class="imgButton" title="Remove Selected Process" alt=""/>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="ISOStandardLabel" class="requiredlabel">Select ISO Standard:</div>
        <div id="ISOStandardField" class="fielddiv" style="width:150px;">
            <asp:DropDownList ID="ISOSTDCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="ISOSTD_LD" class="control-loader"></div>

        <span id="ISOSelect" class="searchactive" title="Search for ISO Standards" style="margin-left:10px" runat="server"></span> 

        <asp:RequiredFieldValidator ID="ISOSTDTxtVal" runat="server" Display="None" ControlToValidate="ISOSTDCBox" ErrorMessage="Select ISO Standard" ValidationGroup="ISOSTD" ></asp:RequiredFieldValidator>
        
        <asp:CompareValidator ID="ISOSTDVal" runat="server" ControlToValidate="ISOSTDCBox"
        Display="None" ErrorMessage="Select ISO Standard" Operator="NotEqual" Style="position: static"
        ValueToCompare="0" ValidationGroup="ISOSTD"></asp:CompareValidator>
    </div>

    <div id="SearchStandard" class="selectbox">
        <div class="toolbox">
            <img id="refreshSTD" src="/Images/refresh.png" class="imgButton" alt="" title="Refresh ISO Standards"/>
            <img id="ISOADD" src="/Images/add.png" class="imgButton" alt="" title="Create new ISO Standard" />
  
            <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
        </div>
        
        <div id="FLTR_LD" class="control-loader"></div> 
        
        <div id="STDScroll" class="gridscroll">
            <asp:GridView id="gvISOStandards" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                    <asp:BoundField DataField="StandardID" HeaderText="ID" />
                    <asp:BoundField DataField="Standard" HeaderText="ISO Standard" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="ISOStandardHeader" class="modalHeader">ISO Standard Details<span id="close" class="modalclose" title="Close">X</span></div>

        <div id="ISOStandardSaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_standard">
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Standard" />
        </div>    
        
        <input id="StandardID" type="hidden" value="" />
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="ISONameLabel" class="requiredlabel">ISO Standard:</div>
            <div id="ISONameField" class="fielddiv" style="width:200px;">
                <asp:Label ID="ISOLabel" runat="server" Text="ISO" CssClass="readonly" style="width:30px;"></asp:Label>
               
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>
               
                <asp:TextBox ID="ISOSTDTxt" runat="server" Width="140px" CssClass="textbox"></asp:TextBox>
            </div>

            <asp:RequiredFieldValidator ID="ISOSTDNMVal" runat="server" Display="None" ValidationGroup="Standard" ControlToValidate="ISOSTDTxt" ErrorMessage="Enter the ISO standard (e.g. ISO9001)"></asp:RequiredFieldValidator>

            <ajax:FilteredTextBoxExtender ID="ISOSTDFExt" runat="server" TargetControlID="ISOSTDTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>
        </div>
        
         <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="ISODESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="ISODESCFVal" runat="server" ValidationGroup="Standard" 
            ControlToValidate = "ISODESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
       </div>

       <div class="buttondiv">
            <input id="savestandard" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
       </div> 
    </asp:Panel>

    <div id="isoprocesstreemenu" class="menucontainer" style="border: 1px solid #052556;  margin-top:10px; height:400px;">
    
        <div id="ISOwait" class="loader">
            <div class="waittext">Please Wait...</div>
        </div>
        <div id="processtree"></div>
    </div>

    <div id="isoprocessdatafield" class="modulecontainer" style="border: 1px solid #052556; margin-top:10px; height:400px;">
        
        <div id="validation_dialog_isoprocess" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="ISOProcess" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="TagNumberLabel" class="labeldiv">Checklist Tag Number:</div>
            <div id="TagNumberField" class="fielddiv" style="width:90px;">
                <asp:TextBox ID="TAGTxt" runat="server" CssClass="textbox treefield" Width="80px"></asp:TextBox> 
            </div>
        
            <asp:RegularExpressionValidator ID="TAGFVal" runat="server" ControlToValidate="TAGTxt"
            Display ="None" ErrorMessage="Enter digits for the Tag number (e.g. 2 or 2.2), and remove spaces if exist" ValidationExpression="^[\d]+([\.]+[\d]+)*$" ValidationGroup="ISOProcess"></asp:RegularExpressionValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="NameLabel" class="requiredlabel">ISO Checklist Name:</div>
            <div id="NameField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="ARCLNTxt" runat="server" CssClass="textbox treefield" Width="240px"></asp:TextBox>
            </div>
            <div id="CHKNMlimit" class="textremaining"></div> 
        
            <asp:CustomValidator id="ARCLNTxtFVal" runat="server" ValidationGroup="ISOProcess" 
            ControlToValidate = "ARCLNTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
              
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="ParentArticleLabel" class="labeldiv">Related to:</div>
            <div id="ParentArticleField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="PRNTARTTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="240px"></asp:TextBox>
            </div>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="ArticleDetailLabel" class="labeldiv">Description:</div>
            <div id="ArticleDetailField" class="fielddiv" style="width:400px; height:200px;">
                <asp:TextBox ID="DESCTxt" runat="server" CssClass="textbox treefield" Width="390px" Height="190px" TextMode="MultiLine"></asp:TextBox>
            </div>
        
            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="ISOProcess" 
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>   
        </div>       
    </div>       

    <asp:Panel ID="Panel2" runat="server" CssClass="loadpanel" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="Panel2" PopupControlID="Panel2" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    <input id="ISOSTD" type="hidden" value="" />

    <input id="MODE" type="hidden" value="" />

</div>

<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvISOStandards.ClientID%> tr:last-child").clone(true);

        /*Load all ISO standards*/
        loadXMLISOStandards();

        /*Deactivate all textboxes*/
        ActivateAll(false);

        $(".textbox").focus(function () {
            $(this).select();

            // Work around Chrome's little problem
            $(this).mouseup(function () {
                // Prevent further mouseup intervention
                $(this).unbind("mouseup");
                return false;
            });
        });


        $("#closeBox").bind('click', function () {
            $("#SearchStandard").hide('800');
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#refreshSTD").bind('click', function ()
        {
            loadISOStandards(empty);
        });

        $("#<%=ISOSelect.ClientID%>").bind('click', function (e)
        {

            showISOStandardDialog(e.pageX, e.pageY, empty);
        });

        /*Add new ISO standard*/
        $("#ISOADD").bind('click', function ()
        {
            
            /* clear all text and combo fields*/
            resetGroup(".modalPanel");

            addWaterMarkText('The description of the ISO standard', '#<%=ISODESCTxt.ClientID%>');
                       
            /* set modal mode to add*/
            $("#MODE").val('ADD');

            /*trigger modal popup extender*/
            $("#<%=alias.ClientID%>").trigger('click');
        });


        $("#<%=ISOSTDCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                /*load all correponding ISO processes*/
                loadProcesses($(this).val());

                /*temporarly store the ISO standard value*/
                $("#ISOSTD").val($(this).val());
            }
            else {
                $("#ISOSTD").val('');
                $('#processtree').tree('loadData', []);
            }
        });

        $("#addparent").bind('click', function () {
            if ($("#ISOSTD").val() != '') {
                $("#processtree").tree('appendNode',
                {
                    label: 'new ISO process',
                    Description: '',
                    ISOStandard: $("#<%=ISOSTDCBox.ClientID%>").find('option:selected').text(),
                    Status: 3
                });
            }
            else {
                alert("Please Select an ISO Standard");
            }

            //hideAll();
        });

        $("#refresh").bind('click', function () {
            if ($("#ISOSTD").val() != '') {
                var result = confirm("Refreshing data will cause all unsaved changes to be lost, are you sure you would like to continue?");
                if (result == true) {
                    loadProcesses($("#ISOSTD").val());
                }
            }
            else {
                alert("Please Select an ISO Standard");
            }
        });

        $("#delete").bind('click', function () {
            if ($("#ISOSTD").val() != '') {
                var node = $('#processtree').tree('getSelectedNode');
                if (node != null && node != false) {
                    removeProcess(node);
                }
                else {
                    alert("Please Select an ISO Process");
                }
            }
            else {
                alert("Please Select an ISO Standard");
            }
        });

        $("#addchild").bind('click', function () {
            if ($("#ISOSTD").val() != '') {
                var node = $('#processtree').tree('getSelectedNode');

                if (node != null && node != false) {
                    $("#processtree").tree('appendNode',
                    {
                        label: 'new ISO process',
                        Description: '',
                        ISOStandard: $("#<%=ISOSTDCBox.ClientID%>").find('option:selected').text(),
                       Status: 3
                   }, node);
               }
               else {
                   alert("Please Select an ISO Process");
               }
           }
           else {
               alert("Please Select an ISO Standard");
            }

            //hideAll();
        });

        $('#processtree').bind('tree.click', function (event)
        {
            var isPageValid = Page_ClientValidate('ISOProcess');
            if (isPageValid)
            {
                if (!$("#validation_dialog_isoprocess").is(":hidden")) {
                    $("#validation_dialog_isoprocess").hide();
                }

                var node = event.node;
                if (node != null && node != false)
                {
                    /*Activate All Fields*/
                    ActivateAll(true);

                    $("#<%=TAGTxt.ClientID%>").val(node.Tag);
                    $("#<%=ARCLNTxt.ClientID%>").val(node.name);
                    $("#<%=PRNTARTTxt.ClientID%>").val(node.parent.name);
                    $("#<%=DESCTxt.ClientID%>").html(node.Description).text();


                    /*attach process to limit plugin*/
                    $('#<%=ARCLNTxt.ClientID%>').limit({ id_result: 'CHKNMlimit', alertClass: 'alertremaining', limit: 100 });
                }
            }
            else
            {
                $("#validation_dialog_isoprocess").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure the details in the input field are in the correct format");
                });

                return false;
            }
        });

        $("#<%=DESCTxt.ClientID%>").keyup(function (event)
        {
            var node = $('#processtree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if (node.Status != 3)
                {
                    $('#processtree').tree('updateNode', node,
                    {
                        Description: escapeHtml($(this).val()),
                        Status: 2
                    });
                }
                else {
                    $('#processtree').tree('updateNode', node,
                    {
                        Description: escapeHtml($(this).val())
                    });
                }
            }
            else
            {
                return false;
            }
        });

        $("#<%=ARCLNTxt.ClientID%>").keyup(function (event) {

            var node = $('#processtree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status != 3) {
                    $('#processtree').tree('updateNode', node,
                    {
                        name: $(this).val(),
                        Status: 2
                    });
                }
                else {
                    $('#processtree').tree('updateNode', node,
                    {
                        name: $(this).val()
                    });
                }
            }
            else {
                return false;
            }
        });

        $("#<%=TAGTxt.ClientID%>").keyup(function (event) {

            var node = $('#processtree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status != 3) {
                    $('#processtree').tree('updateNode', node,
                    {
                        Tag: $(this).val(),
                        Status: 2
                    });
                }
                else {
                    $('#processtree').tree('updateNode', node,
                    {
                        Tag: $(this).val()
                    });
                }
            }
            else {
                return false;
            }
        });

        $("#savestandard").click(function ()
        {
            var isStandardValid = Page_ClientValidate('Standard');
            if (isStandardValid)
            {
                if (!$("#validation_dialog_standard").is(":hidden")) {
                    $("#validation_dialog_standard").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#ISOStandardSaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD')
                        {
                            var standard =
                            {
                                ISOName: 'ISO' + $("#<%=ISOSTDTxt.ClientID%>").val(),
                                Description: $("#<%=ISODESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ISODESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(standard) + "\'}",
                                url: getServiceURL().concat('createNewISO'),
                                success: function (data) {
                                    $("#ISOStandardSaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#closeBox").trigger('click');

                                        loadXMLISOStandards();

                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#ISOStandardSaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        showErrorNotification(r.Message);
                                    });
                                }
                            });
                        }
                        else if ($("#MODE").val() == 'EDIT') {
                            var standard =
                            {
                                ISOStandardID: $("#StandardID").val(),
                                ISOName: 'ISO' + $("#<%=ISOSTDTxt.ClientID%>").val(),
                                Description: $("#<%=ISODESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ISODESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(standard) + "\'}",
                                url: getServiceURL().concat('updateISO'),
                                success: function (data) {
                                    $("#ISOStandardSaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#closeBox").trigger('click');

                                        loadXMLISOStandards();
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#ISOStandardSaveTooltip").fadeOut(500, function () {
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
            else {
                $("#validation_dialog_standard").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });

        $("#save").bind('click', function ()
        {
            var isSelectValid = Page_ClientValidate('ISOSTD');
            if (isSelectValid)
            {
                var isTreeFieldValid = Page_ClientValidate('ISOProcess');
                if (isTreeFieldValid)
                {
                    if (!$("#validation_dialog_isoprocess").is(":hidden"))
                    {
                        $("#validation_dialog_isoprocess").hide();
                    }

                    var Json = $('#processtree').tree('toJson');
                    if (Json != null)
                    {
                        var result = confirm("Are you sure you would like to commit changes?");
                        if (result == true) {
                            saveData(Json);
                        }
                    }
                    else
                    {
                        alert("There are no ISO processes which can be submitted");
                    }
                }
                else
                {
                    $("#validation_dialog_isoprocess").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure the details in the input field are in the correct format");
                    });
                }
            }
            else {
                alert("Please select ISO standard");
            }
        });
    });

    function saveData(jsondata) {
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
            url: getServiceURL().concat("UploadISOProcess"),
            success: function (data) {
                $find('<%= SaveExtender.ClientID %>').hide();

                showSuccessNotification(data.d);
                loadProcesses($("#ISOSTD").val());
            },
            error: function (xhr, status, error) {
                $find('<%= SaveExtender.ClientID %>').hide();
                var r = jQuery.parseJSON(xhr.responseText);
                showErrorNotification(r.Message);
            }
        });
    }

    function loadProcesses(ISOSTD) {

        /*Deactivate all fields to prevent modification*/
        ActivateAll(false);

        $("#ISOwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'isoname':'" + ISOSTD + "'}",
                url: getServiceURL().concat("loadISOProcesses"),
                success: function (data)
                {
                    $("#ISOwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var existingjson = $('#processtree').tree('toJson');

                            if (existingjson == null) {
                                $('#processtree').tree(
                                {
                                    data: $.parseJSON(data.d),
                                    slide: true,
                                    autoOpen: true
                                });
                            }
                            else {
                                $('#processtree').tree('loadData', $.parseJSON(data.d));
                            }
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ISOwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadXMLISOStandards() {

        $("#ISOSTD_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISOStandards"),
                success: function (data) {
                    $("#ISOSTD_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'ISOStandard', 'ISOName', $("#<%=ISOSTDCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ISOSTD_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadISOStandards(empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISOStandards"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadISOGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadISOGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvISOStandards.ClientID%> tr").not($("#<%=gvISOStandards.ClientID%> tr:first-child")).remove();

        $(xml).find("ISOStandard").each(function (index, value) {

            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");
            $("td", row).eq(2).html($(this).attr("ISOStandardID"));
            $("td", row).eq(3).html($(this).attr("ISOName"));
            $("td", row).eq(4).html($(this).attr("Description"));

            $("#<%=gvISOStandards.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeISOStandard($(value).attr('ISOStandardID'));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function ()
                    {
                     
                        /* clear all text and combo fields*/
                        resetGroup(".modalPanel");

                        /*set the mode to edit*/
                        $("#MODE").val('EDIT');

                        /* bind the ID of the risk category*/
                        $("#StandardID").val($(value).attr("ISOStandardID"));

                        var std = $(value).attr("ISOName");

                        /*bind the name of the iso standard*/
                        $("#<%=ISOSTDTxt.ClientID%>").val(std.substring(3, std.length));

                        /*bind the description of the risk category*/
                        if ($(value).attr("Description") == '') {
                            addWaterMarkText('The description of the ISO standard', '#<%=ISODESCTxt.ClientID%>');
                        }
                        else {
                            if ($("#<%=ISODESCTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=ISODESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=ISODESCTxt.ClientID%>").val($("#<%=ISODESCTxt.ClientID%>").html($(value).attr("Description")).text());
                        }

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvISOStandards.ClientID%> tr:last-child").clone(true);

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

    function removeISOStandard(standardID)
    {
        var result = confirm("Removing the current ISO standard, might cause other related ISO articles to be removed, are you sure you would like to continue?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'standardID':'" + standardID + "'}",
                url: getServiceURL().concat("removeISOStandard"),
                success: function (data) {
                    $(".modulewrapper").css("cursor", "default");

                    loadXMLISOStandards();

                    $("#closeBox").trigger('click');
                },
                error: function (xhr, status, error) {
                    $(".modulewrapper").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }
    }

    function removeProcess(selected) {
        if (selected != false) {
            if (selected.children.length > 0) {
                alert("Cannot remove the process(" + selected.name + ") because there is/are (" + selected.children.length + ") assciated processe(s) which must be removed first");
            }
            else {
                if (selected.Status == 3) {
                    $('#processtree').tree('removeNode', selected);
                    ActivateAll(false);
                }
                else
                {
                    var result = confirm("Removing process(" + selected.name + "), might be also removed in the checklist of a prticular Internal Audit record, do you want to continue?");
                    if (result == true)
                    {
                        $(".modulewrapper").css("cursor", "wait");

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{'processID':'" + selected.ISOProcessID + "'}",
                            url: getServiceURL().concat("removeISOProcess"),
                            success: function (data)
                            {
                                $(".modulewrapper").css("cursor", "default");

                                loadProcesses($("#ISOSTD").val());
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
            }
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

    function showISOStandardDialog(x, y, empty)
    {
        loadISOStandards(empty);

        $("#SearchStandard").css({ left: x - 280, top: y + 10 });
        $("#SearchStandard").css({ width: 700, height: 250 });
        $("#SearchStandard").show();
    }
    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
    function hideAll() {
        $(".contextmenu").hide();
    }
</script>
</asp:Content>
