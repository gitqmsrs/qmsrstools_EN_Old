<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateEmployee.aspx.cs" Inherits="QMSRSTools.EmployeeManagement.CreateEmployee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="EMP_Header" class="moduleheader">Create New Employee</div>
    
    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt=""/> 
    </div>

    <div id="validation_dialog_general" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
    </div>

    <div id="validation_dialog_passport" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Passport" />
    </div>
    
    <div id="validation_dialog_residence" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="Residence" />
    </div>
        
    <div id="validation_dialog_address" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary4" runat="server" CssClass="validator" ValidationGroup="Address" />
    </div>

    <div id="validation_dialog_contract" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary5" runat="server" CssClass="validator" ValidationGroup="Contract" />
    </div>

    <div id="slider">
        <ul class="navigation">
            <li><a href="#Details">Details</a></li>
            <li><a href="#Nationalities">Nationality & Residence Permit</a></li>
            <li><a href="#Address">Address & Contact Details</a></li>
            <li><a href="#Contract">Organizational Assignement</a></li>
        </ul>
        <div class="scroll">
            <div class="scrollContainer">
                <div class="panel" id="Details">
                    <h2>Personal Details</h2>

                    <div style="float:left; width:100%; height:20px; margin-top:10px;">
                        <div id="PersonnelID" class="requiredlabel">Personnel ID:</div>
                        <div id="PersonnelIDField" class="fielddiv" style="width:auto;">
                            <asp:TextBox ID="PERSIDTxt" runat="server" CssClass="textbox"></asp:TextBox>
                            <asp:Label ID="PERSIDLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
                        </div>
                    
                        <div id="IDlimit" class="textremaining"></div>
                 
                        <asp:RequiredFieldValidator ID="PERSIDTxtVal" runat="server" Display="None" ControlToValidate="PERSIDTxt" ErrorMessage="Enter the personnel ID of the employee" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                        <asp:CustomValidator id="PERSIDTxtFVal" runat="server" ValidationGroup="General" 
                        ControlToValidate = "PERSIDTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
                        ClientValidationFunction="validateIDField">
                        </asp:CustomValidator> 
                                        
                    </div>
                 
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
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
                        <div id="FistNameField" class="fielddiv" style="width:250px;">
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
                        <div id="LastName" class="requiredlabel">Last Name:</div>
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
                        <div id="EMLlimit" class="textremaining"></div>
       
                        <asp:RequiredFieldValidator ID="EMLVal" runat="server" Display="None" ControlToValidate="EMLTxt" ErrorMessage="Enter the email address of the employee" ValidationGroup="General"></asp:RequiredFieldValidator>
                    
                        <asp:RegularExpressionValidator ID="EMLFVal" runat="server" ControlToValidate="EMLTxt"
                        Display="None" ErrorMessage="Incorrect email format" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="General"></asp:RegularExpressionValidator> 
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="DetailsLabel" class="labeldiv">Additional Details:</div>
                        <div id="DetailsField" class="fielddiv" style="width:400px; height:123px;">
                            <asp:TextBox ID="DTLTxt" runat="server" CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                        </div>

                        <asp:CustomValidator id="DTLTxtVal" runat="server" ValidationGroup="General" 
                        ControlToValidate = "DTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                        ClientValidationFunction="validateSpecialCharactersLongText">
                        </asp:CustomValidator>
                    </div>
                </div>
            <div class="panel" id="Nationalities">
                <h2>Nationality & Residence Info</h2>
                
                <div id="NationalityGroupHeader" class="groupboxheader">Nationality Details</div>
                <div id="NationalityGroupField" class="groupbox" style="height:220px;">


                    <div style="float:left; width:100%; height:20px; margin-top:10px;">
                        <div id="PassportNoLabel" class="requiredlabel">Passport No:</div>
                        <div id="PassportNoField" class="fielddiv">
                            <asp:TextBox ID="PASSNOTxt" runat="server" CssClass="textbox"></asp:TextBox>
                        </div>
                        <div id="PASSNOlimit" class="textremaining"></div>
       
                        <asp:RequiredFieldValidator ID="PASSNOTxtVal" runat="server" Display="None" ControlToValidate="PASSNOTxt" ErrorMessage="Enter the passport number" ValidationGroup="Passport"></asp:RequiredFieldValidator>
                 
                        <asp:CustomValidator id="PASSNOTxtFVal" runat="server" ValidationGroup="Passport" 
                        ControlToValidate = "PASSNOTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                        ClientValidationFunction="validateSpecialCharacters">
                        </asp:CustomValidator>
                    </div>
                    
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="DateOfIssueLabel" class="requiredlabel">Date of Issue:</div>
                        <div id="DateOfIssueField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="DOISSTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                        </div>        
                        <asp:RequiredFieldValidator ID="DOISSTxtVal" runat="server" Display="None" ControlToValidate="DOISSTxt" ErrorMessage="Enter the date of issue of the passport" ValidationGroup="Passport"></asp:RequiredFieldValidator>
                 
                        <asp:RegularExpressionValidator ID="DOISSTxtFVal" runat="server" ControlToValidate="DOISSTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Passport"></asp:RegularExpressionValidator> 

                        <asp:CustomValidator id="DOISSTxtF2Val" runat="server" ValidationGroup="General" 
                        ControlToValidate = "DOISSTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                        </asp:CustomValidator>
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="ExpiryDateLabel" class="requiredlabel">Expiry Date:</div>
                        <div id="ExpiryDateField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="EXPDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                        </div>        
                        <asp:RequiredFieldValidator ID="EXPDTTxtVal" runat="server" Display="None" ControlToValidate="EXPDTTxt" ErrorMessage="Enter the expiry date of the passport" ValidationGroup="Passport"></asp:RequiredFieldValidator>
                 
                        <asp:RegularExpressionValidator ID="EXPDTTxtFVal" runat="server" ControlToValidate="EXPDTTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Passport"></asp:RegularExpressionValidator> 

                        <asp:CompareValidator ID="EXPDTTxtF2Val" runat="server" ControlToCompare="DOISSTxt"  ValidationGroup="Passport"
                        ControlToValidate="EXPDTTxt" ErrorMessage="Expiry date of the passport should be greater than the issuing date"
                        Operator="GreaterThan" Type="Date"
                        Display="None"></asp:CompareValidator>
                        
                        <asp:CustomValidator id="EXPDTTxtF3Val" runat="server" ValidationGroup="Passport" 
                        ControlToValidate = "EXPDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                        </asp:CustomValidator>  
                    </div>
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="IssuingAuthorityLabel" class="requiredlabel">Issuing Authority:</div>
                        <div id="IssuingAuthorityField" class="fielddiv" style="width:150px">
                            <asp:DropDownList ID="ISSAUTHCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="ISSAUTH_LD" class="control-loader"></div>

                        <asp:RequiredFieldValidator ID="ISSAUTHCBoxTxtVal" runat="server" Display="None" ControlToValidate="ISSAUTHCBox" ErrorMessage="Select the issuing authority"  ValidationGroup="Passport"></asp:RequiredFieldValidator>
                    
                        <asp:CompareValidator ID="ISSAUTHCFVal" runat="server" ControlToValidate="ISSAUTHCBox" ValidationGroup="Passport"
                        Display="None" ErrorMessage="Select the issuing authority" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
             
                    </div>

                </div>
                 
                <div id="ResidenceGroupHeader" class="groupboxheader">Residence Info</div>
                <div id="ResidenceGroupField" class="groupbox" style="height:220px;">

                    <div style="float:left; width:100%; height:20px; margin-top:10px;">
                        <div id="DocumentNoLabel" class="requiredlabel">Document No:</div>
                        <div id="DocumentNoField" class="fielddiv">
                            <asp:TextBox ID="DOCNOTxt" runat="server" CssClass="textbox"></asp:TextBox>
                        </div>
                        <div id="DOCNOlimit" class="textremaining"></div>
       
                        <asp:RequiredFieldValidator ID="DOCNOTxtVal" runat="server" Display="None" ControlToValidate="DOCNOTxt" ErrorMessage="Enter the residence permit document number" ValidationGroup="Residence"></asp:RequiredFieldValidator>
                 
                        <asp:CustomValidator id="DOCNOTxtF1Val" runat="server" ValidationGroup="Residence" 
                        ControlToValidate = "DOCNOTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                        ClientValidationFunction="validateSpecialCharacters">
                        </asp:CustomValidator>
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="ValidFromLabel" class="requiredlabel">Valid From:</div>
                        <div id="ValidFromField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="VLDFRMTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                        </div>        
                        <asp:RequiredFieldValidator ID="VLDFRMFVal" runat="server" Display="None" ControlToValidate="VLDFRMTxt" ErrorMessage="Enter the valid from date of the document" ValidationGroup="Residence"></asp:RequiredFieldValidator>
                
                        <asp:RegularExpressionValidator ID="VLDFRMF1Val" runat="server" ControlToValidate="VLDFRMTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Residence"></asp:RegularExpressionValidator> 
                   
                        <asp:CustomValidator id="VLDFRMTxtF2Val" runat="server" ValidationGroup="Residence" 
                        ControlToValidate = "VLDFRMTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                        </asp:CustomValidator>
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="ValidToLabel" class="requiredlabel">Valid To:</div>
                        <div id="ValidToField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="VLDTOTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                        </div>        
                        <asp:RequiredFieldValidator ID="VLDTOVal" runat="server" Display="None" ControlToValidate="VLDTOTxt" ErrorMessage="Enter the valid to date of the document" ValidationGroup="Residence"></asp:RequiredFieldValidator>
                
                        <asp:RegularExpressionValidator ID="VLDTOFVal" runat="server" ControlToValidate="VLDTOTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Residence"></asp:RegularExpressionValidator> 

                        <asp:CompareValidator ID="VLDTOTxtF1Val" runat="server" ControlToCompare="VLDFRMTxt"  ValidationGroup="Residence"
                        ControlToValidate="VLDTOTxt" ErrorMessage="The valid to date should be greater than the valid from date"
                        Operator="GreaterThan" Type="Date"
                        Display="None"></asp:CompareValidator>
                        
                        <asp:CustomValidator id="VLDTOTxtF2Val" runat="server" ValidationGroup="Residence" 
                        ControlToValidate = "VLDTOTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                        </asp:CustomValidator>  
                    </div>
                    
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="ResidenceTypeLabel" class="requiredlabel">Residence Type:</div>
                        <div id="ResidenceTypeField" class="fielddiv" style="width:150px">
                            <asp:DropDownList ID="RESTYPCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="RESTYP_LD" class="control-loader"></div>

                        <asp:RequiredFieldValidator ID="RESTYPCBoxTxtVal" runat="server" Display="None" ControlToValidate="RESTYPCBox" ErrorMessage="Select the type of the residence document"  ValidationGroup="Residence"></asp:RequiredFieldValidator>
                    
                        <asp:CompareValidator ID="RESTYPCBoxFVal" runat="server" ControlToValidate="RESTYPCBox" ValidationGroup="Residence"
                        Display="None" ErrorMessage="Select the type of the residence document" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
             
                    </div>
                    
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="ResidenceStatusLabel" class="requiredlabel">Residence Status:</div>
                        <div id="ResidenceStatusField" class="fielddiv" style="width:150px">
                            <asp:DropDownList ID="RESSTSCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="RESSTS_LD" class="control-loader"></div>

                        <asp:RequiredFieldValidator ID="RESSTSCBoxTxtVal" runat="server" Display="None" ControlToValidate="RESSTSCBox" ErrorMessage="Select the status of the residence document"  ValidationGroup="Residence"></asp:RequiredFieldValidator>
                    
                        <asp:CompareValidator ID="RESSTSCBoxFVal" runat="server" ControlToValidate="RESSTSCBox" ValidationGroup="Residence"
                        Display="None" ErrorMessage="Select the status of the residence document" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                    </div>
                </div>            
            </div>
            <div class="panel" id="Address">
                <h2>Address & Contact Details</h2>

                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="AddressLine1Label" class="requiredlabel">Address Line 1:</div>
                    <div id="AddressLine1Field" class="fielddiv" style="width:400px;">
                        <asp:TextBox ID="ADD1Txt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                    </div>
                    
                    <div id="ADD1limit" class="textremaining"></div>
       
                    <asp:RequiredFieldValidator ID="ADD1Val" runat="server" Display="None" ControlToValidate="ADD1Txt" ErrorMessage="Enter the primary address of the employee" ValidationGroup="Address"></asp:RequiredFieldValidator>  
                    
                    <asp:CustomValidator id="ADD1TxtFVal" runat="server" ValidationGroup="Address" 
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

                    <asp:CustomValidator id="ADD2TxtFVal" runat="server" ValidationGroup="Address" 
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
                    <div id="CONTRY_LD" class="control-loader"></div>

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
                <div id="City2" class="requiredlabel">City:</div>
                <div id="CityField2" class="fielddiv" style="width:150px;">
                    <asp:DropDownList ID="ddlCity" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="CITY_LD" class="control-loader"></div>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddlCity"
                Display="None" ErrorMessage="Select the city of the address" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Address"></asp:CompareValidator>
            </div>
        
               <%-- <div style="float:left; width:100%; height:20px; margin-top:20px;">
                    <div id="City" class="requiredlabel">City:</div>
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

                <div style="float:left; width:100%; height:20px; margin-top:20px;">
                    <div id="PostalCode" class="labeldiv">Postal Code:</div>
                    <div id="PostalCodeField" class="fielddiv">
                        <asp:TextBox ID="POSTTxt" runat="server" CssClass="textbox"></asp:TextBox>
                    </div>

                    <div id="PSTlimit" class="textremaining"></div>

                    <asp:CustomValidator id="POSTTxtFVal" runat="server" ValidationGroup="Address" 
                    ControlToValidate = "POSTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator> 
                </div>

                <div id="ContactDetailsHeader" class="groupboxheader">Contact Details (Optional)</div>
                <div id="ContactDetailsField" class="groupbox" style="height:220px;">
                    <img id="newContact" src="/Images/new_file.png" class="imgButton" alt="" title="Add new contact" />
        
                    <asp:GridView id="gvContacts" runat="server" AutoGenerateColumns="false" style="width:30%; margin-top:30px;" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:TemplateField ShowHeader="false" HeaderStyle-Width="50px">
                                <ItemTemplate>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="false" HeaderStyle-Width="50px">
                                <ItemTemplate>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="ID" HeaderText="" />
                            <asp:BoundField DataField="ContactNo" HeaderText="Contact Number" />
                            <asp:BoundField DataField="ContactType" HeaderText="Mathod" />
                         </Columns>
                    </asp:GridView>
                </div>
            </div>
            <div class="panel" id="Contract">
                <h2>Organizational Assignment</h2>
                
                <div id="ContractGroupHeader" class="groupboxheader">Contract Details</div>
                <div id="ContractGroupField" class="groupbox" style="height:220px;">
                    
                    <div style="float:left; width:100%; height:20px; margin-top:10px;">
                        <div id="ContractIDLebel" class="requiredlabel">Contract ID:</div>
                        <div id="ContractIDField" class="fielddiv" style="width:auto;">
                            <asp:TextBox ID="CTRCTIDTxt" runat="server" CssClass="textbox"></asp:TextBox>
                            <asp:Label ID="CTRCTIDLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
                        </div>
                        <div id="CONTIDlimit" class="textremaining"></div>
       
                        <asp:RequiredFieldValidator ID="CTRCTIDTxtVal" runat="server" Display="None" ControlToValidate="CTRCTIDTxt" ErrorMessage="Enter the contract ID of the employee" ValidationGroup="Contract"></asp:RequiredFieldValidator>
                        
                        <asp:CustomValidator id="CTRCTIDTxtFVal" runat="server" ValidationGroup="Contract" 
                        ControlToValidate = "CTRCTIDTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
                        ClientValidationFunction="validateIDField">
                        </asp:CustomValidator>   
                    
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
               
                    </div>
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
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

                    </div>
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="EndDateLabel" class="requiredlabel">Expiry Date:</div>
                        <div id="EndDateField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="CTREDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="CTREDTVal" runat="server" Display="None" ControlToValidate="CTREDTTxt" ErrorMessage="Enter the expiry date of the contract"  ValidationGroup="Contract"></asp:RequiredFieldValidator>       

                        <asp:RegularExpressionValidator ID="CTREDFVal" runat="server" ControlToValidate="CTREDTTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Contract"></asp:RegularExpressionValidator> 

                        <asp:CompareValidator ID="CTEDTF2Val" runat="server" ControlToCompare="CTRDTTxt"  ValidationGroup="Contract"
                        ControlToValidate="CTREDTTxt" ErrorMessage="Contract expiry date should be greater or equals the start date of the contract"
                        Operator="GreaterThanEqual" Type="Date"
                        Display="None"></asp:CompareValidator>

                        <asp:CustomValidator id="CTREDTTxtF3Val" runat="server" ValidationGroup="Contract" 
                        ControlToValidate = "CTREDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                        </asp:CustomValidator>


                    </div>  
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="EmploymentLabel" class="requiredlabel">Employment Mode:</div>
                        <div id="EmploymentField" class="fielddiv" style="width:150px">
                            <asp:DropDownList ID="CTYPCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="EMPLY_LD" class="control-loader"></div>
                        
                        <asp:RequiredFieldValidator ID="CTYPCBoxTxtVal" runat="server" Display="None" ControlToValidate="CTYPCBox" ErrorMessage="Select employment mode"  ValidationGroup="Contract"></asp:RequiredFieldValidator>
                        
                        <asp:CompareValidator ID="CTYPCBoxVal" runat="server" ControlToValidate="CTYPCBox" ValidationGroup="Contract"
                        Display="None" ErrorMessage="Select employment mode" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                    </div>
                 </div>
                 <div id="ORGManagementLabel" class="groupboxheader">Organization Assignment</div>
                 <div id="ORGManagementField" class="groupbox">
               
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
                    
                     <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="DOALabel" class="requiredlabel">Date of Assignment:</div>
                        <div id="DOAField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="DOATxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                        </div>       
                        <asp:RequiredFieldValidator ID="DOATxtVal" runat="server" Display="None" ControlToValidate="DOATxt" ErrorMessage="Enter the date of assignment" ValidationGroup="Contract"></asp:RequiredFieldValidator>       
                        
                        <asp:RegularExpressionValidator ID="DOAFVal" runat="server" ControlToValidate="DOATxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Contract"></asp:RegularExpressionValidator>
                        
                        <asp:CompareValidator ID="DOAF1Val" runat="server" ControlToCompare="CTRDTTxt"  ValidationGroup="Contract"
                        ControlToValidate="DOATxt" ErrorMessage="Date of assignment should be greater or equals the start date of the contract"
                        Operator="GreaterThanEqual" Type="Date"
                        Display="None"></asp:CompareValidator>
                         
                        <asp:CustomValidator id="DOAF2Val" runat="server" ValidationGroup="Contract" 
                        ControlToValidate = "DOATxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                        </asp:CustomValidator>       
                    </div>
                 </div>      
            </div>
        </div>
     </div>
</div>      
<asp:Panel ID="panel1" CssClass="savepanel" runat="server" style="display:none">
    <div style="padding:8px">
        <h2>Saving...</h2>
    </div>
</asp:Panel>

<ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="panel1" PopupControlID="panel1" BackgroundCssClass="modalBackground" DropShadow="true">
</ajax:ModalPopupExtender>

<input id="CONTACTMODE" type="hidden" value="" />
<input id="DATA" type="hidden" value="" />

<asp:Button ID="alias" runat="server" style="display:none" />

<ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel2" CancelControlID="CONTCancel" BackgroundCssClass="modalBackground">
</ajax:ModalPopupExtender>

<asp:Panel ID="panel2" runat="server" CssClass="modalPanel" style="height:250px;">
    <div id="CONTACT_header" class="modalHeader">Contact Info<span id="contactclose" class="modalclose" title="Close">X</span></div>
    
    <div id="validation_dialog_contactinfo" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary6" runat="server" CssClass="validator" ValidationGroup="ContactInfo" />
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="ContactNumberLabel" class="requiredlabel">Contact Number:</div>
        <div id="ContactNumberField" class="fielddiv" style="width:200px;">
            <asp:TextBox ID="CONTNUMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
        </div>
        
        <asp:RequiredFieldValidator ID="CNUMTxtVal" runat="server" Display="None" ControlToValidate="CONTNUMTxt" ErrorMessage="Enter the contact number" ValidationGroup="ContactInfo" ></asp:RequiredFieldValidator> 
            
        <asp:CustomValidator id="CONTNUMTxtFVal" runat="server" ValidationGroup="ContactInfo" 
        ControlToValidate = "CONTNUMTxt" Display="None" ErrorMessage = "Invalid contact number, the sequence should start with + followed by at most 12 digits"
        ClientValidationFunction="validatePhoneNumber">
        </asp:CustomValidator>   
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="ContactTypeLabel" class="requiredlabel">Contact Type:</div>
        <div id="ContactTypeField" class="fielddiv" style="width:300px">
            <asp:DropDownList ID="CONTTYPCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="CONTTYP_LD" class="control-loader"></div>
                        
        <asp:RequiredFieldValidator ID="CONTTYPTxtVal" runat="server" Display="None" ControlToValidate="CONTTYPCBox" ErrorMessage="Select the method of the contact"  ValidationGroup="ContactInfo"></asp:RequiredFieldValidator>
                        
        <asp:CompareValidator ID="CONTTYPVal" runat="server" ControlToValidate="CONTTYPCBox" ValidationGroup="ContactInfo"
        Display="None" ErrorMessage="Select the method of the contact" Operator="NotEqual" Style="position: static"
        ValueToCompare="0"></asp:CompareValidator>
    </div>
    
    <div class="buttondiv">
        <input id="CONTSave" type="button" class="button" style="margin-left:300px;" value="Save" />
        <input id="CONTCancel" type="button" class="button" value="Cancel" />
    </div>   
</asp:Panel>

</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvContacts.ClientID%> tr:last-child").clone(true);
       
        var duration = null;
        addWaterMarkText('Additional details in the support of the employee record', '#<%=DTLTxt.ClientID%>');

        loadComboboxAjax('loadTitles', "#<%=TitleCBox.ClientID%>","#TTL_LD");
        loadComboboxAjax('loadCountries', "#<%=CBCBox.ClientID%>", "#CB_LD");
        loadComboboxAjax('loadGenders', "#<%=GDRCBox.ClientID%>", "#GNDR_LD");
        loadComboboxAjax('loadMaritalStatus', "#<%=MRTLCBox.ClientID%>","#MRTL_LD");
        loadComboboxAjax('loadReligions', "#<%=RELCBox.ClientID%>", "#REL_LD");

        loadContractGroup("#<%=CTRTGRPCBox.ClientID%>","#CTRCTGRP_LD");

        loadComboboxAjax('loadContractType', "#<%=CTYPCBox.ClientID%>", "#EMPLY_LD");

        loadComboboxAjax('loadResidenceType', "#<%=RESTYPCBox.ClientID%>","#RESTYP_LD");
        loadComboboxAjax('loadResidenceStatus', "#<%=RESSTSCBox.ClientID%>","#RESSTS_LD");

        loadComboboxAjax('loadCountries', "#<%=ISSAUTHCBox.ClientID%>", "#ISSAUTH_LD");

        //loadComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>", "#CONTRY_LD");
        var module = "";
        var countryID = 0;
        var controls = new Array();


        BindCountry('loadCountries2', '#<%=COUNTCBox.ClientID%>', countryID, "#CONTRY_LD");

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

            //Load States
            module = "'countryId':'" + countryID + "'";
            bindParamComboboxAjaxKeyValue('loadStates', '#<%=ddlState.ClientID%>', module, 0, "#STATE_LD");


            //Load City By Country
            module = "'countryId':'" + countryID + "'";
            //bindParamComboboxAjaxKeyValue('loadCitiesByCountry', '#<%=ddlCity.ClientID%>', module, 0, "#CITY_LD");
            BindCityByCountry('loadCitiesByCountry2', '#<%=ddlCity.ClientID%>', module, 0, "#CITY_LD");
        }

        loadLastIDAjax('getLastPersonnelID', "#<%=PERSIDLbl.ClientID%>");
        loadLastIDAjax('getLastContractNo', "#<%=CTRCTIDLbl.ClientID%>");

        //remove the empty row in the gridview
        $("#<%=gvContacts.ClientID%> tr").not($("#<%=gvContacts.ClientID%> tr:first-child")).remove();

        /*attach personnel ID to limit plugin*/
        $("#<%=PERSIDTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach first name to limit plugin*/
        $("#<%=FNameTxt.ClientID%>").limit({ id_result: 'FNMlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach middle name to limit plugin*/
        $("#<%=MNameTxt.ClientID%>").limit({ id_result: 'MNMlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach last name to limit plugin*/
        $("#<%=LNameTxt.ClientID%>").limit({ id_result: 'LNMlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach known as to limit plugin*/
        $("#<%=KHASTxt.ClientID%>").limit({ id_result: 'KHNlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach email address to limit plugin*/
        $("#<%=EMLTxt.ClientID%>").limit({ id_result: 'EMLlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach passport no to limit plugin*/
        $("#<%=PASSNOTxt.ClientID%>").limit({ id_result: 'PASSNOlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach document no to limit plugin*/
        $("#<%=DOCNOTxt.ClientID%>").limit({ id_result: 'DOCNOlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach address line 1 to limit plugin*/
        $("#<%=ADD1Txt.ClientID%>").limit({ id_result: 'ADD1limit', alertClass: 'alertremaining', limit: 200 });

        /*attach address line 2 to limit plugin*/
        $("#<%=ADD2Txt.ClientID%>").limit({ id_result: 'ADD2limit', alertClass: 'alertremaining', limit: 200 });

       

        /*attach postal code to limit plugin*/
        $("#<%=POSTTxt.ClientID%>").limit({ id_result: 'PSTlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach contract no to limit plugin*/
        $("#<%=CTRCTIDTxt.ClientID%>").limit({ id_result: 'CONTIDlimit', alertClass: 'alertremaining', limit: 100 });


        $("#newContact").bind('click', function ()
        {
            $("#CONTACTMODE").val('ADD');

            loadComboboxAjax('loadContactType', '#<%=CONTTYPCBox.ClientID%>', "#CONTTYP_LD");

            clearModal();

            /* trigger modal popup extender*/
            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#contactclose").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#CONTCancel").trigger('click');
            }

        });

        $("#CONTSave").bind('click', function ()
        {
            var row = null;

            var isPageValid = Page_ClientValidate('ContactInfo');
            if (isPageValid)
            {
                if (!$("#validation_dialog_contactinfo").is(":hidden"))
                {
                    $("#validation_dialog_contactinfo").hide();
                }

                if ($("#CONTACTMODE").val() == 'ADD')
                {
                    var length = $("#<%=gvContacts.ClientID%> tr").not($("#<%=gvContacts.ClientID%> tr:first-child")).children().length;

                    if (length == 0) {
                        addContact(empty, length + 1, $("#<%=CONTNUMTxt.ClientID%>").val(), $("#<%=CONTTYPCBox.ClientID%>").val());
                    }
                    else {
                        var row = $("#<%=gvContacts.ClientID%> tr:last-child").clone(true);
                        addContact(row, length + 1, $("#<%=CONTNUMTxt.ClientID%>").val(), $("#<%=CONTTYPCBox.ClientID%>").val());
                    }
                }
                else
                {
                    updateContact();
                }

                $("#CONTCancel").trigger('click');
            }
            else
            {
                $("#validation_dialog_contactinfo").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

        $("#<%=DOBTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () {}
        });

        $("#<%=DOATxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });


        $("#<%=VLDFRMTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=VLDTOTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=DOISSTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=EXPDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=CTREDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=UNTSelect.ClientID%>").bind('click',function (e) {
            showORGDialog(e.pageX, e.pageY);
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function ()
        {
            var loadcontrols = new Array();
            loadcontrols.push('#<%=POSCBox.ClientID%>');

            loadParamComboboxAjax('getRelatedDepPositions', loadcontrols, "'unit':'" + $(this).val() + "'","#POS_LD");

            $("#SelectORG").hide('800');
        });

        $("#<%=CTRTGRPCBox.ClientID%>").change(function ()
        {
            validateContractGroup($(this).val());
        });


        $("#<%=CTRDTTxt.ClientID%>").keyup(function ()
        {
            validateContractGroup($("#<%=CTRTGRPCBox.ClientID%>").val());
        });

        $("#<%=CTRDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                validateContractGroup($("#<%=CTRTGRPCBox.ClientID%>").val());
            }
        });

        $("#save").bind('click', function ()
        {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid)
            {
                if (!$("#validation_dialog_general").is(":hidden"))
                {
                    $("#validation_dialog_general").hide();
                }

                var isPassportValid = Page_ClientValidate('Passport');
                if (isPassportValid)
                {
                    if (!$("#validation_dialog_passport").is(":hidden"))
                    {
                        $("#validation_dialog_passport").hide();
                    }

                    var isResidenceValid = Page_ClientValidate('Residence');
                    if (isResidenceValid)
                    {
                        if (!$("#validation_dialog_residence").is(":hidden"))
                        {
                            $("#validation_dialog_residence").hide();
                        }

                        var isAddressValid = Page_ClientValidate('Address');
                        if (isAddressValid)
                        {
                         
                            if (!$("#validation_dialog_address").is(":hidden"))
                            {
                                $("#validation_dialog_address").hide();
                            }

                            var isContractValid = Page_ClientValidate('Contract');
                            if (isContractValid)
                            {
                                if (!$("#validation_dialog_contract").is(":hidden"))
                                {
                                    $("#validation_dialog_contract").hide();
                                }

                                var result = confirm("Are you sure you would like to submit changes?");
                                if (result == true) {

                                    $find('<%= SaveExtender.ClientID %>').show();

                                    var dob = getDatePart($("#<%=DOBTxt.ClientID%>").val());
                                    var sd = getDatePart($("#<%=CTRDTTxt.ClientID%>").val());
                                    var ed = getDatePart($("#<%=CTREDTTxt.ClientID%>").val());
                                    var doa = getDatePart($("#<%=DOATxt.ClientID%>").val());
                                    var issudt = getDatePart($("#<%=DOISSTxt.ClientID%>").val());
                                    var expdt = getDatePart($("#<%=EXPDTTxt.ClientID%>").val());
                                    var validfromdt = getDatePart($("#<%=VLDFRMTxt.ClientID%>").val());
                                    var validtodt = getDatePart($("#<%=VLDTOTxt.ClientID%>").val());

                                    var stateId = $("#<%=ddlState.ClientID%>").val();
                                    if (stateId == null)
                                        stateId = "0";

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
                                        Nationalities:
                                        [
                                            {
                                                PassportNo: $("#<%=PASSNOTxt.ClientID%>").val(),
                                                IssueDate: new Date(issudt[2], (issudt[1] - 1), issudt[0]),
                                                ExpiryDate: new Date(expdt[2], (expdt[1] - 1), expdt[0]),
                                                Authority: $("#<%=ISSAUTHCBox.ClientID%>").val()
                                            }
                                        ],
                                        Address:
                                        [
                                            {
                                                AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                                                AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                                                CountryID: $("#<%=COUNTCBox.ClientID%>").val(),
                                                StateID: stateId,
                                                CityID: $("#<%=ddlCity.ClientID%>").val(),
                                                PostalCode: $("#<%=POSTTxt.ClientID%>").val(),
                                                Contacts: getContactJSON()
                                            }
                                        ],
                                        ResidenceDoc:
                                        [
                                            {
                                                DocumentNo: $("#<%=DOCNOTxt.ClientID%>").val(),
                                                DocumentType: $("#<%=RESTYPCBox.ClientID%>").val(),
                                                DocumentStatus: $("#<%=RESSTSCBox.ClientID%>").val(),
                                                ValidFrom: new Date(validfromdt[2], (validfromdt[1] - 1), validfromdt[0]),
                                                ValidTo: new Date(validtodt[2], (validtodt[1] - 1), validtodt[0])
                                            }
                                        ],
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
                                        ]
                                    }

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: "{\'json\':\'" + JSON.stringify(employee) + "\'}",
                                        url: getServiceURL().concat('createNewEmployee'),
                                        success: function (data)
                                        {
                                            $find('<%= SaveExtender.ClientID %>').hide();

                                            showSuccessNotification(data.d);

                                            reset();

                                            addWaterMarkText('Additional details in the support of the employee record', '#<%=DTLTxt.ClientID%>');

                                            loadLastIDAjax('getLastPersonnelID', "#<%=PERSIDLbl.ClientID%>");
                                            loadLastIDAjax('getLastContractNo', "#<%=CTRCTIDLbl.ClientID%>");

                                            /*trigger textbox keyup event to reset the character counter*/
                                            $(".textbox").each(function () {
                                                $(this).keyup();

                                            });

                                            trigger({ id: '#Details' });

                                            $('#slider .navigation').find('a[href$="#Details"]').click();

                                        },
                                        error: function (xhr, status, error)
                                        {
                                            $find('<%= SaveExtender.ClientID %>').hide();

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message)

                                        }
                                    });

                                }
                            }
                            else
                            {
                                $("#validation_dialog_contract").stop(true).hide().fadeIn(500, function () {
                                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                                    trigger({ id: '#Contract' });

                                    $('#slider .navigation').find('a[href$="#Contract"]').click();
                                });
                            }
                        }
                        else
                        {
                            $("#validation_dialog_address").stop(true).hide().fadeIn(500, function ()
                            {
                                alert("Please make sure that all warnings highlighted in red color are fulfilled");
                                trigger({ id: '#Address' });

                                $('#slider .navigation').find('a[href$="#Address"]').click();
                            });
                        }

                    }
                    else
                    {
                        $("#validation_dialog_residence").stop(true).hide().fadeIn(500, function ()
                        {
                            alert("Please make sure that all warnings highlighted in red color are fulfilled");
                            trigger({ id: '#Nationalities' });

                            $('#slider .navigation').find('a[href$="#Nationalities"]').click();
                        });
                    }
                }
                else
                {
                    $("#validation_dialog_passport").stop(true).hide().fadeIn(500, function ()
                    {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                        trigger({ id: '#Nationalities' });

                        $('#slider .navigation').find('a[href$="#Nationalities"]').click();
                    });

                   
                }
            }
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");

                    trigger({ id: '#Details' });

                    $('#slider .navigation').find('a[href$="#Details"]').click();
                });
            }
        });

        var $panels = $('#slider .scrollContainer > div');
        var $container = $('#slider .scrollContainer');

        // if false, we'll float all the panels left and fix the width 
        // of the container
        var horizontal = true;

        // float the panels left if we're going horizontal
        if (horizontal) {
            $panels.css({
                'float': 'left',
                'position': 'relative' // IE fix to ensure overflow is hidden
            });

            // calculate a new width for the container (so it holds all panels)
            $container.css('width', $panels[0].offsetWidth * $panels.length);
        }

        // collect the scroll object, at the same time apply the hidden overflow
        // to remove the default scrollbars that will appear
        var $scroll = $('#slider .scroll').css('overflow', 'hidden');

        // apply our left + right buttons
        //$scroll
        //    .before('<img class="scrollButtons left" src="/Images/scroll_left.png" />')
        //    .after('<img class="scrollButtons right" src="/images/scroll_right.png" />');

        // handle nav selection
        function selectNav() {
            $(this)
                .parents('ul:first')
                    .find('a')
                        .removeClass('selected')
                    .end()
                .end()
                .addClass('selected');
        }

        $('#slider .navigation').find('a').click(selectNav);

        // go find the navigation link that has this target and select the nav
        function trigger(data) {
            var el = $('#slider .navigation').find('a[href$="' + data.id + '"]').get(0);
            selectNav.call(el);
        }

        if (window.location.hash) {
            trigger({ id: window.location.hash.substr(1) });
        } else {
            $('ul.navigation a:first').click();
        }

        // offset is used to move to *exactly* the right place, since I'm using
        // padding on my example, I need to subtract the amount of padding to
        // the offset.  Try removing this to get a good idea of the effect
        var offset = parseInt((horizontal ?
            $container.css('paddingTop') :
            $container.css('paddingLeft'))
            || 0) * -1;


        var scrollOptions = {
            target: $scroll, // the element that has the overflow

            // can be a selector which will be relative to the target
            items: $panels,

            navigation: '.navigation a',

            // selectors are NOT relative to document, i.e. make sure they're unique
            prev: 'img.left',
            next: 'img.right',

            // allow the scroll effect to run both directions
            axis: 'xy',

            onAfter: trigger, // our final callback

            offset: offset,

            // duration of the sliding effect
            duration: 500,

            // easing - can be used with the easing plugin: 
            // http://gsgd.co.uk/sandbox/jquery/easing/
            easing: 'swing'
        };

        // apply serialScroll to the slider - we chose this plugin because it 
        // supports// the indexed next and previous scroll along with hooking 
        // in to our navigation.
        $('#slider').serialScroll(scrollOptions);

        // now apply localScroll to hook any other arbitrary links to trigger 
        // the effect
        $.localScroll(scrollOptions);

        // finally, if the URL has a hash, move the slider in to position, 
        // setting the duration to 1 because I don't want it to scroll in the
        // very first page load.  We don't always need this, but it ensures
        // the positioning is absolutely spot on when the pages loads.
        scrollOptions.duration = 1;
        $.localScroll.hash(scrollOptions);

    });

    function loadContractGroup(control,loader)
    {
        $(loader).stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadContractGroup"),
                success: function (data)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'ContractGroup', 'GroupName', $(control));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message)
                    });
                }
            });
        });
    }

    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 40, top: y - 90 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#UNT_LD");
        $("#SelectORG").show();
    }
    function setExpiryDate(date, duration, period) {
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
    function getContactJSON() {
        var contacts = new Array();
        $("#<%=gvContacts.ClientID%> tr").not($("#<%=gvContacts.ClientID%> tr:first-child")).each(function (index, value) {
            var contact =
             {
                 Number: $("td", $(this)).eq(3).html(),
                 Type: $("td", $(this)).eq(4).html()
             }
            contacts.push(contact);
        });

        if (contacts.length == 0)
            return null;

        return contacts;
    }
    function validateContractGroup(name)
    {
        $("#<%=CTRDURTxt.ClientID%>").val('');
        $("#<%=CTRPRDTxt.ClientID%>").val('');
  
        if (name == 0 || name == null)
        {
            alert("Please select contract group");

            /*clear the contract start date field if there is a value*/
            $("#<%=CTRDTTxt.ClientID%>").val('');
        }
        else
        {
            $.ajax(
           {
               type: "POST",
               contentType: "application/json",
               dataType: "json",
               data: "{'name':'" + name + "'}",
               url: getServiceURL().concat('getContractGroup'),
               success: function (data) {
                   if (data)
                   {
                       var xmlGroup = $.parseXML(data.d);

                       var group = $(xmlGroup).find('ContractGroup');

                       if (group.attr('IsConstraint') == "true")
                       {
                           if ($("#<%=CTRDTTxt.ClientID%>").val() != '')
                           {
                               setExpiryDate($("#<%=CTRDTTxt.ClientID%>").val(), parseInt(group.attr('Duration')), group.attr('Period'));

                               /*update the position's date of assignment to the contract date*/
                               $("#<%=DOATxt.ClientID%>").val($("#<%=CTRDTTxt.ClientID%>").val());
                           }

                           /* setup the duration and the period values*/
                           $("#<%=CTRDURTxt.ClientID%>").val(group.attr('Duration'));
                           $("#<%=CTRPRDTxt.ClientID%>").val(group.attr('Period'));
                       }
                       else
                       {
                           /* set unlimited date, which is 31/12/9999*/
                           var expirydate = new Date();
                           expirydate.setFullYear(9999, 11, 31);

                           $("#<%=CTREDTTxt.ClientID%>").val(expirydate.format("dd/MM/yyyy"));

                           if ($("#<%=CTRDTTxt.ClientID%>").val() != '')
                           {
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
    function updateContact()
    {
        var contact = JSON.parse($("#DATA").val());

        $("#<%=gvContacts.ClientID%> tr").not($("#<%=gvContacts.ClientID%> tr:first-child")).each(function (index, value) {

            if ($("td", $(this)).eq(2).html() == contact.ID)
            {
                $("td", $(this)).eq(3).html($("#<%=CONTNUMTxt.ClientID%>").val());
                $("td", $(this)).eq(4).html($("#<%=CONTTYPCBox.ClientID%>").val());
            }
        });
    }
    function addContact(row, length, number,type)
    {
        $("td", row).eq(0).html("<img id='remove_" + length + "' src='/Images/deletenode.png' class='imgButton'/>");
        $("td", row).eq(1).html("<img id='edit_" + length + "' src='/Images/edit.png' class='imgButton'/>");
        $("td", row).eq(2).html(length);
        $("td", row).eq(3).html(number);
        $("td", row).eq(4).html(type);

        $("#<%=gvContacts.ClientID%>").append(row);

        $(row).find('img').each(function () {
            if ($(this).attr('id').search('edit') != -1)
            {
                $(this).bind('click', function ()
                {
                    var contact =
                    {
                        ID: parseInt($("td", row).eq(2).html()),
                        Number: $("td", row).eq(3).html(),
                        Type: $("td", row).eq(4).html()
                    }

                    $("#DATA").val(JSON.stringify(contact));

                    $("#CONTACTMODE").val('EDIT');

                    $("#<%=CONTNUMTxt.ClientID%>").val(contact.Number);

                    bindComboboxAjax('loadContactType', '#<%=CONTTYPCBox.ClientID%>',contact.Type,"#CONTTYP_LD");
                  
                    /* trigger modal popup extender*/
                    $("#<%=alias.ClientID%>").trigger('click');

                });
            }
            else if ($(this).attr('id').search('remove') != -1) {
                $(this).bind('click', function () {
                    $(row).remove();
                });
            }
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

    function clearModal() {
        $(".modalPanel").children().each(function () {
            $(this).find('.textbox').each(function () {
                $(this).val('');
            });

            $(this).find('.combobox').each(function () {
                $(this).val(0);
            });

        });
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
