<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageAsset.aspx.cs" Inherits="QMSRSTools.AssetManagement.ManageAsset" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Asset_Header" class="moduleheader">Manage Assets</div>

    <div class="toolbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" alt="" title="Refresh Data" />
      
        <div id="filter_div">
            <img id="filter_icon" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byCAT">Filter by Asset Category</li>
                <li id="byINSTDT">Filter by Installation Date</li>
                <li id="byPURDT">Filter by Purchase Date</li>
                <li id="byASSTSTS">Filter by Asset Status</li>
                <li id="byORG">Filter by Organization Unit</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
    
    </div>

    <div id="InstallationDateContainer" class="filter">
        <div id="InstallationDateFLabel" class="filterlabel">Installation Date:</div>
        <div id="InstallationDateFField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="INSTFDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>

        <ajax:MaskedEditExtender ID="INSTTDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>
        
    <div id="PurchaseDateContainer" class="filter">
        <div id="PurchaseDateFLabel" class="filterlabel">Purchase Date:</div>
        <div id="PurchaseDateFField" class="filterfield">
            <asp:TextBox ID="PURFDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            <asp:Label ID="Label6" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="PURTDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="PURFDTTxtVal" runat="server" TargetControlID="PURFDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="PURTFTTxtVal" runat="server" TargetControlID="PURTDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>

    <div id="AssetCategoryContainer" class="filter">
        <div id="AssetCategoryFLabel" class="filterlabel">Asset Category:</div>
        <div id="AssetCategoryFField" class="filterfield">
            <asp:DropDownList ID="ASSTCATFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ASSTCATF_LD" class="control-loader"></div>
    </div>

    <div id="AssetOrganizationUnitContainer" class="filter">
        <div id="AssetOrganizationFLabel" class="filterlabel">Organization Unit:</div>
        <div id="AssetOrganizationFField" class="filterfield">
            <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
             </asp:DropDownList>
        </div>
        <div id="ORGUNTF_LD" class="control-loader"></div>
    </div>

    <div id="AssetStatusContainer" class="filter">
        <div id="AssetStatusFLabel" class="filterlabel">Asset Status:</div>
        <div id="AssetStatusFField" class="filterfield">
            <asp:DropDownList ID="ASSTSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ASSTSTSF_LD" class="control-loader"></div>
    </div>

    <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RECMODF_LD" class="control-loader"></div>
    </div>
    
    <div id="AssetTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>

    <div id="ASSTwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvAsset" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="TAG" HeaderText="Asset TAG" />
            <asp:BoundField DataField="Category" HeaderText="Category" />
            <asp:BoundField DataField="Supplier" HeaderText="Supplier" />
            <asp:BoundField DataField="Owner" HeaderText="Owner" />
            <asp:BoundField DataField="Price" HeaderText="Purchase Price" />
            <asp:BoundField DataField="PurchaseDate" HeaderText="Purchase Date" />
            <asp:BoundField DataField="InstallationDate" HeaderText="Installation Date" />
            <asp:BoundField DataField="Unit" HeaderText="ORG. Unit" />
            <asp:BoundField DataField="Status" HeaderText="Asset Status" />
            <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
        </Columns>
        </asp:GridView>
    </div>
    
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="Asset_Details" class="modalHeader">Asset Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="AssetDetailsTooltip" class="tooltip">
            <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <ul id="tabul" style="margin-top:20px;">
            <li id="Details" class="ntabs">Asset Information</li>
            <li id="Purchase" class="ntabs">Purchase Details</li>
            <li id="Owner" class="ntabs">Owner Information</li>
        </ul>
        <div id="DetailsTB" class="tabcontent">

            <div id="validation_dialog_general">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>

            <input id="assetID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="AssetCategoryLabel" class="requiredlabel">Asset Category:</div>
                <div id="AssetCategoryField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="ASSTCATCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="ASSTCAT_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="ASSTCATTxtVal" runat="server" Display="None" ControlToValidate="ASSTCATCBox" ErrorMessage="Select asset category" ValidationGroup="General"></asp:RequiredFieldValidator>   
           
                <asp:CompareValidator ID="ASSTCATVal" runat="server" ControlToValidate="ASSTCATCBox" 
                Display="None" ErrorMessage="Select asset category" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AssetTAGLabel" class="requiredlabel">Asset TAG:</div>
                <div id="AssetTAGField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="ASSTTAGTxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                
                <div id="TAGlimit" class="textremaining"></div>  
        
                <asp:RequiredFieldValidator ID="ASSTTAGTxtVal" runat="server" Display="None" ControlToValidate="ASSTTAGTxt" ErrorMessage="Enter the TAG of the asset" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:CustomValidator id="ASSTAGTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "ASSTTAGTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
                  
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OtherTAGLabel" class="labeldiv">Other TAG:</div>
                <div id="OtherTAGField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="OASSTTAGTxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                
                <div id="OTAGlimit" class="textremaining"></div>  
                
                <asp:CustomValidator id="OASSTTAGTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "OASSTTAGTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>  
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="SerialNoLabel" class="labeldiv">Serial Number:</div>
                <div id="SerialNoField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="SRLNOTxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                
                <div id="SNlimit" class="textremaining"></div> 
                 
                <asp:CustomValidator id="SRLNOTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "SRLNOTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="BarCodeLabel" class="labeldiv">Barcode:</div>
                <div id="BarCodeField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="BRCODETxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                
                <div id="BARlimit" class="textremaining"></div>  
                
                <asp:CustomValidator id="BRCODETxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "BRCODETxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ModelLabel" class="labeldiv">Model:</div>
                <div id="ModelField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="MODLTxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                <div id="MDLlimit" class="textremaining"></div>  
                
                <asp:CustomValidator id="MODLTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "MODLTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ManufacturerLabel" class="labeldiv">Manufacturer:</div>
                <div id="ManufacturerField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="MNFCTTxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                <div id="MNUlimit" class="textremaining"></div>  
        
                <asp:CustomValidator id="MNFCTTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "MNFCTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DescriptionLabel" class="labeldiv">Description:</div>
                <div id="DescriptionField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:122px;">
                <div id="AssetStatusLabel" class="requiredlabel">Asset Status:</div>
                <div id="AssetStatusField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="ASSTSTSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="ASSTSTS_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="ASSTSTSCBoxTxtVal" runat="server" Display="None" ControlToValidate="ASSTSTSCBox" ErrorMessage="Select asset status" ValidationGroup="General"></asp:RequiredFieldValidator>   
           
                <asp:CompareValidator ID="ASSTSTSCBoxVal" runat="server" ControlToValidate="ASSTSTSCBox"
                Display="None" ErrorMessage="Select asset status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
            </div>
        </div>
        <div id="PurchaseTB" class="tabcontent">

            <div id="validation_dialog_purchase">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Purchase" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="SupplierLabel" class="requiredlabel">Supplier:</div>
                <div id="SupplierField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="SUPPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>      
                </div>
                <div id="SUPP_LD" class="control-loader"></div>      

                <span id="SUPPSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting a supplier"></span>
      
                <asp:RequiredFieldValidator ID="SUPPLRTxtVal" runat="server" Display="None" ControlToValidate="SUPPCBox" ErrorMessage="Select a supplier" ValidationGroup="Purchase"></asp:RequiredFieldValidator>   
           
                <asp:CompareValidator ID="SUPPCBoxVal" runat="server" ControlToValidate="SUPPCBox"
                Display="None" ErrorMessage="Select a supplier" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Purchase"></asp:CompareValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="WorkRequestNoLabel" class="labeldiv">Work Request Number:</div>
                <div id="WorkRequestNoField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="WRKREQTxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                <div id="WREQlimit" class="textremaining"></div>  

                <asp:CustomValidator id="WRKREQTxtVal" runat="server" ValidationGroup="Purchase" 
                ControlToValidate = "WRKREQTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AccountingCodeLabel" class="labeldiv">Accounting Code:</div>
                <div id="AccountingCodeField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="ACCCODTxt" Width="240px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                </div>
                <div id="ACClimit" class="textremaining"></div>   
                
                <asp:CustomValidator id="ACCCODTxtVal" runat="server" ValidationGroup="Purchase" 
                ControlToValidate = "ACCCODTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="PurchaseDateLabel" class="requiredlabel">Purchase Date:</div>
                <div id="PurchaseDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="PURDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="PURDTTxtVal" runat="server" Display="None" ControlToValidate="PURDTTxt" ErrorMessage="Enter the purchase date" ValidationGroup="Purchase"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="PURDTTxtFVal" runat="server" ControlToValidate="PURDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Purchase"></asp:RegularExpressionValidator>

                <asp:CustomValidator id="PURDTTxtF2Val" runat="server" ValidationGroup="Purchase" 
                ControlToValidate = "PURDTTxt" Display="None" ErrorMessage = "Purchase date should not be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="PURDTVal" runat="server" ValidationGroup="Purchase" 
                ControlToValidate = "PURDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="PurchasePriceLabel" class="requiredlabel">Price:</div>
                <div id="PurchasePriceField" class="fielddiv" style="width:300px">
                    <asp:TextBox ID="PURCHTxt" runat="server" CssClass="textbox" Width="150px"></asp:TextBox>
                    <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:DropDownList ID="CURRCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                    </asp:DropDownList>     
                </div>     
                <div id="CURR_LD" class="control-loader"></div>  

                <asp:RequiredFieldValidator ID="PURCHTxtVal" runat="server" Display="None" ControlToValidate="PURCHTxt" ErrorMessage="Enter the price of the asset" ValidationGroup="Purchase"></asp:RequiredFieldValidator>
       
                <asp:RegularExpressionValidator ID="PURCHTxtFval" runat="server" ControlToValidate="PURCHTxt"
                Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="Purchase"></asp:RegularExpressionValidator>  
       
                <asp:RequiredFieldValidator ID="CURRCBoxTxtVal" runat="server" Display="None" ControlToValidate="CURRCBox" ErrorMessage="Select price currency" ValidationGroup="Purchase"></asp:RequiredFieldValidator>         
            
                <asp:CompareValidator ID="CURRCBoxVal" runat="server" ControlToValidate="CURRCBox" ValidationGroup="Purchase"
                Display="None" ErrorMessage="Select price currency" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="PurchaseOrderNumberLabel" class="labeldiv">Purchase Order Number:</div>
                <div id="PurchaseOrderNumberField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="EXTRORDRTxt" Width="120px" runat="server" CssClass="textbox">
                    </asp:TextBox>
                    <asp:CheckBox ID="BCHK" runat="server" AutoPostBack="false" CssClass="checkbox" Text="Billable" />
                </div>
                <div id="EXTOlimit" class="textremaining"></div>  

                <asp:CustomValidator id="EXTRORDRTxtVal" runat="server" ValidationGroup="Purchase" 
                ControlToValidate = "EXTRORDRTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CostCentreLabel" class="requiredlabel">Cost Centre:</div>
                <div id="CostCentreField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="CSTCNTRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="CNTR_LD" class="control-loader"></div>    

                <asp:RequiredFieldValidator ID="CSTCNTRCBoxTxtVal" runat="server" Display="None" ControlToValidate="CSTCNTRCBox" ErrorMessage="Select cost centre" ValidationGroup="Purchase"></asp:RequiredFieldValidator>   
            
                <asp:CompareValidator ID="CSTCNTRCBoxVal" runat="server" ControlToValidate="CSTCNTRCBox"
                Display="None" ErrorMessage="Select cost centre" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Purchase"></asp:CompareValidator>
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
                <div id="BillingCategoryLabel" class="requiredlabel">Billing Category:</div>
                <div id="BillingCategoryField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="BCATCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="BCAT_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="BCATCBoxTxtVal" runat="server" Display="None" ControlToValidate="BCATCBox" ErrorMessage="Select billing category" ValidationGroup="Purchase"></asp:RequiredFieldValidator>   
            
                <asp:CompareValidator ID="BCATCBoxVal" runat="server" ControlToValidate="BCATCBox"
                Display="None" ErrorMessage="Select billing category" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Purchase"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AcquisitionMethodLabel" class="requiredlabel">Acquisition Method:</div>
                <div id="AcquisitionMethodField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="ACQMTHDCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="ACQMTHD_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="ACQMTHDCBoxTxtVal" runat="server" Display="None" ControlToValidate="ACQMTHDCBox" ErrorMessage="Select acquisition method" ValidationGroup="Purchase"></asp:RequiredFieldValidator>   
           
                <asp:CompareValidator ID="ACQMTHDCBoxVal" runat="server" ControlToValidate="ACQMTHDCBox"
                Display="None" ErrorMessage="Select acquisition method" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Purchase"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AcquisitionDateLabel" class="requiredlabel">Acquisition Date:</div>
                <div id="AcquisitionDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ACQDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="ACQDTTxtVal" runat="server" Display="None" ControlToValidate="ACQDTTxt" ErrorMessage="Enter the acquisition date" ValidationGroup="Purchase"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="ACQDTTxtFVal" runat="server" ControlToValidate="ACQDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Purchase"></asp:RegularExpressionValidator>
            
                <asp:CustomValidator id="ACQDTVal" runat="server" Display="None" ValidationGroup="Purchase" 
                ControlToValidate = "ACQDTTxt" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="InstallationDateLabel" class="requiredlabel">Installation Date:</div>
                <div id="InstallationDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="INSTDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="INSTDTTxtVal" runat="server" Display="None" ControlToValidate="INSTDTTxt" ErrorMessage="Enter the installation date" ValidationGroup="Purchase"></asp:RequiredFieldValidator>
    
                <asp:RegularExpressionValidator ID="INSTDTFVal" runat="server" ControlToValidate="INSTDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Purchase"></asp:RegularExpressionValidator>
    
                <asp:CompareValidator ID="INSTDTF2Val" runat="server" ControlToCompare="PURDTTxt"  ValidationGroup="Purchase"
                ControlToValidate="INSTDTTxt" ErrorMessage="Installation date should be greater than or equals purchase date"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator> 

                <asp:CustomValidator id="INSTDTVal" runat="server" ValidationGroup="Purchase" 
                ControlToValidate = "INSTDTTxt" Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>
        
            <div id="DepreciationGroupHeader" class="groupboxheader" style=" margin-top:10px;">Depreciation</div>
            <div id="DepreciationGroupField" class="groupbox" style="height:75px">

                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="DepreciationMethodLabel" class="requiredlabel">Depreciation Method:</div>
                    <div id="DepreciationMethodField" class="fielddiv" style="width:250px">
                        <asp:DropDownList ID="DEPRMTHDCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>    
                    </div>
                    <div id="DEPMTHD_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="DEPRMTHDCBoxTxtVal" runat="server" Display="None" ControlToValidate="DEPRMTHDCBox" ErrorMessage="Select depreciation method" ValidationGroup="Purchase"></asp:RequiredFieldValidator>   
                
                    <asp:CompareValidator ID="DEPRMTHDCBoxVal" runat="server" ControlToValidate="DEPRMTHDCBox"
                    Display="None" ErrorMessage="Select depreciation method" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0" ValidationGroup="Purchase"></asp:CompareValidator>
                    </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="DepreciationLifeLabel" class="requiredlabel">Depreciation Life:</div>
                    <div id="DepreciationLifeField" class="fielddiv" style="width:200px">
                        <asp:TextBox ID="DEPRTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                        <asp:Label ID="Label2" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                        <asp:DropDownList ID="DEPRPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                        </asp:DropDownList>     
                    </div>     
                    <div id="DEPRPRD_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="DEPRVal" runat="server" Display="None" ControlToValidate="DEPRTxt" ErrorMessage="Enter the depreciation life" ValidationGroup="Purchase"></asp:RequiredFieldValidator>
               
                    <ajax:FilteredTextBoxExtender ID="DEPRFExt" runat="server" TargetControlID="DEPRTxt" FilterType="Numbers">
                    </ajax:FilteredTextBoxExtender>
               
                    <asp:CustomValidator id="DEPRTxtVal" runat="server" ValidationGroup="Purchase" 
                    ControlToValidate = "DEPRTxt" Display="None" ErrorMessage = "The depreciation lifecycle should be greater than zero"
                    ClientValidationFunction="validateZero">
                    </asp:CustomValidator>    

                    <asp:RequiredFieldValidator ID="DEPRPRDTxtVal" runat="server" Display="None" ControlToValidate="DEPRPRDCBox" ErrorMessage="Select depreciation life period" ValidationGroup="Purchase"></asp:RequiredFieldValidator>         
               
                    <asp:CompareValidator ID="DEPRPRDVal" runat="server" ControlToValidate="DEPRPRDCBox" ValidationGroup="Purchase"
                    Display="None" ErrorMessage="Select depreciation life period" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0"></asp:CompareValidator>
                    </div>
                </div>
            </div>
            <div id="OwnerTB" class="tabcontent">

                <div id="validation_dialog_owner">
                    <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="Owner" />
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="ORGUnitLabel" class="requiredlabel">Organization Unit:</div>
                    <div id="ORGUnitField" class="fielddiv" style="width:250px">
                        <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>    
                    </div>
                    <div id="ORGUNT_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="ORGUNTCBoxTxtVal" runat="server" Display="None" ControlToValidate="ORGUNTCBox" ErrorMessage="Select organization unit" ValidationGroup="Owner"></asp:RequiredFieldValidator>   
            
                    <asp:CompareValidator ID="ORGUNTCBoxVal" runat="server" ControlToValidate="ORGUNTCBox"
                    Display="None" ErrorMessage="Select organization unit" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0" ValidationGroup="Owner"></asp:CompareValidator>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="RoomLabel" class="labeldiv">Room No:</div>
                    <div id="RoomField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="ROOMTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                    </div>
    
                    <asp:CustomValidator id="ROOMTxtFVal" runat="server" ValidationGroup="Owner" 
                    ControlToValidate = "ROOMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator> 
                </div> 
       
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="FloorLabel" class="labeldiv">Floor No:</div>
                    <div id="FloorField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="FLOORTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                    </div>

                    <asp:CustomValidator id="FLOORTxtFVal" runat="server" ValidationGroup="Owner" 
                    ControlToValidate = "FLOORTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator> 
                </div>
      
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="AssetOwnerLabel" class="requiredlabel">Asset Owner:</div>
                    <div id="AssetOwnerField" class="fielddiv" style="width:250px">
                        <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>   
                    </div>      
                    <div id="Owner_LD" class="control-loader"></div>       
           
                    <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the asset"></span>
            
                    <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="Dynamic" CssClass="validator" ControlToValidate="OWNRCBox" ErrorMessage="Select the owner of the asset" ValidationGroup="Owner"></asp:RequiredFieldValidator>   
            
                    <asp:CompareValidator ID="OWNRCBoxVal" runat="server" ControlToValidate="OWNRCBox"
                    Display="None" ErrorMessage="Select the owner of the asset" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0" ValidationGroup="Owner"></asp:CompareValidator>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="AnotherOwnerLabel" class="labeldiv">Another Asset Owner:</div>
                    <div id="AnotherOwnerField" class="fielddiv" style="width:250px">
                        <asp:DropDownList ID="AOWNRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="AOwner_LD" class="control-loader"></div>    
                       
                    <span id="AOWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting another owner of the asset"></span>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ExternalAssetOwnerLabel" class="labeldiv">External Asset Owner:</div>
                    <div id="ExternalAssetOwnerField" class="fielddiv" style="width:250px">
                        <asp:DropDownList ID="EXTOWNRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>    
                    </div>
                    <div id="EXTOWNR_LD" class="control-loader"></div>       
                
                    <span id="EXTSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting external owner of the asset"></span>
                </div>
        
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="RemarksLabel" class="labeldiv">Additional Notes:</div>
                    <div id="RemarksField" class="fielddiv" style="width:400px;">
                        <asp:TextBox ID="RMRKTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                  
                    <asp:CustomValidator id="RMRKTxtVal" runat="server" ValidationGroup="Owner" 
                    ControlToValidate ="RMRKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                    ClientValidationFunction="validateSpecialCharactersLongText">
                    </asp:CustomValidator>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:92px;">
                    <div id="RetirementLabel" class="labeldiv">Retirement:</div>
                    <div id="RetirementField" class="fielddiv" style="width:250px">
                        <asp:TextBox ID="RTRMNTTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                    </div>

                    <asp:CustomValidator id="RTRMNTTxtFVal" runat="server" ValidationGroup="Owner" 
                    ControlToValidate ="RTRMNTTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                    ClientValidationFunction="validateSpecialCharactersLongText">
                    </asp:CustomValidator>
                </div> 

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="RetirementRemarksLabel" class="labeldiv">Retirement Remarks:</div>
                    <div id="RetirementRemarksField" class="fielddiv" style="width:400px;">
                        <asp:TextBox ID="RTRMNTRMRKTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                 
                    <asp:CustomValidator id="RTRMNTRMRKTxtFVal" runat="server" ValidationGroup="Owner" 
                    ControlToValidate ="RTRMNTRMRKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                    ClientValidationFunction="validateSpecialCharactersLongText">
                    </asp:CustomValidator>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:92px;">
                    <div id="DisposalDateLabel" class="labeldiv">Disposal Date:</div>
                    <div id="DisposalDateField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="DSPDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>
                
                    <asp:RegularExpressionValidator ID="DSPDTTxtVal" runat="server" ControlToValidate="DSPDTTxt"
                    Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Owner"></asp:RegularExpressionValidator>

                    <asp:CompareValidator ID="DSPDTTxtFVal" runat="server" ControlToCompare="INSTDTTxt"  ValidationGroup="Owner"
                    ControlToValidate="DSPDTTxt" ErrorMessage="Disposal date should be greater than or equals installation date"
                    Operator="GreaterThanEqual" Type="Date"
                    Display="None"></asp:CompareValidator> 

                    <asp:CustomValidator id="DSPDTTxtF1Val" runat="server" ValidationGroup="Owner" 
                    ControlToValidate = "DSPDTTxt" Display="None" ErrorMessage = "Enter a realistic date value"
                    ClientValidationFunction="validateDate">
                    </asp:CustomValidator>
                </div>
            </div>
        
            <div id="SelectParty" class="selectbox">
                <div id="closePRT" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="OwnerTypeLabel" class="labeldiv" style="width:100px;">External Type:</div>
                    <div id="OwnerTypeField" class="fielddiv" style="width:130px;">
                        <asp:DropDownList ID="PRTYTYPCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                        </asp:DropDownList> 
                    </div>
                    <div id="PRTYP_LD" class="control-loader"></div> 
                </div>
            </div>     
        
            <div id="SelectORG" class="selectbox">
                <div id="closeORG" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="SelectOrganizationLebel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                    <div id="SelectOrganizationField" class="fielddiv" style="width:130px;">
                        <asp:DropDownList ID="SORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                        </asp:DropDownList> 
                    </div>
                    <div id="SORGUNT_LD" class="control-loader"></div> 
                </div>
            </div>
        
            <div class="buttondiv">
                <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
                <input id="cancel" type="button" class="button" value="Cancel" />
            </div>
    </asp:Panel>
    <input id="invoker" type="hidden" value="" />
    <input id="partyinvoker" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">

    $(function () {
        var empty = $("#<%=gvAsset.ClientID%> tr:last-child").clone(true);

        loadAssets(empty);


        $("#refresh").bind('click', function () {
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

            loadComboboxAjax('loadAssetStatus', "#<%=ASSTSTSFCBox.ClientID%>", "#ASSTSTSF_LD");

            $("#AssetStatusContainer").show();
        });

        $("#byORG").bind('click', function () {
            hideAll();

            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTFCBox.ClientID%>", "#ORGUNTF_LD");

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
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        /*filter by installation date range*/
        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByInstallationDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByInstallationDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByInstallationDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
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
            if ($(this).val() != 0) {
                filterByAssetCategory($(this).val(), empty);
            }
        });

        $("#<%=ASSTSTSFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByAssetStatus($(this).val(), empty);
            }
        });

        $("#<%=RECMODCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByAssetMode($(this).val(), empty);
            }
        });
        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#tabul li").bind("click", function () {
            navigate($(this).attr("id"));
        });

        /*show organization unit box when hovering over asset owner, and another asset owner cboxes*/
        /*set the position according to mouse x and y coordination*/

        $("#<%=OWNRSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=AOWNRSelect.ClientID%>").click(function (e) {
            $("#invoker").val('AnotherOwner');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=SUPPSelect.ClientID%>").click(function (e) {
            $("#partyinvoker").val('Supplier');
            showPartyDialog(e.pageX, e.pageY);
        });

        $("#<%=EXTSelect.ClientID%>").click(function (e) {
            $("#partyinvoker").val('ExternalOwner');
            showPartyDialog(e.pageX, e.pageY);
        });

        /*populate the employees in owner, and another owner cboxes*/
        $("#<%=SORGUNTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                switch ($("#invoker").val()) {
                    case "Owner":
                        loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#Owner_LD");
                        break;
                    case "AnotherOwner":
                        loadcontrols.push("#<%=AOWNRCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#AOwner_LD");
                        break;
                }
                $("#SelectORG").hide('800');
            }
        });

        $("#<%=PRTYTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                switch ($("#partyinvoker").val()) {
                    case "Supplier":

                        loadParty($(this).val(), "#<%=SUPPCBox.ClientID%>", "#SUPP_LD");
                        break;
                    case "ExternalOwner":

                        loadParty($(this).val(), "#<%=EXTOWNRCBox.ClientID%>", "#EXTOWNR_LD");
                        break;
                }
                $("#SelectParty").hide('800');
            }
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /*close external owner type box*/
        $("#closePRT").bind('click', function () {
            $("#SelectParty").hide('800');
        });


        $("#<%=PURDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });


        $("#<%=ACQDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=INSTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=DSPDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#save").bind('click', function () {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid) {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var isPurchaseValid = Page_ClientValidate('Purchase');
                if (isPurchaseValid) {
                    if (!$("#validation_dialog_purchase").is(":hidden")) {
                        $("#validation_dialog_purchase").hide();
                    }

                    var isOwnerValid = Page_ClientValidate('Owner');
                    if (isOwnerValid) {
                        if (!$("#validation_dialog_owner").is(":hidden")) {
                            $("#validation_dialog_owner").hide();
                        }
                        var result = confirm("Are you sure you would like to submit changes?");
                        if (result == true) {

                            $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                                ActivateSave(false);

                                var purchaseDateParts = getDatePart($("#<%=PURDTTxt.ClientID%>").val());
                                var acquisitionDateParts = getDatePart($("#<%=ACQDTTxt.ClientID%>").val());
                                var installationDateParts = getDatePart($("#<%=INSTDTTxt.ClientID%>").val());
                                var disposeDateParts = getDatePart($("#<%=DSPDTTxt.ClientID%>").val());

                                var asset =
                                {
                                    AssetID: $("#assetID").val(),
                                    AssetCategory: $("#<%=ASSTCATCBox.ClientID%>").val(),
                                    TAG: $("#<%=ASSTTAGTxt.ClientID%>").val(),
                                    OtherTAG: $("#<%=OASSTTAGTxt.ClientID%>").val(),
                                    SerialNo: $("#<%=SRLNOTxt.ClientID%>").val(),
                                    BARCode: $("#<%=BRCODETxt.ClientID%>").val(),
                                    Model: $("#<%=MODLTxt.ClientID%>").val(),
                                    Manufacturer: $("#<%=MNFCTTxt.ClientID%>").val(),
                                    Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val()),
                                    AssetStatus: $("#<%=ASSTSTSCBox.ClientID%>").val(),
                                    Supplier: $("#<%=SUPPCBox.ClientID%>").val(),
                                    WorkRequestNO: $("#<%=WRKREQTxt.ClientID%>").val(),
                                    AccountingCode: $("#<%=ACCCODTxt.ClientID%>").val(),
                                    PurchaseDate: new Date(purchaseDateParts[2], (purchaseDateParts[1] - 1), purchaseDateParts[0]),
                                    PurchasePrice: $("#<%=PURCHTxt.ClientID%>").val(),
                                    CurrentValue: $("#<%=PURCHTxt.ClientID%>").val(),
                                    Currency: $("#<%=CURRCBox.ClientID%>").val(),
                                    ExternalPurchaseOrder: $("#<%=EXTRORDRTxt.ClientID%>").val(),
                                    IsBillable: $("#<%=BCHK.ClientID%>").is(':checked'),
                                    CostCentre: $("#<%=CSTCNTRCBox.ClientID%>").val(),
                                    OtherCostCentre: ($("#<%=OCSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=OCSTCNTRCBox.ClientID%>").val() == null ? '' : $("#<%=OCSTCNTRCBox.ClientID%>").val()),
                                    BillingCategory: $("#<%=BCATCBox.ClientID%>").val(),
                                    AcquisitionMethod: $("#<%=ACQMTHDCBox.ClientID%>").val(),
                                    AcquisitionDate: new Date(acquisitionDateParts[2], (acquisitionDateParts[1] - 1), acquisitionDateParts[0]),
                                    Installationdate: new Date(installationDateParts[2], (installationDateParts[1] - 1), installationDateParts[0]),
                                    DisposalDate: $("#<%=DSPDTTxt.ClientID%>").val() == '' ? null : new Date(disposeDateParts[2], (disposeDateParts[1] - 1), disposeDateParts[0]),
                                    DepreciationMethod: $("#<%=DEPRMTHDCBox.ClientID%>").val(),
                                    DepreciableLife: $("#<%=DEPRTxt.ClientID%>").val(),
                                    DepreciablePeriod: $("#<%=DEPRPRDCBox.ClientID%>").val(),
                                    Department: $("#<%=ORGUNTCBox.ClientID%>").val(),
                                    Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                                    AnotherOwner: ($("#<%=AOWNRCBox.ClientID%>").val() == 0 || $("#<%=AOWNRCBox.ClientID%>").val() == null ? '' : $("#<%=AOWNRCBox.ClientID%>").val()),
                                    ExternalOwner: ($("#<%=EXTOWNRCBox.ClientID%>").val() == 0 || $("#<%=EXTOWNRCBox.ClientID%>").val() == null ? '' : $("#<%=EXTOWNRCBox.ClientID%>").val()),
                                    Remarks: $("#<%=RMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMRKTxt.ClientID%>").val()),
                                    FloorNo: $("#<%=FLOORTxt.ClientID%>").val(),
                                    RoomNo: $("#<%=ROOMTxt.ClientID%>").val(),
                                    RetirementRemarks: $("#<%=RTRMNTRMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RTRMNTRMRKTxt.ClientID%>").val()),
                                    Retirement: $("#<%=RTRMNTTxt.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(asset) + "\'}",
                                    url: getServiceURL().concat('updateAsset'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function ()
                                        {
                                            showSuccessNotification(data.d);

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
                            });
                        }

                    }
                    else {
                        $("#validation_dialog_owner").stop(true).hide().fadeIn(500, function () {

                            navigate('Owner');
                        });
                    }
                }
                else {
                    $("#validation_dialog_purchase").stop(true).hide().fadeIn(500, function () {

                        navigate('Purchase');
                    });
                }
            }
            else {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {

                    navigate('Details');
                });
            }
        });


    });

    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 300, top: y - 60 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#SORGUNT_LD");
        $("#SelectORG").show();
    }

    function showPartyDialog(x, y) {
        $("#SelectParty").css({ left: x - 300, top: y - 60 });

        loadPartyType("#PRTYP_LD", "#<%=PRTYTYPCBox.ClientID%>");
        $("#SelectParty").show();
    }

    function loadPartyType(loader, control) {
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
        function loadParty(type,control,loader)
        {
            $(loader).stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'type':'" + type + "'}",
                    url: getServiceURL().concat("filterCustomerByType"),
                    success: function (data)
                    {
                        $(loader).fadeOut(500, function () {
                            if (data)
                            {
                                loadComboboxXML($.parseXML(data.d), 'Customer', 'CustomerName', $(control));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $(loader).fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
        function bindParty(value, control, loader)
        {
            $(loader).stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
               {
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   url: getServiceURL().concat("loadCustomers"),
                   success: function (data) {

                       $(loader).fadeOut(500, function ()
                       {
                           if (data)
                           {
                               bindComboboxXML($.parseXML(data.d), 'Customer', 'CustomerName', value, $(control));
                           }
                       });
                   },
                   error: function (xhr, status, error)
                   {
                       $(loader).fadeOut(500, function ()
                       {
                           var r = jQuery.parseJSON(xhr.responseText);
                           showErrorNotification(r.Message);
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
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

        function bindAcquisitionMethod(value) {
            $("#ACQMTHD_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadAcquisitionMethods"),
                    success: function (data) {
                        $("#ACQMTHD_LD").fadeOut(500, function () {
                            if (data) {
                                bindComboboxXML($.parseXML(data.d), 'Method', 'MethodName', value, $("#<%=ACQMTHDCBox.ClientID%>"));
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#ACQMTHD_LD").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

    function bindDepreciationMethod(value)
    {
        $("#DEPMTHD_LD").stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDepreciationMethods"),
                success: function (data)
                {
                    $("#DEPMTHD_LD").fadeOut(500, function ()
                    {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'Method', 'MethodName', value, $("#<%=DEPRMTHDCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#DEPMTHD_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
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
                success: function (data) {
                    $("#ASSTCATF_LD").fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $("#<%=ASSTCATFCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ASSTCATF_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function bindBillingCategory(value)
    {
        $("#BCAT_LD").stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadBillingCategories"),
                success: function (data) {
                    $("#BCAT_LD").fadeOut(500, function () {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', value, $("#<%=BCATCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#BCAT_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function bindAssetCategory(value)
    {
        $("#ASSTCAT_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadAssetCategories"),
                success: function (data)
                {
                    $("#ASSTCAT_LD").fadeOut(500, function ()
                    {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', value, $("#<%=ASSTCATCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ASSTCAT_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function filterByPurchaseDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#ASSTwait").stop(true).hide().fadeIn(800, function () {
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
                    success: function (data)
                    {
                        $("#ASSTwait").fadeOut(500, function () {

                            $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                         

                                $(this).find('p').text("List of current assets purchased between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));

                                loadGridView(data.d, empty);
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#ASSTwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByInstallationDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#ASSTwait").stop(true).hide().fadeIn(800, function ()
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
                        $("#ASSTwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of current assets installed between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));
                            });
                            loadGridView(data.d, empty);
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#ASSTwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByDepartment(department, empty) {
        $("#ASSTwait").stop(true).hide().fadeIn(800, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'department':'" + department + "'}",
                url: getServiceURL().concat('filterAssetsByDepartment'),
                success: function (data) {

                    $("#ASSTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').text("List of current assets filtered by organization unit");
                        });

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#ASSTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByAssetCategory(category, empty)
    {
        $("#ASSTwait").stop(true).hide().fadeIn(800, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat('filterAssetsByCategory'),
                success: function (data) {

                    $("#ASSTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of current assets filtered by their category");
                        });

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#ASSTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByAssetMode(mode, empty)
    {
        $("#ASSTwait").stop(true).hide().fadeIn(800, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterAssetsByMode'),
                success: function (data) {

                    $("#ASSTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function ()
                        {

                            $(this).find('p').text("List of current assets filtered by the record mode");
                        });

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ASSTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByAssetStatus(status, empty)
    {
        $("#ASSTwait").stop(true).hide().fadeIn(800, function ()
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

                    $("#ASSTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            $(this).find('p').text("List of current assets filtered by their status");
                        });

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ASSTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadAssets(empty)
    {
        $("#ASSTwait").stop(true).hide().fadeIn(800, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadAssets'),
                success: function (data)
                {
                    $("#ASSTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            $(this).find('p').text("List of current assets purchased in the current year");
                        });

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ASSTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#AssetTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadGridView(data, empty) {
        var xmlAssets = $.parseXML(data);

        var row = empty;

        $("#<%=gvAsset.ClientID%> tr").not($("#<%=gvAsset.ClientID%> tr:first-child")).remove();

        $(xmlAssets).find("Asset").each(function (index, value) {
            $("td", row).eq(0).html("<img id='archive" + index + "' src='/Images/archive.jpg' class='imgButton' />");
            $("td", row).eq(1).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(2).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");
            $("td", row).eq(3).html($(this).attr("TAG"));
            $("td", row).eq(4).html($(this).attr("AssetCategory"));
            $("td", row).eq(5).html($(this).attr("Supplier"));
            $("td", row).eq(6).html($(this).attr("Owner"));
            $("td", row).eq(7).html($(this).attr("PurchasePrice") + " " + $(this).attr("Currency"));
            $("td", row).eq(8).html(new Date($(this).attr("PurchaseDate")).format("dd/MM/yyyy"));
            $("td", row).eq(9).html(new Date($(this).attr("InstallationDate")).format("dd/MM/yyyy"));
            $("td", row).eq(10).html($(this).attr("Department"));
            $("td", row).eq(11).html($(this).attr("AssetStatus"));
            $("td", row).eq(12).html($(this).attr("ModeString"));

            $("#<%=gvAsset.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeAsset($(value).attr('AssetID'));
                    });
                }
                else if ($(this).attr('id').search('archive') != -1) {
                    $(this).bind('click', function () {
                        archiveAsset($(value).attr('AssetID'));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        resetGroup('.modalPanel');

                        /*bind asset ID*/
                        $("#assetID").val($(value).attr('AssetID'));

                        /*bind asset category value*/
                        bindAssetCategory($(value).attr("AssetCategory"));

                        /*bind asset TAG value*/
                        $("#<%=ASSTTAGTxt.ClientID%>").val($(value).attr('TAG'));

                        /*attach TAG number to limit plugin*/
                        $('#<%=ASSTTAGTxt.ClientID%>').limit({ id_result: 'TAGlimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind asset Other TAG value*/
                        $("#<%=OASSTTAGTxt.ClientID%>").val($(value).attr('OtherTAG'));

                        /*attach other TAG number to limit plugin*/
                        $('#<%=OASSTTAGTxt.ClientID%>').limit({ id_result: 'OTAGlimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind asset serial number*/
                        $("#<%=SRLNOTxt.ClientID%>").val($(value).attr('SerialNo'));

                        /*attach serial number to limit plugin*/
                        $('#<%=SRLNOTxt.ClientID%>').limit({ id_result: 'SNlimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind asset bar code number*/
                        $("#<%=BRCODETxt.ClientID%>").val($(value).attr('BARCode'));

                        /*attach barcode to limit plugin*/
                        $('#<%=BRCODETxt.ClientID%>').limit({ id_result: 'BARlimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind asset bar code number*/
                        $("#<%=MODLTxt.ClientID%>").val($(value).attr('Model'));

                        /*attach model to limit plugin*/
                        $('#<%=MODLTxt.ClientID%>').limit({ id_result: 'MDLlimit', alertClass: 'alertremaining', limit: 50 });

                        /*bind asset description*/
                        if ($(value).attr("Description") == '')
                        {
                            addWaterMarkText('The description of the asset', '#<%=DESCTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext"))
                            {
                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            //$("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text();
                            //$("#<%=DESCTxt.ClientID%>").val($(value).attr("Description"));
                            $("#<%=DESCTxt.ClientID%>").val($("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text());
                        }

                        /*bind asset manufacturer*/
                        $("#<%=MNFCTTxt.ClientID%>").val($(value).attr('Manufacturer'));

                        /*attach manufacturer to limit plugin*/
                        $('#<%=MNFCTTxt.ClientID%>').limit({ id_result: 'MNUlimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind asset status*/
                        bindComboboxAjax('loadAssetStatus', '#<%=ASSTSTSCBox.ClientID%>', $(value).attr("AssetStatus"), "#ASSTSTS_LD");

                        /*bind asset supplier*/
                        bindParty($(value).attr('Supplier'), "#<%=SUPPCBox.ClientID%>", "#SUPP_LD");

                        /*bind asset work request number*/
                        $("#<%=WRKREQTxt.ClientID%>").val($(value).attr('WorkRequestNO'));

                        /*attach work request number to limit plugin*/
                        $('#<%=WRKREQTxt.ClientID%>').limit({ id_result: 'WREQlimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind asset accounting code*/
                        $("#<%=ACCCODTxt.ClientID%>").val($(value).attr('AccountingCode'));

                        /*attach account code to limit plugin*/
                        $('#<%=ACCCODTxt.ClientID%>').limit({ id_result: 'ACClimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind asset pucrhase date*/
                        $("#<%=PURDTTxt.ClientID%>").val(new Date($(value).attr('PurchaseDate')).format("dd/MM/yyyy"));

                        /*bind asset pucrhase price*/
                        $("#<%=PURCHTxt.ClientID%>").val($(value).attr('PurchasePrice'));

                        /*bind purchase currency*/
                        bindComboboxAjax('loadCurrencies', '#<%=CURRCBox.ClientID%>', $(value).attr("Currency"), "#CURR_LD");

                        /*bind asset external purchase order*/
                        $("#<%=EXTRORDRTxt.ClientID%>").val($(value).attr('ExternalPurchaseOrder'));

                        /*attach external purchase order number to limit plugin*/
                        $('#<%=EXTRORDRTxt.ClientID%>').limit({ id_result: 'EXTOlimit', alertClass: 'alertremaining', limit: 50 });
                        
                        /*bind billable value*/
                        if ($(value).attr("IsBillable") == 'true') {
                            $("#<%=BCHK.ClientID%>").attr('checked', true);
                        }
                        else {
                            $("#<%=BCHK.ClientID%>").attr('checked', false);
                        }

                        /*bind cost centre*/
                        bindCostCentre('#<%=CSTCNTRCBox.ClientID%>', $(value).attr("CostCentre"),"#CNTR_LD");

                        /*bind other cost centre*/
                        bindCostCentre('#<%=OCSTCNTRCBox.ClientID%>', $(value).attr("OtherCostCentre"), "#OCNTR_LD");

                        /*bind billing category*/
                        bindBillingCategory($(value).attr("BillingCategory"));

                        /*bind acquisition method*/
                        bindAcquisitionMethod($(value).attr("AcquisitionMethod"));

                        /*bind acquisition date*/
                        $("#<%=ACQDTTxt.ClientID%>").val(new Date($(value).attr("AcquisitionDate")).format("dd/MM/yyyy"));

                        /*bind installation date*/
                        $("#<%=INSTDTTxt.ClientID%>").val(new Date($(value).attr("InstallationDate")).format("dd/MM/yyyy"));

                        /*bind depreciation method*/
                        bindDepreciationMethod($(value).attr("DepreciationMethod"));

                        /*bind depreciable life*/
                        $("#<%=DEPRTxt.ClientID%>").val($(value).attr("DepreciableLife"));

                        /*bind depreciation period*/
                        bindComboboxAjax('loadPeriod', "#<%=DEPRPRDCBox.ClientID%>", $(value).attr("DepreciablePeriod"), "#DEPRPRD_LD");

                        /*bind organization unit*/
                        bindComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", $(value).attr('Department'), "#ORGUNT_LD");

                        /*bind room and floor values */
                        $("#<%=ROOMTxt.ClientID%>").val($(value).attr("RoomNo"));
                        $("#<%=FLOORTxt.ClientID%>").val($(value).attr("FloorNo"));

                        /*bind asset retirement value*/
                        $("#<%=RTRMNTTxt.ClientID%>").val($(value).attr("Retirement"));


                        /*bind asset owner */
                        bindComboboxAjax('loadEmployees', '#<%=OWNRCBox.ClientID%>', $(value).attr("Owner"), "#Owner_LD");

                        /*bind another asset owner */
                        bindComboboxAjax('loadEmployees', '#<%=AOWNRCBox.ClientID%>', $(value).attr("AnotherOwner"), "#AOwner_LD");

                        /*bind external asset owner */
                        bindParty($(value).attr("ExternalOwner"), "#<%=EXTOWNRCBox.ClientID%>", "#EXTOWNR_LD");


                        /*bind remarks value*/
                        if ($(value).attr("Remarks") == '') {

                            addWaterMarkText('Additional details in the support of the asset record', '#<%=RMRKTxt.ClientID%>');
                        }
                        else {
                            if ($("#<%=RMRKTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=RMRKTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            //$("#<%=RMRKTxt.ClientID%>").html($(value).attr("Remarks")).text();
                            //$("#<%=RMRKTxt.ClientID%>").val($(value).attr("Remarks"));
                            $("#<%=RMRKTxt.ClientID%>").val($("#<%=RMRKTxt.ClientID%>").html($(value).attr("Remarks")).text());
                        }

                        /*bind retirement remarks value*/
                        if ($(value).attr("RetirementRemarks") == '') {
                            addWaterMarkText('Add retirement remarks for the asset record', '#<%=RTRMNTRMRKTxt.ClientID%>');
                        }
                        else {
                            if ($("#<%=RTRMNTRMRKTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=RTRMNTRMRKTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            //$("#<%=RTRMNTRMRKTxt.ClientID%>").html($(value).attr("RetirementRemarks")).text();
                            //$("#<%=RTRMNTRMRKTxt.ClientID%>").val($(value).attr("RetirementRemarks"));
                            $("#<%=RTRMNTRMRKTxt.ClientID%>").val($("#<%=RTRMNTRMRKTxt.ClientID%>").html($(value).attr("RetirementRemarks")).text());
                        }

                        /*bind disposal date value*/
                        $("#<%=DSPDTTxt.ClientID%>").val($(value).find("DisposalDate").text() == '' ? '' : new Date($(value).find("DisposalDate").text()).format("dd/MM/yyyy"));

                        /*set default tab navigation*/
                        navigate("Details");

                        /* if the asset is archived, then disable editing*/
                        if ($(value).attr('ModeString') == 'Archived') {
                            $("#AssetDetailsTooltip").find('p').text("Changes cannot take place since the asset record is archived");

                            if ($("#AssetDetailsTooltip").is(":hidden")) {
                                $("#AssetDetailsTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);

                        }
                        else
                        {
                            $("#AssetDetailsTooltip").hide();

                            /*enable all modal controls*/
                            ActivateAll(true);

                        }

                        $(".textbox").each(function () {
                            $(this).keyup();
                        });

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvAsset.ClientID%> tr:last-child").clone(true);
        });
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

    function removeAsset(ID)
    {
        var result = confirm("Are you sure you would like to remove the current asset record, and its associated data?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'assetID':'" + ID + "'}",
                url: getServiceURL().concat("removeAsset"),
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

    function archiveAsset(ID)
    {
        var result = confirm("Are you sure you would like to send this asset record to archive?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'assetID':'" + ID + "'}",
                url: getServiceURL().concat("archiveAsset"),
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

    function hideAll()
    {
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
