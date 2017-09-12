<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="AuditSchedule.aspx.cs" Inherits="QMSRSTools.AuditManagement.AuditSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="wrapper" class="modulewrapper">
    <div id="AUDTACT_Header" class="moduleheader">Audit Schedule</div>

    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
       
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byYear">Filter by Year</li>
                <li id="byAUDTTYP">Filter by Audit Type</li>
                <li id="byAUDTSTS">Filter by Audit Status</li>
                <li id="byPLNAUDT">Planned Audit Date</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
    </div>

    <div id="AuditYearContainer" class="filter">
        <div id="AuditYearLabel" class="filterlabel">Audit Year:</div>
        <div id="AuditYearField" class="filterfield">
            <asp:DropDownList ID="AUDTYRCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ADTYRF_LD" class="control-loader"></div>
    </div>
    
    <div id="AuditTypeContainer" class="filter">
        <div id="AuditTypeFilterLabel" class="filterlabel">Audit Type:</div>
        <div id="AuditTypeFilterField" class="filterfield">
            <asp:DropDownList ID="AUDTTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ADTTYPF_LD" class="control-loader"></div>
    </div>

    <div id="AuditStatusContainer" class="filter">
        <div id="AuditStatusFilterLabel" class="filterlabel">Audit Status:</div>
        <div id="AuditStatusFilterField" class="filterfield">
            <asp:DropDownList ID="AUDTSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="AUDTSTSF_LD" class="control-loader"></div>
    </div>
    
    <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RECMODF_LD" class="control-loader"></div>
    </div>
    
    <div id="AuditDateContainer" class="filter">
        <div id="PlannedDateLabel" class="filterlabel">Planned Audit Date:</div>
        <div id="PlannedDateField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>

    <div id="RAGTooltip" class="tooltip" style="margin-top:20px; background-color:transparent;"> 
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="RED" src="http://www.qmsrs.com/qmsrstools/Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: The audit is overdue.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="GREEN" src="http://www.qmsrs.com/qmsrstools/Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: The audit is on schedule.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="AMBER" src="http://www.qmsrs.com/qmsrstools/Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: The audit has been delayed.</p>
        </div>
    </div>	

    <div id="AuditTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>

    <div id="auditloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="schedule"></div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>


    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Audit Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="AuditDetailsTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <ul id="tabul" style="margin-top:35px;">
            <li id="Details" class="ntabs">Audit Information</li>
            <li id="ORGUnits" class="ntabs">Auditee Unit</li>
            <li id="Auditors" class="ntabs">Auditors</li>
            <li id="ScopeSummery" class="ntabs">Scope and Summary</li>
            <li id="Additional" class="ntabs">Additional Info</li>
        </ul>
        <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">

            <div id="validation_dialog_details">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Details" />
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="AUDTIDLabel" class="labeldiv">Audit ID:</div>
                <div id="AUDTIDField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="AUDTIDTxt" runat="server" CssClass="readonly" Width="90px"></asp:TextBox>
                </div>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AuditTitleLabel" class="requiredlabel">Audit Title:</div>
                <div id="AuditTitleField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="AUDTNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
                <div id="AUDTNMlimit" class="textremaining"></div>  
           
                <asp:RequiredFieldValidator ID="AUDTNMTxtVal" runat="server" Display="None" ControlToValidate="AUDTNMTxt" ErrorMessage="Enter the title of the audit" ValidationGroup="Details"></asp:RequiredFieldValidator>

                <asp:CustomValidator id="AUDTNMTxtFVal" runat="server" Display="None" ValidationGroup="Details" 
                ControlToValidate = "AUDTNMTxt" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProcessDocumentLabel" class="labeldiv">Process Document:</div>
                <div id="ProcessDocumentField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="DOCCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="DOC_LD" class="control-loader"></div>
                 
                <span id="DOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span>
    
            </div>

            <div id="SelectDOC" class="selectbox">
                <div id="closeSelect" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="DocumentTypeLabel" class="labeldiv" style="width:100px;">Document Type:</div>
                    <div id="DocumentTypeField" class="fielddiv" style="width:130px">
                        <asp:DropDownList ID="DOCTYP" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>

                    <div id="DOCTYP_LD" class="control-loader"></div> 
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AuditDateLabel" class="requiredlabel">Planned Audit Date:</div>
                <div id="AuditDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="AUDTDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
            
                <asp:RequiredFieldValidator ID="AUDTDTVal" runat="server" Display="None" ControlToValidate="AUDTDTTxt" ErrorMessage="Enter the planned audit date" ValidationGroup="Details"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="AUDTDTFVal" runat="server" ControlToValidate="AUDTDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Details"></asp:RegularExpressionValidator>  
                
                <asp:CustomValidator id="AUDTDTF3Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "AUDTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>   
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ActualAuditDateLabel" class="labeldiv">Actual Audit Date:</div>
                <div id="ActualAuditDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ACTAUDTDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>

                <asp:RegularExpressionValidator ID="ACTAUDTDTFVal" runat="server" ControlToValidate="ACTAUDTDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Details"></asp:RegularExpressionValidator>  
            
                <asp:CustomValidator id="ACTCLSDTFVal" runat="server" ValidationGroup="Details" 
                ControlToValidate = "ACTAUDTDTTxt" Display="None" ErrorMessage = "Actual audit date shouldn't be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="ACTAUDTDTF2Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "ACTAUDTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
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

                <asp:CompareValidator ID="ACTCLSDTF1Val" runat="server" ControlToCompare="ACTAUDTDTTxt"  ValidationGroup="Additional"
                ControlToValidate="ACTCLSDTTxt" ErrorMessage="Actual close date should be greater than or equals the actual audit date"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator> 

                <asp:CustomValidator id="ACTCLSDTF2Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "ACTCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator> 

            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AuditTypeLabel" class="requiredlabel">Audit Type:</div>
                <div id="AuditTypeField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="AUDTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>

                <div id="ADTTYP_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="AUDTTYPTxtVal" runat="server" Display="None" ControlToValidate="AUDTYPCBox" ErrorMessage="Select audit type" ValidationGroup="Details"></asp:RequiredFieldValidator>  
      
                <asp:CompareValidator ID="AUDTTYPVal" runat="server" ControlToValidate="AUDTYPCBox"
                Display="None" ErrorMessage="Select audit type" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Details"></asp:CompareValidator>
            </div>

            <div id="project" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="ProjectLabel" class="labeldiv">Select Project:</div>
                <div id="ProjectField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="PROJCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>   
                </div>
                <div id="PROJ_LD" class="control-loader"></div>
            </div>

            <div id="supplier" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="SupplierLabel" class="labeldiv">Select Supplier:</div>
                <div id="SupplierField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="SUPPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>   
                </div>
                <div id="SUPP_LD" class="control-loader"></div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AuditStatusLabel" class="requiredlabel">Audit Status:</div>
                <div id="AuditStatusField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="AUDTSTSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="AUDTSTS_LD" class="control-loader"></div> 

                <asp:RequiredFieldValidator ID="AUDTSTSTxtVal" runat="server" Display="None" ControlToValidate="AUDTSTSCBox" ErrorMessage="Select audit status" ValidationGroup="Details"></asp:RequiredFieldValidator>  
            
                <asp:CompareValidator ID="AUDTSTSVal" runat="server" ControlToValidate="AUDTSTSCBox"
                Display="None" ErrorMessage="Select audit status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Details"></asp:CompareValidator>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProgressLabel" class="requiredlabel">Audit Progress (%):</div>
                <div id="ProgressField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="PROGRSSTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>

                <asp:RequiredFieldValidator ID="PROGRSSTxtVal" runat="server" Display="None" ControlToValidate="PROGRSSTxt" ErrorMessage="Enter the progress of the audit process in (%)" ValidationGroup="Details"></asp:RequiredFieldValidator>  
            
                <asp:RegularExpressionValidator ID="PROGRSSFval" runat="server" ControlToValidate="PROGRSSTxt"
                Display="None" ErrorMessage="Percentage value should be between 0 and 100" ValidationExpression="^(100|[0-9]{1,2})?$" ValidationGroup="Details"></asp:RegularExpressionValidator>  
            </div>

            <div id="ISOSTD" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="SelectISOLabel" class="labeldiv" >Select ISO Standard:</div>
                <div id="SelectISOField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="SLCISOCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ISO_LD" class="control-loader"></div>  
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ISOCheckLabel" class="labeldiv">Select ISO Checklists:</div>
                <div id="ISOCheckField" class="fielddiv" style="width:250px">
                    <div id="ISOCHK" class="checklist" style="height:120px"></div>
                </div>
            </div>
        </div>
        <div id="ORGUnitsTB" class="tabcontent" style="display:none;height:450px;">

            <div class="toolbox">
                <img id="newORG" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Add New Organization Unit" alt=""/>
            </div>
            
            <div id="table" class="table" style="display:none;">
                <div id="row_header" class="tr">
                    <div id="col0_head" class="tdh" style="width:50px"></div>
                    <div id="col1_head" class="tdh" style="width:21%">ID</div>
                    <div id="col2_head" class="tdh" style="width:21%">ORG. Unit</div>
                    <div id="col3_head" class="tdh" style="width:21%">ORG. Level</div>
                    <div id="col4_head" class="tdh" style="width:21%">Location</div>
                </div>
            </div>
            
            <div id="SelectUnit" class="selectbox" style="top:15px; left:10px;">
                <div id="UNTClose" class="selectboxclose"></div>
                 <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="ORGUNTLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                    <div id="ORGUNTField" class="fielddiv" style="width:130px; left:0; float:left;">
                        <asp:DropDownList ID="ORGUNTCBox" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>

                    <div id="UNT_LD" class="control-loader"></div>   
                </div>
            </div>
          
        </div>

        <div id="AuditorsTB" class="tabcontent" style="display:none;height:450px;">
            <img id="newAuditor" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Add new Auditor" alt=""/>
         
            <div id="SelectEMP" class="selectbox" style="top:15px; left:10px;">
                <div id="EMPClose" class="selectboxclose"></div>
                    <div style="float:left; width:100%; height:20px; margin-top:5px;">
                        <div id="SelectEmployeeUnitLabel" class="labeldiv" style="width:100px;">Select Unit:</div>
                        <div id="SelectEmployeeUnitField" class="fielddiv" style="width:130px">
                            <asp:DropDownList ID="EMPUNTCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="EMPUNT_LD" class="control-loader"></div> 
                    </div>
                    <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="SelectEmployeeLabel" class="labeldiv" style="width:100px;">Select Employee:</div>
                    <div id="SelectEmployeeField" class="fielddiv" style="width:130px">
                        <asp:DropDownList ID="EMPCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AuditorsCHKLabel" class="labeldiv">Select Auditors:</div>
                <div id="AuditorsCHKField" class="fielddiv" style="width:250px">
                    <div id="AUDTCHK" class="checklist"></div>
                </div>
            </div>
        </div>

        <div id="ScopeSummeryTB" class="tabcontent" style="display:none;height:450px;">

            <div id="validation_dialog_scopesummery">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="ScopeSummery" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ScopeLabel" class="labeldiv">Scope:</div>
                <div id="ScopeField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="SCOPTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
        
                <asp:CustomValidator id="SCOPTxtVal" runat="server" ValidationGroup="ScopeSummery" Display="None" 
                ControlToValidate = "SCOPTxt" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>

            </div>

            <div style="float:left; width:100%; height:20px; margin-top:125px;">
                <div id="SummaryLabel" class="labeldiv">Summary:</div>
                <div id="summaryField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="SMMRYTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
        
                <asp:CustomValidator id="SMMRYTxtVal" runat="server" ValidationGroup="ScopeSummery" Display="None"
                ControlToValidate = "SMMRYTxt" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:125px;">
                <div id="CommentsLabel" class="labeldiv">Additional Comments:</div>
                <div id="CommentsField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="NOTETxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
        
                <asp:CustomValidator id="NOTETxtVal" runat="server" ValidationGroup="ScopeSummery" Display="None"
                ControlToValidate = "NOTETxt" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>
        <div id="AdditionalTB" class="tabcontent" style="display:none;height:450px;">
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="ORGUnitRecipientLabel" class="labeldiv">Select ORG. Unit:</div>
                <div id="ORGUnitRecipientField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="ORGUNTRECBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNT_LD" class="control-loader"></div> 
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RecipientsLabel" class="labeldiv">Select Audit Recipients:</div>
                <div id="RecipientsField" class="fielddiv" style="width:600px;">
                    <div id="RECCHK" class="checklist" style="height:200px;"></div>
                    <div style="width:52px; height:200px; float:left; margin-left:2px;">
                        <input id="Add" type="button" class="button" style="width:50px; margin-top:100px;" value="Add" />
                    </div>
                    <div id="ToCHK" class="checklist" style="height:200px; margin-left:2px;"></div>
                </div>
            </div>
        </div>
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <input id="data" type="hidden" value="" />
    <input id="audityear" type="hidden" value="" />    

</div>

<script type="text/javascript" language="javascript">
    $(function ()
    {
        /* show RAG tooltip */
        if ($("#RAGTooltip").is(":hidden"))
        {
            $("#RAGTooltip").slideDown(800, 'easeOutBounce');
        }

        $("#byYear").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('enumAuditYears', "#<%=AUDTYRCBox.ClientID%>", "#ADTYRF_LD");
            $("#AuditYearContainer").show();
        });

        $("#byRECMOD").bind('click', function () {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#byAUDTTYP").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadAuditType', "#<%=AUDTTYPFCBox.ClientID%>","#ADTTYPF_LD");
            $("#AuditTypeContainer").show();

        });

        $("#byAUDTSTS").bind('click', function () {
            hideAll();
            loadComboboxAjax('loadAuditStatus', "#<%=AUDTSTSFCBox.ClientID%>", "#AUDTSTSF_LD");
            $("#AuditStatusContainer").show();

         });

        $("#<%=AUDTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var $obj = $(this);

                $("#ADTTYP_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $(".modalPanel").css("cursor", "wait");

                    switch ($obj.val())
                    {
                        case "Internal":
                            $("#ADTTYP_LD").fadeOut(500, function ()
                            {
                                $(".modalPanel").css("cursor", "default");

                                $(".selectionfield").each(function () {
                                    $(this).fadeOut(500, function () {
                                    });
                                });
                            });
                            break;
                        case "Supplier":
                            $("#ADTTYP_LD").fadeOut(500, function () {

                                $(".modalPanel").css("cursor", "default");

                                $("#supplier").stop(true).hide().fadeIn(500, function () {
                                    loadSuppliers();
                                });

                                $("#project").fadeOut(500, function () {
                                });
                                
                            });
                            break;
                        case "Project":
                            $("#ADTTYP_LD").fadeOut(500, function () {

                                $(".modalPanel").css("cursor", "default");
                                $("#project").stop(true).hide().fadeIn(500, function () {
                                    loadProjects();
                                });

                                $("#supplier").fadeOut(500, function () {
                                });
                                
                            });
                            break;
                    }
                });
            }
       
        });

        $("#refresh").bind('click', function () {
            hideAll();

            /*define the schedule of the current year*/
            initYearMonthSchedule(new Date().getFullYear());

            /*Load the matrix with audit records according to month and year*/
            loadSchedule(new Date().getFullYear());

            /* set the year of the audit schedule*/
            $("#audityear").val(new Date().getFullYear());
        });

        $("#byPLNAUDT").bind('click', function ()
        {
            hideAll();
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

             $("#AuditDateContainer").show();
        });

        /*change the status of the audit, according to the progress value*/
        /*0% ------> Status=Pending*/
        /*>0% <90% ------> Status=InProgress*/
        /*>90% <99% ------> Status=InProgress*/
        /*100% ------> Status=Completed*/
        $("#<%=PROGRSSTxt.ClientID%>").keyup(function ()
        {
            if ($(this).val() == 0)
            {
                $("#<%=AUDTSTSCBox.ClientID%>").val('Pending');
            }
            else if ($(this).val() > 0 && $(this).val() < 90)
            {
                $("#<%=AUDTSTSCBox.ClientID%>").val('In Progress');
            }
            else if ($(this).val() >= 90 && $(this).val() <= 99)
            {
                $("#<%=AUDTSTSCBox.ClientID%>").val('Closing Down');
            }
            else if ($(this).val() == 100)
            {
                $("#<%=AUDTSTSCBox.ClientID%>").val('Completed');
            }

        });

        $("#<%=FDTTxt.ClientID%>").keyup(function ()
        {
            filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val());
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function ()
        {
            filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val());
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
           inline: true,
           dateFormat: "dd/mm/yy",
           onSelect: function (date) {
               filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val());
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date);
            }
        });

        $("#<%=AUDTYRCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                /*define the schedule of the selected year*/
                initYearMonthSchedule($(this).val());

                /*Load the matrix with audit records according to month and year*/
                loadSchedule($(this).val());

                /* set the year of the audit schedule*/
                $("#audityear").val($(this).val());
            }
        });
    
        $("#<%=AUDTTYPFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                /*define the schedule of the selected year*/
                initYearMonthSchedule($("#audityear").val());

                /*filter audits according to audit type*/
                filterByAuditType($(this).val(), $("#audityear").val());
            }
        });

        $("#<%=AUDTSTSFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {
                /*define the schedule of the selected year*/
                initYearMonthSchedule($("#audityear").val());

                /*filter audits according to audit status*/
                filterByAuditStatus($(this).val(), $("#audityear").val());
            }
        });


        $("#<%=RECMODCBox.ClientID%>").change(function () {
            if ($(this).val() != 0)
            {
                /*define the schedule of the selected year*/
                initYearMonthSchedule($("#audityear").val());

                /*filter audits according to audit mode*/
                filterByMode($(this).val(), $("#audityear").val());
            }
        });

        $('#orgtree').bind('tree.click', function (event) {
            //disable single selection
            event.preventDefault();

            if ($(this).tree('isNodeSelected', event.node)) {
                $(this).tree('removeFromSelection', event.node);
                removeUnit(event.node);
            }
            else {

                if (addUnit(event.node) == true) {
                    $(this).tree('addToSelection', event.node);
                }
            }
        });

        /*load all potential recipients to recipient checkbox*/
        $("#<%=ORGUNTRECBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var text = $(this).val();

                $("#ORGUNT_LD").stop(true).hide().fadeIn(500, function () {

                    $(".modulewrapper").css("cursor", "wait");

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'unit':'" + text + "'}",
                        url: getServiceURL().concat("getDepEmployees"),
                        success: function (data)
                        {
                            $("#ORGUNT_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                if (data) {
                                    var html = '';

                                    $(data.d).each(function (index, value) {
                                        html += "<div class='checkitem'>"
                                        html += "<input type='checkbox' id='" + value + "' name='checklist' value='" + value + "'/><div class='checkboxlabel'>" + value + "</div>";
                                        html += "</div>"
                                    });

                                    $("#RECCHK").append(html);
                                }
                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#ORGUNT_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#Add").bind('click', function () {
            setRecipients("#ToCHK");
        });

        $("#tabul li").bind("click", function () {
            navigate($(this).attr("id"));
        });

        $("#<%=SLCISOCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadISOChecklist($(this).val());
            }
        });
        $("#newAuditor").bind('click', function () {
            loadComboboxAjax('getOrganizationUnits', "#<%=EMPUNTCBox.ClientID%>", "#EMPUNT_LD");
            $("#<%=EMPCBox.ClientID%>").empty();

            $("#SelectEMP").show();
        });


        $("#<%=AUDTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=ACTAUDTDTTxt.ClientID%>").datepicker(
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
           { }
       });


        $("#<%=EMPUNTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                $("EMPUNT_LD").show();

                var loadcontrols = new Array();
                loadcontrols.push('#<%=EMPCBox.ClientID%>');

                unitparam = "'unit':'" + $(this).val() + "'";
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, $("#EMPUNT_LD"));
            }
        });

        $("#<%=EMPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                addAuditor($(this).val());
                $("#SelectEMP").hide('800');
            }
        });

        //code to control the choice of the document to process
        $("#<%=DOCSRCH.ClientID%>").bind('click', function ()
        {
            loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYP.ClientID%>", "#DOCTYP_LD");

            $("#<%=DOCCBox.ClientID%>").empty();

            $("#SelectDOC").show();
        });


        $("#<%=DOCTYP.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var text = $(this).val();

                $("#DOCTYP_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'type':'" + text + "'}",
                        url: getServiceURL().concat("filterDocumentByType"),
                        success: function (data)
                        {
                            $("#DOCTYP_LD").fadeOut(500, function ()
                            {
                                if (data)
                                {
                                    loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $("#<%=DOCCBox.ClientID%>"), $("#DOC_LD"));
                                }

                                $("#SelectDOC").hide("800");
                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#DOCTYP_LD").fadeOut(500, function ()
                            {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });


        $("#closeSelect").bind('click', function ()
        {
            $("#SelectDOC").hide("800");
        });

        /*define the schedule of the current year*/
        initYearMonthSchedule(new Date().getFullYear());

        /*Load the matrix with audit records according to month and year*/
        loadSchedule(new Date().getFullYear());

        /* set the year of the audit schedule*/
        $("#audityear").val(new Date().getFullYear());


        $("#save").bind('click', function ()
        {
            var isDetailsValid = Page_ClientValidate('Details');
            if (isDetailsValid)
            {
                if (!$("#validation_dialog_details").is(":hidden"))
                {
                    $("#validation_dialog_details").hide();
                }

                var isAdditionalValid = Page_ClientValidate('ScopeSummery');
                if (isAdditionalValid)
                {
                    if (!$("#validation_dialog_scopesummery").is(":hidden"))
                    {
                        $("#validation_dialog_scopesummery").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {

                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            var AUDTDTParts = getDatePart($("#<%=AUDTDTTxt.ClientID%>").val());
                            var ACTAUDTDTParts = getDatePart($("#<%=ACTAUDTDTTxt.ClientID%>").val());
                            var ACTCLSDTParts = getDatePart($("#<%=ACTCLSDTTxt.ClientID%>").val());
                           
                            var audit =
                            {
                                AuditNo: $.trim($("#<%=AUDTIDTxt.ClientID%>").val()),
                                AuditType: $("#<%=AUDTYPCBox.ClientID%>").val(),
                                AuditName: $("#<%=AUDTNMTxt.ClientID%>").val(),
                                PlannedAuditDate: new Date(AUDTDTParts[2], (AUDTDTParts[1] - 1), AUDTDTParts[0]),
                                ActualAuditDate: $("#<%=ACTAUDTDTTxt.ClientID%>").val() == '' ? null : new Date(ACTAUDTDTParts[2], (ACTAUDTDTParts[1] - 1), ACTAUDTDTParts[0]),
                                ActualCloseDate: $("#<%=ACTCLSDTTxt.ClientID%>").val() == '' ? null : new Date(ACTCLSDTParts[2], (ACTCLSDTParts[1] - 1), ACTCLSDTParts[0]),
                                ProcessDocument: $("#<%=DOCCBox.ClientID%>").val() == 0 || $("#<%=DOCCBox.ClientID%>").val() == null ? '' : $("#<%=DOCCBox.ClientID%>").val(),
                                Scope: $("#<%=SCOPTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=SCOPTxt.ClientID%>").val()),
                                Summery: $("#<%=SMMRYTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=SMMRYTxt.ClientID%>").val()),
                                Comments: $("#<%=NOTETxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=NOTETxt.ClientID%>").val()),
                                Auditors: getAuditorsJSON(),
                                Supplier: $("#<%=AUDTYPCBox.ClientID%>").val() == "Supplier" ? ($("#<%=SUPPCBox.ClientID%>").val() == 0 || $("#<%=SUPPCBox.ClientID%>").val() == null ? '' : $("#<%=SUPPCBox.ClientID%>").val()) : "",
                                Project: $("#<%=AUDTYPCBox.ClientID%>").val() == "Project" ? ($("#<%=PROJCBox.ClientID%>").val() == 0 || $("#<%=PROJCBox.ClientID%>").val() == null ? '' : $("#<%=PROJCBox.ClientID%>").val()) : "",
                                Completed: $("#<%=PROGRSSTxt.ClientID%>").val(),
                                CheckLists: getChecklistJSON(),
                                Units: $("#table").table('getJSON'),
                                AuditStatusString: $("#<%=AUDTSTSCBox.ClientID%>").val(),
                                Recipients: getRecipientsJSON()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(audit) + "\'}",
                                url: getServiceURL().concat("updateAudit"),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        showSuccessNotification(data.d);

                                        $("#cancel").trigger('click');

                                        $("#refresh").trigger('click');

                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
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
                    $("#validation_dialog_scopesummery").stop(true).hide().fadeIn(500, function ()
                    {
                        
                        navigate('ScopeSummery');
                    });
                }
            }
            else
            {
                $("#validation_dialog_details").stop(true).hide().fadeIn(500, function () {
                    
                    navigate('Details');
                });
            }
        });

        $("#newORG").bind('click', function ()
        {
            
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#UNT_LD");

            $("#SelectUnit").show();
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                addUnit($(this).val());

                $("#SelectUnit").hide('800');
            }
        });

        $("#UNTClose").bind('click', function ()
        {
            $("#SelectUnit").hide('800');
        });
    });

    function bindDocument(docname)
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadDocumentList"),
            success: function (data) {
                if (data) {
                    bindComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', docname, $("#<%=DOCCBox.ClientID%>"), $("#DOC_LD"));
                }

                $("#SelectDOC").hide("800");
            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                showErrorNotification(r.Message);
            }
        });
        
    }
    function bindUnits(data)
    {
        var units = $.parseXML(data);

        $(units).find('ORGUnit').each(function (j, unit)
        {
            $("#table").table('addRow',
            {
                ORGID: $(unit).attr('ORGID'),
                name: $(unit).attr('name'),
                ORGLevel: $(unit).attr('ORGLevel'),
                Country: $(unit).attr('Country'),
                Status: $(unit).attr('Status')
            });

        });
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


    function RecipientExists(control, employee)
    {
        var found = false;
        $(control).children().each(function (index, value) {
            if ($(this).find('.infotext').text() == employee) {
                found = true;
            }
        });

        return found;
    }

    function initializeUnits()
    {
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

        $("#table").table({ JSON: units, Attributes: attr, Settings: settings, Width: 21 });

    }
    

    function removeUnit(name)
    {
        $(".modulewrapper").css("cursor", "wait");

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'name':'" + name + "'}",
            url: getServiceURL().concat("getOrganizationUnitRecord"),
            success: function (data)
            {
                $(".modulewrapper").css("cursor", "default");

                var ORGUNTJSON = $.parseJSON(data.d);

                $("#table").table('removeRowAt', 'ORGID', ORGUNTJSON.ORGID);
            },
            error: function (xhr, status, error)
            {
                $(".modulewrapper").css("cursor", "default");

                var r = jQuery.parseJSON(xhr.responseText);
                showErrorNotification(r.Message);
            }
        });
    }

    function addUnit(name)
    {
        $(".modulewrapper").css("cursor", "wait");

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'name':'" + name + "'}",
            url: getServiceURL().concat("getOrganizationUnitRecord"),
            success: function (data)
            {
                $(".modulewrapper").css("cursor", "default");

                var ORGUNTJSON = $.parseJSON(data.d);

                $("#table").table('addRow',
                {
                    ORGID: ORGUNTJSON.ORGID,
                    name: ORGUNTJSON.name,
                    ORGLevel: ORGUNTJSON.ORGLevel,
                    Country: ORGUNTJSON.Country,
                    Status: 3
                });
            },
            error: function (xhr, status, error)
            {
                $(".modulewrapper").css("cursor", "default");

                var r = jQuery.parseJSON(xhr.responseText);
                showErrorNotification(r.Message);
            }
        });
    }

    function getAuditorsJSON()
    {
        var auditors = new Array();

        $("#AUDTCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function (index, value) {
                var auditor =
                {
                    NameFormat: $(this).parent().find('.checkboxlabel').text(),
                    Status: $(value).val()
                };
                auditors.push(auditor);
            });
        });

        return auditors;
    }

    function loadISOChecklist(standard)
    {
        $("#ISO_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modalPanel").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'isoname':'" + standard + "'}",
                url: getServiceURL().concat("getISOChecklist"),
                success: function (data) {
                    $("#ISO_LD").fadeOut(500, function ()
                    {
                        $(".modalPanel").css("cursor", "default");

                        if (data)
                        {
                            var checklist = JSON.parse(data.d);

                            $("#ISOCHK").empty();

                            $(checklist).each(function (index, value) {
                                var html = '';

                                html += "<div class='checkitem'>";
                                html += "<input type='checkbox' id='ISOPROC_" + value.ISOProcessID + "' name='checklist' value='" + 1 + "'/><div class='checkboxlabel'>" + value.name + "</div>";
                                html += "</div>";

                                $("#ISOCHK").append(html);

                                $("#ISOPROC_" + value.ISOProcessID).change(function () {
                                    if ($(this).is(":checked") == true) {
                                        $(this).val(3);
                                    }
                                    else {
                                        $(this).val(1);
                                    }
                                });

                            });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ISO_LD").fadeOut(500, function ()
                    {
                        $(".modalPanel").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function loadXMLISOChecklist(data)
    {
        var checklist = $.parseXML(data);

        if ($(checklist).find('ISOProcess').length == 0)
        {
            loadXMLISOStandards();
        
            $("#ISOSTD").show();
        }
        else
        {
            $("#ISOSTD").hide();
        }

        $(checklist).find('ISOProcess').each(function (index, value)
        {
            var html = '';
            html += "<div class='checkitem'>";
            html += "<input type='checkbox' id='ISOPROC_" + $(this).attr('ISOProcessID') + "' name='checklist' value='" + $(this).attr('Status') + "'/><div class='checkboxlabel'>" + $(this).attr('name') + "</div>";
            html += "</div>";

            $("#ISOCHK").append(html);

            $("#ISOPROC_" + $(this).attr('ISOProcessID')).prop('checked', true);

            $("#ISOPROC_" + $(this).attr('ISOProcessID')).change(function ()
            {
                if ($(this).is(":checked") == false)
                {
                    $(this).val(4);
                }
                else {
                    $(this).val(3);
                }
            });

        });
    }

    function loadXMLISOStandards() {

        $("#ISO_LD").stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISOStandards"),
                success: function (data) {
                    $("#ISO_LD").fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'ISOStandard', 'ISOName', $("#<%=SLCISOCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ISO_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function getChecklistJSON()
    {
        var checklist = new Array();
        $("#ISOCHK").children(".checkitem").each(function () {

            $(this).find('input').each(function (index, value)
            {
                var ID=$(value).attr('id').split("_");
                var process =
                {
                    ISOProcessID: ID[1],
                    Status: $(value).val()
                };
                checklist.push(process);
            });
        });

        if (checklist.length == 0)
            return null;

        return checklist;
    }
    function addAuditor(auditor)
    {
        var length = $("#AUDTCHK").children('.checkitem').length;

        var html = '';
        html += "<div class='checkitem'>";
        html += "<input type='checkbox' id='Employee_" + length + "' name='checklist' value='" + 3 + "'/><div class='checkboxlabel'>" + auditor + "</div>";
        html += "</div>";

        $("#AUDTCHK").append(html);

        $("#Employee_" + length).prop('checked', true);

        $("#Employee_" + length).change(function () {
            if ($(this).is(":checked") == false) {
                //remove the employee from the list
                $(this).parent().remove();
            }
        });
    }

    function loadAuditors(data)
    {
        var auditors = $.parseXML(data);
        $("#AUDTCHK").empty();

        $(auditors).find('Employee').each(function (index, value)
        {

            var html = '';
            html += "<div class='checkitem'>";
            html += "<input type='checkbox' id='Employee_" + index + "' name='checklist' value='" + 1 + "'/><div class='checkboxlabel'>" + $(this).attr('NameFormat') + "</div>";
            html += "</div>";

            $("#AUDTCHK").append(html);

            $("#Employee_" + index).prop('checked', true);

            $("#Employee_" + index).change(function () {
                if ($(this).is(":checked") == false) {
                    $(this).val(4);
                }
                else {
                    $(this).val(3);
                }
            });
        });

    }

    function removeAudit(auditno)
    {
        var result = confirm("There might be associated actions and findings related to the current audit, are you sure you would like to continue?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'auditno':'" + auditno + "'}",
                url: getServiceURL().concat('removeAudit'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    /*define the schedule of the current year*/
                    initYearMonthSchedule(new Date().getFullYear());

                    /*Load the matrix with audit records according to month and year*/
                    loadSchedule(new Date().getFullYear());

                    /* set the year of the audit schedule*/
                    $("#audityear").val(new Date().getFullYear());

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
    function filterByMode(mode, year)
    {
        $("#auditloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "','year':'" + year + "'}",
                url: getServiceURL().concat('filterByAuditMode'),
                success: function (data) {
                    $("#auditloader").fadeOut(500, function ()
                    {
                        $("#AuditTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of audit management records of the current year filtered by audit mode");

                            if (data) {
                                bindAuditRecord(data.d, 'Year');
                            }
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#auditloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByAuditType(type, year) {
        $("#auditloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "','year':'" + year + "'}",
                url: getServiceURL().concat('filterByAuditType'),
                success: function (data) {
                    $("#auditloader").fadeOut(500, function ()
                    {
                        $("#AuditTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of audit management records of the current year filtered by audit type");

                            if (data)
                            {
                                bindAuditRecord(data.d, 'Year');
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#auditloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByAuditStatus(status, year)
    {
        $("#auditloader").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "','year':'" + year + "'}",
                url: getServiceURL().concat('filterByAuditStatus'),
                success: function (data) {
                    $("#auditloader").fadeOut(500, function ()
                    {
                        $("#AuditTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of audit management records of the current year filtered by audit status");

                            if (data)
                            {
                                bindAuditRecord(data.d, 'Year');
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#auditloader").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByDateRange(start, end) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true) {
            $("#auditloader").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                var dateparam =
                {
                    StartDate: plannedstartdate,
                    EndDate: plannedenddate
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('filterAuditsByDate'),
                    success: function (data) {
                        $("#auditloader").fadeOut(500, function ()
                        {
                            $("#AuditTooltip").stop(true).hide().fadeIn(800, function ()
                            {
                                $(this).find('p').text("List of audit management records where the planned audit date range between " + plannedstartdate.format("dd/MM/yyyy") + " and " + plannedenddate.format("dd/MM/yyyy"));

                                if (data)
                                {
                                    loadDateSchedule(data.d);
                                }
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#auditloader").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
    }
    function loadSchedule(year)
    {
        $("#auditloader").stop(true).hide().fadeIn(500, function () {

           $(".modulewrapper").css("cursor", "wait");

           $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               data: "{'year':'" + year + "'}",
               url: getServiceURL().concat('getAuditsByYear'),
               success: function (data)
               {
                   $("#auditloader").fadeOut(500, function ()
                   {
                       $("#AuditTooltip").stop(true).hide().fadeIn(800, function () {

                           $(".modulewrapper").css("cursor", "default");

                           $(this).find('p').text("List of audit management records in year " + year);

                           if (data) {
                               bindAuditRecord(data.d, 'Year');
                           }
                       });
                   });
               },
               error: function (xhr, status, error)
               {
                   $("#auditloader").fadeOut(500, function ()
                   {
                       $(".modulewrapper").css("cursor", "default");

                       var r = jQuery.parseJSON(xhr.responseText);
                       showErrorNotification(r.Message);
                   });
               }
           });
        });
    }

    function bindAuditRecord(data,matrix)
    {

        var xml = $.parseXML(data);

        $(xml).find('AuditRecord').each(function (index, audit)
        {
            var planneddate = new Date($(this).attr('PlannedAuditDate'));
            var auditors = $.parseXML($(this).attr('XMLAuditors'));
            var htmlauditors = '';

            $(auditors).find('Employee').each(function (i, auditor) {
                if (i == 0) {
                    htmlauditors += $(this).attr('NameFormat');
                }
                else {
                    htmlauditors += " ;" + $(this).attr('NameFormat');
                }
            });

            /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
            var date = new Date();

         
            var sb = new StringBuilder();
            sb.append("<div id='row_" + index + "' class='tr'>");

            sb.append("<div id='Buttons_" + index + "' class='tdl' style='width:117px;  background-color:#f9f9f9;'>");
            sb.append("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' style='float:left;' title='Remove audit record'/>");
            sb.append("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton' style='float:left;' title='Edit audit Record'/>");
            sb.append("<img id='report_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/report.png' class='imgButton' style='float:left;' title='View report' />");
            sb.append("<img id='RAG_" + index + "' src='http://www.qmsrs.com/qmsrstools/RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('AuditID') + "&width=20&height=20&date=" + date.getSeconds() + "' class='imgButton' style='float:left;' title='RAG Status'/>");

            sb.append("</div>");

            sb.append("<div id='AuditNo_" + index + "' class='tdl' style='width:87px'>" + $(this).attr('AuditNo') + "</div>");
            sb.append("<div id='AuditType_" + index + "' class='tdl' style='width:87px'>" + $(this).attr('AuditType') + "</div>");
            sb.append("<div id='PlannedAuditDate_" + index + "' class='tdl' style='width:87px'>" + new Date($(this).attr('PlannedAuditDate')).format("dd/MM/yyyy") + "</div>");
            sb.append("<div id='ActualAuditDate_" + index + "' class='tdl' style='width:87px'>" + ($(this).find("ActualAuditDate").text() == '' ? '' : new Date($(this).find('ActualAuditDate').text()).format("dd/MM/yyyy")) + "</div>");
            sb.append("<div id='AuditStatus_" + index + "' class='tdl' style='width:87px'>" + $(this).attr('AuditStatusString') + "</div>");
            sb.append("<div id='Auditors_" + index + "' class='tdl' style='width:127px'>" + shortenText(htmlauditors) + "</div>");
            sb.append("<div id='Progress_" + index + "' title='Audit is " + $(this).attr('Completed') + "% completed'></div>");

            sb.append("</div>")
            
            if (matrix == "Year")
            {
                $("#" + planneddate.getMonth()).append(sb.toString());
            }
            else
            {
                $("#data_" + planneddate.format("ddMMyyyy")).append(sb.toString());

            }
            $("#delete_" + index).bind('click', function () {
                removeAudit($(audit).attr('AuditNo'));
            });

            $("#report_" + index).bind('click', function ()
            {
                var URL = getURL().concat("AuditManagement/AuditReport.aspx?AuditID=" + $(audit).attr('AuditID'));
                window.open(URL);
            });

            $("#edit_" + index).bind('click', function ()
            {
                /*clear previous data*/
                resetGroup('.modalPanel');

                /*load organization units*/
                initializeUnits();

                $("#<%=AUDTIDTxt.ClientID%>").val($(audit).attr('AuditNo'));
                $("#<%=AUDTNMTxt.ClientID%>").val($(audit).attr('AuditName'));
                
                bindDocument($(audit).attr('ProcessDocument'));
               
                /*bind planned audit date*/
                $("#<%=AUDTDTTxt.ClientID%>").val(new Date($(audit).attr('PlannedAuditDate')).format("dd/MM/yyyy"));

                /* bind actual audit date*/
                $("#<%=ACTAUDTDTTxt.ClientID%>").val($(audit).find("ActualAuditDate").text() == '' ? '' : new Date($(audit).find("ActualAuditDate").text()).format("dd/MM/yyyy"));

                /* bind actual close date*/
                $("#<%=ACTCLSDTTxt.ClientID%>").val($(audit).find("ActualCloseDate").text() == '' ? '' : new Date($(audit).find("ActualCloseDate").text()).format("dd/MM/yyyy"));

                $("#<%=PROGRSSTxt.ClientID%>").val($(audit).attr('Completed'));

                if ($(audit).attr('Scope') != '' && $(audit).attr('Scope') != null) {
                    if ($("#<%=SCOPTxt.ClientID%>").hasClass("watermarktext")) {
                        $("#<%=SCOPTxt.ClientID%>").val('').removeClass("watermarktext");
                    }

                    $("#<%=SCOPTxt.ClientID%>").html($(audit).attr('Scope')).text();
                }
                else {
                    addWaterMarkText('The scope of which the audit is focusing on', '#<%=SCOPTxt.ClientID%>');

                }

                if ($(audit).attr('Summery') != '' && $(audit).attr('Summery') != null) {
                    if ($("#<%=SMMRYTxt.ClientID%>").hasClass("watermarktext")) {
                        $("#<%=SMMRYTxt.ClientID%>").val('').removeClass("watermarktext");
                    }

                    $("#<%=SMMRYTxt.ClientID%>").html($(audit).attr('Summery')).text();
                }
                else {
                    addWaterMarkText('Add the summary of the audit', '#<%=SMMRYTxt.ClientID%>');
                }

                if ($(audit).attr('Comments') != '' && $(audit).attr('Comments') != null) {
                    if ($("#<%=NOTETxt.ClientID%>").hasClass("watermarktext")) {
                        $("#<%=NOTETxt.ClientID%>").val('').removeClass("watermarktext");
                    }

                    $("#<%=NOTETxt.ClientID%>").html($(audit).attr('Comments')).text();
                }
                else {
                    addWaterMarkText('Additional details in the support of the audit record', '#<%=NOTETxt.ClientID%>');
                }

                bindComboboxAjax('loadAuditType', "#<%=AUDTYPCBox.ClientID%>", $(audit).attr('AuditType'), "#ADTTYP_LD");
                bindComboboxAjax('loadAuditStatus', "#<%=AUDTSTSCBox.ClientID%>", $(audit).attr('AuditStatusString'), "#AUDTSTS_LD");

                loadXMLISOChecklist($(audit).attr('XMLChecklist'));

                bindUnits($(audit).attr('XMLUnits'));

                loadAuditors($(audit).attr('XMLAuditors'));

                
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTRECBox.ClientID%>", "#ORGUNT_LD");

                switch ($(audit).attr('AuditType')) {
                    case "Internal":
                        $(".selectionfield").each(function () {
                            $(this).fadeOut(500, function () {
                            });
                        });

                        break;
                    case "Supplier":
                       
                        $("#supplier").stop(true).hide().fadeIn(500, function () {
                            bindSuppliers($(audit).attr('Supplier'));
                        });

                        $("#project").fadeOut(500, function () {
                        });

                       
                        break;
                    case "Project":
                        $("#project").stop(true).hide().fadeIn(500, function ()
                        {
                            bindProjects($(audit).attr('Project'));
                        });

                        $("#supplier").fadeOut(500, function () {
                        });
                        break;
                }

                /*attach audit name to limit plugin*/
                $('#<%=AUDTNMTxt.ClientID%>').limit({ id_result: 'AUDTNMlimit', alertClass: 'alertremaining', limit: 90 });

                $('#<%=AUDTNMTxt.ClientID%>').keyup();

                if ($(audit).attr('AuditStatusString') == 'Completed' || $(audit).attr('AuditStatusString') == 'Cancelled')
                {
                    $("#AuditDetailsTooltip").find('p').text("Changes cannot take place since the audit status is " + $(audit).attr('AuditStatusString'));

                    if ($("#AuditDetailsTooltip").is(":hidden")) {
                        $("#AuditDetailsTooltip").slideDown(800, 'easeOutBounce');
                    }

                    /*disable all modal controls*/
                    ActivateAll(false);
                }
                else
                {
                    $("#AuditDetailsTooltip").hide();

                    /*enable all modal controls for editing*/
                    ActivateAll(true);
                }

                navigate('Details');

                $("#<%=alias.ClientID%>").trigger('click');
            });

            /* setup the progress bar indicator*/
            $("#Progress_" + index).progressbar(
            {
                value: parseInt($(audit).attr('Completed'))
            });
        });
    }
    
    function loadDateSchedule(data)
    {

        $("#schedule").empty();

        var xml = $.parseXML(data);

        var header =
        [
            { name: '' },
            { name: 'Audit No' },
            { name: 'Type' },
            { name: 'Planned Audit Date' },
            { name: 'Actual Audit Date' },
            { name: 'Audit Status' },
            { name: 'Auditors' },
            { name: 'Complete (%)' }
        ]

        $(header).each(function (index, value)
        {
            var sb = new StringBuilder();

            if (index == 0) {
                sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:10%; width:110px;'>");
                sb.append(value.name);
                sb.append("</div>");
            }
            else if (value.name == 'Auditors') {
                sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:1px; width:130px;'>");
                sb.append(value.name);
                sb.append("</div>");
            }
            else {
                sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:1px; width:90px;'>");
                sb.append(value.name);
                sb.append("</div>");
            }
            $("#schedule").append(sb.toString());
        });

        $(xml).find('AuditRecord').each(function (index, value)
        {
            if (dateExists(new Date($(value).attr('PlannedAuditDate')).format("dd/MM/yyyy")) == false)
            {
                var sb = new StringBuilder();

                sb.append("<div id=row_'" + index + "' class='row'>");
                sb.append("<div class='scheduledate'>");
                sb.append(new Date($(value).attr('PlannedAuditDate')).format("dd/MM/yyyy"));
                sb.append("</div>");

                sb.append("<div id='data_" + new Date($(value).attr('PlannedAuditDate')).format("ddMMyyyy") + "' class='data'>");
                sb.append("</div>");
                sb.append("</div>");

                $("#schedule").append(sb.toString());

            }

        });

        bindAuditRecord(data, 'Date');
    }
    function dateExists(date)
    {
        var exists = false;
        $("#schedule").children(".row").each(function ()
        {
            if ($(this).find('.scheduledate').text() == date)
            {
                exists = true;
            }
        });

        return exists;
    }
    function initYearMonthSchedule(year)
    {
        $("#schedule").empty();
        var schedule =
        [
            { name: 'January', Month: 0, Year: year },
            { name: 'February', Month: 1, Year: year },
            { name: 'March', Month: 2, Year: year },
            { name: 'April', Month: 3, Year: year },
            { name: 'May', Month: 4, Year: year },
            { name: 'June', Month: 5, Year: year },
            { name: 'July', Month: 6, Year: year },
            { name: 'August', Month: 7, Year: year },
            { name: 'September', Month: 8, Year: year },
            { name: 'October', Month: 9, Year: year },
            { name: 'November', Month: 10, Year: year },
            { name: 'December', Month: 11, Year: year }
        ]

        var header =
        [
            { name: '' },
            { name: 'Audit No' },
            { name: 'Type' },
            { name: 'Planned Date' },
            { name: 'Actual Date' },
            { name: 'Audit Status' },
            { name: 'Auditors' },
            { name: 'Complete (%)' }
        ]

        $(header).each(function (index, value)
        {
            var sb = new StringBuilder();

            if (index == 0)
            {
                sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:10%; width:110px;'>");
                sb.append(value.name);
                sb.append("</div>");
            }
            else if (value.name == 'Auditors')
            {
                sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:1px; width:130px;'>");
                sb.append(value.name);
                sb.append("</div>");
            }
            else
            {
                sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:1px; width:90px;'>");
                sb.append(value.name);
                sb.append("</div>");
            }
            $("#schedule").append(sb.toString());
        });

        $(schedule).each(function (index, value)
        {
            var sb = new StringBuilder();

            sb.append("<div id=row_'" + index + "' class='row'>");
            sb.append("<div class='scheduledate'>");
            sb.append(value.name + " " + value.Year);
            sb.append("</div>");

            sb.append("<div id='" + value.Month + "' class='data'>");
            sb.append("</div>");
            sb.append("</div>");

            $("#schedule").append(sb.toString());

        });
    }

   
    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
            $(".modalPanel").children().each(function ()
            {
                $(this).find('.textbox').each(function () {
                    $(this).removeClass("textbox");
                    $(this).addClass("readonlycontrolled");
                    $(this).attr('readonly', true);
                });

                $(this).find('.imgButton').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.combobox').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.groupbox').each(function () {
                    $(this).attr('disabled', true);
                });


                $(".textremaining").each(function () {
                    $(this).html('');
                });
            });

            $('#save').attr("disabled", true);
            $("#save").css({ opacity: 0.5 });
        }
        else
        {
            $(".modalPanel").children().each(function () {

                $(this).find('.readonlycontrolled').each(function () {
                    $(this).removeClass("readonlycontrolled");
                    $(this).addClass("textbox");
                    $(this).attr('readonly', false);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('.combobox').each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('.imgButton').each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('.groupbox').each(function () {
                    $(this).attr('disabled', false);
                });

            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }


    function ActivateSave(isactive)
    {
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

    
    function loadSuppliers()
    {
        $("#SUPP_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCustomers"),
                success: function (data)
                {
                    $("#SUPP_LD").fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Customer', 'CustomerName', $("#<%=SUPPCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#SUPP_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function bindSuppliers(supplier)
    {
        $("#SUPP_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCustomers"),
                success: function (data) {
                    $("#SUPP_LD").fadeOut(500, function () {

                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'Customer', 'CustomerName', supplier, $("#<%=SUPPCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#SUPP_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
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
                success: function (data)
                {
                    $("#PROJ_LD").fadeOut(500, function () {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'Project', 'ProjectName', project, $("#<%=PROJCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PROJ_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
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
                    $("#PROJ_LD").fadeOut(500, function ()
                    {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Project', 'ProjectName', $("#<%=PROJCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PROJ_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
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

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
</script>
</asp:Content>
