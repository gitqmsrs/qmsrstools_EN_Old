<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateReview.aspx.cs" Inherits="QMSRSTools.ManagementReviews.CreateReview" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
          
    <div id="AUDT_Header" class="moduleheader">Schedule a Management Review</div>
    
    <div class="toolbox">
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt=""/> 
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:5px;">
        <ul id="tabul">
            <li id="Details" class="ntabs">Details</li>
            <li id="ORGUnits" class="ntabs">Related Organization Units</li>
            <li id="Representatives" class="ntabs">Representatives</li>
            <li id="Additional" class="ntabs">Additional Info</li>
        </ul>
        <div id="DetailsTB" class="tabcontent" style="display:none; height:400px;">
            <div id="validation_dialog_general" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="REVIDLabel" class="requiredlabel">Review ID:</div>
                <div id="REVIDField" class="fielddiv" style="width:auto;">
                    <asp:TextBox ID="REVIDTxt" runat="server" CssClass="textbox"></asp:TextBox>
                    <asp:Label ID="REVIDLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
                </div>
                <div id="IDlimit" class="textremaining"></div>

                <asp:RequiredFieldValidator ID="REVVal" runat="server" Display="None" ControlToValidate="REVIDTxt" ErrorMessage="Enter a unique ID of the review record" ValidationGroup="General"></asp:RequiredFieldValidator>   

                <asp:CustomValidator id="REVIDTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "REVIDTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
                ClientValidationFunction="validateIDField">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewCategoryLabel" class="labeldiv">Review Category:</div>
                <div id="ReviewCategoryField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="REVCATCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox" ValidationGroup="General">
                    </asp:DropDownList>
                </div>
                <asp:RequiredFieldValidator ID="REVCATTxtVal" runat="server" Display="None" ControlToValidate="REVCATCBox" ErrorMessage="Select review category" ValidationGroup="General"></asp:RequiredFieldValidator>         
               
                <asp:CompareValidator ID="REVCATVal" runat="server" ControlToValidate="REVCATCBox" CssClass="validator" ValidationGroup="General"
                Display="None" ErrorMessage="Select review category" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="MeetingTitleLabel" class="requiredlabel">Review Meeting Title:</div>
                <div id="MeetingTitleField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="REVNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
                <div id="MNMlimit" class="textremaining"></div>
            
                <asp:RequiredFieldValidator ID="REVNMVal" runat="server" Display="None" ControlToValidate="REVNMTxt" ErrorMessage="Enter the name of the review meeting event" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:CustomValidator id="REVNMTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "REVNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>     
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewDateLabel" class="requiredlabel">Planned Review Date:</div>
                <div id="ReviewDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="REVDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="REVDTVal" runat="server" Display="None" ControlToValidate="REVDTTxt" ErrorMessage="Enter the planned review date" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="REVDTFVal" runat="server" ControlToValidate="REVDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>
            
                <asp:CustomValidator id="REVDTTxtF2Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "REVDTTxt" Display="None" ErrorMessage = "Planned review date should be in future"
                ClientValidationFunction="compareFuture">
                </asp:CustomValidator>

                <asp:CustomValidator id="REVDTTxtF3Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "REVDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
              
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ObjectivesLabel" class="labeldiv">Meeting Objectives:</div>
                <div id="ObjectivesField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="OBJTxt" runat="server"  CssClass="textbox" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="OBJTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "OBJTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>
    
        <div id="ORGUnitsTB" class="tabcontent" style="display:none;height:400px;">
            <div class="toolbox">
                <img id="refresh" src="../Images/refresh.png" alt=""  class="imgButton" title="Refresh Units"/>
             
                <div id="filter_div">
                    <img id="filter" src="../Images/filter.png" alt=""/>
                    <ul class="contextmenu">
                        <li id="clearFilter">View All Units</li>
                        <li id="byLocation">Filter by Location</li>
                    </ul>
                </div>
             
                <div id="LocationContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                    <div id="LocationLabel" style="width:100px;">Location</div>
                    <div id="LocationField" style="width:150px; left:0; float:left;">
                        <asp:DropDownList ID="LOCCBox" runat="server" Width="150px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="LOC_LD" class="control-loader"></div>   
                </div>
            </div>

            <div id="orgtreemenu" class="menucontainer" style="border: 1px solid #052556; margin-top:10px; height:440px;">   
                <div id="REVloader" class="loader">
                    <div class="waittext">Please Wait...</div>
                </div>
                <div id="orgtree"></div>
            </div>
        
            <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; margin-top:10px;height:440px;">
                <div id="table" style="display:none;">
                    <div id="row_header" class="tr">
                        <div id="col0_head" class="tdh" style="width:50px"></div>
                        <div id="col1_head" class="tdh" style="width:20%">ID</div>
                        <div id="col2_head" class="tdh" style="width:20%">ORG. Unit</div>
                        <div id="col3_head" class="tdh" style="width:20%">ORG. Level</div>
                        <div id="col4_head" class="tdh" style="width:20%">Location</div>
                    </div>
                </div>
            </div>
        </div>
        <div id="RepresentativesTB" class="tabcontent" style="display:none;height:400px;">
            <img id="newRepresentative" src="../Images/new_file.png" class="imgButton" title="Add new representative" alt=""/>
       
            <asp:GridView id="gvReprsentative" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
            GridLines="None" AllowPaging="true" PageSize = "5" AlternatingRowStyle-CssClass="alt" style="margin-top:30px; width:50%">
            <Columns>
                <asp:TemplateField ShowHeader="false" HeaderStyle-Width="50px">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false" HeaderStyle-Width="50px">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="EmployeeName" HeaderText="Representative" />
            </Columns>
            </asp:GridView>
        </div>
        <div id="AdditionalTB" class="tabcontent" style="display:none;height:400px;">
            <div id="AdditionalTooltip" class="tooltip">
                <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
                <p></p>
	        </div>	
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ORGUnitRecipientLabel" class="labeldiv">Select ORG. Unit:</div>
                <div id="ORGUnitRecipientField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="ORGUNTRECBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNT_LD" class="control-loader"></div> 
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RecipientsLabel" class="labeldiv">Select Record Recipients:</div>
                <div id="RecipientsField" class="fielddiv" style="width:600px;">
                    <div id="RECCHK" class="checklist" style="height:200px;"></div>
                    <div style="width:52px; height:200px; float:left; margin-left:2px;">
                        <input id="Add" type="button" class="button" style="width:50px; margin-top:100px;" value="Add" />
                    </div>
                    <div id="ToCHK" class="checklist" style="height:200px; margin-left:2px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div id="DepartmentDialog" title="Select Organization Unit" style="display:none;">
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ORGUnitLabel" class="labeldiv">ORG. Unit:</div>
            <div id="ORGUnitField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="230px" runat="server" CssClass="combobox">
                </asp:DropDownList>
                <div id="ORGUNTE_LD" class="control-loader"></div> 
            </div>
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="EMPNameLabel" class="labeldiv">Employee Name:</div>
            <div id="EMPNameField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="EMPCBox" AutoPostBack="false" Width="230px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
        </div>
        <p style="margin-top:20px; float:left;">Press Esc to cancel the selection</p>
    </div>

    <input id="MODE" type="hidden" value="" />
    <input id="DATA" type="hidden" value="" />

    <asp:Panel ID="panel3" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="panel3" PopupControlID="panel3" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvReprsentative.ClientID%> tr:last-child").clone(true);

        /*attach review ID to limit plugin*/
        $("#<%=REVIDTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach event name description to limit plugin*/
        $('#<%=REVNMTxt.ClientID%>').limit({ id_result: 'MNMlimit', alertClass: 'alertremaining', limit: 100 });

        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTRECBox.ClientID%>", "#ORGUNT_LD");

        loadLastIDAjax('getReviewID', "#<%=REVIDLbl.ClientID%>");

        addWaterMarkText('The objective of the managament review meeting', '#<%=OBJTxt.ClientID%>');

        loadReviewCategory();

        /*prepare initial setup*/
        refresh();

        navigate('Details');

        initializeUnits();

        //remove the empty row in the gridview
        $("#<%=gvReprsentative.ClientID%> tr").not($("#<%=gvReprsentative.ClientID%> tr:first-child")).remove();

        $("#refresh").bind('click', function () {
            refresh();
        });

        $("#<%=REVDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });


        $("#byLocation").bind('click', function () {
            hideAll();

            loadComboboxAjax('loadCountries', "#<%=LOCCBox.ClientID%>");

            $("#LocationContainer").show();

        });

        $("#clearFilter").bind('click', function () {
            hideAll();

            refresh();
        });

        $('#orgtree').bind('tree.click', function (event) {
            //disable single selection
            event.preventDefault();

            if ($(this).tree('isNodeSelected', event.node)) {
                $(this).tree('removeFromSelection', event.node);
                removeUnit(event.node);
            }
            else {
                $(this).tree('addToSelection', event.node);

                addUnit(event.node);
            }
        });

        $("#newRepresentative").bind('click', function () {
            $("#MODE").val('LOAD');
            showORGDialog();
        });


        $("#<%=EMPCBox.ClientID%>").change(function () {
            var row = null;
            if ($("#MODE").val() == 'LOAD') {
                var length = $("#<%=gvReprsentative.ClientID%> tr").not($("#<%=gvReprsentative.ClientID%> tr:first-child")).children().length;

                if (length == 0) {
                    addrepresentative(empty, length += 1, $(this).val());
                }
                else {
                    var row = $("#<%=gvReprsentative.ClientID%> tr:last-child").clone(true);
                    addrepresentative(row, length += 1, $(this).val());
                }
            }
            else {
                var JSONObject = JSON.parse($("#DATA").val());
                updateRow(JSONObject.Name, $(this).val())
            }

            $("#DepartmentDialog").dialog("close");
        });

        $("#<%=LOCCBox.ClientID%>").change(function () {
            filter($(this).val());
        });

        /*load all potential recipients to recipient checkbox*/
        $("#<%=ORGUNTRECBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'unit':'" + $(this).val() + "'}",
                    url: getServiceURL().concat("getDepEmployees"),
                    success: function (data) {
                        var html = '';

                        $(data.d).each(function (index, value) {
                            html += "<div class='checkitem'>"
                            html += "<input type='checkbox' id='" + value + "' name='checklist' value='" + value + "'/><div class='checkboxlabel'>" + value + "</div>";
                            html += "</div>"
                        });

                        $("#RECCHK").append(html);
                    },
                    error: function (xhr, status, error) {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    }
                });
            }
        });

        $("#Add").bind('click', function () {
            setRecipients("#ToCHK");
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            loadcontrols.push("#<%=EMPCBox.ClientID%>");
            loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, $("#ORGUNTE_LD"));

        });

        $("#save").bind('click', function () {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {

                    $find('<%= SaveExtender.ClientID %>').show();

                    var REVDTParts = getDatePart($("#<%=REVDTTxt.ClientID%>").val());
                    var review =
                    {
                        ReviewNo: $.trim($("#<%=REVIDTxt.ClientID%>").val()),
                        ReviewName: $("#<%=REVNMTxt.ClientID%>").val(),
                        ReviewCategory:$("#<%=REVCATCBox.ClientID%>").val(),
                        PlannedReviewDate: new Date(REVDTParts[2], (REVDTParts[1] - 1), REVDTParts[0]),
                        Objectives: $("#<%=OBJTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=OBJTxt.ClientID%>").val()),
                        Representatives: getRepresentativesJSON(),
                        Units: $("#table").table('getJSON'),
                        Recipients: getRecipientsJSON()
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(review) + "\'}",
                        url: getServiceURL().concat("createReview"),
                        success: function (data) {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            alert(data.d);

                            //reset display controls
                            navigate('Details');
                            reset();
                            refresh();

                            $("#<%=gvReprsentative.ClientID%> tr").not($("#<%=gvReprsentative.ClientID%> tr:first-child")).remove();

                            $("#RECCHK").empty();
                            $("#ToCHK").empty();

                            addWaterMarkText('The objective of the managament review meeting', '#<%=OBJTxt.ClientID%>');

                            loadLastIDAjax('getReviewID', "#<%=REVIDLbl.ClientID%>");

                            /*reset limit plugin*/
                            $(".textbox").each(function () {
                                $(this).keyup();
                            });
                        },
                        error: function (xhr, status, error) {
                            $find('<%= SaveExtender.ClientID %>').hide();
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        }
                    });
                }
            }
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    navigate('Details');
                });
            }
        });
        $("#tabul li").bind("click", function ()
        {
            if ($(this).attr("id") == 'Additional')
            {
                $("#AdditionalTooltip").find('p').text("You may choose general managers and steering commities to recieve a notification of adding the review record");

                if ($("#AdditionalTooltip").is(":hidden")) {
                    $("#AdditionalTooltip").slideDown(800, 'easeOutBounce');
                }
            }
            else
            {
                $("#AdditionalTooltip").hide();
            }
            navigate($(this).attr("id"));
        });

    });
    function loadReviewCategory()
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadReviewCategories"),
            success: function (data) {
                if (data)
                {
                    var xml = $.parseXML(data.d);

                    loadComboboxXML(xml, 'Category', 'CategoryName', '#<%=REVCATCBox.ClientID%>');
                }
            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);
            }
        });
    }
    function getRepresentativesJSON()
    {
        var representatives = new Array();
        $("#<%=gvReprsentative.ClientID%> tr").not($("#<%=gvReprsentative.ClientID%> tr:first-child")).each(function (index, value) {
            var representative =
            {
                NameFormat: $("td", $(this)).eq(2).html(),
            };
            representatives.push(representative);
        });

        if (representatives.length == 0)
            return null;

        return representatives;
    }
    function getRecipientsJSON() {
        var recipients = new Array();
        var ID = null;
        var recipient = null;

        $("#ToCHK").children(".infodiv").each(function () {
            recipient =
            {
                Employee: $(this).find('.infotext').text()
            }

            recipients.push(recipient);

        });


        if (recipients.length == 0)
            return null;

        return recipients;
    }

    function setRecipients(control) {
        $("#RECCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function () {
                if ($(this).is(":checked") == true) {
                    if (RecipientExists(control, $(this).val()) == false) {
                        var sb = new StringBuilder('');

                        sb.append("<div id='" + $(control).attr('id') + "_" + $(this).val().substring($(this).val().lastIndexOf(' ') + 1, $(this).val().length - 1) + "' class='infodiv'>");
                        sb.append("<div class='infotext'>" + $(this).val() + "</div>");
                        sb.append("<div id='delete_" + $(control).attr('id') + "_" + $(this).val().substring($(this).val().lastIndexOf(' ') + 1, $(this).val().length - 1) + "' class='infodelete'></div>");
                        sb.append("</div>");

                        $(control).append(sb.toString());

                        $("#delete_" + $(control).attr('id') + "_" + $(this).val().substring($(this).val().lastIndexOf(' ') + 1, $(this).val().length - 1)).bind('click', function () {
                            $(this).parent().remove();
                        });
                    }
                    else {
                        alert('The name already exists');
                    }
                }
            });
        });
    }
    function RecipientExists(control, employee) {
        var found = false;
        $(control).children().each(function (index, value) {
            if ($(this).find('.infotext').text() == employee) {
                found = true;
            }
        });

        return found;
    }

    function updateRow(name, newval)
    {
           $("#<%=gvReprsentative.ClientID%> tr").not($("#<%=gvReprsentative.ClientID%> tr:first-child")).children().each(function (index, value) {
               if (name == $(this).html()) {
                   $(this).html(newval);
               }
           });

    }
    function addrepresentative(row, length, value) {
        $("td", row).eq(0).html("<img id='remove_" + length + "' src='../Images/deletenode.png' class='imgButton'/>");
        $("td", row).eq(1).html("<img id='edit_" + length + "' src='../Images/edit.png' class='imgButton'/>");
        $("td", row).eq(2).html(value);

        $("#<%=gvReprsentative.ClientID%>").append(row);

        $(row).find('img').each(function () {
            if ($(this).attr('id').search('edit') != -1) {
                $(this).bind('click', function () {
                    $("#MODE").val('EDIT');

                    var employeename =
                    {
                        Name: $("td", row).eq(2).html()
                    };

                    $("#DATA").val(JSON.stringify(employeename));

                    showORGDialog();
                });
            }
            else if ($(this).attr('id').search('remove') != -1) {
                $(this).bind('click', function () {
                    $(row).remove();
                });
            }
        });
    }
    function showORGDialog()
    {
        $("#DepartmentDialog").dialog(
        {
            width: 450,
            show: "slow",
            modal: true,
            height: 200,
            hide: "highlight",
            create: function (event, ui) {
               
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
            },
            close: function (event, ui) {
                $(this).dialog("destroy");
            }
        });
    }
    function initializeUnits() {
        var attr = new Array();
        attr.push("ORGID");
        attr.push("name");
        attr.push("ORGLevel");
        attr.push("Country");

        /*set cell settings*/

        var settings = new Array();
        settings.push(JSON.stringify({ readonly: true }));
        settings.push(JSON.stringify({ readonly: true }));
        settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadOrganizationLevel") }));
        settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadCountries") }));

        var units =
        [
        ]

        $("#table").table({ JSON: units, Attributes: attr, Settings: settings, Width: 20 });

    }
    function removeUnit(selected) {
        $("#table").table('removeRowAt', 'ORGID', selected.ORGID);
    }
    function addUnit(selected)
    {
        var result = $("#table").table('addRow',
        {
             ORGID: selected.ORGID,
             name: selected.name,
             ORGLevel: selected.ORGLevel,
             Country: selected.Country,
             Status: 3
        });
    }


    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function filter(country) {
        $("#REVloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'country':'" + country + "'}",
                url: getServiceURL().concat("filterOrganizationUnit"),
                success: function (data) {
                    $("#REVloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var existingjson = $('#orgtree').tree('toJson');
                            if (existingjson == null) {
                                $('#orgtree').tree(
                                {
                                    data: $.parseJSON(data.d),
                                    slide: true,
                                    autoOpen: true
                                });
                            }
                            else {
                                $('#orgtree').tree('loadData', $.parseJSON(data.d));
                            }
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#REVloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function refresh()
    {
        $("#table").table('clear');

        $("#REVloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadOrganizationUnit"),
                success: function (data) {
                    $("#REVloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var existingjson = $('#orgtree').tree('toJson');
                            if (existingjson == null) {
                                $('#orgtree').tree(
                                {
                                    data: $.parseJSON(data.d),
                                    slide: true,
                                    autoOpen: true
                                });
                            }
                            else {
                                $('#orgtree').tree('loadData', $.parseJSON(data.d));
                            }
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#REVloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
