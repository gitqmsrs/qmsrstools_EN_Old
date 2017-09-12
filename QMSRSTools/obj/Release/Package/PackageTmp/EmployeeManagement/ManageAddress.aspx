<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageAddress.aspx.cs" Inherits="QMSRSTools.EmployeeManagement.ManageAddress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="EmployeeAddress_Header" class="moduleheader">Maintain Employee Address</div>

    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="new" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Add New Address" alt="" />  
          
        <div id="PersonnelIDContainer" style=" float:left;width:500px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="PersonnelIDLabel" style="width:100px;">Personnel ID:</div>
            <div id="PersonnelIDField" style="width:250px; left:0; float:left;">
                <asp:TextBox ID="PERSIDTxt" runat="server" CssClass="filtertext" Width="240px"></asp:TextBox>
            </div>
            <div id="PERSID_LD" class="control-loader"></div>      

            <span id="EMPSelect" class="searchactive" style="margin-left:10px" runat="server"></span>      
        </div>
    </div>

    <div id="SearchEmployee" class="selectbox" style="width:700px; height:250px; top:40px; left:150px;">
        <div class="toolbox">
            <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
            <div id="filter_div">
                <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byFirst">Filter by First Name</li>
                    <li id="byLast">Filter by Last Name</li>
                    <li id="byREL">Filter by Religion</li>
                    <li id="byGND">Filter by Gender</li>
                    <li id="byMRT">Filter by Marital Status</li>
                    <li id="byDOB">Filter by Date of Birth Range</li>
                    <li id="byUNT">Filter by Organization Unit</li>
                </ul>
            </div>

            <div id="FirstNameContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="FirstNameFLabel" style="width:100px;">First Name:</div>
                <div id="FirstNameFField" style="width:150px; left:0; float:left;">
                    <asp:TextBox ID="FNMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
                </div>
            </div>
        
            <div id="GenderContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="GenderFLabel" style="width:100px;">Gender:</div>
                <div id="GenderFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="GNDRFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="GNDRF_LD" class="control-loader"></div>
            </div>

            <div id="ReligionContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="ReligionFLabel" style="width:100px;">Religion:</div>
                <div id="ReligionFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RELFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RELF_LD" class="control-loader"></div>
            </div>

            <div id="OrganizationUnitContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="OrganizationUnitFLabel" style="width:100px;">Organization Unit:</div>
                <div id="OrganizationUnitFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNTF_LD" class="control-loader"></div>
            </div>


            <div id="MaritalStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="MaritalStatusFLabel" style="width:100px;">Marital Status:</div>
                <div id="MaritalStatusFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="MRTLSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="MRTLSTSF_LD" class="control-loader"></div>
            </div>

            <div id="LastNameContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="LastNameFLabel" style="width:100px;">Last Name:</div>
                <div id="LastNameFField" style="width:150px; left:0; float:left;">
                    <asp:TextBox ID="LNMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
                </div>
            </div>

            <div id="StartdateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                <div id="StartDateFLabel" style="width:120px;">Date of Birth:</div>
                <div id="StartDateFField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
            </div>
            <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
        </div>
        <div id="FLTR_LD" class="control-loader"></div> 
        <div id="EmployeeScroll" style="height:200px; width:100%; overflow:auto; margin-top:15px; float:left">
            <asp:GridView id="gvEmployees" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
            GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PersonnelID" HeaderText="Personnel ID" />
                    <asp:BoundField DataField="CompleteName" HeaderText="CompleteName" />
                    <asp:BoundField DataField="KnownAs" HeaderText="Known As" />
                    <asp:BoundField DataField="DOB" HeaderText="Date of Birth" />
                    <asp:BoundField DataField="COB" HeaderText="Country of Birth" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                    <asp:BoundField DataField="Religion" HeaderText="Religion" />
                    <asp:BoundField DataField="Marital" HeaderText="Marital Status" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
    
    <div id="ADDRwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>
 
    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvAddress" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="Address1" HeaderText="Address Line 1" />
            <asp:BoundField DataField="Address2" HeaderText="Address Line 2" />
            <asp:BoundField DataField="Country" HeaderText="Country" />
            <asp:BoundField DataField="City" HeaderText="City" />
            <asp:BoundField DataField="PostalCode" HeaderText="Postal Code" />       
        </Columns>
        </asp:GridView>
    </div>
    
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Address Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_address" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="Address" />
        </div>
        
        <input id="AddressID" type="hidden" value="" />

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="AddressLine1Label" class="requiredlabel">Address Line 1:</div>
            <div id="AddressLine1Field" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="ADD1Txt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>
                    
            <div id="ADD1limit" class="textremaining"></div>
       
            <asp:RequiredFieldValidator ID="ADD1Val" runat="server" Display="None" ControlToValidate="ADD1Txt" ErrorMessage="Enter the primary address of the employee" ValidationGroup="Address"></asp:RequiredFieldValidator>  
                    
            <asp:CustomValidator id="ADD1FVal" runat="server" ValidationGroup="Address" 
            ControlToValidate = "ADD1Txt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="AddressLine2" class="labeldiv">Address Line 2:</div>
            <div id="AddressLine2Field" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="ADD2Txt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>
            <div id="ADD2limit" class="textremaining"></div>

            <asp:CustomValidator id="ADD2FVal" runat="server" ValidationGroup="Address" 
            ControlToValidate = "ADD2Txt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="Country" class="requiredlabel">Country:</div>
            <div id="CountryField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="COUNTCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="CTRY_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="COUNTTxtVal" runat="server" Display="None" ControlToValidate="COUNTCBox" ErrorMessage="Select the country of the address" ValidationGroup="Address"></asp:RequiredFieldValidator>
         
            <asp:CompareValidator ID="COUNTVal" runat="server" ControlToValidate="COUNTCBox" Display="None"
            ErrorMessage="Select the country of the address" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Address"></asp:CompareValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="City" class="requiredlabel">City:</div>
            <div id="CityField" class="fielddiv" style="width:150px;">
                <asp:TextBox ID="CTYTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
            </div>
            
            <div id="CTYlimit" class="textremaining"></div>
       
            <asp:RequiredFieldValidator ID="CTYVal" runat="server" Display="None" ControlToValidate="CTYTxt" ErrorMessage="Enter the name of the city" ValidationGroup="Address"></asp:RequiredFieldValidator>
                    
            <asp:CustomValidator id="CTYFVal" runat="server" ValidationGroup="Address" 
            ControlToValidate = "CTYTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>   
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="PostalCode" class="labeldiv">Postal Code:</div>
            <div id="PostalCodeField" class="fielddiv">
                <asp:TextBox ID="POSTTxt" runat="server" CssClass="textbox"></asp:TextBox>
            </div>

            <div id="PSTlimit" class="textremaining"></div>

            <asp:CustomValidator id="POSTFVal" runat="server" ValidationGroup="Address" 
            ControlToValidate = "POSTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>
        
        <div id="ContactGroupLabel" class="groupboxheader">Contact Details</div>
        <div id="ContactGroupField" class="groupbox">
            <img id="newContact" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" alt="" title="Add new contact" />
         
            <div id="table" style=" margin-top:10px; display:none;">
                <div id="row_header" class="tr">
                    <div id="col0_head" class="tdh" style="width:50px;"></div>
                    <div id="col1_head" class="tdh" style="width:30%">Contact Number</div>
                    <div id="col2_head" class="tdh" style="width:30%">Contact Type</div>
                </div>
            </div>
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>
    
    <input id="MODE" type="hidden" value="" />
    <input id="EmployeeJSON" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
        $(function ()
        {
            var employeeempty = $("#<%=gvEmployees.ClientID%> tr:last-child").clone(true);
            var addressempty = $("#<%=gvAddress.ClientID%> tr:last-child").clone(true);

            $("#<%=EMPSelect.ClientID%>").bind('click', function () {
                loadEmployees(employeeempty);

                $("#SearchEmployee").show();
            });

            $("#deletefilter").bind('click', function () {
                hideAll();
                loadEmployees(employeeempty);
            });


            $("#refresh").bind('click', function ()
            {
                if ($("#EmployeeJSON").val() != '')
                {
                    var employeeJSON = $.parseJSON($("#EmployeeJSON").val());

                    loadEmployeeAddresses(employeeJSON.PersonnelID, "#ADDRwait", addressempty);
                
                }
                else
                {
                    alert("Please select an employee, or enter the desired personnel ID");
                }
            });


            $("#byFirst").bind('click', function () {
                hideAll();
                /*Clear text value*/
                $("#<%=FNMTxt.ClientID%>").val('');

                $("#FirstNameContainer").show();

            });

            $("#byLast").bind('click', function () {
                hideAll();
                /*Clear text value*/
                $("#<%=LNMTxt.ClientID%>").val('');

                $("#LastNameContainer").show();
            });

            $("#byREL").bind('click', function () {
                hideAll();
                loadComboboxAjax('loadReligions', "#<%=RELFCBox.ClientID%>","#RELF_LD");

                $("#ReligionContainer").show();
            });


            $("#byGND").bind('click', function () {
                hideAll();
                loadComboboxAjax('loadGenders', "#<%=GNDRFCBox.ClientID%>","#GNDRF_LD");

                $("#GenderContainer").show();
            });


            $("#byMRT").bind('click', function () {
                hideAll();
                loadComboboxAjax('loadMaritalStatus', "#<%=MRTLSTSFCBox.ClientID%>","#MRTLSTSF_LD");

                $("#MaritalStatusContainer").show();
            });

            $("#byDOB").bind('click', function () {
                hideAll();
                /*Clear text value*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#StartdateContainer").show();
            });

            $("#byUNT").bind('click', function () {
                hideAll();
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTFCBox.ClientID%>", "#ORGUNTF_LD");

                $("#OrganizationUnitContainer").show();
            });

         
            $("#new").bind('click', function ()
            {
                if ($("#EmployeeJSON").val() != '')
                {
                    $("#validation_dialog_address").hide();

                    var employeeJSON = $.parseJSON($("#EmployeeJSON").val());

                    /*load country combobox*/
                    loadComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>","#CTRY_LD");

                    /*attach address line 1 to limit plugin*/
                    $("#<%=ADD1Txt.ClientID%>").limit({ id_result: 'ADD1limit', alertClass: 'alertremaining', limit: 200 });

                    /*attach address line 2 to limit plugin*/
                    $("#<%=ADD2Txt.ClientID%>").limit({ id_result: 'ADD2limit', alertClass: 'alertremaining', limit: 200 });

                    /*attach city to limit plugin*/
                    $("#<%=CTYTxt.ClientID%>").limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 100 });

                    /*attach postal code to limit plugin*/
                    $("#<%=POSTTxt.ClientID%>").limit({ id_result: 'PSTlimit', alertClass: 'alertremaining', limit: 100 });

                   
                    var attributes = new Array();
                    attributes.push("Number");
                    attributes.push("Type");

                    var contactjson =
                    [
                    ];

                    var json = $.parseJSON(JSON.stringify(contactjson));

                    var attributes = new Array();
                    attributes.push("Number");
                    attributes.push("Type");

                    /*set cell settings*/
                    var settings = new Array();
                    settings.push(JSON.stringify({}));
                    settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadContactType") }));

                    $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });

                    /* clear all text and combo fields*/
                    $(".modalPanel").children().each(function ()
                    {
                        $(this).find('.textbox').each(function () {
                            $(this).val('');
                        });

                        $(this).find('.readonly').each(function () {
                            $(this).val('');
                        });

                        $(this).find('.combobox').each(function () {
                            $(this).val(0);
                        });
                    });

                    /* set modal mode to add*/
                    $("#MODE").val('ADD');

                    /*trigger modal popup extender*/
                    $("#<%=alias.ClientID%>").trigger('click');
                }
                else
                {
                    alert("Please select an employee, or enter the desired personnel ID");
                }
            });

            $("#save").bind('click', function () {
                var isGeneralValid = Page_ClientValidate('Address');
                if (isGeneralValid)
                {
                    if (!$("#validation_dialog_address").is(":hidden")) {
                        $("#validation_dialog_address").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                            var employeeJSON = $.parseJSON($("#EmployeeJSON").val());

                            ActivateSave(false);

                            if ($("#MODE").val() == 'ADD') {
                                var address =
                                {
                                    AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                                    AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                                    Country: $("#<%=COUNTCBox.ClientID%>").val(),
                                    City: $("#<%=CTYTxt.ClientID%>").val(),
                                    PostalCode: $("#<%=POSTTxt.ClientID%>").val(),
                                    Contacts: $("#table").table('getJSON')
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(address) + "\','personnelID':'" + employeeJSON.PersonnelID + "'}",
                                    url: getServiceURL().concat('createNewEmployeeAddress'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            $("#refresh").trigger('click');

                                        });
                                    },
                                    error: function (xhr, status, error) {
                                        $("#SaveTooltip").fadeOut(500, function () {

                                            ActivateSave(true);

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message)
                                        });
                                    }
                                });
                            }
                            else {
                                var address =
                                {
                                    AddressID: $("#AddressID").val(),
                                    AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                                    AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                                    Country: $("#<%=COUNTCBox.ClientID%>").val(),
                                    City: $("#<%=CTYTxt.ClientID%>").val(),
                                    PostalCode: $("#<%=POSTTxt.ClientID%>").val(),
                                    Contacts: $("#table").table('getJSON')
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(address) + "\'}",
                                    url: getServiceURL().concat('updateEmployeeAddress'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            $("#refresh").trigger('click');

                                        });
                                    },
                                    error: function (xhr, status, error) {
                                        $("#SaveTooltip").fadeOut(500, function () {

                                            ActivateSave(true);

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message)
                                        });
                                    }
                                });
                            }

                        });
                    }
                }
                else {
                    $("#validation_dialog_address").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
            });

            $("#closeBox").bind('click', function () {
                $("#SearchEmployee").hide('800');
            });


            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            /*filter by first name*/
            $("#<%=FNMTxt.ClientID%>").keyup(function () {
                filterEmployeesByFirstName($(this).val(), employeeempty);
            });

            /*filter by last name*/
            $("#<%=LNMTxt.ClientID%>").keyup(function () {
                filterEmployeesByLastName($(this).val(), employeeempty);
            });

            $("#<%=ORGUNTFCBox.ClientID%>").change(function () {

                if ($(this).val() != 0) {
                    filterEmployeesByOrganization($(this).val(), employeeempty);
                }
            });

            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), employeeempty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), employeeempty);
            });


            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
              inline: true,
              dateFormat: "dd/mm/yy",
              onSelect: function (date) {
                  filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), employeeempty);
              }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, employeeempty);
                }
            });

            $("#<%=RELFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByReligion($(this).val(), employeeempty);
                }
            });

            $("#<%=GNDRFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByGender($(this).val(), employeeempty);
                }
            });

            $("#<%=MRTLSTSFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByMaritalStatus($(this).val(), employeeempty);
                }
            });

            $("#<%=PERSIDTxt.ClientID%>").keydown(function (event) {
                var $obj = $(this);

                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    var text = $(this).val();

                    loadEmployeeAddresses(text, "#PERSID_LD", addressempty);
                }
            });

            $("#newContact").click(function () {
                $("#table").table('addRow',
                {
                    Number: '',
                    Type: '',
                    Status: 3
                });
            });
        });

        function loadEmployeeAddresses(personnelID,loader,empty)
        {
            $(loader).stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'personnelID':'" + personnelID + "'}",
                    url: getServiceURL().concat('getEmployeeByPersonnelID'),
                    success: function (data) {
                        $(loader).fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            var xmlEmployee = $.parseXML(data.d);
                            var employee = $(xmlEmployee).find("Employee");

                            var employeeJSON =
                            {
                                PersonnelID: employee.attr('PersonnelID')
                            }

                            /*serialize and temprary store json data*/
                            $("#EmployeeJSON").val(JSON.stringify(employeeJSON));

                            /*Load employee's address list in the grifview*/
                            loadAddressGridView(employee.attr('XMLAddress'), empty);
                        });
                    },
                    error: function (xhr, status, error) {
                        $(loader).fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)

                            $("#EmployeeJSON").val('');
                        });
                    }
                });
            });
        }
        function loadEmployees(empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat('getEmployees'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadEmployeeGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });

                    }
                });
            });
        }

        function filterByDateRange(start, end, empty) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true) {
                $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                    $(".modulewrapper").css("cursor", "wait");

                    var dateparam =
                    {
                        StartDate: startdate,
                        EndDate: enddate
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                        url: getServiceURL().concat('filterEmployeesByDateOfBirth'),
                        success: function (data) {

                            $("#FLTR_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                $(this).find('p').text("List of all current employees filtered by date of birth range.");

                                if (data) {
                                    loadEmployeeGridView(data.d, empty);
                                }
                            });

                        },
                        error: function (xhr, status, error) {
                            $("#FLTR_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });

                        }
                    });
                });
            }
        }

        function filterEmployeesByMaritalStatus(status, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",

                    url: getServiceURL().concat('filterEmployeesByMaritalStatus'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });
                    }
                });
            });
        }

        function filterEmployeesByGender(gender, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'gender':'" + gender + "'}",
                    url: getServiceURL().concat('filterEmployeesByGender'),
                    success: function (data) {

                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadEmployeeGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });
                    }
                });
            });
        }

        function filterEmployeesByReligion(religion, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'religion':'" + religion + "'}",

                    url: getServiceURL().concat('filterEmployeesByReligion'),
                    success: function (data) {


                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {

                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });

                    }
                });
            });
        }

        function filterEmployeesByOrganization(unit, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'unit':'" + unit + "'}",

                    url: getServiceURL().concat('filterEmployeesByOrganization'),
                    success: function (data)
                    {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {

                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });
                    }
                });
            });
        }
        function filterEmployeesByLastName(last, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'last':'" + last + "'}",

                    url: getServiceURL().concat('filterEmployeesByLastName'),
                    success: function (data) {

                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {

                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });
                    }
                });
            });
        }

        function filterEmployeesByFirstName(first, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'first':'" + first + "'}",
                    url: getServiceURL().concat('filterEmployeesByFirstName'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadEmployeeGridView(data.d, empty);
                            }
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });

                    }
                });
            });
        }

        function loadEmployeeGridView(data, empty)
        {
            var xml = $.parseXML(data);

            var row = empty;

            $("#<%=gvEmployees.ClientID%> tr").not($("#<%=gvEmployees.ClientID%> tr:first-child")).remove();

            $(xml).find("Employee").each(function (index, employee) {
                /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                var date = new Date();

                $("td", row).eq(0).html("<img id='icon_" + index + "' src='http://www.qmsrs.com/qmsrstools/ImageHandler.ashx?query=select ProfileImg from HumanResources.Employee where EmployeeID=" + $(this).attr('EmployeeID') + "&width=70&height=40&date=" + date.getSeconds() + "' />");

                $("td", row).eq(1).html($(this).attr("PersonnelID"));
                $("td", row).eq(2).html($(this).attr("CompleteName"));
                $("td", row).eq(3).html($(this).attr("KnownAs"));
                $("td", row).eq(4).html(new Date($(this).attr("DOB")).format("dd/MM/yyyy"));
                $("td", row).eq(5).html($(this).attr("COB"));
                $("td", row).eq(6).html($(this).attr("Gender"));
                $("td", row).eq(7).html($(this).attr("Religion"));
                $("td", row).eq(8).html($(this).attr("MaritalStatus"));
                $("td", row).eq(9).html($(this).attr("EmailAddress"));

                $("#<%=gvEmployees.ClientID%>").append(row);

                row = $("#<%=gvEmployees.ClientID%> tr:last-child").clone(true);
            });

            $("#<%=gvEmployees.ClientID%> tr").not($("#<%=gvEmployees.ClientID%> tr:first-child")).bind('click', function () {

                $("#SearchEmployee").hide('800');

                $("#<%=PERSIDTxt.ClientID%>").val($("td", $(this)).eq(1).html());

                var e = jQuery.Event("keydown");
                e.which = 13; // # Some key code value
                $("#<%=PERSIDTxt.ClientID%>").trigger(e);

             });
        }
        function loadAddressGridView(data, empty)
        {
            var xml = $.parseXML(data);

            var row = empty;


            $("#<%=gvAddress.ClientID%> tr").not($("#<%=gvAddress.ClientID%> tr:first-child")).remove();

            $(xml).find("Address").each(function (index, address) {
                $("td", row).eq(0).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html($(this).attr("AddressLine1"));
                $("td", row).eq(3).html($(this).attr("AddressLine2"));
                $("td", row).eq(4).html($(this).attr("Country"));
                $("td", row).eq(5).html($(this).attr("City"));
                $("td", row).eq(6).html($(this).attr("PostalCode"));

                $("#<%=gvAddress.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('delete') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            removeAddress($(address).attr("AddressID"));
                        });
                    }
                    else if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            $("#validation_dialog_address").hide();

                            /*bind address ID*/
                            $("#AddressID").val($(address).attr('AddressID'));

                            /*bind address line 1 field*/ 
                            $("#<%=ADD1Txt.ClientID%>").val($(address).attr('AddressLine1'));

                            /*bind address line 2 field*/
                            $("#<%=ADD2Txt.ClientID%>").val($(address).attr('AddressLine2'));

                            /*bind country combobox*/
                            bindComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>", $(address).attr('Country'),"#CTRY_LD");

                            /*bind city field*/
                            $("#<%=CTYTxt.ClientID%>").val($(address).attr('City'));

                            /*bind postal code field*/
                            $("#<%=POSTTxt.ClientID%>").val($(address).attr('PostalCode'));

                            /*attach address line 1 to limit plugin*/
                            $("#<%=ADD1Txt.ClientID%>").limit({ id_result: 'ADD1limit', alertClass: 'alertremaining', limit: 200 });

                            /*attach address line 2 to limit plugin*/
                            $("#<%=ADD2Txt.ClientID%>").limit({ id_result: 'ADD2limit', alertClass: 'alertremaining', limit: 200 });

                            /*attach city to limit plugin*/
                            $("#<%=CTYTxt.ClientID%>").limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 100 });

                            /*attach postal code to limit plugin*/
                            $("#<%=POSTTxt.ClientID%>").limit({ id_result: 'PSTlimit', alertClass: 'alertremaining', limit: 100 });

                            $(".textbox").each(function ()
                            {
                                $(this).keyup();
                            });

                            /*load employee contact details*/
                            var attributes = new Array();
                            attributes.push("Number");
                            attributes.push("Type");

                            var json = $.parseJSON($(address).attr("JSONContacts"));

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({}));
                            settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadContactType") }));

                            $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });


                            /* set modal mode to add*/
                            $("#MODE").val('EDIT');

                            /*trigger modal popup extender*/
                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                });
                row = $("#<%=gvAddress.ClientID%> tr:last-child").clone(true);
            });
        }
        function removeAddress(addressID) {
            var result = confirm("Are you sure you would like to remove the selected address record?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'addressID':'" + addressID + "'}",
                    url: getServiceURL().concat('removeEmployeeAddress'),
                    success: function (data)
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#refresh").trigger('click');
                    },
                    error: function (xhr, status, error)
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message)
                    }
                });
            }
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

        function showSuccessNotification(message) {
            $().toastmessage('showSuccessToast', message);
        }

        function showErrorNotification(message) {
            $().toastmessage('showErrorToast', message);
        }
    </script>
</asp:Content>