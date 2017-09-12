<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageRecords.aspx.cs" Inherits="QMSRSTools.QualityRecords.ManageRecords" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="QR_Header" class="moduleheader">Manage Quality Records</div>

    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
       
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byQRNM">Filter by QR Name</li>
                <li id="byORGUNT">Filter by Organization Unit</li>
                <li id="byRECMOD">Filter Record Mode</li>
                <li id="byISSDT">Filter by QR's Issue Date</li>
                <li id="byQRSTS">Filter by QR's Status</li>
            </ul>
        </div>
    </div>

    <div id="QRContainer" class="filter">
        <div id="QRNameLabel" class="filterlabel">QR Name:</div>
        <div id="QRNameField" class="filterfield">
            <asp:TextBox ID="QRNMFTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>

    <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
         </div>
         <div id="RECMODF_LD" class="control-loader"></div>
    </div>

    <div id="ORGUNTContainer" class="filter">
        <div id="ORGUNTFLabel" class="filterlabel">Organization Unit:</div>
        <div id="ORGUNTFField" class="filterfield">
            <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ORGUNTF_LD" class="control-loader"></div>
    </div>

    <div id="QRSTSContainer" class="filter">
        <div id="QRSTSFLabel" class="filterlabel">QR Status:</div>
        <div id="QRSTSFField" class="filterfield">
            <asp:DropDownList ID="QRSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="QRSTSF_LD" class="control-loader"></div>
    </div>

    <div id="StartdateContainer" class="filter">
        <div id="StartDateLabel" class="filterlabel">Issue Date:</div>
        <div id="StartDateField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>

    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="QRwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        
        <div id="RAGTooltip" class="tooltip" style="margin-top:20px; background-color:transparent;"> 
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="RED" src="http://www.qmsrs.com/qmsrstools/Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: Quality Record is Overdue for Review.</p>
            </div>
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="GREEN" src="http://www.qmsrs.com/qmsrstools/Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: Quality Record is not due for review.</p>
            </div>
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="AMBER" src="http://www.qmsrs.com/qmsrstools/Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: Quality Record will be due for review soon.</p>
            </div>
        </div>	

        <asp:GridView id="gvQR" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="RecordNo" HeaderText="Record No" />
            <asp:BoundField DataField="Title" HeaderText="QR Name" />
            <asp:BoundField DataField="Department" HeaderText="Department" />
            <asp:BoundField DataField="Originator" HeaderText="Originator" />
            <asp:BoundField DataField="Owner" HeaderText="Owner" />
            <asp:BoundField DataField="IssueDate" HeaderText="Issue Date" />
            <asp:BoundField DataField="ReviewDate" HeaderText="Review Date" />
            <asp:BoundField DataField="ReviewDuration" HeaderText="Review Duration" />
            <asp:BoundField DataField="RetentionDuration" HeaderText="Retention Duration" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
        </Columns>
        </asp:GridView>
    </div>
   
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
    
        <div id="header" class="modalHeader">Quality Record Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="QRTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>	

        <div id="QRFileDownload" class="tooltip">
            <img src="#" alt="Download" height="25" width="25" />
            <p></p>
   	    </div>
    
        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <ul id="tabul">
            <li id="Details" class="ntabs">Details</li>
            <li id="Additional" class="ntabs">Additional Information</li>
        </ul>

        <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">
    
            <div id="validation_dialog_general">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>

            <input id="RecordID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="QRNOLabel" class="labeldiv">Record No:</div>
                <div id="QRNOField" class="fielddiv" style="width:250px;">
                    <asp:TextBox ID="QRNOTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>  
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="QualityRecordName" class="requiredlabel">QR Name:</div>
                <div id="QualityRecordField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="QRNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>  
                <div id="QRNMlimit" class="textremaining"></div>   

                <asp:RequiredFieldValidator ID="QRNMTxtVal" runat="server" ControlToValidate="QRNMTxt" Display="None" ErrorMessage="Enter the name of the quality record" ValidationGroup="General"></asp:RequiredFieldValidator>
        
                <asp:CustomValidator id="QRNMTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "QRNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewDurationLabel" class="requiredlabel">Review Duration:</div>
                <div id="ReviewDurationField" class="fielddiv" style="width:200px">
                    <asp:TextBox ID="REVDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
            
                    <asp:Label ID="revslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>
                  
                    <asp:DropDownList ID="REVPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                    </asp:DropDownList>     
                </div>     
        
                <div id="REVPRD_LD" class="control-loader"></div>  
       
                <asp:RequiredFieldValidator ID="REVDURVal" runat="server" Display="None" ControlToValidate="REVDURTxt" ErrorMessage="Enter the review duration of the document" ValidationGroup="General"></asp:RequiredFieldValidator>
        
                <ajax:FilteredTextBoxExtender ID="REVDURFExt" runat="server" TargetControlID="REVDURTxt" FilterType="Numbers">
                </ajax:FilteredTextBoxExtender>
        
                <asp:CustomValidator id="REVDURTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "REVDURTxt" Display="None" ErrorMessage = "The review duration should be greater than zero"
                ClientValidationFunction="validateZero">
                </asp:CustomValidator>  

                <asp:RequiredFieldValidator ID="REVPRDTxtVal" runat="server" Display="None" ControlToValidate="REVPRDCBox" ErrorMessage="Select review period" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
                <asp:CompareValidator ID="REVPRDVal" runat="server" ControlToValidate="REVPRDCBox" Display="None" ValidationGroup="General"
                ErrorMessage="Select review period" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
    
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RetentionDurationLabel" class="requiredlabel">Retention Duration:</div>
                <div id="RetentionDurationField" class="fielddiv" style="width:200px">
                    <asp:TextBox ID="RETDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
            
                    <asp:Label ID="retslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>
                  
                    <asp:DropDownList ID="RETPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                    </asp:DropDownList>     
                </div>     
        
                <div id="RETPRD_LD" class="control-loader"></div>  
       
                <asp:RequiredFieldValidator ID="RETDURVal" runat="server" Display="None" ControlToValidate="RETDURTxt" ErrorMessage="Enter the retention duration of the record" ValidationGroup="General"></asp:RequiredFieldValidator>
        
                <ajax:FilteredTextBoxExtender ID="RETDURExt" runat="server" TargetControlID="RETDURTxt" FilterType="Numbers">
                </ajax:FilteredTextBoxExtender>
        
                <asp:CustomValidator id="RETDURFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "RETDURTxt" Display="None" ErrorMessage = "The retention duration should be greater than zero"
                ClientValidationFunction="validateZero">
                </asp:CustomValidator>  

                <asp:RequiredFieldValidator ID="RETPRDVal" runat="server" Display="None" ControlToValidate="RETPRDCBox" ErrorMessage="Select the retention period" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
                <asp:CompareValidator ID="RETPRDFVal" runat="server" ControlToValidate="RETPRDCBox" Display="None" ValidationGroup="General"
                ErrorMessage="Select the retention period" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RECFTYPLabel" class="requiredlabel">Record File Type:</div>
                <div id="RECFTYPField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="RECFTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div>

                <div id="RECFTYP_LD" class="control-loader"></div>  
       
                <asp:RequiredFieldValidator ID="RECFTYPVal" runat="server" Display="None" ControlToValidate="RECFTYPCBox" ErrorMessage="Select record file type" ValidationGroup="General"></asp:RequiredFieldValidator>         
       
                <asp:CompareValidator ID="RECFTYPFVal" runat="server" ControlToValidate="RECFTYPCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select record file type" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
           
     
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="QRURLLabel" class="labeldiv">Record File URL:</div>
                <div id="QRURLField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="QRURLTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                </div>
            
                <input id="VQRBTN" class="button" type="button" value="View" style="margin-left:5px; width:85px" />
 
                <asp:RegularExpressionValidator ID="QRURLFVal" runat="server" ControlToValidate="QRURLTxt"
                ErrorMessage="invalid URL e.g.(http://www.example.com) or (www.example.com)" ValidationExpression="^(http(s)?\://)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+\s&amp;%\$#\=~])*$" Display="None" ValidationGroup="General"></asp:RegularExpressionValidator> 
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="QRFileLabel" class="labeldiv">Upload Record File:</div>
                <div id="QRFileField" class="fielddiv" style="width:400px">
                    <asp:TextBox ID="QRFTxt" CssClass="readonly" runat="server" Width="390px" ReadOnly="true"></asp:TextBox>
                    <div class="uploaddiv"></div>
                    <input id="fileupload" type="file" name="file" style="width:0; height:0; display:block;"/>
                    <input id="filename" type="hidden" value=""/>
                    <div id="uploadmessage"></div>
                </div>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RemarksLabel" class="labeldiv">Remarks:</div>
                <div id="RemarksField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="RMKTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <asp:CustomValidator id="RMKTxtFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "RMKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:92px;">
                <div id="QRStatusLabel" class="requiredlabel">Status:</div>
                <div id="QRStatusField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="QRSTSCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="QRSTS_LD" class="control-loader"></div>
                
                <asp:RequiredFieldValidator ID="QRSTSTxtVal" runat="server" Display="None" ControlToValidate="QRSTSCBox" ErrorMessage="Select quality record status" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="QRSTSVal" runat="server" ControlToValidate="QRSTSCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select quality record status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
   
        </div>    
        <div id="AdditionalTB" class="tabcontent" style="display:none; height:450px;">

            <div id="validation_dialog_additional" class="validation" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Additional" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="IssueDateLabel" class="labeldiv">Issue Date:</div>
                <div id="IssueDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ISSUDTTxt" runat="server" CssClass="readonly" Width="140px" readonly="true"></asp:TextBox>
                </div>        
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewDateLabel" class="labeldiv">Last Review Date:</div>
                <div id="ReviewDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="REVDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>        

                <asp:RegularExpressionValidator ID="REVDTFVal" runat="server" ControlToValidate="REVDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$"  ValidationGroup="Additional"></asp:RegularExpressionValidator>  
        
                <asp:CustomValidator id="REVDTF2Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "REVDTTxt" Display="None" ErrorMessage = "Last review date should not be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="REVDTF3Val" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "REVDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>

                <asp:CompareValidator ID="REVDTF4Val" runat="server" ControlToCompare="ISSUDTTxt"
                ControlToValidate="REVDTTxt" ErrorMessage="Last review date should be greater or equals issue date"  ValidationGroup="Additional"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator>  
            </div>
           
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ORGUNTLabel" class="requiredlabel">Organization Unit:</div>
                <div id="ORGUNTField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>           
                </div>
                <div id="ORG_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="ORGUNTVal" runat="server" Display="None" ControlToValidate="ORGUNTCBox" ErrorMessage="Select the organization unit" ValidationGroup="Additional"></asp:RequiredFieldValidator>         
        
                <asp:CompareValidator ID="ORGUNTFVal" runat="server" ControlToValidate="ORGUNTCBox" Display="None" ValidationGroup="Additional"
                ErrorMessage="Select the organization unit" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RecordOriginatorLabel" class="requiredlabel">Record Originator:</div>
                <div id="RecordOriginatorField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="ORIGCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="ORIGN_LD" class="control-loader"></div>  
             
                <span id="ORIGNSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the originator of the quality record"></span>
        
                <asp:RequiredFieldValidator ID="ORIGTxtVal" runat="server" Display="None" ControlToValidate="ORIGCBox" ErrorMessage="Select quality record originator" ValidationGroup="Additional"></asp:RequiredFieldValidator>              
        
                <asp:CompareValidator ID="ORIGVal" runat="server" ControlToValidate="ORIGCBox" ValidationGroup="Additional"
                Display="None" ErrorMessage="Select quality record originator" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
    
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RecordOwnerLabel" class="requiredlabel">Record Owner:</div>
                <div id="RecordOwnerField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="Owner_LD" class="control-loader"></div>  
              
                <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the document"></span>
        
                <asp:RequiredFieldValidator ID="OWNRTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select quality record owner"  ValidationGroup="Additional"></asp:RequiredFieldValidator>              
        
                <asp:CompareValidator ID="OWNRFVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="Additional"
                Display="None" ErrorMessage="Select quality record owner" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

        </div>
       
        <div id="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
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

    </asp:Panel>

    <input id="invoker" type="hidden" value="" />
</div>

<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvQR.ClientID%> tr:last-child").clone(true);

        refresh(empty);

        $("#refresh").bind('click', function ()
        {
            hideAll();
            refresh(empty);
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#byQRNM").bind('click', function ()
        {
            hideAll();

            $("#<%=QRNMFTxt.ClientID%>").val('');

            $("#QRContainer").show();

        });

        $("#byORGUNT").bind('click', function ()
        {
            hideAll();
        
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTFCBox.ClientID%>", "#ORGUNTF_LD");

            $("#ORGUNTContainer").show();
        });

        $("#byRECMOD").bind('click', function ()
        {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#byQRSTS").bind('click', function ()
        {
            hideAll();
            $("#QRSTSContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadQualityRecordStatus', "#<%=QRSTSFCBox.ClientID%>", "#QRSTSF_LD");
        });

        $("#byISSDT").bind('click', function ()
        {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#StartdateContainer").show();
        });

        /*filter records according to their title*/
        $("#<%=QRNMFTxt.ClientID%>").keyup(function ()
        {
            filterByName($(this).val(), empty);
        })

        /*filter records according to the related organization unit*/
        $("#<%=ORGUNTFCBox.ClientID%>").change(function () {

            filterByOrganizationUnit($(this).val(), empty);
        });

        $("#<%=RECMODCBox.ClientID%>").change(function ()
        {
            filterByRecordMode($(this).val(), empty);
        });

        $("#<%=QRSTSFCBox.ClientID%>").change(function ()
        {
            filterByRecordStatus($(this).val(), empty);
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


        $("#<%=REVDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        /*At the current stage, documents can be viewed using google doc viewer tool where a customized document viewer can be added as a future work*/
        $("#VQRBTN").bind('click', function ()
        {
            window.open('http://docs.google.com/viewer?url=' + $("#<%=QRURLTxt.ClientID%>").val());
        });


        $("#<%=ORIGNSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Originator');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=OWNRSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });

        /*populate the employees in originatir, and owner cboxes*/
        $("#<%=SORGUNTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                switch ($("#invoker").val()) {
                    case "Originator":
                        loadcontrols.push("#<%=ORIGCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORIGN_LD");
                        break;
                    case "Owner":
                        loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#Owner_LD");
                        break;
                }
                $("#SelectORG").hide('800');
            }
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /* this will trigger download.ashx to download the attached file*/
        $("#QRFileDownload").bind('click', function ()
        {
            window.open(getURL().concat('DocumentDownload.ashx?key=' + $("#RecordID").val() + '&module=QR'));
        });


        $("#tabul li").bind("click", function ()
        {
            $("#tabul li").removeClass("ctab");
            $(this).addClass("ctab");

            $(".tabcontent").each(function () {
                $(this).css('display', 'none');
            });

            $("#" + $(this).attr("id") + "TB").css('display', 'block');
        });

        $("#fileupload").fileupload(
        {
            dataType: 'json',
            url: 'http://www.qmsrs.com/qmsrstools/Upload.ashx',
            progress: function (e, data) {
                $("#uploadmessage").show();
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $("#uploadmessage").html("Uploading(" + progress + "%)");
            },
            done: function (e, data) {
                $.each(data.files, function (index, file) {
                    /*temporarly store the name of the file*/
                    $("#filename").val(file.name);
                });

                $("#uploadmessage").hide("2000");

                $("#<%=QRFTxt.ClientID%>").val(data.result.name);
            },
            fail: function (e, err) {
                $("#uploadmessage").hide("2000");

                alert(err.errorThrown);
            }
        });

        $(".uploaddiv").bind('click', function () {
            $('input[type=file]').trigger('click');
        });

        $("#<%=QRURLTxt.ClientID%>").keyup(function () {
            if ($(this).val() == '') {
                if ($("#VQRBTN").is(":disabled") == false) {
                    /*set opacity property to 50% indicating the record view button is disabled by default*/
                    $("#VQRBTN").css({ opacity: 0.5 });

                    /*disable view button*/
                    disableViewButton(false);
                }
            }
            else {
                if ($("#VQRBTN").is(":disabled") == true) {
                    /*set opacity property to 100% indicating the record view button is enabled*/
                    $("#VQRBTN").css({ opacity: 1 });

                    /*enable view button*/
                    disableViewButton(true);
                }
            }
        });


        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('General');
            if (isPageValid)
            {
                if (!$("#validation_dialog_general").is(":hidden"))
                {
                    $("#validation_dialog_general").hide();
                }

                var isAdditionalValid = Page_ClientValidate('Additional');
                if (isAdditionalValid)
                {
                    if (!$("#validation_dialog_additional").is(":hidden")) {
                        $("#validation_dialog_additional").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {
                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            var issuedatepart = getDatePart($("#<%=ISSUDTTxt.ClientID%>").val());
                            var lrevpart = getDatePart($("#<%=REVDTTxt.ClientID%>").val());

                            var qualityrecord =
                            {
                                RecordID: $("#RecordID").val(),
                                RecordNo: $("#<%=QRNOTxt.ClientID%>").val(),
                                Title: $("#<%=QRNMTxt.ClientID%>").val(),
                                Department: ($("#<%=ORGUNTCBox.ClientID%>").val() == 0 || $("#<%=ORGUNTCBox.ClientID%>").val() == null ? '' : $("#<%=ORGUNTCBox.ClientID%>").val()),
                                ReviewDuration: $("#<%=REVDURTxt.ClientID%>").val(),
                                ReviewPeriod: $("#<%=REVPRDCBox.ClientID%>").find('option:selected').text(),
                                RetentionDuration: $("#<%=RETDURTxt.ClientID%>").val(),
                                RetentionPeriod: $("#<%=RETPRDCBox.ClientID%>").find('option:selected').text(),
                                Remarks: $("#<%=RMKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMKTxt.ClientID%>").val()),
                                Originator: $("#<%=ORIGCBox.ClientID%>").val(),
                                Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                                ReviewDate: lrevpart == '' ? null : new Date(lrevpart[2], (lrevpart[1] - 1), lrevpart[0]),
                                IssueDate: new Date(issuedatepart[2], (issuedatepart[1] - 1), issuedatepart[0]),
                                RecordFileType: $("#<%=RECFTYPCBox.ClientID%>").val(),
                                RecordFileURL: $("#<%=QRURLTxt.ClientID%>").val(),
                                RecordFile: $("#<%=QRFTxt.ClientID%>").val().replace(/\\/g, '/'),
                                RecordFileName: $("#filename").val(),
                                RecordStatusString: $("#<%=QRSTSCBox.ClientID%>").val()
                            }


                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(qualityrecord) + "\'}",
                                url: getServiceURL().concat('updateQualityRecord'),
                                success: function (data)
                                {
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
                else
                {
                    $("#validation_dialog_additional").stop(true).hide().fadeIn(500, function () {

                        alert("Please make sure that all warnings in the additional TAB are fulfilled");
                        navigate('Additional');
                    });
                }
            }
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings in the details TAB are fulfilled");
                    navigate('Details');
                });
            }
        });
    });

    
    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 290, top: y - 109 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#SORGUNT_LD");
        $("#SelectORG").show();
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

    function filterByDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#QRwait").stop(true).hide().fadeIn(500, function ()
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
                    url: getServiceURL().concat('filterQualityRecordByIssueDate'),
                    success: function (data) {
                        $("#QRwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            /* show module tooltip */
                            $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                                $(this).slideDown(800, 'easeOutBounce');
                            });

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(this).find('p').html("List of all current quality records where the issue date between " + startdate.format('dd/MM/yyyy') + " and " + enddate.format('dd/MM/yyyy') + ".<br/> Note:Withdrawn, or Cancelled quality records cannot be modified");
                            });

                            if (data)
                            {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#QRwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(500, function () {

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByName(title, empty)
    {
        $("#QRwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat("filterQualityRecordByName"),
                success: function (data) {
                    $("#QRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        $("#FilterTooltip").stop(true).hide().fadeIn(500, function () {

                            $(this).find('p').html("List of all current quality records filtered by their title. <br/> Note:Withdrawn, or Cancelled quality records cannot be modified");
                        });


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#QRwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByRecordMode(mode, empty)
    {
        $("#QRwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat("filterQualityRecordByMode"),
                success: function (data)
                {
                    $("#QRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        /* show module tooltip */
                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        $("#FilterTooltip").stop(true).hide().fadeIn(500, function () {

                            $(this).find('p').html("List of all current quality records filtered by their mode. <br/> Note:Withdrawn, or Cancelled quality records cannot be modified");
                        });

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#QRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }


    function filterByRecordStatus(status, empty) {
        $("#QRwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat("filterQualityRecordByStatus"),
                success: function (data)
                {
                    $("#QRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        /* show module tooltip */
                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        $("#FilterTooltip").stop(true).hide().fadeIn(500, function () {

                            $(this).find('p').html("List of all current quality records filtered by their status. <br/> Note:Withdrawn, or Cancelled quality records cannot be modified");
                        });

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#QRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByOrganizationUnit(unit, empty)
    {
        $("#QRwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'unit':'" + unit + "'}",
                url: getServiceURL().concat("filterQualityRecordByOrganization"),
                success: function (data)
                {
                    $("#QRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        /* show module tooltip */
                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });


                        $("#FilterTooltip").stop(true).hide().fadeIn(500, function () {

                            $(this).find('p').html("List of all current quality records filtered by the related organization unit. <br/> Note:Withdrawn, or Cancelled quality records cannot be modified");
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#QRwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function refresh(empty) {
        $("#QRwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadQualityRecordList"),
                success: function (data)
                {
                    $("#QRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        /* show module tooltip */
                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        $("#FilterTooltip").stop(true).hide().fadeIn(500, function () {

                            $(this).find('p').html("List of all current quality records. <br/> Note:Withdrawn, or Cancelled quality records cannot be modified");
                        });


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#QRwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadGridView(data, empty)
    {
        var xmlQR = $.parseXML(data);
        var row = empty;

        /* remove all previous records */
        $("#<%=gvQR.ClientID%> tr").not($("#<%=gvQR.ClientID%> tr:first-child")).remove();

        $(xmlQR).find('QualityRecord').each(function (index, record)
        {
            /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
            var date = new Date();

            $("td", row).eq(0).html("<img id='icon_" + index + "' src='http://www.qmsrs.com/qmsrstools/RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('RecordID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
            $("td", row).eq(1).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(2).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");
            $("td", row).eq(3).html($(this).attr("RecordNo"));
            $("td", row).eq(4).html($(this).attr("Title"));
            $("td", row).eq(5).html($(this).attr("Department"));
            $("td", row).eq(6).html($(this).attr("Originator"));
            $("td", row).eq(7).html($(this).attr("Owner"));
            $("td", row).eq(8).html(new Date($(this).attr("IssueDate")).format("dd/MM/yyyy"));
            $("td", row).eq(9).html($(this).find("ReviewDate").text() == '' ? '' : new Date($(this).find("ReviewDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(10).html($(this).attr("ReviewDuration") + " " + $(this).attr("ReviewPeriod"));
            $("td", row).eq(11).html($(this).attr("RetentionDuration") + " " + $(this).attr("RetentionPeriod"));
            $("td", row).eq(12).html($(this).attr("RecordStatusString"));

            $("#<%=gvQR.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {

                if ($(this).attr('id').search('delete') != -1)
                {

                    $(this).bind('click', function ()
                    {
                        removeQualityRecord($(record).attr('RecordID'));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        resetGroup('.modalPanel');

                        /*bind QR ID value*/
                        $("#RecordID").val($(record).attr('RecordID'));

                        /*bind QR No*/
                        $("#<%=QRNOTxt.ClientID%>").val($(record).attr('RecordNo'));

                        /*bind QR title*/
                        $("#<%=QRNMTxt.ClientID%>").val($(record).attr('Title'));

                        /*bind review duration*/
                        $("#<%=REVDURTxt.ClientID%>").val($(record).attr('ReviewDuration'));

                        /*bind review period*/
                        bindComboboxAjax('loadPeriod', '#<%=REVPRDCBox.ClientID%>', $(record).attr("ReviewPeriod"), "#REVPRD_LD");

                        /*bind retention duration*/
                        $("#<%=RETDURTxt.ClientID%>").val($(record).attr('RetentionDuration'));

                        /*bind retention period*/
                        bindComboboxAjax('loadPeriod', '#<%=RETPRDCBox.ClientID%>', $(record).attr("RetentionPeriod"), "#RETPRD_LD");

                        /*bind quality record originator*/
                        bindComboboxAjax('loadEmployees', '#<%=ORIGCBox.ClientID%>', $(record).attr("Originator"), "#ORIGN_LD");

                        /*bind quality record Owner*/
                        bindComboboxAjax('loadEmployees', '#<%=OWNRCBox.ClientID%>', $(record).attr("Owner"), "#Owner_LD");

                        /*bind organization unit*/
                        bindComboboxAjax('getOrganizationUnits', '#<%=ORGUNTCBox.ClientID%>', $(record).attr("Department"), "#ORG_LD");

                        /*bind record file type*/
                        bindComboboxAjax('loadDocumentFileTypes', "#<%=RECFTYPCBox.ClientID%>", $(record).attr("RecordFileType"), "#RECFTYP_LD");
       
                        /*bind QR status*/
                        bindComboboxAjax('loadQualityRecordStatus', '#<%=QRSTSCBox.ClientID%>', $(record).attr("RecordStatusString"), "#QRSTS_LD");

                        /*bind issue date value*/
                        $("#<%=ISSUDTTxt.ClientID%>").val(new Date($(record).attr("IssueDate")).format("dd/MM/yyyy"));

                        /*bind review date date*/
                        $("#<%=REVDTTxt.ClientID%>").val($(record).find("ReviewDate").text() == '' ? '' : new Date($(record).find("ReviewDate").text()).format("dd/MM/yyyy"));

                        /*bind remarks*/
                        if ($(record).attr("Remarks") == '')
                        {
                            addWaterMarkText('Additional details in the support of the quality record', '#<%=RMKTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=RMKTxt.ClientID%>").hasClass("watermarktext")) {

                                $("#<%=RMKTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=RMKTxt.ClientID%>").html($(record).attr("Remarks")).text();
                        }

                     
                        if ($(record).attr("RecordFileName") != '')
                        {
                            $("#QRFileDownload").stop(true).hide().fadeIn(500, function ()
                            {
                                $(this).find('img').attr('src', "http://www.qmsrs.com/qmsrstools/ImageHandler.ashx?query=select Icon from DocumentList.DocumentFileType where FileType='" + $(record).attr("RecordFileType") + "'&width=20&height=20");
                                $(this).find('p').text("Click here to download the file " + $(record).attr('RecordFileName'));
                            });
                        }
                        else
                        {
                            $("#QRFileDownload").hide();
                        }

                        /*bind QR file URL*/
                        $("#<%=QRURLTxt.ClientID%>").val($(record).attr('RecordFileURL'));

                        /* check if there is a URL for the document to view*/
                        if ($(record).attr('RecordFileURL') == '') {
                            /*set opacity property to 50% indicating the document view button is disabled by default*/
                            $("#VQRBTN").css({ opacity: 0.5 });

                            /*disable view button*/
                            disableViewButton(false);
                        }
                        else
                        {
                            /*set opacity property to 100% indicating the document view button is enabled*/
                            $("#VQRBTN").css({ opacity: 1 });

                            /*activate view button*/
                            disableViewButton(true);
                        }

                        //activate the first TAB
                        resetTab();

                        /*attach the title of the quality record to limit plugin*/
                        $('#<%=QRNMTxt.ClientID%>').limit({ id_result: 'QRNMlimit', alertClass: 'alertremaining', limit: 90 });

                        $('.textbox').each(function () {
                            $(this).keyup();
                        });

                        /*Check if the quality record is disposed or cancelled so that it may enable or disable changes*/
                        if ($(record).attr('RecordStatusString') == 'Disposed' || $(record).attr('RecordStatusString') == 'Cancelled')
                        {
                            $("#QRTooltip").find('p').html("Changes cannot take place since the quality record is " + $(record).attr('RecordStatusString'));

                            if ($("#QRTooltip").is(":hidden")) {
                                $("#QRTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else if ($(record).attr('ModeString') == 'Archived')
                        {
                            $("#QRTooltip").find('p').html("Changes cannot take place since the quality record was sent to archive.");

                            if ($("#QRTooltip").is(":hidden")) {
                                $("#QRTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else
                        {
                            $("#QRTooltip").hide();

                            /*enable all modal controls for editing*/
                            ActivateAll(true);
                        }

                        /*trigger popup modal pane*/
                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }
            });
            row = $("#<%=gvQR.ClientID%> tr:last-child").clone(true);
        });
    }

    function removeQualityRecord(id)
    {

        var result = confirm("Are you sure you would like to remove the selected quality record?");
        if (result == true) {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'recordID':'" + id + "'}",
                url: getServiceURL().concat('removeQualityRecord'),
                success: function (data) {
                    $(".modulewrapper").css("cursor", "default");

                    $("#refresh").trigger('click');
                },
                error: function (xhr, status, error) {
                    $(".modulewrapper").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }
    }
    function disableViewButton(enabled) {
        if (enabled == false) {
            $("#VQRBTN").attr('disabled', true);

            /*set opacity property to 50% indicating the document view button is disabled by default*/
            $("#VQRBTN").css({ opacity: 0.5 });

        }
        else {
            $("#VQRBTN").attr('disabled', false);

            /*set opacity property to 100% indicating the document view button is enabled*/
            $("#VQRBTN").css({ opacity: 1 });

        }
    }

    function resetTab()
    {
        //clear previously activated tabs
        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        //bind to the first tab
        $("#tabul li").removeClass("ctab");

        $("#Details").addClass("ctab");
        $("#DetailsTB").css('display', 'block');
    }

    function ActivateAll(isactive)
    {
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

    function navigate(name) {
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
