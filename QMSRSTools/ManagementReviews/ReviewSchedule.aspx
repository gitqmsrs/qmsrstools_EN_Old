<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ReviewSchedule.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ReviewSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="ManageReviewSchedule_Header" class="moduleheader">Management Review Meeting Schedule</div>
    
    <div class="toolbox">
        <img id="refreshschedule" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byREVSTS">Filter by Review Status</li>
                <li id="byREVCAT">Filter by Review Category</li>
                <li id="byPLNREV">Planned Review Date</li>
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="byREVTTL">Filter by Meeting Title</li>
            </ul>
        </div>   
    </div>    

    <div id="ReviewtStatusContainer" class="filter">
        <div id="ReviewStatusFLabel" class="filterlabel">Review Status:</div>
        <div id="ReviewStatusFField" class="filterfield">
            <asp:DropDownList ID="REVSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="REVFSTS_LD" class="control-loader"></div>
    </div>

    <div id="ReviewCategoryContainer" class="filter">
        <div id="ReviewCategoryFLabel" class="filterlabel">Review Category:</div>
        <div id="ReviewCategoryFField" class="filterfield">
            <asp:DropDownList ID="REVCATFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="REVFCAT_LD" class="control-loader"></div>
    </div>

    <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RECMODF_LD" class="control-loader"></div>
     </div>

     <div id="PlannedReviewDateContainer" class="filter">
        <div id="PlannedReviewDateLabel" class="filterlabel">Planned Review Date:</div>
        <div id="PlannedReviewField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>

        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>
    
    <div id="ReviewTitleContainer" class="filter">
        <div id="ReviewTitleLabel" class="filterlabel">Review Title:</div>
        <div id="ReviewTitleField" class="filterfield">
            <asp:TextBox ID="REVNMFTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>

    <div id="RAGTooltip" class="tooltip" style="margin-top:10px;"> 
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="RED" src="/Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: The management review is overdue.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="GREEN" src="/Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: The management review is on schedule.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="AMBER" src="/Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: The management review has been delayed.</p>
        </div>
    </div>	
    
    <div id="SCHDwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id='calendar'></div>

    <div id="Review_LD" class="control-loader"></div> 

    <div id="ReviewOption" class="optionbox" style="top:110px; width:400px;">
        <div id="closeOption" class="optionclose"></div>

        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="ReviewNoLabel" class="labeldiv" style="width:100px;">Review No:</div>
            <div id="ReviewNoField" class="fielddiv" style="width:130px">
                <asp:TextBox ID="REVNOTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="120px"></asp:TextBox>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="EventLabel" class="labeldiv" style="width:100px;">Event Name:</div>
            <div id="EventField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="EVNTTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="240px"></asp:TextBox>
            </div>
        </div>

        <div class="buttondiv">
            <img id='delete_review' src='/Images/deletenode.png' class='imgButton' alt="Remove Course" style='float:left;' title='Remove course' />
            <img id='edit_review' src='/Images/edit.png' class='imgButton' alt="Edit Course" style='float:left;' title='Edit course' />
        </div>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="ManagementReviewHeader" class="modalHeader">Management Review Details<span id="Close" class="modalclose" title="Close">X</span></div>
        
        <div id="ReviewTooltip" class="tooltip">
            <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <ul id="tabul">
            <li id="Details" class="ntabs">Details</li>
            <li id="ORGUnits" class="ntabs">Related Organization Units</li>
            <li id="Representatives" class="ntabs">Representatives</li>
            <li id="ScopeSummary" class="ntabs">Scope and Summary</li>
            <li id="Additional" class="ntabs">Additional Info</li>
        </ul>
        <div id="DetailsTB" class="tabcontent" style="display:none; height:470px;">
            
            <div id="validation_dialog_general">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="REVIDLabel" class="requiredlabel">Review ID:</div>
                <div id="REVIDField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="REVIDTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="90px"></asp:TextBox>
                </div>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewCategoryLabel" class="labeldiv">Review Category:</div>
                <div id="ReviewCategoryField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="REVCATCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox" ValidationGroup="General">
                    </asp:DropDownList>
                </div>
                <div id="REVCAT_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="REVCATTxtVal" runat="server" Display="None" ControlToValidate="REVCATCBox" ErrorMessage="Select review category" ValidationGroup="General"></asp:RequiredFieldValidator>         
                
                <asp:CompareValidator ID="REVCATVal" runat="server" ControlToValidate="REVCATCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select review category" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="MeetingTitleLabel" class="requiredlabel">Review Meeting Title:</div>
                <div id="MeetingTitleField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="REVNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
                </div>
                <div id="MNMlimit" class="textremaining"></div>
                <asp:RequiredFieldValidator ID="REVNMVal" runat="server" Display="None" ControlToValidate="REVNMTxt" ErrorMessage="Enter the name of the review meeting event" ValidationGroup="General"></asp:RequiredFieldValidator>
                
                <asp:CustomValidator id="REVNMTxtFVal" runat="server" ValidationGroup="General" Display="None"
                ControlToValidate = "REVNMTxt" CssClass="validator" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>
                              
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewDateLabel" class="requiredlabel">Planned Review Date:</div>
                <div id="ReviewDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="REVDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="REVDTVal" runat="server" Display="None" ControlToValidate="REVDTTxt" ErrorMessage="Enter the planned review date" ValidationGroup="General"></asp:RequiredFieldValidator>
       
                <asp:RegularExpressionValidator ID="REVDTFVal" runat="server" ControlToValidate="REVDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  

                <asp:CustomValidator id="REVDTTxtF3Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "REVDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ActualReviewDateLabel" class="labeldiv">Actual Review Date:</div>
                <div id="ActualReviewDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ACTREVDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                
                <asp:RegularExpressionValidator ID="ACTREVDTVal" runat="server" ControlToValidate="ACTREVDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  

                <asp:CustomValidator id="ACTREVDTFVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "ACTREVDTTxt" Display="None" ErrorMessage = "Actual review date shouldn't be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="ACTREVDTF2Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "ACTREVDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ActualCloseDateLabel" class="labeldiv">Actual Close Date:</div>
                <div id="ActualCloseDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ACTCLSDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                
                <asp:RegularExpressionValidator ID="ACTCLSDTVal" runat="server" ControlToValidate="ACTCLSDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  

                <asp:CompareValidator ID="ACTCLSDTF1Val" runat="server" ControlToCompare="ACTREVDTTxt"  ValidationGroup="General"
                ControlToValidate="ACTCLSDTTxt" ErrorMessage="Actual close date should be greater than or equals actual review date"
                Operator="GreaterThanEqual" Type="Date"
                Display="None"></asp:CompareValidator>     
 
                <asp:CustomValidator id="ACTCLSDTF2Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "ACTCLSDTTxt" Display="None" ErrorMessage = "Actual close date shouldn't be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="ACTCLSDTF3Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "ACTCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewStatusLabel" class="requiredlabel">Review Status:</div>
                <div id="ReviewStatusField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="REVSTSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="REVSTS_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="REVSTSTxtVal" runat="server" Display="None" ControlToValidate="REVSTSCBox" ErrorMessage="Select review status" ValidationGroup="General"></asp:RequiredFieldValidator> 
                 
                <asp:CompareValidator ID="REVSTSVal" runat="server" ControlToValidate="REVSTSCBox"
                Display="None" ErrorMessage="Select review status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
            </div>
        </div>
        <div id="ORGUnitsTB" class="tabcontent" style="display:none;height:470px">
            <span id="lblUnitMessage" class="validator"></span>
             <div class="toolbox">
                <img id="newORG" src="/Images/new_file.png" class="imgButton" title="Add New Organization Unit" alt=""/>
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
        <div id="RepresentativesTB" class="tabcontent" style="display:none;height:470px">
            <span id="lblRepMessage" class="validator"></span>
            <img id="newRepresentative" src="/Images/new_file.png" class="imgButton" title="Add new representative" alt=""/>
       
            <div id="SelectEMP" class="selectbox" style="top:15px; left:10px;">
                <div id="EMPClose" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="SelectEmployeeUnitLabel" class="labeldiv" style="width:100px;">Select Unit:</div>
                    <div id="SelectEmployeeUnitField" class="fielddiv" style="width:130px">
                        <asp:DropDownList ID="EMPUNTCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="ORGUNTE_LD" class="control-loader"></div> 
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
                <div id="RepresentativesCHKLabel" class="labeldiv">Select Representatives:</div>
                <div id="RepresentativesCHKField" class="fielddiv" style="width:250px">
                    <div id="REPRCHK" class="checklist"></div>
                </div>
            </div>
        </div>
        <div id="ScopeSummaryTB" class="tabcontent" style="display:none;height:470px;">

            <div id="validation_dialog_scopesummery">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="ScopeSummary" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ObjectivesLabel" class="labeldiv">Meeting Objectives:</div>
                <div id="ObjectivesField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="OBJTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="OBJTxtVal" runat="server" ValidationGroup="ScopeSummary" 
                ControlToValidate = "OBJTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:125px;">
                <div id="SummaryLabel" class="labeldiv">Summary:</div>
                <div id="SummaryField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="SUMMTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="SUMMTxtVal" runat="server" ValidationGroup="ScopeSummary" 
                ControlToValidate = "SUMMTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:125px;">
                <div id="CommentsLabel" class="labeldiv">Additional Notes:</div>
                <div id="CommentsField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="NOTETxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
                <asp:CustomValidator id="NOTETxtVal" runat="server" ValidationGroup="ScopeSummary" 
                ControlToValidate = "NOTETxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>
        <div id="AdditionalTB" class="tabcontent" style="display:none;height:470px;">
            <div id="AdditionalTooltip" class="tooltip">
                <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
                <p></p>
	        </div>	
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ORGUnitRecipientLabel" class="labeldiv">Select ORG. Unit:</div>
                <div id="ORGUnitRecipientField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="ORGUNTRECBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNT_LD" class="control-loader"></div> 
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RecipientsLabel" class="labeldiv">Select Record Recipients:</div>
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
    
    <input id="review_id" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">
        $(function ()
        {
            /* load default calendar*/
            loadReviewSchedule();

            /* show RAG tooltip */
            if ($("#RAGTooltip").is(":hidden")) {
                $("#RAGTooltip").slideDown(800, 'easeOutBounce');
            }

            $("#<%=REVDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=ACTREVDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=ACTCLSDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#byREVSTS").bind('click', function () {
                hideAll();

                /*load review status*/
                loadComboboxAjax('loadReviewStatus', '#<%=REVSTSFCBox.ClientID%>', "#REVFSTS_LD");

                $("#ReviewtStatusContainer").show();
            });


            $("#byREVCAT").bind('click', function () {
                hideAll();

                /*load review category*/
                loadReviewCategory();

                $("#ReviewCategoryContainer").show();
            });

            $("#byRECMOD").bind('click', function () {
                hideAll();
    
                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");

                $("#RecordModeContainer").show();

            });

            $("#byREVTTL").bind('click', function ()
            {
                hideAll();

                $("#<%=REVNMFTxt.ClientID%>").val('');

                $("#ReviewTitleContainer").show();

            });

            $("#byPLNREV").bind('click', function () {
                hideAll();
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#PlannedReviewDateContainer").show();
            });

            $("#<%=REVNMFTxt.ClientID%>").keyup(function ()
            {
                filterByTitle($(this).val());
            });

            $("#<%=FDTTxt.ClientID%>").keyup(function ()
            {
                filterByPlannedReviewDate($(this).val(), $("#<%=TDTTxt.ClientID%>").val());
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function ()
            {
                filterByPlannedReviewDate($("#<%=FDTTxt.ClientID%>").val(), $(this).val());
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByPlannedReviewDate(date, $("#<%=TDTTxt.ClientID%>").val());
                }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByPlannedReviewDate($("#<%=FDTTxt.ClientID%>").val(), date);
                }
            });

            $("#refreshschedule").bind('click', function ()
            {
                hideAll();
                loadReviewSchedule();
            });


            $("#Close").bind('click', function ()
            {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                     $("#<%=ORGUNTRECBox.ClientID%> option").attr("disabled", false);
                }
            });

            $('#<%=REVSTSFCBox.ClientID%>').change(function ()
            {
                if ($(this).val() != 0)
                {
                    filterByStatus($(this).val());
                }

            });

            $('#<%=REVCATFCBox.ClientID%>').change(function () {
                if ($(this).val() != 0) {
                    filterByCategory($(this).val());
                }
            });

            $("#<%=RECMODCBox.ClientID%>").change(function () {
                if ($(this).val() != 0)
                {
                    filterByMode($(this).val());
                }
            });

            $("#newRepresentative").bind('click', function ()
            {
                loadComboboxAjax('getOrganizationUnits', "#<%=EMPUNTCBox.ClientID%>", "#ORGUNTE_LD");
                $("#<%=EMPCBox.ClientID%>").empty();

                $("#SelectEMP").show();
            });

            $("#<%=EMPUNTCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0) 
                {
                    var loadcontrols = new Array();
                    loadcontrols.push('#<%=EMPCBox.ClientID%>');

                    unitparam = "'unit':'" + $(this).val() + "'";
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORGUNTE_LD");
                }
            });

            $("#<%=EMPCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    addRepresentative($(this).val());
                    $("#SelectEMP").hide('800');
                }
            });

            $("#EMPClose").bind('click', function ()
            {
                $("#SelectEMP").hide('800');
            });

            /*TAB navigation event*/
            $("#tabul li").bind("click", function ()
            {
                if ($(this).attr("id") == 'Additional') {
                    $("#AdditionalTooltip").find('p').text("You may choose general managers and steering commities to recieve a notification of adding the review record");

                    if ($("#AdditionalTooltip").is(":hidden")) {
                        $("#AdditionalTooltip").slideDown(800, 'easeOutBounce');
                    }
                }
                else {
                    $("#AdditionalTooltip").hide();
                }
                navigate($(this).attr("id"));
            });

            /*load all potential recipients to recipient checkbox*/
            $("#<%=ORGUNTRECBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0) {
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
                            success: function (data) {
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
                            error: function (xhr, status, error) {
                                $("#ORGUNT_LD").fadeOut(500, function () {
                                    $(".modulewrapper").css("cursor", "default");

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                });
                            }
                        });
                    });

                    $("#<%=ORGUNTRECBox.ClientID%> option:selected").attr("disabled", true)
                }
            });

            $("#Add").bind('click', function () {
                setRecipients("#ToCHK");
            });

           

            $("#save").bind('click', function ()
            {
                var units = $("#table").table('getJSON');
                var removeAll = true;
                var removeAllrep = true;
                var hasError = false;

                for (x = 0; x < units.length; x++) {
                    if (units[x].Status != 4) {
                        removeAll = false;
                    }
                }

                var representatives = getRepresentativesJSON();
                var repName = [];
                var repDuplicates = false;

                for (x = 0; x < representatives.length; x++) {
                    if (representatives[x].Status != 4) {
                        repName.push(representatives[x].NameFormat);
                        removeAllrep = false;
                    }
                }

                repName = repName.sort();

                for (y = 0; y < repName.length; y++) {
                    if (repName[y + 1] == repName[y]) {
                        repDuplicates = true;
                    }
                }

                if (removeAll) {
                    $("#lblUnitMessage").html("<ul><li>Organization Unit is required.</li></ul>");
                    $("#lblUnitMessage").show();
                    navigate('ORGUnits');
                    hasError = true;
                } else if (repDuplicates) {
                    $("#lblRepMessage").html("<ul><li>Duplicate name exists.</li></ul>");
                    $("#lblRepMessage").show();
                    navigate('Representatives');
                    hasError = true;
                } else if (representatives == null || representatives == "" || (representatives.length == 1 && representatives[0].Status == 4) || (removeAllrep)) {
                    $("#lblRepMessage").html("<ul><li>Representative is required.</li></ul>");
                    $("#lblRepMessage").show();
                    navigate('Representatives');
                    hasError = true;
                }

                if (!hasError) {
                    $("#lblUnitMessage").hide();
                    $("#lblRepMessage").hide();
                    funcDetailsValid();
                }

                function funcDetailsValid() {
                    var isGeneralValid = Page_ClientValidate('General');
                    if (isGeneralValid)
                    {
                        if (!$("#validation_dialog_general").is(":hidden"))
                        {
                            $("#validation_dialog_general").hide();
                        }

                        var isScopeSummaryValid = Page_ClientValidate('ScopeSummary');
                        if(isScopeSummaryValid)
                        {
                            if (!$("#validation_dialog_scopesummery").is(":hidden"))
                            {
                                $("#validation_dialog_scopesummery").hide();
                            }

                            var result = confirm("Are you sure you would like to submit changes?");
                            if (result == true)
                            {

                                $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                                    ActivateSave(false);

                                    var REVDTParts = getDatePart($("#<%=REVDTTxt.ClientID%>").val());
                                    var ACTREVDTParts = getDatePart($("#<%=ACTREVDTTxt.ClientID%>").val());
                                    var ACTCLSDTParts = getDatePart($("#<%=ACTCLSDTTxt.ClientID%>").val());
                                    var review =
                                    {
                                        ReviewNo: $.trim($("#<%=REVIDTxt.ClientID%>").val()),
                                        ReviewName: $("#<%=REVNMTxt.ClientID%>").val(),
                                        ReviewCategory: $("#<%=REVCATCBox.ClientID%>").val(),
                                        PlannedReviewDate: new Date(REVDTParts[2], (REVDTParts[1] - 1), REVDTParts[0]),
                                        ActualReviewDate: $("#<%=ACTREVDTTxt.ClientID%>").val() == '' ? null : new Date(ACTREVDTParts[2], (ACTREVDTParts[1] - 1), ACTREVDTParts[0]),
                                        ActualCloseDate: $("#<%=ACTCLSDTTxt.ClientID%>").val() == '' ? null : new Date(ACTCLSDTParts[2], (ACTCLSDTParts[1] - 1), ACTCLSDTParts[0]),
                                        Objectives: $("#<%=OBJTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=OBJTxt.ClientID%>").val()),
                                        Summary: $("#<%=SUMMTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=SUMMTxt.ClientID%>").val()),
                                        Notes: $("#<%=NOTETxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=NOTETxt.ClientID%>").val()),
                                        ReviewStatusStr: $("#<%=REVSTSCBox.ClientID%>").val(),
                                        Representatives: getRepresentativesJSON(),
                                        Units: $("#table").table('getJSON'),
                                        Recipients: getRecipientsJSON()
                                    }

                              
                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{\'json\':\'" + JSON.stringify(review) + "\'}",
                                        url: getServiceURL().concat("updateReview"),
                                        success: function (data) {
                                            $("#SaveTooltip").fadeOut(500, function () {
                                                ActivateSave(true);

                                                showSuccessNotification(data.d);

                                                $("#cancel").trigger('click');
                                                $("#refreshschedule").trigger('click');
                                                $("#<%=ORGUNTRECBox.ClientID%> option").attr("disabled", false);
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
                            $("#validation_dialog_scopesummery").stop(true).hide().fadeIn(500, function ()
                            {
                            
                                navigate('ScopeSummary');
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
                }
            });

            $("#edit_review").bind('click', function ()
            {
                $("#closeOption").trigger('click');

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'reviewID':'" + parseInt($("#review_id").val()) + "'}",
                    url: getServiceURL().concat("getManagementReview"),
                    success: function (data)
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            bindReviewData(data.d);
                        }
                    },
                    error: function (xhr, status, error)
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    }
                });
            });

            $("#delete_review").bind('click', function ()
            {
                $("#closeOption").trigger('click');

                removeReview(parseInt($("#review_id").val()));
            });

            /*close review option box*/
            $("#closeOption").bind('click', function () {
                $("#ReviewOption").hide('800');
            });

            $("#newORG").bind('click', function () {

                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#UNT_LD");

                $("#SelectUnit").show();
            });

            $("#<%=ORGUNTCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0) {
                    addUnit($(this).val());

                    $("#SelectUnit").hide('800');
                }
            });
        });

      

        function getRepresentativesJSON()
        {
            var representatives = new Array();
            $("#REPRCHK").children(".checkitem").each(function () {
                $(this).find('input').each(function (index, value) {
                    var representative =
                    {
                        NameFormat: $(this).parent().find('.checkboxlabel').text(),
                        Status: $(value).val()
                    };
                    representatives.push(representative);
                });
            });

            //if (representatives.length == 0)
            //    return null;

            return representatives;
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

        function setRecipients(control)
        {
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
                            $(this).attr("disabled", true)
                            
                        }
                        else {
                            $(this).attr("disabled", true).attr("checked", true)
                        }

                        $("#delete_" + $(control).attr('id') + "_" + $(this).val().substring($(this).val().lastIndexOf(' ') + 1, $(this).val().length - 1)).bind('click', function () {
                            $(this).parent().remove();
                            $("input[value='" + $(this).prev().html() + "']").attr("disabled", false).attr("checked", false);
                        });
                    }
                });
            });
        }

        function RecipientExists(control, employee) {
            var found = false;
            $(control).children().each(function (index, value) {
                if ($(this).find('.infotext').text() == employee) {
                    found = true;
                }
            });

            return found;
        }
        function removeReview(ID)
        {
            var result = confirm("Removing the current management review record might cause all related tasks and their actions to be remove accordignly, are you sure you would like to continue?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'ID':'" + ID + "'}",
                    url: getServiceURL().concat("removeReview"),
                    success: function (data)
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#refreshschedule").trigger('click');
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
        function loadReviewCategory()
        {
            $("#REVFCAT_LD").stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadReviewCategories"),
                    success: function (data)
                    {
                        $("#REVFCAT_LD").fadeOut(500, function ()
                        {
                            if (data)
                            {
                                var xml = $.parseXML(data.d);

                                loadComboboxXML(xml, 'Category', 'CategoryName', '#<%=REVCATFCBox.ClientID%>');
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#REVFCAT_LD").fadeOut(500, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
        function bindReviewCategory(value)
        {
            $("#REVCAT_LD").stop(true).hide().fadeIn(500, function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadReviewCategories"),
                    success: function (data) {
                        $("#REVCAT_LD").fadeOut(500, function ()
                        {
                            if (data)
                            {
                                var xml = $.parseXML(data.d);

                                bindComboboxXML(xml, 'Category', 'CategoryName', value, '#<%=REVCATCBox.ClientID%>');
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#REVCAT_LD").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

        function loadReviewSchedule()
        {
            $("#SCHDwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                /*remove previous calendar data*/

                $("#calendar").empty();

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",
                    url: getServiceURL().concat('loadManagementReviewSchedule'),
                    success: function (data) 
                    {
                        var data = $.parseJSON(data.d);

                        $("#SCHDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var eventdata = new Array();

                            $(data).each(function (index, value) {
                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(parseInt(value.start.substr(6))),
                                    modulename: value.modulename
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                                eventClick: function (calEvent, jsEvent, view) {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{'reviewID':'" + calEvent.id + "'}",
                                        url: getServiceURL().concat("getManagementReview"),
                                        success: function (data) {
                                            if (data) {
                                                $(".modulewrapper").css("cursor", "default");

                                                $("#review_id").val(calEvent.id);

                                                var xmlReview = $.parseXML(data.d);
                                                var review = $(xmlReview).find('Review');

                                                $("#<%=REVNOTxt.ClientID%>").val(review.attr('ReviewNo'));
                                                $("#<%=EVNTTxt.ClientID%>").val(review.attr('ReviewName'));

                                                showReviewOption(jsEvent.pageX, jsEvent.pageY);

                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            $(".modulewrapper").css("cursor", "default");

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message);
                                        }
                                    });

                                },
                                hasRAG: true,
                                editable: false,
                                events: eventdata
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#SCHDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

    function filterByTitle(title) {
        $("#SCHDwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            /*remove previous calendar data*/

            $("#calendar").empty();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat('filterManagementReviewScheduleByTitle'),
                success: function (data) {
                    var data = $.parseJSON(data.d);

                    $("#SCHDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var eventdata = new Array();


                        $(data).each(function (index, value) {
                            var event =
                            {
                                id: value.id,
                                title: value.title,
                                start: new Date(parseInt(value.start.substr(6))),
                                modulename: value.modulename
                            };
                            eventdata.push(event);
                        });

                        $('#calendar').fullCalendar(
                        {
                            header:
                            {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month'
                            },
                            eventClick: function (calEvent, jsEvent, view) {
                                $(".modulewrapper").css("cursor", "wait");

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{'reviewID':'" + calEvent.id + "'}",
                                    url: getServiceURL().concat("getManagementReview"),
                                    success: function (data) {
                                        if (data) {
                                            $(".modulewrapper").css("cursor", "default");

                                            $("#review_id").val(calEvent.id);

                                            var xmlReview = $.parseXML(data.d);
                                            var review = $(xmlReview).find('Review');

                                            $("#<%=REVNOTxt.ClientID%>").val(review.attr('ReviewNo'));
                                            $("#<%=EVNTTxt.ClientID%>").val(review.attr('ReviewName'));

                                            showReviewOption(jsEvent.pageX, jsEvent.pageY);

                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        $(".modulewrapper").css("cursor", "default");

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        showErrorNotification(r.Message);
                                    }
                                });

                            },
                            hasRAG: true,
                            editable: false,
                            events: eventdata
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#SCHDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

        function filterByMode(mode)
        {
            $("#SCHDwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                /*remove previous calendar data*/

                $("#calendar").empty();

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'mode':'" + mode + "'}",
                    url: getServiceURL().concat('filterManagementReviewScheduleByMode'),
                    success: function (data)
                    {
                        var data = $.parseJSON(data.d);

                        $("#SCHDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var eventdata = new Array();


                            $(data).each(function (index, value) {
                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(parseInt(value.start.substr(6))),
                                    modulename: value.modulename
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header:
                                {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                                eventClick: function (calEvent, jsEvent, view) {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{'reviewID':'" + calEvent.id + "'}",
                                        url: getServiceURL().concat("getManagementReview"),
                                        success: function (data) {
                                            if (data) {
                                                $(".modulewrapper").css("cursor", "default");

                                                $("#review_id").val(calEvent.id);

                                                var xmlReview = $.parseXML(data.d);
                                                var review = $(xmlReview).find('Review');

                                                $("#<%=REVNOTxt.ClientID%>").val(review.attr('ReviewNo'));
                                                $("#<%=EVNTTxt.ClientID%>").val(review.attr('ReviewName'));

                                                showReviewOption(jsEvent.pageX, jsEvent.pageY);

                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            $(".modulewrapper").css("cursor", "default");

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message);
                                        }
                                    });

                                },
                                hasRAG: true,
                                editable: false,
                                events: eventdata
                            });
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#SCHDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

        function filterByCategory(category)
        {
            $("#SCHDwait").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                /*remove previous calendar data*/

                $("#calendar").empty();

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'category':'" + category + "'}",
                    url: getServiceURL().concat('filterManagementReviewScheduleByCategory'),
                    success: function (data) {

                        var data = $.parseJSON(data.d);

                        $("#SCHDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var eventdata = new Array();


                            $(data).each(function (index, value) {
                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(parseInt(value.start.substr(6))),
                                    modulename: value.modulename
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                                eventClick: function (calEvent, jsEvent, view) {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{'reviewID':'" + calEvent.id + "'}",
                                        url: getServiceURL().concat("getManagementReview"),
                                        success: function (data) {
                                            if (data) {
                                                $(".modulewrapper").css("cursor", "default");

                                                $("#review_id").val(calEvent.id);

                                                var xmlReview = $.parseXML(data.d);
                                                var review = $(xmlReview).find('Review');

                                                $("#<%=REVNOTxt.ClientID%>").val(review.attr('ReviewNo'));
                                                $("#<%=EVNTTxt.ClientID%>").val(review.attr('ReviewName'));

                                                showReviewOption(jsEvent.pageX, jsEvent.pageY);

                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            $(".modulewrapper").css("cursor", "default");

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message);
                                        }
                                    });

                                },
                                hasRAG: true,
                                editable: false,
                                events: eventdata
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#SCHDwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }


    function filterByPlannedReviewDate(start, end) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true) {

            $("#SCHDwait").stop(true).hide().fadeIn(500, function ()
            {

                $(".modulewrapper").css("cursor", "wait");

                /*remove previous calendar data*/

                $("#calendar").empty();

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
                    url: getServiceURL().concat('filterManagementReviewScheduleByDate'),
                    success: function (data) {

                        var data = $.parseJSON(data.d);

                        $("#SCHDwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var eventdata = new Array();


                            $(data).each(function (index, value) {
                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(parseInt(value.start.substr(6))),
                                    modulename: value.modulename
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                                eventClick: function (calEvent, jsEvent, view)
                                {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{'reviewID':'" + calEvent.id + "'}",
                                        url: getServiceURL().concat("getManagementReview"),
                                        success: function (data)
                                        {
                                            if (data)
                                            {
                                                $(".modulewrapper").css("cursor", "default");

                                                $("#review_id").val(calEvent.id);

                                                var xmlReview = $.parseXML(data.d);
                                                var review = $(xmlReview).find('Review');

                                                $("#<%=REVNOTxt.ClientID%>").val(review.attr('ReviewNo'));
                                                $("#<%=EVNTTxt.ClientID%>").val(review.attr('ReviewName'));

                                                showReviewOption(jsEvent.pageX, jsEvent.pageY);

                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            $(".modulewrapper").css("cursor", "default");

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message);
                                        }
                                    });

                                },
                                hasRAG: true,
                                editable: false,
                                events: eventdata
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#SCHDwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
    }

        function filterByStatus(status) {
            $("#SCHDwait").stop(true).hide().fadeIn(500, function ()
            {

                $(".modulewrapper").css("cursor", "wait");

                /*remove previous calendar data*/
                $("#calendar").empty();

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",
                    url: getServiceURL().concat('filterManagementReviewScheduleByStatus'),
                    success: function (data) {

                        var data = $.parseJSON(data.d);

                        $("#SCHDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var eventdata = new Array();


                            $(data).each(function (index, value) {
                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(parseInt(value.start.substr(6))),
                                    modulename: value.modulename
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                                eventClick: function (calEvent, jsEvent, view) {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{'reviewID':'" + calEvent.id + "'}",
                                        url: getServiceURL().concat("getManagementReview"),
                                        success: function (data) {
                                            if (data) {
                                                $(".modulewrapper").css("cursor", "default");

                                                $("#review_id").val(calEvent.id);

                                                var xmlReview = $.parseXML(data.d);
                                                var review = $(xmlReview).find('Review');

                                                $("#<%=REVNOTxt.ClientID%>").val(review.attr('ReviewNo'));
                                                $("#<%=EVNTTxt.ClientID%>").val(review.attr('ReviewName'));

                                                showReviewOption(jsEvent.pageX, jsEvent.pageY);

                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            $(".modulewrapper").css("cursor", "default");

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            showErrorNotification(r.Message);
                                        }
                                    });

                                },
                                hasRAG: true,
                                editable: false,
                                events: eventdata
                            });
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#SCHDwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

        function showReviewOption(x, y) {

            $("#ReviewOption").css({ left: x - 10, top: y + 20 });
            $("#ReviewOption").show();
        }
       
        function addRepresentative(representative)
        {
            //if (representativeExists($("#REPRCHK"), representative) == false) {

                var length = $("#REPRCHK").children('.checkitem').length;

                var html = '';
                html += "<div class='checkitem'>";
                html += "<input type='checkbox' id='Employee_" + length + "' name='checklist' value='" + 3 + "'/><div class='checkboxlabel'>" + representative + "</div>";
                html += "</div>";

                $("#REPRCHK").append(html);

                $("#Employee_" + length).prop('checked', true);

                $("#Employee_" + length).change(function () {
                    if ($(this).is(":checked") == false) {
                        //remove the employee from the list
                        $(this).parent().remove();
                    }
                });
            //}
            //else
            //{
            //    alert("The name of the representative already exists");
            //}
        }

        function representativeExists(control, representative) {
            var found = false;
            $(control).children().each(function (index, value) {
                if ($(this).find('.checkboxlabel').text() == representative) {
                    found = true;
                }
            });

            return found;
        }

        function loadRepresentatives(data) {
            var representatives = $.parseXML(data);
            $("#REPRCHK").empty();

            $(representatives).find('Employee').each(function (index, value) {

                var html = '';
                html += "<div class='checkitem'>";
                html += "<input type='checkbox' id='Employee_" + index + "' name='checklist' value='" + 1 + "'/><div class='checkboxlabel'>" + $(this).attr('NameFormat') + "</div>";
                html += "</div>";

                $("#REPRCHK").append(html);

                $("#Employee_" + index).prop('checked', true);

                $("#Employee_" + index).change(function () {
                    if ($(this).is(":checked") == false) {
                        $(this).val(4);
                        $(this).parent().hide();
                    }
                    else {
                        $(this).val(3);
                    }
                });
            });

        }
        
        function loadRecipients(data) {
            var recipients = $.parseXML(data);
            //alert(recipients);
            $('#ToCHK').empty();

            $(recipients).find('Employee').each(function (index, value) {
  
                var sb = new StringBuilder('');

                sb.append("<div id='" + $('#ToCHK').attr('id') + "_" + $(this).attr('NameFormat').substring($(this).attr('NameFormat').lastIndexOf(' ') + 1, $(this).attr('NameFormat').length - 1) + "' class='infodiv'>");
                sb.append("<div class='infotext'>" + $(this).attr('NameFormat') + "</div>");
                sb.append("<div id='delete_" + $('#ToCHK').attr('id') + "_" + $(this).attr('NameFormat').substring($(this).attr('NameFormat').lastIndexOf(' ') + 1, $(this).attr('NameFormat').length - 1) + "' class='infodelete'></div>");
                sb.append("</div>");

                $('#ToCHK').append(sb.toString());

                $("#delete_" + $('#ToCHK').attr('id') + "_" + $(this).attr('NameFormat').substring($(this).attr('NameFormat').lastIndexOf(' ') + 1, $(this).attr('NameFormat').length - 1)).bind('click', function () {
                    $(this).parent().remove();
                });

            });

        }

        function bindUnits(data) {
            var units = $.parseXML(data);

            $(units).find('ORGUnit').each(function (j, unit) {
                $("#table").table('addRow',
                {
                    ORGID: $(unit).attr('ORGID'),
                    name: $(unit).attr('name'),
                    ORGLevel: $(unit).attr('ORGLevel') != null ? $(unit).attr('ORGLevel') : "",
                    Country: $(unit).attr('Country'),
                    Status: $(unit).attr('Status')
                });

            });
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
                success: function (data) {
                    $(".modulewrapper").css("cursor", "default");

                    var ORGUNTJSON = $.parseJSON(data.d);

                    $("#table").table('removeRowAt', 'ORGID', ORGUNTJSON.ORGID);
                },
                error: function (xhr, status, error) {
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
                success: function (data) {
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
                error: function (xhr, status, error) {
                    $(".modulewrapper").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }

        function unitExists(unit)
        {
            var unitjson = $("#table").table('getJSON');
            var found = false;

            $(unitjson).each(function (index, value)
            {
                if (value.name == unit)
                {
                    found = true;
                }
            });
          
            return found;
        }
        function bindReviewData(data)
        {
            var xmlReview = $.parseXML(data);

            var review = $(xmlReview).find('Review');

            if (review != null)
            {
                /*clear previous data*/
                resetGroup('.modalPanel');

                /*setup the organization unit table and its cells*/
                initializeUnits();

            
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTRECBox.ClientID%>", "#ORGUNT_LD");

                $("#<%=REVIDTxt.ClientID%>").val(review.attr('ReviewNo'));

                bindReviewCategory(review.attr('ReviewCategory'));

                $("#<%=REVNMTxt.ClientID%>").val(review.attr('ReviewName'));

                /*attach review name to limit plugin*/
                $('#<%=REVNMTxt.ClientID%>').limit({ id_result: 'MNMlimit', alertClass: 'alertremaining' });

                /*trigger the keyup event to get the actual number of characters*/
                $('#<%=REVNMTxt.ClientID%>').keyup();

                var plannedreviewdate = new Date(review.attr('PlannedReviewDate'));
                plannedreviewdate.setMinutes(plannedreviewdate.getMinutes() + plannedreviewdate.getTimezoneOffset());

                $("#<%=REVDTTxt.ClientID%>").val(plannedreviewdate.format("dd/MM/yyyy"));

                var actualreviewdate = new Date(review.find("ActualReviewDate").text());
                actualreviewdate.setMinutes(actualreviewdate.getMinutes() + actualreviewdate.getTimezoneOffset());

                $("#<%=ACTREVDTTxt.ClientID%>").val(review.find("ActualReviewDate").text() == '' ? '' : actualreviewdate.format("dd/MM/yyyy"));

                var actualclosedate = new Date(review.find("ActualCloseDate").text());
                actualclosedate.setMinutes(actualclosedate.getMinutes() + actualclosedate.getTimezoneOffset());

                $("#<%=ACTCLSDTTxt.ClientID%>").val(review.find("ActualCloseDate").text() == '' ? '' : actualclosedate.format("dd/MM/yyyy"));

                if (review.attr('Objectives') != '' && review.attr('Objectives') != null)
                {
                    if ($("#<%=OBJTxt.ClientID%>").hasClass("watermarktext"))
                    {
                        $("#<%=OBJTxt.ClientID%>").val('').removeClass("watermarktext");
                    }

                    $("#<%=OBJTxt.ClientID%>").val($("#<%=OBJTxt.ClientID%>").html(review.attr('Objectives')).text());
                }
                else
                {
                    addWaterMarkText('The objective of the managament review meeting', '#<%=OBJTxt.ClientID%>');
                }

             
                if (review.attr('Summary') != '' && review.attr('Summary') != null) {
                    if ($("#<%=SUMMTxt.ClientID%>").hasClass("watermarktext")) {
                        $("#<%=SUMMTxt.ClientID%>").val('').removeClass("watermarktext");
                    }

                    $("#<%=SUMMTxt.ClientID%>").val($("#<%=SUMMTxt.ClientID%>").html(review.attr('Summary')).text());
                }
                else {
                    addWaterMarkText('Add the summary of the management review meeting', '#<%=SUMMTxt.ClientID%>');
                }

             
                if (review.attr('Notes') != '' && review.attr('Notes') != null)
                {
                    if ($("#<%=NOTETxt.ClientID%>").hasClass("watermarktext")) {
                        $("#<%=NOTETxt.ClientID%>").val('').removeClass("watermarktext");
                    }

                    $("#<%=NOTETxt.ClientID%>").val($("#<%=NOTETxt.ClientID%>").html(review.attr('Notes')).text());
                }
                else
                {
                    addWaterMarkText('Additional details in the support of the management review record', '#<%=NOTETxt.ClientID%>');
                }


                bindComboboxAjax('loadReviewStatus', "#<%=REVSTSCBox.ClientID%>", review.attr('ReviewStatus'), "#REVSTS_LD");

            
                bindUnits(review.attr('XMLUnits'));


                loadRepresentatives(review.attr('XMLRepresentatives'));
               
                loadRecipients(review.attr('XMLReviewRecipients'));
                
                if (review.attr('ReviewStatus') == 'Completed' || review.attr('ReviewStatus') == 'Cancelled') {
                    $("#ReviewTooltip").find('p').text("Changes cannot take place since the management review status is " + review.attr('ReviewStatus'));

                    if ($("#ReviewTooltip").is(":hidden")) {
                        $("#ReviewTooltip").slideDown(800, 'easeOutBounce');
                    }

                    /*disable all modal controls*/
                    ActivateAll(false);
                }
                else {
                    $("#ReviewTooltip").hide();

                    /*enable all modal controls for editing*/
                    ActivateAll(true);
                }

                navigate('Details');

                $("#<%=alias.ClientID%>").trigger('click');
            }
        }
        function ActivateAll(isactive)
        {
            if (isactive == false)
            {
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
