<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateProblem.aspx.cs" Inherits="QMSRSTools.ProblemManagement.CreateProblem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="wrapper" class="modulewrapper">
    
    <div id="Problem_Header" class="moduleheader">Create a New Problem</div>

    <div class="toolbox">
        <img id="save" src="http://www.qmsrs.com/qmsrstools/Images/save.png" class="imgButton" title="Save Changes" alt="" /> 
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="ProblemTypeLabel" class="requiredlabel">Problem Type:</div>
        <div id="ProblemTypeField" class="fielddiv" style="width:250px;">
            <asp:DropDownList ID="PRBLCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="PTYP_LD" class="control-loader"></div>
        
        <span id="PROBADD" class="addnew" style="" runat="server" title="Create new problem type"></span>
     
        <asp:RequiredFieldValidator ID="PRBLTxtVal" runat="server" Display="None" ControlToValidate="PRBLCBox" ErrorMessage="Select the type of the problem" ValidationGroup="General"></asp:RequiredFieldValidator>
    
        <asp:CompareValidator ID="PRBLVal" runat="server" ControlToValidate="PRBLCBox"
        Display="None" ErrorMessage="Select the type of the problem" Operator="NotEqual" Style="position: static"
        ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="CaseNoLabel" class="requiredlabel">Case No:</div>
        <div id="CaseNoField" class="fielddiv" style="width:auto;">
            <asp:TextBox ID="CaseNoTxt" runat="server" CssClass="textbox"></asp:TextBox>
            <asp:Label ID="CaseNoLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
        </div>
        <div id="IDlimit" class="textremaining"></div>
        
        <asp:RequiredFieldValidator ID="CaseNoVal" runat="server" Display="None" ControlToValidate="CaseNoTxt" ErrorMessage="Enter a unique case number" ValidationGroup="General"></asp:RequiredFieldValidator>

        <asp:CustomValidator id="CaseNoTxtFVal" runat="server" ValidationGroup="General" 
        ControlToValidate = "CaseNoTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
        ClientValidationFunction="validateIDField">
        </asp:CustomValidator>      
    </div>

    <div id="ProblemGroupHeader" class="groupboxheader">Problem Details</div>
    <div id="ProblemGroupField" class="groupbox" style="height:500px;">
    
        <ul id="tabul">
            <li id="Details" class="ntabs">Main Information</li>
            <li id="Causes" class="ntabs">Related Causes</li>
            <li id="Additional" class="ntabs">Additional information</li>
            <li id="Supplementary" class="ntabs">Supplementary information</li>
            <li id="Approval" class="ntabs">Approval Details</li>
        </ul>
    
        <div id="DetailsTB" class="tabcontent" style="display:none; height:400px;">        
            
            <div id="validation_dialog_general" class="validation" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="AffectedPartyTypeLabel" class="requiredlabel">Affected Party Type:</div>
                <div id="AffectedPartyTypeField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="AFFPRTTYPCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="AFFPRTTYP_LD" class="control-loader"></div>
        
                <asp:RequiredFieldValidator ID="AFFPRTTYPTxtVal" runat="server" Display="None" ControlToValidate="AFFPRTTYPCBox" ErrorMessage="Select the type of the affected party" ValidationGroup="General"></asp:RequiredFieldValidator>
    
                <asp:CompareValidator ID="AFFPRTTYPVal" runat="server" ControlToValidate="AFFPRTTYPCBox"
                Display="None" ErrorMessage="Select the type of the affected party" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
            </div>
            
            <div id="external" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="AffectedPartyLabel" class="labeldiv">Affected Party:</div>
                <div id="AffectedPartyField" class="fielddiv" style="width:300px;">
                    <asp:TextBox ID="AFFPRTYTxt" runat="server" CssClass="readonly" Width="290px" ReadOnly="true"></asp:TextBox>
                </div>
                <span id="AFFPRTYSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            </div>

            <div id="internal" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px; display:none;"">
                <div id="AffectedDepartmentLabel" class="labeldiv">Affected Department:</div>
                <div id="AffectedDepartmentField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="AFFORGUNT" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="AFFORGUNT_LD" class="control-loader"></div>
            </div>

            <div id="SearchCustomer" class="selectbox">
                <div class="toolbox">
                    <div id="closeBox" class="selectboxclose"></div>
                </div>
                
                <div id="PartyTypeContainer" class="filterselectbox" style="display:block;">
                    <div id="PartyTypeLabel" class="filterlabel">Filter by Type:</div>
                    <div id="PartyTypeField" class="filterfield">
                        <asp:DropDownList ID="PRTTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                        </asp:DropDownList>
                    </div>
                    <div id="PRTYP_LD" class="control-loader"></div>
                </div>

                <div id="FLTR_LD" class="control-loader"></div> 

                <div id="scrollbar" class="gridscroll">
                    <asp:GridView id="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:BoundField DataField="CustomerNo" HeaderText="Affected Party No." />
                            <asp:BoundField DataField="CustomerType" HeaderText="Type" />
                            <asp:BoundField DataField="CustomerName" HeaderText="Name" />
                            <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AffectedDocumentLabel" class="labeldiv">Affected Document:</div>
                <div id="AffectedDocumentField" class="fielddiv" style="width:250px">
                     <asp:DropDownList ID="AFFCTDOCCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="DOC_LD" class="control-loader"></div>

                <span id="DOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for affected document"></span>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemTitleLabel" class="requiredlabel">Problem:</div>
                <div id="ProblemTitleField" class="fielddiv" style="width:300px;">
                    <asp:TextBox ID="PRMNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
                </div>
                <div id="PRMNMlimit" class="textremaining"></div>
        
                <asp:RequiredFieldValidator ID="PRMNMVal" runat="server" Display="None" ControlToValidate="PRMNMTxt" ErrorMessage="Enter the title of the problem" ValidationGroup="General"></asp:RequiredFieldValidator>

                <asp:CustomValidator id="PRMNMTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "PRMNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemDescriptionLabel" class="labeldiv">Problem Description:</div>
                <div id="ProblemDescriptionField" class="fielddiv" style="width:400px; height:190px;">
                    <asp:TextBox ID="PRMDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="PRMDESCTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "PRMDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>
        <div id="CausesTB" class="tabcontent" style="display:none;height:400px;">
            <div class="toolbox">
                <img id="undo" src="http://www.qmsrs.com/qmsrstools/Images/undo.png" class="imgButton" title="Undo Causes" alt="" />
                <img id="delete" src="http://www.qmsrs.com/qmsrstools/Images/deletenode.png" alt="" class="imgButton" title="Remove Selected Cause" />
                <img id="new" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" alt="" class="imgButton" title="New Child Cause"/>

                <div id="RootCauseContainer" style=" float:left;width:400px; margin-left:10px; height:20px; margin-top:3px;">
                    <div id="RootCauseLabel" style="width:100px;">Root Cause:</div>
                    <div id="RootCauseField" style="width:250px; left:0; float:left;">
                        <asp:DropDownList ID="RTCAUSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="RTCAUS_LD" class="control-loader"></div>
                </div>

            </div>
        
            <div id="treemenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible;height:370px;">
                <div id="cause_LD" class="control-loader"></div> 
                <div id="causetree"></div>
            </div>

            <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; overflow:visible;height:370px;">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="CUSTitleLabel" class="requiredlabel">Cause Name:</div>
                    <div id="CUSTitleField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="CUSTTLTxt" runat="server" CssClass="textbox treefield" Width="240px"></asp:TextBox>
                    </div>
                    <div id="CUSTTLlimit" class="textremaining"></div>
        
                </div>
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ParentCauseLabel" class="labeldiv">Related to Cause:</div>
                    <div id="ParentCauseField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="PCUSTxt" runat="server" ReadOnly="true" CssClass="readonly" Width="240px"></asp:TextBox>
                    </div>
                </div>
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="CUSDetailsLabel" class="labeldiv">More Information</div>
                    <div id="CUSDetailsField" class="fielddiv" style="width:400px; height:190px;">
                        <asp:TextBox ID="CUSDTLTxt" runat="server" CssClass="textbox treefield" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
            </div>  
        </div>
        <div id="AdditionalTB" class="tabcontent" style="display:none;height:400px;">

            <div id="validation_dialog_additional" class="validation" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Additional" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemOriginatorLabel" class="requiredlabel">Problem Originator:</div>
                <div id="ProblemOriginatorField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="ORGCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORIG_LD" class="control-loader"></div>
                
                <span id="ORIGSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
        
                <asp:RequiredFieldValidator ID="ORGCBoxTxtVal" runat="server" ControlToValidate="ORGCBox" ErrorMessage="Select the originator of the problem" Display="None" ValidationGroup="Additional"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="ORGCBoxVal" runat="server" ControlToValidate="ORGCBox" Display="None"  ValidationGroup="Additional"
                ErrorMessage="Select the originator of the problem" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OwnerLabel" class="requiredlabel">Problem Owner:</div>
                <div id="OwnerField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="OWNR_LD" class="control-loader"></div>

                <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
                <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select the owner of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="OWNRCBoxVal" runat="server" ControlToValidate="OWNRCBox" Display="None"  ValidationGroup="Additional"
                ErrorMessage="Select the owner of the problem" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
     
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ExecutiveLabel" class="requiredlabel">Problem Executive:</div>
                <div id="ExecutiveField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="EXECBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="EXE_LD" class="control-loader"></div>

                <span id="EXESelect" class="searchactive" style="margin-left:10px" runat="server"></span>

                <asp:RequiredFieldValidator ID="EXECBoxTxtVal" runat="server" Display="None" ControlToValidate="EXECBox" ErrorMessage="Select the executive of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="EXECBoxVal" runat="server" ControlToValidate="EXECBox" Display="None" ValidationGroup="Additional"
                ErrorMessage="Select the executive of the problem" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

           

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProblemRaiseDateLabel" class="requiredlabel">Raise Date:</div>
            <div id="ProblemRaiseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="RISDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
             
            </div>      
            <asp:RequiredFieldValidator ID="RISDTVal" runat="server" Display="None" ControlToValidate="RISDTTxt" ErrorMessage="Enter the raise date of the problem"  ValidationGroup="Additional"></asp:RequiredFieldValidator>  
           
            <asp:RegularExpressionValidator ID="RISDTTxtFVal" runat="server" ControlToValidate="RISDTTxt"
            ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" Display="None" ValidationGroup="Additional"></asp:RegularExpressionValidator>  
            
            <asp:CustomValidator id="RISDTTxtF2Val" runat="server" ValidationGroup="Additional" 
            ControlToValidate = "RISDTTxt" Display="None" ErrorMessage = "Raise date should match today's date"
            ClientValidationFunction="compareEqualsToday">
            </asp:CustomValidator>

            <asp:CustomValidator id="RISDTTxtF3Val" runat="server" ValidationGroup="Additional" 
            ControlToValidate = "RISDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>   
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OriginationDateLabel" class="labeldiv">Origination Date:</div>
            <div id="OriginationDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ORGDTTxt" runat="server" Width="140px" CssClass="date" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            
            <asp:RegularExpressionValidator ID="ORGDTTxtFval" runat="server" ControlToValidate="ORGDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>  
            
            <asp:CompareValidator ID="ORGDTVal" runat="server" ControlToCompare="RISDTTxt"  ValidationGroup="Additional"
            ControlToValidate="ORGDTTxt" ErrorMessage="Orgination date should be greater or equals raise date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator>
            
            <asp:CustomValidator id="ORGDTF2Val" runat="server" ValidationGroup="Additional" 
            ControlToValidate = "ORGDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator> 
        </div> 
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="TRGTCloseDateLabel" class="requiredlabel">Target Close Date:</div>
            <div id="TRGTCloseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="TRGTCLSDTTxt" runat="server" Width="140px" CssClass="date" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            <asp:RequiredFieldValidator ID="TRGTCLSDTVal" runat="server" Display="None" ControlToValidate="TRGTCLSDTTxt" ErrorMessage="Enter the target closing date of the problem"  ValidationGroup="Additional"></asp:RequiredFieldValidator>   
            
            <asp:RegularExpressionValidator ID="TRGTCLSDTTxtFval" runat="server" ControlToValidate="TRGTCLSDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>  
           
            <asp:CompareValidator ID="TRGTCLSDTFVal" runat="server" ControlToCompare="RISDTTxt"  ValidationGroup="Additional"
            ControlToValidate="TRGTCLSDTTxt" ErrorMessage="Target closing date should be greater or equals raise date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator>
      
            <asp:CustomValidator id="TRGTCLSDTF2Val" runat="server" ValidationGroup="Additional" 
            ControlToValidate = "TRGTCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator> 
        </div>     
          
    </div>
    <div id="SupplementaryTB" class="tabcontent" style="display:none; height:400px;">
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="ReportedFromLabel" class="labeldiv">Reported From:</div>
            <div id="ReportedFromField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="REPFRMCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="REPORG_LD" class="control-loader"></div>

        </div>
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RelatedORGLabel" class="labeldiv">Source of Problem:</div>
            <div id="RelatedORGField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="RELORGCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="SRCORG_LD" class="control-loader"></div>

        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="SeverityLabel" class="labeldiv">Severity Criteria:</div>
            <div id="SeverityField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="SVRTCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>

            <div id="SVR_LD" class="control-loader"></div>

        </div>      
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RiskCategoryLabel" class="labeldiv">Select Risk Category:</div>
            <div id="RiskCategoryField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="RSKCATCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            
            <div id="RSKCAT_LD" class="control-loader"></div> 

            <span id="CATADD" class="addnew" style="margin-left:10px;" runat="server" title="Create new risk category"></span>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RiskListLabel" class="labeldiv">Assciated Risk List:</div>
            <div id="RiskListField" class="fielddiv" style="width:250px">
                <div id="RSKCHK" class="checklist"></div>
            </div>
        </div>
    </div>
    <div id="ApprovalTB" class="tabcontent" style="display:none; height:400px;">

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RequiresApprovalLabel" class="labeldiv">Requires Approval:</div>
            <div id="RequiresApprovalField" class="fielddiv" style="width:250px">
                <input type="checkbox" id="APPRCHK" class="checkbox" />
            </div>
            
        </div>

        <div id="ApprovalGroupHeader" class="groupboxheader" style=" margin-top:15px;">Approval Details</div>
        <div id="ApprovalGroupField" class="groupbox" style="height:100px; display:none;">
            <img id="newmember" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Add new Approval Member" alt=""/>
        
            <div id="table" class="table" style="display:none;">
                <div id="row_header" class="tr">
                    <div id="col0_head" class="tdh" style="width:50px"></div>
                    <div id="col1_head" class="tdh" style="width:20%">Member</div>
                    <div id="col2_head" class="tdh" style="width:20%">Type</div>
                    <div id="col3_head" class="tdh" style="width:20%">Approval Status</div>
                    <div id="col4_head" class="tdh" style="width:20%">Decision Details</div>
                </div>
            </div>
        </div>
    </div>

    <div id="SelectDOC" class="selectbox">
        <div id="closedoc" class="selectboxclose"></div>
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="DocumentTypeLabel" class="labeldiv" style="width:100px;">Document Type:</div>
            <div id="DocumentTypeField" class="fielddiv" style="width:130px">
                <asp:DropDownList ID="DOCTYP" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="DOCTYP_LD" class="control-loader"></div>
        </div>
    </div>

    <div id="SelectORG" class="selectbox">
        <div id="closeORG" class="selectboxclose"></div>
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
            <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                </asp:DropDownList> 
            </div>
            <div id="ORG_LD" class="control-loader"></div>
        </div>
    </div>

</div>


<asp:Button ID="ptypealias" runat="server" style="display:none" />
<asp:Button ID="rskcatalias" runat="server" style="display:none" />

<ajax:ModalPopupExtender ID="ProblemTypeExtender" runat="server" BehaviorID="ProblemTypeExtender" TargetControlID="ptypealias" PopupControlID="ProblemTypePanel" CancelControlID="PTYPCancel" BackgroundCssClass="modalBackground">
</ajax:ModalPopupExtender>

<ajax:ModalPopupExtender ID="RiskCategoryExtender" runat="server" BehaviorID="RiskCategoryExtender" TargetControlID="rskcatalias" PopupControlID="RiskCategoryPanel" CancelControlID="CATCancel" BackgroundCssClass="modalBackground">
</ajax:ModalPopupExtender>

<asp:Panel ID="ProblemTypePanel" runat="server" CssClass="modalPanel" style="height:300px;">
    <div id="PTYP_header" class="modalHeader">Create New Problem Type<span id="PTYPclose" class="modalclose" title="Close">X</span></div>
    
    <div id="validation_dialog_popup">
        <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="Popup" />
    </div>
          
    <div id="ProblemTypeSaveTooltip" class="tooltip">
        <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
        <p>Saving...</p>
    </div>

      
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="TypeNameLabel" class="requiredlabel">Type Name:</div>
        <div id="TypeNameField" class="fielddiv" style="width:200px;">
            <asp:TextBox ID="TYPNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
        </div>
            
        <div id="TYPlimit" class="textremaining"></div>

        <asp:RequiredFieldValidator ID="TYPNMVal" runat="server" Display="None" ControlToValidate="TYPNMTxt" ErrorMessage="Enter the name of the problem type" ValidationGroup="Popup"></asp:RequiredFieldValidator>
            
        <asp:CustomValidator id="TYPNMFVal" runat="server" ValidationGroup="Popup" 
        ControlToValidate = "TYPNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
        ClientValidationFunction="validateSpecialCharacters">
        </asp:CustomValidator>    
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="DescriptionLabel" class="labeldiv">Description:</div>
        <div id="DescriptionField" class="fielddiv" style="width:400px;">
            <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
        </div>

        <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="Popup"
        ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
        ClientValidationFunction="validateSpecialCharactersLongText">
        </asp:CustomValidator>
    </div>
    
    <div class="buttondiv">
        <input id="PTYPSave" type="button" class="button" style="margin-left:300px;" value="Save" />
        <input id="PTYPCancel" type="button" class="button" value="Cancel" />
    </div>   
</asp:Panel>


 <asp:Panel ID="RiskCategoryPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CategoryHeader" class="modalHeader">Risk Category Details<span id="CATclose" class="modalclose" title="Close">X</span></div>

        <div id="RiskCategorySaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_category">
            <asp:ValidationSummary ID="ValidationSummary4" runat="server" CssClass="validator" ValidationGroup="Category" />
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
            <div id="RiskCategoryDescriptionLabel" class="labeldiv">Description:</div>
            <div id="RiskCategoryDescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="RSKCATDESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="RSKCATDESCTxtFVal" runat="server" ValidationGroup="Category" 
            ControlToValidate = "RSKCATDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
       </div>

       <div class="buttondiv">
            <input id="CATSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="CATCancel" type="button" class="button" value="Cancel" />
       </div>   
</asp:Panel>

<input id="invoker" type="hidden" value="" />



<asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
    <div style="padding:8px">
        <h2>Saving...</h2>
    </div>
</asp:Panel>

<ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
</ajax:ModalPopupExtender>

</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        /*setup the title of each of help icons*/
        $(".tooltipbutton").attr('title', "What's this?");

        var empty = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);

        /*Activate the first TAB*/
        resetTab();

        /*load all root causes*/
        loadRootCauses();

        /*Create default causes*/
        refreshCauses();

        /*Obtain the latest case No.*/
        loadLastIDAjax('getLastCaseID', "#<%=CaseNoLbl.ClientID%>");

        /*Load problem type*/
        loadProblemType();

        /*load the organization unit for which the problem is reported from*/
        loadComboboxAjax('getOrganizationUnits', "#<%=REPFRMCBox.ClientID%>", "#REPORG_LD");

        /*load the organization unit for which is the source of the problem*/
        loadComboboxAjax('getOrganizationUnits', "#<%=RELORGCBox.ClientID%>", "#SRCORG_LD");

        /*load the type of the party*/
        loadComboboxAjax('loadProblemPartyType', "#<%=AFFPRTTYPCBox.ClientID%>", "#AFFPRTTYP_LD");

        /*load severity values*/
        loadSeverity();

        /*load risk category*/
        loadXMLRiskCategory();

        addWaterMarkText('The Description of the Problem', '#<%=PRMDESCTxt.ClientID%>');

        /*attach ID to limit plugin*/
        $("#<%=CaseNoTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 90 });

        /*attach problem name to limit plugin*/
        $("#<%=PRMNMTxt.ClientID%>").limit({ id_result: 'PRMNMlimit', alertClass: 'alertremaining', limit: 90 });

        $("#<%=AFFPRTYSelect.ClientID%>").click(function (e)
        {
            $("#<%=AFFPRTYTxt.ClientID%>").val('');

            loadXMLPartyType("#PRTYP_LD", "#<%=PRTTYPCBox.ClientID%>");
            
            showCustomerDialog(e.pageX, e.pageY, empty);
            
        });

        /* Undo any loaded cause tree by refrshing it with a new and default tree*/
        $("#undo").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to undo all modified causes?");
            if (result == true)
            {
                refreshCauses();
                loadRootCauses();
            }
        });

     
        $("#<%=DOCTYP.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var $obj = $(this);
                $("#DOC_LD").stop(true).hide().fadeIn(800, function () {
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'type':'" + $obj.val() + "'}",
                        url: getServiceURL().concat("loadCurrentDocuments"),
                        success: function (data) {
                            $("#DOC_LD").fadeOut(500, function () {
                                if (data) {
                                    loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $("#<%=AFFCTDOCCBox.ClientID%>"));

                                    $("#SelectDOC").hide('800');
                                }
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#DOC_LD").fadeOut(500, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);

                                $("#SelectDOC").hide('800');
                            });
                        }
                    });
                });
            }
        });

        $("#<%=AFFPRTTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                switch ($(this).val())
                {
                    case "External":
                        $("#external").stop(true).hide().fadeIn(500, function ()
                        {});

                        $("#internal").fadeOut(500, function () {});

                        break;
                    case "Internal":
                        $("#internal").stop(true).hide().fadeIn(500, function ()
                        {
                            /*load the organization unit if the affected party is of type internal*/
                            loadComboboxAjax('getOrganizationUnits', "#<%=AFFORGUNT.ClientID%>", "#AFFORGUNT_LD");
                        });

                        $("#external").fadeOut(500, function ()
                        {
                        });
                        break;
                    case "None":
                        $(".selectionfield").each(function ()
                        {
                            $(this).fadeOut(500, function ()
                            {
                            });
                        });
                        break;
                }
            }
        });

        $("#<%=RTCAUSCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var vals = $(this).val().split(" ");

                loadCauses(parseInt(vals[1]));
            }
        });

        $("#<%=PRTTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != -1)
            {
                filterByType($(this).val(), empty);
            }
        });

        /*enable or disable adding approval members*/
        $("#APPRCHK").change(function ()
        {
            if ($(this).is(":checked") == true)
            {

                $("#ApprovalGroupField").stop(true).hide().fadeIn(500, function ()
                {
                    var jsonmember =
                    [
                    ];

                    var attributes = new Array();
                    attributes.push("Member");
                    attributes.push("MemberType");
                    attributes.push("ApprovalStatusString");
                    attributes.push("ApprovalRemarks");

                    var json = $.parseJSON(JSON.stringify(jsonmember));

                    /*set cell settings*/
                    var settings = new Array();
                    settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                    settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                    settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                    settings.push(JSON.stringify({ readonly: true }));

                    $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 20 });
                });
            }
            else {
                $("#ApprovalGroupField").fadeOut(500, function ()
                {
                });

            }

        });

        $("#newmember").bind('click', function () {
            /*add a new approval member for the problem*/

            $("#table").table('addRow',
            {
                Member: '',
                MemberType: '',
                ApprovalStatusString: 'PENDING',
                ApprovalRemarks: '',
                Status: 3
            });

        });

        $("#closeBox").bind('click', function ()
        {
            $("#SearchCustomer").hide('800');
        });

        $("#PTYPclose").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#PTYPCancel").trigger('click');
            }
        });

        $("#CATclose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#CATCancel").trigger('click');
            }
        });

        $("#CATSave").bind('click', function ()
        {
            var isCategoryValid = Page_ClientValidate('Category');
            if (isCategoryValid) {
                if (!$("#validation_dialog_category").is(":hidden")) {
                    $("#validation_dialog_category").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {
                    $("#RiskCategorySaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

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
                                $("#RiskCategorySaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    $("#CATCancel").trigger('click');

                                    loadXMLRiskCategory();

                                });
                            },
                            error: function (xhr, status, error) {
                                $("#RiskCategorySaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                });
                            }
                        });
                    });
                }
            }
            else {
                $("#validation_dialog_category").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });

        $("#PTYPSave").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('Popup');
            if (isPageValid)
            {
                if (!$("#validation_dialog_popup").is(":hidden")) {
                    $("#validation_dialog_popup").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#ProblemTypeSaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        var type =
                        {
                            TypeName: $("#<%=TYPNMTxt.ClientID%>").val(),
                            Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(type) + "\'}",
                            url: getServiceURL().concat('createProblemType'),
                            success: function (data) {
                                $("#ProblemTypeSaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    $("#PTYPCancel").trigger('click');

                                    /*Load problem type*/
                                    loadProblemType();

                                });
                            },
                            error: function (xhr, status, error) {
                                $("#ProblemTypeSaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                });
                            }
                        });
                    });
                }  
            }
            else
            {
                $("#validation_dialog_popup").stop(true).hide().fadeIn(500, function ()
                {
                    
                });
            }
        });
        /*show organization unit box when hovering over originator, owner, and exective cboxes*/
        /*set the position according to mouse x and y coordination*/

        $("#<%=ORIGSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Originator');
            showORGDialog(e.pageX, e.pageY);

        });

        $("#<%=OWNRSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=EXESelect.ClientID%>").click(function (e) {
            $("#invoker").val('Executive');
            showORGDialog(e.pageX, e.pageY);
        });


        /*populate the employees in owner, originator, and executive cboxes*/
        $("#<%=ORGUNTCBox.ClientID%>").change(function ()
        {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            switch ($("#invoker").val())
            {
                case "Originator":
                    loadcontrols.push("#<%=ORGCBox.ClientID%>");
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORIG_LD");
                    break;
                case "Owner":
                    loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#OWNR_LD");
                    break;
                case "Executive":
                    loadcontrols.push("#<%=EXECBox.ClientID%>");
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EXE_LD");
                    break;
            }
            $("#SelectORG").hide('800');
        });

     
        /*close document type box*/
        $("#closedoc").bind('click', function () {
            $("#SelectDOC").hide('800');
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /*bind the details of the selected node*/
        $('#causetree').bind('tree.select', function (event) {
            // The clicked node is 'event.node'
            var node = event.node;

            if (node != null && node != false)
            {
                var isCausesValid = Page_ClientValidate('Causes');
                if (isCausesValid)
                {
                    ActivateTreeField(true);

                    $("#<%=CUSTTLTxt.ClientID%>").val(node.name);
                    $("#<%=PCUSTxt.ClientID%>").val(node.parent.name);
                    $("#<%=CUSDTLTxt.ClientID%>").html(node.Description).text();

                    /*attach ID to limit plugin*/
                    $("#<%=CUSTTLTxt.ClientID%>").limit({ id_result: 'CUSTTLlimit', alertClass: 'alertremaining', limit: 100 });
                }
                else
                {
                    alert("Please make sure that the details of the cause name is in the correct format");
                    event.preventDefault();
                }
            }
        });
        $("#<%=CUSTTLTxt.ClientID%>").keyup(function (event)
        {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                if ($(this).val() != '') {
                    if (node.Status == 3) {
                        $('#causetree').tree('updateNode', node, { name: $(this).val() });
                    }
                    else {
                        $('#causetree').tree('updateNode', node, { name: $(this).val(), Status: 2 });
                    }
                }
            }
            else {
                event.preventDefault();
            }
        });

        $("#<%=CUSDTLTxt.ClientID%>").keyup(function (event) {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status == 3) {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()) });
                }
                else {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()), Status: 2 });
                }
            }
            else {
                event.preventDefault();
            }
        });

        $("#delete").bind('click', function () {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {

                if (node.children.length > 0) {
                    alert("Cannot remove the cause (" + node.name + ") because there is/are (" + node.children.length + ") assciated sub cause(s) which must be removed first");
                }
                else if (node.getLevel() == 1) {
                    alert("At least a main cause should be included when creating a problem");
                }
                else {
                    if (node.Status == 3) {
                        $('#causetree').tree('removeNode', node);

                        ActivateTreeField(false);

                        /*clear number of character values of the tree fields*/
                        $("#CUSTTLlimit").html('');
                    }
                    else {
                        removeCause(node);
                    }
                }
            }
            else {
                alert('Please select a cause');
            }
        });

        /*Add new problem type*/
        $("#<%=PROBADD.ClientID%>").bind('click', function ()
        {
          
            resetGroup(".modalPanel");

            /*attach problem type to limit plugin*/
            $('#<%=TYPNMTxt.ClientID%>').limit({ id_result: 'TYPlimit', alertClass: 'alertremaining', limit: 90 });

            addWaterMarkText('The description of the problem type', '#<%=DESCTxt.ClientID%>');

            $("#<%=ptypealias.ClientID%>").trigger('click');
        });

        /*Add new risk category*/
        $("#<%=CATADD.ClientID%>").bind('click', function ()
        {
            resetGroup(".modalPanel");

            /*attach category name to limit plugin*/
            $('#<%=CATNMTxt.ClientID%>').limit({ id_result: 'CATNMlimit', alertClass: 'alertremaining', limit: 90 });

            addWaterMarkText('The description of the risk category', '#<%=RSKCATDESCTxt.ClientID%>');

            $("#<%=rskcatalias.ClientID%>").trigger('click');
        });

        $("#new").bind('click', function ()
        {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                $("#causetree").tree('appendNode',
                {
                    name: 'new sub cause',
                    Description: '',
                    Status: 3
                }, node);
            }
            else {
                alert('Please select a cause');
            }
        });

        /*Load Risk Sub-categories*/
        $("#<%=RSKCATCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadChecklist($(this).val());
            }
        });

        $("#<%=RISDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=ORGDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=TRGTCLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        /*Save changes*/
        $("#save").bind('click', function ()
        {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var isAdditionalValid = Page_ClientValidate('Additional');
                if (isAdditionalValid)
                {
                    if (!$("#validation_dialog_additional").is(":hidden"))
                    {
                        $("#validation_dialog_additional").hide();
                    }


                    /*the system cannot allow storing the default name for the root cause*/
                    var causes = $.parseJSON($('#causetree').tree('toJson'));
                    if (causes[0].name != 'new root cause') {

                        var result = confirm("Are you sure you would like to submit changes?");
                        if (result == true)
                        {
                            $find('<%= SaveExtender.ClientID %>').show();

                            var raisedate = getDatePart($("#<%=RISDTTxt.ClientID%>").val());
                            var origination = getDatePart($("#<%=ORGDTTxt.ClientID%>").val());
                            var target = getDatePart($("#<%=TRGTCLSDTTxt.ClientID%>").val());

                            var problem =
                            {
                                CaseNO: $("#<%=CaseNoTxt.ClientID%>").val(),
                                Title: $("#<%=PRMNMTxt.ClientID%>").val(),
                                ProblemType: $("#<%=PRBLCBox.ClientID%>").val(),
                                AffectedPartyType: $("#<%=AFFPRTTYPCBox.ClientID%>").val(),
                                AffectedDepartment: $("#<%=AFFPRTTYPCBox.ClientID%>").val() == "Internal" ? ($("#<%=AFFORGUNT.ClientID%>").val() == 0 || $("#<%=AFFORGUNT.ClientID%>").val() == null ? '' : $("#<%=AFFORGUNT.ClientID%>").val()) : "",
                                ExternalParty: $("#<%=AFFPRTTYPCBox.ClientID%>").val() == "External" ? ($("#<%=AFFPRTYTxt.ClientID%>").val() == 0 || $("#<%=AFFPRTYTxt.ClientID%>").val() == null ? '' : $("#<%=AFFPRTYTxt.ClientID%>").val()) : "",
                                AffectedDocument: ($("#<%=AFFCTDOCCBox.ClientID%>").val() == null || $("#<%=AFFCTDOCCBox.ClientID%>").val() == 0) ? '' : $("#<%=AFFCTDOCCBox.ClientID%>").val(),
                                Details: $("#<%=PRMDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=PRMDESCTxt.ClientID%>").val()),
                                Originator: $("#<%=ORGCBox.ClientID%>").val(),
                                Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                                Executive: $("#<%=EXECBox.ClientID%>").val(),
                                ReportDepartment: ($("#<%=REPFRMCBox.ClientID%>").val() == null || $("#<%=REPFRMCBox.ClientID%>").val() == 0) ? '' : $("#<%=REPFRMCBox.ClientID%>").val(),
                                ProblemRelatedDepartment: ($("#<%=RELORGCBox.ClientID%>").val() == null || $("#<%=RELORGCBox.ClientID%>").val() == 0) ? '' : $("#<%=RELORGCBox.ClientID%>").val(),
                                Severity: ($("#<%=SVRTCBox.ClientID%>").val() == null || $("#<%=SVRTCBox.ClientID%>").val() == 0) ? '' : $("#<%=SVRTCBox.ClientID%>").val(),
                                CustomerName: $("#<%=AFFPRTYTxt.ClientID%>").val(),
                                RaiseDate: new Date(raisedate[2], (raisedate[1] - 1), raisedate[0]),
                                OriginationDate: origination == '' ? null : new Date(origination[2], (origination[1] - 1), origination[0]),
                                TargetCloseDate: new Date(target[2], (target[1] - 1), target[0]),
                                RiskSubcategory: getChecklistJSON(),
                                Causes: causes,
                                Members: $("#table").table('getJSON')
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{'json':'" + JSON.stringify(problem) + "'}",
                                url: getServiceURL().concat('createProblem'),
                                success: function (data) {
                                    $find('<%= SaveExtender.ClientID %>').hide();

                                    showSuccessNotification(data.d);

                                    /*Obtain the latest case No.*/
                                    loadLastIDAjax('getLastCaseID', "#<%=CaseNoLbl.ClientID%>");

                                    resetGroup(".modulewrapper");

                                    refreshCauses();

                                    /*restore watermarks*/
                                    if (!$("#<%=PRMDESCTxt.ClientID%>").hasClass("watermarktext")) {
                                        addWaterMarkText('The Description of the Problem', '#<%=PRMDESCTxt.ClientID%>');
                                    }

                                    navigate("Details");
                                },
                                error: function (xhr, status, error) {
                                    $find('<%= SaveExtender.ClientID %>').hide();

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                }
                            });

                        }
                    }
                    else
                    {
                        alert("The name of the root cause cannot be set to the one specified by the system, and it should be therefore re-named");
                        navigate('Causes');
                    }
                }
                else
                {    
                    $("#validation_dialog_additional").stop(true).hide().fadeIn(500, function ()
                    {
                        
                        navigate('Additional');

                    });
                }
            }
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                {
                    
                    navigate('Details');

                });
            }
        });

        $("#tabul li").bind("click", function () {
            var isCausesValid = Page_ClientValidate('Causes');
            if (isCausesValid) {
                navigate($(this).attr("id"));
            }
            else {
                alert('Please make sure that the details of the cause name is in the correct format');
                return false;
            }

        });


        $("#<%=DOCSRCH.ClientID%>").click(function (e)
        {
            showDOCDialog(e.pageX, e.pageY);
        });

       
        
    });

    function loadXMLPartyType(loader, control)
    {
        $(loader).stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCustomerType"),
                success: function (data) {
                    $(loader).fadeOut(500, function ()
                    {
                        if (data)
                        {
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
                success: function (data) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
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
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function getChecklistJSON() {
        var checklist = new Array();
        $("#RSKCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function (index, value) {
                if ($(value).is(":checked") == true) {
                    var entity =
                    {
                        SubCategoryID: $(value).val()
                    };

                    checklist.push(entity);
                }
            });
        });
        if (checklist.length == 0)
            return null;

        return checklist;
    }

    function loadProblemType()
    {
        $("#PTYP_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemType"),
                success: function (data)
                {
                    $("#PTYP_LD").fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $("#<%=PRBLCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PTYP_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadChecklist(category)
    {
        $("#RSKCAT_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'categoryname':'" + category + "'}",
                url: getServiceURL().concat("loadSubcategories"),
                success: function (data) {
                    $("#RSKCAT_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var checklist = JSON.parse(data.d);
                            var html = '';

                            $("#RSKCHK").empty();

                            $(checklist).each(function (index, value) {
                                html += "<div class='checkitem'>"
                                html += "<input type='checkbox' id='" + value.SubCategoryID + "' name='checklist' value='" + value.SubCategoryID + "'/><div class='checkboxlabel'>" + value.name + "</div>";
                                html += "</div>"
                            });

                            $("#RSKCHK").append(html);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKCAT_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadSeverity()
    {
        $("#SVR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadSeverity"),
                success: function (data)
                {
                    $("#SVR_LD").fadeOut(500, function () {
                        if (data) {
                            /*Parse xml data and load severity cbox*/
                            loadComboboxXML($.parseXML(data.d), 'Severity', 'Criteria', "#<%=SVRTCBox.ClientID%>");
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#SVR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
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

    function loadRootCauses()
    {
        $("#RTCAUS_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRootCauses"),
                success: function (data)
                {
                    $("#RTCAUS_LD").fadeOut(500, function ()
                    {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Causes', 'name', $("#<%=RTCAUSCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RTCAUS_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadCauses(ID)
    {
        $("#cause_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            /*Deactivate all textboxes in the causes*/
            ActivateTreeField(false);

            /*clear number of character values of the tree fields*/
            $("#CUSTTLlimit").html('');

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeid':'" + ID + "'}",
                url: getServiceURL().concat('loadChildCauseTree'),
                success: function (data)
                {
                    $("#cause_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var existingjson = $('#causetree').tree('toJson');
                        if (existingjson == null)
                        {
                            $('#causetree').tree(
                            {
                                data: $.parseJSON(data.d),
                                slide: true,
                                autoOpen: true
                            });
                        }
                        else {
                            $('#causetree').tree('loadData', $.parseJSON(data.d));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#cause_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

        function refreshCauses()
        {
            /*Deactivate tree fields*/
            ActivateTreeField(false);

            /*clear number of character values of the tree fields*/
            $("#CUSTTLlimit").html('');

            var cause =
            [{
                name: 'new root cause',
                Description: '',
                Status: 3,
                children:
                [
                    { name: 'new sub cause', Status: 3, Description: '' }
                ]
            }];

            var existingjson = $('#causetree').tree('toJson');
            if (existingjson == null) {
                $('#causetree').tree(
                {
                    data: cause,
                    slide: true,
                    autoOpen: true
                });
            }
            else {
                $('#causetree').tree('loadData', cause);
            }
        }

        function showDOCDialog(x, y)
        {
            $("#SelectDOC").css({ left: x - 270, top: y + 20 });
            loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYP.ClientID%>", "#DOCTYP_LD");
            $("#SelectDOC").show();
        }

        function showORGDialog(x, y) {
            $("#SelectORG").css({ left: x - 300, top: y + 20 });
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
            $("#SelectORG").show();
        }

    function filterByType(type, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterCustomerByType'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function loadCustomers(empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadCustomers'),
                success: function (data)
                {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function loadGridView(data, empty)
    {
        var xmlCustomers = $.parseXML(data);

        var row = empty;

        $("#<%=gvCustomers.ClientID%> tr").not($("#<%=gvCustomers.ClientID%> tr:first-child")).remove();

        $(xmlCustomers).find("Customer").each(function (index, value) {
            $("td", row).eq(0).html($(this).attr("CustomerNo"));
            $("td", row).eq(1).html($(this).attr("CustomerType"));
            $("td", row).eq(2).html($(this).attr("CustomerName"));
            $("td", row).eq(3).html($(this).attr("EmailAddress"));

            $("#<%=gvCustomers.ClientID%>").append(row);

            $(row).bind('click', function () {
                $("#SearchCustomer").hide('800');
                $("#<%=AFFPRTYTxt.ClientID%>").val($(value).attr("CustomerName"));
            });

            row = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);
        });

    }
    function ActivateTreeField(isactive) {
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

    function removeCause(selectednode)
    {
        var result = confirm("Are you sure you would like to remove the selected cause?");
        if (result == true) {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeID':'" + selectednode.CauseID + "'}",
                url: getServiceURL().concat('removeCause'),
                success: function (data) {
                    var vals = $("#<%=RTCAUSCBox.ClientID%>").val().split(" ");
                    loadCauses(parseInt(vals[1]));
                },
                error: function (xhr, status, error) {
                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }
    }

    function resetTab() {
        //clear previously activated tabs
        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        //bind to the first tab
        $("#tabul li").removeClass("ctab");
        $("#Details").addClass("ctab");
        $("#DetailsTB").css('display', 'block');
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

    function showCustomerDialog(x, y, empty)
    {
        loadCustomers(empty);


        $("#SearchCustomer").css({ left: x - 420, top: y - 130 });
        $("#SearchCustomer").css({ width: 700, height: 250 });
        $("#SearchCustomer").show();
    }

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
</script>
</asp:Content>
