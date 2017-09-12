<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="UserCourseVenueSchedule.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.UserCourseVenueSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="CourseVenueSchedule_Header" class="moduleheader">Course Timetable</div>
  
    <div id='calendar'></div>
  
    <script type="text/javascript" language="javascript">
        $(function ()
        {
        });
        function loadTimeTable(courseid)
        {
            $("#CRSVNUwait").show();

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
                    if (data)
                    {
                        $("#CRSVNUwait").hide();

                        var data = $.parseJSON(data.d);

                        var eventdata = new Array();


                        $(data).each(function (index, value) 
                        {
                            var starttimepart=value.starttime.split(":");
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
                            eventDeleteClick: function (calEvent, jsEvent, view)
                            {
                                alert("Not permitted to delete an event");
                            },
                            eventEditClick: function (calEvent, jsEvent, view)
                            {
                                alert("Not permitted to modify an event");
                            }
                        });
                    }
                },
                error: function (xhr, status, error)
                {
                    $("#CRSVNUwait").hide();

                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
       
        </script>
</asp:Content>
