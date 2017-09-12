<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageEmployee.aspx.cs" Inherits="QMSRSTools.EmployeeManagement.ManageEmployee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Employee_Header" class="moduleheader">Maintain Employee Record</div>

    <div class="toolbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
        
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
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

        <div id="MaritalStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="MaritalStatusFLabel" style="width:100px;">Marital Status:</div>
            <div id="MaritalStatusFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="MRTLSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="MRTLSTSF_LD" class="control-loader"></div>
        </div>

         <div id="OrganizationUnitContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="OrganizationUnitFLabel" style="width:100px;">Organization Unit:</div>
            <div id="OrganizationUnitFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ORGUNTF_LD" class="control-loader"></div>
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
    </div>

    
    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="EMPwait" style="margin-top:20px;display:none;">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvEmployees" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Employee Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="ProfileTooltip" class="tooltip" style="margin-top:10px;">
            <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p></p>
        </div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_details" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Details" />
        </div>

        <ul id="tabul" style="margin-top:40px;">
            <li id="Details" class="ntabs">Employee Information</li>
            <li id="Contract" class="ntabs">Current Contract</li>
        </ul>

        <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">

            <div id="validation_dialog_general" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>

            <div id="profilecontainer" class="employeeimage">
                <img id="profileimg" src="#" alt="" />
            
                <div class="uploaddiv"></div>
                <input id="fileupload" type="file" name="file" style="width:0; height:0; display:block;"/>
                <input id="filename" type="hidden" value=""/>
                <div id="uploadmessage"></div>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="PersonnelID" class="requiredlabel">Personnel ID:</div>
                <div id="PersonnelIDField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="PERSIDTxt" runat="server" CssClass="readonly" Width="140px" ReadOnly="true"></asp:TextBox>
                </div> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="Title" class="requiredlabel">Title:</div>
                <div id="TitleField" class="fielddiv">
                    <asp:DropDownList ID="TitleCBox" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="TTL_LD" class="control-loader"></div> 

                <asp:RequiredFieldValidator ID="TitleVal" runat="server" Display="None" ControlToValidate="TitleCBox" ErrorMessage="Select the title of the employee" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:CompareValidator ID="TitleFVal" runat="server" ControlToValidate="TitleCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select the title of the employee" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
 
            </div>
             
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="FirstName" class="requiredlabel">First Name:</div>
                <div id="FirstNameField" class="fielddiv" style="width:250px;">
                    <asp:TextBox ID="FNameTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
                <div id="FNMlimit" class="textremaining"></div>
       
                <asp:RequiredFieldValidator ID="FRSTNTxtVal" runat="server" Display="None" ControlToValidate="FNameTxt" ErrorMessage="Enter the first name of the employee" CssClass="validator" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:CustomValidator id="FNameTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "FNameTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>  
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="MiddleName" class="requiredlabel">Middle Name:</div>
                <div id="MiddleNameField" class="fielddiv" style="width:250px;">
                    <asp:TextBox ID="MNameTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
                <div id="MNMlimit" class="textremaining"></div>
       
                <asp:RequiredFieldValidator ID="MDLNTxtVal" runat="server" Display="None" ControlToValidate="MNameTxt" ErrorMessage="Enter the middle name of the employee" ValidationGroup="General"></asp:RequiredFieldValidator>
                   
                <asp:CustomValidator id="MNameTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "MNameTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="LastNameLabel" class="requiredlabel">Last Name:</div>
                <div id="LastNameField" class="fielddiv" style="width:250px;">
                    <asp:TextBox ID="LNameTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
                <div id="LNMlimit" class="textremaining"></div>
       
                <asp:RequiredFieldValidator ID="LNameTxtVal" runat="server" Display="None" ControlToValidate="LNameTxt" ErrorMessage="Enter the last name of the employee" ValidationGroup="General"></asp:RequiredFieldValidator>
                   
                <asp:CustomValidator id="LNameTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "LNameTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="KnownAs" class="labeldiv">Known As:</div>
                <div id="KnownAsField" class="fielddiv" style="width:250px;">
                    <asp:TextBox ID="KHASTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>

                <div id="KHNlimit" class="textremaining"></div>
       
                <asp:CustomValidator id="KHASTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "KHASTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DateofBirth" class="requiredlabel">Date of Birth:</div>
                <div id="DateofBirthField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="DOBTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>        
                
                <asp:RequiredFieldValidator ID="DOBVal" runat="server" Display="None" ControlToValidate="DOBTxt" ErrorMessage="Enter the date of birth of the employee" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:RegularExpressionValidator ID="DOBFVal" runat="server" ControlToValidate="DOBTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator> 

                <asp:CustomValidator id="DOBF2Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "DOBTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CountryBirth" class="requiredlabel">Country of Birth:</div>
                <div id="CountryBirthField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="CBCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="CB_LD" class="control-loader"></div> 

                <asp:RequiredFieldValidator ID="CBCBoxTxtVal" runat="server" Display="None" ControlToValidate="CBCBox" ErrorMessage="Select the country of birth of the employee"  ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:CompareValidator ID="CBCBoxVal" runat="server" ControlToValidate="CBCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select the country of birth of the employee" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="Gender" class="requiredlabel">Gender:</div>
                <div id="GenderField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="GDRCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                
                <div id="GNDR_LD" class="control-loader"></div> 
                    
                <asp:RequiredFieldValidator ID="GDRCBoxTxtVal" runat="server" Display="None" ControlToValidate="GDRCBox" ErrorMessage="Select the gender of the employee"  ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:CompareValidator ID="GDRCBoxVal" runat="server" ControlToValidate="GDRCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select the gender of the employee" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="MaritalStatus" class="requiredlabel">Marital Status:</div>
                <div id="MaritalStatusField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="MRTLCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="MRTL_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="MRTLCBoxTxtVal" runat="server" Display="None" ControlToValidate="MRTLCBox" ErrorMessage="Select the marital status of the employee"  ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:CompareValidator ID="MRTLCBoxVal" runat="server" ControlToValidate="MRTLCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select the marital status of the employee" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="Religion" class="requiredlabel">Religion:</div>
                <div id="ReligionField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="RELCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="REL_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="RELCBoxTxtVal" runat="server" Display="None" ControlToValidate="RELCBox" ErrorMessage="Select the religion of the employee"  ValidationGroup="General"></asp:RequiredFieldValidator>
                        
                <asp:CompareValidator ID="RELCBoxVal" runat="server" ControlToValidate="RELCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select the religion of the employee" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="EmailAddress" class="requiredlabel">Email Address:</div>
                <div id="EmailAddressField" class="fielddiv" style="width:250px;">
                    <asp:TextBox ID="EMLTxt" runat="server" Width="240px" CssClass="textbox"></asp:TextBox>
                </div> 
                <asp:RequiredFieldValidator ID="EMLVal" runat="server" Display="None" ControlToValidate="EMLTxt" ErrorMessage="Enter the email address of the employee" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                <asp:RegularExpressionValidator ID="EMLFVal" runat="server" ControlToValidate="EMLTxt"
                Display="None" ErrorMessage="Incorrect email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="General"></asp:RegularExpressionValidator> 
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DetailsLabel" class="labeldiv">Additional Details:</div>
                <div id="DetailsField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="DTLTxt" runat="server" CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="DTLTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "DTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>
        <div id="ContractTB" class="tabcontent" style="display:none; height:450px;">

            <div id="validation_dialog_contract" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary5" runat="server" CssClass="validator" ValidationGroup="Contract" />
            </div>
            
            <div id="ContractGroupHeader" class="groupboxheader">Contract Details</div>
            <div id="ContractGroupField" class="groupbox" style="height:300px;">
                
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="ContractIDLebel" class="requiredlabel">Contract No:</div>
                    <div id="ContractIDField" class="fielddiv" style="width:150px;">
                        <asp:TextBox ID="CTRCTIDTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                    </div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ContractTypeLabel" class="requiredlabel">Contract Group:</div>
                    <div id="ContractTypeField" class="fielddiv" style="width:150px">
                        <asp:DropDownList ID="CTRTGRPCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                        </asp:DropDownList> 
                    </div>
                    <div id="CTRCTGRP_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="CTRTGRPCBoxTxtVal" runat="server" Display="None" ControlToValidate="CTRTGRPCBox" ErrorMessage="Select the contract group"  ValidationGroup="Contract"></asp:RequiredFieldValidator>
                        
                    <asp:CompareValidator ID="CTRTGRPCBoxVal" runat="server" ControlToValidate="CTRTGRPCBox" ValidationGroup="Contract"
                    Display="None" ErrorMessage="Select the contract group" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0"></asp:CompareValidator>
                    
                    <div id="GroupDurationLabel" class="labeldiv">Contract Duration:</div>
                    <div id="GroupDurationField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="CTRDURTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="50px"></asp:TextBox>
                        <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                        <asp:TextBox ID="CTRPRDTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="70px"></asp:TextBox>
                    </div> 
                    
                  
                </div>
                
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
                    <div id="StartDateField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="CTRDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>

                     <asp:RequiredFieldValidator ID="CTRDTxtVal" runat="server" Display="None" ControlToValidate="CTRDTTxt" ErrorMessage="Enter the start date of the contract" ValidationGroup="Contract"></asp:RequiredFieldValidator>       
                     <asp:RegularExpressionValidator ID="CTRDFVal" runat="server" ControlToValidate="CTRDTTxt"
                     Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Contract"></asp:RegularExpressionValidator> 

                     <asp:CustomValidator id="CTRDTTxtF2Val" runat="server" ValidationGroup="Contract" 
                     ControlToValidate = "CTRDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                     ClientValidationFunction="validateDate">
                     </asp:CustomValidator>

                    <div id="EndDateLabel" class="requiredlabel">Expiry Date:</div>
                    <div id="EndDateField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="CTREDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>             
                    

                    <asp:RequiredFieldValidator ID="CTREDTVal" runat="server" Display="None" ControlToValidate="CTREDTTxt" ErrorMessage="Enter the expiry date of the contract"  ValidationGroup="Contract"></asp:RequiredFieldValidator>       

                    <asp:RegularExpressionValidator ID="CTREDFVal" runat="server" ControlToValidate="CTREDTTxt"
                    Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Contract"></asp:RegularExpressionValidator> 

                   <%-- <asp:CompareValidator ID="CTEDTF2Val" runat="server" ControlToValidate="CTREDTTxt" ControlToCompare="CTRDTTxt"  ValidationGroup="Contract"
                     ErrorMessage="Contract expiry date should be greater or equals the start date of the contract"
                    Operator="GreaterThanEqual" Type="Date"
                    Display="None"></asp:CompareValidator>--%>

                    <asp:CustomValidator id="CTREDTTxtF3Val" runat="server" ValidationGroup="Contract" 
                    ControlToValidate = "CTREDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                    ClientValidationFunction="validateDate">
                    </asp:CustomValidator>
                </div>
                
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ExtendedUntilLabel" class="labeldiv">Extended Until:</div>
                    <div id="ExtendedUntilField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="EXTDTTxt" runat="server" CssClass="readonlydate" ReadOnly="true" Width="140px"></asp:TextBox>
                    </div>
                    
                    <div id="TerminationDateLabel" class="labeldiv">Termination Date:</div>
                    <div id="terminationDateField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="TRMDTTxt" runat="server" CssClass="readonlydate" ReadOnly="true" Width="140px"></asp:TextBox>
                    </div>
                </div>  
                
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="EmploymentLabel" class="requiredlabel">Employment Mode:</div>
                    <div id="EmploymentField" class="fielddiv" style="width:150px">
                        <asp:DropDownList ID="CTYPCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="EMPLY_LD" class="control-loader"></div>
                   
                    <div id="ContractStatusLabel" class="labeldiv">Contract Status:</div>
                    <div id="ContractStatusField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="CONTSTSTxt" runat="server" CssClass="readonlydate" ReadOnly="true" Width="140px"></asp:TextBox>
                    </div>
                         
                    <asp:RequiredFieldValidator ID="CTYPCBoxTxtVal" runat="server" Display="None" ControlToValidate="CTYPCBox" ErrorMessage="Select employment mode"  ValidationGroup="Contract"></asp:RequiredFieldValidator>
                        
                    <asp:CompareValidator ID="CTYPCBoxVal" runat="server" ControlToValidate="CTYPCBox" ValidationGroup="Contract"
                    Display="None" ErrorMessage="Select employment mode" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0"></asp:CompareValidator>
                 </div>

                 <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="TerminationReasonLabel" class="labeldiv">Reason for Termination:</div>
                    <div id="TerminationReasonField" class="fielddiv" style="width:470px;">
                        <asp:TextBox ID="TRMRSNTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="460px" Height="70px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                 </div>

                 <div style="float:left; width:100%; height:20px; margin-top:70px;">
                    <div id="RemarksLabel" class="labeldiv">System Notes:</div>
                    <div id="RemarksField" class="fielddiv" style="width:470px">
                        <asp:TextBox ID="NOTETxt" runat="server" CssClass="readonlydate" ReadOnly="true" Width="460px"></asp:TextBox>
                    </div>
                 </div>
                
            </div>
            
            <div id="ORGManagementLabel" class="groupboxheader">Organization Assignment</div>
            <div id="ORGManagementField" class="groupbox" style="height:100px;">
               
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="POSLabel" class="requiredlabel">Assigned Position:</div>
                    <div id="POSField" class="fielddiv" style="width:300px">
                        <asp:DropDownList ID="POSCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="POS_LD" class="control-loader"></div>

                    <span id="UNTSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
                        
                    <asp:RequiredFieldValidator ID="POSCBoxTxtVal" runat="server" Display="None" ControlToValidate="POSCBox" ErrorMessage="Select the assigned position"  ValidationGroup="Contract"></asp:RequiredFieldValidator>
                        
                    <asp:CompareValidator ID="POSCBoxVal" runat="server" ControlToValidate="POSCBox" ValidationGroup="Contract"
                    Display="None" ErrorMessage="Select the assigned position" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0"></asp:CompareValidator>
                </div>                 
                     
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="DOALabel" class="requiredlabel">Date of Assignment:</div>
                    <div id="DOAField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="DOATxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>       
                    
                    <asp:RequiredFieldValidator ID="DOATxtVal" runat="server" Display="None" ControlToValidate="DOATxt" ErrorMessage="Enter the date of assignment" ValidationGroup="Contract"></asp:RequiredFieldValidator>       
                        
                    <asp:RegularExpressionValidator ID="DOAFVal" runat="server" ControlToValidate="DOATxt"
                    Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Contract"></asp:RegularExpressionValidator>
                        
                   <%-- <asp:CompareValidator ID="DOAF1Val" runat="server" ControlToValidate="DOATxt" ControlToCompare="CTRDTTxt"  ValidationGroup="Contract"
                     ErrorMessage="Date of assignment should be greater or equals the start date of the contract"
                    Operator="GreaterThanEqual" Type="Date"
                    Display="None"></asp:CompareValidator>--%>
                         
                    <asp:CustomValidator id="DOAF2Val" runat="server" ValidationGroup="Contract" 
                    ControlToValidate = "DOATxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                    ClientValidationFunction="validateDate">
                    </asp:CustomValidator>     
                 </div>
            </div>    
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
        
        <div id="SelectORG" class="selectbox">
            <div id="closeORG" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList> 
                </div>
                <div id="UNT_LD" class="control-loader"></div>
            </div>
        </div>
    </asp:Panel>

</div>
<script type="text/javascript" language="javascript">
        $(function ()
        {
            var empty = $("#<%=gvEmployees.ClientID%> tr:last-child").clone(true);
       
            loadEmployees(empty);

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#<%=ORGUNTCBox.ClientID%>").change(function () {
                var loadcontrols = new Array();
                loadcontrols.push('#<%=POSCBox.ClientID%>');

                loadParamComboboxAjax('getRelatedDepPositions', loadcontrols, "'unit':'" + $(this).val() + "'", "#POS_LD");

                $("#SelectORG").hide('800');
            });

            /*close organization unit box*/
            $("#closeORG").bind('click', function () {
                $("#SelectORG").hide('800');
            });

            $("#<%=UNTSelect.ClientID%>").bind('click', function (e)
            {
                showORGDialog(e.pageX, e.pageY);
            });

            $("#<%=CTREDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=DOBTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=DOATxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=CTRDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    validateContractGroup($("#<%=CTRTGRPCBox.ClientID%>").val());
                }
            });

            $("#<%=CTRTGRPCBox.ClientID%>").change(function () {
                validateContractGroup($(this).val());
            });

            $("#<%=CTRDTTxt.ClientID%>").keyup(function () {
                validateContractGroup($("#<%=CTRTGRPCBox.ClientID%>").val());
            });

            $("#refresh").bind('click', function () {
                hideAll();
                loadEmployees(empty);
            });

            $("#deletefilter").bind('click', function () {
                hideAll();
                loadEmployees(empty);
            });

            $("#byFirst").bind('click', function ()
            {
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

            $("#profileimg").bind('click', function ()
            {
                $('input[type=file]').trigger('click');
            });

            $("#fileupload").fileupload(
            {
                dataType: 'json',
                url: '/Upload.ashx',
                progress: function (e, data)
                {
                    $("#uploadmessage").show();
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $("#uploadmessage").html("Uploading(" + progress + "%)");
                },
                done: function (e, data)
                {
                    $("#uploadmessage").hide("2000");

                    $("#filename").val(data.result.name.replace(/\\/g, '/'));
                },
                fail: function (e, err)
                {
                    $("#uploadmessage").hide("2000");

                    alert(err.errorThrown);
                }
            });

            $("#save").bind('click', function ()
            {
                var isEmployeeValid = Page_ClientValidate('General');
                if (isEmployeeValid)
                {
                    if (!$("#validation_dialog_general").is(":hidden")) {
                        $("#validation_dialog_general").hide();
                    }

                    var isContractValid = Page_ClientValidate('Contract');
                    if (isContractValid)
                    {
                        if (!$("#validation_dialog_contract").is(":hidden")) {
                            $("#validation_dialog_contract").hide();
                        }

                        var result = confirm("Are you sure you would like to submit changes?");
                        if (result == true)
                        {
                            $("#ProfileTooltip").hide();

                            $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                            {
                                ActivateSave(false);

                                var dob = getDatePart($("#<%=DOBTxt.ClientID%>").val());
                                var sd = getDatePart($("#<%=CTRDTTxt.ClientID%>").val());
                                var ed = getDatePart($("#<%=CTREDTTxt.ClientID%>").val());
                                var doa = getDatePart($("#<%=DOATxt.ClientID%>").val());

                                var employee =
                                {
                                    PersonnelID: $("#<%=PERSIDTxt.ClientID%>").val(),
                                    Title: $("#<%=TitleCBox.ClientID%>").val(),
                                    FirstName: $("#<%=FNameTxt.ClientID%>").val(),
                                    MiddleName: $("#<%=MNameTxt.ClientID%>").val(),
                                    LastName: $("#<%=LNameTxt.ClientID%>").val(),
                                    KnownAs: $("#<%=KHASTxt.ClientID%>").val(),
                                    DOB: new Date(dob[2], (dob[1] - 1), dob[0]),
                                    COB: $("#<%=CBCBox.ClientID%>").find('option:selected').text(),
                                    Religion: $("#<%=RELCBox.ClientID%>").find('option:selected').text(),
                                    Gender: $("#<%=GDRCBox.ClientID%>").find('option:selected').text(),
                                    MaritalStatus: $("#<%=MRTLCBox.ClientID%>").find('option:selected').text(),
                                    EmailAddress: $("#<%=EMLTxt.ClientID%>").val(),
                                    Remarks: $("#<%=DTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DTLTxt.ClientID%>").val()),
                                    EMPImg:$("#filename").val(),
                                    Contracts:
                                    [
                                        {
                                            ContractNo: $("#<%=CTRCTIDTxt.ClientID%>").val(),
                                            StartDate: new Date(sd[2], (sd[1] - 1), sd[0]),
                                            EndDate: new Date(ed[2], (ed[1] - 1), ed[0]),
                                            Group: $("#<%=CTRTGRPCBox.ClientID%>").find('option:selected').text(),
                                            Type: $("#<%=CTYPCBox.ClientID%>").find('option:selected').text(),
                                            Assignement:
                                            [
                                                {
                                                    Position: $("#<%=POSCBox.ClientID%>").find('option:selected').text(),
                                                    DOA: new Date(doa[2], (doa[1] - 1), doa[0])
                                                }
                                            ]
                                        }
                                    ],
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(employee) + "\'}",
                                    url: getServiceURL().concat('updateEmployee'),
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
                            });
                        }
                    }
                    else
                    {
                        $("#validation_dialog_contract").stop(true).hide().fadeIn(500, function () {

                            alert("Please make sure that all warnings highlighted in red color are fulfilled");
                            navigate('Contract');
                        });
                    }
                }
                else
                {
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                        navigate('Details');
                    });
                }
            });

            /*filter by first name*/
            $("#<%=FNMTxt.ClientID%>").keyup(function () {
                filterEmployeesByFirstName($(this).val(), empty);
            });

            /*filter by last name*/
            $("#<%=LNMTxt.ClientID%>").keyup(function () {
                filterEmployeesByLastName($(this).val(), empty);
            });

            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
                }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $("#<%=RELFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0)
                {
                    filterEmployeesByReligion($(this).val(), empty);
                }
            });

            $("#<%=GNDRFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByGender($(this).val(), empty);
                }
            });

            $("#<%=MRTLSTSFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByMaritalStatus($(this).val(), empty);
                }
            });

            $("#<%=ORGUNTFCBox.ClientID%>").change(function () {

                if ($(this).val() != 0)
                {
                    filterEmployeesByOrganization($(this).val(), empty);
                }
            });

            $("#tabul li").bind("click", function () {
                navigate($(this).attr("id"));
            });

        });
        function showORGDialog(x, y)
        {
            $("#SelectORG").css({ left: x - 40, top: y - 90 });
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>","#UNT_LD");
            $("#SelectORG").show();
        }
        function setExpiryDate(date, duration, period)
        {
            var sd = getDatePart(date);

            var startDate = new Date(sd[2], (sd[1] - 1), sd[0]);

            switch (period) {
                case "Years":
                    $("#<%=CTREDTTxt.ClientID%>").val(startDate.addYears(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
                case "Months":
                    $("#<%=CTREDTTxt.ClientID%>").val(startDate.addMonths(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
                case "Days":
                    $("#<%=CTREDTTxt.ClientID%>").val(startDate.addDays(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
            }
        }

        function validateContractGroup(name) {
            $("#<%=CTRDURTxt.ClientID%>").val('');
            $("#<%=CTRPRDTxt.ClientID%>").val('');

            if (name == 0 || name == null) {
                alert("Please select contract group");

                /*clear the contract start date field if there is a value*/
                $("#<%=CTRDTTxt.ClientID%>").val('');
            }
            else {
                $.ajax(
               {
                   type: "POST",
                   contentType: "application/json",
                   dataType: "json",
                   data: "{'name':'" + name + "'}",
                   url: getServiceURL().concat('getContractGroup'),
                   success: function (data) {
                       if (data) {
                           var xmlGroup = $.parseXML(data.d);

                           var group = $(xmlGroup).find('ContractGroup');

                           if (group.attr('IsConstraint') == "true") {
                               if ($("#<%=CTRDTTxt.ClientID%>").val() != '') {
                                   setExpiryDate($("#<%=CTRDTTxt.ClientID%>").val(), parseInt(group.attr('Duration')), group.attr('Period'));

                                   /*update the position's date of assignment to the contract date*/
                                   $("#<%=DOATxt.ClientID%>").val($("#<%=CTRDTTxt.ClientID%>").val());
                               }

                               /* setup the duration and the period values*/
                               $("#<%=CTRDURTxt.ClientID%>").val(group.attr('Duration'));
                               $("#<%=CTRPRDTxt.ClientID%>").val(group.attr('Period'));
                           }
                           else {
                               /* set unlimited date, which is 31/12/9999*/
                               var expirydate = new Date();
                               expirydate.setFullYear(9999, 11, 31);

                               $("#<%=CTREDTTxt.ClientID%>").val(expirydate.format("dd/MM/yyyy"));

                               if ($("#<%=CTRDTTxt.ClientID%>").val() != '') {
                                   /*update the position's date of assignment to the contract date*/
                                   $("#<%=DOATxt.ClientID%>").val($("#<%=CTRDTTxt.ClientID%>").val());
                               }

                           }
                       }
                   },
                   error: function (xhr, status, error) {
                       var r = jQuery.parseJSON(xhr.responseText);
                       showErrorNotification(r.Message)
                   }
               });
            }
        }
        function filterByDateRange(start, end, empty)
        {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true)
            {
                $("#EMPwait").stop(true).hide().fadeIn(500, function () {

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
                        success: function (data)
                        {
                            $("#EMPwait").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                                {
                                    $(this).find('p').text("List of all current employees filtered by date of birth range.");

                                });

                                if (data) {
                                    loadGridView(data.d, empty);
                                }
                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#EMPwait").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                $("#FilterTooltip").fadeOut(800, function () {
                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message)
                                });
                            });
                        }
                    });
                });
            }
        }

        function filterEmployeesByOrganization(unit, empty)
        {
            $("#EMPwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'unit':'" + unit + "'}",

                    url: getServiceURL().concat('filterEmployeesByOrganization'),
                    success: function (data) {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current employees filtered by organization unit.");
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {

                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });
                        });
                    }
                });
            });
        }
        function filterEmployeesByMaritalStatus(status, empty) {
            $("#EMPwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",

                    url: getServiceURL().concat('filterEmployeesByMaritalStatus'),
                    success: function (data)
                    {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                            {
                                $(this).find('p').text("List of all current employees filtered by marital status.");
                            });

                            if (data)
                            {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {

                        $("#EMPwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });
                        });
                    }
                });
            });
        }
        function filterEmployeesByGender(gender, empty) {
            $("#EMPwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'gender':'" + gender + "'}",

                    url: getServiceURL().concat('filterEmployeesByGender'),
                    success: function (data) {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                            {
                                $(this).find('p').text("List of all current employees filtered by gender.");
                            });

                            if (data)
                            {
                                loadGridView(data.d, empty);
                            }

                        });
                    },
                    error: function (xhr, status, error) {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });
                        });
                    }
                });
            });
        }
        function filterEmployeesByReligion(religion, empty) {
            $("#EMPwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'religion':'" + religion + "'}",

                    url: getServiceURL().concat('filterEmployeesByReligion'),
                    success: function (data)
                    {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                            {
                                $(this).find('p').text("List of all current employees filtered by religion.");
                            });

                            if (data)
                            {
                                loadGridView(data.d, empty);
                            }
                        });
                       
                    },
                    error: function (xhr, status, error) {

                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });
                        });
                    }
                });
            });
        }
        function filterEmployeesByLastName(last, empty) {
            $("#EMPwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'last':'" + last + "'}",

                    url: getServiceURL().concat('filterEmployeesByLastName'),
                    success: function (data) {
                        $("#EMPwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(this).find('p').text("List of all current employees filtered by last name.");
                            });
                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#EMPwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });
                        });
                    }
                });
            });
        }
        function filterEmployeesByFirstName(first,empty) {
            $("#EMPwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'first':'" + first + "'}",
                    url: getServiceURL().concat('filterEmployeesByFirstName'),
                    success: function (data)
                    {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(this).find('p').text("List of all current employees filtered by first name.");
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });
                        });
                    }
                });
            });
        }
        function loadEmployees(empty) {
            $("#EMPwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat('getEmployees'),
                    success: function (data)
                    {
                        $("#EMPwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current employees to date.");
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                        
                    },
                    error: function (xhr, status, error)
                    {
                        $("#EMPwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message)
                            });
                        });
                    }
                });
            });
        }
        function loadGridView(data, empty)
        {
            var xml = $.parseXML(data);

            var row = empty;

            $("#<%=gvEmployees.ClientID%> tr").not($("#<%=gvEmployees.ClientID%> tr:first-child")).remove();

            $(xml).find("Employee").each(function (index, employee) {
                /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                var date = new Date();

                $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html("<img id='icon_" + index + "' src='/ImageHandler.ashx?query=select ProfileImg from HumanResources.Employee where EmployeeID=" + $(this).attr('EmployeeID') + "&width=70&height=40&date=" + date.getSeconds() + "' />");

                $("td", row).eq(3).html($(this).attr("PersonnelID"));
                $("td", row).eq(4).html($(this).attr("CompleteName"));
                $("td", row).eq(5).html($(this).attr("KnownAs"));

                var dateofbirth = new Date($(this).attr("DOB"));
                dateofbirth.setMinutes(dateofbirth.getMinutes() + dateofbirth.getTimezoneOffset());

                $("td", row).eq(6).html(dateofbirth.format("dd/MM/yyyy"));
                $("td", row).eq(7).html($(this).attr("COB"));
                $("td", row).eq(8).html($(this).attr("Gender"));
                $("td", row).eq(9).html($(this).attr("Religion"));
                $("td", row).eq(10).html($(this).attr("MaritalStatus"));
                $("td", row).eq(11).html($(this).attr("EmailAddress"));

                $("#<%=gvEmployees.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            $("#validation_dialog_general").hide();
                            $("#validation_dialog_contract").hide();

                            /*clear previously uploaded images*/
                            $("#filename").val('');

                            /*bind employee data*/
                            $("#<%=PERSIDTxt.ClientID%>").val($(employee).attr("PersonnelID"));

                            $("#ProfileTooltip").stop(true).hide().fadeIn(800, function ()
                            {
                                $(this).slideDown(800, 'easeOutBounce');

                                $(this).find('p').text("To add or edit the profile image, please click on the image box on the right");

                                $('#profileimg').attr("src", "/ImageHandler.ashx?query=select ProfileImg from HumanResources.Employee where EmployeeID=" + $(employee).attr('EmployeeID') + "&width=150&height=150&date=" + date.getSeconds());

                            });
                           
                            
                            bindComboboxAjax('loadTitles', '#<%=TitleCBox.ClientID%>', $(employee).attr("Title"), "#TTL_LD");

                            $("#<%=FNameTxt.ClientID%>").val($(employee).attr("FirstName"));
                            $("#<%=MNameTxt.ClientID%>").val($(employee).attr("MiddleName"));
                            $("#<%=LNameTxt.ClientID%>").val($(employee).attr("LastName"));
                            $("#<%=KHASTxt.ClientID%>").val($(employee).attr("KnownAs"));
                            $("#<%=DOBTxt.ClientID%>").val(dateofbirth.format("dd/MM/yyyy"));

                            bindComboboxAjax('loadCountries', '#<%=CBCBox.ClientID%>', $(employee).attr("COB"),"#CB_LD");
                            bindComboboxAjax('loadGenders', '#<%=GDRCBox.ClientID%>', $(employee).attr("Gender"),"#GNDR_LD");
                            bindComboboxAjax('loadReligions', '#<%=RELCBox.ClientID%>', $(employee).attr("Religion"), "#REL_LD");
                            bindComboboxAjax('loadMaritalStatus', '#<%=MRTLCBox.ClientID%>', $(employee).attr("MaritalStatus"),"#MRTL_LD");

                            $("#<%=EMLTxt.ClientID%>").val($(employee).attr("EmailAddress"));

                            /*bind employee additional details*/
                            if ($(employee).attr("Remarks") == '') {

                                addWaterMarkText('Additional details in the support of the employee record', '#<%=DTLTxt.ClientID%>');
                            }
                            else {
                                if ($("#<%=DTLTxt.ClientID%>").hasClass("watermarktext")) {
                                    $("#<%=DTLTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=DTLTxt.ClientID%>").html($(employee).attr("Remarks")).text();
                            }

                            /*bind contract details*/
                            var xmlContract = $.parseXML($(employee).attr('XMLContract'));
                            var contract = $(xmlContract).find('Contract').last();

                            $("#<%=CTRCTIDTxt.ClientID%>").val(contract.attr("ContractNo"));

                            bindContractGroup("#<%=CTRTGRPCBox.ClientID%>", contract.attr("Group"),"#CTRCTGRP_LD");


                            var startdate = new Date(contract.attr("StartDate"));
                            startdate.setMinutes(startdate.getMinutes() + startdate.getTimezoneOffset());

                            $("#<%=CTRDTTxt.ClientID%>").val(startdate.format("dd/MM/yyyy"));

                            var enddate = new Date(contract.attr("EndDate"));
                            enddate.setMinutes(enddate.getMinutes() + enddate.getTimezoneOffset());

                            $("#<%=CTREDTTxt.ClientID%>").val(enddate.format("dd/MM/yyyy"));

                            var extendedtodate = new Date(contract.find("ExtendedToDate").text());
                            extendedtodate.setMinutes(extendedtodate.getMinutes() + extendedtodate.getTimezoneOffset());

                            $("#<%=EXTDTTxt.ClientID%>").val(contract.find("ExtendedToDate").text() == '' ? '' : extendedtodate.format("dd/MM/yyyy"));

                            var terminationdate = new Date(contract.find("TerminationDate").text());
                            terminationdate.setMinutes(terminationdate.getMinutes() + terminationdate.getTimezoneOffset());

                            $("#<%=TRMDTTxt.ClientID%>").val(contract.find("TerminationDate").text() == '' ? '' : terminationdate.format("dd/MM/yyyy"));

                            bindComboboxAjax('loadContractType', '#<%=CTYPCBox.ClientID%>', contract.attr("Type"),"#EMPLY_LD");

                            $("#<%=CONTSTSTxt.ClientID%>").val(contract.attr("CStatusStr"));

                            $("#<%=NOTETxt.ClientID%>").html(contract.attr("Remarks")).text();
                            $("#<%=TRMRSNTxt.ClientID%>").html(contract.attr("TermenationReason")).text();

                            /*bind organizational assignement details*/
                            var xmlAssignement = $.parseXML(contract.attr('XMLAssignement'));
                            var assignement = $(xmlAssignement).find('ContractAssignement').last();


                            bindPosition("#<%=POSCBox.ClientID%>", assignement.attr("Position"), "#POS_LD");

                            var dateofassignment = new Date(assignement.attr("DOA"));
                            dateofassignment.setMinutes(dateofassignment.getMinutes() + dateofassignment.getTimezoneOffset());

                            $("#<%=DOATxt.ClientID%>").val(dateofassignment.format("dd/MM/yyyy"));

                            navigate('Details');

                            /*trigger modal popup extender*/
                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                    else if ($(this).attr('id').search('delete') != -1) {
                        $(this).bind('click', function () {
                            removeEmployee($(employee).attr('EmployeeID'));
                        });
                    }
                });
                row = $("#<%=gvEmployees.ClientID%> tr:last-child").clone(true);
            });
        }
        function removeEmployee(employeeID) {
            var result = confirm("Are you sure you would like to remove the selected employee record?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'employeeID':'" + employeeID + "'}",
                    url: getServiceURL().concat('removeEmployee'),
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

        function bindContractGroup(control, value,loader)
        {
            $(loader).stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadContractGroup"),
                    success: function (data)
                    {
                        $(loader).fadeOut(500, function () {
                            if (data) {
                                bindComboboxXML($.parseXML(data.d), 'ContractGroup', 'GroupName', value, $(control));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $(loader).fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });
                    }
                });
            });
        }

        function bindPosition(control, value, loader)
        {
            $(loader).stop(true).hide().fadeIn(500, function () {

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadPositions"),
                    success: function (data)
                    {
                        $(loader).fadeOut(500, function () {

                            if (data) {
                                bindComboboxXML($.parseXML(data.d), 'Position', 'Title', value, $(control));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $(loader).fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message)
                        });
                    }
                });
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

        function showSuccessNotification(message) {
            $().toastmessage('showSuccessToast', message);
        }

        function showErrorNotification(message) {
            $().toastmessage('showErrorToast', message);
        }
    </script>
</asp:Content>
