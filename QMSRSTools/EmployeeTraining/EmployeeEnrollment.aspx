<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="EmployeeEnrollment.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.EmployeeEnrollment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="CourseEnrollment_Header" class="moduleheader">Manage Course Enrollment</div>
    
    <div class="toolbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />

        <img id="new" src="/Images/new_file.png" class="imgButton" title="Add New Participant" alt="" />  

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
                <asp:TextBox ID="CRSNMTxt" runat="server" CssClass="textbox" Width="300px"></asp:TextBox>
            </div>
        </div>
        
        <div id="CourseStatusContainer" class="filter">
            <div id="CourseStatusFLabel" class="filterlabel">Course Status:</div>
            <div id="CourseStatusFField" class="filterfield">
                <asp:DropDownList ID="CSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
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

    <div id="CourseTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>

    <div id="CRSENRLwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbarEnroll" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvEnrollers" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CourseNo" HeaderText="Course No." />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                <asp:BoundField DataField="Enroller" HeaderText="Participant's Name" />
                <asp:BoundField DataField="EnrollerLevel" HeaderText="Proficiency Level" />
                <asp:BoundField DataField="AttendanceStatus" HeaderText="Attendance Status" />
                <asp:BoundField DataField="Feedback" HeaderText="Has Provided Feedback" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:550px;">
        <div id="Enroller_Details" class="modalHeader">Participant Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="EmailReminderTooltip" class="tooltip" style="margin-top:10px;">
            <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p>You can remind the participant to provide his/her feedback by clicking here</p>
            <a id="Email" href="#" style="display:none;"></a> 
	    </div>
        
         <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div id="EnrollerTooltip" class="tooltip">
            <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>
        
        <input id="enroller" type="hidden" value="" />
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CourseParticipantLabel" class="requiredlabel">Select Participant:</div>
            <div id="CourseParticipantField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="PRTCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>   
            </div>      
            <div id="Participant_LD" class="control-loader"></div>       
           
            <span id="PRTSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting a participant for the course"></span>
            
            <asp:RequiredFieldValidator ID="PRTCBoxTxtVal" runat="server" Display="None" ControlToValidate="PRTCBox" ErrorMessage="Select a participant for the course" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CompareValidator ID="PRTCBoxVal" runat="server" ControlToValidate="PRTCBox"
            Display="None" ErrorMessage="Select a participant for the course" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProficiencyLevelLabel" class="requiredlabel">Proficiency Level:</div>
            <div id="ProficiencyLevelField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="PROFLVLCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>   
            </div>      
            <div id="PROFLVL_LD" class="control-loader"></div>       
           
            <asp:RequiredFieldValidator ID="PROFLVLCBoxTxtVal" runat="server" Display="None" ControlToValidate="PROFLVLCBox" ErrorMessage="Select the level of proficiency of the participant" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CompareValidator ID="PROFLVLCBoxVal" runat="server" ControlToValidate="PROFLVLCBox"
            Display="None" ErrorMessage="Select the level of proficiency of the participant" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>
        
        <div id="DietaryInformationGroupHeader" class="groupboxheader" style=" margin-top:15px;">Dietary Information</div>
        <div id="DietaryInformationGroupField" class="groupbox" style="height:40px;">
             <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="VegetarianLabel" class="labeldiv">Vegetarian:</div>
                <div id="VegetarianField" class="fielddiv" style="width:50px">
                    <input type="checkbox" id="VEGECHK" class="checkbox" />
                </div>

                <div id="VeganLabel" class="labeldiv">Vegan:</div>
                <div id="VeganField" class="fielddiv" style="width:50px">
                    <input type="checkbox" id="VEGCHK" class="checkbox" />
                </div>
             </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OtherNeedLabel" class="labeldiv">Other Needs?:</div>
            <div id="OtherNeedField" class="fielddiv" style="width:250px">
                <input type="checkbox" id="OTHRNDCHK" class="checkbox" />
            </div>
        </div>

        <div id="OtherNeedGRP" class="groupbox" style="height:110px; display:none;">
             <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="OTHRRemarksLabel" class="labeldiv">Please Specify:</div>
                <div id="OTHRRemarksField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="OTHRRMRKTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <asp:CustomValidator id="OTHRRMRKTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "OTHRRMRKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
             </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="SpecialNeedLabel" class="labeldiv">Special Needs?:</div>
            <div id="SpecialNeedField" class="fielddiv" style="width:250px">
                <input type="checkbox" id="SPCNDSCHK" class="checkbox" />
            </div>
        </div>

         <div id="SpecialNeedGRP" class="groupbox" style="height:110px; display:none;">
             <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="SPCRemarksLabel" class="labeldiv">Please Specify:</div>
                <div id="SPCRemarksField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="SPCRMRKTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="SPCRMRKTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "SPCRMRKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
             </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AttendanceStatusLabel" class="requiredlabel">Attendance Status:</div>
            <div id="AttendanceStatusField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="ATTSTSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>   
            </div>      
            <div id="ATTSTS_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="ATTSTSCBoxTxtVal" runat="server" Display="None" ControlToValidate="ATTSTSCBox" ErrorMessage="Select attendance status" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CompareValidator ID="ATTSTSCBoxVal" runat="server" ControlToValidate="ATTSTSCBox"
            Display="None" ErrorMessage="Select attendance status" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
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

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>
    <input id="MODE" type="hidden" value="" />
    <input id="CourseJSON" type="hidden" value="" />

</div>
<script type="text/javascript" language="javascript">
        $(function ()
        {
            var empty = $("#<%=gvCourses.ClientID%> tr:last-child").clone(true);

            var enrollerempty = $("#<%=gvEnrollers.ClientID%> tr:last-child").clone(true);

            $("#<%=CRSSelect.ClientID%>").bind('click', function (e) {
                hideAll();

                showCourseDialog(e.pageX, e.pageY, empty);
            });

            $("#refreshcourses").bind('click', function () {
                hideAll();
                loadCourses(empty);
            });

            $("#byTitle").bind('click', function () {
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
                loadComboboxAjax('loadCourseStatus', '#<%=CSTSFCBox.ClientID%>',"#CRSSTS_LD");

                $("#CourseStatusContainer").show();
            });

            $("#bySTRTDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#StartDateFilterContainer").show();
            });


            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#RecordModeContainer").show();

                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMOD_LD");
            });

            $("#<%=CRSSelect.ClientID%>").bind('click', function () {
                loadCourses(empty);

                $("#SearchCourse").show();
            });


            /*filter by course number*/
            $("#<%=CRSNUMTxt.ClientID%>").keyup(function ()
            {
                filterCoursesByNumber($(this).val(), empty);
            });


            $("#<%=CRSNMTxt.ClientID%>").keyup(function (event)
            {
                filterCoursesByTitle($(this).val(), empty);
            });

            $("#<%=RECMODCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0) {
                    filterCoursesByMode($(this).val(), empty);
                }
            });

            $('#<%=CSTSFCBox.ClientID%>').change(function ()
            {
                if ($(this).val() != 0) {
                    filterCoursesByStatus($(this).val(), empty);
                }
            });

            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByStartDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(),empty);
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

            $("#close").bind('click', function ()
            {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#refresh").bind('click', function ()
            {
                if ($("#CourseJSON").val() != '') {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());

                    refreshCourse(courseJSON.CourseNo, enrollerempty);
                }
                else
                {
                    alert("Please select a course");
                }
            });

            $("#closeBox").bind('click', function ()
            {
                $("#SearchCourse").hide('800');
            });

            $("#EmailReminderTooltip").bind('click',function ()
            {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'name':'" + $("#enroller").val() + "'}",
                    url: getServiceURL().concat("getEmployeeEmail"),
                    success: function (data)
                    {
                        if (data) 
                        {
                            if ($("#CourseJSON").val() != '')
                            {
                                var courseJSON = $.parseJSON($("#CourseJSON").val());

                                /*send feedback request email*/
                                window.open("mailto:" + data.d + "?subject=Feedback for course (" + courseJSON.Title + ")&body=Dear All, %0d%0a%0d%0aKindly provide us with your feedback about the course (" + courseJSON.Title + ")%0d%0a%0d%0aRegards,%0d%0a%0d%0aTraining Department Team.");
                            }
                        }
                    },
                    error: function (xhr, status, error)
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    }
                });
            });

            /*close organization unit box*/
            $("#closeORG").bind('click', function ()
            {
                $("#SelectORG").hide('800');
            });

            $("#<%=PRTSelect.ClientID%>").click(function (e)
            {
                showORGDialog(e.pageX, e.pageY);
            });

            $("#<%=SORGUNTCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    var unitparam = "'unit':'" + $(this).val() + "'";
                    var loadcontrols = new Array();
                    loadcontrols.push("#<%=PRTCBox.ClientID%>");

                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#Participant_LD");
                    
                    $("#SelectORG").hide('800');
                }
            });

            $("#new").bind('click', function ()
            {
                if ($("#CourseJSON").val() != '') {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());

                    if (courseJSON.Status == 'Completed' || courseJSON.Status == 'Cancelled')
                    {
                        alert("Cannot add a new participant to this course since it is " + courseJSON.Status);
                    }
                    else if (courseJSON.Mode == 'Archived')
                    {
                        alert("Cannot add a new participant to an archived course");
                    }
                    else
                    {
                        var capacity = parseInt(courseJSON.Capacity);
                        var current = calculateTotalParticipants();

                        /*if the current participants is less than the capacity of the course, then allow adding a new participant*/

                        if (current < capacity)
                        {
                            /*clear previous data*/
                            resetGroup('.modalPanel');

                            /*set modal mode to add*/
                            $("#MODE").val('ADD');

                            ActivateAll(true);

                            /*load attendance status*/
                            loadComboboxAjax('loadAttendanceStatus', '#<%=ATTSTSCBox.ClientID%>', "#ATTSTS_LD");

                            /*load proficiency level*/
                            loadComboboxAjax('loadProficiencyLevel', '#<%=PROFLVLCBox.ClientID%>', "#PROFLVL_LD");

                            $("#<%=alias.ClientID%>").trigger('click');
                        }
                        else
                        {
                            alert("Cannot add a new participant because the course is full");
                        }
                    }
                }
                else {
                    alert("Please select a course");
                }
            });

            /*save changes*/

            $("#save").bind('click', function () {
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
                            ActivateSave(false);

                            var courseJSON = $.parseJSON($("#CourseJSON").val());

                            if ($("#MODE").val() == 'ADD')
                            {
                                var enroller =
                                {
                                    Employee: $("#<%=PRTCBox.ClientID%>").val(),
                                    EnrollerLevel: $("#<%=PROFLVLCBox.ClientID%>").val(),
                                    IsVegetarian: $("#VEGECHK").is(':checked'),
                                    IsVegan: $("#VEGCHK").is(':checked'),
                                    OtherNeeds: $("#OTHRNDCHK").is(':checked'),
                                    SpecialNeeds: $("#SPCNDSCHK").is(':checked'),
                                    OtherNeedNotes: $("#<%=OTHRRMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=OTHRRMRKTxt.ClientID%>").val()),
                                    SpecialNeedNotes: $("#<%=SPCRMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=SPCRMRKTxt.ClientID%>").val()),
                                    AttendanceStatus: $("#<%=ATTSTSCBox.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(enroller) + "\','courseID':'" + courseJSON.ID + "'}",
                                    url: getServiceURL().concat('createNewEnroller'),
                                    success: function (data)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function ()
                                        {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            $("#refresh").trigger('click');

                                        });
                                    },
                                    error: function (xhr, status, error) {
                                        $("#SaveTooltip").fadeOut(500, function ()
                                        {
                                            ActivateSave(true);

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            alert(r.Message);
                                        });
                                    }
                                });
                            }
                            else if ($("#MODE").val() == "EDIT")
                            {
                                var enroller =
                                {
                                    Employee: $("#<%=PRTCBox.ClientID%>").val(),
                                    EnrollerLevel: $("#<%=PROFLVLCBox.ClientID%>").val(),
                                    IsVegetarian: $("#VEGECHK").is(':checked'),
                                    IsVegan: $("#VEGCHK").is(':checked'),
                                    OtherNeeds: $("#OTHRNDCHK").is(':checked'),
                                    SpecialNeeds: $("#SPCNDSCHK").is(':checked'),
                                    OtherNeedNotes: $("#OTHRNDCHK").is(':checked') ? ($("#<%=OTHRRMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=OTHRRMRKTxt.ClientID%>").val())) : '',
                                    SpecialNeedNotes: $("#SPCNDSCHK").is(':checked') ? ($("#<%=SPCRMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=SPCRMRKTxt.ClientID%>").val())) : '',
                                    AttendanceStatus: $("#<%=ATTSTSCBox.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(enroller) + "\','oldemployee':'" +  $("#enroller").val() + "','courseID':'" + courseJSON.ID + "'}",
                                    url: getServiceURL().concat('updateEnroller'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function ()
                                        {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            $("#refresh").trigger('click');

                                        });
                                    },
                                    error: function (xhr, status, error) {
                                        $("#SaveTooltip").fadeOut(500, function ()
                                        {
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
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
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

                        $("#CRSENRLwait").stop(true).hide().fadeIn(500, function ()
                        {
                            if (!$("#SearchCourse").is(":hidden"))
                            {
                                $("#SearchCourse").hide();
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{'courseno':'" + text + "'}",
                                url: getServiceURL().concat('getCourseByNumber'),
                                success: function (data)
                                {
                                    var xmlCourse = $.parseXML(data.d);

                                    $("#CRSID_LD").fadeOut(500, function ()
                                    {
                                        $("#CRSENRLwait").fadeOut(500, function ()
                                        {
                                            $(".modulewrapper").css("cursor", "default");

                                            var course = $(xmlCourse).find('Course');

                                            $("#CourseQuestionTooltip").stop(true).hide().fadeIn(800, function () {
                                                $(this).find('p').text("List of all participants enrolled to the course (" + course.attr('CourseTitle') + ")");
                                            });

                                            /* create temporary JSON course for future reference*/
                                            var courseJSON =
                                            {
                                                ID: course.attr('CourseID'),
                                                CourseNo: course.attr('CourseNo'),
                                                Title: course.attr('CourseTitle'),
                                                Capacity: course.attr('Capacity'),
                                                Status: course.attr('CourseStatus'),
                                                Mode: course.attr('ModeString')
                                            }


                                            /*serialize and temprary store json data*/
                                            $("#CourseJSON").val(JSON.stringify(courseJSON));

                                            loadEnrollers(data.d, enrollerempty);
                                        });
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#CRSID_LD").fadeOut(500, function ()
                                    {
                                        $("#CRSENRLwait").fadeOut(500, function ()
                                        {

                                            $(".modulewrapper").css("cursor", "default");

                                            $("#CourseTooltip").fadeOut(800, function () {
                                            });

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            alert(r.Message);

                                            if ($("#CourseJSON").val() != '') {
                                                $("#CourseJSON").val('');
                                            }

                                            /*empty the enroller gridview*/
                                            $("#<%=gvEnrollers.ClientID%> tr").not($("#<%=gvEnrollers.ClientID%> tr:first-child")).remove();

                                        });
                                    });
                                }
                            });
                        });
                    });
                }
               
            });

            $("#OTHRNDCHK").change(function ()
            {
                if ($(this).is(":checked"))
                {
                    $("#OtherNeedGRP").stop(true).hide().fadeIn(500, function ()
                    {
                        $(this).find('.textbox').each(function ()
                        {
                            if (!$(this).hasClass("watermarktext"))
                            {   
                                addWaterMarkText('Add any other needs for the participant', '#<%=OTHRRMRKTxt.ClientID%>');
                            }
                        });
                    });
                }
                else
                {
                    $("#OtherNeedGRP").fadeOut(500, function ()
                    {
                    });
                }
            });

            $("#SPCNDSCHK").change(function ()
            {
                if ($(this).is(":checked"))
                {
     
                    $("#SpecialNeedGRP").stop(true).hide().fadeIn(500, function ()
                    {
                        $(this).find('.textbox').each(function ()
                        {
                            if (!$(this).hasClass("watermarktext"))
                            {
                                addWaterMarkText('Add any special needs for the participant', '#<%=SPCRMRKTxt.ClientID%>');
                            }
                        });
                    });
                }
                else
                {
                    $("#SpecialNeedGRP").fadeOut(500, function ()
                    {
                    });
                }

        
            });
        });

        function refreshCourse(courseno, empty)
        {
            $("#CRSENRLwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'courseno':'" + courseno + "'}",
                    url: getServiceURL().concat('getCourseByNumber'),
                    success: function (data)
                    {
                        var xmlCourse = $.parseXML(data.d);

                        $("#CRSENRLwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var course = $(xmlCourse).find('Course');

                            $("#CourseTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all participants enrolled to the course (" + course.attr('CourseTitle') + ")");
                            });

                            /* create temporary JSON course for future reference*/
                            var courseJSON =
                            {
                                ID: course.attr('CourseID'),
                                CourseNo: course.attr('CourseNo'),
                                Capacity: course.attr('Capacity'),
                                Status: course.attr('CourseStatus'),
                                Mode: course.attr('ModeString')
                            }


                            /*serialize and temprary store json data*/
                            $("#CourseJSON").val(JSON.stringify(courseJSON));

                            loadEnrollers(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#CRSENRLwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").fadeOut(800, function () {
                            });

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);

                            if ($("#CourseJSON").val() != '') {
                                $("#CourseJSON").val('');
                            }

                            /*empty the enroller gridview*/
                            $("#<%=gvEnrollers.ClientID%> tr").not($("#<%=gvEnrollers.ClientID%> tr:first-child")).remove();

                        });
                    }
                });
            });
        }
        function showORGDialog(x, y)
        {
            $("#SelectORG").css({ left: x - 300, top: y - 60 });
            loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>","#SORGUNT_LD");
            $("#SelectORG").show();
        }

        function loadEnrollers(course,empty)
        {
            var xmlCourse = $.parseXML(course);
            var course = $(xmlCourse).find("Course");
         
            var row = empty;
            $("#<%=gvEnrollers.ClientID%> tr").not($("#<%=gvEnrollers.ClientID%> tr:first-child")).remove();

            
            var xmlEnrollers = $.parseXML(course.attr('XMLEnroller'));
            $(xmlEnrollers).find('Enroller').each(function (index, enroller)
            {
                $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");

                $("td", row).eq(2).html(course.attr("CourseNo"));
                $("td", row).eq(3).html(course.attr("CourseTitle"));
                $("td", row).eq(4).html(new Date(course.attr("StartDate")).format("dd/MM/yyyy"));
                $("td", row).eq(5).html($(this).attr("Enroller"));
                $("td", row).eq(6).html($(this).attr("EnrollerLevel"));
                $("td", row).eq(7).html($(this).attr("AttendanceStatus"));
                $("td", row).eq(8).html($(this).attr("HasProvidedFeedback") == 'true' ? 'Yes' : 'No');

                $("#<%=gvEnrollers.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('delete') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            removeEnroller($(enroller).attr("Enroller"), course.attr("CourseNo"));
                        });
                    }
                    else if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                        
                            resetGroup(".modalPanel");

                            /* if the participant has attended the course but didn't provide his feedback then show reminder tooltip*/                           
                            if ($(enroller).attr("HasProvidedFeedback") == 'false' && $(enroller).attr("AttendanceStatus") == 'Attended')
                            {
                                if ($("#EmailReminderTooltip").is(":hidden"))
                                {
                                    $("#EmailReminderTooltip").slideDown(800, 'easeOutBounce');
                                }
                            }
                            else
                            {
                                $("#EmailReminderTooltip").hide();
                            }

                            /*store the participant's name */
                            $("#enroller").val($(enroller).attr("Enroller"));

                            /*bind participant's name */
                            bindComboboxAjax('loadEmployees', '#<%=PRTCBox.ClientID%>', $(enroller).attr("Enroller"), "#Participant_LD");

                            /*bind proficiency level */
                            bindComboboxAjax('loadProficiencyLevel', '#<%=PROFLVLCBox.ClientID%>', $(enroller).attr("EnrollerLevel"), "#PROFLVL_LD");

                            /*bind attendance status */
                            bindComboboxAjax('loadAttendanceStatus', '#<%=ATTSTSCBox.ClientID%>', $(enroller).attr("AttendanceStatus"),"#ATTSTS_LD");


                            if ($(enroller).attr("IsVegan") == 'true')
                            {
                                $("#VEGCHK").prop('checked', true);
                            }
                            else
                            {
                                $("#VEGCHK").prop('checked', false);
                            }

                            if ($(enroller).attr("IsVegetarian") == 'true')
                            {
                                $("#VEGECHK").prop('checked', true);
                            }
                            else
                            {
                                $("#VEGECHK").prop('checked', false);
                            }

                            if ($(enroller).attr("OtherNeeds") == 'true')
                            {
                                $("#OTHRNDCHK").prop('checked', true);

                                $("#OtherNeedGRP").stop(true).hide().fadeIn(500, function () {

                                    /*bind other needs remarks value*/
                                    if ($(enroller).attr("OtherNeedNotes") == '')
                                    {
                                        addWaterMarkText('Add any other needs for the participant', '#<%=OTHRRMRKTxt.ClientID%>');
                                    }
                                    else
                                    {
                                        if ($("#<%=OTHRRMRKTxt.ClientID%>").hasClass("watermarktext")) {
                                            $("#<%=OTHRRMRKTxt.ClientID%>").val('').removeClass("watermarktext");
                                        }

                                        $("#<%=OTHRRMRKTxt.ClientID%>").val($("#<%=OTHRRMRKTxt.ClientID%>").html($(enroller).attr("OtherNeedNotes")).text());
                                    }
                                });
                              
                            }
                            else
                            {
                                $("#OTHRNDCHK").prop('checked', false);

                                $("#OtherNeedGRP").fadeOut();
                            }

                            if ($(enroller).attr("SpecialNeeds") == 'true')
                            {
                                $("#SPCNDSCHK").prop('checked', true);

                                $("#SpecialNeedGRP").stop(true).hide().fadeIn(500, function () {

                                    /*bind special needs remarks value*/
                                    if ($(enroller).attr("SpecialNeedNotes") == '') {
                                        addWaterMarkText('Add any special needs for the participant', '#<%=SPCRMRKTxt.ClientID%>');
                                    }
                                    else {
                                        if ($("#<%=SPCRMRKTxt.ClientID%>").hasClass("watermarktext")) {
                                            $("#<%=SPCRMRKTxt.ClientID%>").val('').removeClass("watermarktext");
                                        }

                                        $("#<%=SPCRMRKTxt.ClientID%>").val($("#<%=SPCRMRKTxt.ClientID%>").html($(enroller).attr("SpecialNeedNotes")).text());
                                    }
                                });
                            }
                            else
                            {
                                $("#SPCNDSCHK").prop('checked', false);

                                $("#SpecialNeedGRP").fadeOut();
                            }

                            if (course.attr('CourseStatus') == 'Cancelled' || course.attr('CourseStatus') == 'Completed')
                            {

                                $("#EnrollerTooltip").find('p').text("Changes cannot take place since the course status is " + course.attr('CourseStatus'));

                                if ($("#EnrollerTooltip").is(":hidden")) {
                                    $("#EnrollerTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);

                            }
                            else if (course.attr('ModeString') == 'Archived')
                            {
                                $("#EnrollerTooltip").find('p').text("Changes cannot take place since the course is archived");

                                if ($("#EnrollerTooltip").is(":hidden")) {
                                    $("#EnrollerTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else
                            {
                                $("#EnrollerTooltip").hide();

                                /*enable all modal controls for editing*/
                                ActivateAll(true);
                            }
                            /*set modal mode to edit*/
                            $("#MODE").val('EDIT');

                            /*trigger modal popup extender*/
                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                });

                row = $("#<%=gvEnrollers.ClientID%> tr:last-child").clone(true);

            });
        }
        function removeEnroller(employee, courseno)
        {
            var result = confirm("Are you sure you would like to remove the participant?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'employee':'" + employee + "','courseNo':'" + courseno + "'}",
                    url: getServiceURL().concat("removeEnroller"),
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

        function calculateTotalParticipants() {
            return $("#<%=gvEnrollers.ClientID%> tr").not($("#<%=gvEnrollers.ClientID%> tr:first-child")).length;
        }



    function filterByStartDateRange(start, end, empty)
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
                    url: getServiceURL().concat("filterCourseByStartDate"),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadCourseGridView(data.d, empty);
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
                            loadCourseGridView(data.d, empty);
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
                            loadCourseGridView(data.d, empty);
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
                            loadCourseGridView(data.d, empty);
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
                            loadCourseGridView(data.d, empty);
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

    function filterCoursesByNumber(courseno, empty) {
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
                            loadCourseGridView(data.d, empty);
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

        function loadCourseGridView(data, empty) {
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
                $("td", row).eq(4).html($(this).attr("Duration") + ' ' + $(this).attr("Period"));
                $("td", row).eq(5).html($(this).attr("Capacity"));
                $("td", row).eq(6).html($(this).attr("Coordinator"));
                $("td", row).eq(7).html($(this).attr("CourseStatus"));
                $("td", row).eq(8).html($(this).attr("ModeString"));

                $("#<%=gvCourses.ClientID%>").append(row);
                row = $("#<%=gvCourses.ClientID%> tr:last-child").clone(true);
            });


            $("#<%=gvCourses.ClientID%> tr").not($("#<%=gvCourses.ClientID%> tr:first-child")).bind('click', function ()
            {

                $("#SearchCourse").hide('800');

                $("#<%=CourseIDTxt.ClientID%>").val($("td", $(this)).eq(0).html());

                var e = jQuery.Event("keydown");
                e.which = 13; // # Some key code value
                $("#<%=CourseIDTxt.ClientID%>").trigger(e);

            });
        }
        function ActivateAll(isactive)
        {
            if (isactive == false)
            {
                $(".modalPanel").children().each(function () {
                    $(this).find('.textbox').each(function ()
                    {
                        $(this).removeClass("textbox");
                        $(this).addClass("readonlycontrolled");
                        $(this).attr('readonly', true);
                    });

                    $(this).find('.searchactive').each(function ()
                    {
                        $(this).attr('disabled', true);
                    });

                    $(this).find('.combobox').each(function ()
                    {
                        $(this).attr('disabled', true);
                    });

                    $(this).find('.groupbox').each(function ()
                    {
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

        function showCourseDialog(x, y, empty) {
            loadCourses(empty);

            $("#SearchCourse").css({ left: x - 280, top: y + 10 });
            $("#SearchCourse").css({ width: 700, height: 250 });
            $("#SearchCourse").show();
        }

        function hideAll() {
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
        }
    </script>
</asp:Content>
