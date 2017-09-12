<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageProblems.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ManageProblems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Problem_Header" class="moduleheader">Manage Problems</div>

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
        
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byPRM">Filter by Problem Title</li>
                <li id="byPRMTYP">Filter by Problem Type</li>
                <li id="byORGIDT">Filter by Origination Date</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>

        <div id="StartdateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
            <div id="StartDateLabel" style="width:120px;">Origination Date:</div>
            <div id="StartDateField" style="width:270px; left:0; float:left;">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>
    
        <div id="ProblemContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ProblemNameLabel" style="width:100px;">Title:</div>
            <div id="ProblemNameField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="PRMNMFTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
            </div>
        </div>
    
        <div id="ProblemTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ProblemTypeFLabel" style="width:100px;">Problem Type:</div>
            <div id="ProblemtypeFField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="PRMTYPFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="PRMTYPF_LD" class="control-loader"></div>
        </div>

        <div id="RecordModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
            <div id="RecordModeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RECMODF_LD" class="control-loader"></div>
        </div>
    </div>

    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="../Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="PRMwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
   
        <div id="RAGTooltip" class="tooltip" style="margin-top:20px; background-color:transparent;">
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="RED" src="../Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: Problem has passed target close date.</p>
            </div>
        
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="GREEN" src="../Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: Problem is on schedule.</p>
            </div>
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="AMBER" src="../Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: Problem will be overdue soon.</p>
            </div>
        </div>	


        <asp:GridView id="gvProblems" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="CaseNo" HeaderText="Case No." />
            <asp:BoundField DataField="PRMTitle" HeaderText="Problem Title" />
            <asp:BoundField DataField="PRMType" HeaderText="Problem Type" />
            <asp:BoundField DataField="Originator" HeaderText="Originator" />
            <asp:BoundField DataField="OriginationDate" HeaderText="Origination Date" />
            <asp:BoundField DataField="TargetCloseDate" HeaderText="Target Close Date" />
            <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
        </Columns>
        </asp:GridView>
    </div>


    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
    <div id="header" class="modalHeader">Problem Details<span id="close" class="modalclose" title="Close">X</span></div>
        <div id="ProblemTooltip" class="tooltip">
            <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <ul id="tabul" style="margin-top:30px;">
            <li id="Details" class="ntabs">Main Information</li>
            <li id="Causes" class="ntabs">Related Causes</li>
            <li id="Additional" class="ntabs">Additional information</li>
            <li id="Supplementary" class="ntabs">Supplementary information</li>
        </ul>
        <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">
            
            <div id="validation_dialog_general" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="CaseNoLabel" class="requiredlabel">Case No:</div>
                <div id="CaseNoField" class="fielddiv" style="width:300px;">
                    <asp:TextBox ID="CaseNoTxt" runat="server" CssClass="readonly" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemTypeLabel" class="requiredlabel">Problem Type:</div>
                <div id="ProblemTypeField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="PRBLCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>

                <div id="PTYP_LD" class="control-loader"></div>
       
                <asp:RequiredFieldValidator ID="PRBLTxtVal" runat="server" Display="None" ControlToValidate="PRBLCBox" ErrorMessage="Select the type of the problem" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="PRBLVal" runat="server" ControlToValidate="PRBLCBox"
                Display="None" ErrorMessage="Select the type of the problem" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemTitleLabel" class="requiredlabel">Problem Title:</div>
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
                <div id="AffectedPartyLabel" class="requiredlabel">Affected Party:</div>
                <div id="AffectedPartyField" class="fielddiv" style="width:300px;">
                    <asp:TextBox ID="AFFPRTYTxt" runat="server" CssClass="readonly" Width="290px" ReadOnly="true"></asp:TextBox>
                </div>
                <span id="AFFPRTYSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
                <asp:RequiredFieldValidator ID="AFFPRTYVal" runat="server" Display="None" ControlToValidate="AFFPRTYTxt" ErrorMessage="Select the affected party" ValidationGroup="General"></asp:RequiredFieldValidator>
            </div>

            <div id="SearchCustomer" class="selectbox" style="width:600px; height:250px; top:130px; left:80px;">
                <div class="toolbox">
                    <img id="party_delete_filter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
                    <div id="party_filter_div">
                        <img id="party_filter" src="../Images/filter.png" alt=""/>
                        <ul class="contextmenu">
                            <li id="byPRTYTYP">Filter By Party Type</li>
                        </ul>
                    </div>
                
                    <div id="PartyTypeContainer" class="Customerfilter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                        <div id="PartyTypeLabel" style="width:120px;">Filter by Type:</div>
                        <div id="PartyTypeField" style="width:270px; left:0; float:left;">
                            <asp:DropDownList ID="PRTTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                            </asp:DropDownList>
                        </div>
                        <div id="PRTYP_LD" class="control-loader"></div>
                    </div>
                    <div id="closeBox" class="selectboxclose"></div>
                </div>       
                <div id="FLTR_LD" class="control-loader"></div> 
                <div id="scroll2" style="height:250px; width:96%; overflow:auto; margin-top:15px; float:left">
                    <asp:GridView id="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:BoundField DataField="CustomerNo" HeaderText="Customer No." />
                            <asp:BoundField DataField="CustomerType" HeaderText="Type" />
                            <asp:BoundField DataField="CustomerName" HeaderText="Name" />
                            <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemDescriptionLabel" class="labeldiv">Problem Description:</div>
                <div id="ProblemDescriptionField" class="fielddiv" style="width:400px; height:133px;">
                    <asp:TextBox ID="PRMDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="130px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="PRMDESCTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "PRMDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:135px;">
                <div id="ProblemStatusLabel" class="requiredlabel">Problem Status:</div>
                <div id="ProblemStatusField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="PRMSTSCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="PSTS_LD" class="control-loader"></div>
        
                <asp:RequiredFieldValidator ID="PRMSTStxtVal" runat="server" Display="None" ControlToValidate="PRMSTSCBox" ErrorMessage="Select the status of the problem" ValidationGroup="General"></asp:RequiredFieldValidator>
               
                <asp:CompareValidator ID="PRMSTSVal" runat="server" ControlToValidate="PRMSTSCBox"
                Display="None" ErrorMessage="Select the status of the problem" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
            </div>
        </div>      
        <div id="CausesTB" class="tabcontent" style="display:none;height:450px;">
        
            <div class="toolbox">
                <img id="undo" src="../Images/undo.png" class="imgButton" title="Undo Causes" alt="" />
                <img id="delete" src="../Images/deletenode.png" alt="" class="imgButton" title="Remove Selected Cause" />
                <img id="new" src="../Images/new_file.png" alt="" class="imgButton" title="New Child Cause"/>
            
                <div id="RootCauseContainer" style=" float:left;width:400px; margin-left:10px; height:20px; margin-top:3px;">
                    <div id="RootCauseLabel" style="width:100px;">Root Cause:</div>
                    <div id="RootCauseField" style="width:250px; left:0; float:left;">
                        <asp:DropDownList ID="RTCAUSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="RTCAUS_LD" class="control-loader"></div>
                </div>
            </div>

            <div id="treemenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible;height:370px;width:29%;">
                <div id="cause_LD" class="control-loader"></div> 
                <div id="causetree"></div>
            </div>
            <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; overflow:visible;height:370px;width:67%;">
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
        <div id="AdditionalTB" class="tabcontent" style="display:none;height:450px;">
            <div id="validation_dialog_additional" style="display: none">
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

                <asp:RequiredFieldValidator ID="ORGCBoxTxtVal" runat="server" Display="None" ControlToValidate="ORGCBox" ErrorMessage="Select the originator of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="ORGCBoxVal" runat="server" ControlToValidate="ORGCBox" ValidationGroup="Additional"
                Display="None" ErrorMessage="Select the originator of the problem" Operator="NotEqual" Style="position: static"
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

                <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select the owner of the problem"  ValidationGroup="Additional"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="OWNRCBoxVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="Additional"
                Display="None" ErrorMessage="Select the owner of the problem" Operator="NotEqual" Style="position: static"
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
            
                <asp:CompareValidator ID="EXECBoxVal" runat="server" ControlToValidate="EXECBox" ValidationGroup="Additional"
                Display="None" ErrorMessage="Select the executive of the problem" Operator="NotEqual" Style="position: static"
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
                    <div id="ORG_LD" class="control-loader"></div>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemRaiseDateLabel" class="requiredlabel">Raise Date:</div>
                <div id="ProblemRaiseDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="RISDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
                <asp:RequiredFieldValidator ID="RISDTVal" runat="server" Display="None" ControlToValidate="RISDTTxt" ErrorMessage="Enter the raise date of the problem"  ValidationGroup="Additional"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="RISDTTxtFVal" runat="server" ControlToValidate="RISDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>  
          
                <asp:CustomValidator id="RISDTTxtF2Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "RISDTTxt" Display="None" ErrorMessage = "Raise date should not be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="RISDTTxtF3Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "RISDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
  
            </div>   
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OriginationDateLabel" class="requiredlabel">Origination Date:</div>
                <div id="OriginationDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ORGDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
                <asp:RequiredFieldValidator ID="ORGDTTxtVal" runat="server" Display="None" ControlToValidate="ORGDTTxt" ErrorMessage="Enter the origination date of the problem"  ValidationGroup="Additional"></asp:RequiredFieldValidator>  
            
                <asp:RegularExpressionValidator ID="ORGDTTxtFval" runat="server" ControlToValidate="ORGDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>  
            
                <asp:CompareValidator ID="ORGDTVal" runat="server" ControlToCompare="RISDTTxt"  ValidationGroup="Additional"
                ControlToValidate="ORGDTTxt" ErrorMessage="Orgination date should be greater or equals raise date"
                Operator="GreaterThanEqual" Type="Date" Display="None"></asp:CompareValidator> 

                <asp:CustomValidator id="ORGDTF2Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "ORGDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator> 
            </div> 
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="TRGTCloseDateLabel" class="requiredlabel">Target Close Date:</div>
                <div id="TRGTCloseDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="TRGTCLSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
                <asp:RequiredFieldValidator ID="TRGTCLSDTVal" runat="server" Display="None" ControlToValidate="TRGTCLSDTTxt" ErrorMessage="Enter the target closing date of the problem"  ValidationGroup="Additional"></asp:RequiredFieldValidator>   
           
                <asp:RegularExpressionValidator ID="TRGTCLSDTTxtFval" runat="server" ControlToValidate="TRGTCLSDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>  
           
                <asp:CompareValidator ID="TRGTCLSDTFVal" runat="server" ControlToCompare="ORGDTTxt"  ValidationGroup="Additional"
                ControlToValidate="TRGTCLSDTTxt" ErrorMessage="Target closing date should be greater or equals origination date"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator>

                <asp:CustomValidator id="TRGTCLSDTF2Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "TRGTCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ACTUCloseDateLabel" class="labeldiv">Actual Close Date:</div>
                <div id="ACTUCloseDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ACTCLSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
         
                <asp:RegularExpressionValidator ID="ACTCLSDTVal" runat="server" ControlToValidate="ACTCLSDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>  

                <asp:CustomValidator id="ACTCLSDTF0Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "ACTCLSDTTxt" Display="None" ErrorMessage = "Actual close date shouldn't be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CompareValidator ID="ACTCLSDTF1Val" runat="server" ControlToCompare="ORGDTTxt"  ValidationGroup="Additional"
                ControlToValidate="ACTCLSDTTxt" ErrorMessage="Actual close date should be greater or equals origination date"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator> 

                <asp:CustomValidator id="ACTCLSDTF2Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "ACTCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator> 

            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewReportIssueDateLabel" class="labeldiv">Review Report Issue Date:</div>
                <div id="ReviewReportIssueDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="REVREPISSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      

                <asp:RegularExpressionValidator ID="REVREPISSDTFval" runat="server" ControlToValidate="REVREPISSDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>  
          
                <asp:CompareValidator ID="REVREPISSDTVal" runat="server" ControlToCompare="ORGDTTxt"  ValidationGroup="Additional"
                ControlToValidate="REVREPISSDTTxt" ErrorMessage="Review report date should be greater or equals origination date"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator>

                <asp:CustomValidator id="REVREPISSDTF2Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "REVREPISSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>
        </div>
        <div id="SupplementaryTB" class="tabcontent" style="display:none; height:450px;">
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
                <div id="ScoreLabel" class="labeldiv">Score:</div>
                <div id="ScoreField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="SCRTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                </div>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskCategoryLabel" class="labeldiv">Select Risk Category:</div>
                <div id="RiskCategoryField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="RSKCATCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="RSKCAT_LD" class="control-loader"></div> 
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskListLabel" class="labeldiv">Assciated Risk List:</div>
                <div id="RiskListField" class="fielddiv" style="width:250px">
                    <div id="RSKCHK" class="checklist"></div>
                </div>
            </div>
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>

    </asp:Panel>

    <input id="xmlseverity" type="hidden" value="" />
    <input id="problemID" type="hidden" value="" />
    <input id="invoker" type="hidden" value="" />

</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);
        var customerempty = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);

        /*load all problems in the system*/
        loadProblems(empty);

        $("#<%=RTCAUSCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var vals = $(this).val().split(" ");

                loadCauses(parseInt(vals[1]));
            }
        });

        /* Undo any loaded cause tree by refrshing it with a new and default tree*/
        $("#undo").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to undo all modified causes?");
            if (result == true)
            {
                /*load original cause tree*/
                bindCauses($("#problemID").val());

                loadRootCauses();
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

        $("#<%=ACTCLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function ()
            {}
        });

        $("#<%=REVREPISSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#byPRTYTYP").bind('click', function ()
        {
            loadComboboxAjax('loadCustomerType', "#<%=PRTTYPCBox.ClientID%>", "#PRTYP_LD");

            $("#PartyTypeContainer").show();

        });
        $("#byRECMOD").bind('click', function ()
        {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#<%=RECMODCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterByProblemMode($(this).val(), empty);
            }
        });

        $("#party_delete_filter").click(function ()
        {
            hideAllCustomerFilter();
            loadCustomers(customerempty);
        });

        $("#<%=PRTTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != -1) {
                filterCustomerByType($(this).val(), customerempty);
            }
        });

        $("#<%=AFFPRTYSelect.ClientID%>").hover(function ()
        {
            hideAllCustomerFilter();
            loadCustomers(customerempty);

            $("#SearchCustomer").show();
        });

        $("#closeBox").bind('click', function () {
            $("#SearchCustomer").hide('800');
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#refresh").bind('click', function () {
            hideAll();
            loadProblems(empty);
        });

        $("#deletefilter").bind('click', function () {
            hideAll();
            loadProblems(empty);
        });

        $("#byPRM").bind('click', function () {
            hideAll();
            /*Clear text value*/
            $("#<%=PRMNMFTxt.ClientID%>").val('');

            $("#ProblemContainer").show();

        });

        $("#byPRMTYP").bind('click', function () {
            hideAll();
           
            $("#ProblemTypeContainer").show();

            loadProblemType();
        });

        $("#byORGIDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#StartdateContainer").show();
        });
        /*filter by problem title*/
        $("#<%=PRMNMFTxt.ClientID%>").keyup(function () {
            filterByProblemTitle($(this).val(), empty);
        });

        /*filter by problem type*/
        $("#<%=PRMTYPFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByProblemType($(this).val(), empty);
            }
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


        $("#tabul li").bind("click", function () {
            var isCausesValid = Page_ClientValidate('Causes')
            if (isCausesValid) {
                navigate($(this).attr("id"));
            }
            else {
                alert('Please make sure that the details of the cause name is in the correct format');
                return false;
            }
        });

        /*Get severity score*/
        $("#<%=SVRTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var $combo = $(this);
                if ($("#xmlseverity").val() != '') {
                    var xmlSeverity = $.parseXML($("#xmlseverity").val());

                    $(xmlSeverity).find('Severity').each(function (index, severity) {
                        if ($(this).attr('Criteria') == $combo.val()) {
                            $("#<%=SCRTxt.ClientID%>").val($(this).attr('Score'));
                        }
                    });
                }
            }
        });

        /*Load Risk Sub-categories*/
        $("#<%=RSKCATCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadSubcategories($(this).val());
            }
        });

        /*bind the details of the selected node*/
        $('#causetree').bind('tree.select', function (event) {
            var node = event.node;

            if (node != null && node != false)
            {
                var isCausesValid = Page_ClientValidate('Causes')
                if (isCausesValid) {
                    ActivateTreeField(true);

                    $("#<%=CUSTTLTxt.ClientID%>").val(node.name);
                    $("#<%=PCUSTxt.ClientID%>").val(node.parent.name);
                    $("#<%=CUSDTLTxt.ClientID%>").html(node.Description).text();


                    /*attach ID to limit plugin*/
                    $("#<%=CUSTTLTxt.ClientID%>").limit({ id_result: 'CUSTTLlimit', alertClass: 'alertremaining', limit: 100 });

                }
                else {
                    alert('Please make sure that the details of the cause name is in the correct format');
                    return false;
                }
            }
        });
        $("#<%=CUSTTLTxt.ClientID%>").keyup(function (event) {
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

        /* delete a cause node*/
        $("#delete").bind('click', function () {
            var node = $('#causetree').tree('getSelectedNode');

            if (node != null && node != false) {
                if (node.children.length > 0) {
                    alert("Cannot remove the process(" + node.name + ") because there is/are (" + node.children.length + ") assciated cause(s) which must be removed first");
                }
                else if (node.getLevel() == 1) {
                    alert("At least a main cause should be included with a problem");
                }
                else
                {
                    if (node.Status == 3)
                    {
                        $('#causetree').tree('removeNode', node);
                    }
                    else
                    {
                        removeCause(node.CauseID, $("#problemID").val());
                    }

                    $("#CUSTTLlimit").html('');

                    ActivateTreeField(false);
                }
            }
            else {
                alert('Please select a cause');
            }
        });

        /*add new cause node*/
        $("#new").bind('click', function () {

            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                $("#causetree").tree('appendNode',
                {
                    name: 'new sub cause',
                    Description: '',
                    Status: 3
                }, node);
            }
            else
            {
                var json = $.parseJSON($('#causetree').tree('toJson'));
                if (json.length == 0)
                {
                    var cause =
                    [{
                        name: 'new root cause',
                        Description: '',
                        Status: 3
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
                else
                {
                    alert('Please select a cause');
                }
            }
        });

        /*show organization unit box when hovering over originator, owner, and exective cboxes*/
        /*set the position according to mouse x and y coordination*/

        $("#<%=ORIGSelect.ClientID%>").bind('click',function (e) {
            $("#invoker").val('Originator');
            showORGDialog(e.pageX, e.pageY);

        });

        $("#<%=OWNRSelect.ClientID%>").bind('click', function (e)
        {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=EXESelect.ClientID%>").bind('click', function (e) {
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

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /*save changes*/
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

                    var json = $.parseJSON($('#causetree').tree('toJson'));
                   
                    if (json.length > 0)
                    {
                        var result = confirm("Are you sure you would like to submit changes?");
                        if (result == true)
                        {

                            $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                                ActivateSave(false);

                                var raisedate = getDatePart($("#<%=RISDTTxt.ClientID%>").val());
                                var origination = getDatePart($("#<%=ORGDTTxt.ClientID%>").val());
                                var target = getDatePart($("#<%=TRGTCLSDTTxt.ClientID%>").val());
                                var actual = getDatePart($("#<%=ACTCLSDTTxt.ClientID%>").val());
                                var review = getDatePart($("#<%=REVREPISSDTTxt.ClientID%>").val());

                                var problem =
                                {
                                    ProblemType: $("#<%=PRBLCBox.ClientID%>").val(),
                                    CaseNO: $("#<%=CaseNoTxt.ClientID%>").val(),
                                    Title: $("#<%=PRMNMTxt.ClientID%>").val(),
                                    CustomerNo: $("#<%=AFFPRTYTxt.ClientID%>").val(),
                                    Details: $("#<%=PRMDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=PRMDESCTxt.ClientID%>").val()),
                                    Originator: $("#<%=ORGCBox.ClientID%>").val(),
                                    Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                                    Executive: $("#<%=EXECBox.ClientID%>").val(),
                                    ReportDepartment: ($("#<%=REPFRMCBox.ClientID%>").val() == null || $("#<%=REPFRMCBox.ClientID%>").val() == 0) ? '' : $("#<%=REPFRMCBox.ClientID%>").val(),
                                    ProblemRelatedDepartment: ($("#<%=RELORGCBox.ClientID%>").val() == null || $("#<%=RELORGCBox.ClientID%>").val() == 0) ? '' : $("#<%=RELORGCBox.ClientID%>").val(),
                                    Severity: ($("#<%=SVRTCBox.ClientID%>").val() == null || $("#<%=SVRTCBox.ClientID%>").val() == 0) ? '' : $("#<%=SVRTCBox.ClientID%>").val(),
                                    ProblemStatusString: $("#<%=PRMSTSCBox.ClientID%>").val(),
                                    CustomerName: $("#<%=AFFPRTYTxt.ClientID%>").val(),
                                    RaiseDate: new Date(raisedate[2], (raisedate[1] - 1), raisedate[0]),
                                    OriginationDate: new Date(origination[2], (origination[1] - 1), origination[0]),
                                    TargetCloseDate: new Date(target[2], (target[1] - 1), target[0]),
                                    ActualCloseDate: actual == '' ? null : new Date(actual[2], (actual[1] - 1), actual[0]),
                                    ReviewReportIssueDate: review == '' ? null : new Date(review[2], (review[1] - 1), review[0]),
                                    RiskSubcategory: getChecklistJSON(),
                                    Causes: JSON.parse($('#causetree').tree('toJson'))
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{'json':'" + JSON.stringify(problem) + "'}",
                                    url: getServiceURL().concat('updateProblem'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            alert(data.d);

                                            /*close modal popup extender*/
                                            $("#cancel").trigger('click');

                                            $("#refresh").trigger('click');
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
                            });
                        }
                    }
                    else
                    {
                        alert("At least one root cause should be added with the problem record");
                        navigate('Causes');
                    }
                }
                else
                {
                    $("#validation_dialog_additional").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                        navigate('Additional');

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

    });
    function getChecklistJSON() {
        var checklist = new Array();
        $("#RSKCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function (index, value) {
                var entity =
                {
                    SubCategoryID: $(value).attr('id'),
                    Status: $(value).val()
                };

                checklist.push(entity);

            });
        });
        if (checklist.length == 0)
            return null;

        return checklist;
    }
    function filterByDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#PRMwait").stop(true).hide().fadeIn(500, function ()
            {
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
                    url: getServiceURL().concat('filterProblemByOriginationDate'),
                    success: function (data)
                    {
                        $("#PRMwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(this).find('p').text("List of all current problems filtered where the origination date between " + startdate.format('dd/MM/yyyy') + " and " + enddate.format('dd/MM/yyyy') + ".Note: Closed, withdrawn, or archived problems cannot be modified");
                            });

                            /* show module tooltip */

                            $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).slideDown(800, 'easeOutBounce');
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#PRMwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByProblemMode(mode, empty) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterProblemByMode'),
                success: function (data)
                {
                    $("#PRMwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').text("List of all current problems filtered according to their mode. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }

                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PRMwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    });
                }
            });
        });
    }
    function filterByProblemType(type, empty)
    {
        $("#PRMwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterProblemBytype'),
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                      
                            $(this).find('p').text("List of all current problems filtered according to their type. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PRMwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByProblemTitle(title, empty)
    {
        $("#PRMwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat('filterProblemByName'),
                success: function (data)
                {
                    $("#PRMwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current problems filtered according to their title. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PRMwait").fadeOut(500, function () {

                        $("#FilterTooltip").fadeOut(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadProblems(empty) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadProblems'),
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').text("List of all current problems. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    });
                }
            });
        });
    }
  
    function removeCause(causeID, problemID)
    {
        var result = confirm("Are you sure you would like to remove the selected cause?");
        if (result == true)
        {
            $(".modalPanel").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeID':'" + causeID + "'}",
                url: getServiceURL().concat('removeCause'),
                success: function (data)
                {
                    $(".modalPanel").css("cursor", "default");

                    bindCauses(problemID);
                },
                error: function (xhr, status, error)
                {
                    $(".modalPanel").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
    }

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function loadGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvProblems.ClientID%> tr").not($("#<%=gvProblems.ClientID%> tr:first-child")).remove();

        $(xml).find("Problem").each(function (index, value) {
            /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
            var date = new Date();

            $("td", row).eq(0).html("<img id='icon_" + index + "' src='../RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('ProblemID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
            $("td", row).eq(1).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(2).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");

            $("td", row).eq(3).html($(this).attr("CaseNo"));
            $("td", row).eq(4).html($(this).attr("Title"));
            $("td", row).eq(5).html($(this).attr("ProblemType"));
            $("td", row).eq(6).html($(this).attr("Originator"));
            $("td", row).eq(7).html(new Date($(this).attr("OriginationDate")).format("dd/MM/yyyy"));
            $("td", row).eq(8).html(new Date($(this).attr("TargetCloseDate")).format("dd/MM/yyyy"));
            $("td", row).eq(9).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(10).html($(this).attr("ProblemStatus"));

            $("#<%=gvProblems.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function ()
                    {
                        $("#validation_dialog_general").hide();
                        $("#validation_dialog_additional").hide();

                        /*clear all fields*/
                        reset();

                        /*bind case number of the problem*/
                        $("#<%=CaseNoTxt.ClientID%>").val($(value).attr("CaseNo"));

                        /*bind problem type*/
                        bindProblemType($(value).attr("ProblemType"));

                        /*bind problem name*/
                        $("#<%=PRMNMTxt.ClientID%>").val(($(value).attr("Title")));

                        /* bind customer name*/
                        $("#<%=AFFPRTYTxt.ClientID%>").val($(value).attr('CustomerName'));

                        /*bind problem description*/
                        if ($(value).attr("Details") == '')
                        {
                            addWaterMarkText('The Details of the Problem', '#<%=PRMDESCTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=PRMDESCTxt.ClientID%>").hasClass("watermarktext"))
                            {
                                $("#<%=PRMDESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=PRMDESCTxt.ClientID%>").html($(value).attr("Details")).text();
                        }

                        /*bind originator*/
                        bindComboboxAjax('loadEmployees', '#<%=ORGCBox.ClientID%>', $(value).attr("Originator"), "#ORIG_LD");

                        /*bind owner*/
                        bindComboboxAjax('loadEmployees', '#<%=OWNRCBox.ClientID%>', $(value).attr("Owner"), "#OWNR_LD");

                        /*bind executive*/
                        bindComboboxAjax('loadEmployees', '#<%=EXECBox.ClientID%>', $(value).attr("Executive"), "#EXE_LD");

                        /* bind raise date*/
                        $("#<%=RISDTTxt.ClientID%>").val(new Date($(value).attr("RaiseDate")).format("dd/MM/yyyy"));

                        /* bind origination date*/
                        $("#<%=ORGDTTxt.ClientID%>").val(new Date($(value).attr("OriginationDate")).format("dd/MM/yyyy"));

                        /* bind target close date*/
                        $("#<%=TRGTCLSDTTxt.ClientID%>").val(new Date($(value).attr("TargetCloseDate")).format("dd/MM/yyyy"));

                        /* bind actual close date*/
                        $("#<%=ACTCLSDTTxt.ClientID%>").val($(value).find("ActualCloseDate").text() == '' ? '' : new Date($(value).find("ActualCloseDate").text()).format("dd/MM/yyyy"));

                        /* bind review report issue date*/
                        $("#<%=REVREPISSDTTxt.ClientID%>").val($(value).find("ReviewReportIssueDate").text() == '' ? '' : new Date($(value).find("ReviewReportIssueDate").text()).format("dd/MM/yyyy"));

                        /*bind problem status*/
                        bindComboboxAjax('loadProblemStatus', '#<%=PRMSTSCBox.ClientID%>', $(value).attr("ProblemStatus"), "#PSTS_LD");

                        /*bind reported from department*/
                        bindComboboxAjax('getOrganizationUnits', '#<%=REPFRMCBox.ClientID%>', $(value).attr("ReportDepartment"), "#REPORG_LD");

                        /*bind source of problem department*/
                        bindComboboxAjax('getOrganizationUnits', '#<%=RELORGCBox.ClientID%>', $(value).attr("ProblemRelatedDepartment"), "#SRCORG_LD");

                        /*bind severity value*/
                        bindSeverity($(value).attr('Severity'));

                        /*load risk category*/
                        loadXMLRiskCategory();

                        /*bind risk subcategories*/
                        loadXMLSubcategories($(value).attr('XMLSubcategories'));

                        /*bind causes*/
                        bindCauses($(value).attr("ProblemID"));

                        loadRootCauses();

                        /*Deactivate tree fields*/
                        ActivateTreeField(false);

                        /*Temporarly store problem ID*/
                        $("#problemID").val($(value).attr("ProblemID"));


                        /*attach problem name to limit plugin*/
                        $("#<%=PRMNMTxt.ClientID%>").limit({ id_result: 'PRMNMlimit', alertClass: 'alertremaining', limit: 100 });

                        $("#<%=PRMNMTxt.ClientID%>").keyup();

                        /*set default tab navigation*/
                        navigate("Details");

                        if ($(value).attr('ProblemStatus') == 'Closed' || $(value).attr('ProblemStatus') == 'Withdrawn') {
                            $("#ProblemTooltip").find('p').text("Changes cannot take place since the problem is " + $(value).attr('ProblemStatus'));

                            if ($("#ProblemTooltip").is(":hidden")) {
                                $("#ProblemTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else
                        {
                            $("#ProblemTooltip").hide();

                            /*enable all modal controls for editing*/
                            ActivateAll(true);
                        }
                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }
                else if ($(this).attr('id').search('delete') != -1)
                {
                    $(this).bind('click', function () {
                        removeProblem($(value).attr("CaseNo"), empty);
                    });
                }
            });
            row = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);
        });
    }

    function loadXMLRiskCategory() {

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
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function removeProblem(caseNo, empty)
    {
        var result = confirm('Removing the selected problem record might cause its related actions (if any) to be removed, do you want to continue?');
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

           $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               data: "{'caseNo':'" + caseNo + "'}",
               url: getServiceURL().concat('removeProblem'),
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

    function loadRootCauses()
    {
        $("#RTCAUS_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRootCauses"),
                success: function (data)
                {
                    $("#RTCAUS_LD").fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Causes', 'name', $("#<%=RTCAUSCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RTCAUS_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });

    }

    function loadProblemType()
    {
        $("#PRMTYPF_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemType"),
                success: function (data)
                {
                    $("#PRMTYPF_LD").fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $("#<%=PRMTYPFCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PRMTYPF_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function bindProblemType(type)
    {
        $("#PTYP_LD").stop(true).hide().fadeIn(500, function () {

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
                            bindComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', type, $("#<%=PRBLCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PTYP_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function bindCauses(ID)
    {
        $("#cause_LD").stop(true).hide().fadeIn(500, function ()
        {
            /*Deactivate all textboxes in the causes*/
            ActivateTreeField(false);

            /*clear number of character values of the tree fields*/
            $("#CUSTTLlimit").html('');

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'problemID':'" + ID + "'}",
                url: getServiceURL().concat('loadProblemCauses'),
                success: function (data)
                {
                    $("#cause_LD").fadeOut(500, function ()
                    {
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
                        else
                        {
                            $('#causetree').tree('loadData', $.parseJSON(data.d));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#cause_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadCauses(ID)
    {
        $("#cause_LD").stop(true).hide().fadeIn(500, function () {

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
                success: function (data) {
                    $("#cause_LD").fadeOut(500, function () {
                        var existingjson = $('#causetree').tree('toJson');
                        if (existingjson == null) {
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
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }


    function loadSubcategories(category)
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
                success: function (data)
                {
                    $("#RSKCAT_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            $("#RSKCHK").empty();

                            var checklist = JSON.parse(data.d);

                            $(checklist).each(function (index, value)
                            {
                                if (SubcategoryExists("#RSKCHK", value.name) == false)
                                {
                                    var html = '';
                                    html += "<div class='checkitem'>";
                                    html += "<input type='checkbox' id='" + value.SubCategoryID + "' name='checklist' value='" + 5 + "'/><div class='checkboxlabel'>" + value.name + "</div>";
                                    html += "</div>";

                                    $("#RSKCHK").append(html);

                                    $("#" + $(this).attr('SubCategoryID')).change(function () {
                                        if ($(this).is(":checked") == false) {
                                            if ($(this).val() == 3) {
                                                $(this).val(5);
                                            }
                                        }
                                        else {
                                            if ($(this).val() == 5) {
                                                $(this).val(3);
                                            }
                                        }
                                    });

                                }
                            });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RSKCAT_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function SubcategoryExists(control, subcat) {
        var found = false;

        $(control).children().each(function (index, value) {
            if ($(this).find('.checkboxlabel').text() == subcat) {
                found = true;
                return false;
            }
        });

        return found;
    }
    function loadXMLSubcategories(data) {
        var subcategory = $.parseXML(data);

        /*clear all previous values*/
        $("#RSKCHK").empty();

        $(subcategory).find('RiskSubcategory').each(function (index, value) {
            var html = '';
            html += "<div class='checkitem'>";
            html += "<input type='checkbox' id='" + $(this).attr('SubCategoryID') + "' name='checklist' value='" + $(this).attr('Status') + "'/><div class='checkboxlabel'>" + $(this).attr('SubCategory') + "</div>";
            html += "</div>";

            $("#RSKCHK").append(html);

            $("#" + $(this).attr('SubCategoryID')).prop('checked', true);

            $("#" + $(this).attr('SubCategoryID')).change(function () {
                if ($(this).is(":checked") == false) {
                    if ($(this).val() == 1) {
                        $(this).val(4);
                    }
                }
                else {
                    if ($(this).val() == 4) {
                        $(this).val(1);
                    }
                }
            });

        });
    }
    function filterCustomerByType(type, empty)
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

                        if (data) {
                            loadCustomerGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
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
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadCustomerGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function bindSeverity(name)
    {
        $("#SVR_LD").stop(true).hide().fadeIn(500, function () {

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
                            bindComboboxXML($.parseXML(data.d), 'Severity', 'Criteria', name, "#<%=SVRTCBox.ClientID%>");

                            /*Temporarly store the severity xml list*/
                            $("#xmlseverity").val(data.d);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#SVR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadCustomerGridView(data, empty)
    {
        var xmlCustomers = $.parseXML(data);

        var row = empty;

        $("#<%=gvCustomers.ClientID%> tr").not($("#<%=gvCustomers.ClientID%> tr:first-child")).remove();

        $(xmlCustomers).find("Customer").each(function (index, value)
        {
            $("td", row).eq(0).html($(this).attr("CustomerNo"));
            $("td", row).eq(1).html($(this).attr("CustomerType"));
            $("td", row).eq(2).html($(this).attr("CustomerName"));
            $("td", row).eq(3).html($(this).attr("EmailAddress"));

            $("#<%=gvCustomers.ClientID%>").append(row);

            $(row).bind('click', function ()
            {
                $("#SearchCustomer").hide('800');
                $("#<%=AFFPRTYTxt.ClientID%>").val($(value).attr("CustomerName"));
            });

            row = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);
        });
    }


    function hideAllCustomerFilter()
    {
        $(".Customerfilter").each(function () {
            $(this).css('display', 'none');
        });
    }
    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }

    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
            $(".modalPanel").children().each(function ()
            {

                $(".textbox").each(function () {
                    $(this).removeClass("textbox");
                    $(this).addClass("readonlycontrolled");
                    $(this).attr('readonly', true);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', true);
                });

                $(".combobox").each(function () {
                    $(this).attr('disabled', true);
                });

                $(".textremaining").each(function ()
                {
                    $(this).html('');
                });
            });

            $('#save').attr("disabled", true);
            $("#save").css({ opacity: 0.5 });

        }
        else {
            $(".modalPanel").children().each(function () {

                $(".readonlycontrolled").each(function () {
                    $(this).removeClass("readonlycontrolled");
                    $(this).addClass("textbox");
                    $(this).attr('readonly', false);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', false);
                });

                $(".combobox").each(function () {
                    $(this).attr('disabled', false);
                });
            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }

    function ActivateTreeField(isactive)
    {
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

    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 310, top: y -150 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
        $("#SelectORG").show();
    }
</script>
</asp:Content>
