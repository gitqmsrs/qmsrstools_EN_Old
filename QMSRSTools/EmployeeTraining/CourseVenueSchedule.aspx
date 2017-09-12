
<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CourseVenueSchedule.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.CourseVenueSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="CourseVenueSchedule_Header" class="moduleheader">Manage Course Schedule</div>
   
    <div class="toolbox">
        <img id="refreshschedule" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="new" src="/Images/new_file.png" class="imgButton" title="Add New Course Session" alt="" />  

        <div id="CourseIDContainer" style=" float:left;width:500px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="CourseIDFLabel" style="width:100px;">Course ID:</div>
            <div id="CourseIDFField" style="width:250px; left:0; float:left;">
                <asp:TextBox ID="CourseIDTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
            </div>
            <div id="CRSID_LD" class="control-loader"></div>
                    
            <span id="CRSSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting a course"></span>
        </div>

    </div>

    <div id="SearchCourse" class="selectbox">

        <div class="toolbox">
            <img id="refreshcourses" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
            
            <div id="filter_div">
                <img id="filter" src="/Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byNumber">Filter by Course Number</li>
                    <li id="byTitle">Filter by Course Title</li>
                    <li id="byStatus">Filter by Course Status</li>
                    <li id="bySTRTDT">Filter by Course Start Date</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>
            
            <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
        </div>

         <div id="CourseNumberContainer" class="filter">
            <div id="CourseNumberLabel" class="filterlabel">Course No:</div>
            <div id="CourseNumberField" class="filterfield">
                <asp:TextBox ID="CRSNUMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>      
            </div>
        </div>
        
        <div id="CourseTitleContainer" class="filter">
            <div id="CourseTitleLabel" class="filterlabel">Course Title:</div>
            <div id="CourseTitleField" class="filterfield">
                <asp:TextBox ID="CRSNMTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
            </div>
        </div>
        
        <div id="CourseStatusContainer" class="filter">
            <div id="CourseStatusFLabel" class="filterlabel">Course Status:</div>
            <div id="CourseStatusFField" class="filterfield">
                <asp:DropDownList ID="CSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="CRSSTS_LD" class="control-loader"></div>
        </div>

        <div id="StartDateFilterContainer" class="filter">
            <div id="StartDateFLabel" class="filterlabel">Start Date:</div>
            <div id="StartDateFField" class="filterfield">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>

        <div id="RecordModeContainer" class="filter">
            <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
            <div id="RecordModeField" class="filterfield">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RECMOD_LD" class="control-loader"></div>
        </div>
        
        <div id="FLTR_LD" class="control-loader"></div> 

        <div id="scrollbar" class="gridscroll">
            <asp:GridView id="gvCourses" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:BoundField DataField="CourseNo" HeaderText="Course No." />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                    <asp:BoundField DataField="EndDate" HeaderText="End Date" />
                    <asp:BoundField DataField="Duration" HeaderText="Duration" />
                    <asp:BoundField DataField="Capacity" HeaderText="Capacity" />
                    <asp:BoundField DataField="Coordinator" HeaderText="Coordinator" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="Mode" HeaderText="Record Mode" />

                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="CRSVNUwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id='calendar'></div>
    
    <div id="VenueOption" class="optionbox" style="top:110px;">
        <div id="closeOption" class="optionclose"></div>
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="LocationLabel" class="labeldiv" style="width:100px;">Location:</div>
            <div id="LocationField" class="fielddiv" style="width:130px">
                <asp:TextBox ID="VNUTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="120px"></asp:TextBox>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="TimeLabel" class="labeldiv" style="width:100px;">Time:</div>
            <div id="TimeField" class="fielddiv" style="width:130px">
                <asp:TextBox ID="SCHTMTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="120px"></asp:TextBox>
            </div>
        </div>

        <div class="buttondiv">
            <img id='delete_venue' src='/Images/deletenode.png' class='imgButton' alt="Remove venue schedule" style='float:left;' title='Remove course' />
            <img id='edit_venue' src='/Images/edit.png' class='imgButton' alt="Edit venue schedule" style='float:left;' title='Edit course' />
        </div>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="CourseSessionHeader" class="modalHeader">Course Session Details<span id="Close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div class="tabcontent" style="height:500px; margin-top:10px; display:block;">

            <div id="validation_dialog_general">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>

            <input id="scheduleID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="SessionDateLabel" class="requiredlabel">Session Date:</div>
                <div id="SessiomDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="SESSIONDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>

                <asp:RequiredFieldValidator ID="SESSIONDTVal" runat="server" Display="None" ControlToValidate="SESSIONDTTxt" ErrorMessage="Enter the session date of the course" ValidationGroup="General"></asp:RequiredFieldValidator>
        
                <asp:RegularExpressionValidator ID="SESSIONDTFVal" runat="server" ControlToValidate="SESSIONDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        
                <asp:CustomValidator id="SESSIONDTF2Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "SESSIONDTTxt" Display="None" ErrorMessage = "Session start date should be among the duration of the course"
                ClientValidationFunction="compareCourseStartDate">
                </asp:CustomValidator>

                <asp:CustomValidator id="SESSIONDTF3Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "SESSIONDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>  
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="BeginningTimeLabel" class="requiredlabel">Beginning Time:</div>
                <div id="BeginningTimeField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="BTMTxt" runat="server" CssClass="time" Width="140px" placeholder="hh:mm"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="BTMTxtVal" runat="server" Display="None" ControlToValidate="BTMTxt" ErrorMessage="Enter the beginning time of the course session" ValidationGroup="General"></asp:RequiredFieldValidator>
        
                <asp:RegularExpressionValidator ID="BTMTxtFVal" runat="server" ControlToValidate="BTMTxt"
                Display="None" ErrorMessage="Time format should be hh:mm ranging from 01:00 to 23:59" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$" ValidationGroup="General"></asp:RegularExpressionValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="EndingTimeLabel" class="requiredlabel">Ending Time:</div>
                <div id="EndingTimeField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ENDTMTxt" runat="server" CssClass="time" Width="140px" placeholder="hh:mm"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="ENDTMVal" runat="server" Display="None" ControlToValidate="ENDTMTxt" ErrorMessage="Enter the ending time of the course session" ValidationGroup="General"></asp:RequiredFieldValidator>
        
                <asp:RegularExpressionValidator ID="ENDTMFVal" runat="server" ControlToValidate="ENDTMTxt"
                Display="None" ErrorMessage="Time format should be hh:mm ranging from 01:00 to 23:59" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$" ValidationGroup="General"></asp:RegularExpressionValidator> 

                <asp:CompareValidator ID="ENDTMF2Val" runat="server" ControlToCompare="BTMTxt" ControlToValidate="ENDTMTxt"
                ErrorMessage="Ending time should be greater than the beginning time of the session" Display="None" Operator="GreaterThan" ValidationGroup="General"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="InstructorTypeLabel" class="labeldiv">Instructor Type:</div>
                <div id="InstructorTypeField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="INSTRTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="CRSINSTR_LD" class="control-loader"></div>
            </div>
            
            <div id="Employee" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="EmployeeLabel" class="labeldiv">Select Employee:</div>
                <div id="EmployeeField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="EMPTxt" runat="server" CssClass="readonly" Width="240px"></asp:TextBox>
                </div>
                <span id="EMPSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting an employee"></span>
            </div>

             <div id="External" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="ExternalInstructorLabel" class="labeldiv">Select Instructor:</div>
                <div id="ExternalInstructorField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="INSTRTxt" runat="server" CssClass="readonly" Width="240px"></asp:TextBox>
                </div>
                <span id="INSTRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting external instructor"></span>
            </div>
            
            <div id="SelectORG" class="selectbox">
                <div id="closeORG" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="SelectOrganizationLebel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                    <div id="SelectOrganizationField" class="fielddiv" style="width:130px;">
                        <asp:DropDownList ID="SORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                        </asp:DropDownList> 
                    </div>
                    <div id="UNT_LD" class="control-loader"></div>
                </div>           
           
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="SelectEmployeeLabel" class="labeldiv" style="width:100px;">Select Employee:</div>
                    <div id="SelectEmployeeField" class="fielddiv" style="width:130px">
                        <asp:DropDownList ID="EMPCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="EMP_LD" class="control-loader"></div>
                </div>
            </div>

            <div id="SelectINSTR" class="selectbox">
                <div id="closeINSTR" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="SelectTypeLabel" class="labeldiv" style="width:100px;">Select Type:</div>
                    <div id="SelectTypeField" class="fielddiv" style="width:130px;">
                        <asp:DropDownList ID="TYPCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                        </asp:DropDownList> 
                    </div>
                    <div id="INSTRTYP_LD" class="control-loader"></div>
                </div>           
           
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="InstructorLabel" class="labeldiv" style="width:100px;">Select Instructor:</div>
                    <div id="InstructorField" class="fielddiv" style="width:130px">
                        <asp:DropDownList ID="INSTRCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="INSTR_LD" class="control-loader"></div>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="VenueLabel" class="requiredlabel">Select Venue:</div>
                <div id="VenueField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="LOCCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <span id="AddVenue" class="searchactive" style="margin-left:10px; background: url(/Images/add.png)" title="Add New Venue" /> 
    
                <div id="LOC_LD" class="control-loader"></div>
                
                <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="None" ControlToValidate="LOCCBox" ErrorMessage="Select the location of the course session" ValidationGroup="General"></asp:RequiredFieldValidator>   
                
                <asp:CompareValidator ID="OWNRCBoxVal" runat="server" ControlToValidate="LOCCBox"
                Display="None" ErrorMessage="Select the location of the course session" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
            </div>

            <div id="LocationGroupHeader" class="groupboxheader" style=" margin-top:15px;">Location Details</div>
            <div id="LocationGroupField" class="groupbox" style="height:260px; display:none;">
                
                <img id="SaveLOC" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" style="display:none;"/>
                
                <img id="SaveLOCWIMG" src="/Images/wait-loader.gif" alt="Save" height="25" width="25" style="display:none;" />
                
                <div id="validation_dialog_venue">
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Venue" />
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="VenueNameLabel" class="requiredlabel">Venue Name:</div>
                    <div id="VenueNameField" class="fielddiv" style="width:200px;">
                        <asp:TextBox ID="VNUNMTxt" runat="server" CssClass="textbox" Width="190px"></asp:TextBox>
                    </div>
                    <div id="VNMlimit" class="textremaining"></div>
                    
                    <asp:RequiredFieldValidator ID="VNUNMTxtVal" runat="server" Display="None" ControlToValidate="VNUNMTxt" ErrorMessage="Enter the name of the venue" ValidationGroup="Venue"></asp:RequiredFieldValidator>   
                    
                    <asp:CustomValidator id="VNUNMTxtF1Val" runat="server" ValidationGroup="Venue" 
                    ControlToValidate = "VNUNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:20px;">
                    <div id="AddressLine1Label" class="requiredlabel">Address Line 1:</div>
                    <div id="AddressLine1Field" class="fielddiv" style="width:400px;">
                        <asp:TextBox ID="ADD1Txt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                    </div>
                    <div id="ADD1limit" class="textremaining"></div>

                    <asp:RequiredFieldValidator ID="ADD1Val" runat="server" Display="None" ControlToValidate="ADD1Txt" ErrorMessage="Enter the primary address of the venue" ValidationGroup="Venue"></asp:RequiredFieldValidator>   
                    
                    <asp:CustomValidator id="ADD1TxtFVal" runat="server" ValidationGroup="Venue" 
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

                    <asp:CustomValidator id="ADD2TxtFVal" runat="server" ValidationGroup="Venue" 
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
                    <div id="CNTRY_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="COUNTTxtVal" runat="server" Display="None" ControlToValidate="COUNTCBox" ErrorMessage="Select the country of the address" ValidationGroup="Venue"></asp:RequiredFieldValidator>
         
                    <asp:CompareValidator ID="COUNTVal" runat="server" ControlToValidate="COUNTCBox"
                    Display="None" ErrorMessage="Select the country of the address" Operator="NotEqual" Style="position: static"
                    ValueToCompare="0" ValidationGroup="Venue"></asp:CompareValidator>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:20px;">
                    <div id="City" class="requiredlabel">City:</div>
                    <div id="CityField" class="fielddiv" style="width:150px;">
                        <asp:TextBox ID="CTYTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                    </div>
                    <div id="CTYlimit" class="textremaining"></div>

                    <asp:RequiredFieldValidator ID="CTYVal" runat="server" Display="None" ControlToValidate="CTYTxt" ErrorMessage="Enter the name of the city" ValidationGroup="Venue"></asp:RequiredFieldValidator>       
                    
                    <asp:CustomValidator id="CTYTxtFVal" runat="server" ValidationGroup="Venue" 
                    ControlToValidate = "CTYTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                    ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator>        
                </div>
            
                <div style="float:left; width:100%; height:20px; margin-top:20px;">
                    <div id="WebsiteLabel" class="labeldiv">Website URL:</div>
                    <div id="WebsiteField" class="fielddiv" style="width:400px;">
                        <asp:TextBox ID="WEBTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                    </div>

                    <asp:RegularExpressionValidator ID="WEBFVal" runat="server" ControlToValidate="WEBTxt"
                    Display="None" ErrorMessage="Invalid URL (e.g.(http://www.example.com) or (www.example.com))" ValidationExpression="^((http|https)://)?([A-Za-z0-9\-_]+\.)+[A-Za-z0-9_\-]+(/[A-Za-z0-9\-_ ./?%&=]*)?$" ValidationGroup="Venue"></asp:RegularExpressionValidator> 
                </div>

            </div>
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <input id="MODE" type="hidden" value="" />
    <input id="CourseJSON" type="hidden" value="" />
    <input id="schedule_id" type="hidden" value="" />

</div>
<script type="text/javascript" language="javascript">
        $(function () {

            var empty = $("#<%=gvCourses.ClientID%> tr:last-child").clone(true);

            $("#<%=BTMTxt.ClientID%>").timepicker({
                showPeriod: false,
                showLeadingZero: true,
                showPeriodLabels: false,
                onSelect: function (){ }
            });

            $("#<%=ENDTMTxt.ClientID%>").timepicker({
                showPeriod: false,
                showLeadingZero: true,
                showPeriodLabels: false,
                onSelect: function () { }
            });

            $("#refreshcourses").bind('click', function ()
            {
                hideAll();
                loadCourses(empty);
            });

            $("#byTitle").bind('click', function ()
            {
                hideAll();

                $("#<%=CRSNMTxt.ClientID%>").val('');

                $("#CourseTitleContainer").show();
            });

            $("#byNumber").bind('click', function () {
                hideAll();

                $("#<%=CRSNUMTxt.ClientID%>").val('');

                $("#CourseNumberContainer").show();
            });

            $("#byStatus").bind('click', function () {
                hideAll();

                /*load course status*/
                loadComboboxAjax('loadCourseStatus', '#<%=CSTSFCBox.ClientID%>', "#CRSSTS_LD");

                $("#CourseStatusContainer").show();
            });


            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#RecordModeContainer").show();

                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMOD_LD");
            });

            $("#bySTRTDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#StartDateFilterContainer").show();
            });

            $("#delete_venue").bind('click', function ()
            {
                $("#VenueOption").hide('800');

                var courseJSON = $.parseJSON($("#CourseJSON").val());

                if (courseJSON.Status == 'Completed' || courseJSON.Status == 'Cancelled') {
                    alert("Cannot remove the selected session since the course is " + courseJSON.Status);
                }
                else if (courseJSON.Mode == 'Archived') {
                    alert("Cannot remove the selected session since the related course was sent to archive");
                }
                else
                {
                    removeSchedule($("#schedule_id").val(), courseJSON.ID);
                }
            });

            $("#edit_venue").bind('click', function ()
            {
                var courseJSON = $.parseJSON($("#CourseJSON").val());

                if (courseJSON.Status == 'Completed' || courseJSON.Status == 'Cancelled') {
                    alert("Cannot modify the selected session since the course is " + courseJSON.Status);
                }
                else if (courseJSON.Mode == 'Archived') {
                    alert("Cannot modify the selected session since the related course was sent to archive");
                }
                else
                {
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'scheduleID':'" + $("#schedule_id").val() + "'}",
                        url: getServiceURL().concat("getSchedule"),
                        success: function (data) {
                            if (data) {
                                bindScheduleData(data.d);
                            }
                        },
                        error: function (xhr, status, error) {
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        }
                    });
                }
            });

            /*close course option box*/
            $("#closeOption").bind('click', function () {
                $("#VenueOption").hide('800');
            });


            $("#<%=CRSSelect.ClientID%>").bind('click', function (e) {
                hideAll();

                showCourseDialog(e.pageX, e.pageY, empty);
            });

            $("#<%=CRSNMTxt.ClientID%>").keyup(function (event)
            {
                filterCoursesByTitle($(this).val(), empty);
            });

            /*filter by course number*/
            $("#<%=CRSNUMTxt.ClientID%>").keyup(function () {
                filterCoursesByNumber($(this).val(), empty);
            });

            $("#<%=RECMODCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0) {
                    filterCoursesByMode($(this).val(), empty);
                }
            });

            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByStartDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByStartDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByStartDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
                }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByStartDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $('#<%=CSTSFCBox.ClientID%>').change(function ()
            {
                if ($(this).val() != 0) {
                    filterCoursesByStatus($(this).val(), empty);
                }
            });

            $("#<%=SESSIONDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#Close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#AddVenue").bind('click', function ()
            {
                resetGroup(".groupbox");

                var $group = $(".groupbox");

                $group.stop(true).hide().fadeIn(800, function ()
                {
                    $group.children().each(function ()
                    {
                        if ($("#SaveLOC").is(":hidden")) {
                            $("#SaveLOC").show();
                        }

                        /*load countries*/
                        loadComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>","#CNTRY_LD");

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

                    /*attach venue name to limit plugin*/
                    $("#<%=VNUNMTxt.ClientID%>").limit({ id_result: 'VNMlimit', alertClass: 'alertremaining', limit: 100 });

                    /*attach address line1 to limit plugin*/
                    $('#<%=ADD1Txt.ClientID%>').limit({ id_result: 'ADD1limit', alertClass: 'alertremaining' });

                    /*attach address line2 to limit plugin*/
                    $('#<%=ADD2Txt.ClientID%>').limit({ id_result: 'ADD2limit', alertClass: 'alertremaining' });

                    /*attach city to limit plugin*/
                    $('#<%=CTYTxt.ClientID%>').limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 100 });
                });
            });

            $("#new").bind('click', function ()
            {
                if ($("#CourseJSON").val()!='')
                {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());

                    if (courseJSON.Status == 'Completed' || courseJSON.Status == 'Cancelled')
                    {
                        alert("Cannot add a new session for the course since it is " + courseJSON.Status);
                    }
                    else if (courseJSON.Mode == 'Archived')
                    {
                        alert("Cannot add a new session for an archived course");
                    }
                    else
                    {
                        /* set modal mode to add*/
                        $("#MODE").val('ADD');

                        resetGroup(".modalPanel");

                        /*load instructor type*/
                        loadComboboxAjax('loadInstructorType', '#<%=INSTRTYPCBox.ClientID%>', "#CRSINSTR_LD");

                        loadLocations();

                        $("#<%=alias.ClientID%>").trigger('click');
                    }
                }
                else
                {
                    alert("Please select a course");
                }
            });

            $("#refreshschedule").bind('click', function ()
            {
                if ($("#CourseJSON").val() != '')
                {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());
                    loadTimeTable(courseJSON.ID);

                }
                else
                {
                    alert("Please select a course");
                }
            });

            $('#<%=INSTRTYPCBox.ClientID%>').change(function () {
                if ($(this).val() == 'Employee')
                {
                    $("#Employee").stop(true).hide().fadeIn(500, function ()
                    {
                        $("#<%=EMPTxt.ClientID%>").val('');
                    });

                    $("#External").fadeOut(500, function () { });
               
                }
                else if ($(this).val() == 'External')
                {
                    $("#Employee").fadeOut(500, function () { });

                    $("#External").stop(true).hide().fadeIn(500, function ()
                    {
                        $("#<%=INSTRTxt.ClientID%>").val('');
                    });
                }
                else
                {
                    $(".selectionfield").each(function () {
                        $(this).fadeOut(500, function () {
                        });
                    });
                }
            });

            $("#<%=EMPSelect.ClientID%>").click(function (e) {
                showORGDialog(e.pageX, e.pageY);
            });

            /*populate the employees in employee cbox*/
            $("#<%=SORGUNTCBox.ClientID%>").change(function () {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=EMPCBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EMP_LD");
            });

            $("#<%=EMPCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    $("#<%=EMPTxt.ClientID%>").val($("#<%=EMPCBox.ClientID%> option:selected").text());
                    $("#InternalInstructorID").val($(this).val());
                    $("#SelectORG").hide('800');
                }
            });

            /*close organization unit box*/
            $("#closeORG").bind('click', function () {
                $("#SelectORG").hide('800');
            });


            $("#<%=INSTRSelect.ClientID%>").click(function (e)
            {
                showINSTRDialog(e.pageX, e.pageY);
            });

            $("#<%=TYPCBox.ClientID%>").change(function () {
                //loadInstructors($(this).val());
                loadInstructors2($(this).val(), '#<%=INSTRCBox.ClientID%>', "#INSTR_LD");
            });

            $("#<%=INSTRCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    $("#<%=INSTRTxt.ClientID%>").val($("#<%=INSTRCBox.ClientID%> option:selected").text());
                    $("#ExternalInstructorID").val($(this).val());
                    $("#SelectINSTR").hide('800');
                }
            });

            /*close instructor box*/
            $("#closeINSTR").bind('click', function () {
                $("#SelectINSTR").hide('800');
            });

            $("#SaveLOC").bind('click', function ()
            {
                var isVenueValid = Page_ClientValidate('Venue');
                if (isVenueValid)
                {
                    
                    if (!$("#validation_dialog_venue").is(":hidden")) {
                        $("#validation_dialog_venue").hide();
                    }

                    $("#SaveLOCWIMG").stop(true).hide().fadeIn(500, function ()
                    {
                        $(".modalPanel").css("cursor", "wait");

                        var venue =
                        {
                            VenueName: $("#<%=VNUNMTxt.ClientID%>").val(),
                            AddressLine1: $("#<%=ADD1Txt.ClientID%>").val(),
                            AddressLine2: $("#<%=ADD2Txt.ClientID%>").val(),
                            Country: $("#<%=COUNTCBox.ClientID%>").val(),
                            City: $("#<%=CTYTxt.ClientID%>").val(),
                            Website: $("#<%=WEBTxt.ClientID%>").val()
                        }

                        $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(venue) + "\'}",
                                url: getServiceURL().concat('createSessionLocation'),
                                success: function (data) {
                                    $("#SaveLOCWIMG").fadeOut(500, function ()
                                    {
                                        $(".modalPanel").css("cursor", "default");

                                        $(".groupbox").fadeOut('slow', function ()
                                        {
                                            $("#SaveLOC").hide();

                                            loadLocations();
                                        });
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#SaveLOCWIMG").fadeOut(500, function ()
                                    {
                                        $(".modalPanel").css("cursor", "default");

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(r.Message);
                                    });
                                }
                            });
                    });
                }
                else
                {
                    $("#validation_dialog_venue").stop(true).hide().fadeIn(500, function () {
                        
                    });
                }
            });

            $("#save").bind('click', function ()
            {
                var isGeneralValid = Page_ClientValidate('General');
                if (isGeneralValid)
                {

                    if (!$("#validation_dialog_general").is(":hidden")) {
                        $("#validation_dialog_general").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            var sessionDateParts = getDatePart($("#<%=SESSIONDTTxt.ClientID%>").val());

                            var courseJSON = $.parseJSON($("#CourseJSON").val());

                            ActivateSave(false);

                            if ($("#MODE").val() == 'ADD') {
                                var venue = $("#<%=LOCCBox.ClientID%>").val().split(", ");
                                var schedule =
                                {
                                    StartTime: $("#<%=BTMTxt.ClientID%>").val(),
                                    EndTime: $("#<%=ENDTMTxt.ClientID%>").val(),
                                    SessionDate: new Date(sessionDateParts[2], (sessionDateParts[1] - 1), sessionDateParts[0]),
                                    IntructorType: ($("#<%=INSTRTYPCBox.ClientID%>").val() == 0 || $("#<%=INSTRTYPCBox.ClientID%>").val() == null ? '' : $("#<%=INSTRTYPCBox.ClientID%>").val()),
                                    ExternalIntructor: $("#<%=INSTRTxt.ClientID%>").val(),
                                    InternalIntructor: $("#<%=EMPTxt.ClientID%>").val(),
                                    Venue: venue[0]
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(schedule) + "\','courseID':'" + courseJSON.ID + "'}",
                                    url: getServiceURL().concat('createCourseSession'),
                                    success: function (data)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');

                                            loadTimeTable(courseJSON.ID);
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
                            else if ($("#MODE").val() == "EDIT") {
                                var venue = $("#<%=LOCCBox.ClientID%>").val().split(", ");
                                var schedule =
                                {
                                    ScheduleID: $("#scheduleID").val(),
                                    StartTime: $("#<%=BTMTxt.ClientID%>").val(),
                                    EndTime: $("#<%=ENDTMTxt.ClientID%>").val(),
                                    SessionDate: new Date(sessionDateParts[2], (sessionDateParts[1] - 1), sessionDateParts[0]),
                                    IntructorType: ($("#<%=INSTRTYPCBox.ClientID%>").val() == 0 || $("#<%=INSTRTYPCBox.ClientID%>").val() == null ? '' : $("#<%=INSTRTYPCBox.ClientID%>").val()),
                                    ExternalIntructor: $("#<%=INSTRTxt.ClientID%>").val(),
                                    InternalIntructor: $("#<%=EMPTxt.ClientID%>").val(),
                                    Venue: venue[0]
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(schedule) + "\'}",
                                    url: getServiceURL().concat('updateCourseSession'),
                                    success: function (data)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');

                                            loadTimeTable(courseJSON.ID);
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
                else
                {
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                        
                    });
                }
            });

            $("#<%=CourseIDTxt.ClientID%>").keydown(function (event)
            {
                var $obj = $(this);

                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13')
                {
                    var text = $(this).val();

                    $("#CRSID_LD").stop(true).hide().fadeIn(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "wait");

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'courseno':'" + text + "'}",
                            url: getServiceURL().concat('getCourseByNumber'),
                            success: function (data)
                            {
                                $("#CRSID_LD").fadeOut(500, function ()
                                {
                                    $(".modulewrapper").css("cursor", "default");

                                    var xmlCourse = $.parseXML(data.d);
                                    var course = $(xmlCourse).find("Course");

                                    /* create temporary JSON course for future reference*/
                                    var courseJSON =
                                    {
                                        ID: course.attr('CourseID'),
                                        StartDate: new Date(course.attr('StartDate')).format("dd/MM/yyyy"),
                                        EndDate: course.find("EndDate").text() == '' ? '' : new Date(course.find("EndDate").text()).format("dd/MM/yyyy"),
                                        Status: course.attr('CourseStatus'),
                                        Mode: course.attr('ModeString')
                                    }


                                    /*serialize and temprary store json data*/
                                    $("#CourseJSON").val(JSON.stringify(courseJSON));

                                    /*Load the time table of the course*/
                                    loadTimeTable(courseJSON.ID);

                                    if (!$("#SearchCourse").is(":hidden")) {
                                        $("#SearchCourse").hide('800');
                                    }
                                });
                            },
                            error: function (xhr, status, error) {
                                $("#CRSID_LD").fadeOut(500, function ()
                                {
                                    $(".modulewrapper").css("cursor", "default");

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);

                                    /*reset course ID field*/
                                    if ($("#CourseJSON").val() != '') {
                                        $("#CourseJSON").val('');
                                    }
                                    /*remove previous calendar data*/
                                    $("#calendar").empty();
                                });


                            }
                        });
                    });
                }
                    
            });

            $("#closeBox").bind('click', function () {
                $("#SearchCourse").hide('800');
            });

           
        });
        function compareCourseStartDate(sender, args)
        {
            var courseJSON = $.parseJSON($("#CourseJSON").val());

            var targetdatepart = getDatePart(args.Value);
            var startpart = getDatePart(courseJSON.StartDate);
            var endpart = getDatePart(courseJSON.EndDate);
            
            var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
            var startdate = new Date(startpart[2], (startpart[1] - 1), startpart[0]);
            var enddate = new Date(endpart[2], (endpart[1] - 1), endpart[0]);

            if (courseJSON.EndDate != '')
            {
                if (targetdate >= startdate && targetdate <= enddate)
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            else
            {
                
                if (targetdate >= startdate)
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
            
            return args.IsValid;
        }

        function removeSchedule(ID, courseid)
        {
            var result = confirm("Are you sure you would like to remove the current schedule?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'scheduleID':'" + ID + "'}",
                    url: getServiceURL().concat("removeCourseSession"),
                    success: function (data) {
                        $(".modulewrapper").css("cursor", "default");

                        loadTimeTable(courseid);
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

        function loadLocations() {
            $("#LOC_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadSessionLocation"),
                    success: function (data) {
                        $("#LOC_LD").fadeOut(500, function () {

                            if (data) {
                                var xml = $.parseXML(data.d);
                                loadComboboxXML(xml, 'CourseVenue', 'NameFormat', '#<%=LOCCBox.ClientID%>');
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#LOC_LD").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }

    function bindLocations(value)
    {
        $("#LOC_LD").stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadSessionLocation"),
                success: function (data)
                {
                    $("#LOC_LD").fadeOut(500, function () {

                        if (data) {
                            var xml = $.parseXML(data.d);
                            bindComboboxXML(xml, 'CourseVenue', 'NameFormat', value, '#<%=LOCCBox.ClientID%>');
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#LOC_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadInstructors(type) {
        $("#INSTR_LD").stop(true).hide().fadeIn(500, function () {
        
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("filterCustomerByType"),
                success: function (data) {
                    $("#INSTR_LD").fadeOut(500, function () {
        
                        if (data) {
                            var xml = $.parseXML(data.d);

                            loadComboboxXML(xml, 'Customer', 'CustomerName', '#<%=INSTRCBox.ClientID%>');
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#INSTR_LD").fadeOut(500, function () {
        
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadEmployees(unit, ID, loader) {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: getServiceURL().concat("loadCustomersByTypeId"),
                data: "{'typeId':'" + typeId + "'}",
                dataType: "json",
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        //clear all previously loaded data
                        $(ID).empty();

                        if (data.d.length > 0) {
                            var HTML = '<option value=0>اختر القيمة</option>';
                            var i = 0;
                            $.each(data.d, function (key, value) {
                                HTML += "<option value='" + data.d[i].CustomerID + "'>" + data.d[i].CustomerName + "</option>";
                                i++;
                            });
                            $(ID).append(HTML);
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
    function loadInstructors2(typeId, ID, loader) {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: getServiceURL().concat("loadCustomersByTypeId"),
                data: "{'typeId':'" + typeId + "'}",
                dataType: "json",
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        //clear all previously loaded data
                        $(ID).empty();

                        if (data.d.length > 0) {
                            var HTML = '<option value=0>اختر القيمة</option>';
                            var i = 0;
                            $.each(data.d, function (key, value) {
                                HTML += "<option value='" + data.d[i].CustomerID + "'>" + data.d[i].CustomerName + "</option>";
                                i++;
                            });
                            $(ID).append(HTML);
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
    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 300, top: y - 90 });
        $("#<%=EMPCBox.ClientID%>").empty();
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#UNT_LD");
        $("#SelectORG").show();
    }

    function showINSTRDialog(x, y) {
        $("#SelectINSTR").css({ left: x - 300, top: y - 90 });
        $("#<%=INSTRCBox.ClientID%>").empty();
        <%--loadComboboxAjax('loadCustomerType', "#<%=TYPCBox.ClientID%>", "#INSTRTYP_LD");--%>
        loadCustomerType('loadCustomerType2', "#<%=TYPCBox.ClientID%>", "#INSTRTYP_LD");
        $("#SelectINSTR").show();
    }
    function loadCustomerType(MethodName, ID, loader) {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: getServiceURL().concat(MethodName),
                //data: "{}",
                dataType: "json",
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        //clear all previously loaded data
                        $(ID).empty();

                        if (data.d.length > 0) {
                            var HTML = '<option value=0>اختر القيمة</option>';
                            var i = 0;
                            $.each(data.d, function (key, value) {
                                HTML += "<option value='" + data.d[i].CustomerTypeID + "'>" + data.d[i].CustomerType1 + "</option>";
                                i++;
                            });
                            $(ID).append(HTML);
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
    function loadTimeTable(courseid) {
        $("#CRSVNUwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            /*remove previous calendar data*/
            $("#calendar").empty();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'courseID':'" + courseid + "'}",
                url: getServiceURL().concat("loadTimeTable"),
                success: function (data)
                {
                    var data = $.parseJSON(data.d);

                    $("#CRSVNUwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var eventdata = new Array();

                            $(data).each(function (index, value)
                            {
                                var starttimepart = value.starttime.split(":");
                                var endtimepart = value.endtime.split(":");

                                /*parse the session date*/
                                var date = new Date(parseInt(value.start.substr(6)));
                                var d = date.getDate();
                                var m = date.getMonth();
                                var y = date.getFullYear();

                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(y, m, d, parseInt(starttimepart[0]), parseInt(starttimepart[1])),
                                    end: new Date(y, m, d, parseInt(endtimepart[0]), parseInt(endtimepart[1])),
                                    allDay: false
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'agendaWeek'
                                },
                                defaultView: 'agendaWeek',
                                editable: false,
                                events: eventdata,
                                eventClick: function (calEvent, jsEvent, view) {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json; charset=utf-8",
                                        dataType: "json",
                                        data: "{'scheduleID':'" + calEvent.id + "'}",
                                        url: getServiceURL().concat("getSchedule"),
                                        success: function (data) {
                                            $(".modulewrapper").css("cursor", "default");

                                            if (data) {
                                                var xmlSchedule = $.parseXML(data.d);
                                                var schedule = $(xmlSchedule).find('CourseSchedule');

                                                $("#<%=VNUTxt.ClientID%>").val(schedule.attr('Venue'));

                                                $("#<%=SCHTMTxt.ClientID%>").val(schedule.attr('StartTime') + " To " + schedule.attr('EndTime'));

                                                showVenueOption(jsEvent.pageX, jsEvent.pageY);

                                                /* temprarely store the id of the schedule for future reference*/
                                                $("#schedule_id").val(calEvent.id);
                                            }
                                        },
                                        error: function (xhr, status, error) {
                                            $(".modulewrapper").css("cursor", "default");

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            alert(r.Message);
                                        }
                                    });
                                }

                            });
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#CRSVNUwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function bindScheduleData(data)
    {
        var xmlSchedule = $.parseXML(data);

        var schedule = $(xmlSchedule).find('CourseSchedule');

        if (schedule != null)
        {
            resetGroup(".modalPanel");
            /*store the ID of the schedule*/
            $("#scheduleID").val(schedule.attr('ScheduleID'));

            $("#<%=SESSIONDTTxt.ClientID%>").val(new Date(schedule.attr('SessionDate')).format("dd/MM/yyyy"));

            $("#<%=BTMTxt.ClientID%>").val(schedule.attr('StartTime'));
            $("#<%=ENDTMTxt.ClientID%>").val(schedule.attr('EndTime'));

            bindComboboxAjax('loadInstructorType', "#<%=INSTRTYPCBox.ClientID%>", schedule.attr('IntructorType'), "#CRSINSTR_LD");


            if (schedule.attr('IntructorType') == 'Employee')
            {
                $("#Employee").stop(true).hide().fadeIn(500, function ()
                {
                    $("#<%=EMPTxt.ClientID%>").val(schedule.attr('InternalIntructor'));

                });

                $("#External").fadeOut(500, function () { });

            }
            else if (schedule.attr('IntructorType') == 'External')
            {
                $("#Employee").fadeOut(500, function () { });

                $("#External").stop(true).hide().fadeIn(500, function () {
                    $("#<%=INSTRTxt.ClientID%>").val(schedule.attr('ExternalIntructor'));
                });
            }
            else
            {
                $(".selectionfield").each(function () {
                    $(this).fadeOut(500, function () {
                    });
                });
            }

            bindLocations(schedule.attr('Venue'));


            /* set modal mode to edit*/
            $("#MODE").val('EDIT');

            $(".groupbox").hide();

            $("#VenueOption").hide('800');

            $("#<%=alias.ClientID%>").trigger('click');
        }
    }
    function loadCourses(empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCourses"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
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

    function filterByStartDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
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
                    url: getServiceURL().concat("filterCourseByStartDate"),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadGridView(data.d, empty);
                            }
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

    function filterCoursesByNumber(courseno, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'courseno':'" + courseno + "'}",
                url: getServiceURL().concat("filterCourseByNumber"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
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

    function filterCoursesByMode(mode, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat("filterCourseByMode"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
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
    function filterCoursesByStatus(status, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat("filterCourseByStatus"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
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
    function filterCoursesByTitle(title, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat("filterCourseByTitlePrefix"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
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
        var xmlCourses = $.parseXML(data);

        var row = empty;

        $("#<%=gvCourses.ClientID%> tr").not($("#<%=gvCourses.ClientID%> tr:first-child")).remove();

        $(xmlCourses).find("Course").each(function (index, value) {
            $("td", row).eq(0).html($(this).attr("CourseNo"));
            $("td", row).eq(1).html($(this).attr("CourseTitle"));

            var startdate = new Date($(this).attr("StartDate"));
            startdate.setMinutes(startdate.getMinutes() + startdate.getTimezoneOffset());

            $("td", row).eq(2).html(startdate.format("dd/MM/yyyy"));

            var enddate = new Date($(this).find("EndDate").text());
            enddate.setMinutes(enddate.getMinutes() + enddate.getTimezoneOffset());

            $("td", row).eq(3).html($(this).find("EndDate").text() == '' ? '' : enddate.format("dd/MM/yyyy"));
            $("td", row).eq(4).html($(this).attr("Duration") == 0 ? '' : $(this).attr("Duration") + ' ' + $(this).attr("Period"));
            $("td", row).eq(5).html($(this).attr("Capacity"));
            $("td", row).eq(6).html($(this).attr("Coordinator"));
            $("td", row).eq(7).html($(this).attr("CourseStatus"));
            $("td", row).eq(8).html($(this).attr("ModeString"));


            $("#<%=gvCourses.ClientID%>").append(row);
            row = $("#<%=gvCourses.ClientID%> tr:last-child").clone(true);
        });


        $("#<%=gvCourses.ClientID%> tr").not($("#<%=gvCourses.ClientID%> tr:first-child")).bind('click', function () {

            $("#SearchCourse").hide('800');

            $("#<%=CourseIDTxt.ClientID%>").val($("td", $(this)).eq(0).html());

            var e = jQuery.Event("keydown");
            e.which = 13; // # Some key code value
            $("#<%=CourseIDTxt.ClientID%>").trigger(e);

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

    function showCourseDialog(x, y, empty) {
        loadCourses(empty);

        $("#SearchCourse").css({ left: x - 280, top: y + 10 });
        $("#SearchCourse").css({ width: 700, height: 250 });
        $("#SearchCourse").show();
    }

    function showVenueOption(x, y) {
        $("#VenueOption").css({ left: x - 10, top: y + 20 });
        $("#VenueOption").show();
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
    </script>
</asp:Content>
