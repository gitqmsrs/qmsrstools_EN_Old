<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="ManageRiskCategory.aspx.cs" Inherits="QMSRSTools.RiskManagement.ManageRiskCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="RISKCAT_Header" class="moduleheader">Manage Risk Category</div>

    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" />
        <img id="new" src="/Images/new_file.png" class="imgButton" title="Create New Subcategory" alt=""/>  
        <img id="refresh" src="/Images/refresh.png" alt=""  class="imgButton" title="Refresh Data"/>
        <img id="delete" src="/Images/deletenode.png" class="imgButton" title="Remove Selected Subcategory" alt=""/>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="RiskCategoryLabel" class="requiredlabel">Select Risk Category:</div>
        <div id="RiskCategoryField" class="fielddiv" style="width:150px;">
            <asp:DropDownList ID="RSKCATCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="RSKCAT_LD" class="control-loader"></div>

        <span id="CATADD" class="addnew" style="" runat="server" title="Create new risk category"></span>
        
        <span id="CATSelect" class="searchactive" title="Search for categories" style="margin-left:10px" runat="server"></span> 
        
        <asp:RequiredFieldValidator ID="RSKCATTxtVal" runat="server" Display="None" ControlToValidate="RSKCATCBox" ErrorMessage="Select risk category" ValidationGroup="General" ></asp:RequiredFieldValidator>
    
        <asp:CompareValidator ID="RSKCATVal" runat="server" ControlToValidate="RSKCATCBox"
        Display="None" ErrorMessage="Select risk category" Operator="NotEqual" Style="position: static"
        ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
    </div>

    <div id="SearchCategory" class="selectbox">
        <div class="toolbox">
            <img id="refreshcategories" src="/Images/refresh.png" class="imgButton" alt="" title="Refresh Categories"/>

             <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
        </div>
        
        <div id="FLTR_LD" class="control-loader"></div> 
        
        <div id="CategoryScroll" class="gridscroll">
            <asp:GridView id="gvCategories" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                    <asp:BoundField DataField="CategoryID" HeaderText="Category ID" />
                    <asp:BoundField DataField="Category" HeaderText="Category Name" />
                    <asp:BoundField DataField="Description" HeaderText="Description" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

     <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CategoryHeader" class="modalHeader">Risk Category Details<span id="close" class="modalclose" title="Close">X</span></div>

        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_category">
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Category" />
        </div>    
        
        <input id="CategoryID" type="hidden" value="" />
      
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CategoryNameLabel" class="requiredlabel">Category Name</div>
            <div id="CategoryNameField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="CATNMTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div> 
             <div id="CATNMlimit" class="textremaining"></div>   
       
            <asp:RequiredFieldValidator ID="CATNMVal" runat="server" Display="None" ControlToValidate="CATNMTxt" ErrorMessage="Enter the name of the risk category" ValidationGroup="Category"></asp:RequiredFieldValidator> 
            
            <asp:CustomValidator id="CATNMTxtFVal" runat="server" ValidationGroup="Category" 
            ControlToValidate = "CATNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="Category" 
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
       </div>

       <div class="buttondiv">
            <input id="savecategory" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>

    <div id="subcattreemenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible; margin-top:10px; height:300px;">
        <div id="SUBCATWait" class="loader">
            <div class="waittext">Please Wait...</div>
        </div>

        <div id="subcattree"></div>
    </div>

    <div id="subcatdatafield" class="modulecontainer" style="border: 1px solid #052556; overflow:visible; margin-top:10px; height:300px;">
        
        <div id="validation_dialog_subcategory" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Subcategory" />
        </div> 
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="SUBCATNameLabel" class="labeldiv">Subcategory Name:</div>
            <div id="SUBCATNameField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="SUBCATTxt" runat="server" CssClass="textbox treefield" Width="240px"></asp:TextBox> 
            </div>
            
            <asp:CustomValidator id="SUBCATTxtVal" runat="server" ValidationGroup="Subcategory" 
            ControlToValidate = "SUBCATTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
    
         </div>
        
         <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="SUBCATDescriptionLabel" class="labeldiv">Description:</div>
            <div id="SUBCATDescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="SUBCATDESCTxt" runat="server"  CssClass="textbox treefield" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="SUBCATDESCFVal" runat="server" ValidationGroup="Subcategory" 
            ControlToValidate = "SUBCATDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>       
    </div>       

    <asp:Panel ID="Panel2" runat="server" CssClass="savepanel" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="Panel2" PopupControlID="Panel2" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    <input id="Category" type="hidden" value="" />
    <input id="MODE" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var categoryempty = $("#<%=gvCategories.ClientID%> tr:last-child").clone(true);

        /*Deactivate all textboxes*/
        ActivateAll(false);

        loadXMLRiskCategory();

        $(".textbox").focus(function () {
            $(this).select();

            // Work around Chrome's little problem
            $(this).mouseup(function () {
                // Prevent further mouseup intervention
                $(this).unbind("mouseup");
                return false;
            });
        });

        /*Add new risk category*/
        $("#<%=CATADD.ClientID%>").bind('click', function ()
        {
            /* clear all text and combo fields*/
            resetGroup(".modalPanel");

            /*attach category name to limit plugin*/
            $("#<%=CATNMTxt.ClientID%>").limit({ id_result: 'CATNMlimit', alertClass: 'alertremaining', limit: 90 });

            addWaterMarkText('The description of the risk category', '#<%=DESCTxt.ClientID%>');

            /* set modal mode to add*/
            $("#MODE").val('ADD');

            /*trigger modal popup extender*/
            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#refreshcategories").bind('click', function ()
        {
            loadRiskCategories(categoryempty);
        });

        $("#<%=CATSelect.ClientID%>").bind('click', function (e)
        {
            showRiskCategoryDialog(e.pageX, e.pageY, categoryempty);
        });

        $("#closeBox").bind('click', function () {
            $("#SearchCategory").hide('800');
        });


        $("#<%=RSKCATCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                /*load all correponding subcategories*/
                loadSubcategories($(this).val());

                /*temporarly store the risk category value*/
                $("#Category").val($(this).val());
            }
            else {
                $("#Category").val('');
                $('#subcattree').tree('loadData', []);
            }
        });

        $("#new").bind('click', function ()
        {
            if ($("#Category").val() != '')
            {
                $("#subcattree").tree('appendNode',
                {
                    label: 'new subcategory',
                    Category: $("#Category").val(),
                    Description:'',
                    Status: 3
                });
            }
            else
            {
                alert("Please select risk category");
            }
        });

        $("#refresh").bind('click', function () {
            if ($("#Category").val() != '') {
                var result = confirm("Refreshing data will cause all unsaved changes to be lost, are you sure you would like to continue?");
                if (result == true) {
                    loadSubcategories($("#Category").val());
                }
            }
            else {
                alert("Please select risk category");
            }
        });

        $("#delete").bind('click', function () {
            if ($("#Category").val() != '') {
                var node = $('#subcattree').tree('getSelectedNode');
                if (node != null && node != false) {
                    removeSubcategory(node);
                }
                else {
                    alert("Please select subcategory");
                }
            }
            else {
                alert("Please select risk category");
            }
        });

        $('#subcattree').bind('tree.click', function (event)
        {
            var isTreeFieldValid = Page_ClientValidate('Subcategory');
            if (isTreeFieldValid)
            {
                if (!$("#validation_dialog_subcategory").is(":hidden")) {
                    $("#validation_dialog_subcategory").hide();
                }

                var node = event.node;
                if (node != null && node != false)
                {
                    /*Activate All Fields*/
                    ActivateAll(true);

                    $("#<%=SUBCATTxt.ClientID%>").val(node.name);


                    /*bind the description of the risk sub category*/
                    if (node.Description == '')
                    {
                        addWaterMarkText('The description of the risk sub-category', '#<%=SUBCATDESCTxt.ClientID%>');
                    }
                    else
                    {
                        if ($("#<%=SUBCATDESCTxt.ClientID%>").hasClass("watermarktext")) {
                            $("#<%=SUBCATDESCTxt.ClientID%>").val('').removeClass("watermarktext");
                        }

                        $("#<%=SUBCATDESCTxt.ClientID%>").val($("#<%=SUBCATDESCTxt.ClientID%>").html(node.Description).text());
                    }
                    
                }
            }
            else
            {
                $("#validation_dialog_subcategory").stop(true).hide().fadeIn(500, function ()
                {
               
                });
                return false;
            }
        });

        $("#<%=SUBCATTxt.ClientID%>").keyup(function (event)
        {
            var node = $('#subcattree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if ($(this).val() != '')
                {
                    if (node.Status != 3) {
                        $('#subcattree').tree('updateNode', node,
                        {
                            name: $(this).val(),
                            Status: 2
                        });
                    }
                    else {
                        $('#subcattree').tree('updateNode', node,
                        {
                            name: $(this).val()
                        });
                    }
                }
                else
                {
                    alert("Cannot accept empty values");
                    event.preventDefault();
                }
            }
            else {
                return false;
            }
        });

        $("#<%=SUBCATDESCTxt.ClientID%>").keyup(function (event) {
            var node = $('#subcattree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if (node.Status != 3) {
                    $('#subcattree').tree('updateNode', node,
                    {
                        Description: escapeHtml($(this).val()),
                        Status: 2
                    });
                }
                else {
                    $('#subcattree').tree('updateNode', node,
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

        $("#save").bind('click', function ()
        {
            var isSelectValid = Page_ClientValidate('General');
            if (isSelectValid)
            {
                var isTreeFieldValid = Page_ClientValidate('Subcategory');
                if (isTreeFieldValid)
                {
                    if (!$("#validation_dialog_subcategory").is(":hidden")) {
                        $("#validation_dialog_subcategory").hide();
                    }


                    var Json = $('#subcattree').tree('toJson');
                    if (Json != null)
                    {
                        var result = confirm("Are you sure you would like to commit changes?");
                        if (result == true) {
                            saveData(Json);
                        }
                    }
                    else
                    {
                        alert("There are no sub categories which can be submitted");
                    }
                }
                else
                {
                    $("#validation_dialog_subcategory").stop(true).hide().fadeIn(500, function ()
                    {
                        
                    });
                }
            }
            else
            {
                alert("Please select risk category");
            }
        });

        $("#savecategory").click(function ()
        {
            var isCategoryValid = Page_ClientValidate('Category');
            if (isCategoryValid)
            {
                if (!$("#validation_dialog_category").is(":hidden"))
                {
                    $("#validation_dialog_category").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD') {
                            var category =
                            {
                                CategoryName: $("#<%=CATNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(category) + "\'}",
                                url: getServiceURL().concat('createNewRiskCategory'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#closeBox").trigger('click');

                                        loadXMLRiskCategory();
                                   
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(r.Message);
                                    });
                                }
                            });
                        }
                        else if ($("#MODE").val() == 'EDIT') {
                            var category =
                            {
                                CategoryID: $("#CategoryID").val(),
                                CategoryName: $("#<%=CATNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(category) + "\'}",
                                url: getServiceURL().concat('updateRiskCategory'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#closeBox").trigger('click');

                                        loadXMLRiskCategory();
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
                    });
                }
            }
            else
            {
                $("#validation_dialog_category").stop(true).hide().fadeIn(500, function () {
                    
                });
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
            url: getServiceURL().concat("UploadSubcategories"),
            success: function (data) {
                $find('<%= SaveExtender.ClientID %>').hide();

                alert(data.d);
                loadSubcategories($("#Category").val());
            },
            error: function (xhr, status, error) {
                $find('<%= SaveExtender.ClientID %>').hide();
                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);
            }
        });
    }
    function loadXMLRiskCategory()
    {

        $("#RSKCAT_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCategory"),
                success: function (data)
                {
                    $("#RSKCAT_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $("#<%=RSKCATCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadRiskCategories(empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCategory"),
                success: function (data)
                {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadcategoryGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadSubcategories(category) {
        /*Deactivate all fields to prevent modification*/
        ActivateAll(false);

        $("#SUBCATWait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'categoryname':'" + category + "'}",
                url: getServiceURL().concat("loadSubcategories"),
                success: function (data) {
                    $("#SUBCATWait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var existingjson = $('#subcattree').tree('toJson');

                            if (existingjson == null) {
                                $('#subcattree').tree(
                                {
                                    data: $.parseJSON(data.d),
                                    slide: true,
                                    autoOpen: true
                                });
                            }
                            else {
                                $('#subcattree').tree('loadData', $.parseJSON(data.d));
                            }
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#SUBCATWait").fadeOut(500, function () {
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
    function removeSubcategory(selected)
    {
        if (selected != false)
        {
            if (selected.Status == 3)
            {
                $('#subcattree').tree('removeNode', selected);

                ActivateAll(false);
            }
            else
            {
                var result = confirm("Removing subcategory (" + selected.name + "), might be also removed in the associated list of a particuler Problem Management record, do you want to continue?");
                if (result == true)
                {
                    $(".modulewrapper").css("cursor", "wait");
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'subcategoryID':'" + selected.SubCategoryID + "'}",
                        url: getServiceURL().concat("removeRiskSubCategory"),
                        success: function (data)
                        {
                            $(".modulewrapper").css("cursor", "default");

                            loadSubcategories($("#Category").val());
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

    function loadcategoryGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvCategories.ClientID%> tr").not($("#<%=gvCategories.ClientID%> tr:first-child")).remove();

        $(xml).find("Category").each(function (index, value) {

            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");
            $("td", row).eq(2).html($(this).attr("CategoryID"));
            $("td", row).eq(3).html($(this).attr("CategoryName"));
            $("td", row).eq(4).html($(this).attr("Description"));

            $("#<%=gvCategories.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('delete') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        removeRiskcategory($(value).attr('CategoryID'));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function ()
                    {
                        resetGroup(".modalPanel");

                        /*set the mode to edit*/
                        $("#MODE").val('EDIT');

                        /* bind the ID of the risk category*/
                        $("#CategoryID").val($(value).attr("CategoryID"));

                        /*bind the name of the risk category*/
                        $("#<%=CATNMTxt.ClientID%>").val($(value).attr("CategoryName"));


                        /*bind the description of the risk category*/
                        if ($(value).attr("Description") == '') {
                            addWaterMarkText('The description of the risk category', '#<%=DESCTxt.ClientID%>');
                        }
                        else {
                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=DESCTxt.ClientID%>").val($("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text());
                        }

                        /*attach category name to limit plugin*/
                        $("#<%=CATNMTxt.ClientID%>").limit({ id_result: 'CATNMlimit', alertClass: 'alertremaining', limit: 90 });

                        $('#<%=CATNMTxt.ClientID%>').keyup();

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvCategories.ClientID%> tr:last-child").clone(true);
        
        });
    }

    function removeRiskcategory(categoryID)
    {
        var result = confirm("Removing the current risk category record will also remove all the related sub-categories, are you sure you would like to continue?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'ID':'" + categoryID + "'}",
                url: getServiceURL().concat("removeRiskCategory"),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    loadXMLRiskCategory();

                    $("#closeBox").trigger('click');
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

    function showRiskCategoryDialog(x, y, empty) {
        loadRiskCategories(empty);

        $("#SearchCategory").css({ left: x - 280, top: y + 10 });
        $("#SearchCategory").css({ width: 700, height: 250 });
        $("#SearchCategory").show();
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
