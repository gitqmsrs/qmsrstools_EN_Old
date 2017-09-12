<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageRisk.aspx.cs" Inherits="QMSRSTools.RiskManagement.ManageRisk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byRSKTYP">Filter by Risk Type</li>
                <li id="byRSKMOD">Filter by Risk Mode</li>
                <li id="byRSKCAT">Filter by Risk Category</li>
                <li id="byRSKSTS">Filter by Risk Status</li>
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="byRD">Filter by Register Date</li>
                <li id="byCLSRDT">Filter by Closure Date</li>
                <li id="byDUEDT">Filter by Due Date</li>
            </ul>
        </div>
    </div>

    
        <div id="RiskStatusContainer" class="filter">
            <div id="RiskStatusFilterLabel" class="filterlabel">Risk Status:</div>
            <div id="RiskStatusFilterField" class="filterfield">
                <asp:DropDownList ID="RSKSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RSKSTSF_LD" class="control-loader"></div>
        </div>

        <div id="RiskTYPContainer" class="filter">
            <div id="RiskTYPFilterLabel" class="filterlabel">Risk Type:</div>
            <div id="RiskTYPFilterField" class="filterfield">
                <asp:DropDownList ID="RSKTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RSKTYPF_LD" class="control-loader"></div>
        </div>

        <div id="RiskModeContainer" class="filter">
            <div id="RiskModeFilterLabel" class="filterlabel">Risk Mode:</div>
            <div id="RiskModeFilterField" class="filterfield">
                <asp:DropDownList ID="RSKMODFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RSKMODF_LD" class="control-loader"></div>
        </div>

        <div id="RiskCategoryContainer" class="filter">
            <div id="RiskCategoryFilterLabel" class="filterlabel">Risk Category:</div>
            <div id="RiskCategoryFilterField" class="filterfield">
                <asp:DropDownList ID="RSKCATFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RSKCATF_LD" class="control-loader"></div>
        </div>

        <div id="RegisterDateContainer" class="filter">
            <div id="RegisterDateFilterLabel" class="filterlabel">Register Date:</div>
            <div id="RegisterDateFilterField" class="filterfield">
                <asp:TextBox ID="RDFDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="RDTDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="RDFDTFExt" runat="server" TargetControlID="RDFDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="RDTDTFExt" runat="server" TargetControlID="RDTDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>

         <div id="ClosureDateContainer" class="filter">
            <div id="ClosureDateFilterLabel" class="filterlabel">Closure Date:</div>
            <div id="ClosureDateFilterField" class="filterfield">
                <asp:TextBox ID="CLSRFDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label2" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="CLSRTDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="CLSRFDTFExt" runat="server" TargetControlID="CLSRFDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="CLSRTDTFExt" runat="server" TargetControlID="CLSRTDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>

         <div id="DueDateContainer" class="filter">
            <div id="DueDateFilterLabel" class="filterlabel">Due Date:</div>
            <div id="DueDateFilterField" class="filterfield">
                <asp:TextBox ID="DUEFDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label3" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="DUETDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="DUEFDTFExt" runat="server" TargetControlID="DUEFDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="DUETDTFExt" runat="server" TargetControlID="DUETDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>

        <div id="RecordModeContainer" class="filter">
            <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
            <div id="RecordModeField" class="filterfield">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RECMODF_LD" class="control-loader"></div>
        </div>

    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>

    <div id="RSKwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvRisks" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="RiskNo" HeaderText="Risk No." />
                <asp:BoundField DataField="RiskName" HeaderText="Risk Name" />
                <asp:BoundField DataField="RiskType" HeaderText="Risk Type" />
                <asp:BoundField DataField="RiskMode" HeaderText="Risk Mode" />
                <asp:BoundField DataField="RiskCategory" HeaderText="Category" />
                <asp:BoundField DataField="RegisterDate" HeaderText="Register Date" />
                <asp:BoundField DataField="ClosureDate" HeaderText="Closure Date" />
                <asp:BoundField DataField="Score" HeaderText="Score" />
                <asp:BoundField DataField="Status" HeaderText="Status" />    
                <asp:BoundField DataField="Mode" HeaderText="Record Mode" />       
            </Columns>
        </asp:GridView>
    </div>

    
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Risk Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div class="toolbox">
    
            <div id="RiskTypeLabel" style="width:100px; top:1px;">Risk Type:</div>
            <div id="RiskTypeField" style="width:250px; top:1px; float:left;">
                <asp:DropDownList ID="RSKTYPCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            
            <div id="RSKTYP_LD" class="control-loader"></div>
         
            <asp:RequiredFieldValidator ID="PRBLTxtVal" runat="server" Display="None" ControlToValidate="RSKTYPCBox" ErrorMessage="Select the type of the risk" ValidationGroup="Details"></asp:RequiredFieldValidator>
    
            <asp:CompareValidator ID="PRBLVal" runat="server" ControlToValidate="RSKTYPCBox"
            Display="None" ErrorMessage="Select the type of the risk" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Details"></asp:CompareValidator>
        </div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="RiskTooltip" class="tooltip">
            <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <ul id="tabul">
            <li id="Details" class="ntabs">Risk Information</li>
            <li id="Probability" class="ntabs">Risk Estimation</li>
        </ul>

        <div id="DetailsTB" class="tabcontent" style="display:none; height:460px;">

            <input id="RiskID" type="hidden" value="" />

            <div id="validation_dialog_details" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Details" />
            </div>
             
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="RiskNoLabel" class="requiredlabel">Risk No:</div>
                <div id="RiskNoField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="RiskNoTxt" runat="server" Width="140px" CssClass="readonly" ReadOnly="true"></asp:TextBox>
                </div> 
            </div>
          
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskNameLabel" class="requiredlabel">Risk Name:</div>
                <div id="RiskNameField" class="fielddiv" style="width:300px;">
                    <asp:TextBox ID="RSKNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
                </div>
                <div id="RSKNMlimit" class="textremaining"></div>
        
                <asp:RequiredFieldValidator ID="RSKNMVal" runat="server" Display="None" ControlToValidate="RSKNMTxt" ErrorMessage="Enter the name of the risk" ValidationGroup="Details"></asp:RequiredFieldValidator>

                <asp:CustomValidator id="RSKNMTxtFVal" runat="server" ValidationGroup="Details" 
                ControlToValidate = "RSKNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskModeLabel" class="requiredlabel">Risk Mode:</div>
                <div id="RiskModeField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="RSKMODCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>

                <div id="RSKMOD_LD" class="control-loader"></div>
                
                <asp:RequiredFieldValidator ID="RSKMODCBoxVal" runat="server" ControlToValidate="RSKMODCBox" ErrorMessage="Select the risk mode" Display="None" ValidationGroup="Details"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="RSKMODCBoxFVal" runat="server" ControlToValidate="RSKMODCBox" Display="None"  ValidationGroup="Details"
                ErrorMessage="Select the risk mode" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskCategoryLabel" class="requiredlabel">Risk Category:</div>
                <div id="RiskCategoryField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="RSKCATCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            
                <div id="RSKCAT_LD" class="control-loader"></div> 

                <asp:RequiredFieldValidator ID="RSKCATTxtVal" runat="server" ControlToValidate="RSKCATCBox" ErrorMessage="Select the category of the risk" Display="None" ValidationGroup="Details"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="RSKCATVal" runat="server" ControlToValidate="RSKCATCBox" Display="None"  ValidationGroup="Details"
                ErrorMessage="Select the category of the risk" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DateRegisteredDateLabel" class="requiredlabel">Date Registered:</div>
                <div id="DateRegisteredDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="REGDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
            
                <asp:RequiredFieldValidator ID="REGDTVal" runat="server" Display="None" ControlToValidate="REGDTTxt" ErrorMessage="Enter the date of the registration"  ValidationGroup="Details"></asp:RequiredFieldValidator>  
           
                <asp:RegularExpressionValidator ID="REGDTTxtFVal" runat="server" ControlToValidate="REGDTTxt"
                ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" Display="None" ValidationGroup="Details"></asp:RegularExpressionValidator>  
            
                <asp:CustomValidator id="REGDTTxtF2Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "REGDTTxt" Display="None" ErrorMessage = "the date of the registration should not be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="REGDTTxtF3Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "REGDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DueDateLabel" class="labeldiv">Due Date:</div>
                <div id="DueDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="DUDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
  
                <asp:RegularExpressionValidator ID="DUDTFVal" runat="server" ControlToValidate="DUDTTxt"
                ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" Display="None" ValidationGroup="Details"></asp:RegularExpressionValidator>  
                
                <asp:CustomValidator id="DUDTF2Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "DUDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>

                <asp:CompareValidator ID="DUDTF3Val" runat="server" ControlToValidate="DUDTTxt" ControlToCompare="REGDTTxt"
                ErrorMessage="Due date should be greater than or equals the registration date"  ValidationGroup="Details"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DateAssessedLabel" class="labeldiv">Date Assessed:</div>
                <div id="DateAssessedField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="DTASSDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
  
                <asp:RegularExpressionValidator ID="DTASSDTFVal" runat="server" ControlToValidate="DTASSDTTxt"
                ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" Display="None" ValidationGroup="Details"></asp:RegularExpressionValidator>  
                
                <asp:CustomValidator id="DTASSDTF2Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "DTASSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>

                <asp:CompareValidator ID="DTASSDTF3Val" runat="server" ControlToCompare="REGDTTxt"
                ControlToValidate="DTASSDTTxt" ErrorMessage="Date Assessed should be greater than or equals the registration date"  ValidationGroup="Details"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator>
                 
                <asp:CustomValidator id="DTASSDTF4Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "DTASSDTTxt" Display="None" ErrorMessage = "The date of the assessment shouldn't be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>
                 
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ClosureDateLabel" class="labeldiv">Closure Date:</div>
                <div id="ClosureDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="CLSRDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
  
                <asp:RegularExpressionValidator ID="CLSRDTFVal" runat="server" ControlToValidate="CLSRDTTxt"
                ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" Display="None" ValidationGroup="Details"></asp:RegularExpressionValidator>  
                
                <asp:CustomValidator id="CLSRDTF2Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "CLSRDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>

                <asp:CustomValidator id="CLSRDTF3Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "CLSRDTTxt" Display="None" ErrorMessage = "Closure date shouldn't be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskOwnerLabel" class="requiredlabel">Risk Owner:</div>
                <div id="RiskOwnerField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="OWNR_LD" class="control-loader"></div>

                <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
                <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select the owner of the risk" ValidationGroup="Details"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="OWNRCBoxVal" runat="server" ControlToValidate="OWNRCBox" Display="None"  ValidationGroup="Details"
                ErrorMessage="Select the owner of the risk" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CostCentreLabel" class="labeldiv">Cost Centre:</div>
                <div id="CostCentreField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="CSTCNTRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="CNTR_LD" class="control-loader"></div>       
           </div>

           <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OtherCostCentreLabel" class="labeldiv">Other Cost Centre:</div>
                <div id="OtherCostCentreField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="OCSTCNTRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="OCNTR_LD" class="control-loader"></div>  
           </div>


           <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DescriptionLabel" class="labeldiv">Description:</div>
                <div id="DescriptionField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="RSKDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="RSKDESCTxtVal" runat="server" ValidationGroup="Details" 
                ControlToValidate = "RSKDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:92px;">
                <div id="RiskStatusLabel" class="requiredlabel">Risk Status:</div>
                <div id="RiskStatusField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="RSKSTSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="RSKSTS_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="RSKSTSCBoxTxtVal" runat="server" Display="None" ControlToValidate="RSKSTSCBox" ErrorMessage="Select risk status" ValidationGroup="Details"></asp:RequiredFieldValidator>   
           
                <asp:CompareValidator ID="RSKSTSCBoxVal" runat="server" ControlToValidate="RSKSTSCBox"
                Display="None" ErrorMessage="Select risk status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Details"></asp:CompareValidator>
            </div>




        </div>
        <div id="ProbabilityTB" class="tabcontent" style="display:none; height:460px;">
            <div id="RiskEstimationTooltip" class="tooltip" style="margin-top:10px;">
                <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
                <p></p>
            </div>

            <div id="validation_dialog_risk" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary6" runat="server" CssClass="validator" ValidationGroup="Risk" />
            </div>
          
            <div id="validation_dialog_ohsashaccp" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary9" runat="server" CssClass="validator" ValidationGroup="OHSASHACCP" />
            </div>
            
            <div id="validation_dialog_ems" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary10" runat="server" CssClass="validator" ValidationGroup="EMS" />
            </div>

            <div id="RiskEstimationGroupHeader" class="groupboxheader">Risk Estimation Details</div>
            <div id="RiskEstimationGroupDetails" class="groupbox" style="height:auto;">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="ProbabilityLabel" class="requiredlabel">Probability:</div>
                    <div id="ProbabilityField" class="fielddiv" style="width:100px">
                        <asp:DropDownList ID="PROBCBox" AutoPostBack="false" runat="server" Width="100px" CssClass="combobox">
                        </asp:DropDownList>    
                    </div>
                
                    <img id="PROBEdit" src="/Images/edit.png" class="imgButton" alt="" title="Edit Probability Criteria"/>
                                        
                    <div id="PROB_LD" class="control-loader"></div>

                    <div id="ProbabilityValueLabel" class="labeldiv" style="width:200px;">Probability Value:</div>
                    <div id="ProbabilityValueField" class="fielddiv" style="width:150px;">
                        <asp:TextBox ID="PROBVALTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                    </div>
                    <div id="PROBVAL_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="PROBCBoxVal" runat="server" Display="None" ControlToValidate="PROBCBox" ErrorMessage="Select the probability percentage" ValidationGroup="Probability"></asp:RequiredFieldValidator>         
        
                    <asp:CompareValidator ID="PROBCBoxTxtVal" runat="server" ControlToValidate="PROBCBox" Display="None" ValidationGroup="Probability"
                    ErrorMessage="Select the probability percentage" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0"></asp:CompareValidator>
                
                </div>

                <div id="RiskGeneralEstimationGroupHeader" class="groupboxheader">Risk Estimation for Organizational, Projects, and Issue Risk Types</div>
                <div id="RiskGeneralEstimationGroup" class="groupbox" style="height:auto;">

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="ORIRiskTypeLabel" class="labeldiv">ORI Risk Type:</div>
                        <div id="ORIRiskTypeField" class="fielddiv" style="width:auto;">
                            <asp:RadioButton  ID="ProjectRB" GroupName="ORIRiskType" CssClass="radiobutton" Text="Project" runat="server" />
                            <asp:RadioButton  ID="OrganizationalRB" GroupName="ORIRiskType" CssClass="radiobutton" Text="Organizational" runat="server" />
                        </div>     
                    </div>

                    <div id="project" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                        <div id="ProjectLabel" class="labeldiv">Project:</div>
                        <div id="ProjectField" class="fielddiv" style="width:250px">
                            <asp:DropDownList ID="PROJCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                            </asp:DropDownList>   
                        </div>
                        <div id="PROJ_LD" class="control-loader"></div>

                        <asp:RequiredFieldValidator ID="PROJTxtVal" runat="server" Display="None" ControlToValidate="PROJCBox" ErrorMessage="Select a Project" ValidationGroup="Project"></asp:RequiredFieldValidator> 

                        <asp:CompareValidator ID="PROJTxtFVal" runat="server" ControlToValidate="PROJCBox" Display="None" ValidationGroup="Project"
                        ErrorMessage="Select a Project" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="TimeImpactLabel" class="requiredlabel">Time Impact:</div>
                        <div id="TimeImpactField" class="fielddiv" style="width:100px;">
                            <asp:DropDownList ID="TIMPCBox" AutoPostBack="false" Width="100px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                    
                        <div id="TIMP_LD" class="control-loader"></div>
                    
                        <div id="TimeProbabilityLabel" class="labeldiv">Probability Value:</div>
                        <div id="TimeProbabilityField" class="fielddiv" style="width:100px">
                            <asp:TextBox ID="TPROBTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                        </div>

                        <div id="TIMPVAL_LD" class="control-loader"></div>
                    
                        <img id="TPROB_Help" src="/Images/help.png" class="searchactive" style="margin-left:10px;" alt="" title="Maintain Probability Percentage Matrix"/>
                    
                        <asp:RequiredFieldValidator ID="TPROBVal" runat="server" Display="None" ControlToValidate="TPROBTxt" ErrorMessage="Select the probability percentage of the time impact" ValidationGroup="Risk"></asp:RequiredFieldValidator> 
           
                    </div>
                    
                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="CostImpactLabel" class="requiredlabel">Cost Impact:</div>
                        <div id="CostImpactField" class="fielddiv" style="width:100px;">
                            <asp:DropDownList ID="CIMPCBox" AutoPostBack="false" Width="100px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div> 
                   
                        <div id="CIMP_LD" class="control-loader"></div>
                    
                        <div id="CostProbabilityLabel" class="labeldiv">Probability Value:</div>
                        <div id="CostProbabilityField" class="fielddiv" style="width:100px">
                            <asp:TextBox ID="CPROBTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                        </div>

                        <div id="CIMPVAL_LD" class="control-loader"></div>
                    

                        <asp:RequiredFieldValidator ID="CPROBVal" runat="server" Display="None" ControlToValidate="CPROBTxt" ErrorMessage="Select the probability percentage of the cost impact" ValidationGroup="Risk"></asp:RequiredFieldValidator> 
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="QOSImpactLabel" class="requiredlabel">QOS Impact:</div>
                        <div id="QOSImpactField" class="fielddiv" style="width:100px;">
                            <asp:DropDownList ID="QOSIMPCBox" AutoPostBack="false" Width="100px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                   
                        <div id="QOSIMP_LD" class="control-loader"></div>
                    
                        <div id="QOSProbabilityLabel" class="labeldiv">Probability Value:</div>
                        <div id="QOSProbabilityField" class="fielddiv" style="width:100px">
                            <asp:TextBox ID="QOSPROBTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                        </div>

                        <div id="QOSIMPVAL_LD" class="control-loader"></div>
                    
                        <asp:RequiredFieldValidator ID="QOSPROBVal" runat="server" Display="None" ControlToValidate="QOSPROBTxt" ErrorMessage="Select the probability percentage of the QOS impact" ValidationGroup="Risk"></asp:RequiredFieldValidator> 
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="StandardImpactCostLabel" class="labeldiv">Standard Cost of Impact:</div>
                        <div id="StandardImpactCostField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="STDIMPCOSTTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                        </div>
                    
                        <img id="STDIMPEdit" src="/Images/edit.png" class="imgButton" alt="" title="Edit Standard Impact Cost Criteria"/>
                        
                        <div id="StandardExposureLabel" class="labeldiv">Exposure:</div>
                        <div id="StandardExposureField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="STDEXPTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                        </div>
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="AdjustedImpactCostLabel" class="labeldiv">Adjusted Cost of Impact:</div>
                        <div id="AdjustedImpactCostField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="ADJIMPCOSTTxt" runat="server" Width="140px" CssClass="textbox"></asp:TextBox>
                        </div>
                    
                        <asp:RegularExpressionValidator ID="ADJIMPCOSTTxtFVal" runat="server" ControlToValidate="ADJIMPCOSTTxt"
                        Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="Risk"></asp:RegularExpressionValidator>  
    
         
                        <div id="AdjustedExposureLabel" class="labeldiv">Exposure:</div>
                        <div id="AdjustedExposureField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="ADJEXPTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div id="OHSASHACCPGroupHeader" class="groupboxheader">Risk Estimation for OHSAS & HACCP Risk Types</div>
                <div id="OHSASHACCPGroup" class="groupbox" style="height:100px;"> 
                
                    <div style="float:left; width:100%; height:20px; margin-top:10px;">
                        <div id="SeverityLabel" class="requiredlabel">Severity Criteria:</div>
                        <div id="SeverityField" class="fielddiv" style="width:250px;">
                            <asp:DropDownList ID="SVRTCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                    
                        <div id="SVR_LD" class="control-loader"></div>


                        <div id="CriticalLimitLabel" class="requiredlabel" style="width:80px;">Critical Limit:</div>
                        <div id="CriticalLimitField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="OPRCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                            </asp:DropDownList>

                            <div id="OPR_LD" class="control-loader"></div>
                    
                            <asp:Label ID="LMslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="LMTTxt" runat="server" Width="90px" CssClass="textbox"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="LMTTxtVal" runat="server" Display="None" ControlToValidate="LMTTxt" ErrorMessage="Select the critical limit value" ValidationGroup="OHSASHACCP"></asp:RequiredFieldValidator> 
           
                            <asp:RegularExpressionValidator ID="LMTTxtFVal" runat="server" ControlToValidate="LMTTxt"
                            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="OHSASHACCP"></asp:RegularExpressionValidator>  
    
                            <asp:RequiredFieldValidator ID="OPRCTxtVal" runat="server" Display="None" ControlToValidate="OPRCBox" ErrorMessage="Select the sign of the critical limit" ValidationGroup="OHSASHACCP"></asp:RequiredFieldValidator>         
        
                            <asp:CompareValidator ID="OPRCVal" runat="server" ControlToValidate="OPRCBox" Display="None" ValidationGroup="OHSASHACCP"
                            ErrorMessage="Select the sign of the critical limit" Operator="NotEqual" Style="position: static"
                            ValueToCompare="0"></asp:CompareValidator>
                        </div>
                    </div>

                    <div style="float:left; width:100%; height:20px; margin-top:15px;">     
                        <div id="SeverityValueLabel" class="labeldiv">Severity Score:</div>
                        <div id="SeverityValueField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="SVRVALTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                        </div>

                        <%--<asp:RequiredFieldValidator ID="SVRVALTxtVal" runat="server" Display="None" ControlToValidate="SVRVALTxt" ErrorMessage="Select the score of the severity" ValidationGroup="OHSASHACCP"></asp:RequiredFieldValidator>--%> 
           
                    </div>
                </div>

                <div id="EMSGroupHeader" class="groupboxheader">Risk Estimation for EMS Risk Types</div>
                <div id="EMSGroup" class="groupbox" style="height:305px;">

                    <div style="float:left; width:100%; height:20px; margin-top:10px;">
                        <div id="SeverityEnvironmentLabel" class="requiredlabel" style="width:200px;">Severity of Impact on Env.:</div>
                        <div id="SeverityEnvironmentField" class="fielddiv" style="width:200px;">
                            <asp:DropDownList ID="SVRENVCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                 
                        <div id="SVRENV_LD" class="control-loader"></div>

                        <div id="SeverityEnvironmentValueLabel" class="labeldiv">Severity Score:</div>
                        <div id="SeverityEnvironmentValueField" class="fielddiv">
                            <asp:TextBox ID="SVRENVValTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                        </div>
                    
                        <asp:RequiredFieldValidator ID="SVRENVValTxtVal" runat="server" Display="None" ControlToValidate="SVRENVValTxt" ErrorMessage="Select the value of the sevrity of impact on environment" ValidationGroup="EMS"></asp:RequiredFieldValidator>         
        
                   </div>
                
                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="SeverityHumanLabel" class="requiredlabel" style="width:200px;">Severity of Impact on Human:</div>
                        <div id="SeverityHumanField" class="fielddiv" style="width:200px;">
                            <asp:DropDownList ID="SVRHUMCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                 
                        <div id="SVRHUM_LD" class="control-loader"></div>

                        <div id="SeverityHumanScoreLabel" class="labeldiv">Severity Score:</div>
                        <div id="SeverityHumanScoreField" class="fielddiv">
                            <asp:TextBox ID="SVRHUMValTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="SVRHUMValTxtVal" runat="server" Display="None" ControlToValidate="SVRHUMValTxt" ErrorMessage="Select the value of the sevrity of impact on human" ValidationGroup="EMS"></asp:RequiredFieldValidator>         
       
                   </div>

                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="ComplexityOperationalLabel" class="requiredlabel" style="width:200px;">Complexity of Operational Controls:</div>
                        <div id="ComplexityOperationalField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="COMPOPRCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                            
                            <asp:Label ID="Label4" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="COMPOPRSCRTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox> 
            
                        </div>
                        <div id="COMPOPR_LD" class="control-loader"></div>

                        <span id="COMPOPRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
                        
                        <asp:RequiredFieldValidator ID="COMPOPRTxtVal" runat="server" Display="None" ControlToValidate="COMPOPRCBox" ErrorMessage="Select the score of the operational complexity" ValidationGroup="EMS"></asp:RequiredFieldValidator>      
                   
                        <asp:CompareValidator ID="COMPOPRVal" runat="server" ControlToValidate="COMPOPRCBox" Display="None" ValidationGroup="EMS"
                        ErrorMessage="Select the score of the operational complexity" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                   
                   </div>
               
             
                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="LegalRegularityLabel" class="labeldiv" style="width:200px;">Legal/Regulatory Requirements:</div>
                        <div id="LegalRegularityField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="LRRCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                            
                            <asp:Label ID="Label5" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="LRRValTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox> 
                 
                        </div>
                        <div id="LRR_LD" class="control-loader"></div>

                        <span id="LRRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>    
                    
                   </div>
                    
                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="NuisanceLabel" class="labeldiv" style="width:200px;">Nuisance:</div>
                        <div id="NuisanceField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="NuisanceCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                           
                            <asp:Label ID="Label6" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="NuisanceValTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox> 
              
                        </div>

                        <div id="Nuisance_LD" class="control-loader"></div>

                        <span id="NuisanceSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
                    
                   </div>

                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="InterestedPartiesLabel" class="labeldiv" style="width:200px;">Interested Parties:</div>
                        <div id="InterestedPartiesField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="INTPRTCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                           
                            <asp:Label ID="Label7" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="INTPRTValTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox> 
              
                        </div>
                       <div id="INTPRT_LD" class="control-loader"></div>

                        <span id="INTPRTSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
                    
                   </div>
               
                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="LackInformationLabel" class="labeldiv" style="width:200px;">Lack of Information:</div>
                        <div id="LackInformationField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="LINFOCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                           
                            <asp:Label ID="Label8" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="LINFOValTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox> 
                        </div>
                        <div id="LINFO_LD" class="control-loader"></div>
                        <span id="LINFOSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
                   </div>

                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="PolicyIssuesLabel" class="labeldiv" style="width:200px;">Policy Issues:</div>
                        <div id="PolicyIssuesField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="PLCYISSUCBox" AutoPostBack="false" Width="200px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                           
                            <asp:Label ID="Label9" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="PLCYISSUValTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox> 
                    
                        </div>
                        <div id="PLCYISSU_LD" class="control-loader"></div>
                        <span id="PLCYISSUSelect" class="searchactive" style="margin-left:10px" runat="server"></span> 
                   </div>
                    
                   <div style="float:left; width:100%; height:20px; margin-top:15px;">
                        <div id="SignRatingLabel" class="labeldiv" style="width:200px;">Significant Rating:</div>
                        <div id="SignRatingField" class="fielddiv" style="width:150px">
                            <asp:TextBox ID="SGNRATTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                        </div>  
                    
                        <img id="SGNRAT_Help" src="/Images/help.png" class="searchactive" style="margin-left:10px;" alt="" title="Maintain Significant Rating Criteria"/>   
                   
                    
                        <div id="EMSCriticalLimitsLabel" class="requiredlabel" style="width:80px;">Critical Limit:</div>
                        <div id="EMSCriticalLimitsField" class="fielddiv" style="width:auto;">
                            <asp:DropDownList ID="EMSOPRCbox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                            </asp:DropDownList>

                            <div id="EMSOPR_LD" class="control-loader"></div>
                    
                            <asp:Label ID="EMSLMslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                            <asp:TextBox ID="EMSLMTTxt" runat="server" Width="90px" CssClass="textbox"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="EMSLMTVal" runat="server" Display="None" ControlToValidate="EMSLMTTxt" ErrorMessage="Select the critical limit value" ValidationGroup="EMS"></asp:RequiredFieldValidator> 
           
                            <asp:RegularExpressionValidator ID="EMSLMTTxtFVal" runat="server" ControlToValidate="EMSLMTTxt"
                            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="EMS"></asp:RegularExpressionValidator>  
   
                            <asp:RequiredFieldValidator ID="EMSOPRTxtVal" runat="server" Display="None" ControlToValidate="EMSOPRCbox" ErrorMessage="Select the sign of the critical limit" ValidationGroup="EMS"></asp:RequiredFieldValidator>         
        
                            <asp:CompareValidator ID="EMSOPRVal" runat="server" ControlToValidate="EMSOPRCbox" Display="None" ValidationGroup="EMS"
                            ErrorMessage="Select the sign of the critical limit" Operator="NotEqual" Style="position: static"
                            ValueToCompare="0"></asp:CompareValidator>
                        </div>      
                    </div>
               
                   
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:30px;">
                    <div id="RiskScoreLabel" class="requiredlabel">Risk Score:</div>
                    <div id="RiskScoreField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="RSKSCRTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    </div> 
                
                    <div id="RSKSCR_LD" class="control-loader"></div> 
                </div>
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
        
        <div id="SelectAssessment" class="selectbox">
            <div id="guidclosebox" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="AssessmentCategoryFLabel" class="labeldiv" style="width:110px;">Assessment Category:</div>
                <div id="AssessmentCategoryFField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="ACATFCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ACAT_LD" class="control-loader"></div>
            </div>
        </div> 
            
        <div id="EditProbabilityMatrix" class="selectbox" style="width:700px; height:300px;">
            <div class="toolbox">
                <img id="pmsave" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" /> 
                <div id="pmclosebox" class="selectboxclose"></div>
            </div>
      
             <div id="ProbabilityMatrixTooltip" class="tooltip" style="margin-top:10px;">
                <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
                <p></p>
	        </div>
       
            <div id="ProbabilityMatrixSaveTooltip" class="tooltip">
                <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
                <p>Saving...</p>
	        </div>

            <div id="Matrixwait" class="loader">
                <div class="waittext">Retrieving Data, Please Wait...</div>
            </div>

            <table id="matrix" class="table" ></table>
          
        </div>

        <div id="EditProbability" class="selectbox" style="width:700px; height:300px;">
            <div class="toolbox">
                <img id="psave" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" /> 
                <div id="pclosebox" class="selectboxclose"></div>
            </div>

            <div id="PercentageProbabilityTooltip" class="tooltip" style="margin-top:10px;">
                <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
                <p></p>
	        </div>
       
            <div id="PercentageProbabilitySaveTooltip" class="tooltip">
                <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
                <p>Saving...</p>
	        </div>

            <div id="PPwait" class="loader">
                <div class="waittext">Retrieving Data, Please Wait...</div>
            </div>
         
            <div id="table" class="table" style=" margin-top:10px; display:none;">
                <div id="row_header" class="tr">
                    <div id="col0_head" class="tdh" style="width:50px;"></div>
                    <div id="col1_head" class="tdh" style="width:30%">Risk Probability Criteria</div>
                    <div id="col2_head" class="tdh" style="width:30%">Probability Value</div>
                </div>
            </div>
        </div>

        <div id="EditSTDCostImpact" class="selectbox" style="width:700px; height:300px;">
            <div class="toolbox">
                <img id="stdsave" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" /> 
                <div id="stdclosebox" class="selectboxclose"></div>
            </div>
            
            <div id="STDCostImpactCriteriaTooltip" class="tooltip" style="margin-top:10px;">
                <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
                <p></p>
	        </div>

            <div id="STDCostImpactCriteriaSaveTooltip" class="tooltip">
                <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
                <p>Saving...</p>
	        </div>
        
            <div id="STDCostwait" class="loader">
                <div class="waittext">Retrieving Data, Please Wait...</div>
            </div>
        
            <div id="STDcost" class="table" style=" margin-top:10px; display:none;">
                <div id="STDcost_row_header" class="tr">
                    <div id="STDcost_col0_head" class="tdh" style="width:50px;"></div>
                    <div id="STDcost_col1_head" class="tdh" style="width:30%">Cost of Impact Criteria</div>
                    <div id="STDcost_col2_head" class="tdh" style="width:30%">Standard Cost</div>
                </div>
            </div>
      
        </div>
        
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
         </div>
    </asp:Panel>

</div>
<input id="ASGMODE" type="hidden" value="" />
<input id="riskparam" type="hidden" value="" />

<script type="text/javascript" language="javascript">

    $(function ()
    {
        var empty = $("#<%=gvRisks.ClientID%> tr:last-child").clone(true);
     
        var riskparam =
        {
            TimeImpact: '',
            CostImpact: '',
            QOSImpact: '',
            AdjustedCostOfImpact: parseFloat(0),
            Severity: '',
            SeverityHuman: '',
            SeverityEnvironment: '',
            OperationalComplexity: '',
            Nusiance: '',
            Regularity: '',
            InterestedParties: '',
            LackInformation: '',
            PolicyIssue: ''
        }

        /*store the parameters of the risk in the hidden storage*/
        $("#riskparam").val(JSON.stringify(riskparam));

        /*get all risk list*/
        loadRisks(empty);

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /*close assessment guidline category box*/
        $("#guidclosebox").bind('click', function ()
        {
            $("#SelectAssessment").hide('800');
        });

        /*close probability dialog*/
        $("#pclosebox").bind('click', function () {
            $("#EditProbability").hide('800');
        });


        /*close probability matrix dialog*/
        $("#pmclosebox").bind('click', function () {
            $("#EditProbabilityMatrix").hide('800');
        });

        /*close std cost impact dialog*/
        $("#stdclosebox").bind('click', function () {
            $("#EditSTDCostImpact").hide('800');
        });

        $("#<%=COMPOPRSelect.ClientID%>").bind('click', function (e)
        {
            /*set value for operational complexity field*/
            $("#ASGMODE").val("Complexity");

            showAssessmentGuide(e.pageX, e.pageY);
        });

        $("#<%=LRRSelect.ClientID%>").bind('click', function (e) {
            /*set value for Legal & Regularity requirement field*/
            $("#ASGMODE").val("Legal");

            showAssessmentGuide(e.pageX, e.pageY);
        });

        $("#<%=NuisanceSelect.ClientID%>").bind('click', function (e) {
            /*set value for Nuisance field*/
            $("#ASGMODE").val("Nuisance");

            showAssessmentGuide(e.pageX, e.pageY);
        });

        $("#<%=INTPRTSelect.ClientID%>").bind('click', function (e) {
            /*set value for interested parties field*/
            $("#ASGMODE").val("Party");

            showAssessmentGuide(e.pageX, e.pageY);
        });

        $("#<%=LINFOSelect.ClientID%>").bind('click', function (e) {
            /*set value for lack of information field*/
            $("#ASGMODE").val("Information");

            showAssessmentGuide(e.pageX, e.pageY);
        });

        $("#<%=PLCYISSUSelect.ClientID%>").bind('click', function (e) {
            /*set value for policy issues field*/
            $("#ASGMODE").val("Policy");

            showAssessmentGuide(e.pageX, e.pageY);
        });

        $("#refresh").bind('click', function () {
            hideAll();
            loadRisks(empty);
        });

        $("#byRSKTYP").bind('click', function ()
        {
            hideAll();

            $("#RiskTYPContainer").show();

            /*load risk type*/
            loadComboboxAjax('loadRiskType', "#<%=RSKTYPFCBox.ClientID%>", "#RSKTYPF_LD");
        });

        $("#byRSKSTS").bind('click', function () {
            hideAll();

            $("#RiskStatusContainer").show();

            /*load risk status*/
            loadComboboxAjax('loadRiskStatus', "#<%=RSKSTSFCBox.ClientID%>", "#RSKSTSF_LD");

        });

        $("#byRSKMOD").bind('click', function () {
            hideAll();

            $("#RiskModeContainer").show();

            /*load risk mode*/
            loadComboboxAjax('loadRiskMode', "#<%=RSKMODFCBox.ClientID%>", "#RSKMODF_LD");

        });

        $("#byRSKCAT").bind('click', function () {
            hideAll();

            $("#RiskCategoryContainer").show();

            /*load risk category*/

            loadRiskCategory("#<%=RSKCATFCBox.ClientID%>", "#RSKCATF_LD");
        });


        $("#byRECMOD").bind('click', function () {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#byRD").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=RDFDTFTxt.ClientID%>").val('');
            $("#<%=RDTDTFTxt.ClientID%>").val('');

            $("#RegisterDateContainer").show();
        });

        $("#<%=REGDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=DUDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=DTASSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });


        $("#<%=CLSRDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });
        

        /*filter by registration date range*/
        $("#<%=RDFDTFTxt.ClientID%>").keyup(function () {
            filterByRegisterDateRange($(this).val(), $("#<%=RDTDTFTxt.ClientID%>").val(), empty);
        });

        $("#<%=RDTDTFTxt.ClientID%>").keyup(function () {
            filterByRegisterDateRange($("#<%=RDFDTFTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=RDFDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByRegisterDateRange(date, $("#<%=RDTDTFTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=RDTDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByRegisterDateRange($("#<%=RDFDTFTxt.ClientID%>").val(), date, empty);
            }
        });


        $("#byCLSRDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=CLSRFDTFTxt.ClientID%>").val('');
            $("#<%=CLSRTDTFTxt.ClientID%>").val('');

            $("#ClosureDateContainer").show();
        });

        /*filter by closure date range*/
        $("#<%=CLSRFDTFTxt.ClientID%>").keyup(function () {
            filterByClosureDateRange($(this).val(), $("#<%=CLSRTDTFTxt.ClientID%>").val(), empty);
        });

        $("#<%=CLSRTDTFTxt.ClientID%>").keyup(function () {
            filterByClosureDateRange($("#<%=CLSRFDTFTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=CLSRFDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByClosureDateRange(date, $("#<%=CLSRTDTFTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=CLSRTDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByClosureDateRange($("#<%=CLSRFDTFTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#byDUEDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=DUEFDTFTxt.ClientID%>").val('');
            $("#<%=DUETDTFTxt.ClientID%>").val('');

            $("#DueDateContainer").show();
        });

        /*filter by due date range*/
        $("#<%=DUEFDTFTxt.ClientID%>").keyup(function () {
            filterByDueDateRange($(this).val(), $("#<%=DUETDTFTxt.ClientID%>").val(), empty);
        });

        $("#<%=DUETDTFTxt.ClientID%>").keyup(function () {
            filterByDueDateRange($("#<%=DUEFDTFTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=DUEFDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDueDateRange(date, $("#<%=DUETDTFTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=DUETDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDueDateRange($("#<%=DUEFDTFTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#<%=RSKTYPFCBox.ClientID%>").change(function ()
        {
            filterRisksByType($(this).val(), empty);
        });

        $("#<%=RSKSTSFCBox.ClientID%>").change(function ()
        {
            filterRisksByStatus($(this).val(), empty);
        });

        $("#<%=RSKMODFCBox.ClientID%>").change(function ()
        {
            filterRisksByMode($(this).val(), empty);
        });

        $("#<%=RSKCATFCBox.ClientID%>").change(function () 
        {
            filterRisksByCategory($(this).val(), empty);
        });

        $("#<%=RECMODCBox.ClientID%>").change(function ()
        {
            filterRisksByRecordMode($(this).val(), empty);
        });


        $("#tabul li").bind("click", function () {
            navigate($(this).attr("id"));
        });


        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#cancel").trigger('click');
            }
        });

        $("#<%=OWNRSelect.ClientID%>").bind('click', function (e) {

            showORGDialog(e.pageX, e.pageY);
        });

        $("#PROBEdit").bind('click', function (e) {

            showProbabilityDialog(e.pageX, e.pageY);
        });

        $("#TPROB_Help").bind('click', function (e) {

            showProbabilityMatrixDialog(e.pageX, e.pageY);
        });

        $("#STDIMPEdit").bind('click', function (e) {

            showSTDCostImpactDialog(e.pageX, e.pageY);
        });
        
        $("#<%=RSKTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var $obj = $(this);

                clearParameters();

                /*load probability criteria for all types of risk*/
                loadProbabilityCriteria("#PROB_LD", "#<%=PROBCBox.ClientID%>", $(this).val());

                switch ($(this).val()) {
                    case "ORI":
                        $("#RiskGeneralEstimationGroup").stop(true).hide().fadeIn(500, function () {
                            loadProbabilityCriteria("#TIMP_LD", "#<%=TIMPCBox.ClientID%>", $obj.val());
                            loadProbabilityCriteria("#QOSIMP_LD", "#<%=QOSIMPCBox.ClientID%>", $obj.val());
                            loadProbabilityCriteria("#CIMP_LD", "#<%=CIMPCBox.ClientID%>", $obj.val());

                            $("#RiskGeneralEstimationGroupHeader").show();

                            resetGroup("#RiskEstimationGroupDetails");

                            $("#project").hide();

                            $("#OHSASHACCPGroupHeader").hide();
                            $("#OHSASHACCPGroup").hide();

                            $("#EMSGroupHeader").hide();
                            $("#EMSGroup").hide();

                            $("#RiskEstimationTooltip").fadeOut();

                            /*set the adjusted cost of impact to zero by default*/
                            $("#<%=ADJIMPCOSTTxt.ClientID%>").val(parseFloat(0).toFixed(2));

                            /*automaitically calculate the adjusted cost exposure value*/
                            var e = jQuery.Event("keydown");
                            e.which = 13; // # Some key code value
                            $("#<%=ADJIMPCOSTTxt.ClientID%>").trigger(e);

                        });
                        break;
                    case "OHSAS":
                    case "HACCP":
                        $("#OHSASHACCPGroup").stop(true).hide().fadeIn(500, function () {

                            $("#OHSASHACCPGroupHeader").show();

                            resetGroup("#RiskEstimationGroupDetails");

                            $("#RiskGeneralEstimationGroupHeader").hide();
                            $("#RiskGeneralEstimationGroup").hide();

                            $("#EMSGroupHeader").hide();
                            $("#EMSGroup").hide();

                            loadSeverity("#SVR_LD", "#<%=SVRTCBox.ClientID%>");

                            loadComboboxAjax('loadComparatorOperators', "#<%=OPRCBox.ClientID%>", "#OPR_LD");

                            $("#RiskEstimationTooltip").fadeOut();
                        });
                        break;
                    case "EMS":
                        $("#EMSGroup").stop(true).hide().fadeIn(500, function () {
                            $("#RiskEstimationTooltip").stop(true).hide().fadeIn(500, function () {
                                $(this).find('p').html("The significant rating value can be estimated using the following equation: <br/> Rating= Risk Score + Legal/Regulatory Requirements + Nuisance + Interested Parties + Lack of Information + Policy Issues");
                            });
                            resetGroup("#RiskEstimationGroupDetails");
                            /*load severity of impact on env.*/
                            loadSeverity("#SVRENV_LD", "#<%=SVRENVCBox.ClientID%>");

                            /*load severity of impact on human*/
                            loadSeverity("#SVRHUM_LD", "#<%=SVRHUMCBox.ClientID%>");

                            $("#RiskGeneralEstimationGroupHeader").hide();
                            $("#RiskGeneralEstimationGroup").hide();

                            $("#OHSASHACCPGroupHeader").hide();
                            $("#OHSASHACCPGroup").hide();

                            $("#EMSGroupHeader").show();

                            loadComboboxAjax('loadComparatorOperators', "#<%=EMSOPRCbox.ClientID%>", "#EMSOPR_LD");

                        });
                        break;

                }
            }
        });

        /*populate the employees in  owner, or actionee cbox*/
        $("#<%=ORGUNTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=OWNRCBox.ClientID%>");

                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#OWNR_LD");
                $("#SelectORG").hide('800');
            }
        });

        $("#<%=ACATFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                switch ($("#ASGMODE").val()) {
                    case "Complexity":
                        loadAssessmentGuide("#COMPOPR_LD", "#<%=COMPOPRCBox.ClientID%>", $(this).val());
                        break;
                    case "Legal":
                        loadAssessmentGuide("#LRR_LD", "#<%=LRRCBox.ClientID%>", $(this).val());
                        break;
                    case "Nuisance":
                        loadAssessmentGuide("#Nuisance_LD", "#<%=NuisanceCBox.ClientID%>", $(this).val());
                        break;
                    case "Party":
                        loadAssessmentGuide("#INTPRT_LD", "#<%=INTPRTCBox.ClientID%>", $(this).val());
                        break;
                    case "Policy":
                        loadAssessmentGuide("#PLCYISSU_LD", "#<%=PLCYISSUCBox.ClientID%>", $(this).val());
                        break;
                    case "Information":
                        loadAssessmentGuide("#LINFO_LD", "#<%=LINFOCBox.ClientID%>", $(this).val());
                        break;
                }

                $("#SelectAssessment").hide('800');
            }
        });

        /*obtain probability percentage or value depending on the type of the risk*/
        $("#<%=PROBCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                /*calculate probability percentage*/
                getProbabilityPercentage("#PROBVAL_LD", $(this).val(), $("#<%=RSKTYPCBox.ClientID%>").val());
            }
        });

        /*obtain the probability of the time impact criteria*/
        $("#<%=TIMPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {

                if ($("#riskparam").val() != '')
                {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.TimeImpact = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));


                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });


        /*obtain the probability of the QOS impact criteria*/
        $("#<%=QOSIMPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {

                if ($("#riskparam").val() != '')
                {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.QOSImpact = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=CIMPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                if ($("#riskparam").val() != '')
                {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.CostImpact = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=ADJIMPCOSTTxt.ClientID%>").keydown(function (event)
        {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13')
            {
                var probability = $("#<%=PROBVALTxt.ClientID%>").val() == '' ? 0 : $("#<%=PROBVALTxt.ClientID%>").val();

                /*calculate the adjusted exposure value, and store it in the adjusted exposure text field*/
                var adjustedexposure = calculateExposure(parseFloat($(this).val()), probability);

                $("#<%=ADJEXPTxt.ClientID%>").val(adjustedexposure.toFixed(2));
            }
        });

        /*bind severity score*/
        $("#<%=SVRTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                if ($("#riskparam").val() != '')
                {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.Severity = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }                                
            }
        });

        $("#<%=SVRENVCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#riskparam").val() != '') {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.SeverityEnvironment = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=SVRHUMCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#riskparam").val() != '') {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.SeverityHuman = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=COMPOPRCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                if ($("#riskparam").val() != '')
                {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.OperationalComplexity = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=LRRCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#riskparam").val() != '') {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.Regularity = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=NuisanceCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#riskparam").val() != '') {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.Nusiance = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=INTPRTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#riskparam").val() != '') {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.InterestedParties = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=LINFOCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#riskparam").val() != '') {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.LackInformation = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=PLCYISSUCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#riskparam").val() != '') {
                    var riskparam = $.parseJSON($("#riskparam").val());

                    riskparam.PolicyIssue = $(this).val();

                    $("#riskparam").val(JSON.stringify(riskparam));

                    getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                }
            }
        });

        $("#<%=OrganizationalRB.ClientID%>").click(function () {

            if (!$("#project").is(":hidden"))
                $("#project").hide();
        });

        $("#<%=ProjectRB.ClientID%>").click(function ()
        {
            if ($("#project").is(":hidden")) {
                $("#project").stop(true).hide().fadeIn(500, function () {
                    loadProjects();
                });
            }
        });


        $("#psave").bind('click', function () {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true) {
                $("#PercentageProbabilitySaveTooltip").stop(true).hide().fadeIn(500, function () {
                
                    var json = $("#table").table('getJSON');

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(json) + "\'}",
                        url: getServiceURL().concat('uploadProbabilityValues'),
                        success: function (data) {
                            $("#PercentageProbabilitySaveTooltip").fadeOut(500, function () {

                                $("#pclosebox").trigger('click');

                                getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                            });

                        },
                        error: function (xhr, status, error) {
                            $("#PercentageProbabilitySaveTooltip").fadeOut(500, function () {

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#pmsave").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true)
            {
                $("#ProbabilityMatrixSaveTooltip").stop(true).hide().fadeIn(500, function ()
                {
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify($("#matrix").matrixtable('getJSON')) + "\'}",
                        url: getServiceURL().concat('uploadProbabilityMatrix'),
                        success: function (data) {
                            $("#ProbabilityMatrixSaveTooltip").fadeOut(500, function () {
                              
                                $("#pmclosebox").trigger('click');

                                getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#ProbabilityMatrixSaveTooltip").fadeOut(500, function () {
                               
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(xhr.responseText);
                            });
                        }
                    });
                });
            }
         });


        $("#stdsave").bind('click', function () {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true) {
                var stdcost = $("#STDcost").table('getJSON');

                $("#STDCostImpactCriteriaSaveTooltip").stop(true).hide().fadeIn(500, function () {
                 
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(stdcost) + "\'}",
                        url: getServiceURL().concat('UploadSTDCostImpactGuidlines'),
                        success: function (data) {
                            $("#STDCostImpactCriteriaSaveTooltip").fadeOut(500, function () {
                 
                                $("#stdclosebox").trigger('click');

                                getProbabilityPercentage("#PROBVAL_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());
                 
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#STDCostImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#save").bind('click', function ()
        {
            var isDetailsValid = Page_ClientValidate('Details');
            if (isDetailsValid)
            {
                if (!$("#validation_dialog_details").is(":hidden"))
                {
                    $("#validation_dialog_details").hide();
                }

                var isRiskEstimationValue = Page_ClientValidate('Probability');
                if (isRiskEstimationValue)
                {
                    var registeredDateParts =  getDatePart($("#<%=REGDTTxt.ClientID%>").val());
                    var dueDateParts = getDatePart($("#<%=DUDTTxt.ClientID%>").val());
                    var assessedDateParts = getDatePart($("#<%=DTASSDTTxt.ClientID%>").val());
                    var closureDateParts = getDatePart($("#<%=CLSRDTTxt.ClientID%>").val());

                    //set the default values of the risk JSON object
                    var risk =
                    {
                        RiskID:$("#RiskID").val(),
                        RiskNo: $("#<%=RiskNoTxt.ClientID%>").val(),
                        RiskType: $("#<%=RSKTYPCBox.ClientID%>").val(),
                        RiskMode: $("#<%=RSKMODCBox.ClientID%>").val(),
                        RiskCategory: $("#<%=RSKCATCBox.ClientID%>").val(),
                        RiskName: $("#<%=RSKNMTxt.ClientID%>").val(),
                        RiskStatusString:$("#<%=RSKSTSCBox.ClientID%>").val(),
                        Description: $("#<%=RSKDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RSKDESCTxt.ClientID%>").val()),
                        RegisterDate: new Date(registeredDateParts[2], (registeredDateParts[1] - 1), registeredDateParts[0]),
                        DueDate: dueDateParts == '' ? null : new Date(dueDateParts[2], (dueDateParts[1] - 1), dueDateParts[0]),
                        AssessedDate: assessedDateParts == '' ? null : new Date(assessedDateParts[2], (assessedDateParts[1] - 1), assessedDateParts[0]),
                        ClosureDate: closureDateParts == '' ? null : new Date(closureDateParts[2], (closureDateParts[1] - 1), closureDateParts[0]),
                        RiskProbability: $("#<%=PROBCBox.ClientID%>").val(),
                        Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                        ProjectName: '',
                        TimeImpact: '',
                        CostImpact: '',
                        QOSImpact: '',
                        CostCentre1: '',
                        CostCentre2: '',
                        AdjustedCostImpact: parseFloat(0),
                        Severity: '',
                        LimitSign: '',
                        CriticalLimit: parseFloat(0),
                        Score: parseFloat(0),
                        SeverityHuman: '',
                        SeverityEnvironment: '',
                        OperationalComplexity: '',
                        Nusiance: '',
                        Regularity: '',
                        InterestedParties: '',
                        LackInformation: '',
                        PolicyIssue: '',
                        SIR: -1

                    }

                    var risktype = $("#<%=RSKTYPCBox.ClientID%>").val();
                    switch (risktype) {
                        case "ORI":
                            var isRiskValid = Page_ClientValidate('Risk');
                            if (isRiskValid) {
                                if (!$("#validation_dialog_risk").is(":hidden")) {
                                    $("#validation_dialog_risk").hide();
                                }

                                //adjust ORI JSON attribute values
                                risk.TimeImpact = $("#<%=TIMPCBox.ClientID%>").val();
                                risk.CostImpact = $("#<%=CIMPCBox.ClientID%>").val();
                                risk.QOSImpact = $("#<%=QOSIMPCBox.ClientID%>").val();
                                risk.CostCentre1 = ($("#<%=CSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=CSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=CSTCNTRCBox.ClientID%>").val();
                                risk.CostCentre2 = ($("#<%=OCSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=OCSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=OCSTCNTRCBox.ClientID%>").val();
                                risk.AdjustedCostImpact = parseFloat($("#<%=ADJIMPCOSTTxt.ClientID%>").val());
                                risk.Score = parseFloat($("#<%=RSKSCRTxt.ClientID%>").val());
                                //alert("ORI");

                                if ($("#<%=ProjectRB.ClientID%>").is(':checked')) {
                                    var isProjectValid = Page_ClientValidate('Project');
                                    if (!isProjectValid) {
                                        alert("Please select the name of the project");
                                        navigate('Probability');
                                    }
                                    else {
                                        //set the name of the project in the above JSON data
                                        risk.ProjectName = $("#<%=PROJCBox.ClientID%>").val();
                                    }

                                }
                                else {
                                    risk.ProjectName = '';
                                }

                                saveRisk(JSON.stringify(risk));
                            }
                            else {
                                $("#validation_dialog_risk").stop(true).hide().fadeIn(500, function () {
                                    navigate('Probability');
                                });
                            }

                            break;

                        case "OHSAS":
                        case "HACCP":
                            var isOHSASHACCPValid = Page_ClientValidate('OHSASHACCP');
                            if (isOHSASHACCPValid) {
                                if (!$("#validation_dialog_ohsashaccp").is(":hidden")) {
                                    $("#validation_dialog_ohsashaccp").hide();
                                }

                                risk.Severity = $("#<%=SVRTCBox.ClientID%>").val();
                                risk.LimitSign = $("#<%=OPRCBox.ClientID%>").val();
                                risk.CriticalLimit = parseFloat($("#<%=LMTTxt.ClientID%>").val());
                                risk.Score = parseFloat($("#<%=RSKSCRTxt.ClientID%>").val());
                                risk.CostCentre1 = ($("#<%=CSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=CSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=CSTCNTRCBox.ClientID%>").val();
                                risk.CostCentre2 = ($("#<%=OCSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=OCSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=OCSTCNTRCBox.ClientID%>").val();
                                //alert("haccp");
                                saveRisk(JSON.stringify(risk));
                            }
                            else {
                                $("#validation_dialog_ohsashaccp").stop(true).hide().fadeIn(500, function () {
                                    navigate('Probability');
                                });
                            }
                            break;

                        case "EMS":
                            var isEMSValid = Page_ClientValidate('EMS');
                            if (isEMSValid) {
                                if (!$("#validation_dialog_ems").is(":hidden")) {
                                    $("#validation_dialog_ems").hide();
                                }

                                risk.LimitSign = $("#<%=EMSOPRCbox.ClientID%>").val();
                                risk.CriticalLimit = parseFloat($("#<%=EMSLMTTxt.ClientID%>").val());
                                risk.SeverityHuman = $("#<%=SVRHUMCBox.ClientID%>").val();
                                risk.SeverityEnvironment = $("#<%=SVRENVCBox.ClientID%>").val();
                                risk.OperationalComplexity = $("#<%=COMPOPRCBox.ClientID%>").val();
                                risk.LackInformation = ($("#<%=LINFOCBox.ClientID%>").val() == 0 || $("#<%=LINFOCBox.ClientID%>").val() == null ? '' : $("#<%=LINFOCBox.ClientID%>").val());
                                risk.Nusiance = ($("#<%=NuisanceCBox.ClientID%>").val() == 0 || $("#<%=NuisanceCBox.ClientID%>").val() == null ? '' : $("#<%=NuisanceCBox.ClientID%>").val()); 
                                risk.Regularity = ($("#<%=LRRCBox.ClientID%>").val() == 0 || $("#<%=LRRCBox.ClientID%>").val() == null ? '' : $("#<%=LRRCBox.ClientID%>").val());
                                risk.InterestedParties = ($("#<%=INTPRTCBox.ClientID%>").val() == 0 || $("#<%=INTPRTCBox.ClientID%>").val() == null ? '' : $("#<%=INTPRTCBox.ClientID%>").val());
                                risk.PolicyIssue = ($("#<%=PLCYISSUCBox.ClientID%>").val() == 0 || $("#<%=PLCYISSUCBox.ClientID%>").val() == null ? '' : $("#<%=PLCYISSUCBox.ClientID%>").val());
                                risk.Score = parseFloat($("#<%=RSKSCRTxt.ClientID%>").val());
                                risk.SIR = parseFloat($("#<%=SGNRATTxt.ClientID%>").val());
                                risk.CostCentre1 = ($("#<%=CSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=CSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=CSTCNTRCBox.ClientID%>").val();
                                risk.CostCentre2 = ($("#<%=OCSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=OCSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=OCSTCNTRCBox.ClientID%>").val();
                                //alert("EMS");
                                saveRisk(JSON.stringify(risk));
                            }
                            else {
                                $("#validation_dialog_ems").stop(true).hide().fadeIn(500, function () {
                                    navigate('Probability');
                                });
                            }

                            break;
                    }


                }
                else {
                    alert("Please select the risk probability percentage");
                    navigate('Probability');
                }
            }
            else {
                $("#validation_dialog_details").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings in the details TAB are fulfilled");
                    navigate('Details');
                });
            }

        });

    });

    function saveRisk(json)
    {
        var result = confirm("Are you sure you would like to submit changes?");
        if (result == true) 
        {
            $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                ActivateSave(false);

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{\'json\':\'" + json + "\'}",
                    url: getServiceURL().concat('updateRisk'),
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
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }

    function ActivateAll(isactive) {
        if (isactive == false) {
            $(".modalPanel").children().each(function () {

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

                $(".textremaining").each(function () {
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

    function clearParameters()
    {
        if ($("#riskparam").val() != '')
        {
            var riskparam = $.parseJSON($("#riskparam").val());

            riskparam.TimeImpact = '';
            riskparam.CostImpact = '';
            riskparam.QOSImpact = '';
            riskparam.AdjustedCostOfImpact = parseFloat(0);
            riskparam.Severity = '';
            riskparam.SeverityHuman = '';
            riskparam.SeverityEnvironment = '';
            riskparam.OperationalComplexity = '';
            riskparam.Nusiance = '';
            riskparam.Regularity = '';
            riskparam.InterestedParties = '';
            riskparam.LackInformation = '';
            riskparam.PolicyIssue = '';

            $("#riskparam").val(JSON.stringify(riskparam));
        }
    }

    function getSeverityScore(criteria, target,risktype)
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadSeverity"),
            success: function (data) {
                if (data) {
                    /*Parse xml data and load severity cbox*/
                    var xmlSeverity = $.parseXML(data.d);

                    $(xmlSeverity).find('Severity').each(function (index, severity) {
                        if ($(this).attr('Criteria') == criteria)
                        {
                            $(target).val(parseFloat($(this).attr('Score')).toFixed(2));

                            calculateRisk(risktype);
                        }
                    });

                }
            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);
            }
        });
    }

    function calculateImpactProbability(control, loader, probability, impact, risktype) {
        /*locate both impact and probability criterias*/
        /*The matrix is designed such that the probability criteria values are located 
        in the first column of the matrix, where the impact values are located in the first row of the matrix*/

        /*according to the matrix, the desired value is located in p(Xp,Yi)*/

        $(loader).stop(true).hide().fadeIn(500, function () {

            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json",
                     dataType: "json",
                     data: "{'risktype':'" + risktype + "'}",
                     url: getServiceURL().concat('loadProbabilityMatrix'),
                     success: function (data)
                     {
                         $(loader).fadeOut(500, function ()
                         {
                             $(".modulewrapper").css("cursor", "default");

                             var json = $.parseJSON(data.d);
                             var xp = 0;
                             var yi = 0;

                             $(json).each(function (index, value)
                             {
                                 if (parseInt(value["Y"]) == 0)
                                 {
                                     if (value["Value"] == probability)
                                     {
                                         xp = parseInt(value["X"]);
                                     }
                                 }
                                 else if (parseInt(value["X"]) == 0)
                                 {
                                     if (value["Value"] == impact)
                                     {
                                         yi = parseInt(value["Y"]);
                                     }
                                 }
                             });

                             var desiredprobability = locateMatrixValue(data.d, xp, yi);
                             $(control).val(desiredprobability.toFixed(2));

                             /*calculate risk score*/
                             calculateRisk(risktype);


                         });
                     },
                     error: function (xhr, status, error) {
                         $(loader).fadeOut(500, function () {
                             $(".modulewrapper").css("cursor", "default");

                             var r = jQuery.parseJSON(xhr.responseText);
                             alert(r.Message);
                         });
                     }
                 });
        });
    }

    function locateMatrixValue(jsondata, x, y)
    {

        var desired = 0;

        var json = $.parseJSON(jsondata);

        $(json).each(function (index, value)
        {
            if (parseInt(value["X"]) == x && parseInt(value["Y"]) == y)
            {
                desired = isNaN(value["Value"]) == true ? 0 : parseFloat(value["Value"]);
            }
        });

        return desired;
    }

    function loadRiskCategory(control,loader) {

        $(loader).stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCategory"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $(control));
                        }
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

    function filterRisksByType(type, empty)
    {
        $("#RSKwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterRiskByType'),
                success: function (data) {
                    $("#RSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').html("List of all current risks filtered by the type of the risk. <br/> Note: Closed, Cancelled, or Archived risks cannot be modified");
                        });


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKwait").fadeOut(500, function () {
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


    function filterRisksByStatus(status, empty)
    {
        $("#RSKwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat('filterRiskByStatus'),
                success: function (data) {
                    $("#RSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').html("List of all current risks filtered by the status of the risk. <br/> Note: Closed, Cancelled, or Archived risks cannot be modified");
                        });


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKwait").fadeOut(500, function () {
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


    function filterRisksByCategory(category, empty)
    {
        $("#RSKwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat('filterRiskByCategory'),
                success: function (data) {
                    $("#RSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').html("List of all current risks filtered by the category of the risk. <br/> Note: Closed, Cancelled, or Archived risks cannot be modified");
                        });


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKwait").fadeOut(500, function () {
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

    function filterRisksByMode(mode, empty) {
        $("#RSKwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterRiskByMode'),
                success: function (data) {
                    $("#RSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').html("List of all current risks filtered by the mode of the risk. <br/> Note: Closed, Cancelled, or Archived risks cannot be modified");
                        });


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKwait").fadeOut(500, function () {
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


    function filterRisksByRecordMode(mode, empty) {
        $("#RSKwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterRiskByRecordMode'),
                success: function (data) {
                    $("#RSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').html("List of all current risks filtered by the status of the record. <br/> Note: Closed, Cancelled, or Archived risks cannot be modified");
                        });


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKwait").fadeOut(500, function () {
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

    function loadRisks(empty) {
        $("#RSKwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadRiskList'),
                success: function (data) {
                    $("#RSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            $(this).find('p').html("List of all current risks. <br/> Note: Closed, Cancelled, or Archived risks cannot be modified");
                        });

                      
                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKwait").fadeOut(500, function () {
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

    function filterByRegisterDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#RSKwait").stop(true).hide().fadeIn(800, function () {
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
                    url: getServiceURL().concat('filterRiskByRegisterDate'),
                    success: function (data) {
                        $("#RSKwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current risks filtered by register date between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));
                            });
                            loadGridView(data.d, empty);
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#RSKwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#RSKwait").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByClosureDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#RSKwait").stop(true).hide().fadeIn(800, function () {
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
                    url: getServiceURL().concat('filterRiskByClosureDate'),
                    success: function (data) {
                        $("#RSKwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current risks filtered by closure date between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));
                            });
                            loadGridView(data.d, empty);
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#RSKwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#RSKwait").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByDueDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#RSKwait").stop(true).hide().fadeIn(800, function () {
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
                    url: getServiceURL().concat('filterRiskByDueDate'),
                    success: function (data) {
                        $("#RSKwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current risks filtered by due date between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));
                            });
                            loadGridView(data.d, empty);
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#RSKwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#RSKwait").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }



    
    function loadGridView(data, empty)
    {
        var xmlRisks = $.parseXML(data);

        var row = empty;

        $("#<%=gvRisks.ClientID%> tr").not($("#<%=gvRisks.ClientID%> tr:first-child")).remove();

        $(xmlRisks).find("Risk").each(function (index, value)
        {
           
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");
            $("td", row).eq(2).html($(this).attr("RiskNo"));
            $("td", row).eq(3).html($(this).attr("RiskName"));
            $("td", row).eq(4).html($(this).attr("RiskType"));
            $("td", row).eq(5).html($(this).attr("RiskMode"));
            $("td", row).eq(6).html($(this).attr("RiskCategory"));

            var registerdate = new Date($(this).attr("RegisterDate"));
            registerdate.setMinutes(registerdate.getMinutes() + registerdate.getTimezoneOffset());

            $("td", row).eq(7).html(registerdate.format("dd/MM/yyyy"));

            var closuredate = new Date($(this).find("ClosureDate").text());
            closuredate.setMinutes(closuredate.getMinutes() + closuredate.getTimezoneOffset());

            $("td", row).eq(8).html($(this).find("ClosureDate").text() == '' ? '' : closuredate.format("dd/MM/yyyy"));
            $("td", row).eq(9).html($(this).attr("Score"));
            $("td", row).eq(10).html($(this).attr("RiskStatusString"));
            $("td", row).eq(11).html($(this).attr("ModeString"));

            $("#<%=gvRisks.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeRisk($(value).attr('RiskID'));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        var risktype = $(value).attr("RiskType");

                        /*bind the ID of the risk*/
                        $("#RiskID").val($(value).attr('RiskID'));

                        /*bind risk number*/
                        $("#<%=RiskNoTxt.ClientID%>").val($(value).attr("RiskNo"));

                        /*bind risk name*/
                        $("#<%=RSKNMTxt.ClientID%>").val($(value).attr("RiskName"));

                        /*bind risk type*/
                        bindComboboxAjax('loadRiskType', '#<%=RSKTYPCBox.ClientID%>', risktype, "#RSKTYP_LD");
                   
                        bindProbabilityCriteria("#PROB_LD", "#<%=PROBCBox.ClientID%>", $(value).attr('RiskProbability'), risktype);
                                 
                        var riskparam = $.parseJSON($("#riskparam").val());

                        /*control the risk estimation calculations based on the type of the risk*/
                        switch (risktype)
                        {
                            case "ORI":

                                $("#RiskGeneralEstimationGroup").stop(true).hide().fadeIn(500, function ()
                                {
                                    resetGroup("#RiskEstimationGroupDetails");

                                    riskparam.TimeImpact = $(value).attr('TimeImpact');
                                    riskparam.CostImpact = $(value).attr('CostImpact');
                                    riskparam.QOSImpact = $(value).attr('QOSImpact');
                                    riskparam.AdjustedCostOfImpact = parseFloat($(value).attr('AdjustedCostImpact'));

                                    /*load probability criteria for all types of risk*/
                                    bindProbabilityCriteria("#TIMP_LD", "#<%=TIMPCBox.ClientID%>", riskparam.TimeImpact, risktype);
                                    bindProbabilityCriteria("#QOSIMP_LD", "#<%=QOSIMPCBox.ClientID%>", riskparam.QOSImpact, risktype);
                                    bindProbabilityCriteria("#CIMP_LD", "#<%=CIMPCBox.ClientID%>", riskparam.CostImpact, risktype);

                                    $("#RiskGeneralEstimationGroupHeader").show();

                                    if ($(value).attr('ProjectName') == '')
                                    {
                                        $("#project").hide();

                                        $("#<%=OrganizationalRB.ClientID%>").prop('checked', true);
                                    }
                                    else
                                    {
                                        $("#project").show();

                                        $("#<%=ProjectRB.ClientID%>").prop('checked', true);

                                        bindProjects($(value).attr('ProjectName'));
                                    }

                                    $("#OHSASHACCPGroupHeader").hide();
                                    $("#OHSASHACCPGroup").hide();

                                    $("#EMSGroupHeader").hide();
                                    $("#EMSGroup").hide();

                                    $("#RiskEstimationTooltip").fadeOut();
                                });
                                break;
                            case "OHSAS":
                            case "HACCP":
                                $("#OHSASHACCPGroup").stop(true).hide().fadeIn(500, function ()
                                {
                                    resetGroup("#RiskEstimationGroupDetails");

                                    $("#OHSASHACCPGroupHeader").show();

                                    $("#RiskGeneralEstimationGroupHeader").hide();
                                    $("#RiskGeneralEstimationGroup").hide();

                                    $("#EMSGroupHeader").hide();
                                    $("#EMSGroup").hide();

                                    riskparam.Severity = $(value).attr('Severity');

                                    bindSeverity("#SVR_LD", "#<%=SVRTCBox.ClientID%>", riskparam.Severity);

                                    bindComboboxAjax('loadComparatorOperators', "#<%=OPRCBox.ClientID%>", $(value).attr("LimitSign"), "#OPR_LD");

                                    $("#<%=LMTTxt.ClientID%>").val(parseFloat($(value).attr('CriticalLimit')).toFixed(2));

                                    $("#RiskEstimationTooltip").fadeOut();
                                });
                                break;
                            case "EMS":
                                $("#EMSGroup").stop(true).hide().fadeIn(500, function ()
                                {
                                    $("#RiskEstimationTooltip").stop(true).hide().fadeIn(500, function ()
                                    {
                                        $(this).find('p').html("The significant rating value can be estimated using the following equation: <br/> Rating= Risk Score + Legal/Regulatory Requirements + Nuisance + Interested Parties + Lack of Information + Policy Issues");
                                    });

                                    resetGroup("#RiskEstimationGroupDetails");

                                    riskparam.SeverityHuman = $(value).attr('SeverityHuman');
                                    riskparam.SeverityEnvironment = $(value).attr('SeverityEnvironment');
                                    riskparam.OperationalComplexity = $(value).attr('OperationalComplexity');
                                    riskparam.Nusiance = $(value).attr('Nusiance');
                                    riskparam.InterestedParties = $(value).attr('InterestedParties');
                                    riskparam.LackInformation = $(value).attr('LackInformation');
                                    riskparam.Regularity = $(value).attr('Regularity');
                                    riskparam.PolicyIssue = $(value).attr('PolicyIssue');

                                    bindComboboxAjax('loadComparatorOperators', "#<%=EMSOPRCbox.ClientID%>", $(value).attr("LimitSign"), "#EMSOPR_LD");

                                    $("#<%=EMSLMTTxt.ClientID%>").val(parseFloat($(value).attr('CriticalLimit')).toFixed(2));

                                    /*load severity of impact on env.*/
                                    bindSeverity("#SVRENV_LD", "#<%=SVRENVCBox.ClientID%>", riskparam.SeverityHuman);

                                    /*load severity of impact on human*/
                                    bindSeverity("#SVRHUM_LD", "#<%=SVRHUMCBox.ClientID%>", riskparam.SeverityEnvironment);

                                    bindAssessmentGuide("#COMPOPR_LD", "#<%=COMPOPRCBox.ClientID%>", riskparam.OperationalComplexity);

                                    bindAssessmentGuide("#LRR_LD", "#<%=LRRCBox.ClientID%>", riskparam.Regularity);

                                    bindAssessmentGuide("#Nuisance_LD", "#<%=NuisanceCBox.ClientID%>", riskparam.Nusiance);

                                    bindAssessmentGuide("#INTPRT_LD", "#<%=INTPRTCBox.ClientID%>", riskparam.InterestedParties);

                                    bindAssessmentGuide("#LINFO_LD", "#<%=LINFOCBox.ClientID%>", riskparam.LackInformation);

                                    bindAssessmentGuide("#PLCYISSU_LD", "#<%=PLCYISSUCBox.ClientID%>", riskparam.PolicyIssue);

                                    $("#RiskGeneralEstimationGroupHeader").hide();
                                    $("#RiskGeneralEstimationGroup").hide();

                                    $("#OHSASHACCPGroupHeader").hide();
                                    $("#OHSASHACCPGroup").hide();

                                    $("#EMSGroupHeader").show();

                                });
                                break;
                        }
                        
                        /*wait until the groupbox for each type of risk fades in, then get the probability percentage
                        * This will ensure that the values within the group boxes are stored in the JSON parameter
                        */
                        var t = setTimeout(function ()
                        {
                            $("#riskparam").val(JSON.stringify(riskparam));
                            getProbabilityPercentage("#PROBVAL_LD", $(value).attr('RiskProbability'), risktype);

                        }, 1000);
                        
                        /*bind risk mode*/
                        bindComboboxAjax('loadRiskMode', "#<%=RSKMODCBox.ClientID%>", $(value).attr("RiskMode"), "#RSKMOD_LD");

                        /*bind risk status*/
                        bindComboboxAjax('loadRiskStatus', "#<%=RSKSTSCBox.ClientID%>", $(value).attr("RiskStatusString"), "#RSKSTS_LD");

                        /*bind risk Owner*/
                        bindComboboxAjax('loadEmployees', '#<%=OWNRCBox.ClientID%>', $(value).attr("Owner"), "#OWNR_LD");

                        /*bind cost centre*/
                        bindCostCentre('#<%=CSTCNTRCBox.ClientID%>', $(value).attr("CostCentre1"), "#CNTR_LD");

                        /*bind other cost centre*/
                        bindCostCentre('#<%=OCSTCNTRCBox.ClientID%>', $(value).attr("CostCentre2"), "#OCNTR_LD");

                        /*bind risk category*/
                        bindRiskCategory("#RSKCAT_LD", $(value).attr("RiskCategory"), "#<%=RSKCATCBox.ClientID%>");
                       
                        /*bind details value*/
                        if ($(value).attr("Description") == '')
                        {

                            addWaterMarkText('The description of the risk', '#<%=RSKDESCTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=RSKDESCTxt.ClientID%>").hasClass("watermarktext"))
                            {
                                $("#<%=RSKDESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=RSKDESCTxt.ClientID%>").val($("#<%=RSKDESCTxt.ClientID%>").html($(value).attr("Description")).text());
                        }

                        /*bind register date*/
                        $("#<%=REGDTTxt.ClientID%>").val(registerdate.format("dd/MM/yyyy"));

                        var duedate = new Date($(value).find("DueDate").text());
                        duedate.setMinutes(duedate.getMinutes() + duedate.getTimezoneOffset());

                        /*bind due date*/
                        $("#<%=DUDTTxt.ClientID%>").val($(value).find("DueDate").text() == '' ? '' : duedate.format("dd/MM/yyyy"));

                        var assesseddate = new Date($(value).find("AssessedDate").text());
                        assesseddate.setMinutes(assesseddate.getMinutes() + assesseddate.getTimezoneOffset());

                        /*bind assessed date*/
                        $("#<%=DTASSDTTxt.ClientID%>").val($(value).find("AssessedDate").text() == '' ? '' : assesseddate.format("dd/MM/yyyy"));

                        /*bind closure date*/
                        $("#<%=CLSRDTTxt.ClientID%>").val($(value).find("ClosureDate").text() == '' ? '' : closuredate.format("dd/MM/yyyy"));

                       
                        if ($(value).attr('RiskStatusString') == 'Closed' || $(value).attr('RiskStatusString') == 'Cancelled')
                        {
                            $("#RiskTooltip").find('p').text("Changes cannot take place since the risk is " + $(value).attr('RiskStatusString'));

                            if ($("#RiskTooltip").is(":hidden")) {
                                $("#RiskTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else {
                            $("#RiskTooltip").hide();

                            /*enable all modal controls for editing*/
                            ActivateAll(true);
                        }

                        /*set default tab navigation*/
                        navigate("Details");

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvRisks.ClientID%> tr:last-child").clone(true);
        });
    }

    function getProbabilityPercentage(loader,criteria, risktype)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadProbability"),
                success: function (data)
                {
                    $(loader).fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var json = $.parseJSON(data.d);

                            $(json).each(function (index, value)
                            {
                                if (value["Criteria"] == criteria) {
                                    var probability = parseFloat(value["Probability"]);

                                    $("#<%=PROBVALTxt.ClientID%>").val(probability.toFixed(2));

                                    if ($("#riskparam").val() != '')
                                    {
                                        var riskparam = $.parseJSON($("#riskparam").val());

                                        switch (risktype)
                                        {
                                            case "ORI":

                                                calculateImpactProbability("#<%=TPROBTxt.ClientID%>", "#TIMPVAL_LD", criteria, riskparam.TimeImpact, risktype);
                                                calculateImpactProbability("#<%=QOSPROBTxt.ClientID%>", "#QOSIMPVAL_LD", criteria, riskparam.QOSImpact, risktype);
                                                calculateImpactProbability("#<%=CPROBTxt.ClientID%>", "#CIMPVAL_LD", criteria, riskparam.CostImpact, risktype);

                                                setStandardCost(riskparam.CostImpact, risktype, probability);

                                                /*store the value of the adjusted cost of impact*/
                                                $("#<%=ADJIMPCOSTTxt.ClientID%>").val(riskparam.AdjustedCostOfImpact.toFixed(2));

                                                /*calculate adjusted cost of impact exposure*/
                                                var exposure = calculateExposure(riskparam.AdjustedCostOfImpact, probability);

                                                $("#<%=ADJEXPTxt.ClientID%>").val(exposure.toFixed(2));

                                                break;
                                            case "OHSAS":
                                            case "HACCP":
                                                getSeverityScore(riskparam.Severity, "#<%=SVRVALTxt.ClientID%>", risktype);
                                                break;

                                            case "EMS":
                                                getSeverityScore(riskparam.SeverityEnvironment, "#<%=SVRENVValTxt.ClientID%>", risktype);

                                                getSeverityScore(riskparam.SeverityHuman, "#<%=SVRHUMValTxt.ClientID%>", risktype);

                                                getAssessmentScore(riskparam.OperationalComplexity, "#<%=COMPOPRSCRTxt.ClientID%>", risktype);

                                                getAssessmentValue(riskparam.Regularity, "#<%=LRRValTxt.ClientID%>", risktype);

                                                getAssessmentValue(riskparam.Nusiance, "#<%=NuisanceValTxt.ClientID%>", risktype);

                                                getAssessmentValue(riskparam.InterestedParties, "#<%=INTPRTValTxt.ClientID%>", risktype);

                                                getAssessmentValue(riskparam.LackInformation, "#<%=LINFOValTxt.ClientID%>", risktype);

                                                getAssessmentValue(riskparam.PolicyIssue, "#<%=PLCYISSUValTxt.ClientID%>", risktype);
                                                break;
                                        }
                                    }
                                }
                            });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $(loader).fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function getAssessmentValue(guidline,target,risktype)
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadISO14001Guide"),
            success: function (data) {
                var xmlAssessment = $.parseXML(data.d);

                $(xmlAssessment).find('ISO14001Guide').each(function () {
                    if ($(this).attr('Guideline') == guidline) {
                        $(target).val($(this).attr('Value'));

                        calculateRisk(risktype);
                    }
                });
            },
            error: function (xhr, status, error) {

                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);
            }
        });
    }

    function getAssessmentScore(guidline, target, risktype)
    {
        $.ajax(
        {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISO14001Guide"),
                success: function (data)
                {
                    var xmlAssessment = $.parseXML(data.d);

                    $(xmlAssessment).find('ISO14001Guide').each(function ()
                    {
                        if ($(this).attr('Guideline') == guidline)
                        {
                            $(target).val(parseFloat($(this).attr('Score')).toFixed(2));

                            calculateRisk(risktype);
                        }
                    });
                },
                error: function (xhr, status, error) {

                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
        });
    }

    function setStandardCost(criteria, risktype,probability)
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'risktype':'" + risktype + "'}",
            url: getServiceURL().concat("loadSTDCostImpactGuidLines"),
            success: function (data)
            {
                if (data)
                {
                    var json = $.parseJSON(data.d);

                    var stdcost = 0;

                    $(json).each(function (index, value)
                    {
                        if (value["RiskCriteria"] == criteria)
                        {
                            stdcost = parseFloat(value["STDCost"]);
                            $("#<%=STDIMPCOSTTxt.ClientID%>").val(stdcost.toFixed(2));

                            var exposure = calculateExposure(stdcost, probability);
                            $("#<%=STDEXPTxt.ClientID%>").val(exposure.toFixed(2));

                        }
                    });

                }
            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                alert(xhr.responseText);
            }
        });
    }

    function calculateExposure(stdcost, probability)
    {
        probability = probability / 100; //for example, if the probability is 8% then the desired value is 0.08

        return stdcost * probability;
    }

    function bindProjects(project)
    {
        $("#PROJ_LD").stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProjects"),
                success: function (data) {
                    $("#PROJ_LD").fadeOut(500, function () {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'Project', 'ProjectName', project, $("#<%=PROJCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJ_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }


    function loadProjects()
    {
        $("#PROJ_LD").stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProjects"),
                success: function (data) {
                    $("#PROJ_LD").fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Project', 'ProjectName', $("#<%=PROJCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJ_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function bindProbabilityCriteria(loader, control, value, risktype)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("filterCriteriaByRiskType"),
                success: function (data)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        if (data)
                        {
                            bindComboboxXML($.parseXML(data.d), 'RiskCriteria', 'Criteria', value, $(control));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProbabilityCriteria(loader, control, risktype) {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("filterCriteriaByRiskType"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'RiskCriteria', 'Criteria', $(control));
                        }
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


    function bindSeverity(loader, control, value)
    {
        $(loader).stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadSeverity"),
                success: function (data)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        if (data)
                        {
                            /*Parse xml data and load severity cbox*/
                            var xmlSeverity = $.parseXML(data.d);

                            bindComboboxXML(xmlSeverity, 'Severity', 'Criteria', value, $(control));
                        }
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

    function loadSeverity(loader, control) {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadSeverity"),
                success: function (data) {
                    $(loader).fadeOut(500, function ()
                    {
                        if (data)
                        {
                            /*Parse xml data and load severity cbox*/
                            loadComboboxXML($.parseXML(data.d), 'Severity', 'Criteria', control);
                        }
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

    function bindAssessmentGuide(loader, control, value)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {
         
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISO14001Guide"),
                success: function (data) {
                    $(loader).fadeOut(500, function ()
                    {

                        /*Parse xml data and load ISO 14001 assessment guid cbox*/
                        bindComboboxXML($.parseXML(data.d), 'ISO14001Guide', 'Guideline', value, $(control));
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

    function loadAssessmentGuide(loader, control,category)
    {
        $(loader).stop(true).hide().fadeIn(500, function ()
        {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'category':'" + category + "'}",

                url: getServiceURL().concat("filterISO14001GuideByCategory"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {

                        /*Parse xml data and load ISO 14001 assessment guid cbox*/
                        loadComboboxXML($.parseXML(data.d), 'ISO14001Guide', 'Guideline', $(control));
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

    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 320, top: y - 150 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
        $("#SelectORG").show();
    }

    function showAssessmentGuide(x, y)
    {
        $("#SelectAssessment").css({ left: x - 320, top: y - 120 });

        /*load ISO assessment category*/
        loadComboboxAjax('loadAssessmentCategory', "#<%=ACATFCBox.ClientID%>", "#ACAT_LD");
          
        $("#SelectAssessment").show();
    }

    function showProbabilityDialog(x, y)
    {
        $("#EditProbability").css({ left: x - 320, top: y - 70 });

        loadProbabilityPercentage($("#<%=RSKTYPCBox.ClientID%>").val());
      
        $("#EditProbability").show();
    }


    function showProbabilityMatrixDialog(x, y)
    {
        $("#EditProbabilityMatrix").css({ left: x - 450, top: y - 170 });

        loadProbabilityMatrix();

        $("#EditProbabilityMatrix").show();
    }


    function showSTDCostImpactDialog(x, y)
    {
        $("#EditSTDCostImpact").css({ left: x - 320, top: y - 250 });

        loadSTDCostImpactGuidLines($("#<%=RSKTYPCBox.ClientID%>").val());

        $("#EditSTDCostImpact").show();
    }


    function loadSTDCostImpactGuidLines(risktype)
    {
      
        $("#STDCostImpactCriteriaTooltip").stop(true).hide().fadeIn(800, function () {
            $(this).find('p').text("The below table represents the predefined values of the standard cost, where by default, each value is set to zero indicating that the value for a certain cost of impact criteria might be assigned automatically and not being added in the system yet.");
        });

        $("#STDCostwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadSTDCostImpactGuidLines"),
                success: function (data) {
                    $("#STDCostwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var json = $.parseJSON(data.d);

                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("STDCost");

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));

                            $("#STDcost").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#STDCostwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function loadProbabilityMatrix() {
        $("#ProbabilityMatrixTooltip").stop(true).hide().fadeIn(800, function () {
            $(this).find('p').text("The below matrix represents the cost, time, and QOS impact probability percentage, which can be determined by the criteria of the probability in the first column and the criteria of one of the impacts in the first row.");
        });

        $("#Matrixwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            var html = '';
            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'risktype':'" + $("#<%=RSKTYPCBox.ClientID%>").val() + "'}",
                    url: getServiceURL().concat('loadProbabilityMatrix'),
                    success: function (data) {
                        $("#Matrixwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var json = $.parseJSON(data.d);

                            $("#matrix").matrixtable({ JSON: json, Width: 30 });
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#Matrixwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });

    }
    function loadProbabilityPercentage(risktype)
    {
    
        $("#PercentageProbabilityTooltip").stop(true).hide().fadeIn(800, function () {
            $(this).find('p').text("The below table represents the predefined percentage values of the probability, where by default, the percentage is zero indicating that the value for a certain risk criteria might be assigned automatically and not being added in the system yet");
        });

        $("#PPwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadProbability"),
                success: function (data) {
                    $("#PPwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var attributes = new Array();
                            attributes.push("Criteria");
                            attributes.push("Probability");

                            var json = $.parseJSON(data.d);

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));

                            $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PPwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function bindCostCentre(control, value, loader) {

        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCostCentres"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'CostCentre', 'CostCentreName', value, $(control));
                        }
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

    function bindRiskCategory(loader, value, control)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCategory"),
                success: function (data) {
                    $("#RSKCAT_LD").fadeOut(500, function ()
                    {
                        if (data)
                        {
                            bindComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', value, $(control));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RSKCAT_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function removeRisk(riskID, empty)
    {
        var result = confirm("Are you sure you would like to remove the selected risk record?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'riskID':'" + riskID + "'}",
                url: getServiceURL().concat('removeRisk'),
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

    function calculateRisk(risktype)
    {
        var parameter = {};

        var riskscore = 0;

        switch (risktype) {
            case "ORI":
                parameter =
                {
                    TimeImpact: $("#<%=TPROBTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=TPROBTxt.ClientID%>").val()),
                    CostImpact: $("#<%=CPROBTxt.ClientID%>").val() == '' ? 0: parseFloat($("#<%=CPROBTxt.ClientID%>").val()),
                    QOSImpact: $("#<%=QOSPROBTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=QOSPROBTxt.ClientID%>").val())
                }

            
                getRiskScore(JSON.stringify(parameter), risktype);
                break;

            case "OHSAS":
            case "HACCP":
                parameter =
                {
                    Severity: $("#<%=SVRVALTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=SVRVALTxt.ClientID%>").val()),
                    Probability: $("#<%=PROBVALTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=PROBVALTxt.ClientID%>").val()),
                }

                getRiskScore(JSON.stringify(parameter), risktype);
                break;
            case "EMS":

                parameter =
                {
                    SeverityHuman: $("#<%=SVRHUMValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=SVRHUMValTxt.ClientID%>").val()),
                    SeverityEnvironment: $("#<%=SVRENVValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=SVRENVValTxt.ClientID%>").val()),
                    Probability: $("#<%=PROBVALTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=PROBVALTxt.ClientID%>").val()),
                    Complexity: $("#<%=COMPOPRSCRTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=COMPOPRSCRTxt.ClientID%>").val())
                }

                getRiskScore(JSON.stringify(parameter), risktype);
                break;

        }
    }

    function getRiskScore(parameter, risktype) {
        var score = 0;

        $("#RSKSCR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                url: "/FormulaHandler.ashx?param=" + parameter + "&risktype=" + risktype,
                dataType: "HTML",
                success: function (data) {
                    $("#RSKSCR_LD").fadeOut(500, function ()
                    {
                        score = parseFloat(data);

                        $("#<%=RSKSCRTxt.ClientID%>").val(parseFloat(score).toFixed(2));

                        if (risktype == "EMS")
                        {
                            var rating =
                            {
                                LegalRegularity: $("#<%=LRRValTxt.ClientID%>").val() == '' ? 0 : parseInt($("#<%=LRRValTxt.ClientID%>").val()),
                                Nuisance: $("#<%=NuisanceValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=NuisanceValTxt.ClientID%>").val()),
                                Parties: $("#<%=INTPRTValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=INTPRTValTxt.ClientID%>").val()),
                                Information: $("#<%=LINFOValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=LINFOValTxt.ClientID%>").val()),
                                Policy: $("#<%=PLCYISSUValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=PLCYISSUValTxt.ClientID%>").val()),
                                Score: score
                            }

                            calculateSignificantRating(JSON.stringify(rating));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKSCR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function calculateSignificantRating(json) {
        var jsonparam = $.parseJSON(json);

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'score':'" + parseFloat(jsonparam.Score) + "'}",
            url: getServiceURL().concat("getRiskScoreRating"),
            success: function (data) {
                var ratingscore = parseInt(data.d) + jsonparam.LegalRegularity + jsonparam.Nuisance + jsonparam.Parties + jsonparam.Information + jsonparam.Policy;

                $("#<%=SGNRATTxt.ClientID%>").val(ratingscore);

            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                alert(xhr.responseText);
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

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }


</script>
</asp:Content>
