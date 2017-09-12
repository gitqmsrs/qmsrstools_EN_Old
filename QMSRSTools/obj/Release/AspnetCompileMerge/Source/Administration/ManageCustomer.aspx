<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageCustomer.aspx.cs" Inherits="QMSRSTools.Administration.ManageCustomer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
     <div id="AffectedParty_Header" class="moduleheader">Manage Parties</div>

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="" alt="" />
  
        <img id="newcustomer" src="../Images/new_file.png" class="imgButton" title="Create new party" alt=""/>  
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
   
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byCUSTNM">Filter by Name</li>
                <li id="byCUSTTYP">Filter by Type of Party</li>
            </ul>
        </div>
        <div id="CUSTNameContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CustomerFNameLabel" style="width:100px;">Name:</div>
            <div id="CustomerFNameField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="CUSTNMTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
            </div>
        </div>
        <div id="CUSTTypeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CustomerFTypeLabel" style="width:100px;">Party Type:</div>
            <div id="CustomerFTypeField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="CUSTTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="CUSTTYPF_LD" class="control-loader"></div>
        </div>
    </div>
    
    <div id="custwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
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
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
        </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
       </div>

        <div id="customeraccordion">
            <h3>Party Information</h3>
            <div id="CUST_INFO">

                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="CUSTIDLabel" class="requiredlabel">Party ID:</div>
                    <div id="CUSTIDField" class="fielddiv" style="width:auto">
                        <asp:TextBox ID="CUSTIDTxt" runat="server" CssClass="textbox" Width="90px"></asp:TextBox>
                        <asp:Label ID="CUSTIDLbl" runat="server" CssClass="label"  style="width:auto;"></asp:Label>
                    </div>
                    <div id="IDlimit" class="textremaining"></div>

                    <asp:RequiredFieldValidator ID="CUSTIDVal" runat="server" Display="None" ControlToValidate="CUSTIDTxt" ErrorMessage="Enter a unique ID of the party" ValidationGroup="General"></asp:RequiredFieldValidator> 
                    
                    <asp:CustomValidator id="CUSTIDTxtFVal" runat="server" ValidationGroup="General" 
                    ControlToValidate = "CUSTIDTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
                    ClientValidationFunction="validateIDField">
                    </asp:CustomValidator>         
                </div>
        
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="CustomerTypeLabel" class="requiredlabel">Party Type:</div>
                    <div id="CustomerTypeField" class="fielddiv" style="width:170px">
                        <asp:DropDownList ID="TYPCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="TYP_LD" class="control-loader"></div>

                    <span id="PRTYTYPADD" class="addnew" style="" runat="server" title="Create new party type"></span>
            
                    <asp:RequiredFieldValidator ID="TYPTxtVal" runat="server" Display="None" ControlToValidate="TYPCBox" ErrorMessage="Select customer type" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                    <asp:CompareValidator ID="TYPVal" runat="server" ControlToValidate="TYPCBox" ValidationGroup="General"
                    Display="None" ErrorMessage="Select customer type" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0"></asp:CompareValidator>
                </div>

                <div id="SelectPRTY" class="selectbox" style="top:160px; left:100px; width:350px;">
                    <div id="PRTYClose" class="selectboxclose"></div>
                    
                    <div style="float:left; width:100%; height:20px; margin-top:5px;">
                        <div id="SelectEmployeeUnitLabel" class="requiredlabel" style="width:100px;">Party Type:</div>
                        <div id="SelectEmployeeUnitField" class="fielddiv" style="width:200px">
                            <asp:TextBox ID="PRTYNMTxt" runat="server" CssClass="textbox" Width="190px"></asp:TextBox>
                        </div>
                        
                        <img id="Submit" src="../Images/find.png" class="imgButton" title="Submit" alt="" /> 
    
                        <asp:RequiredFieldValidator ID="PRTYNMTxtVal" runat="server" Display="Dynamic" CssClass="validator" ControlToValidate="PRTYNMTxt" ErrorMessage="Enter the type of the party" ValidationGroup="popup"></asp:RequiredFieldValidator>
                        
                        <asp:CustomValidator id="PRTYNMFVal" runat="server" ValidationGroup="popup" CssClass="validator" 
                        ControlToValidate = "PRTYNMTxt" Display="Dynamic" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                        ClientValidationFunction="validateSpecialCharacters">
                        </asp:CustomValidator>
                    </div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="CustomerNameLabel" class="requiredlabel">Party Name:</div>
                    <div id="CustomerNameField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="CUSNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                    </div>
                    <div id="PRTNMlimit" class="textremaining"></div>

                    <asp:RequiredFieldValidator ID="CUSTNMVal" runat="server" Display="None" ControlToValidate="CUSNMTxt" ErrorMessage="Enter the name of the customer" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                    <asp:CustomValidator id="CUSNMTxtFVal" runat="server" ValidationGroup="General"
                    ControlToValidate = "CUSNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
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
            <h3>Address Details</h3>
            <div id="CUST_ADDR">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="AddressLine1Label" class="requiredlabel">Address Line 1:</div>
                    <div id="AddressLine1Field" class="fielddiv" style="width:400px;">
                        <asp:TextBox ID="ADD1Txt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                    </div>
                    <div id="ADD1limit" class="textremaining"></div>
       
                    <asp:RequiredFieldValidator ID="ADD1Val" runat="server" Display="None" ControlToValidate="ADD1Txt" ErrorMessage="Enter the primary address for the customer" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                    <asp:CustomValidator id="ADD1TxtFVal" runat="server" ValidationGroup="General" 
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

                    <asp:CustomValidator id="ADD2TxtFVal" runat="server" ValidationGroup="General" 
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

                    <asp:RequiredFieldValidator ID="COUNTTxtVal" runat="server" Display="None" ControlToValidate="COUNTCBox" ErrorMessage="Select the country of the address" ValidationGroup="General"></asp:RequiredFieldValidator>
         
                    <asp:CompareValidator ID="COUNTVal" runat="server" ControlToValidate="COUNTCBox"
                    Display="None" ErrorMessage="Select the country of the address" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
                </div>
        
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="City" class="requiredlabel">City:</div>
                    <div id="CityField" class="fielddiv" style="width:150px;">
                        <asp:TextBox ID="CTYTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                    </div>
            
                    <div id="CTYlimit" class="textremaining"></div>
       
                    <asp:RequiredFieldValidator ID="CTYVal" runat="server" Display="None" ControlToValidate="CTYTxt" ErrorMessage="Enter the name of the city" ValidationGroup="General"></asp:RequiredFieldValidator>       
                    
                    <asp:CustomValidator id="CTYTxtFVal" runat="server" ValidationGroup="General" 
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
       
                    <asp:CustomValidator id="POSTTxtVal" runat="server" ValidationGroup="General" 
                    ControlToValidate = "POSTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator> 

                </div>
        </div>
        <h3>Contact Info (Optional)</h3>
        <div id="CUST_CONT">
            <img id="newContact" src="../Images/new_file.png" class="imgButton" alt="" title="Add new contact" />
         
            <div id="table" style=" margin-top:10px; display:none;">
                <div id="row_header" class="tr">
                    <div id="col0_head" class="tdh" style="width:50px;"></div>
                    <div id="col1_head" class="tdh" style="width:30%">Contact Number</div>
                    <div id="col2_head" class="tdh" style="width:30%">Contact Type</div>
                </div>
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
      $(function ()
      {
          var param = '';
          var empty = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);

      $("#customeraccordion").accordion();

      refresh(empty);

      $("#deletefilter").bind('click', function () {
          hideAll();
          refresh(empty);
      });

      $("#refresh").bind('click', function ()
      {
          hideAll();
          refresh(empty);
      });

      $("#byCUSTNM").bind('click', function () {
          hideAll();
          $("#CUSTNameContainer").show();
      });

      $("#byCUSTTYP").bind('click', function () {
          hideAll();
          loadComboboxAjax('loadCustomerType', "#<%=CUSTTYPCBox.ClientID%>", "#CUSTTYPF_LD");
          $("#CUSTTypeContainer").show();
      });

      $("#<%=PRTYTYPADD.ClientID%>").hover(function ()
      {
          $("#<%=PRTYNMTxt.ClientID%>").val('');
          $("#SelectPRTY").show();
      });

      $("#PRTYClose").bind('click', function ()
      {
          loadComboboxAjax('loadCustomerType', "#<%=TYPCBox.ClientID%>", "#TYP_LD");
       
         $("#SelectPRTY").hide('800');
      });

      $("#Submit").bind('click', function ()
      {
          var isPageValid = Page_ClientValidate('popup');
          if (isPageValid) {
              $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json; charset=utf-8",
                     dataType: "json",
                     data: "{'type':'" + $("#<%=PRTYNMTxt.ClientID%>").val() + "'}",
                     url: getServiceURL().concat("createCustomerType"),
                     success: function (data)
                     {
                         $("#PRTYClose").trigger('click');
                     },
                     error: function (xhr, status, error)
                     {
                         var r = jQuery.parseJSON(xhr.responseText);
                         alert(r.Message);
                     }
                 });
          }
          else {
              alert('Please make sure that the warning highlighted in red color is fulfilled');
          }
      });

      /*filter according to the name of the customer*/
      $("#<%=CUSTNMTxt.ClientID%>").keyup(function () {
        filterByName($(this).val(), empty);
      });

     /*filter according to customer type*/
     $("#<%=CUSTTYPCBox.ClientID%>").change(function () {
         if ($(this).val() != 0) {
             filterByType($(this).val(), empty);
         }
     });

     $("#newcustomer").click(function () {
         /* set modal mode to add*/
         $("#MODE").val('ADD');

         /* clear all previous values */
         reset();

         /*add CSS readonly*/
         $("#<%=CUSTIDTxt.ClientID%>").removeClass('readonly');
          $("#<%=CUSTIDTxt.ClientID%>").addClass('textbox');
          $("#<%=CUSTIDTxt.ClientID%>").attr('readonly', false);

          if ($("#<%=CUSTIDLbl.ClientID%>").css('display') == 'none') {
              $("#<%=CUSTIDLbl.ClientID%>").show();
          }

          loadLastIDAjax('getLastCustomerID', "#<%=CUSTIDLbl.ClientID%>");

         loadComboboxAjax('loadCustomerType', "#<%=TYPCBox.ClientID%>", "#TYP_LD");
         loadComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>", "#CTRY_LD");

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
          $("#<%=CUSTIDTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

          /*attach party name to limit plugin*/
          $("#<%=CUSNMTxt.ClientID%>").limit({ id_result: 'PRTNMlimit', alertClass: 'alertremaining', limit: 100 });

          /*attach contact person to limit plugin*/
          $("#<%=CONTPRSTxt.ClientID%>").limit({ id_result: 'CPRSlimit', alertClass: 'alertremaining', limit: 100 });
          
          /*attach email address to limit plugin*/
          $("#<%=EMAILTxt.ClientID%>").limit({ id_result: 'EMLlimit', alertClass: 'alertremaining', limit: 100 });

          /*attach website to limit plugin*/
          $("#<%=WEBTxt.ClientID%>").limit({ id_result: 'WEBlimit', alertClass: 'alertremaining', limit: 100 });

         /*attach address line 1 to limit plugin*/
         $("#<%=ADD1Txt.ClientID%>").limit({ id_result: 'ADD1limit', alertClass: 'alertremaining', limit: 100 });

         /*attach address line 2 to limit plugin*/
         $("#<%=ADD2Txt.ClientID%>").limit({ id_result: 'ADD2limit', alertClass: 'alertremaining', limit: 200 });

         /*attach city to limit plugin*/
         $("#<%=CTYTxt.ClientID%>").limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 100 });

         /*attach postal code to limit plugin*/
         $("#<%=POSTTxt.ClientID%>").limit({ id_result: 'PSTlimit', alertClass: 'alertremaining', limit: 100 });

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
                         var customer =
                         {
                             CustomerNo: $("#<%=CUSTIDTxt.ClientID%>").val(),
                             CustomerType: $("#<%=TYPCBox.ClientID%>").find('option:selected').text(),
                             CustomerName: $("#<%=CUSNMTxt.ClientID%>").val(),
                             ContactPerson: $("#<%=CONTPRSTxt.ClientID%>").val(),
                             EmailAddress: $("#<%=EMAILTxt.ClientID%>").val(),
                             Website: $("#<%=WEBTxt.ClientID%>").val(),
                             Address:
                             {
                                 AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                                 AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                                 Country: $("#<%=COUNTCBox.ClientID%>").find('option:selected').text(),
                                 City: $("#<%=CTYTxt.ClientID%>").val(),
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
                             url: getServiceURL().concat("createNewCustomer"),
                             success: function (data)
                             {
                                 $("#SaveTooltip").fadeOut(500, function () {
                                     ActivateSave(true);

                                     $("#cancel").trigger('click');
                                     $("#refresh").trigger('click');
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
                     else {
                         var customer =
                         {
                             CustomerNo: $("#<%=CUSTIDTxt.ClientID%>").val(),
                             CustomerType: $("#<%=TYPCBox.ClientID%>").find('option:selected').text(),
                             CustomerName: $("#<%=CUSNMTxt.ClientID%>").val(),
                             ContactPerson: $("#<%=CONTPRSTxt.ClientID%>").val(),
                             EmailAddress: $("#<%=EMAILTxt.ClientID%>").val(),
                             Website: $("#<%=WEBTxt.ClientID%>").val(),
                             Address:
                             {
                                 AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                                 AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                                 Country: $("#<%=COUNTCBox.ClientID%>").find('option:selected').text(),
                                 City: $("#<%=CTYTxt.ClientID%>").val(),
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
                             success: function (data)
                             {
                                 $("#SaveTooltip").fadeOut(500, function () {
                                     ActivateSave(true);

                                     $("#cancel").trigger('click');
                                     $("#refresh").trigger('click');
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

     $("#newContact").click(function () {
         $("#table").table('addRow',
         {
             Number: '',
             Type: '',
             Status: 3
         });
     });
 });

  function removeCustomer(ID, empty) {
      var result = confirm("Are you sure you would like to remove the selected customer record?");
      if (result == true) {
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
                  alert(r.Message);
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
                      alert(r.Message);
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
                      alert(r.Message);
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
                      alert(r.Message);
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
          $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
          $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'  />");
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
              else if ($(this).attr('id').search('edit') != -1) {
                  $(this).bind('click', function () {
                      /* set modal mode to edit*/
                      $("#MODE").val('EDIT');

                      /*clear all fields*/
                      reset();

                      /*bind customer type*/
                      bindComboboxAjax('loadCustomerType', '#<%=TYPCBox.ClientID%>', $(customer).attr("CustomerType"), "#TYP_LD");

                      /*bind customer ID*/
                      $("#<%=CUSTIDTxt.ClientID%>").val($(customer).attr("CustomerNo"));

                      /*set customerID to readonly mode*/
                      $("#<%=CUSTIDTxt.ClientID%>").attr('readonly', true);

                      /*add CSS readonly*/
                      $("#<%=CUSTIDTxt.ClientID%>").removeClass('textbox');
                      $("#<%=CUSTIDTxt.ClientID%>").addClass('readonly');
                      $("#<%=CUSTIDLbl.ClientID%>").hide();

                      /*bind customer name*/
                      $("#<%=CUSNMTxt.ClientID%>").val($(customer).attr("CustomerName"));

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
                      bindComboboxAjax('loadCountries', '#<%=COUNTCBox.ClientID%>', $(xmladdress).find('CustomerAddress').attr('Country'), "#CTRY_LD");

                      /*bind city*/
                      $("#<%=CTYTxt.ClientID%>").val($(xmladdress).find('CustomerAddress').attr('City'));


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
                      $("#<%=CUSTIDTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

                      /*attach party name to limit plugin*/
                      $("#<%=CUSNMTxt.ClientID%>").limit({ id_result: 'PRTNMlimit', alertClass: 'alertremaining', limit: 100 });

                      /*attach contact person to limit plugin*/
                      $("#<%=CONTPRSTxt.ClientID%>").limit({ id_result: 'CPRSlimit', alertClass: 'alertremaining', limit: 100 });

                      /*attach email address to limit plugin*/
                      $("#<%=EMAILTxt.ClientID%>").limit({ id_result: 'EMLlimit', alertClass: 'alertremaining', limit: 100 });

                      /*attach website to limit plugin*/
                      $("#<%=WEBTxt.ClientID%>").limit({ id_result: 'WEBlimit', alertClass: 'alertremaining', limit: 100 });

                      /*attach address line 1 to limit plugin*/
                      $("#<%=ADD1Txt.ClientID%>").limit({ id_result: 'ADD1limit', alertClass: 'alertremaining', limit: 100 });

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

                      /*trigger modal popup extender*/
                      $("#<%=alias.ClientID%>").trigger('click');
                  });
              }
          });

          row = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);
      });
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
