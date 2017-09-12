<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateTaskAction.aspx.cs" Inherits="QMSRSTools.ManagementReviews.CreateTaskAction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper" class="modulewrapper">
    <div id="ACT_Header" class="moduleheader">Create a New Action</div>

    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" />
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="ReviewIDLabel" class="requiredlabel">Review ID:</div>
        <div id="ReviewIDField" class="fielddiv" style="width:170px">
            <asp:TextBox ID="REVIDTxt" runat="server" CssClass="textbox" Width="160px"></asp:TextBox>
        </div>
    
        <span id="REVIDSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for management review record"></span>
    
        <div id="REVID_LD" class="control-loader"></div>
    
        <asp:RequiredFieldValidator ID="REVIDVal" runat="server" Display="None" ControlToValidate="REVIDTxt" ErrorMessage="Enter the ID of the review record" ValidationGroup="ID"></asp:RequiredFieldValidator>  
    </div>

    <div id="ReviewTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>
    
    <div id="SearchReview" class="selectbox">
        <div class="toolbox">
             <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
      
            <div id="filter_div">
                <img id="filter" src="/Images/filter.png" alt=""/>
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
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="TaskLabel" class="requiredlabel">Select Task:</div>
        <div id="TaskField" class="fielddiv" style="width:400px">
            <asp:TextBox ID="TSKTxt" runat="server"  CssClass="readonly" Width="390px" Height="100px" TextMode="MultiLine"></asp:TextBox>
        </div>
        <input id="SRCHTSK" class="button" type="button" value="Search" style="margin-left:5px; width:85px" />
        
        <asp:RequiredFieldValidator ID="TSKVal" runat="server" Display="Dynamic" ControlToValidate="TSKTxt" ErrorMessage="Select a task" ValidationGroup="Task" CssClass="validator">
        </asp:RequiredFieldValidator>   
    </div>

    <div id="ActionGroupHeader" class="groupboxheader" style=" margin-top:105px;">Action Details</div>
    <div id="ActionGroupField" class="groupbox" style="height:400px">

        <div id="validation_dialog_action" class="validation" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Action" />
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActionTypeLabel" class="requiredlabel">Action Type:</div>
            <div id="ActionTypeField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="ACTTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="ACTYP_LD" class="control-loader"></div> 

            <asp:RequiredFieldValidator ID="ACTTYPTTxtVal" runat="server" Display="None" ErrorMessage="Select action type" ControlToValidate="ACTTYPCBox" ValidationGroup="Action">
            </asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="ACTTYPVal" runat="server" ControlToValidate="ACTTYPCBox"
            Display="None" ErrorMessage="Select action type" Operator="NotEqual" Style="position: static" ValidationGroup="Action"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActioneeLabel" class="requiredlabel">Actionee:</div>
            <div id="ActioneeField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="ACTEETxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>
            <div id="ACTEE_LD" class="control-loader"></div> 

            <span id="ACTEESelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
            <asp:RequiredFieldValidator ID="ACTEEVal" runat="server" Display="None" ControlToValidate="ACTEETxt" ErrorMessage="Select the name of the actionee" ValidationGroup="Action"></asp:RequiredFieldValidator>     
        </div>
    
        <div id="SelectActionee" class="selectbox" style="top:300px; left:160px;">
            <div id="closeActionee" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNT_LD" class="control-loader"></div> 
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="EMPNameLabel" class="labeldiv" style="width:100px;">Employee Name:</div>
                <div id="EMPNameField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="EMPCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="EMP_LD" class="control-loader"></div> 
            </div>
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActionDetailsLabel" class="labeldiv">Details:</div>
            <div id="ActionDetailsField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="ACTDTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="ACTDTLTxtVal" runat="server" ValidationGroup="Action" 
            ControlToValidate = "ACTDTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:125px;">
            <div id="TRGTDateLabel" class="requiredlabel">Target Close Date:</div>
            <div id="TRGTDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="TRGTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            
            <asp:RequiredFieldValidator ID="TRGTDTVal" runat="server" Display="None" ControlToValidate="TRGTDTTxt" ErrorMessage="Enter the target close date of the action" ValidationGroup="Action"></asp:RequiredFieldValidator>   
       
            <asp:RegularExpressionValidator ID="TRGTDTxtFVal" runat="server" ControlToValidate="TRGTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action">
            </asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="TRGTDTF2Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "TRGTDTTxt" Display="None" ErrorMessage = "Target close date should be greater than or equals the planned date of the management review"
            ClientValidationFunction="comparePlannedReviewDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="TRGTDTF3Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "TRGTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>

        </div>
    </div>

    <div id="TaskDialog" title="Related Tasks" style="display:none;">
        <div id="data"></div>
    </div>

    <input id="taskid" type="hidden" value="" /> 
    <input id="reviewdate" type="hidden" />



    <asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>
    
    </div>
    <script type="text/javascript" language="javascript">
        $(function () {
            var empty = $("#<%=gvReviews.ClientID%> tr:last-child").clone(true);

            addWaterMarkText('The Description of the Action', '#<%=ACTDTLTxt.ClientID%>');

            /*deactivate all controls*/
            ActivateAll(false);

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
                $("#RecordModeContainer").show();

                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
            });

            $("#byREVDT").bind('click', function () {
                hideAll();
                $("#PlannedReviewDateContainer").show();

                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');
            });

            $("#byREVTTL").bind('click', function ()
            {
                hideAll();

                $("#<%=REVNMFTxt.ClientID%>").val('');

                $("#ReviewTitleContainer").show();

            });

            $("#refresh").bind('click', function ()
            {
                hideAll();

                refreshManagementReviews(empty);
            });

            $("#<%=REVNMFTxt.ClientID%>").keyup(function ()
            {
                filterByTitle($(this).val());
            });

            $('#<%=REVSTSFCBox.ClientID%>').change(function ()
            {
                if ($(this).val() != 0)
                {
                    filterByStatus($(this).val(), empty);
                }

            });

            $('#<%=REVCATFCBox.ClientID%>').change(function () {
                if ($(this).val() != 0) {
                    filterByCategory($(this).val(), empty);
                }
            });

            $("#<%=RECMODCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByMode($(this).val(), empty);
                }
            });
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterReviewsByDate($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterReviewsByDate($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
           {
               inline: true,
               dateFormat: "dd/mm/yy",
               onSelect: function (date) {
                   filterReviewsByDate(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
               }
           });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterReviewsByDate($("#<%=FDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $("#<%=REVIDSRCH.ClientID%>").bind('click', function (e) {
                hideAll();

                showReviewDialog(e.pageX, e.pageY, empty)
            });


            $("#closeBox").bind('click', function ()
            {
                $("#SearchReview").hide('800');
            });

            $("#<%=ACTEESelect.ClientID%>").bind('click', function () {
                var isTaskValid = Page_ClientValidate("Task");
                if (isTaskValid) {
                    loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");

                    $("#<%=EMPCBox.ClientID%>").empty();
                    $("#SelectActionee").show();
                }
                else {
                    alert("Please select a task");
                }
            });


            $("#closeActionee").bind('click', function () {
                $("#SelectActionee").hide('800');
            });

            $("#<%=TRGTDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                }
            });

            $("#<%=ORGUNTCBox.ClientID%>").change(function () {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=EMPCBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EMP_LD");
            });

            $("#<%=EMPCBox.ClientID%>").change(function () {
                $("#<%=ACTEETxt.ClientID%>").val($(this).val());
                $("#SelectActionee").hide('800');
            });


            $("#<%=REVIDTxt.ClientID%>").keydown(function (event)
            {
                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13')
                {
                    var text = $(this).val();

                    loadTasks("#REVID_LD", text);
                }
            });

            $("#SRCHTSK").bind('click', function ()
            {
                showTaskDialog();
            });

            $("#save").bind('click', function ()
            {
                var isGeneralValid = Page_ClientValidate('ID');
                if (isGeneralValid) {
                    var isPageValid = Page_ClientValidate('Action');
                    if (isPageValid) {
                        if (!$("#validation_dialog_action").is(":hidden")) {
                            $("#validation_dialog_action").hide();
                        }

                        var result = confirm("Are you sure you would like to submit changes?");
                        if (result == true) {
                            $find('<%= SaveExtender.ClientID %>').show();

                            var CLSDTParts = getDatePart($("#<%=TRGTDTTxt.ClientID%>").val());
                            var action =
                            {
                                ActionType: $("#<%=ACTTYPCBox.ClientID%>").find('option:selected').text(),
                                Details: $("#<%=ACTDTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTDTLTxt.ClientID%>").val()),
                                Actionee: $("#<%=ACTEETxt.ClientID%>").val(),
                                TargetClosingDate: new Date(CLSDTParts[2], (CLSDTParts[1] - 1), CLSDTParts[0])
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{'json':'" + JSON.stringify(action) + "','taskID':'" + $("#taskid").val() + "'}",
                                url: getServiceURL().concat("createTaskAction"),
                                success: function (data)
                                {
                                    $find('<%= SaveExtender.ClientID %>').hide();

                                    showSuccessNotification(data.d);

                                    resetGroup(".modulewrapper");

                                    /*restore watermark for the action details*/
                                    if (!$("#<%=ACTDTLTxt.ClientID%>").hasClass("watermarktext"))
                                    {
                                        addWaterMarkText('The Description of the Action', '#<%=ACTDTLTxt.ClientID%>');
                                    }

                                    ActivateAll(false);

                                    $("#data").empty();

                                },
                                error: function (xhr, status, error)
                                {
                                    $find('<%= SaveExtender.ClientID %>').hide();

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);
                                }
                            });
                        }
                    }
                    else
                    {
                        $("#validation_dialog_action").stop(true).hide().fadeIn(500, function ()
                        {
                            
                        });
                    }
                }
                else
                {
                    alert("Enter a unique management review ID number");
                }
            });

        });

        function loadTasks(loader,reviewID)
        {
            $(loader).stop(true).hide().fadeIn(500, function () {

                $("#data").empty();

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'reviewno':'" + reviewID + "'}",
                    url: getServiceURL().concat('getManagementReviewByUniqueNo'),
                    success: function (data)
                    {
                        $(loader).fadeOut(500, function ()
                        {

                            var xmlReview = $.parseXML(data.d);

                            var review = $(xmlReview).find("Review");

                            if ($(review).attr('ReviewStatus') == 'Completed' || $(review).attr('ReviewStatus') == 'Cancelled')
                            {

                                $("#ReviewTooltip").stop(true).hide().fadeIn(500, function () {
                                    $(this).find('p').html("Cannot create an action on a task which is related to a " + $(review).attr('ReviewStatus') + " management review record");

                                    ActivateAll(false);

                                    resetGroup(".modulewrapper");
                                });
                            }
                            else
                            {
                                $("#ReviewTooltip").stop(true).hide().fadeIn(500, function ()
                                {
                                    $(this).find('p').html("The name selected management review record is (" + $(review).attr('ReviewName') + "), and the planned review date is scheduled on " + new Date($(review).attr('PlannedReviewDate')).format("dd/MM/yyyy"));

                                    /* temporarily store the planned date of the review record for validation purposes*/
                                    $("#reviewdate").val($(review).attr('PlannedReviewDate'));

                                    //activate search button
                                    $(".button").each(function () {
                                        $(this).attr("disabled", false);
                                        $(this).css({ opacity: 1 });
                                    });

                                    var tasks = $.parseXML($(review).attr("XMLTasks"));

                                    if ($(tasks).find("ReviewTask").length > 0) {
                                        $(tasks).find("ReviewTask").each(function (index, task) {
                                            var sb = new StringBuilder('');

                                            sb.append("<div id='row_" + index + "' class='datarow' title=''>");

                                            sb.append("<h3>(" + (index + 1) + ") Task");
                                            sb.append("</h3>");

                                            sb.append("<div class='content'>");

                                            sb.append("<div style='float:left; width:100%; height:20px; margin-top:2px;'>");
                                            sb.append("<div class='labeldiv'>Task</div>");
                                            sb.append("<div class='fielddiv' style='width:50%; height:auto;'>");
                                            sb.append("<div class='label' style='width:100%; height:auto;'>" + $(this).attr('TaskName') + "</div>");
                                            sb.append("</div>");
                                            sb.append("</div>");

                                            sb.append("</div>");
                                            sb.append("</div>");

                                            $("#data").append(sb.toString());

                                            $("#row_" + index).bind('click', function () {
                                                //cannot create an action on a closed task
                                                if ($(task).attr('IsClosed') == 'true')
                                                {
                                                    alert("Cannot create an action on a closed task");
                                                }
                                                else {
                                                    $("#<%=TSKTxt.ClientID%>").val($(task).attr('TaskName'));
                                                    $("#taskid").val($(task).attr('TaskID'));

                                                    refreshActionType();

                                                    ActivateAll(true);

                                                    $("#TaskDialog").dialog("close");
                                                }
                                            });
                                        });
                                    }
                                    else
                                    {
                                        alert("There are no tasks for the current management review record in order to define a corresponding action");
                                        resetGroup(".modulewrapper");

                                        ActivateAll(false);
                                    }
                                });
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $(loader).fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);

                            resetGroup(".modulewrapper");

                            ActivateAll(false);
                        });

                    }
                });
            });
        }

        function refreshActionType()
        {
            $("#ACTYP_LD").stop(true).hide().fadeIn(500, function () {
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadTaskActionType"),
                    success: function (data)
                    {
                        $("#ACTYP_LD").fadeOut(500, function () {
                            var xml = $.parseXML(data.d);

                            loadComboboxXML(xml, 'TaskActionType', 'TypeName', '#<%=ACTTYPCBox.ClientID%>');
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#ACTYP_LD").fadeOut(500, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

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

        function showTaskDialog()
        {
            $("#TaskDialog").dialog(
            {
                width: 550,
                show: "slow",
                modal: true,
                height: 300,
                hide: "highlight",
                buttons:
                [
                     {
                         text: "Cancel",
                         click: function () {
                             $(this).dialog("close");
                         }
                     }
                ],
                close: function (event, ui) {
                    $(this).dialog("destroy");
                }

            });
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

                $(".button").each(function () {
                    $(this).attr("disabled", true);
                    $(this).css({ opacity: 0.5 });
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
                $(".button").each(function () {
                    $(this).attr("disabled", false);
                    $(this).css({ opacity: 1 });
                });

                $('#save').attr("disabled", false);
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

        function filterByTitle(title, empty)
        {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'mode':'" + mode + "'}",
                    url: getServiceURL().concat('filterManagementReviewsByMeetingTitle'),
                    success: function (data)
                    {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            loadGridView(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#FLTR_LD").fadeOut(500, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }

        function filterReviewsByDate(start, end, empty) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true) {

                $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

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

        function refreshManagementReviews(empty) {
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

        function loadReviewCategory()
        {
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

        function loadGridView(data, empty) {
            var xml = $.parseXML(data);

            var row = empty;

            $("#<%=gvReviews.ClientID%> tr").not($("#<%=gvReviews.ClientID%> tr:first-child")).remove();

            $(xml).find("Review").each(function (index, value) {

                $("td", row).eq(0).html($(this).attr("ReviewNo"));
                $("td", row).eq(1).html($(this).attr("ReviewName"));
                var plannedreviewdate = new Date($(this).attr("PlannedReviewDate"));
                plannedreviewdate.setMinutes(plannedreviewdate.getMinutes() + plannedreviewdate.getTimezoneOffset());

                $("td", row).eq(2).html(plannedreviewdate.format("dd/MM/yyyy"));

                var actualreviewdate = new Date($(this).find("ActualReviewDate").text());
                actualreviewdate.setMinutes(actualreviewdate.getMinutes() + actualreviewdate.getTimezoneOffset());

                $("td", row).eq(3).html($(this).find("ActualReviewDate").text() == '' ? '' : actualreviewdate.format("dd/MM/yyyy"));

                var actualclosedate = new Date($(this).find("ActualCloseDate").text());
                actualclosedate.setMinutes(actualclosedate.getMinutes() + actualclosedate.getTimezoneOffset());

                $("td", row).eq(4).html($(this).find("ActualCloseDate").text() == '' ? '' : actualclosedate.format("dd/MM/yyyy"));
                $("td", row).eq(5).html($(this).attr("ReviewStatus"));


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

        function showReviewDialog(x, y, empty) {
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
