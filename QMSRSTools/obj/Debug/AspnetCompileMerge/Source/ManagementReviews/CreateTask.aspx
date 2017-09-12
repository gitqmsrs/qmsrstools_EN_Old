<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateTask.aspx.cs" Inherits="QMSRSTools.ManagementReviews.CreateTask" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="TSK_Header" class="moduleheader">Create a New Task</div>

    <div class="toolbox">
        <img id="save" src="http://www.qmsrs.com/qmsrstools/Images/save.png" class="imgButton" title="Save Changes" alt="" />
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="ReviewIDLabel" class="requiredlabel">Review ID:</div>
        <div id="ReviewIDField" class="fielddiv" style="width:170px">
            <asp:TextBox ID="REVIDTxt" runat="server" CssClass="textbox" Width="160px"></asp:TextBox>
        </div>

        <span id="REVIDSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for a management review record"></span>
        
        <div id="REVID_LD" class="control-loader"></div>
        
        <asp:RequiredFieldValidator ID="REVIDVal" runat="server" Display="Dynamic" ControlToValidate="REVIDTxt" ErrorMessage="Enter the ID of the review record" ValidationGroup="ID" CssClass="validator"></asp:RequiredFieldValidator>  
    </div>

    <div id="ReviewTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="SearchReview" class="selectbox">
        <div class="toolbox">

            <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
    
            <div id="filter_div">
                <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byREVSTS">Filter by Review Status</li>
                    <li id="byREVCAT">Filter by Review Category</li>
                    <li id="byREVDT">Filter by Planned Review</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                    <li id="byREVTTL">Filter by Meeting Title</li>
                </ul>
            </div>

            <div id="closeBox" class="selectboxclose"></div>
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
            <div id="PlannedReviewDateField" class="filterfield">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
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

        <div id="FLTR_LD" class="control-loader"></div> 

        <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvReviews" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:BoundField DataField="ReviewNo" HeaderText="Review No." />
                <asp:BoundField DataField="EventName" HeaderText="Meeting Title" />
                <asp:BoundField DataField="PlannedReviewDate" HeaderText="Planned Review Date" />
                <asp:BoundField DataField="ActualReviewDate" HeaderText="Actual Review Date" />
                <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
                <asp:BoundField DataField="ReviewStatus" HeaderText="Status" />
                <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
            </Columns>
        </asp:GridView>
        </div>
    </div>

    <div id="TaskGroupHeader" class="groupboxheader">Task Details</div>
    <div id="TaskGroupField" class="groupbox" style="height:520px;">

        <div id="validation_dialog_task">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Task" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="TaskNameLabel" class="requiredlabel">Task Name:</div>
            <div id="TaskNameField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="TSKNMTxt" runat="server"  CssClass="textbox" Width="390px" Height="100px" TextMode="MultiLine"></asp:TextBox>
            </div>
            <div id="TSKlimit" class="textremaining"></div>
               
            <asp:RequiredFieldValidator ID="TSKNMTxtVal" runat="server" Display="None" ControlToValidate="TSKNMTxt" ErrorMessage="Enter the name of the task" ValidationGroup="Task"></asp:RequiredFieldValidator>
            
            <asp:CustomValidator id="TSKNMTxtFVal" runat="server" ValidationGroup="Task" 
            ControlToValidate = "TSKNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>    
        </div>  
        
        <div style="float:left; width:100%; height:20px; margin-top:102px;">
            <div id="TaskDetailsLabel" class="labeldiv">Description:</div>
            <div id="TaskDetailsField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="DTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="DTLTxtVal" runat="server" ValidationGroup="Task" 
            ControlToValidate = "DTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
       </div>

       <div style="float:left; width:100%; height:20px; margin-top:122px;">
            <div id="CloseDateLabel" class="requiredlabel">Planned Close Date:</div>
            <div id="CloseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CLSDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
   
            <asp:RequiredFieldValidator ID="CLSDTVal" runat="server" Display="None" ControlToValidate="CLSDTTxt" ErrorMessage="Enter the planned closing date of the task" ValidationGroup="Task"></asp:RequiredFieldValidator>
            
            <asp:RegularExpressionValidator ID="CLSDTFVal" runat="server" ControlToValidate="CLSDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Task"></asp:RegularExpressionValidator>
           
            <asp:CustomValidator id="CLSDTF2Val" runat="server" ValidationGroup="Task" 
            ControlToValidate = "CLSDTTxt" Display="None" ErrorMessage = "Planned close date should be greater than or equals the planned date of the management review"
            ClientValidationFunction="comparePlannedReviewDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="CLSDTF3Val" runat="server" ValidationGroup="Task" 
            ControlToValidate = "CLSDTTxt" Display="None" ErrorMessage = "Planned close date should be in future"
            ClientValidationFunction="compareFuture">
            </asp:CustomValidator>

            <asp:CustomValidator id="CLSDTF4Val" runat="server" ValidationGroup="Task" 
            ControlToValidate = "CLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
       </div>

       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="TaskOwnerLabel" class="requiredlabel">Task Executive:</div>
            <div id="TaskOwnerField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="TSKOWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>

            <div id="EXEC_LD" class="control-loader"></div>

            <span id="TSKEXESelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
            <asp:RequiredFieldValidator ID="TSKEXETxtVal" runat="server" Display="None" ControlToValidate="TSKOWNRCBox" ErrorMessage="Select task executive"  ValidationGroup="Task"></asp:RequiredFieldValidator>              
            
           <asp:CompareValidator ID="TSKEXEVal" runat="server" ControlToValidate="TSKOWNRCBox" ValidationGroup="Task"
            Display="None" ErrorMessage="Select task originator" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
      </div>

      <div id="SelectORG" class="selectbox">
        <div id="closeORG" class="selectboxclose"></div>
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
            <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                </asp:DropDownList> 
            </div>
            <div id="ORGUNT_LD" class="control-loader"></div>
        </div>
      </div>

    </div>

    <asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    <input id="reviewdate" type="hidden" />
    
</div>
<script type="text/javascript" language="javascript">
        $(function () {
            var empty = $("#<%=gvReviews.ClientID%> tr:last-child").clone(true);

            /*Deactivate all controls*/
            ActivateAll(false);


            $("#refresh").bind('click', function () {
                hideAll();

                refreshManagementReviews(empty);
            });

            /*attach task name to limit plugin*/
            $("#<%=TSKNMTxt.ClientID%>").limit({ id_result: 'TSKlimit', alertClass: 'alertremaining'});

         
            $("#byREVSTS").bind('click', function ()
            {
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

            $("#byRECMOD").bind('click', function ()
            {
                hideAll();
                $("#RecordModeContainer").show();

                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
            });

            $("#byREVTTL").bind('click', function ()
            {
                hideAll();

                $("#<%=REVNMFTxt.ClientID%>").val('');

                $("#ReviewTitleContainer").show();

            });
     
            $("#byREVDT").bind('click', function ()
            {
                hideAll();
                $("#PlannedReviewDateContainer").show();

                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');
            });

            $('#<%=REVSTSFCBox.ClientID%>').change(function () {
                if ($(this).val() != 0) {
                    filterByStatus($(this).val(),empty);
                }

            });

            $('#<%=REVCATFCBox.ClientID%>').change(function () {
                if ($(this).val() != 0) {
                    filterByCategory($(this).val(),empty);
                }
            });

            $("#<%=RECMODCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByMode($(this).val(),empty);
                }
            });

            $("#<%=REVNMFTxt.ClientID%>").keyup(function () {
                filterByMeetingTitle($(this).val(), empty);
            });
           
            $("#<%=REVIDSRCH.ClientID%>").bind('click', function (e)
            {
                hideAll();

                showReviewDialog(e.pageX, e.pageY, empty)
            });

            $("#closeBox").bind('click', function () {
                $("#SearchReview").hide('800');
            });

            $("#<%=CLSDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                }
            });

            $("#<%=TSKEXESelect.ClientID%>").bind('click', function (e) {
                if ($(".groupbox").is(":disabled")) {
                    alert("Please select a management review record");
                }
                else {
                    showORGDialog(e.pageX, e.pageY);
                }
            });

            /*populate the employees in task executive cbox*/
            $("#<%=ORGUNTCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    unitparam = "'unit':'" + $(this).val() + "'";

                    var loadcontrols = new Array();
                    loadcontrols.push("#<%=TSKOWNRCBox.ClientID%>");

                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EXEC_LD");
                    $("#SelectORG").hide('800');
                }
            });

            /*close organization unit box*/
            $("#closeORG").bind('click', function () {
                $("#SelectORG").hide('800');
            });

            $("#save").bind('click', function () {
                var isIDValid = Page_ClientValidate("ID");
                if (isIDValid)
                {
                    var isPageValid = Page_ClientValidate('Task');
                    if (isPageValid)
                    {
                        if (!$("#validation_dialog_task").is(":hidden")) {
                            $("#validation_dialog_task").hide();
                        }

                        var result = confirm("Are you sure you would like to submit changes?");
                        if (result == true)
                        {
                            $find('<%= SaveExtender.ClientID %>').show();

                            var CLSDTParts = getDatePart($("#<%=CLSDTTxt.ClientID%>").val());

                            var task =
                            {
                                TaskName: $("#<%=TSKNMTxt.ClientID%>").val(),
                                Description: $("#<%=DTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DTLTxt.ClientID%>").val()),
                                Owner: $("#<%=TSKOWNRCBox.ClientID%>").val(),
                                PlannedCloseDate: new Date(CLSDTParts[2], (CLSDTParts[1] - 1), CLSDTParts[0])
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{'json':'" + JSON.stringify(task) + "','reviewno':'" + $("#<%=REVIDTxt.ClientID%>").val() + "'}",
                                url: getServiceURL().concat("createTask"),
                                success: function (data) {
                                    $find('<%= SaveExtender.ClientID %>').hide();

                                    showSuccessNotification(data.d);

                                    resetGroup(".modulewrapper");

                                    ActivateAll(false);

                                    /*restore watermarks*/
                                    if (!$("#<%=DTLTxt.ClientID%>").hasClass("watermarktext"))
                                    {
                                        addWaterMarkText('The description of the task', '#<%=DTLTxt.ClientID%>');
                                    }
                                    
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
                        $("#validation_dialog_task").stop(true).hide().fadeIn(500, function ()
                        {
                            
                        });
                    }
                }
                else {
                    alert('Please enter or select the ID of the review');
                }
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterReviewsByDate(date, $("#<%=TDTTxt.ClientID%>").val(),empty);
                }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterReviewsByDate($("#<%=FDTTxt.ClientID%>").val(), date,empty);
                }
            });

            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterReviewsByDate($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });


            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterReviewsByDate($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });


            $("#<%=REVIDTxt.ClientID%>").keydown(function (event)
            {
                var $obj = $(this);

                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13')
                {
                    var text = $(this).val();

       
                    $("#REVID_LD").stop(true).hide().fadeIn(500, function ()
                    {
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'reviewno':'" + text + "'}",
                            url: getServiceURL().concat('getManagementReviewByUniqueNo'),
                            success: function (data)
                            {
                                $("#REVID_LD").fadeOut(500, function () {

                                    var xmlReview = $.parseXML(data.d);
                                    var review = $(xmlReview).find('Review');

                                    if ($(review).attr('ReviewStatus') == 'Completed' || $(review).attr('ReviewStatus') == 'Cancelled')
                                    {
                                        $("#ReviewTooltip").fadeOut(500, function ()
                                        {
                                            $(this).find('p').html("Cannot create a task record on " + $(review).attr('ReviewStatus') + " management review record");

                                            resetGroup(".modulewrapper");

                                            ActivateAll(false);
                                        });
                                    }
                                    else
                                    {
                                        $("#ReviewTooltip").stop(true).hide().fadeIn(500, function ()
                                        {
                                            $(this).find('p').html("The name selected management review record is (" + $(review).attr('ReviewName') + "), and the planned review date is scheduled on " + new Date($(review).attr('PlannedReviewDate')).format("dd/MM/yyyy"));

                                            /* temporarily store the planned date of the review record for validation purposes*/
                                            $("#reviewdate").val($(review).attr('PlannedReviewDate'));

                                            ActivateAll(true);

                                            /*attach name of the task to limit plugin*/
                                            $('#<%=TSKNMTxt.ClientID%>').limit({ id_result: 'TSKlimit', alertClass: 'alertremaining', limit: 90 });

                                            /*restore watermarks*/
                                            if (!$("#<%=DTLTxt.ClientID%>").hasClass("watermarktext")) {
                                                addWaterMarkText('The description of the task', '#<%=DTLTxt.ClientID%>');
                                            }

                                        });
                                    }
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#REVID_LD").fadeOut(500, function ()
                                {
                                    $(".modulewrapper").css("cursor", "default");

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);

                                    resetGroup(".modulewrapper");

                                    ActivateAll(false);
                                });
                            }
                        });
                    });
                }
            });
        });

        function comparePlannedReviewDate(sender, args)
        {
            var targetdatepart = getDatePart(args.Value);
            var planneddatepart = getDatePart(new Date($("#reviewdate").val()).format('dd/MM/yyyy'));


            var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
            var planneddate = new Date(planneddatepart[2], (planneddatepart[1] - 1), planneddatepart[0]);

            if (targetdate < planneddate) {
                args.IsValid = false;
            }
            else {
                args.IsValid = true;
            }

            return args.IsValid;
        }

        function ActivateAll(isactive) {
            if (isactive == false) {
                $(".groupbox").children().each(function () {
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

                    $(".textremaining").each(function () {
                        $(this).html('');
                    });
                });


                $('#save').attr("disabled", true);
            }
            else {
                $(".groupbox").each(function () {
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

                });

                $('#save').attr("disabled", false);
            }
        }

        function loadReviewCategory() {
            $("#REVFCAT_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadReviewCategories"),
                    success: function (data) {
                        $("#REVFCAT_LD").fadeOut(500, function () {

                            if (data) {
                                var xml = $.parseXML(data.d);

                                loadComboboxXML(xml, 'Category', 'CategoryName', '#<%=REVCATFCBox.ClientID%>');
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#REVFCAT_LD").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 180, top: y + 15 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
        $("#SelectORG").show();
    }

    function filterReviewsByDate(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true) {
            var dateparam =
            {
                StartDate: plannedstartdate,
                EndDate: plannedenddate
            }

            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('filterManagementReviewsByDate'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {

                            loadGridView(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
    }

    function filterByStatus(status, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat('filterManagementReviewsByStatus'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByMeetingTitle(title, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat('filterManagementReviewsByMeetingTitle'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByMode(mode, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterManagementReviewsByMode'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByCategory(category, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat('filterManagementReviewsByCategory'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function refreshManagementReviews(empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadManagementReviews'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvReviews.ClientID%> tr").not($("#<%=gvReviews.ClientID%> tr:first-child")).remove();

        $(xml).find("Review").each(function (index, value) {

            $("td", row).eq(0).html($(this).attr("ReviewNo"));
            $("td", row).eq(1).html($(this).attr("ReviewName"));
            $("td", row).eq(2).html(new Date($(this).attr("PlannedReviewDate")).format("dd/MM/yyyy"));
            $("td", row).eq(3).html($(this).find("ActualReviewDate").text() == '' ? '' : new Date($(this).find("ActualReviewDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(4).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualAuditDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(5).html($(this).attr("ReviewStatus"));
            $("td", row).eq(6).html($(this).attr("ModeString"));


            $("#<%=gvReviews.ClientID%>").append(row);

            row = $("#<%=gvReviews.ClientID%> tr:last-child").clone(true);
        });



        $("#<%=gvReviews.ClientID%> tr").not($("#<%=gvReviews.ClientID%> tr:first-child")).bind('click', function () {
            $("#SearchReview").hide('800');

            $("#<%=REVIDTxt.ClientID%>").val($("td", $(this)).eq(0).html());

            var e = jQuery.Event("keydown");
            e.which = 13; // # Some key code value
            $("#<%=REVIDTxt.ClientID%>").trigger(e);

        });
    }

    function showReviewDialog(x, y, empty)
    {
        refreshManagementReviews(empty);

        $("#SearchReview").css({ left: x - 280, top: y + 10 });
        $("#SearchReview").css({ width: 700, height: 250 });
        $("#SearchReview").show();
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
