<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewCourse.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.ViewCourse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="ViewCourse_Header" class="moduleheader">View Courses</div>
    
    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
     
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byTitle">Filter by Course Title</li>
                <li id="byStatus">Filter by Course Status</li>
                <li id="byStartdate">Filter by Course Start Date</li>
                <li id="byATTSTS">Filter by Attendance Status</li>
            </ul>
        </div>
    </div>

    <div id="CourseTitleContainer" class="filter">
        <div id="CourseTitleFLabel" class="filterlabel">Course Title:</div>
        <div id="CourseTitleFField" class="filterfield">
            <asp:TextBox ID="CTTLTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
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

    <div id="AttendanceStatusContainer" class="filter">
        <div id="AttendanceStatusLabel" class="filterlabel">Attendance Status:</div>
        <div id="AttendanceStatusField" class="filterfield">
            <asp:DropDownList ID="ATTSTSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ATTSTS_LD" class="control-loader"></div>
    </div>

    <div id="StartdateContainer" class="filter">
        <div id="StartDateLabel" class="filterlabel">Start Date:</div>
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

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="EmployeeLabel" class="labeldiv">Employee Name:</div>
        <div id="EmployeeField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="EMPTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
        </div>
    </div>
    
    <div id="CourseTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>
    <div id="CRSwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>
    
    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvCourses" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
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
                <asp:BoundField DataField="CourseNo" HeaderText="Course No." />
                <asp:BoundField DataField="Title" HeaderText="Title" />
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                <asp:BoundField DataField="EndDate" HeaderText="End Date" />
                <asp:BoundField DataField="Duration" HeaderText="Duration" />
                <asp:BoundField DataField="Capacity" HeaderText="Capacity" />
                <asp:BoundField DataField="Coordinator" HeaderText="Coordinator" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="ATTStatus" HeaderText="Attendance Status" />
                <asp:BoundField DataField="Feedback" HeaderText="Has Provided Feedback" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="Feedback_Details" class="modalHeader">Feedback Details<span id="close" class="modalclose" title="Close">X</span></div>

        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="FeedbackTooltip" class="tooltip" style="margin-top:10px;">
            <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p>A) Strongly Disagree, B) Disagree, C) Undecided, D) Agree, E) Strongly Agree</p>
	    </div>

        <div id="schedule"></div>
        
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>
    
    <input id="courseID" type="hidden" value="" />

</div>
<script type="text/javascript" language="javascript">
        $(function () {
            var empty = $("#<%=gvCourses.ClientID%> tr:last-child").clone(true);

            var enroller = $("#<%=EMPTxt.ClientID%>").val().split(' ');

            loadCourses(empty, enroller);

            $("#refresh").bind('click', function () {
                hideAll();
                loadCourses(empty, enroller);
            });

            $("#deletefilter").bind('click', function () {
                hideAll();
                loadCourses(empty, enroller);
            });

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#byStartdate").bind('click', function () {
                hideAll();
                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#StartdateContainer").show();
            });

            $("#byStatus").bind('click', function () {
                hideAll();

                /*load course status*/
                loadComboboxAjax('loadCourseStatus', '#<%=CSTSFCBox.ClientID%>', "#CRSSTS_LD");

                $("#CourseStatusContainer").show();
            });

            $("#byTitle").bind('click', function () {
                hideAll();

                $("#<%=CTTLTxt.ClientID%>").val('');

                $("#CourseTitleContainer").show();
            });

            $("#byATTSTS").bind('click', function () {
                hideAll();

                /*load attendance status*/
                loadComboboxAjax('loadAttendanceStatus', '#<%=ATTSTSCBox.ClientID%>',"#ATTSTS_LD");

                $("#AttendanceStatusContainer").show();

            });

            $('#<%=ATTSTSCBox.ClientID%>').change(function () {
                if ($(this).val() != 0) {
                    filterByAttendanceStatus(empty, enroller, $(this).val())
                }
            });

            $('#<%=CSTSFCBox.ClientID%>').change(function () {
                if ($(this).val() != 0) {
                    filterByCourseStatus(empty, enroller, $(this).val());
                }
            });

            $("#<%=CTTLTxt.ClientID%>").keydown(function () {
                filterByCourseTitle(empty, enroller, $(this).val());
            });

            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByDateRange(empty, enroller, $(this).val(), $("#<%=TDTTxt.ClientID%>").val());
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByDateRange(empty, enroller, $("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByDateRange(empty, enroller, date, $("#<%=TDTTxt.ClientID%>").val());
                }
            });


            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByDateRange(empty, enroller, $("#<%=FDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $("#save").bind('click', function ()
            {
                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'firstname':'" + enroller[0] + "','lastname':'" + enroller[1] + "','courseID':'" + $("#courseID").val() + "',\'json\':\'" + JSON.stringify(getFeedbackJSON()) + "\'}",
                            url: getServiceURL().concat('addCourseFeedback'),
                            success: function (data) {
                                $("#SaveTooltip").fadeOut(500, function ()
                                {
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
            });
        });

        function getFeedbackJSON() {
            var feedbacklist = new Array();

            $("#schedule").children('.row').each(function () {
                var $row = $(this);
                $(this).find('input[type=radio]').each(function () {
                    if ($(this).is(':checked') == true) {
                        var feedback =
                        {
                            Question: $row.attr('id'),
                            AnswerValue: $(this).val()
                        }

                        feedbacklist.push(feedback);
                    }
                });
            });

            if (feedbacklist.length == 0)
                return null;

            return feedbacklist;
        }
        function filterByDateRange(empty, enroller, start, end) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true) {
                $("#CRSwait").stop(true).hide().fadeIn(500, function () {
                    $(".modulewrapper").css("cursor", "wait");

                    var dateparam =
                    {
                        StartDate: startdate,
                        EndDate: enddate
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json",
                        dataType: "json",
                        data: "{'firstname':'" + enroller[0] + "','lastname':'" + enroller[1] + "',\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                        url: getServiceURL().concat('filterCourseByEnrollerANDStartDate'),
                        success: function (data)
                        {
                            $("#CRSwait").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                $("#CourseTooltip").stop(true).hide().fadeIn(800, function ()
                                {
                                    $(this).find('p').text("List of all courses assciated to (" + enroller + ") filtered by their start date range");
                                });

                                loadGridView(data.d, empty);
                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#CRSwait").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                $("#CourseTooltip").fadeOut(800, function () {
                                });

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        }

        function filterByAttendanceStatus(empty, enroller, status) {
            $("#CRSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'firstname':'" + enroller[0] + "','lastname':'" + enroller[1] + "','attendance':'" + status + "'}",
                    url: getServiceURL().concat("filterCourseByEnrollerANDAttendanceStatus"),
                    success: function (data) {
                        $("#CRSwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all courses assciated to (" + enroller + ") filtered by employee's attendance status");
                            });

                            loadGridView(data.d, empty);

                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").fadeOut(800, function () {
                            });

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }

        function filterByCourseTitle(empty, enroller, title) {
            $("#CRSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'firstname':'" + enroller[0] + "','lastname':'" + enroller[1] + "','title':'" + title + "'}",
                    url: getServiceURL().concat("filterCourseByEnrollerANDTitle"),
                    success: function (data) {
                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").stop(true).hide().fadeIn(800, function ()
                            {
                                $(this).find('p').text("List of all courses assciated to (" + enroller + ") filtered by their title prefix");
                            });

                            loadGridView(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").fadeOut(800, function () {
                            });

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });

                    }
                });
            });
        }

        function filterByCourseStatus(empty, enroller, status) {
            $("#CRSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'firstname':'" + enroller[0] + "','lastname':'" + enroller[1] + "','status':'" + status + "'}",
                    url: getServiceURL().concat("filterCourseByEnrollerANDStatus"),
                    success: function (data)
                    {
                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all courses assciated to (" + enroller + ") filtered by their status");
                            });

                            loadGridView(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").fadeOut(800, function () {
                            });

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);

                        });
                    }
                });
            });
        }

        function loadCourses(empty, enroller) {
            $("#CRSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'firstname':'" + enroller[0] + "','lastname':'" + enroller[1] + "'}",
                    url: getServiceURL().concat("filterCourseByEnroller"),
                    success: function (data)
                    {
                        $("#CRSwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseTooltip").stop(true).hide().fadeIn(800, function ()
                            {
                                $(this).find('p').text("List of all courses assciated to (" + enroller + ")");
                            });

                            loadGridView(data.d, empty);

                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#CRSwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");
                            $("#CourseTooltip").fadeOut(800, function () {
                            });

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
                $("td", row).eq(0).html("<img id='schedule_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/schedule.jpg' class='imgButton' title='View course timetable' />");
                $("td", row).eq(1).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' title='Withdraw from this course' />");
                $("td", row).eq(2).html("<img id='feedback_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/feedback.jpg' class='imgButton' title='Add feedback for this course'/>");

                $("td", row).eq(3).html($(this).attr("CourseNo"));
                $("td", row).eq(4).html($(this).attr("CourseTitle"));
                $("td", row).eq(5).html(new Date($(this).attr("StartDate")).format("dd/MM/yyyy"));
                $("td", row).eq(6).html($(this).find("EndDate").text() == '' ? '' : new Date($(this).find("EndDate").text()).format("dd/MM/yyyy"));
                $("td", row).eq(7).html($(this).attr("Duration") + ' ' + $(this).attr("Period"));
                $("td", row).eq(8).html($(this).attr("Capacity"));
                $("td", row).eq(9).html($(this).attr("Coordinator"));
                $("td", row).eq(10).html($(this).attr("CourseStatus"));

                var enroller = $.parseXML($(value).attr('XMLEnroller'));

                $("td", row).eq(11).html($(enroller).find('Enroller').attr("AttendanceStatus"));
                $("td", row).eq(12).html($(enroller).find('Enroller').attr("HasProvidedFeedback") == 'true' ? 'Yes' : 'No');

                $("#<%=gvCourses.ClientID%>").append(row);

                $(row).find('img').each(function () {
                    if ($(this).attr('id').search('feedback') != -1) {
                        $(this).bind('click', function () {
                            if ($(enroller).find('Enroller').attr("HasProvidedFeedback") == 'true') {
                                alert("You have already applied your feedback for this course");
                            }
                            else {
                                if ($(value).attr("CourseStatus") != 'Completed') {
                                    alert("You cannot apply your feedback because the course is not completed");
                                }
                                else if ($(enroller).find('Enroller').attr("AttendanceStatus") != 'Attended') {
                                    alert("You cannot apply your feedback on an undetermined attendance status or unattended course");
                                }
                                else {
                                    buildFeedbackControl($(value).attr("CourseNo"));

                                    if ($("#FeedbackTooltip").is(":hidden")) {
                                        $("#FeedbackTooltip").slideDown(800, 'easeOutBounce');
                                    }

                                    /*store course ID*/
                                    $("#courseID").val($(value).attr("CourseID"));

                                    /*trigger modal popup extender*/
                                    $("#<%=alias.ClientID%>").trigger('click');
                                }
                        }
                        });
                }
                else if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        if ($(value).attr("CourseStatus") == 'Completed' || $(value).attr("CourseStatus") == 'Cancelled') {
                            alert("You cannot withdraw from a completed or cancelled course");
                        }
                        else {
                            var enroller = $("#<%=EMPTxt.ClientID%>").val().split(' ');

                                removeEnroller(enroller, $(value).attr("CourseID"));
                            }
                        });
                    }
                    else if ($(this).attr('id').search('schedule') != -1) {
                        $(this).bind('click', function () {
                            window.open(getURL().concat('EmployeeTraining/UserCourseVenueSchedule.aspx?courseid=' + $(value).attr("CourseID")));
                        });
                    }

                });

                row = $("#<%=gvCourses.ClientID%> tr:last-child").clone(true);
            });
        }
        function removeEnroller(enroller, courseID) {
            var result = confirm("Are you sure you would like to withdraw from this course?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'firstname':'" + enroller[0] + "','lastname':'" + enroller[1] + "','courseID':'" + courseID + "'}",
                    url: getServiceURL().concat("withdrawCourse"),
                    success: function (data)
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#refresh").trigger('click');
                    },
                    error: function (xhr, status, error) {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    }
                });
            }
        }
        function buildFeedbackControl(courseno) {
            $("#schedule").empty();

            var header =
            [
                { name: '' },
                { name: 'A' },
                { name: 'B' },
                { name: 'C' },
                { name: 'D' },
                { name: 'E' }
            ]

            $(header).each(function (index, value) {
                var sb = new StringBuilder();

                if (index == 0) {
                    sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:1px; width:460px;'>");
                    sb.append(value.name);
                    sb.append("</div>");
                }
                else {
                    sb.append("<div id='header_" + index + "' class='tdh' style='margin-left:1px; width:40px;'>");
                    sb.append(value.name);
                    sb.append("</div>");
                }

                $("#schedule").append(sb.toString());
            });

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'courseno':'" + courseno + "'}",
                url: getServiceURL().concat('getCourseByNumber'),
                success: function (data) {
                    var xmlCourse = $.parseXML(data.d);
                    var course = $(xmlCourse).find("Course")

                    var xmlQuestion = $.parseXML(course.attr('XMLQuestion'));

                    $(xmlQuestion).find('Question').each(function (index, value) {
                        var sb = new StringBuilder();

                        sb.append("<div id='" + $(this).attr('QuestionText') + "' class='row'>");

                        sb.append("<div id=row_'" + index + "' class='tr'>");

                        sb.append("<div id='Question_" + index + "' class='tdl' style='width:458px'>" + $(this).attr('QuestionText') + "</div>");
                        sb.append("<div id='Strongly_Disagree_" + index + "' class='tdl' style='width:38px'><input id='Strongly_Disagree_Radio" + index + "' type='radio' value='1' name='feedback_" + index + "'  /></div>");
                        sb.append("<div id='Disagree_" + index + "' class='tdl' style='width:38px'><input id='Disagree_Radio" + index + "' type='radio' name='feedback_" + index + "' value='2' /></div>");
                        sb.append("<div id='Agree_" + index + "' class='tdl' style='width:38px'><input id='Agree_Radio" + index + "' type='radio' name='feedback_" + index + "' value='3'/></div>");
                        sb.append("<div id='Undecided_" + index + "' class='tdl' style='width:38px'><input id='Undecided_Radio" + index + "' type='radio' name='feedback_" + index + "' value='4'/></div>");
                        sb.append("<div id='Strongly_Agree_" + index + "' class='tdl' style='width:38px'><input id='Strongly_Agree_Radio" + index + "' type='radio' name='feedback_" + index + "' value='5'/></div>");

                        sb.append("</div>");
                        sb.append("</div>");

                        $("#schedule").append(sb.toString());

                    });
                },
                error: function (xhr, status, error) {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
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

        function hideAll() {
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
        }
    </script>
</asp:Content>
