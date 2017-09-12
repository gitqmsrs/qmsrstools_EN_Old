<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageCustomer.aspx.cs" Inherits="QMSRSTools.Administration.ManageCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
     <div id="AffectedParty_Header" class="moduleheader">Manage Parties</div>

    <div class="toolbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="" alt="" />
  
        <img id="newcustomer" src="/Images/new_file.png" class="imgButton" title="Create new party" alt=""/>  
   
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byPRTYNM">Filter by Name</li>
                <li id="byPRTYTYP">Filter by Party Type</li>
            </ul>
        </div>
    </div>
    
    <div id="ExternalPartyNameContainer" class="filter">
            <div id="PartyNameFLabel" class="filterlabel">Name of External Party:</div>
            <div id="PartyNameFField" class="filterfield">
                <asp:TextBox ID="PRTYNMFTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
            </div>
        </div>

        <div id="ExternalPartyTypeContainer" class="filter">
            <div id="PartyTypeFLabel" class="filterlabel">Party Type:</div>
            <div id="PartyTypeFField" class="filterfield">
                <asp:DropDownList ID="PRTYTYPFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="PRTYTYPF_LD" class="control-loader"></div>
        </div>

    <div id="custwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="CustomerNo" HeaderText="Party No" />
            <asp:BoundField DataField="CustomerType" HeaderText="Type" />
            <asp:BoundField DataField="CustomerName" HeaderText="Name" />
            <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" />
            <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
       
        </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Party Details<span id="close" class="modalclose" title="Close">X</span></div>
     
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
        </div>

        <ul id="tabul" style="margin-top:30px;">
            <li id="Details" class="ntabs">Main Information</li>
            <li id="Address" class="ntabs">Address Details</li>
            <li id="Contact" class="ntabs">Contact Info (Optional)</li>
        </ul>

        <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">
             <div id="validation_dialog_general">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
             </div>
             
             <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="PartyTypeIDLabel" class="requiredlabel">Party ID:</div>
                <div id="PartyTypeIDField" class="fielddiv" style="width:auto">
                    <asp:TextBox ID="PRTIDTxt" runat="server" CssClass="textbox" Width="90px"></asp:TextBox>
                    <asp:Label ID="PRTIDLbl" runat="server" CssClass="label"  style="width:auto;"></asp:Label>
                </div>
                
                <div id="IDlimit" class="textremaining"></div>

                <asp:RequiredFieldValidator ID="PRTIDVal" runat="server" Display="None" ControlToValidate="PRTIDTxt" ErrorMessage="Enter a unique ID of the external party" ValidationGroup="General"></asp:RequiredFieldValidator> 
                    
                <asp:CustomValidator id="PRTIDTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "PRTIDTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
                ClientValidationFunction="validateIDField">
                </asp:CustomValidator>         
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="PartyTypeLabel" class="requiredlabel">Party Type:</div>
                <div id="PartyTypeField" class="fielddiv" style="width:170px">
                    <asp:DropDownList ID="PRTYTYPCBox" AutoPostBack="false" Width="170px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="TYP_LD" class="control-loader"></div>

                <span id="PRTYTYPSelect" class="searchactive" style="margin-left:10px" runat="server" title="Select external party type"></span>
            
                <asp:RequiredFieldValidator ID="PRTYTYPTxtVal" runat="server" Display="None" ControlToValidate="PRTYTYPCBox" ErrorMessage="Select external party type" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:CompareValidator ID="PRTYTYPVal" runat="server" ControlToValidate="PRTYTYPCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select external party type" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div id="SearchPartyType" class="selectbox">
                <div class="toolbox">
                    <img id="refreshTYP" src="/Images/refresh.png" class="imgButton" alt="" title="Refresh ISO Standards"/>
                    <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
                </div>

                <div id="PartyTypeContainer" class="filterselectbox" style="display:block;">
                    <div id="PartyTypeNewLabel" class="filterlabel">External Party:</div>
                    <div id="PartyTypeNewField" class="filterfield">
                        <asp:TextBox ID="PRTYPTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
                    </div>

                    <img id="Submit" src="/Images/find.png" class="imgButton" style="padding-top:1px;" title="Submit" alt="" /> 

                    <asp:RequiredFieldValidator ID="PRTYPTxtVal" runat="server" Display="None" ControlToValidate="PRTYPTxt" ValidationGroup="popup"></asp:RequiredFieldValidator>
                        
                    <asp:CustomValidator id="PRTYPTxtFVal" runat="server" ValidationGroup="popup" 
                    ControlToValidate = "PRTYPTxt" Display="None"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator>
                </div>
        
                <div id="FLTR_LD" class="control-loader"></div> 
        
                <div id="PRTYPScroll" class="gridscroll">
                        <asp:GridView id="gvPartyType" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
                        GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:TemplateField ShowHeader="false">
                                <ItemTemplate>
                                </ItemTemplate>
                            </asp:TemplateField>
                       
                            <asp:BoundField DataField="PartyTypeID" HeaderText="ID" />
                            <asp:BoundField DataField="PartyType" HeaderText="External Party Type" />
                            <asp:BoundField DataField="Description" HeaderText="Description" />
                        </Columns>
                        </asp:GridView>
                </div>
            </div>
                
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="PartyNameLabel" class="requiredlabel">Party Name:</div>
                <div id="PartyNameField" class="fielddiv" style="width:250px;">
                    <asp:TextBox ID="PRTYNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
                
                <div id="PRTNMlimit" class="textremaining"></div>

                <asp:RequiredFieldValidator ID="PRTYNMTxtVal" runat="server" Display="None" ControlToValidate="PRTYNMTxt" ErrorMessage="Enter the name of the external party" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:CustomValidator id="PRTYNMTxtFVal" runat="server" ValidationGroup="General"
                ControlToValidate = "PRTYNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ContactPersonLabel" class="labeldiv">Contact Person:</div>
                <div id="ContactPersonField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="CONTPRSTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>   
                    
                <div id="CPRSlimit" class="textremaining"></div>
                                        
                <asp:CustomValidator id="CONTPRSTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "CONTPRSTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
                
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="EmailAddressLabel" class="labeldiv">Email Address:</div>
                <div id="EmailAddressField" class="fielddiv" style="width:200px;">
                    <asp:TextBox ID="EMAILTxt" runat="server" CssClass="textbox" Width="190px"></asp:TextBox>
                </div>
                <div id="EMLlimit" class="textremaining"></div>

                <asp:RegularExpressionValidator ID="EMAILFVal" runat="server" ControlToValidate="EMAILTxt"
                Display="None" ErrorMessage="Incorrect email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="General"></asp:RegularExpressionValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="WebsiteLabel" class="labeldiv">Website URL:</div>
                <div id="WebsiteField" class="fielddiv" style="width:200px;">
                    <asp:TextBox ID="WEBTxt" runat="server" CssClass="textbox" Width="190px"></asp:TextBox>
                </div>
            
                <div id="WEBlimit" class="textremaining"></div>
            
                <asp:RegularExpressionValidator ID="WEBFVal" runat="server" ControlToValidate="WEBTxt"
                Display="None" ErrorMessage="URL should start with http(s) followed by URL  e.g.(http://www.example.com)" ValidationExpression="^(http|https)://([A-Za-z0-9\-_]+\.)+[A-Za-z0-9_\-]+(/[A-Za-z0-9\-_ ./?%&=]*)?$" ValidationGroup="General"></asp:RegularExpressionValidator> 
            </div>
        </div>
        <div id="AddressTB" class="tabcontent" style="display:none; height:450px;">
             <div id="validation_dialog_address">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Address" />
             </div>
            
             <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="AddressLine1Label" class="requiredlabel">Address Line 1:</div>
                <div id="AddressLine1Field" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="ADD1Txt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                </div>
                <div id="ADD1limit" class="textremaining"></div>
       
                <asp:RequiredFieldValidator ID="ADD1Val" runat="server" Display="None" ControlToValidate="ADD1Txt" ErrorMessage="Enter the primary address for the customer" ValidationGroup="Address"></asp:RequiredFieldValidator>
                    
                <asp:CustomValidator id="ADD1TxtFVal" runat="server" ValidationGroup="Address" 
                ControlToValidate = "ADD1Txt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>   
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AddressLine2" class="labeldiv">Address Line 2:</div>
                <div id="AddressLine2Field" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="ADD2Txt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                </div>
                    
                <div id="ADD2limit" class="textremaining"></div>

                <asp:CustomValidator id="ADD2TxtFVal" runat="server" ValidationGroup="Address" 
                ControlToValidate = "ADD2Txt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="Country" class="requiredlabel">Country:</div>
                <div id="CountryField" class="fielddiv" style="width:150px;">
                    <asp:DropDownList ID="COUNTCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="CTRY_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="COUNTTxtVal" runat="server" Display="None" ControlToValidate="COUNTCBox" ErrorMessage="Select the country of the address" ValidationGroup="Address"></asp:RequiredFieldValidator>
         
                <asp:CompareValidator ID="COUNTVal" runat="server" ControlToValidate="COUNTCBox"
                Display="None" ErrorMessage="Select the country of the address" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Address"></asp:CompareValidator>
            </div>

            <div id="divState" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="State" class="requiredlabel">State:</div>
                <div id="StateField" class="fielddiv" style="width:150px;">
                    <asp:DropDownList ID="ddlState" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="STATE_LD" class="control-loader"></div>

            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="City" class="requiredlabel">City:</div>
                <div id="CityField2" class="fielddiv" style="width:150px;">
                    <asp:DropDownList ID="ddlCity" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="CITY_LD" class="control-loader"></div>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlCity"
                Display="None" ErrorMessage="Select the city of the address" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Address"></asp:CompareValidator>
            </div>
        
            <%--<div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CityLabel" class="requiredlabel">City:</div>
                <div id="CityField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="CTYTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                </div>
            
                <div id="CTYlimit" class="textremaining"></div>
       
                <asp:RequiredFieldValidator ID="CTYVal" runat="server" Display="None" ControlToValidate="CTYTxt" ErrorMessage="Enter the name of the city" ValidationGroup="Address"></asp:RequiredFieldValidator>       
                    
                <asp:CustomValidator id="CTYTxtFVal" runat="server" ValidationGroup="Address" 
                ControlToValidate = "CTYTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>         
            </div>--%>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="PostalCode" class="labeldiv">Postal Code:</div>
                <div id="PostalCodeField" class="fielddiv">
                    <asp:TextBox ID="POSTTxt" runat="server" CssClass="textbox"></asp:TextBox>
                </div>
                <div id="PSTlimit" class="textremaining"></div>
       
                <asp:CustomValidator id="POSTTxtVal" runat="server" ValidationGroup="Address" 
                ControlToValidate = "POSTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 

            </div>
        </div>
        <div id="ContactTB" class="tabcontent" style="display:none; height:450px;">
            <img id="newContact" src="/Images/new_file.png" class="imgButton" alt="" title="Add new contact" />
         
            <div id="table" class="table" style=" margin-top:10px; display:none;">
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
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var param = '';
        var empty = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);
        var emptyparty = $("#<%=gvPartyType.ClientID%> tr:last-child").clone(true);

        refresh(empty);


        $("#refresh").bind('click', function () {
            hideAll();
            refresh(empty);
        });

        $("#byPRTYNM").bind('click', function () {
            hideAll();

            $("#<%=PRTYNMFTxt.ClientID%>").val('');
            $("#ExternalPartyNameContainer").show();
        });

        $("#byPRTYTYP").bind('click', function () {
            hideAll();

            loadXMLPartyType("#PRTYTYPF_LD", "#<%=PRTYTYPFCBox.ClientID%>");

            $("#ExternalPartyTypeContainer").show();
        });

        $("#<%=PRTYTYPSelect.ClientID%>").bind('click', function (e) {
            $("#<%=PRTYPTxt.ClientID%>").val('');

            showPartyDialog(e.pageX, e.pageY, emptyparty);

        });

        $("#refreshTYP").bind('click', function () {
            loadExternalPartyTypeGrid(emptyparty);
        });

        $("#closeBox").bind('click', function () {
            $("#SearchPartyType").hide('800');

        });


        /*create a new external party*/
        $("#Submit").bind('click', function () {
            var isPageValid = Page_ClientValidate('popup');
            if (isPageValid) {
                $(".modalPanel").css("cursor", "wait");

                var external =
                {

                    TypeName: $("#<%=PRTYPTxt.ClientID%>").val()
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(external) + "\'}",
                    url: getServiceURL().concat("createCustomerType"),
                    success: function (data) {
                        $(".modalPanel").css("cursor", "default");

                        $("#refreshTYP").trigger('click');
                    },
                    error: function (xhr, status, error) {
                        $(".modalPanel").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    }
                });
            }
            else {
                alert('Enter the type of the external party');
            }
        });

        /*filter according to the name of the external*/
        $("#<%=PRTYNMFTxt.ClientID%>").keyup(function () {
            filterByName($(this).val(), empty);
        });

        /*filter according to customer type*/
        $("#<%=PRTYTYPFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByType($(this).val(), empty);
            }
        });

        $("#newcustomer").click(function () {
            /* clear all previous values */
            resetGroup('.modalPanel');


            /* set modal mode to add*/
            $("#MODE").val('ADD');

            /*add CSS readonly*/
            $("#<%=PRTIDTxt.ClientID%>").removeClass('readonly');
            $("#<%=PRTIDTxt.ClientID%>").addClass('textbox');
            $("#<%=PRTIDTxt.ClientID%>").attr('readonly', false);

            if ($("#<%=PRTIDLbl.ClientID%>").css('display') == 'none') {
                $("#<%=PRTIDLbl.ClientID%>").show();
            }

            loadLastIDAjax('getLastCustomerID', "#<%=PRTIDLbl.ClientID%>");

            loadXMLPartyType("#TYP_LD", "#<%=PRTYTYPCBox.ClientID%>");

            //loadComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>", "#CTRY_LD");

            var module = "";
            var countryID = 0;
            var controls = new Array();
            

            //bindComboboxAjaxKeyValue('loadCountryList', '#<%=COUNTCBox.ClientID%>', countryID, "#CTRY_LD");
            BindCountry('loadCountries2', '#<%=COUNTCBox.ClientID%>', countryID, "#CTRY_LD");

            if (countryID == "1" || countryID == "2" || countryID == "95") {
                //Load States
                module = "'countryId':'" + countryID + "'";
                bindParamComboboxAjaxKeyValue('loadStates', '#<%=ddlState.ClientID%>', module, 0, "#STATE_LD");

                //Load City By Region
                var regionID = $("#<%=ddlState.ClientID%>").val();
                module = "'regionId':'" + regionID + "'";
                
                bindParamComboboxAjaxKeyValue('loadCitiesByRegion', '#<%=ddlCity.ClientID%>', module, 0, "#CITY_LD");
            }
            else {
                //Load City By Country
                module = "'countryId':'" + countryID + "'";
                //bindParamComboboxAjaxKeyValue('loadCitiesByCountry', '#<%=ddlCity.ClientID%>', module, 0, "#CITY_LD");
                BindCityByCountry('loadCitiesByCountry2', '#<%=ddlCity.ClientID%>', module, 0, "#CITY_LD");
            }
             

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


            /*attach party ID to limit plugin*/
            $("#<%=PRTIDTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach party name to limit plugin*/
            $("#<%=PRTYNMTxt.ClientID%>").limit({ id_result: 'PRTNMlimit', alertClass: 'alertremaining', limit: 90 });

            /*attach contact person to limit plugin*/
            $("#<%=CONTPRSTxt.ClientID%>").limit({ id_result: 'CPRSlimit', alertClass: 'alertremaining', limit: 90 });

            /*attach email address to limit plugin*/
            $("#<%=EMAILTxt.ClientID%>").limit({ id_result: 'EMLlimit', alertClass: 'alertremaining', limit: 90 });

            /*attach website to limit plugin*/
            $("#<%=WEBTxt.ClientID%>").limit({ id_result: 'WEBlimit', alertClass: 'alertremaining', limit: 90 });

            /*attach address line 1 to limit plugin*/
            $("#<%=ADD1Txt.ClientID%>").limit({ id_result: 'ADD1limit', alertClass: 'alertremaining', limit: 190 });

            /*attach address line 2 to limit plugin*/
            $("#<%=ADD2Txt.ClientID%>").limit({ id_result: 'ADD2limit', alertClass: 'alertremaining', limit: 190 });

            /*attach city to limit plugin*/
            <%--$("#<%=CTYTxt.ClientID%>").limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 90 });--%>

            /*attach postal code to limit plugin*/
            $("#<%=POSTTxt.ClientID%>").limit({ id_result: 'PSTlimit', alertClass: 'alertremaining', limit: 90 });

            /*trigger keyup event for each text box to reset it's character counter*/

            $(".textbox").each(function () {
                $(this).keyup();
            });

            navigate('Details');

            /* trigger modal popup extender*/
            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#save").bind('click', function () {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid) {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var isAddressValid = Page_ClientValidate('Address');
                if (isAddressValid) {
                    if (!$("#validation_dialog_address").is(":hidden")) {
                        $("#validation_dialog_address").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {
                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            if ($("#MODE").val() == 'ADD') {
                                
                                var address = {};

                                address["AddressLine1"] = $("#<%=ADD1Txt.ClientID%>").val();
                                address["AddressLine2"] = $("#<%=ADD2Txt.ClientID%>").val();
                                address["Country"] = $("#<%=COUNTCBox.ClientID%>").find('option:selected').text();
                                address["CountryID"] = $("#<%=COUNTCBox.ClientID%>").val();

                                if ($("#<%=ddlState.ClientID%>").val() != null) {
                                    address["StateID"] = $("#<%=ddlState.ClientID%>").val();
                                }

                                address["CityID"] = $("#<%=ddlCity.ClientID%>").val();
                                address["PostalCode"] = $("#<%=POSTTxt.ClientID%>").val();

                                var customer =
                                {
                                    CustomerNo: $("#<%=PRTIDTxt.ClientID%>").val(),
                                    CustomerType: $("#<%=PRTYTYPCBox.ClientID%>").find('option:selected').text(),
                                    CustomerName: $("#<%=PRTYNMTxt.ClientID%>").val(),
                                    ContactPerson: $("#<%=CONTPRSTxt.ClientID%>").val(),
                                    EmailAddress: $("#<%=EMAILTxt.ClientID%>").val(),
                                    Website: $("#<%=WEBTxt.ClientID%>").val(),
                                    <%--                                    Address:
                                    {
                                        AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                                        AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                                        Country: $("#<%=COUNTCBox.ClientID%>").find('option:selected').text(),
                                        CountryID: $("#<%=COUNTCBox.ClientID%>").val(),
                                        StateID: $("#<%=ddlState.ClientID%>").val(),
                                        CityID: $("#<%=ddlCity.ClientID%>").val(),
                                        PostalCode: $("#<%=POSTTxt.ClientID%>").val()
                                    },--%>
                                    Address: address,
                                    Contacts: $("#table").table('getJSON')
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(customer) + "\'}",
                                    url: getServiceURL().concat("createNewCustomer"),
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
                                            showErrorNotification(r.Message);
                                        });
                                    }
                                });
                            }
                            else {
                                var customer =
                                {
                                    CustomerNo: $("#<%=PRTIDTxt.ClientID%>").val(),
                                    CustomerType: $("#<%=PRTYTYPCBox.ClientID%>").find('option:selected').text(),
                                    CustomerName: $("#<%=PRTYNMTxt.ClientID%>").val(),
                                    ContactPerson: $("#<%=CONTPRSTxt.ClientID%>").val(),
                                    EmailAddress: $("#<%=EMAILTxt.ClientID%>").val(),
                                    Website: $("#<%=WEBTxt.ClientID%>").val(),
                                    Address:
                                    {
                                        AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                                        AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                                        Country: $("#<%=COUNTCBox.ClientID%>").find('option:selected').text(),
                                        CountryID: $("#<%=COUNTCBox.ClientID%>").val(),
                                        StateID: $("#<%=ddlState.ClientID%>").val(),
                                        CityID: $("#<%=ddlCity.ClientID%>").val(),
                                        PostalCode: $("#<%=POSTTxt.ClientID%>").val()
                                    },
                                    Contacts: $("#table").table('getJSON')
                                }
                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(customer) + "\'}",
                                    url: getServiceURL().concat("updateCustomer"),
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
                                            showErrorNotification(r.Message);
                                        });
                                    }
                                });
                            }
                        });
                    }
                }

                else {
                    $("#validation_dialog_address").stop(true).hide().fadeIn(500, function () {
                        navigate('Address');
                    });
                }
            }
            else {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    navigate('Details');
                });
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

        $("#tabul li").bind("click", function () {
            navigate($(this).attr("id"));
        });
    });

    function showPartyDialog(x, y,empty)
    {
        loadExternalPartyTypeGrid(empty);

        $("#SearchPartyType").css({ left: x - 420, top: y - 130 });
        $("#SearchPartyType").css({ width: 700, height: 250 });
        $("#SearchPartyType").show();
    }

    function loadExternalPartyTypeGrid(empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $(".modalPanel").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCustomerType"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modalPanel").css("cursor", "default");

                        loadExtenalPartyTypeGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modalPanel").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function removeExternalPartyType(typeid) {
        var result = confirm("Are you sure you would like to remove the selected external party type?");
        if (result == true)
        {
            $(".modalPanel").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'ID':'" + typeid + "'}",
                url: getServiceURL().concat("removeCustomerType"),
                success: function (data)
                {
                    $(".modalPanel").css("cursor", "default");

                    $("#closeBox").trigger('click');
                },
                error: function (xhr, status, error) {
                    $(".modalPanel").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }
    }

    function loadExtenalPartyTypeGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvPartyType.ClientID%> tr").not($("#<%=gvPartyType.ClientID%> tr:first-child")).remove();

        $(xml).find("GenericType").each(function (index, value)
        {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html($(this).attr("TypeID"));
            $("td", row).eq(2).html($(this).attr("TypeName"));
            $("td", row).eq(3).html($(this).attr("Description"));

            $("#<%=gvPartyType.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('delete') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        removeExternalPartyType($(value).attr('TypeID'));
                    });
                }
            });

            row = $("#<%=gvPartyType.ClientID%> tr:last-child").clone(true);

        });
    }

    function loadXMLPartyType(loader, control)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCustomerType"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $(control));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }


    function bindXMLPartyType(loader, control, bound)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCustomerType"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', bound, $(control));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
  function removeCustomer(ID, empty) {
      var result = confirm("Are you sure you would like to remove the selected customer record?");
      if (result == true)
      {
          $(".modulewrapper").css("cursor", "wait");

          $.ajax(
          {
              type: "POST",
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              data: "{'customerID':'" + ID + "'}",
              url: getServiceURL().concat("removeCustomer"),
              success: function (data)
              {
                  $(".modulewrapper").css("cursor", "default");
                  $("#refresh").trigger('click');
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

  function filterByType(type, empty) {
      $("#custwait").stop(true).hide().fadeIn(500, function () {
          $(".modulewrapper").css("cursor", "wait");
          $.ajax(
          {
              type: "POST",
              contentType: "application/json",
              dataType: "json",
              data: "{'type':'" + type + "'}",
              url: getServiceURL().concat('filterCustomerByType'),
              success: function (data) {

                  $("#custwait").fadeOut(500, function () {
                      $(".modulewrapper").css("cursor", "default");

                      if (data) {
                          loadGridView(data.d, empty);
                      }
                  });
              },
              error: function (xhr, status, error) {
                  $("#custwait").fadeOut(500, function () {
                      $(".modulewrapper").css("cursor", "default");

                      var r = jQuery.parseJSON(xhr.responseText);
                      showErrorNotification(r.Message);
                  });
              }
          });
      });
  }
  function filterByName(name, empty)
  {
      $("#custwait").stop(true).hide().fadeIn(500, function () {
          $(".modulewrapper").css("cursor", "wait");
          $.ajax(
          {
              type: "POST",
              contentType: "application/json",
              dataType: "json",
              data: "{'name':'" + name + "'}",
              url: getServiceURL().concat('filterCustomerByName'),
              success: function (data) {
                  $("#custwait").fadeOut(500, function ()
                  {
                      $(".modulewrapper").css("cursor", "default");
                      if (data) {
                          loadGridView(data.d, empty);
                      }
                  });
              },
              error: function (xhr, status, error) {
                  $("#custwait").fadeOut(500, function ()
                  {
                      $(".modulewrapper").css("cursor", "default");
                      var r = jQuery.parseJSON(xhr.responseText);
                      showErrorNotification(r.Message);
                  });
              }
          });
      });
  }
  function refresh(empty) {
      $("#custwait").stop(true).hide().fadeIn(500, function () {
          $(".modulewrapper").css("cursor", "wait");
          $.ajax(
          {
              type: "POST",
              contentType: "application/json; charset=utf-8",
              dataType: "json",
              url: getServiceURL().concat("loadCustomers"),
              success: function (data) {
                  $("#custwait").fadeOut(500, function () {
                      $(".modulewrapper").css("cursor", "default");
                      if (data) {
                          loadGridView(data.d, empty);
                      }
                  });
              },
              error: function (xhr, status, error) {
                  $("#custwait").fadeOut(500, function () {
                      $(".modulewrapper").css("cursor", "default");
                      var r = jQuery.parseJSON(xhr.responseText);
                      showErrorNotification(r.Message);
                  });
              }
          });
      });
  }

  function loadGridView(data, empty) {
      var customer = $.parseXML(data);
      var row = empty;

      $("#<%=gvCustomers.ClientID%> tr").not($("#<%=gvCustomers.ClientID%> tr:first-child")).remove();

      $(customer).find("Customer").each(function (index, customer) {
          $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
          $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'  />");
          $("td", row).eq(2).html($(this).attr("CustomerNo"));
          $("td", row).eq(3).html($(this).attr("CustomerType"));
          $("td", row).eq(4).html($(this).attr("CustomerName"));
          $("td", row).eq(5).html($(this).attr("ContactPerson"));
          $("td", row).eq(6).html($(this).attr("EmailAddress"));

          $("#<%=gvCustomers.ClientID%>").append(row);

          $(row).find('img').each(function () {
              if ($(this).attr('id').search('delete') != -1) {
                  $(this).bind('click', function () {
                      removeCustomer($(customer).attr("CustomerID"), empty);
                  });
              }
              else if ($(this).attr('id').search('edit') != -1)
              {
                  $(this).bind('click', function ()
                  {
                      /* clear all text and combo fields*/
                      resetGroup(".modalPanel");

                      /* set modal mode to edit*/
                      $("#MODE").val('EDIT');

                      /*bind external party type*/
                      bindXMLPartyType("#TYP_LD", '#<%=PRTYTYPCBox.ClientID%>', $(customer).attr("CustomerType"));

                      /*bind customer ID*/
                      $("#<%=PRTIDTxt.ClientID%>").val($(customer).attr("CustomerNo"));

                      /*set customerID to readonly mode*/
                      $("#<%=PRTIDTxt.ClientID%>").attr('readonly', true);

                      /*add CSS readonly*/
                      $("#<%=PRTIDTxt.ClientID%>").removeClass('textbox');
                      $("#<%=PRTIDTxt.ClientID%>").addClass('readonly');
                      $("#<%=PRTIDLbl.ClientID%>").hide();

                      /*bind customer name*/
                      $("#<%=PRTYNMTxt.ClientID%>").val($(customer).attr("CustomerName"));

                      /*bind contact person*/
                      $("#<%=CONTPRSTxt.ClientID%>").val($(customer).attr("ContactPerson"));

                      /*bind email address*/
                      $("#<%=EMAILTxt.ClientID%>").val($(customer).attr("EmailAddress"));

                      /*bind website URL*/
                      $("#<%=WEBTxt.ClientID%>").val($(customer).attr("Website"));

                      /*bind customer address*/

                      var xmladdress = $.parseXML($(customer).attr('XMLAddress'));

                      /*bind customer address line 1*/
                      $("#<%=ADD1Txt.ClientID%>").val($(xmladdress).find('CustomerAddress').attr('AddressLine1'));

                      /*bind customer address line 1*/
                      $("#<%=ADD2Txt.ClientID%>").val($(xmladdress).find('CustomerAddress').attr('AddressLine2'));

                      /*bind country*/
                      var countryID = $(xmladdress).find('CustomerAddress').attr('CountryID');
                      //bindComboboxAjaxKeyValue('loadCountryList', '#<%=COUNTCBox.ClientID%>', countryID, "#CTRY_LD");
                      BindCountry('loadCountries2', '#<%=COUNTCBox.ClientID%>', countryID, "#CTRY_LD");

                      var module = "";
                      var controls = new Array();
                      
                     

                      if (countryID != null && countryID >= 0) {

                          if (countryID == "1" || countryID == "2" || countryID == "95") {
                              //alert("us");
                              //alert(countryID);

                            //Load States
                            $("#divState").show();
                            module = "'countryId':'" + countryID + "'";
                            <%--controls = new Array();
                            controls.push("#<%=ddlState.ClientID%>");--%>

                            var stateID = $(xmladdress).find('CustomerAddress').attr('StateID');
                            bindParamComboboxAjaxKeyValue('loadStates', '#<%=ddlState.ClientID%>', module, stateID, "#STATE_LD");

                            //  alert("state");
                            //alert(stateID);

                            if (stateID != null && stateID > 0) {
                                //Load City By Region
                                module = "'regionId':'" + stateID + "'";
                                <%--controls = new Array();
                                controls.push("#<%=ddlCity.ClientID%>");--%>

                                var cityID = $(xmladdress).find('CustomerAddress').attr('CityID');
                                //alert("city");
                                //alert(cityID);
                                bindParamComboboxAjaxKeyValue('loadCitiesByRegion', '#<%=ddlCity.ClientID%>', module, cityID, "#CITY_LD");
                            }
                            else {
                                //Load City By Country
                                $("#divState").hide();
                                module = "'countryId':'" + countryID + "'";

                                var cityID = $(address).attr('CityID');
                                //bindParamComboboxAjaxKeyValue('loadCitiesByCountry', '#<%=ddlCity.ClientID%>', module, cityID, "#CITY_LD");
                                BindCityByCountry('loadCitiesByCountry2', '#<%=ddlCity.ClientID%>', module, cityID, "#CITY_LD");
                            }
                        }
                        else {
                              //Load City By Country
                            $("#divState").hide();
                            module = "'countryId':'" + countryID + "'";
                           
                            bindParamComboboxAjaxKeyValue('loadStates', '#<%=ddlState.ClientID%>', module, 0, "#STATE_LD");
                            var cityID = $(xmladdress).find('CustomerAddress').attr('CityID');
                            //bindParamComboboxAjaxKeyValue('loadCitiesByCountry', '#<%=ddlCity.ClientID%>', module, cityID, "#CITY_LD");
                            BindCityByCountry('loadCitiesByCountry2', '#<%=ddlCity.ClientID%>', module, cityID, "#CITY_LD");
                        }
                      }

                      /*bind city*/
                      <%--$("#<%=CTYTxt.ClientID%>").val($(xmladdress).find('CustomerAddress').attr('City'));--%>

                      /*bind postal code*/
                      $("#<%=POSTTxt.ClientID%>").val($(xmladdress).find('CustomerAddress').attr('PostalCode'));


                      /*load customer contact details*/
                      var attributes = new Array();
                      attributes.push("Number");
                      attributes.push("Type");

                      var json = $.parseJSON($(customer).attr("JSONContacts"));

                      /*set cell settings*/
                      var settings = new Array();
                      settings.push(JSON.stringify({}));
                      settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadContactType") }));

                      $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });


                      /*attach party ID to limit plugin*/
                      $("#<%=PRTIDTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

                      /*attach party name to limit plugin*/
                      $("#<%=PRTYNMTxt.ClientID%>").limit({ id_result: 'PRTNMlimit', alertClass: 'alertremaining', limit: 90 });

                      /*attach contact person to limit plugin*/
                      $("#<%=CONTPRSTxt.ClientID%>").limit({ id_result: 'CPRSlimit', alertClass: 'alertremaining', limit: 90 });

                      /*attach email address to limit plugin*/
                      $("#<%=EMAILTxt.ClientID%>").limit({ id_result: 'EMLlimit', alertClass: 'alertremaining', limit: 90 });

                      /*attach website to limit plugin*/
                      $("#<%=WEBTxt.ClientID%>").limit({ id_result: 'WEBlimit', alertClass: 'alertremaining', limit: 90 });

                      /*attach address line 1 to limit plugin*/
                      $("#<%=ADD1Txt.ClientID%>").limit({ id_result: 'ADD1limit', alertClass: 'alertremaining', limit: 90 });

                      /*attach address line 2 to limit plugin*/
                      $("#<%=ADD2Txt.ClientID%>").limit({ id_result: 'ADD2limit', alertClass: 'alertremaining', limit: 90 });

                      /*attach city to limit plugin*/
                      <%--$("#<%=CTYTxt.ClientID%>").limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 90 });--%>

                      /*attach postal code to limit plugin*/
                      $("#<%=POSTTxt.ClientID%>").limit({ id_result: 'PSTlimit', alertClass: 'alertremaining', limit: 90 });

                      $(".textbox").each(function ()
                      {
                          $(this).keyup();
                      });

                      navigate('Details');

                      /*trigger modal popup extender*/
                      $("#<%=alias.ClientID%>").trigger('click');
                  });
              }
          });

          row = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);
      });
  }
  //function hideAll() {
  //    $(".filter").each(function () {
  //        $(this).css('display', 'none');

  //    });

  //    $(".contextmenu").hide();
    //}

    // Added by JP - Override the CSS Hover in contextmenu. 
    $("#filterList").hover(function () {
        $('#filterList').removeAttr('style');
    });

    // Added by JP - Hide the contextMenu after click
    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
        $('#filterList').attr('style', 'display:none  !important');
        reset();
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

  function navigate(name)
  {
      /*hide any opened select boxes*/
      $(".selectbox").each(function () {
          $(this).hide('800');
      });

      $("#tabul li").removeClass("ctab");

      $(".tabcontent").each(function () {
          $(this).css('display', 'none');
      });

      $("#" + name).addClass("ctab");
      $("#" + name + "TB").css('display', 'block');
  }

  function showSuccessNotification(message) {
      $().toastmessage('showSuccessToast', message);
  }

  function showErrorNotification(message) {
      $().toastmessage('showErrorToast', message);
  }

  function BindCountry(MethodName, control, bound, loader) {
      $(loader).stop(true).hide().fadeIn(500, function () {

          $.ajax(
          {
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: getServiceURL().concat(MethodName),
              dataType: "json",
              success: function (data) {
                  $(loader).fadeOut(500, function () {
                      clearCombobox(control);

                      var HTML = '<option value=0>Select Value</option>';
                      for (x = 0; x < data.d.length; x++) {
                          HTML += "<option value='" + data.d[x].CountryID + "'>" + data.d[x].CountryName + "</option>";
                      }

                      //alert(HTML);
                      $(control).append(HTML);
                      $(control).val(bound);

                  });
              },
              error: function (xhr, status, error) {
                  $(loader).fadeOut(500, function () {

                      var r = jQuery.parseJSON(xhr.responseText);
                      alert(r.Message);
                  });
              }
          });
      });
  }

  function BindCityByCountry(MethodName, control, param, bound, loader) {
      var parameter = param.split(":");

      $(loader).stop(true).hide().fadeIn(500, function () {
          $.ajax(
          {
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: getServiceURL().concat(MethodName),
              data: "{" + param + "}",
              dataType: "json",
              success: function (data) {
                  $(loader).fadeOut(500, function () {
                      clearCombobox(control);

                      var HTML = '<option value=0>Select Value</option>';
                      for (x = 0; x < data.d.length; x++) {
                          HTML += "<option value='" + data.d[x].CityID + "'>" + data.d[x].CityName + "</option>";
                      }

                      //alert(HTML);
                      $(control).append(HTML);
                      $(control).val(bound);


                  });
              },
              error: function (xhr, status, error) {
                  $(loader).fadeOut(500, function () {
                      var r = jQuery.parseJSON(xhr.responseText);
                      alert(r.Message);
                  });
              }
          });
      });

  }

  function LoadCityByCountry(MethodName, controls, param, loader) {
      $(loader).stop(true).hide().fadeIn(500, function () {
          var parameter = param.split(":");
          $.ajax(
          {
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: getServiceURL().concat(MethodName),
              data: "{" + parameter[0] + ":" + parameter[1] + "}",
              dataType: "json",
              success: function (data) {
                  $(loader).fadeOut(500, function () {
                      $(controls).each(function (i, value) {
                          clearCombobox(controls[i]);
                      });


                      $(controls).each(function (i, value) {
                          var HTML = '<option value=0>Select Value</option>';
                          for (x = 0; x < data.d.length; x++) {
                              HTML += "<option value='" + data.d[x].CityID + "'>" + data.d[x].CityName + "</option>";
                          }
                          $(controls[i]).append(HTML);
                      });
                  });
              },
              error: function (xhr, status, error) {
                  $(loader).fadeOut(500, function () {
                      var r = jQuery.parseJSON(xhr.responseText);
                      alert(r.Message);
                  });
              }
          });
      });
  }

  $("#<%=COUNTCBox.ClientID%>").change(function () {
      var module = "";
      var countryID = $("#<%=COUNTCBox.ClientID%>").val();
      var controls = new Array();

      //alert(countryID);

      if (countryID != null && countryID >= 0) {

          if (countryID == "1" || countryID == "2" || countryID == "95") {
             
              //Load States
              $("#divState").show();
              module = "'countryId':'" + countryID + "'";
              controls = new Array();
              controls.push("#<%=ddlState.ClientID%>");
              loadParamComboboxAjaxKeyValue('loadStates', controls, module, "#STATE_LD");

              //alert("Load City By Region");

              //Load City By Region
              var regionID = $("#<%=ddlState.ClientID%>").val();
              module = "'regionId':'" + regionID + "'";
              controls = new Array();
              controls.push("#<%=ddlCity.ClientID%>");
              loadParamComboboxAjaxKeyValue('loadCitiesByRegion', controls, module, "#CITY_LD");
          }
          else {
              
              //Load City By Country
              $("#divState").hide();
              module = "'countryId':'" + countryID + "'";
              controls = new Array();
              controls.push("#<%=ddlCity.ClientID%>");
              //loadParamComboboxAjaxKeyValue('loadCitiesByCountry', controls, module, "#CITY_LD");
              LoadCityByCountry('loadCitiesByCountry2', controls, module, "#CITY_LD");
          }
      }
  
  });

    $("#<%=ddlState.ClientID%>").change(function () {
          var module = "";
          var regionID = $("#<%=ddlState.ClientID%>").val();
          var controls = new Array();
        
          if (regionID != null && regionID >= 0) {

              //alert("Load City By Region");

              //Load City By Region
              var regionID = $("#<%=ddlState.ClientID%>").val();
              module = "'regionId':'" + regionID + "'";
              controls = new Array();
              controls.push("#<%=ddlCity.ClientID%>");
              loadParamComboboxAjaxKeyValue('loadCitiesByRegion', controls, module, "#CITY_LD");
          }

  });
  
</script>
</asp:Content>
