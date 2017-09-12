<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="ManageCalibration.aspx.cs" Inherits="QMSRSTools.AssetManagement.ManageCalibration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="AssetCalibration_Header" class="moduleheader">Manage Asset Calibration</div>
    
    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" alt="" title="Refresh Data" />
        <img id="new" src="../Images/new_file.png" class="imgButton" title="Add New Calibration Record" alt=""/>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="AssetTAGLabel" class="requiredlabel">Asset TAG:</div>
        <div id="AssetTAGField" class="fielddiv" style="width:250px">
            <asp:TextBox ID="ASSTTAGTxt" Width="240px" runat="server" CssClass="textbox">
            </asp:TextBox>
        </div>  
        <div id="Asset_LD" class="control-loader"></div>

        <span id="TAGSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the asset record"></span>      
        
        <asp:RequiredFieldValidator ID="ASSTTAGTxtVal" runat="server" Display="None" ControlToValidate="ASSTTAGTxt" ErrorMessage="Enter the TAG of the asset" ValidationGroup="TAG"></asp:RequiredFieldValidator>   
    </div>

    <div id="SearchAsset" class="selectbox" style="width:700px; height:250px; top:90px; left:150px;">
        <div class="toolbox">
        
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="selectBoxImg" alt=""/>

        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byCAT">Filter by Asset Category</li>
                <li id="byINSTDT">Filter by Installation Date</li>
                <li id="byPURDT">Filter by Purchase Date</li>
                <li id="byASSTSTS">Filter by Asset Status</li>
                <li id="byORG">Filter by Organization Unit</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>

        <div id="InstallationDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
            <div id="InstallationDateFLabel" style="width:120px;">Installation Date:</div>
            <div id="InstallationDateFField" style="width:270px; left:0; float:left;">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="INSTFDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="INSTTDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>
        
        <div id="PurchaseDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
            <div id="PurchaseDateFLabel" style="width:120px;">Purchase Date:</div>
            <div id="PurchaseDateFField" style="width:270px; left:0; float:left;">
                <asp:TextBox ID="PURFDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label6" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="PURTDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="PURFDTTxtVal" runat="server" TargetControlID="PURFDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="PURTFTTxtVal" runat="server" TargetControlID="PURTDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>

        <div id="AssetCategoryContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AssetCategoryFLabel" style="width:100px;">Asset Category:</div>
            <div id="AssetCategoryFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="ASSTCATFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ASSTCATF_LD" class="control-loader"></div>
        </div>

        <div id="AssetOrganizationUnitContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AssetOrganizationFLabel" style="width:100px;">Organization Unit:</div>
            <div id="AssetOrganizationFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ORGUNTF_LD" class="control-loader"></div>
        </div>

        <div id="AssetStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AssetStatusFLabel" style="width:100px;">Asset Status:</div>
            <div id="AssetStatusFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="ASSTSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ASSTSTSF_LD" class="control-loader"></div>
        </div>

        <div id="RecordModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
            <div id="RecordModeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RECMODF_LD" class="control-loader"></div>
        </div>

        <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
    
    </div>
    <div id="FLTR_LD" class="control-loader"></div> 
    
    <div id="AssetScroll" style="height:200px; width:100%; overflow:auto; margin-top:15px; float:left">
            <asp:GridView id="gvAssets" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:BoundField DataField="TAG" HeaderText="Asset TAG" />
                    <asp:BoundField DataField="Model" HeaderText="Model" />
                    <asp:BoundField DataField="AssetCategory" HeaderText="Category" />
                    <asp:BoundField DataField="PurchasePrice" HeaderText="Purchase Price" />
                    <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" />
                    <asp:BoundField DataField="HasCalibration" HeaderText="Has Calibration" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="AssetGroupHeader" class="groupboxheader" style=" margin-top:10px;">Asset Details</div>
    <div id="AssetGroupField" class="groupbox" style="height:170px">

        <img id="SaveGroup" src="../Images/save.png" class="imgButton" title="Save Changes" alt=""/>

        <div id="validation_dialog_calibrationgroup" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="CalibrationGroup" />
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="AssetCategoryLabel" class="labeldiv">Asset Category:</div>
            <div id="AssetCategoryField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="ASSTCATTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>

            <div id="CalibrationFreqLabel" class="requiredlabel">Calibration Frequency:</div>
            <div id="CalibrationFreqField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="CALIFREQTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                <asp:Label ID="Label3" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:DropDownList ID="CALIFREQPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                </asp:DropDownList>     
            </div>     
            <div id="CALIFPRD_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="CALIFREQVal" runat="server" Display="None" ControlToValidate="CALIFREQTxt" ErrorMessage="Enter the value of calibration frequency" ValidationGroup="CalibrationGroup"></asp:RequiredFieldValidator>
     
            <ajax:FilteredTextBoxExtender ID="CALIFREQFExt" runat="server" TargetControlID="CALIFREQTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>
     
            <asp:CustomValidator id="CALIFREQTxtVal" runat="server" ValidationGroup="CalibrationGroup" 
            ControlToValidate = "CALIFREQTxt" Display="None" ErrorMessage = "The calibration frequency should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator>   
            
            <asp:RequiredFieldValidator ID="CALIFREQPRDTxtVal" runat="server" Display="None" ControlToValidate="CALIFREQPRDCBox" ErrorMessage="Select calibration period" ValidationGroup="CalibrationGroup"></asp:RequiredFieldValidator>         
            
            <asp:CompareValidator ID="CALIFREQPRDVal" runat="server" ControlToValidate="CALIFREQPRDCBox" ValidationGroup="CalibrationGroup"
            Display="None" ErrorMessage="Select calibration period" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="HasCalibrationLabel" class="labeldiv">Has Calibration:</div>
            <div id="HasCalibrationField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="HSCALTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>

            <div id="AssetStatusLabel" class="labeldiv">Asset Status:</div>
            <div id="AssetStatusField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="ASSTSTSTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
           </div>     
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CalibrationStatusLabel" class="labeldiv">Calibration Status:</div>
            <div id="CalibrationStatusField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="CALSTSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList> 
            </div>     
            
            <div id="CALSTS_LD" class="control-loader"></div>

            <span id="CSTSADD" class="addnew" runat="server" title="Add new calibration status"></span>
            
            <div id="CalibrationDocumentLabel" class="labeldiv">Calibration Document:</div>
            <div id="CalibrationDocumentField" class="fielddiv" style="width:250px">
                 <asp:DropDownList ID="DOCCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="DOC_LD" class="control-loader"></div>
            <span id="CALDOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="InstallationDateLabel" class="labeldiv">Installation Date:</div>
            <div id="InstallationDateField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="INSTDTTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>     
        </div>
        
        <div id="SelectDOC" class="selectbox" style="top:110px;">
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

    </div>
    
    <div id="CALWait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>
    
    <div id="RAGTooltip" class="tooltip"  style="margin-top:20px; background-color:transparent;"> 
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="RED" src="../Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: Asset is overdue for calibration.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="GREEN" src="../Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: Asset will be due for calibration.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="AMBER" src="../Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: Asset is not due for calibration.</p>
        </div>
    </div>	

    
    <div id="table" class="table">    
        <div id="row_header" class="tr">
            <div id="col0_head" class="tdh" style="width:10%"></div>
            <div id="col1_head" class="tdh" style="width:13%">Purchase Order No.</div>
            <div id="col2_head" class="tdh" style="width:13%">Calibration Date</div>
            <div id="col3_head" class="tdh" style="width:13%">Due Date</div>
            <div id="col4_head" class="tdh" style="width:13%">Provider</div>
            <div id="col5_head" class="tdh" style="width:13%">Cost</div>
            <div id="col6_head" class="tdh" style="width:13%">Result</div>
        </div>
    </div>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Calibration Details<span id="close" class="modalclose" title="Close">X</span></div>
   
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="CalibrationTooltip" class="tooltip">
            <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <input id="CALID" type="hidden" value="" />

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="PurchaseOrderNumberLabel" class="requiredlabel">Purchase Order No.:</div>
            <div id="PurchaseOrderNumberField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="PURODRNOTxt" runat="server" Width="190px" CssClass="textbox"></asp:TextBox>
            </div>  
            
            <div id="PURlimit" class="textremaining"></div>  

            <asp:RequiredFieldValidator ID="PURODRNOVal" runat="server" Display="None" ControlToValidate="PURODRNOTxt" ErrorMessage="Enter the purchase order number of the calibration" ValidationGroup="General"></asp:RequiredFieldValidator>     
            
            <asp:CustomValidator id="PURODRNOTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "PURODRNOTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>          
       </div>

       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CalibrationDateLabel" class="requiredlabel">Calibration Date:</div>
            <div id="CalibrationDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CALDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="CALDTTxtVal" runat="server" Display="None" ControlToValidate="CALDTTxt" ErrorMessage="Enter calibration date" ValidationGroup="General"></asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ID="CALDTTxtFVal" runat="server" ControlToValidate="CALDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>
                    
            <asp:CustomValidator id="CALDTFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CALDTTxt" Display="None" ErrorMessage = "Calibration date should be greater than the installation date of the asset"
            ClientValidationFunction="compareInstallationDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="CALDTF1Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "CALDTTxt" Display="None" ErrorMessage = "Calibration date should not be in future"
            ClientValidationFunction="comparePast">
            </asp:CustomValidator>

            <asp:CustomValidator id="CALDTVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CALDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CalibrationDueDateLabel" class="labeldiv">Calibration Due Date:</div>
            <div id="CalibrationDueDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CALDUEDTTxt" runat="server" CssClass="readonly" Width="140px" ReadOnly="true"></asp:TextBox>
            </div>
        </div>

         <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="SupplierLabel" class="requiredlabel">Calibration Supplier:</div>
            <div id="SupplierField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="CALSUPPTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>

            <span id="SUPPSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for suppliers"></span>   
            
            <asp:RequiredFieldValidator ID="CALSUPPTxtVal" runat="server" Display="None" ControlToValidate="CALSUPPTxt" ErrorMessage="Select calibration supplier" ValidationGroup="General"></asp:RequiredFieldValidator>
        </div>

        <div id="SearchSupplier" class="selectbox" style="width:500px; height:250px; top:130px; left:150px;">
            <div class="toolbox">
                <div style="float:left; width:450px; height:20px; margin-top:4px;">
                    <div id="PartyTypeLabel" style="width:120px;">Party Type:</div>
                    <div id="PartyTypeField" style="width:150px;">
                        <asp:DropDownList ID="PRTYTYPCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                        </asp:DropDownList> 
                    </div>
                    <div id="PRTYP_LD" class="control-loader"></div>
                </div>
                <div id="suppclosebox" class="selectboxclose" style="margin-right:1px;"></div>
            </div>
            <div id="SUPPFLTR_LD" class="control-loader"></div> 
            <div id="scrollbarSUPP" style="height:200px; width:100%; overflow:auto; margin-top:15px; float:left">
                <asp:GridView id="gvSuppliers" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                    <Columns>
                        <asp:BoundField DataField="CustomerNo" HeaderText="Supplier No." />
                        <asp:BoundField DataField="CustomerType" HeaderText="Type" />
                        <asp:BoundField DataField="CustomerName" HeaderText="Name" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
        
         <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CalibrationCostLabel" class="requiredlabel">Calibration Cost:</div>
            <div id="CalibrationCostField" class="fielddiv" style="width:280px">
                <asp:TextBox ID="CALCOSTTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="CALCURRTxt" runat="server" Width="85px" CssClass="readonly" ReadOnly="true"></asp:TextBox> 
            </div>     
            <asp:RequiredFieldValidator ID="CALCOSTTxtVal" runat="server" Display="None" ControlToValidate="CALCOSTTxt" ErrorMessage="Enter the cost of the calibration" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <asp:RegularExpressionValidator ID="CALCOSTTxtFval" runat="server" ControlToValidate="CALCOSTTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CalibrationResultLabel" class="requiredlabel">Calibration Result:</div>
            <div id="CalibrationResultField" class="fielddiv" style="width:200px">
                <asp:DropDownList ID="CALRESCBox" AutoPostBack="false" runat="server" Width="200px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="CALRES_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="CALRESCBoxTxtVal" runat="server" Display="None" ControlToValidate="CALRESCBox" ErrorMessage="Select calibration result" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CompareValidator ID="CALRESCBoxVal" runat="server" ControlToValidate="CALRESCBox"
            Display="None" ErrorMessage="Select calibration result" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="TrendLabel" class="labeldiv">Trend:</div>
            <div id="TrendField" class="fielddiv" style="width:250px">
                <asp:CheckBox ID="TRNDCHK" runat="server" AutoPostBack="false" CssClass="checkbox" />
            </div>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CommentActionLabel" class="labeldiv">Comment/Action:</div>
            <div id="CommentActionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="ACTCMNTTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="ACTCMNTTxtVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "ACTCMNTTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
            
        </div>
        
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <asp:Panel ID="CalibrationStatusPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CALSTS_header" class="modalHeader">Create New Calibration Status<span id="CALSTSclose" class="modalclose" title="Close">X</span></div>
        
        <div id="CalibrationStatusSaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
        </div>
 
        <div id="validation_dialog_calibrationstatus" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="CalibrationStatus" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="StatusNameLabel" class="requiredlabel">Status Name:</div>
            <div id="StatusNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="STSNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            
            <div id="STSlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="STSNMVal" runat="server" Display="None" ControlToValidate="STSNMTxt" ErrorMessage="Enter the name of the calibration status" ValidationGroup="CalibrationStatus"></asp:RequiredFieldValidator> 
           
            <asp:CustomValidator id="STSNMTxtVal" runat="server" ValidationGroup="CalibrationStatus" 
            ControlToValidate = "STSNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="DESCTxtFVal" runat="server" ValidationGroup="CalibrationStatus" 
            ControlToValidate ="DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>

        <div class="buttondiv">
            <input id="CalibrationSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="CalibrationCancel" type="button" class="button" value="Cancel" />
        </div>   
    </asp:Panel>

    <asp:Button ID="alias" runat="server" style="display:none" />
    <asp:Button ID="cstsalias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="StatusExtender" runat="server" BehaviorID="StatusExtender" TargetControlID="cstsalias" PopupControlID="CalibrationStatusPanel" CancelControlID="CalibrationCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    
    <asp:Panel ID="panel1" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="panel1" PopupControlID="panel1" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    <input id="assetJSON" type="hidden" value="" /> 

    <input id="MODE" type="hidden" value="" /> 

</div>
<script type="text/javascript" language="javascript">
        $(function () {
            var empty = $("#<%=gvAssets.ClientID%> tr:last-child").clone(true);
            var emptySUPP = $("#<%=gvSuppliers.ClientID%> tr:last-child").clone(true);
     
            disable(true);

            $("#<%=SUPPSRCH.ClientID%>").bind('click', function ()
            {
                loadComboboxAjax('loadCustomerType', "#<%=PRTYTYPCBox.ClientID%>","#PRTYP_LD");

                loadSuppliers(emptySUPP);
                $("#SearchSupplier").show();
            });

            $("#<%=PRTYTYPCBox.ClientID%>").change(function () {
                filterSupplier($(this).val(), emptySUPP);
            });

            /* show RAG tooltip */
            if ($("#RAGTooltip").is(":hidden")) {
                $("#RAGTooltip").slideDown(800, 'easeOutBounce');
            }

            $("#deletefilter").bind('click', function () {
                hideAll();

                loadAssets(empty);
            });

            $("#byINSTDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#InstallationDateContainer").show();
            });

            $("#byPURDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=PURFDTTxt.ClientID%>").val('');
                $("#<%=PURTDTTxt.ClientID%>").val('');

                $("#PurchaseDateContainer").show();
            });

            $("#byASSTSTS").bind('click', function () {
                hideAll();

                loadComboboxAjax('loadAssetStatus', "#<%=ASSTSTSFCBox.ClientID%>","#ASSTSTSF_LD");

                $("#AssetStatusContainer").show();
            });

            $("#byORG").bind('click', function () {
                hideAll();

                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTFCBox.ClientID%>","#ORGUNTF_LD");

                $("#AssetOrganizationUnitContainer").show();
            });

            $("#byCAT").bind('click', function () {
                hideAll();

                loadAssetCategories();

                $("#AssetCategoryContainer").show();
            });

            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#RecordModeContainer").show();

                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>","#RECMODF_LD");
            });

            $("#suppclosebox").bind('click', function () {
                $("#SearchSupplier").hide('800');
            });

            /*filter by installation date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByInstallationDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });

           $("#<%=FDTTxt.ClientID%>").datepicker(
           {
               inline: true,
               dateFormat: "dd/mm/yy",
               onSelect: function (date) {
                   filterByInstallationDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
                }
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByInstallationDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
           {
               inline: true,
               dateFormat: "dd/mm/yy",
               onSelect: function (date) {
                   filterByInstallationDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
                }
            });

            /*filter by purchase date range*/
            $("#<%=PURFDTTxt.ClientID%>").keyup(function () {
                filterByPurchaseDateRange($(this).val(), $("#<%=PURTDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=PURTDTTxt.ClientID%>").keyup(function () {
                filterByPurchaseDateRange($("#<%=PURFDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=PURFDTTxt.ClientID%>").datepicker(
            {
               inline: true,
               dateFormat: "dd/mm/yy",
               onSelect: function (date) {
                   filterByPurchaseDateRange(date, $("#<%=PURTDTTxt.ClientID%>").val(), empty);
                }
            });

            $("#<%=PURTDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByPurchaseDateRange($("#<%=PURFDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $("#<%=ORGUNTFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByDepartment($(this).val(), empty);
                }
            });

            $("#<%=ASSTCATFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0)
                {
                    filterByCategory($(this).val(), empty);
                }
            });

            $("#<%=ASSTSTSFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0)
                {
                    filterByAssetStatus($(this).val(), empty);
                }
            });

            $("#<%=RECMODCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByAssetMode($(this).val(), empty);
                }
            });
            
            $("#<%=CALDOCSRCH.ClientID%>").click(function (e) {
                showDOCDialog(e.pageX, e.pageY);
            });

            $("#refresh").bind('click', function ()
            {
                if (("#assetJSON").val() != '') {

                    loadCalibrationList();
                }
                else
                {

                    alert("Please select an asset record");
                }
            });

            /* to add new calibration status*/
            $("#<%=CSTSADD.ClientID%>").bind('click', function ()
            {
                clearModal();

                $("#validation_dialog_calibrationstatus").hide();

                /*attach status to limit plugin*/
                $('#<%=STSNMTxt.ClientID%>').limit({ id_result: 'STSlimit', alertClass: 'alertremaining', limit: 50 });

                addWaterMarkText('The description of the calibration status', '#<%=DESCTxt.ClientID%>');
          
                $("#<%=cstsalias.ClientID%>").trigger('click');
            });


            $("#CALSTSclose").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#CalibrationCancel").trigger('click');
                }
            });

            $("#CalibrationSave").bind('click', function ()
            {
                var isPageValid = Page_ClientValidate('CalibrationStatus');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_calibrationstatus").is(":hidden"))
                    {
                        $("#validation_dialog_calibrationstatus").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {

                        $("#CalibrationStatusSaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            var status =
                            {
                                StatusName: $("#<%=STSNMTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(status) + "\'}",
                                url: getServiceURL().concat('createCalibrationStatus'),
                                success: function (data)
                                {
                                    $("#CalibrationStatusSaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#CalibrationCancel").trigger('click');

                                        var e = jQuery.Event("keydown");
                                        e.which = 13; // # Some key code value
                                        $("#<%=ASSTTAGTxt.ClientID%>").trigger(e);
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#CalibrationStatusSaveTooltip").fadeOut(500, function ()
                                    {
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
                    $("#validation_dialog_calibrationstatus").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
            });

            $("#<%=DOCTYP.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    var $obj = $(this);
                    $("#DOC_LD").stop(true).hide().fadeIn(800, function ()
                    {
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{'type':'" + $obj.val() + "'}",
                            url: getServiceURL().concat("filterDocumentByType"),
                            success: function (data)
                            {    
                                $("#DOC_LD").fadeOut(500, function ()
                                {
                                    if (data) {
                                        loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $("#<%=DOCCBox.ClientID%>"), $("DOCORG_LD"));

                                        $("#SelectDOC").hide('800');
                                    }
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#DOC_LD").fadeOut(500, function ()
                                {
                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);

                                    $("#SelectDOC").hide('800');
                                });
                            }
                        });
                    });
                }
            });

            $("#<%=TAGSelect.ClientID%>").click(function () {
                loadAssetCategories();
                loadAssets(empty);

                $("#SearchAsset").show();
            });

            $("#<%=CALDTTxt.ClientID%>").keyup(function () {
                if ($(this).val() != '') {
                    if ($("#<%=CALIFREQPRDCBox.ClientID%>").val() != 0) {
                        var period = $("#<%=CALIFREQPRDCBox.ClientID%>").find('option:selected').text();
                        var duration = parseInt($("#<%=CALIFREQTxt.ClientID%>").val());

                        $("#<%=CALDUEDTTxt.ClientID%>").val(getCalibrationDueDate($(this).val(), duration, period).format('dd/MM/yyyy'));
                    }
                }
            });

            $("#<%=CALDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    var period = $("#<%=CALIFREQPRDCBox.ClientID%>").find('option:selected').text();
                    var duration = parseInt($("#<%=CALIFREQTxt.ClientID%>").val());
                    $("#<%=CALDUEDTTxt.ClientID%>").val(getCalibrationDueDate(date, duration, period).format('dd/MM/yyyy'));
                }
            });

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

      
            $("#closeBox").bind('click', function () {
                $("#SearchAsset").hide('800');
            });

            $("#closedoc").bind('click', function () {
                $("#SelectDOC").hide('800');
            });

            
            $("#SaveGroup").bind('click', function () {
                var isPageValid = Page_ClientValidate('CalibrationGroup');
                if (isPageValid)
                {   
                    if (!$("#validation_dialog_calibrationgroup").is(":hidden"))
                    {
                        $("#validation_dialog_calibrationgroup").hide();
                    }

                    var result = confirm("Are you sure you would like to modify the asset's calibration details?");
                    if (result == true)
                    {
                        $find('<%= SaveExtender.ClientID %>').show();

                        var assetcalibration =
                        {
                            TAG: $("#<%=ASSTTAGTxt.ClientID%>").val(),
                            CalibrationFrequency: parseInt($("#<%=CALIFREQTxt.ClientID%>").val()),
                            CalibrationPeriod: $("#<%=CALIFREQPRDCBox.ClientID%>").val(),
                            CalibrationDocument: ($("#<%=DOCCBox.ClientID%>").val() == 0 || $("#<%=DOCCBox.ClientID%>").val() == null ? '' : $("#<%=DOCCBox.ClientID%>").val()),
                            CalibrationStatus: ($("#<%=CALSTSCBox.ClientID%>").val() == 0 || $("#<%=CALSTSCBox.ClientID%>").val() == null ? '' : $("#<%=CALSTSCBox.ClientID%>").val())
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(assetcalibration) + "\'}",
                            url: getServiceURL().concat('updateAssetCalibrationRecord'),
                            success: function (data)
                            {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                alert(data.d);

                                recalculateDueDates(assetcalibration.TAG, assetcalibration.CalibrationFrequency, assetcalibration.CalibrationPeriod);
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
                    $("#validation_dialog_calibrationgroup").stop(true).hide().fadeIn(500, function ()
                    {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
            });

            $("#save").bind('click', function ()
            {
                var isAssetTAGValid = Page_ClientValidate('TAG');
                if (isAssetTAGValid)
                {
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

                                var caldatepart = getDatePart($("#<%=CALDTTxt.ClientID%>").val());
                                var calduedatepart = getDatePart($("#<%=CALDUEDTTxt.ClientID%>").val());

                                if ($("#MODE").val() == "ADD") {
                                    var calibration =
                                    {
                                        PurchaseOrderNumber: $("#<%=PURODRNOTxt.ClientID%>").val(),
                                        ExtensionProvider: $("#<%=CALSUPPTxt.ClientID%>").val(),
                                        ExtensionCost: $("#<%=CALCOSTTxt.ClientID%>").val(),
                                        Currency: $("#<%=CALCURRTxt.ClientID%>").val(),
                                        ExtensionDate: calduedatepart == '' ? null : new Date(caldatepart[2], (caldatepart[1] - 1), caldatepart[0]),
                                        ExtensionDueDate: new Date(calduedatepart[2], (calduedatepart[1] - 1), calduedatepart[0]),
                                        ResultString: $("#<%=CALRESCBox.ClientID%>").val(),
                                        Trend: $("#<%=TRNDCHK.ClientID%>").is(':checked'),
                                        ActionNeededOrComment: $("#<%=ACTCMNTTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTCMNTTxt.ClientID%>").val())
                                    }

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: "{\'json\':\'" + JSON.stringify(calibration) + "\','TAG':'" + $("#<%=ASSTTAGTxt.ClientID%>").val() + "'}",
                                        url: getServiceURL().concat('createCalibration'),
                                        success: function (data) {
                                            $("#SaveTooltip").fadeOut(500, function () {
                                                ActivateSave(true);

                                                $("#cancel").trigger('click');

                                                loadCalibrationList();
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
                                }
                                else {
                                    var calibration =
                                    {
                                        ExtensionID: $("#CALID").val(),
                                        PurchaseOrderNumber: $("#<%=PURODRNOTxt.ClientID%>").val(),
                                        ExtensionProvider: $("#<%=CALSUPPTxt.ClientID%>").val(),
                                        ExtensionCost: $("#<%=CALCOSTTxt.ClientID%>").val(),
                                        Currency: $("#<%=CALCURRTxt.ClientID%>").val(),
                                        ExtensionDate: new Date(caldatepart[2], (caldatepart[1] - 1), caldatepart[0]),
                                        ExtensionDueDate: calduedatepart == '' ? null : new Date(calduedatepart[2], (calduedatepart[1] - 1), calduedatepart[0]),
                                        ResultString: $("#<%=CALRESCBox.ClientID%>").val(),
                                        Trend: $("#<%=TRNDCHK.ClientID%>").is(':checked'),
                                        ActionNeededOrComment: $("#<%=ACTCMNTTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTCMNTTxt.ClientID%>").val())
                                    }

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: "{\'json\':\'" + JSON.stringify(calibration) + "\'}",
                                        url: getServiceURL().concat('updateCalibration'),
                                        success: function (data) {
                                            $("#SaveTooltip").fadeOut(500, function () {
                                                ActivateSave(true);

                                                $("#cancel").trigger('click');

                                                loadCalibrationList();
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
                                }
                            });
                        }
                    }
                    else {
                        $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                            alert("Please make sure that all warnings highlighted in red color are fulfilled");
                        });
                    }
                }
                else
                {
                    alert("Please enter a valid asset TAG number");
                }

            });

            $("#new").bind('click', function ()
            {
                if ($("#assetJSON").val() != '')
                {
                    var asset = $.parseJSON($("#assetJSON").val());

                    if (asset.Mode == 'Archived')
                    {
                        alert("Cannot create a new calibration record to an archived asset");
                    }
                    else if (($("#<%=CALIFREQPRDCBox.ClientID%>").val() == 0 || $("#<%=CALIFREQPRDCBox.ClientID%>").val() == null) || $("#<%=CALIFREQTxt.ClientID%>").val() == 0) {
                        alert("Cannot create new calibration record because the calibration frequency property or its period has not been specified");
                    }
                    else
                    {
                        $("#validation_dialog_general").hide();

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

                            $(this).find('.checkbox').each(function () {
                                $(this).prop("checked", false);
                            });

                            $(".textremaining").each(function () {
                                $(this).html('');
                            });
                        });

                        $("#MODE").val("ADD");

                        /* set currency value for the calibration record*/
                        $("#<%=CALCURRTxt.ClientID%>").val(asset.Currency);


                        loadComboboxAjax('loadResult', '#<%=CALRESCBox.ClientID%>', "#CALRES_LD");

                        /*attach purchase order number to limit plugin*/
                        $('#<%=PURODRNOTxt.ClientID%>').limit({ id_result: 'PURlimit', alertClass: 'alertremaining', limit: 50 });

                        if ($("#<%=ACTCMNTTxt.ClientID%>").hasClass("watermarktext") == false)
                        {
                            addWaterMarkText('Additional comments or required action for the calibration record', '#<%=ACTCMNTTxt.ClientID%>');
                        }

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');


                    }
                }
                else
                {
                    alert("Please select an asset record");
                }
            });

            $("#<%=ASSTTAGTxt.ClientID%>").keydown(function (event)
            {
                var $obj = $(this);

                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13')
                {
                    $("#SearchAsset").hide('800');

                    $("#Asset_LD").stop(true).hide().fadeIn(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "wait");

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'TAG':'" + $obj.val() + "'}",
                            url: getServiceURL().concat('getAsset'),
                            success: function (data)
                            {
                                $("#Asset_LD").fadeOut(500, function ()
                                {
                                    $(".modulewrapper").css("cursor", "default");

                                    var xml = $.parseXML(data.d);
                                    var asset = $(xml).find('Asset');

                                    var assetjson =
                                    {
                                        AssetID: asset.attr('AssetID'),
                                        Mode: asset.attr('ModeString'),
                                        Currency: asset.attr('Currency'),
                                        InstallationDate: new Date(asset.attr('InstallationDate')).format("dd/MM/yyyy"),
                                    }

                                    /*serialize and temprary store json data*/
                                    $("#assetJSON").val(JSON.stringify(assetjson));

                                    if (asset.attr('HasCalibration') == 'false') {
                                        alert("Cannot create calibration record since the current asset's calibration settings has been disabled");

                                        disable(true);
                                        reset();

                                        $("#table .tr").not($("#table .tr:first-child")).remove();

                                        $("#assetJSON").val('');
                                    }
                                    else if (asset.attr('ModeString') == 'Archived') {
                                        alert("All asset's data and the associated calibration record are disabled since the asset is archived");

                                        $("#<%=ASSTCATTxt.ClientID%>").val(asset.attr('AssetCategory'));
                                        $("#<%=CALIFREQTxt.ClientID%>").val(asset.attr('CalibrationFrequency'));
                                        $("#<%=HSCALTxt.ClientID%>").val(asset.attr('HasCalibration') == 'true' ? 'Yes' : 'No');
                                        $("#<%=ASSTSTSTxt.ClientID%>").val(asset.attr('AssetStatus'));
                                        $("#<%=INSTDTTxt.ClientID%>").val(new Date(asset.attr('InstallationDate')).format("dd/MM/yyyy"));

                                        bindComboboxAjax('loadPeriod', $("#<%=CALIFREQPRDCBox.ClientID%>"), asset.attr('CalibrationPeriod'), "#CALIFPRD_LD");

                                        bindCalibrationStatus(asset.attr('CalibrationStatus'));
                                        bindCalibrationDocument(asset.attr('CalibrationDocument'));

                                        loadCalibrations(asset.attr('XMLCalibration'));

                                        disable(true);

                                    }
                                    else {
                                        disable(false);

                                        $("#<%=ASSTCATTxt.ClientID%>").val(asset.attr('AssetCategory'));
                                        $("#<%=CALIFREQTxt.ClientID%>").val(asset.attr('CalibrationFrequency'));
                                        $("#<%=HSCALTxt.ClientID%>").val(asset.attr('HasCalibration') == 'true' ? 'Yes' : 'No');
                                        $("#<%=ASSTSTSTxt.ClientID%>").val(asset.attr('AssetStatus'));
                                        $("#<%=INSTDTTxt.ClientID%>").val(new Date(asset.attr('InstallationDate')).format("dd/MM/yyyy"));

                                        bindComboboxAjax('loadPeriod', $("#<%=CALIFREQPRDCBox.ClientID%>"), asset.attr('CalibrationPeriod'), "#CALIFPRD_LD");

                                        bindCalibrationStatus(asset.attr('CalibrationStatus'));
                                        bindCalibrationDocument(asset.attr('CalibrationDocument'));

                                        loadCalibrations(asset.attr('XMLCalibration'));
                                    }
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#Asset_LD").fadeOut(500, function ()
                                {
                                    $(".modulewrapper").css("cursor", "default");


                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);

                                    disable(true);
                                    reset();

                                    $("#table .tr").not($("#table .tr:first-child")).remove();

                                    $("#assetJSON").val('');
                                });
                            }
                        });
                    });
                }
                
            });
        });

        function compareInstallationDate(sender, args)
        {
            var asset = $.parseJSON($("#assetJSON").val());

            var targetdatepart = getDatePart(args.Value);
            var installationdatepart = getDatePart(asset.InstallationDate);

            var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
            var installationdate = new Date(installationdatepart[2], (installationdatepart[1] - 1), installationdatepart[0]);

            if (targetdate > installationdate) {
                args.IsValid = true;
            }
            else {
                args.IsValid = false;
            }

            return args.IsValid;
        }

        function showDOCDialog(x, y)
        {
            $("#SelectDOC").css({ left: x - 270, top: y + 20 });
            loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYP.ClientID%>", "#DOCTYP_LD");
            $("#SelectDOC").show();
        }

        function bindCalibrationStatus(value)
        {
            $("#CALSTS_LD").stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadCalibrationStatus"),
                    success: function (data)
                    {
                        $("#CALSTS_LD").fadeOut(500, function ()
                        {
                            if (data) {
                                var xml = $.parseXML(data.d);

                                bindComboboxXML(xml, 'Status', 'StatusName', value, '#<%=CALSTSCBox.ClientID%>');
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#CALSTS_LD").fadeOut(500, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
        function bindCalibrationDocument(value)
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDocumentList"),
                success: function (data) {
                    if (data) {
                        var xml = $.parseXML(data.d);

                        bindComboboxXML(xml, 'DocFile', 'DOCTitle', value, $("#<%=DOCCBox.ClientID%>"));
                    }
                },
                error: function (xhr, status, error) {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
        function getCalibrationDueDate(date, duration, period) {
            var sd = getDatePart(date);

            var startDate = new Date(sd[2], (sd[1] - 1), sd[0]);


            var enddate = null;

            try {
                switch (period) {
                    case "Years":
                        enddate = startDate.addYears(parseInt(duration));
                        break;
                    case "Months":
                        enddate = startDate.addMonths(parseInt(duration));
                        break;
                    case "Days":
                        enddate = startDate.addDays(parseInt(duration));
                        break;
                }
            }

            catch (e) {
            }

            return enddate;
        }

        function loadCalibrationList()
        {
            $("#CALWait").stop(true).hide().fadeIn(800, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'TAG':'" + $("#<%=ASSTTAGTxt.ClientID%>").val() + "'}",
                    url: getServiceURL().concat('getAsset'),
                    success: function (data) {
                        $("#CALWait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var xml = $.parseXML(data.d);
                            var asset = $(xml).find('Asset');

                            loadCalibrations(asset.attr('XMLCalibration'));
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#CALWait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                            reset();
                            $("#table .tr").not($("#table .tr:first-child")).remove();
                        });
                    }
                });
            });
        }
        function recalculateDueDates(tag, duration, period) {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'TAG':'" + tag + "'}",
                url: getServiceURL().concat('getAsset'),
                success: function (data) {
                    var xml = $.parseXML(data.d);
                    var asset = $(xml).find('Asset');


                    var xmlCalibrations = asset.attr('XMLCalibration');

                    $(xmlCalibrations).find('AssetExtensions').each(function (index, value) {
                        var caldatepart = getDatePart(new Date($(value).attr('ExtensionDate')).format('dd/MM/yyyy'));

                        var calibration =
                        {
                            ExtensionID: $(value).attr('ExtensionID'),
                            PurchaseOrderNumber: $(value).attr('PurchaseOrderNumber'),
                            ExtensionProvider: $(value).attr('ExtensionProvider'),
                            ExtensionCost: $(value).attr('ExtensionCost'),
                            Currency: $(value).attr('Currency'),
                            ExtensionDate: new Date(caldatepart[2], (caldatepart[1] - 1), caldatepart[0]),
                            ExtensionDueDate: getCalibrationDueDate(new Date($(value).attr('ExtensionDate')).format('dd/MM/yyyy'), duration, period),
                            ResultString: $(value).attr('ResultString'),
                            Trend: $(value).attr('Trend'),
                            ActionNeededOrComment: $(value).attr('ActionNeededOrComment')
                        }


                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(calibration) + "\'}",
                            url: getServiceURL().concat('updateCalibration'),
                            success: function (data) {
                            },
                            error: function (xhr, status, error) {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            }
                        });
                    });

                    loadCalibrationList();
                },
                error: function (xhr, status, error) {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }

        function loadCalibrations(data)
        {
            
            var xmlCalibrations = $.parseXML(data);
            var total = 0;
            var sb = null;
            var asset = $.parseJSON($("#assetJSON").val());

            $("#table .tr").not($("#table .tr:first-child")).remove();

            $(xmlCalibrations).find('AssetExtensions').each(function (index, value) {
                /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                var date = new Date();

                sb = new StringBuilder();

                sb.append("<div id='row_data_" + index + "' class='tr'>");

                sb.append("<div id='Buttons_" + index + "' class='tdl' style='width:10%;  background-color:#f9f9f9;'>");
                sb.append("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' style='float:left;' title='Remove calibration'/>");
                sb.append("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton' style='float:left;' title='Edit calibration Record'/>");
                sb.append("<img id='RAG_" + index + "' src='../RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('ExtensionID') + "&width=20&height=20&date=" + date.getSeconds() + "' class='imgButton' style='float:left;' title='RAG Status'/>");

                sb.append("</div>");

                sb.append("<div id='Purchase_Order_" + index + "' class='tdl' style='width:13%'>");
                sb.append($(this).attr('PurchaseOrderNumber'));
                sb.append("</div>");

                sb.append("<div id='Calibration_Date" + index + "' class='tdl' style='width:13%'>");
                sb.append(new Date($(this).attr('ExtensionDate')).format('dd/MM/yyyy'));
                sb.append("</div>");

                sb.append("<div id='Calibration_Due_Date" + index + "' class='tdl' style='width:13%'>");
                sb.append(($(this).find("ExtensionDueDate").text() == '' ? '' : new Date($(this).find('ExtensionDueDate').text()).format("dd/MM/yyyy")));
                sb.append("</div>");

                sb.append("<div id='Calibration_Provider" + index + "' class='tdl' style='width:13%'>");
                sb.append($(this).attr("ExtensionProvider"));
                sb.append("</div>");

                sb.append("<div id='Calibration_Cost" + index + "' class='tdl' style='width:13%'>");
                sb.append($(this).attr("ExtensionCost") + " " + $(this).attr("Currency"));
                sb.append("</div>");

                sb.append("<div id='Calibration_Result" + index + "' class='tdl' style='width:13%'>");
                sb.append($(this).attr("ResultString"));
                sb.append("</div>");

                sb.append("</div>");

                total += parseFloat($(this).attr("ExtensionCost"));

                $("#table").append(sb.toString());

                $("#delete_" + index).bind('click', function () {
                    removeCalibration($(value).attr('ExtensionID'));
                });

                $("#edit_" + index).bind('click', function ()
                {
                    $("#validation_dialog_general").hide();

                    /* set the ID of the calibration*/
                    $("#CALID").val($(value).attr('ExtensionID'));

                    /* bind purchase order value*/
                    $("#<%=PURODRNOTxt.ClientID%>").val($(value).attr('PurchaseOrderNumber'));

                    /* bind calibration date*/
                    $("#<%=CALDTTxt.ClientID%>").val(new Date($(value).attr('ExtensionDate')).format('dd/MM/yyyy'));

                    /* bind calibration due date*/
                    $("#<%=CALDUEDTTxt.ClientID%>").val($(value).find("ExtensionDueDate").text() == '' ? '' : new Date($(value).find("ExtensionDueDate").text()).format("dd/MM/yyyy"));

                    /* bind calibration provider*/
                    $("#<%=CALSUPPTxt.ClientID%>").val($(value).attr("ExtensionProvider"));

                    /* bind calibration cost*/
                    $("#<%=CALCOSTTxt.ClientID%>").val($(value).attr("ExtensionCost"));

                    /* bind calibration currency*/
                    $("#<%=CALCURRTxt.ClientID%>").val($(value).attr("Currency"));

                    /* bind calibration result*/
                    bindComboboxAjax('loadResult', '#<%=CALRESCBox.ClientID%>', $(value).attr("ResultString"),"#CALRES_LD");

                    /*bind comments */
                    if ($(value).attr("ActionNeededOrComment") == '') {
                        addWaterMarkText('Additional comments or required action for the calibration record', '#<%=ACTCMNTTxt.ClientID%>');
                    }
                    else {
                        if ($("#<%=ACTCMNTTxt.ClientID%>").hasClass("watermarktext")) {
                            $("#<%=ACTCMNTTxt.ClientID%>").val('').removeClass("watermarktext");
                        }

                        $("#<%=ACTCMNTTxt.ClientID%>").html($(value).attr("ActionNeededOrComment")).text();
                    }


                    /*attach purchase order number to limit plugin*/
                    $('#<%=PURODRNOTxt.ClientID%>').limit({ id_result: 'PURlimit', alertClass: 'alertremaining', limit: 50 });
                    $('#<%=PURODRNOTxt.ClientID%>').keyup();

                    if ($(value).attr("Trend") == 'true') {
                        $("#<%=TRNDCHK.ClientID%>").attr('checked', true);
                    }
                    else {
                        $("#<%=TRNDCHK.ClientID%>").attr('checked', false);
                    }

                    if (asset.Mode == 'Archived')
                    {
                        $("#CalibrationTooltip").find('p').text("Changes cannot take place since the asset record is archived");

                        if ($("#CalibrationTooltip").is(":hidden"))
                        {
                            $("#CalibrationTooltip").slideDown(800, 'easeOutBounce');
                        }

                        ActivateAll(false);
                    }
                    else
                    {
                        $("#CalibrationTooltip").hide();
                        ActivateAll(true);
                    }

                    /* set modal mode to edit*/
                    $("#MODE").val("EDIT");

                    /*trigger modal popup extender*/
                    $("#<%=alias.ClientID%>").trigger('click');
                });
            });

            sb = new StringBuilder();

            sb.append("<div id='row_data_total' class='tr'>");

            sb.append("<div class='tdl' style='width:10%; background-color:#f9f9f9;'></div>");

            sb.append("<div class='tdl' style='width:13%; background-color:#f9f9f9;'></div>");

            sb.append("<div class='tdl' style='width:13%; background-color:#f9f9f9;'></div>");

            sb.append("<div class='tdl' style='width:13%; background-color:#f9f9f9;'></div>");

            sb.append("<div class='tdl' style='width:13%; background-color:#f9f9f9;'></div>");

            sb.append("<div id='Total' class='tdl' style='width:13%; font-weight:bold;'>Total Cost</div>");

            sb.append("<div id='Total_Value' class='tdl' style='width:13%; font-weight:bold;'>" + total.toFixed(2) + " " + asset.Currency + "</div>");


            sb.append("</div>");
            $("#table").append(sb.toString());

        }
        function ActivateAll(isactive) {
            if (isactive == false) {
                $(".modalPanel").children().each(function () {
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
            else {
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
        function removeCalibration(ID)
        {
            var result = confirm("Are you sure you would like to remove the selected calibration record?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'ID':'" + ID + "'}",
                    url: getServiceURL().concat('removeCalibration'),
                    success: function (data)
                    {
                        $(".modulewrapper").css("cursor", "default");

                        loadCalibrationList();
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
        function disable(value)
        {
            if (value == true)
            {
                $("#new").hide();
                $("#refresh").hide();

                $(".groupbox").attr('disabled', true);
                $(".groupbox").children().each(function ()
                {
                    $(this).find('.searchactive').each(function () {
                        $(this).attr('disabled', true);
                    });

                    $(this).find('.combobox').each(function () {
                        $(this).attr('disabled', true);
                    });

                    $(this).find('.imgButton').each(function () {
                        $(this).attr('disabled', true);
                    });
                });
            }
            else
            {
                $("#new").show();
                $("#refresh").show();

                $(".groupbox").attr('disabled', false);
                $(".groupbox").children().each(function ()
                {
                    $(this).find('.searchactive').each(function () {
                        $(this).attr('disabled', false);
                    });

                    $(this).find('.combobox').each(function () {
                        $(this).attr('disabled', false);
                    });

                    $(this).find('.imgButton').each(function () {
                        $(this).attr('disabled', false);
                    });
                });
            }
        }
        function filterByPurchaseDateRange(start, end, empty) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true) {

                $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
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
                        url: getServiceURL().concat('filterAssetsByPurchaseDate'),
                        success: function (data) {

                            $("#FLTR_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                loadGridView(data.d, empty);
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
        }

        function filterByInstallationDateRange(start, end, empty)
        {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true)
            {
                $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
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
                        url: getServiceURL().concat('filterAssetsByInstallationDate'),
                        success: function (data) {

                            $("#FLTR_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                loadGridView(data.d, empty);
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#FLTR_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        }
        function filterByDepartment(department, empty)
        {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'department':'" + department + "'}",
                    url: getServiceURL().concat('filterAssetsByDepartment'),
                    success: function (data) {

                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
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
        function filterByAssetMode(mode, empty)
        {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'mode':'" + mode + "'}",
                    url: getServiceURL().concat('filterAssetsByMode'),
                    success: function (data)
                    {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
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

        function filterByAssetStatus(status, empty)
        {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",
                    url: getServiceURL().concat('filterAssetsByStatus'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");
                            loadGridView(data.d, empty);
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

        function filterByCategory(category, empty) 
        {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'category':'" + category + "'}",
                    url: getServiceURL().concat('filterAssetsByCategory'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
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

        function loadAssets(empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{}",
                    url: getServiceURL().concat('loadAssets'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }

        function loadGridView(data, empty) {
            var xmlAssets = $.parseXML(data);

            var row = empty;

            $("#<%=gvAssets.ClientID%> tr").not($("#<%=gvAssets.ClientID%> tr:first-child")).remove();

            $(xmlAssets).find("Asset").each(function (index, value) {
                $("td", row).eq(0).html($(this).attr("TAG"));
                $("td", row).eq(1).html($(this).attr("Model"));
                $("td", row).eq(2).html($(this).attr("AssetCategory"));
                $("td", row).eq(3).html($(this).attr("PurchasePrice") + " " + $(this).attr("Currency"));
                $("td", row).eq(4).html($(this).attr("Manufacturer"));
                $("td", row).eq(5).html($(this).attr("HasCalibration") == 'true' ? 'Yes' : 'No');
                $("td", row).eq(6).html($(this).attr("AssetStatus"));

                $("#<%=gvAssets.ClientID%>").append(row);

                row = $("#<%=gvAssets.ClientID%> tr:last-child").clone(true);
            });

            $("#<%=gvAssets.ClientID%> tr").not($("#<%=gvAssets.ClientID%> tr:first-child")).each(function ()
            {
                $(this).bind('click', function ()
                {
                    $("#SearchAsset").hide('800');


                    $("#<%=ASSTTAGTxt.ClientID%>").val($("td", $(this)).eq(0).html());

                    var e = jQuery.Event("keydown");
                    e.which = 13; // # Some key code value
                    $("#<%=ASSTTAGTxt.ClientID%>").trigger(e);
                });
            });
        }

        function loadAssetCategories()
        {
            $("#ASSTCATF_LD").stop(true).hide().fadeIn(500, function () {

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadAssetCategories"),
                    success: function (data)
                    {
                        $("#ASSTCATF_LD").fadeOut(500, function () {
                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $("#<%=ASSTCATFCBox.ClientID%>"));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#ASSTCATF_LD").fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }

        function filterSupplier(value, empty) {
            $("#SUPPFLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'type':'" + value + "'}",
                    url: getServiceURL().concat('filterCustomerByType'),
                    success: function (data) {
                        $("#SUPPFLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadSupplierGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#SUPPFLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
        function loadSuppliers(empty) {
            $("#SUPPFLTR_LD").stop(true).hide().fadeIn(500, function ()
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
                        $("#SUPPFLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadSupplierGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#SUPPFLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }

        function loadSupplierGridView(data, empty)
        {
            var xmlCustomers = $.parseXML(data);

            var row = empty;

            $("#<%=gvSuppliers.ClientID%> tr").not($("#<%=gvSuppliers.ClientID%> tr:first-child")).remove();

            $(xmlCustomers).find("Customer").each(function (index, value) {
                $("td", row).eq(0).html($(this).attr("CustomerNo"));
                $("td", row).eq(1).html($(this).attr("CustomerType"));
                $("td", row).eq(2).html($(this).attr("CustomerName"));


                $("#<%=gvSuppliers.ClientID%>").append(row);
                row = $("#<%=gvSuppliers.ClientID%> tr:last-child").clone(true);
            });

            $("#<%=gvSuppliers.ClientID%> tr").not($("#<%=gvSuppliers.ClientID%> tr:first-child")).bind('click', function ()
            {
                $("#SearchSupplier").hide('800');
                $("#<%=CALSUPPTxt.ClientID%>").val($("td", $(this)).eq(2).html());
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

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
