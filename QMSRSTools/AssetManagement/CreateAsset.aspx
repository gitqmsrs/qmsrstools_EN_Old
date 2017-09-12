<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateAsset.aspx.cs" Inherits="QMSRSTools.AssetManagement.CreateAsset" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Asset_Header" class="moduleheader">Create New Asset Record</div>
    
    <div class="toolbox">
        <img id="save" src="<%=GetSitePath() + "/Images/save.png" %>" class="imgButton" title="Save Changes" alt=""/>
    </div>

    <ul id="tabul">
        <li id="Details" class="ntabs">Asset Details</li>
        <li id="Purchase" class="ntabs">Purchase Details</li>
        <li id="Owner" class="ntabs">Owner Information</li>
        <li id="Lifecycle" class="ntabs">Asset Lifecycle</li>
    </ul>

    <div id="DetailsTB" class="tabcontent" style="display:none; height:520px;">
        <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="AssetCategoryLabel" class="requiredlabel">Asset Category:</div>
            <div id="AssetCategoryField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="ASSTCATCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="ASSTCAT_LD" class="control-loader"></div>

            <span id="CATADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new asset category"></span>

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

            <span id="ASTSTSADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new asset status"></span>

            <asp:RequiredFieldValidator ID="ASSTSTSCBoxTxtVal" runat="server" Display="None" ControlToValidate="ASSTSTSCBox" ErrorMessage="Select asset status" ValidationGroup="General"></asp:RequiredFieldValidator>   
           
             <asp:CompareValidator ID="ASSTSTSCBoxVal" runat="server" ControlToValidate="ASSTSTSCBox"
            Display="None" ErrorMessage="Select asset status" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>

    </div>
    <div id="PurchaseTB" class="tabcontent" style="display:none; height:520px;">
        
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
            
            <asp:CustomValidator id="PURDTFVal" runat="server" ValidationGroup="Purchase" 
            ControlToValidate = "PURDTTxt"  Display="None" ErrorMessage = "Purchase date should not be in future"
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
          
            <span id="CNTRADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new cost centre"></span>

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

            <span id="BCATADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new billing category"></span>

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

            <span id="ACQADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new acquisition method"></span>

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
            
            <asp:CustomValidator id="INSTDTVal" runat="server" ValidationGroup="Purchase" 
            ControlToValidate = "INSTDTTxt" Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        
            <asp:RegularExpressionValidator ID="INSTDTFVal" runat="server" ControlToValidate="INSTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Purchase"></asp:RegularExpressionValidator>
    
            <asp:CompareValidator ID="INSTDTF2Val" runat="server" ControlToCompare="PURDTTxt"  ValidationGroup="Purchase"
            ControlToValidate="INSTDTTxt" ErrorMessage="Installation date should be greater than or equals purchase date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator> 

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

                <span id="DEPMTHDADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new depreciation method"></span>

                <asp:RequiredFieldValidator ID="DEPRMTHDCBoxTxtVal" runat="server" Display="None" ControlToValidate="DEPRMTHDCBox" ErrorMessage="Select depreciation method" ValidationGroup="Purchase"></asp:RequiredFieldValidator>   
                
                <asp:CompareValidator ID="DEPRMTHDCBoxVal" runat="server" ControlToValidate="DEPRMTHDCBox"
                Display="None" ErrorMessage="Select depreciation method" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Purchase"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DepreciationLifeLabel" class="requiredlabel">Depreciation Life:</div>
                <div id="DepreciationLifeField" class="fielddiv" style="width:200px">
                    <asp:TextBox ID="DEPRTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
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
    <div id="OwnerTB" class="tabcontent" style="display:none; height:520px;">
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
            
            <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select the owner of the asset" ValidationGroup="Owner"></asp:RequiredFieldValidator>   
            
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
                <asp:TextBox ID="RMRKTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="RMRKTxtVal" runat="server" ValidationGroup="Owner" 
            ControlToValidate ="RMRKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
    </div>
    <div id="LifecycleTB" class="tabcontent" style="display:none; height:520px;">
        
        <div id="validation_dialog_lifecycle">
            <asp:ValidationSummary ID="ValidationSummary4" runat="server" CssClass="validator" ValidationGroup="Lifecycle" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="HasCalibrationLabel" class="labeldiv">Has calibration:</div>
            <div id="HasCalibrationField" class="fielddiv" style="width:250px">
                <input type="checkbox" id="CALICHK" class="checkbox" />
            </div>
        </div>

        <div id="CalibrationGroupHeader" class="groupboxheader" style=" margin-top:15px;">Calibration Details</div>
        <div id="CalibrationGroupField" class="groupbox" style="height:100px; display:none;">
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="CalibrationFreqLabel" class="labeldiv">Calibration Frequency:</div>
                <div id="CalibrationFreqField" class="fielddiv" style="width:200px">
                    <asp:TextBox ID="CALIFREQTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                    <asp:Label ID="Label3" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:DropDownList ID="CALIFREQPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                    </asp:DropDownList>     
                </div>     
                <div id="CALIFREQ_LD" class="control-loader"></div>  

                <ajax:FilteredTextBoxExtender ID="CALIFREQFExt" runat="server" TargetControlID="CALIFREQTxt" FilterType="Numbers">
                </ajax:FilteredTextBoxExtender>

                <asp:CustomValidator id="CALIFREQTxtVal" runat="server" ValidationGroup="Lifecycle" 
                ControlToValidate = "CALIFREQTxt" Display="None" ErrorMessage = "The calibration frequency should be greater than zero"
                ClientValidationFunction="validateZero">
                </asp:CustomValidator>   
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CalibrationDocumentLabel" class="labeldiv">Calibration Document:</div>
                <div id="CalibrationDocumentField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="CALIDOCTxt" Width="240px" runat="server" CssClass="readonly">
                    </asp:TextBox>
                </div>
                <span id="CALDOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="MaintenanceLabel" class="labeldiv">Has maintenance:</div>
            <div id="MaintenanceField" class="fielddiv" style="width:250px">
                <input type="checkbox" id="MAINTCHK" class="checkbox" />
            </div>
        </div>
        
        <div id="MaintenanceGroupHeader" class="groupboxheader" style=" margin-top:15px;">Maintenance Details</div>
        <div id="MaintenanceGroupField" class="groupbox" style="height:100px; display:none;">
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="MaintenanceFrequencyLabel" class="labeldiv">Maintenance Frequency:</div>
                <div id="MaintenanceFrequencyField" class="fielddiv" style="width:200px">
                    <asp:TextBox ID="MAINFREQTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                    <asp:Label ID="Label4" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:DropDownList ID="MAINFREQPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                    </asp:DropDownList>     
                </div>     
                <div id="MAINTFREQ_LD" class="control-loader"></div> 

                <ajax:FilteredTextBoxExtender ID="MAINFREQFExt" runat="server" TargetControlID="MAINFREQTxt" FilterType="Numbers">
                </ajax:FilteredTextBoxExtender>

                <asp:CustomValidator id="MAINFREQTxtVal" runat="server" ValidationGroup="Lifecycle" 
                ControlToValidate = "MAINFREQTxt" Display="None" ErrorMessage = "The maintenance frequency should be greater than zero"
                ClientValidationFunction="validateZero">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="MaintenanceDocumentLabel" class="labeldiv">Maintenance Document:</div>
                <div id="MaintenanceDocumentField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="MAINDOCTxt" Width="240px" runat="server" CssClass="readonly">
                    </asp:TextBox>
                </div>
                <span id="MAINTDOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span>
            </div>
         
        </div>
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="HasElectricalTestLabel" class="labeldiv">Has electrical test:</div>
            <div id="HasElectricalTestField" class="fielddiv" style="width:250px">
                <input type="checkbox" id="ELCTSTCHK" class="checkbox" />
            </div>
        </div>
        
        <div id="ElectricalTestGroupHeader" class="groupboxheader" style=" margin-top:15px;">Electrical Details</div>
        <div id="ElectricalTestGroupField" class="groupbox" style="height:100px; display:none;">
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="ElectricalTestFrequencyLabel" class="labeldiv">Electrical Test Frequency:</div>
                <div id="ElectricalTestFrequencyField" class="fielddiv" style="width:200px">
                    <asp:TextBox ID="ELCTRFREQTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                    <asp:Label ID="Label5" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:DropDownList ID="ELCTRFREQPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                    </asp:DropDownList>     
                </div>     
                <div id="ELECTRFREQ_LD" class="control-loader"></div> 

                <ajax:FilteredTextBoxExtender ID="ELCTRFREQFExt" runat="server" TargetControlID="ELCTRFREQTxt" FilterType="Numbers">
                </ajax:FilteredTextBoxExtender>

                <asp:CustomValidator id="ELCTRFREQTxtVal" runat="server" ValidationGroup="Lifecycle" 
                ControlToValidate = "ELCTRFREQTxt" Display="None" ErrorMessage = "The electrical test frequency should be greater than zero"
                ClientValidationFunction="validateZero">
                </asp:CustomValidator> 
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ElectricalTestDocumentLabel" class="labeldiv">Electrical Test Document:</div>
                <div id="ElectricalTestDocumentField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="ELCTRDOCTxt" Width="240px" runat="server" CssClass="readonly">
                    </asp:TextBox>
                </div>
                <span id="ELCDOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span>
            </div>
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
        
    <div id="SelectParty" class="selectbox">
        <div id="closePRT" class="selectboxclose"></div>
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="PartyTypeLabel" class="labeldiv" style="width:100px;">Party Type:</div>
            <div id="PartyTypeField" class="fielddiv" style="width:130px;">
                <asp:DropDownList ID="PRTYTYPCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                </asp:DropDownList> 
            </div>
            <div id="PRTYP_LD" class="control-loader"></div> 
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
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="DocumentLabel" class="labeldiv" style="width:100px;">Select Document:</div>
            <div id="DocumentField" class="fielddiv" style="width:130px">
                <asp:DropDownList ID="DOCCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="DOC_LD" class="control-loader"></div>
        </div>
    </div>

    <input id="invoker" type="hidden" value="" />
    <input id="docinvoker" type="hidden" value="" />
    <input id="partyinvoker" type="hidden" value="" />
  
    <asp:Panel ID="panel1" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="panel1" PopupControlID="panel1" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    <asp:Button ID="catalias" runat="server" style="display:none" />
    <asp:Button ID="cntralias" runat="server" style="display:none" />
    <asp:Button ID="bcatalias" runat="server" style="display:none" />
    <asp:Button ID="acqalias" runat="server" style="display:none" />
    <asp:Button ID="depalias" runat="server" style="display:none" />
    <asp:Button ID="stsalias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="CategoryExtender" runat="server" BehaviorID="CategoryExtender" TargetControlID="catalias" PopupControlID="CategoryPanel" CancelControlID="CATCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="CentreExtender" runat="server" BehaviorID="CentreExtender" TargetControlID="cntralias" PopupControlID="CentrePanel" CancelControlID="CNTRCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="BillingExtender" runat="server" BehaviorID="BillingExtender" TargetControlID="bcatalias" PopupControlID="BillingPanel" CancelControlID="BCATCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
    
    <ajax:ModalPopupExtender ID="AcquisitionExtender" runat="server" BehaviorID="AcquisitionExtender" TargetControlID="acqalias" PopupControlID="AcquisitionPanel" CancelControlID="ACQCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="DepreciationExtender" runat="server" BehaviorID="DepreciationExtender" TargetControlID="depalias" PopupControlID="DepreciationPanel" CancelControlID="DEPCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

     <ajax:ModalPopupExtender ID="StatusExtender" runat="server" BehaviorID="StatusExtender" TargetControlID="stsalias" PopupControlID="StatusPanel" CancelControlID="STSCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>


    <asp:Panel ID="StatusPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="ASSTSTS_header" class="modalHeader">Create New Asset Status<span id="ASSTSTSclose" class="modalclose" title="Close">X</span></div>
        
        <div id="AssetStatusSaveTooltip" class="tooltip">
            <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
            <p>Saving...</p>
        </div>

         <div id="validation_dialog_status">
            <asp:ValidationSummary ID="ValidationSummary5" runat="server" CssClass="validator" ValidationGroup="Status" />
        </div>
      
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="StatusNameLabel" class="requiredlabel">Status Name:</div>
            <div id="StatusNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="STSNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            
            <div id="STSlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="STSNMVal" runat="server" Display="None" ControlToValidate="STSNMTxt" ErrorMessage="Enter the name of the asset status" ValidationGroup="Status"></asp:RequiredFieldValidator>
            
            <asp:CustomValidator id="STSNMTxtFVal" runat="server"
            ControlToValidate = "STSNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters" ValidationGroup="Status">
            </asp:CustomValidator>  
        </div>

      <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AssetStatusDescriptionLabel" class="labeldiv">Description:</div>
            <div id="AssetStatusDescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="STSDESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
           
            <asp:CustomValidator id="STSDESCTxtVal" runat="server"
            ControlToValidate = "STSDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText" ValidationGroup="Status">
            </asp:CustomValidator>
       </div>

       <div class="buttondiv">
            <input id="STSSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="STSCancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>

    <asp:Panel ID="CategoryPanel" runat="server" CssClass="modalPanel" style="height:300px;">
       <div id="CAT_header" class="modalHeader">Create New Asset Category<span id="CATclose" class="modalclose" title="Close">X</span></div>
    
       <div id="CategorySaveTooltip" class="tooltip">
            <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	   </div>
   
       <div id="validation_dialog_category">
            <asp:ValidationSummary ID="ValidationSummary6" runat="server" CssClass="validator" ValidationGroup="Category" />
       </div>

       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CategoryNameLabel" class="requiredlabel">Category Name:</div>
            <div id="CategoryNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="CATNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            <div id="CATlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="CATNMTxtVal" runat="server" Display="None" ControlToValidate="CATNMTxt" ErrorMessage="Enter the name of the asset category" ValidationGroup="Category"></asp:RequiredFieldValidator> 

            <asp:CustomValidator id="CATNMTxtFVal" runat="server" ValidationGroup="Category" 
            ControlToValidate = "CATNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>   
       </div>

      <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CategoryDescriptionLabel" class="labeldiv">Description:</div>
            <div id="CategoryDescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="CATDESTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
           
            <asp:CustomValidator id="CATDESVal" runat="server" ValidationGroup="Category" 
            ControlToValidate = "CATDESTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
       </div>
       <div class="buttondiv">
            <input id="CATSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="CATCancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>

    <asp:Panel ID="BillingPanel" runat="server" CssClass="modalPanel" style="height:300px;">
       <div id="BCAT_header" class="modalHeader">Create New Billing Category<span id="BCATclose" class="modalclose" title="Close">X</span></div>
       
       <div id="BillingCategorySaveTooltip" class="tooltip">
            <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	   </div>

       <div id="validation_dialog_billing">
            <asp:ValidationSummary ID="ValidationSummary7" runat="server" CssClass="validator" ValidationGroup="Billing" />
       </div>

       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="BillingCategoryNameLabel" class="requiredlabel">Category Name:</div>
            <div id="BillingCategoryNamField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="BCATTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            <div id="BCATlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="BCATTxtVal" runat="server" Display="None" ControlToValidate="BCATTxt" ErrorMessage="Enter the name of the billing category" ValidationGroup="Billing"></asp:RequiredFieldValidator>  
           
            <asp:CustomValidator id="BCATTxtFVal" runat="server" ValidationGroup="Billing" 
            ControlToValidate = "BCATTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>   
     
       </div>

      <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="BillingCategoryDescriptionLabel" class="labeldiv">Description:</div>
            <div id="BillingCategoryDescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="BCATDESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="BCATDESCFVal" runat="server" ValidationGroup="Billing" 
            ControlToValidate = "BCATDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
       </div>

       <div class="buttondiv">
            <input id="BCATSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="BCATCancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>

    <asp:Panel ID="CentrePanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CostCentre_header" class="modalHeader">Create New Cost Centre<span id="COSTCNTRclose" class="modalclose" title="Close">X</span></div>
        
        <div id="CostCentreSaveTooltip"  class="tooltip">
            <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_centre">
            <asp:ValidationSummary ID="ValidationSummary8" runat="server" CssClass="validator" ValidationGroup="Centre" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CostCentreNoLabel" class="requiredlabel">Cost Centre ID:</div>
            <div id="CostCentreNoField" class="fielddiv" style="width:auto">
                <asp:TextBox ID="CentreNoTxt" runat="server" CssClass="textbox" Width="90px"></asp:TextBox>
                <asp:Label ID="CentreNoLbl" runat="server" CssClass="label"  style="width:auto;"></asp:Label>
            </div>
            <div id="CentreIDlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="CentreNoVal" runat="server" Display="None" ControlToValidate="CentreNoTxt" ErrorMessage="Enter a unique ID of the cost centre" ValidationGroup="Centre"></asp:RequiredFieldValidator> 
                    
            <asp:CustomValidator id="CentreNoTxtFVal" runat="server" ValidationGroup="Centre" 
            ControlToValidate = "CentreNoTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
            ClientValidationFunction="validateIDField">
            </asp:CustomValidator>         
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CentreNameLabel" class="requiredlabel">Cost Centre Name:</div>
            <div id="CentreNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="CTRNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            <div id="CNTRlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="CTRNMTxtVal" runat="server" Display="None" ControlToValidate="CTRNMTxt" ErrorMessage="Enter the name of the cost centre" ValidationGroup="Centre"></asp:RequiredFieldValidator>  

            <asp:CustomValidator id="CTRNMTxtFVal" runat="server" ValidationGroup="Centre" 
            ControlToValidate = "CTRNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>   
       </div>

     
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OrganizationUnitLabel" class="requiredlabel">ORG. Unit:</div>
            <div id="OrganizationUnitField" class="fielddiv" style="width:300px;">
                <asp:DropDownList ID="CNTRORGCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>    
            <div id="UNIT_LD" class="control-loader"></div>  
            
            <asp:RequiredFieldValidator ID="CNTRORGVal" runat="server" Display="None" ControlToValidate="CNTRORGCBox" ErrorMessage="Select an organization unit" ValidationGroup="Centre"></asp:RequiredFieldValidator>
                    
            <asp:CompareValidator ID="ORGUNTVal" runat="server" ControlToValidate="CNTRORGCBox"
            Display="None" ErrorMessage="Select an organization unit" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Centre"></asp:CompareValidator>
       </div>
        
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ManagerLabel" class="requiredlabel">Manager:</div>
            <div id="ManagerField" class="fielddiv" style="width:300px;">
                <asp:DropDownList ID="MGRCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>    
            <div id="MGR_LD" class="control-loader"></div> 
            
            <asp:RequiredFieldValidator ID="MGRCBoxTxtVal" runat="server" Display="None" ControlToValidate="MGRCBox" ErrorMessage="Select a manager" ValidationGroup="Centre"></asp:RequiredFieldValidator>         
            
            <asp:CompareValidator ID="MGRCBoxVal" runat="server" ControlToValidate="MGRCBox"
            Display="None" ErrorMessage="Select a manager" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Centre"></asp:CompareValidator>
       </div>
      
    
       <div class="buttondiv">
            <input id="CNTRSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="CNTRCancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>

    <asp:Panel ID="AcquisitionPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="ACQ_header" class="modalHeader">Create New Acquisition Method<span id="ACQclose" class="modalclose" title="Close">X</span></div>
            
            <div id="AcquisitionMethodSaveTooltip" class="tooltip">
                <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
                <p>Saving...</p>
            </div>

            <div id="validation_dialog_acquisition">
                <asp:ValidationSummary ID="ValidationSummary9" runat="server" CssClass="validator" ValidationGroup="Acquisition" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AcquisitionMethodNameLabel" class="requiredlabel">Acquisition Method:</div>
                <div id="AcquisitionMethodNameField" class="fielddiv" style="width:200px;">
                    <asp:TextBox ID="ACQNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
                </div>
                <div id="ACQNMlimit" class="textremaining"></div>

                <asp:RequiredFieldValidator ID="ACQNMTxtVal" runat="server" Display="None" ControlToValidate="ACQNMTxt" ErrorMessage="Enter the name of the acquisition method" ValidationGroup="Acquisition" ></asp:RequiredFieldValidator> 
            
                <asp:CustomValidator id="ACQNMTxtFVal" runat="server" ValidationGroup="Acquisition" 
                ControlToValidate = "ACQNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>   
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AcquisitionMethodDescriptionLabel" class="labeldiv">Description:</div>
                <div id="AcquisitionMethodDescriptionField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="ACQDESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <asp:CustomValidator id="ACQDESCFVal" runat="server" ValidationGroup="Acquisition" 
                ControlToValidate = "ACQDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
    
            <div class="buttondiv">
                <input id="ACQSave" type="button" class="button" style="margin-left:300px;" value="Save" />
                <input id="ACQCancel" type="button" class="button" value="Cancel" />
            </div>   
        </asp:Panel>

        <asp:Panel ID="DepreciationPanel" runat="server" CssClass="modalPanel" style="height:300px;">
            <div id="DEP_header" class="modalHeader">Depreciation Method Details<span id="DEPclose" class="modalclose" title="Close">X</span></div>
       
            <div id="DepreciationSaveTooltip" class="tooltip">
                <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
                <p>Saving...</p>
            </div>

            <div id="validation_dialog_depreciation">
                <asp:ValidationSummary ID="ValidationSummary10" runat="server" CssClass="validator" ValidationGroup="Depreciation" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DepreciationMethodNameLabel" class="requiredlabel">Depreciation Method:</div>
                <div id="DepreciationMethodNameField" class="fielddiv" style="width:200px;">
                    <asp:TextBox ID="DEPRNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
                </div>
                <div id="MTHDlimit" class="textremaining"></div>

                <asp:RequiredFieldValidator ID="DEPRNMTxtVal" runat="server" Display="Dynamic" ControlToValidate="DEPRNMTxt" ErrorMessage="Enter the name of the depreciation method" CssClass="validator" ValidationGroup="Depreciation" ></asp:RequiredFieldValidator> 

                <asp:CustomValidator id="DEPRNMTxtFVal" runat="server" ValidationGroup="Depreciation" 
                ControlToValidate = "DEPRNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>   
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DepreciationMethodDescriptionLabel" class="labeldiv">Description:</div>
                <div id="DepreciationMethodDescriptionField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="DEPDESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="DEPDESCTxtVal" runat="server" ValidationGroup="Depreciation" 
                ControlToValidate = "DEPDESCTxt" CssClass="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div class="buttondiv">
                <input id="DEPSave" type="button" class="button" style="margin-left:300px;" value="Save" />
                <input id="DEPCancel" type="button" class="button" value="Cancel" />
            </div>   
        </asp:Panel>
    </div>

    <script type="text/javascript" language="javascript">
        $(function ()
        {
            addWaterMarkText('The description of the asset', '#<%=DESCTxt.ClientID%>');
            addWaterMarkText('The notes in the support of the asset record', '#<%=RMRKTxt.ClientID%>');


            /*attach TAG number to limit plugin*/
            $('#<%=ASSTTAGTxt.ClientID%>').limit({ id_result: 'TAGlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach other TAG number to limit plugin*/
            $('#<%=OASSTTAGTxt.ClientID%>').limit({ id_result: 'OTAGlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach serial number to limit plugin*/
            $('#<%=SRLNOTxt.ClientID%>').limit({ id_result: 'SNlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach barcode to limit plugin*/
            $('#<%=BRCODETxt.ClientID%>').limit({ id_result: 'BARlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach model to limit plugin*/
            $('#<%=MODLTxt.ClientID%>').limit({ id_result: 'MDLlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach manufacturer to limit plugin*/
            $('#<%=MNFCTTxt.ClientID%>').limit({ id_result: 'MNUlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach work request number to limit plugin*/
            $('#<%=WRKREQTxt.ClientID%>').limit({ id_result: 'WREQlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach account code to limit plugin*/
            $('#<%=ACCCODTxt.ClientID%>').limit({ id_result: 'ACClimit', alertClass: 'alertremaining', limit: 50 });

            /*attach external purchase order number to limit plugin*/
            $('#<%=EXTRORDRTxt.ClientID%>').limit({ id_result: 'EXTOlimit', alertClass: 'alertremaining', limit: 50 });

            loadAssetCategories();

            loadCostCentre('#<%=CSTCNTRCBox.ClientID%>',"#CNTR_LD");
            loadCostCentre('#<%=OCSTCNTRCBox.ClientID%>',"#OCNTR_LD");

            loadBillingCategory();
            loadAcquisitionMethod();
            loadDepreciationMethod();

            loadAssetStatus();

            loadComboboxAjax('loadCurrencies', "#<%=CURRCBox.ClientID%>","#CURR_LD");
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>","#ORGUNT_LD");
       

            /*period of depreciation life*/
            loadComboboxAjax('loadPeriod', "#<%=DEPRPRDCBox.ClientID%>", "#DEPRPRD_LD");

            /* to add new asset category*/
            $("#<%=CATADD.ClientID%>").bind('click', function ()
            {
                resetGroup('.modalPanel');

                /*attach category name to limit plugin*/
                $('#<%=CATNMTxt.ClientID%>').limit({ id_result: 'CATlimit', alertClass: 'alertremaining', limit: 50 });
                $('#<%=CATNMTxt.ClientID%>').keyup();
             
                addWaterMarkText('The description of the asset category', '#<%=CATDESTxt.ClientID%>');

                $("#<%=catalias.ClientID%>").trigger('click');
            });

            /* to add new asset status*/
            $("#<%=ASTSTSADD.ClientID%>").bind('click', function ()
            {
                resetGroup('.modalPanel');

                /*attach status name to limit plugin*/
                $('#<%=STSNMTxt.ClientID%>').limit({ id_result: 'STSlimit', alertClass: 'alertremaining', limit: 50 });
                $('#<%=STSNMTxt.ClientID%>').keyup();

                addWaterMarkText('The description of the asset status', '#<%=STSDESCTxt.ClientID%>');

                $("#<%=stsalias.ClientID%>").trigger('click');
            });

            $("#<%=CNTRADD.ClientID%>").bind('click', function ()
            {
                resetGroup('.modalPanel');

                loadLastIDAjax('getLastCentreID', "#<%=CentreNoLbl.ClientID%>");

                loadComboboxAjax('getOrganizationUnits', '#<%=CNTRORGCBox.ClientID%>', "#UNIT_LD");

                $('#<%=MGRCBox.ClientID%>').empty();

                /*attach cost centre name to limit plugin*/
                $("#<%=CTRNMTxt.ClientID%>").limit({ id_result: 'CNTRlimit', alertClass: 'alertremaining', limit: 90 });
                $('#<%=CTRNMTxt.ClientID%>').keyup();

                $("#<%=cntralias.ClientID%>").trigger('click');
           
            }); 

            $("#<%=BCATADD.ClientID%>").bind('click', function ()
            {
                resetGroup('.modalPanel');

                /*attach category name to limit plugin*/
                $('#<%=BCATTxt.ClientID%>').limit({ id_result: 'BCATlimit', alertClass: 'alertremaining', limit: 50 });
                $('#<%=BCATTxt.ClientID%>').keyup();

                addWaterMarkText('The description of the billing category', '#<%=BCATDESCTxt.ClientID%>');

                $("#<%=bcatalias.ClientID%>").trigger('click');

            });

            $("#<%=ACQADD.ClientID%>").bind('click', function () {
                resetGroup('.modalPanel');

                /*attach category name to limit plugin*/
                $('#<%=ACQNMTxt.ClientID%>').limit({ id_result: 'ACQNMlimit', alertClass: 'alertremaining', limit: 50 });
                $('#<%=ACQNMTxt.ClientID%>').keyup();

                addWaterMarkText('The description of the acquisition method', '#<%=ACQDESCTxt.ClientID%>');

                $("#<%=acqalias.ClientID%>").trigger('click');

            });

            $("#<%=DEPMTHDADD.ClientID%>").bind('click', function ()
            {
                resetGroup('.modalPanel');

                /*attach depreciation method to limit plugin*/
                $('#<%=DEPRNMTxt.ClientID%>').limit({ id_result: 'MTHDlimit', alertClass: 'alertremaining', limit: 50 });
                $('#<%=DEPRNMTxt.ClientID%>').keyup();

                addWaterMarkText('The description of the depreciation method', '#<%=DEPDESCTxt.ClientID%>');

                $("#<%=depalias.ClientID%>").trigger('click');
            });

            $("#<%=CNTRORGCBox.ClientID%>").change(function () {
                if ($(this).val() != 0)
                {
                    var controls = new Array();
                    controls.push('#<%=MGRCBox.ClientID%>');
                    loadParamComboboxAjax('getDepEmployees', controls, "'unit':'" + $(this).val() + "'", "#MGR_LD");
                }
            });

            $("#CATclose").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#CATCancel").trigger('click');
                }
            });

            $("#COSTCNTRclose").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#CNTRCancel").trigger('click');
                }
            });

            $("#BCATclose").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#BCATCancel").trigger('click');
                }
            });

            $("#ACQclose").bind('click', function ()
            {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#ACQCancel").trigger('click');
                }
            });

            $("#DEPclose").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#DEPCancel").trigger('click');
                }
            });

            $("#ASSTSTSclose").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#STSCancel").trigger('click');
                }
            });

            $("#STSSave").click(function ()
            {
                var isPageValid = Page_ClientValidate('Status');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_status").is(":hidden"))
                    {
                        $("#validation_dialog_status").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $("#AssetStatusSaveTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            ActivateSave(false);

                            var status =
                            {
                                StatusName: $("#<%=STSNMTxt.ClientID%>").val(),
                                Description: $("#<%=STSDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=STSDESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(status) + "\'}",
                                url: getServiceURL().concat('createAssetStatus'),
                                success: function (data) 
                                {
                                    $("#AssetStatusSaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#STSCancel").trigger('click');
                                        loadAssetStatus();
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#AssetStatusSaveTooltip").fadeOut(500, function ()
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
                    $("#validation_dialog_status").stop(true).hide().fadeIn(500, function ()
                    {
                        
                    });
                }
            });

            $("#CNTRSave").click(function ()
            {
                var isPageValid = Page_ClientValidate('Centre');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_centre").is(":hidden")) {
                        $("#validation_dialog_centre").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $("#CostCentreSaveTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            ActivateSave(false);


                            var costcentre =
                            {
                                CostCentreNo: $("#<%=CentreNoTxt.ClientID%>").val(),
                                CostCentreName: $("#<%=CTRNMTxt.ClientID%>").val(),
                                ORGUnit: $("#<%=CNTRORGCBox.ClientID%>").val(),
                                Manager: $("#<%=MGRCBox.ClientID%>").val()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(costcentre) + "\'}",
                                url: getServiceURL().concat('createCostCentre'),
                                success: function (data) {
                                    $("#CostCentreSaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#CNTRCancel").trigger('click');

                                        loadCostCentre('#<%=CSTCNTRCBox.ClientID%>', "#CNTR_LD");
                                        loadCostCentre('#<%=OCSTCNTRCBox.ClientID%>', "#OCNTR_LD");
                                        
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#CostCentreSaveTooltip").fadeOut(500, function () {
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
                    $("#validation_dialog_centre").stop(true).hide().fadeIn(500, function ()
                    {
                    });
                }
            });
      
            $("#CATSave").click(function ()
            {
                var isPageValid = Page_ClientValidate('Category');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_category").is(":hidden")) {
                        $("#validation_dialog_category").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $("#CategorySaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            var category =
                            {
                                CategoryName: $("#<%=CATNMTxt.ClientID%>").val(),
                                Description: $("#<%=CATDESTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=CATDESTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(category) + "\'}",
                                url: getServiceURL().concat('createAssetCategory'),
                                success: function (data)
                                {
                                    $("#CategorySaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#CATCancel").trigger('click');
                                        loadAssetCategories();
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#CategorySaveTooltip").fadeOut(500, function () {
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

            $("#BCATSave").click(function ()
            {
                var isPageValid = Page_ClientValidate('Billing');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_billing").is(":hidden"))
                    {
                        $("#validation_dialog_billing").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {
                        $("#BillingCategorySaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            var category =
                            {
                                CategoryName: $("#<%=BCATTxt.ClientID%>").val(),
                                Description: $("#<%=BCATDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=BCATDESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(category) + "\'}",
                                url: getServiceURL().concat('createBillingCategory'),
                                success: function (data) {
                                    $("#BillingCategorySaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#BCATCancel").trigger('click');
                                        loadBillingCategory();

                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#BillingCategorySaveTooltip").fadeOut(500, function ()
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
                    $("#validation_dialog_billing").stop(true).hide().fadeIn(500, function () {
                        
                    });
                }
            });

            $("#ACQSave").click(function ()
            {
                var isPageValid = Page_ClientValidate('Acquisition');
                if (isPageValid) {
                    if (!$("#validation_dialog_acquisition").is(":hidden")) {
                        $("#validation_dialog_acquisition").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {
                        $("#AcquisitionMethodSaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            var method =
                              {
                                  MethodName: $("#<%=ACQNMTxt.ClientID%>").val(),
                                  Description: $("#<%=ACQDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACQDESCTxt.ClientID%>").val())
                              }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(method) + "\'}",
                                url: getServiceURL().concat('createAcquisitionMethod'),
                                success: function (data) {
                                    $("#AcquisitionMethodSaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        $("#ACQCancel").trigger('click');
                                        loadAcquisitionMethod();
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#AcquisitionMethodSaveTooltip").fadeOut(500, function () {
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
                    $("#validation_dialog_acquisition").stop(true).hide().fadeIn(500, function ()
                    {
                        
                    });
                }
            });

            $("#DEPSave").click(function ()
            {
                var isPageValid = Page_ClientValidate('Depreciation');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_depreciation").is(":hidden")) {
                        $("#validation_dialog_depreciation").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {

                        $("#DepreciationSaveTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            ActivateSave(false);

                            var method =
                              {
                                  MethodName: $("#<%=DEPRNMTxt.ClientID%>").val(),
                                  Description: $("#<%=DEPDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DEPDESCTxt.ClientID%>").val())
                              }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(method) + "\'}",
                                url: getServiceURL().concat('createDepreciationMethod'),
                                success: function (data) {
                                    $("#DepreciationSaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#DEPCancel").trigger('click');
                                        loadDepreciationMethod();
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#DepreciationSaveTooltip").fadeOut(500, function ()
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
                    $("#validation_dialog_depreciation").stop(true).hide().fadeIn(500, function () {
                        
                    });
                }
            });

            $("#<%=OWNRSelect.ClientID%>").click(function (e)
            {
                $("#invoker").val('Owner');
                showORGDialog(e.pageX, e.pageY);
            });

            $("#<%=AOWNRSelect.ClientID%>").click(function (e)
            {
                $("#invoker").val('AnotherOwner');
                showORGDialog(e.pageX, e.pageY);
            });

            $("#<%=SUPPSelect.ClientID%>").click(function (e)
            {
                $("#partyinvoker").val('Supplier');
                showPartyDialog(e.pageX, e.pageY);
            });

            $("#<%=EXTSelect.ClientID%>").click(function (e)
            {
                $("#partyinvoker").val('ExternalOwner');
                showPartyDialog(e.pageX, e.pageY);
            });

            $("#<%=CALDOCSRCH.ClientID%>").click(function (e) {
                $("#docinvoker").val('Calibration');
                showDOCDialog(e.pageX, e.pageY);
            });

            $("#<%=MAINTDOCSRCH.ClientID%>").click(function (e) {
                $("#docinvoker").val('Maintenance');
                showDOCDialog(e.pageX, e.pageY);
            });

            $("#<%=ELCDOCSRCH.ClientID%>").click(function (e) {
                $("#docinvoker").val('ElectricalTest');
                showDOCDialog(e.pageX, e.pageY);
            });

            /* filter all issued and updated documents only*/
            $("#<%=DOCTYP.ClientID%>").change(function ()
            {

                if ($(this).val() != 0)
                {
                    var $obj = $(this);

                    $("#DOC_LD").stop(true).hide().fadeIn(500, function ()
                    {
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{'type':'" + $obj.val() + "'}",
                            url: getServiceURL().concat("loadCurrentDocuments"),
                            success: function (data)
                            {
                                $("#DOC_LD").fadeOut(500, function ()
                                {
                                    if (data)
                                    {
                                        loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $("#<%=DOCCBox.ClientID%>"));
                                    }
                                });
                            },
                            error: function (xhr, status, error) {
                                $("#DOC_LD").fadeOut(500, function ()
                                {
                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                });
                            }
                        });
                    });
                }
            });

            $("#<%=DOCCBox.ClientID%>").change(function ()
            {
                switch ($("#docinvoker").val())
                {
                    case "Calibration":
                        $("#<%=CALIDOCTxt.ClientID%>").val($(this).val());
                        break;
                    case "Maintenance":
                        $("#<%=MAINDOCTxt.ClientID%>").val($(this).val());
                        break;
                    case "ElectricalTest":
                        $("#<%=ELCTRDOCTxt.ClientID%>").val($(this).val());
                        break;
                }
                $("#SelectDOC").hide("800");
            });

            /*populate the employees in owner, and another owner cboxes*/
            $("#<%=SORGUNTCBox.ClientID%>").change(function ()
            {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                switch ($("#invoker").val())
                {
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
            });


            $("#CALICHK").change(function ()
            {
                if ($(this).is(":checked") == true)
                {
                    $("#CalibrationGroupField").stop(true).hide().fadeIn(500, function ()
                    {
                        $(this).children().each(function ()
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

                        });

                        /*period of calibration frequency*/
                        loadComboboxAjax('loadPeriod', "#<%=CALIFREQPRDCBox.ClientID%>", "#CALIFREQ_LD");
                    });
                }
                else
                {
                    $("#CalibrationGroupField").fadeOut(500, function ()
                    {
                    });

                }

            });

            $("#MAINTCHK").change(function ()
            {
                if ($(this).is(":checked") == true)
                {
                    $("#MaintenanceGroupField").stop(true).hide().fadeIn(500, function ()
                    {
                        $(this).children().each(function ()
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

                        });

                        /*period of maintenance frequency*/
                        loadComboboxAjax('loadPeriod', "#<%=MAINFREQPRDCBox.ClientID%>", "#MAINTFREQ_LD");

                    });
                }
                else
                {
                    $("#MaintenanceGroupField").fadeOut(500, function () {
                    });

                }

            });


            $("#ELCTSTCHK").change(function ()
            {
                if ($(this).is(":checked") == true)
                {
                    $("#ElectricalTestGroupField").stop(true).hide().fadeIn(500, function ()
                    {
                        $(this).children().each(function ()
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

                        });

                        /*period of electrical testing frequency*/
                        loadComboboxAjax('loadPeriod', "#<%=ELCTRFREQPRDCBox.ClientID%>", "#ELECTRFREQ_LD");

                    });
                }
                else
                {
                    $("#ElectricalTestGroupField").fadeOut(500, function () {
                    });

                }

            });

            $("#<%=PRTYTYPCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    switch ($("#partyinvoker").val())
                    {
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

            $("#closedoc").bind('click', function () {
                $("#SelectDOC").hide('800');
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

            $("#save").bind('click', function ()
            {
                var isGeneralValid = Page_ClientValidate('General');
                if (isGeneralValid)
                {
                    if (!$("#validation_dialog_general").is(":hidden"))
                    {
                        $("#validation_dialog_general").hide();
                    }
                    var isPurchaseValid = Page_ClientValidate('Purchase');
                    if (isPurchaseValid)
                    {
                        if (!$("#validation_dialog_purchase").is(":hidden")) {
                            $("#validation_dialog_purchase").hide();
                        }
                        var isOwnerValid = Page_ClientValidate('Owner');
                        if (isOwnerValid)
                        {
                            if (!$("#validation_dialog_owner").is(":hidden")) {
                                $("#validation_dialog_owner").hide();
                            }

                            var isAdditionalValid = Page_ClientValidate('Lifecycle');
                            if (isAdditionalValid)
                            {
                                if (!$("#validation_dialog_lifecycle").is(":hidden"))
                                {
                                    $("#validation_dialog_lifecycle").hide();
                                }

                                var result = confirm("Are you sure you would like to submit changes?");
                                if (result == true) {
                                    $find('<%= SaveExtender.ClientID %>').show();

                                    var purchaseDateParts = getDatePart($("#<%=PURDTTxt.ClientID%>").val());
                                    var acquisitionDateParts = getDatePart($("#<%=ACQDTTxt.ClientID%>").val());
                                    var installationDateParts = getDatePart($("#<%=INSTDTTxt.ClientID%>").val());

                                    var asset =
                                    {
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
                                        DepreciationMethod: $("#<%=DEPRMTHDCBox.ClientID%>").val(),
                                        DepreciableLife: $("#<%=DEPRTxt.ClientID%>").val(),
                                        DepreciablePeriod: $("#<%=DEPRPRDCBox.ClientID%>").val(),
                                        Department: $("#<%=ORGUNTCBox.ClientID%>").val(),
                                        Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                                        AnotherOwner: ($("#<%=AOWNRCBox.ClientID%>").val() == 0 || $("#<%=AOWNRCBox.ClientID%>").val() == null ? '' : $("#<%=AOWNRCBox.ClientID%>").val()),
                                        ExternalOwner: ($("#<%=EXTOWNRCBox.ClientID%>").val() == 0 || $("#<%=EXTOWNRCBox.ClientID%>").val() == null ? '' : $("#<%=EXTOWNRCBox.ClientID%>").val()),
                                        Remarks: $("#<%=RMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMRKTxt.ClientID%>").val()),
                                        CalibrationFrequency: $("#<%=CALIFREQTxt.ClientID%>").val() == '' ? 0 : parseInt($("#<%=CALIFREQTxt.ClientID%>").val()),
                                        CalibrationPeriod: ($("#<%=CALIFREQPRDCBox.ClientID%>").val() == 0 || $("#<%=CALIFREQPRDCBox.ClientID%>").val() == null ? '' : $("#<%=CALIFREQPRDCBox.ClientID%>").val()),
                                        MaintenanceFrequency: $("#<%=MAINFREQTxt.ClientID%>").val() == '' ? 0 : $("#<%=MAINFREQTxt.ClientID%>").val(),
                                        MaintenancePeriod: ($("#<%=MAINFREQPRDCBox.ClientID%>").val() == 0 || $("#<%=MAINFREQPRDCBox.ClientID%>").val() == null ? '' : $("#<%=MAINFREQPRDCBox.ClientID%>").val()),
                                        CalibrationDocument: $("#<%=CALIDOCTxt.ClientID%>").val(),
                                        MaintenanceDocument: $("#<%=MAINDOCTxt.ClientID%>").val(),
                                        ElectricalTestDocument: $("#<%=ELCTRDOCTxt.ClientID%>").val(),
                                        ElectricalTestFrequency: $("#<%=ELCTRFREQTxt.ClientID%>").val() == '' ? 0 : $("#<%=ELCTRFREQTxt.ClientID%>").val(),
                                        ElectricalTestPeriod: ($("#<%=ELCTRFREQPRDCBox.ClientID%>").val() == 0 || $("#<%=ELCTRFREQPRDCBox.ClientID%>").val() == null ? '' : $("#<%=ELCTRFREQPRDCBox.ClientID%>").val()),
                                        HasCalibration: $("#CALICHK").is(':checked'),
                                        HasMaintenance: $("#MAINTCHK").is(':checked'),
                                        HasElectricalTest: $("#ELCTSTCHK").is(':checked'),
                                        FloorNo: $("#<%=FLOORTxt.ClientID%>").val(),
                                        RoomNo: $("#<%=ROOMTxt.ClientID%>").val()
                                    }

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{\'json\':\'" + JSON.stringify(asset) + "\'}",
                                        url: getServiceURL().concat('createAsset'),
                                        success: function (data)
                                        {
                                            $find('<%= SaveExtender.ClientID %>').hide();

                                            showSuccessNotification(data.d);

                                            resetGroup(".modulewrapper");

                                            /*restore watermarks*/
                                            if (!$("#<%=DESCTxt.ClientID%>").hasClass("watermarktext"))
                                            {
                                                addWaterMarkText('The description of the asset', '#<%=DESCTxt.ClientID%>');
                                            }

                                            if (!$("#<%=RMRKTxt.ClientID%>").hasClass("watermarktext")) {
                                                addWaterMarkText('The notes in the support of the asset record', '#<%=RMRKTxt.ClientID%>');

                                            }
                                            
                                            $(".groupbox").each(function () {

                                                if (!$(this).is(":hidden"))
                                                    $(this).hide();
                                            });

                                            navigate('Details');

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
                                $("#validation_dialog_lifecycle").stop(true).hide().fadeIn(500, function ()
                                {
                                    navigate('Lifecycle');
                                });
                            }
                        }
                        else
                        {
                            $("#validation_dialog_owner").stop(true).hide().fadeIn(500, function ()
                            {
                                
                                navigate('Owner');
                            });
                        }
                    }
                    else
                    {
                        
                        $("#validation_dialog_purchase").stop(true).hide().fadeIn(500, function ()
                        {
                            navigate('Purchase');
                        });
                    }
                }
                else
                {
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                        
                        navigate('Details');
                    });
                }
            });

            navigate('Details');

            $("#tabul li").bind("click", function () {
                navigate($(this).attr("id"));
            });

        });

        function showORGDialog(x, y)
        {
            $("#SelectORG").css({ left: x, top: y - 100 });
            loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#SORGUNT_LD");
            $("#SelectORG").show();
        }

        function showDOCDialog(x, y)
        {
            $("#SelectDOC").css({ left: x, top: y - 100 });
            loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYP.ClientID%>", "#DOCTYP_LD");
           
            $("#<%=DOCCBox.ClientID%>").empty();
            $("#SelectDOC").show();
        }

        function showPartyDialog(x, y) {
            $("#SelectParty").css({ left: x, top: y - 100 });
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

        function loadParty(type, control,loader)
        {
            $(loader).stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'type':'" + type + "'}",
                    url: getServiceURL().concat("filterCustomerByType"),
                    success: function (data) {
                        $(loader).fadeOut(500, function ()
                        {
                            if (data)
                            {
                                loadComboboxXML($.parseXML(data.d), 'Customer', 'CustomerName', $(control));
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

        function loadDepreciationMethod()
        {
            $("#DEPMTHD_LD").stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadDepreciationMethods"),
                    success: function (data)
                    {
                        $("#DEPMTHD_LD").fadeOut(500, function () {

                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'Method', 'MethodName', $("#<%=DEPRMTHDCBox.ClientID%>"));
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
        function loadAcquisitionMethod()
        {
            $("#ACQMTHD_LD").stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadAcquisitionMethods"),
                    success: function (data)
                    {
                        $("#ACQMTHD_LD").fadeOut(500, function () {

                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'Method', 'MethodName', $("#<%=ACQMTHDCBox.ClientID%>"));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#ACQMTHD_LD").fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
        function loadBillingCategory()
        {
            $("#BCAT_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadBillingCategories"),
                    success: function (data)
                    {
                        $("#BCAT_LD").fadeOut(500, function () {

                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $("#<%=BCATCBox.ClientID%>"));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#BCAT_LD").fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
        function loadCostCentre(control,loader)
        {
            $(loader).stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadCostCentres"),
                    success: function (data)
                    {
                        $(loader).fadeOut(500, function () {

                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'CostCentre', 'CostCentreName', $(control));
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



        function loadAssetStatus()
        {
            $("#ASSTSTS_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadAssetListStatus"),
                    success: function (data)
                    {
                        $("#ASSTSTS_LD").fadeOut(500, function () {
                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'Status', 'StatusName', $("#<%=ASSTSTSCBox.ClientID%>"));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#ASSTSTS_LD").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

        function loadAssetCategories()
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
                        $("#ASSTCAT_LD").fadeOut(500, function () {
                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $("#<%=ASSTCATCBox.ClientID%>"));
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#ASSTCAT_LD").fadeOut(500, function () {
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
            $(".selectbox").each(function ()
            {
                $(this).hide('800');
            });

            $("#tabul li").removeClass("ctab");

            $(".tabcontent").each(function () {
                $(this).css('display', 'none');
            });

            $("#" + name).addClass("ctab");
            $("#" + name + "TB").css('display', 'block');
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

        function showSuccessNotification(message) {
            $().toastmessage('showSuccessToast', message);
        }

        function showErrorNotification(message) {
            $().toastmessage('showErrorToast', message);
        }
    </script>
</asp:Content>
