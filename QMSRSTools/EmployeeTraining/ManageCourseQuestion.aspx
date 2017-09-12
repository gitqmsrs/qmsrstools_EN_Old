<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageCourseQuestion.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.ManageCourseQuestion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="CourseQuestions_Header" class="moduleheader">Manage Course Questions</div>

    <div class="toolbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="new" src="/Images/new_file.png" class="imgButton" title="Add New Course Question" alt="" />  
        <div id="CourseIDContainer"  style=" float:left;width:500px; margin-left:10px; height:20px; margin-top:3px;">
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
                    <li id="byTitle">Filter by Course Title</li>
                    <li id="byStatus">Filter by Course Status</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>
                        
            <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
        </div>
        
        <div id="CourseTitleContainer" class="filter">
            <div id="CourseTitleLabel" class="filterlabel">Filter by Title:</div>
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

     <div id="CourseQuestionTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>

    <div id="CRSQUSwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <div id="scrollbarQuestion" class="gridscroll">
        <asp:GridView id="gvQuestions" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="Question" HeaderText="Question" />
                <asp:BoundField DataField="QuestionMode" HeaderText="Question Type" />

            </Columns>
        </asp:GridView>
    </div>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel" style="height:450px;">
         <div id="CourseQuestion_Details" class="modalHeader">Question Details<span id="close" class="modalclose" title="Close">X</span></div>
       
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <input id="questionID" type="hidden" value="" />
        
        <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div id="QuestionTooltip" class="tooltip">
            <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="SelectQuestionLabel" class="requiredlabel">Select Question:</div>
            <div id="SelectQuestionField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="QUSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>   
            </div>      
            <div id="QUS_LD" class="control-loader"></div>

            <img id="AddQuestion" src="/Images/add.png" class="imgButton" title="Add New Question" alt="" /> 
                
            <asp:RequiredFieldValidator ID="QUSVal" runat="server" Display="None" ControlToValidate="QUSCBox" ErrorMessage="Select a question" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CompareValidator ID="QUSFVal" runat="server" ControlToValidate="QUSCBox"
            Display="None" ErrorMessage="Select a question" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>

        <div id="CreateQuestionGroupHeader" class="groupboxheader" style=" margin-top:15px;">Create Question</div>
        <div id="CreateQuestionGroupField" class="groupbox" style="height:260px; display:none;">

            <img id="SaveQUS" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" style="display:none;"/>
                
            <img id="SaveQUSWIMG" src="/Images/wait-loader.gif" alt="Save" height="25" width="25" style="display:none;" />
              
            <div id="validation_dialog_new">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="New" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="QuestionLabel" class="requiredlabel">Question:</div>
                <div id="QuestionField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="QUSTxt" runat="server"  CssClass="textbox" Width="390px" Height="180px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <div id="QUSlimit" class="textremaining"></div>
                  
                <asp:RequiredFieldValidator ID="QUSTxtVal" runat="server" Display="None" ControlToValidate="QUSTxt" ErrorMessage="Enter the desired question" ValidationGroup="New"></asp:RequiredFieldValidator>
                
                <asp:CustomValidator id="QUSTxtF1Val" runat="server" ValidationGroup="New" 
                ControlToValidate = "QUSTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:182px;">
                <div id="QuestionTypeLabel" class="requiredlabel">Question Type:</div>
                <div id="QuestionTypeField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="QUSTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>   
                </div>
                <div id="QUSTYP_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="QUSTYPTxtVal" runat="server" Display="None" ControlToValidate="QUSTYPCBox" ErrorMessage="Select the type of the question" ValidationGroup="New"></asp:RequiredFieldValidator>   
                
                <asp:CompareValidator ID="QUSTYPVal" runat="server" ControlToValidate="QUSTYPCBox"
                Display="None" ErrorMessage="Select the type of the question" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="New"></asp:CompareValidator>
            </div>
        </div>
         
        <div class="buttondiv">
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
            var queempty = $("#<%=gvQuestions.ClientID%> tr:last-child").clone(true);

          
            $("#refreshcourses").bind('click', function () {
                hideAll();
                loadCourses(empty);
            });

            $("#byTitle").bind('click', function () {
                hideAll();

                $("#<%=CRSNMTxt.ClientID%>").val('');

                $("#CourseTitleContainer").show();
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

            $("#<%=CRSSelect.ClientID%>").bind('click', function (e) {
                hideAll();

                showCourseDialog(e.pageX, e.pageY, empty);
            });

            $("#<%=CRSNMTxt.ClientID%>").keyup(function (event) {
                filterCoursesByTitle($(this).val(), empty);
            });

            $("#<%=RECMODCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterCoursesByMode($(this).val(), empty);
                }
            });

            $('#<%=CSTSFCBox.ClientID%>').change(function () {
                if ($(this).val() != 0) {
                    filterCoursesByStatus($(this).val(), empty);
                }
            });

            $("#refresh").bind('click', function ()
            {
                if ($("#CourseJSON").val() != '')
                {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());

                    refreshQuestions(courseJSON.CourseNo, queempty);
                }
                else
                {
                    alert("Please select a course");
                }
            });

            $("#AddQuestion").bind('click', function ()
            {
                var $group = $(".groupbox");

                $group.stop(true).hide().fadeIn(800, function ()
                {
                    $group.children().each(function ()
                    {
                        if ($("#SaveQUS").is(":hidden"))
                        {
                            $("#SaveQUS").show();
                        }

                        $(this).find('.textbox').each(function ()
                        {
                            if (!$(this).hasClass("watermarktext"))
                            {
                                $(this).val('');

                                addWaterMarkText('Add your question here no maximum than 300 words, or select a question by clicking the search button next to the field', '#<%=QUSTxt.ClientID%>');
                            }
                        });
                    });

                    /*attach question to limit plugin*/
                    $("#<%=QUSTxt.ClientID%>").limit({ id_result: 'QUSlimit', alertClass: 'alertremaining' });

                    /*load question mode*/
                    loadComboboxAjax('loadQuestionMode', '#<%=QUSTYPCBox.ClientID%>', "#QUSTYP_LD");

                });
            });

            $("#new").bind('click', function ()
            {
                if ($("#CourseJSON").val() != '')
                {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());

                    if (courseJSON.Status == 'Completed' || courseJSON.Status == 'Cancelled')
                    {
                        alert("Cannot add a new question to this course since it is " + courseJSON.Status);
                    }
                    else if (courseJSON.Mode == 'Archived')
                    {
                        alert("Cannot add a new question to an archived course");
                    }
                    else
                    {
                        /*clear all fields*/
                        resetGroup('.modalPanel');

                        /*set modal mode to add*/
                        $("#MODE").val('ADD');

                        /*reset data*/
                        $("#<%=panel2.ClientID%>").children().each(function () {

                            $(this).find('.combobox').each(function () {
                                $(this).val(0);
                            });
                        });

                        $(".groupbox").hide()
                        $("#SaveQUS").hide();

                        /*load questions*/
                        loadComboboxAjax('loadCourseQuestions', '#<%=QUSCBox.ClientID%>', "#QUS_LD");

                        $("#<%=alias.ClientID%>").trigger('click');
                    }
                }
                else
                {
                    alert("Please select a course");
                }
            });

            $("#SaveQUS").bind('click', function ()
            {
                var isVenueValid = Page_ClientValidate('New');
                if (isVenueValid)
                {
                    if (!$("#validation_dialog_new").is(":hidden"))
                    {
                        $("#validation_dialog_new").hide();
                    }

                    $("#SaveQUSWIMG").stop(true).hide().fadeIn(500, function ()
                    {
                        $(".modalPanel").css("cursor", "wait");

                        var question =
                        {
                            QuestionText: $("#<%=QUSTxt.ClientID%>").val(),
                            QuestionMode: $("#<%=QUSTYPCBox.ClientID%>").val()
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(question) + "\'}",
                            url: getServiceURL().concat('createCourseQuestion'),
                            success: function (data)
                            {
                                $("#SaveQUSWIMG").fadeOut(500, function ()
                                {
                                    $(".modalPanel").css("cursor", "default");

                                    $(".groupbox").fadeOut('slow', function ()
                                    {
                                        $("#SaveQUS").hide();

                                        /*load questions*/
                                        loadComboboxAjax('loadCourseQuestions', '#<%=QUSCBox.ClientID%>', "#QUS_LD");

                                    });
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#SaveQUSWIMG").fadeOut(500, function ()
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
                    $("#validation_dialog_new").stop(true).hide().fadeIn(500, function ()
                    {
                        
                    });
                }
            });


            /*save changes*/
            $("#save").bind('click', function ()
            {
                if ($("#SaveQUS").is(":visible")) {
                    var r = confirm("You still have unsaved changes. Press OK if you want to continue and discard the changes.")
                } else {
                    funcIsValid();
                }


                if (r == true) {
                    funcIsValid();
                }

                function funcIsValid() {
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

                            if ($("#MODE").val() == 'ADD') {
                                var question =
                                {
                                    QuestionText: $("#<%=QUSCBox.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(question) + "\','courseID':'" + courseJSON.ID + "'}",
                                    url: getServiceURL().concat('addTrainingCourseQuestion'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function ()
                                        {
                                            ActivateSave(true);

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
                                            alert(r.Message);
                                        });
                                    }
                                });
                            }
                            else if ($("#MODE").val() == "EDIT") {
                                var question =
                                {
                                    QuestionID: $("#questionID").val(),
                                    QuestionText: $("#<%=QUSCBox.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(question) + "\','courseID':'" + courseJSON.ID + "'}",
                                    url: getServiceURL().concat('updateTrainingCourseQuestion'),
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
                        
                    });
                }
                }
            });

            $("#closeBox").bind('click', function () {
                $("#SearchCourse").hide('800');
            });

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
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

                        $("#CRSQUSwait").stop(true).hide().fadeIn(500, function ()
                        {
                            if (!$("#SearchCourse").is(":hidden")) {
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
                                        $("#CRSQUSwait").fadeOut(500, function () {

                                            $(".modulewrapper").css("cursor", "default");

                                            $("#CourseQuestionTooltip").stop(true).hide().fadeIn(800, function () {
                                                $(this).find('p').text("List of all feedback questions associated with the selected course");
                                            });

                                            var course = $(xmlCourse).find("Course");

                                            /* create temporary JSON course for future reference*/
                                            var courseJSON =
                                            {
                                                ID: course.attr('CourseID'),
                                                CourseNo: course.attr('CourseNo'),
                                                Status: course.attr('CourseStatus'),
                                                Mode: course.attr('ModeString')
                                            }

                                            /*serialize and temprary store json data*/
                                            $("#CourseJSON").val(JSON.stringify(courseJSON));

                                            /*Load course questions*/
                                            loadQuestions(data.d, queempty);
                                        });
                                    });
                                },
                                error: function (xhr, status, error)
                                {
                                    $("#CRSID_LD").fadeOut(500, function ()
                                    {
                                        $("#CRSQUSwait").fadeOut(500, function () {

                                            $(".modulewrapper").css("cursor", "default");

                                            $("#CourseQuestionTooltip").fadeOut(800, function () {
                                            });

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            alert(r.Message);

                                            if ($("#CourseJSON").val() != '') {
                                                $("#CourseJSON").val('');
                                            }

                                            /*empty the question gridview*/
                                            $("#<%=gvQuestions.ClientID%> tr").not($("#<%=gvQuestions.ClientID%> tr:first-child")).remove();
                                        });
                                    });
                                }
                            });
                        });
                    });
                }
                    
            });
        });
        function refreshQuestions(courseno, empty)
        {
            $("#CRSQUSwait").stop(true).hide().fadeIn(500, function () {
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

                        $("#CRSQUSwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseQuestionTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all feedback questions associated with the selected course");
                            });

                            var course = $(xmlCourse).find("Course");
                            
                            /* create temporary JSON course for future reference*/
                            var courseJSON =
                            {
                                ID: course.attr('CourseID'),
                                CourseNo: course.attr('CourseNo'),
                                Status: course.attr('CourseStatus'),
                                Mode: course.attr('ModeString')
                            }

                            /*serialize and temprary store json data*/
                            $("#CourseJSON").val(JSON.stringify(courseJSON));

                            /*Load course questions*/
                            loadQuestions(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#CRSQUSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#CourseQuestionTooltip").fadeOut(800, function () {
                            });

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);

                            if ($("#CourseJSON").val() != '') {
                                $("#CourseJSON").val('');
                            }

                            /*empty the question gridview*/
                            $("#<%=gvQuestions.ClientID%> tr").not($("#<%=gvQuestions.ClientID%> tr:first-child")).remove();

                        });
                    }
                });
            });
        }

        function removeCourseQuestion(courseno, questionID)
        {
            var result = confirm("Are you sure you would like to remove the selected training course question?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'courseNo':'" + courseno + "','questionID':'" + questionID + "'}",
                    url: getServiceURL().concat("removeTrainingCourseQuestion"),
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
        function loadQuestions(data, empty)
        {
            var xmlCourse = $.parseXML(data);
            var course = $(xmlCourse).find("Course");
          
            var xmlQuestions = $.parseXML(course.attr('XMLQuestion'));

            var row = empty;

            $("#<%=gvQuestions.ClientID%> tr").not($("#<%=gvQuestions.ClientID%> tr:first-child")).remove();

          
            $(xmlQuestions).find("Question").each(function (index, value)
            {
                $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html($(this).attr("QuestionText"));
                $("td", row).eq(3).html($(this).attr("QuestionMode"));

                $("#<%=gvQuestions.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('delete') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            removeCourseQuestion(course.attr('CourseNo'), $(value).attr('QuestionID'));
                        });
                    }
                    else if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            /*clear all fields*/
                            resetGroup('.modalPanel');

                            /* set the ID of the question*/
                            $("#questionID").val($(value).attr('QuestionID'));

                            /*bind the question value*/
                            bindComboboxAjax('loadCourseQuestions', '#<%=QUSCBox.ClientID%>', $(value).attr('QuestionText'), "#QUS_LD");
                           

                            if (course.attr('CourseStatus') == 'Cancelled' || course.attr('CourseStatus') == 'Completed')
                            {
                                $("#QuestionTooltip").find('p').text("Changes cannot take place since the course status is " + course.attr('CourseStatus'));

                                if ($("#QuestionTooltip").is(":hidden")) {
                                    $("#QuestionTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);

                            }
                            else if (course.attr('ModeString') == 'Archived')
                            {
                                $("#QuestionTooltip").find('p').text("Changes cannot take place since the course is archived");

                                if ($("#QuestionTooltip").is(":hidden")) {
                                    $("#QuestionTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else {
                                $("#QuestionTooltip").hide();

                                /*enable all modal controls for editing*/
                                ActivateAll(true);
                            }

                            /*set modal mode to edit*/
                            $("#MODE").val('EDIT');


                            $(".groupbox").hide()
                            $("#SaveQUS").hide();

                            /*trigger modal popup extender*/
                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                });
                row = $("#<%=gvQuestions.ClientID%> tr:last-child").clone(true);
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
                    success: function (data)
                    {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
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

        function loadCourses(empty)
        {
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


            $("#<%=gvCourses.ClientID%> tr").not($("#<%=gvCourses.ClientID%> tr:first-child")).bind('click', function () {

                $("#SearchCourse").hide('800');

                $("#<%=CourseIDTxt.ClientID%>").val($("td", $(this)).eq(0).html());

                var e = jQuery.Event("keydown");
                e.which = 13; // # Some key code value
                $("#<%=CourseIDTxt.ClientID%>").trigger(e);

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

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).fin('imgButton').each(function ()
                {
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

                $(this).find('imgButton').each(function () {
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
