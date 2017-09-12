<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageTask.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ManageTask" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    
    <div id="TSK_Header" class="moduleheader">Manage Tasks</div>

    <div class="toolbox">
         <img id="refreshtask" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
           
         <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byREVSTS">Filter by Review Status</li>
                <li id="byREVCAT">Filter by Review Category</li>
                <li id="byREVDT">Filter by Planned Review Date</li>
                <li id="byREVTTL">Filter by Meeting Title</li>
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="byTSKNM">Filter by Task Name</li>
            </ul>
        </div>
    </div>

    <div id="ReviewDateContainer" class="filter">
        <div id="StartDateLabel" class="filterlabel">Planned Review Date:</div>
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

  
    <div id="ReviewTitleContainer" class="filter">
        <div id="ReviewTitleLabel" class="filterlabel">Review Title:</div>
        <div id="ReviewTitleField" class="filterfield">
            <asp:TextBox ID="REVNMFTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>

     <div id="TaskTitleContainer" class="filter">
        <div id="TaskTitleLabel" class="filterlabel">Task Name:</div>
        <div id="TaskTitleField" class="filterfield">
            <asp:TextBox ID="TSKTTLTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>

     <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="TSKwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="TaskScrollbar" class="gridscroll">
        <asp:GridView id="gvTasks" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ReviewNo" HeaderText="Review No." />
                <asp:BoundField DataField="EventName" HeaderText="Meeting Title" />
                <asp:BoundField DataField="PlannedReviewDate" HeaderText="Planned Review Date" />
                <asp:BoundField DataField="TaskName" HeaderText="Task Name" />
                <asp:BoundField DataField="Owner" HeaderText="Task Executive" />
                <asp:BoundField DataField="PlannedCloseDate" HeaderText="Planned Close Date" />
                <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
                <asp:BoundField DataField="IsClosed" HeaderText="Status" />
                <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="TaskHeader" class="modalHeader">Management Review Task Details<span id="TaskClose" class="modalclose" title="Close">X</span></div>
        
        <div id="TaskTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
         <div id="validation_dialog_task">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Task" />
        </div>

        <input id="taskID" type="hidden" value="" />
        
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
                <asp:TextBox ID="DTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DTLTxtVal" runat="server" ValidationGroup="Task" 
            ControlToValidate = "DTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:92px;">
            <div id="CloseDateLabel" class="requiredlabel">Planned Close Date:</div>
            <div id="CloseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CLSDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
   
            <asp:RequiredFieldValidator ID="CLSDTVal" runat="server" Display="None" ControlToValidate="CLSDTTxt" ErrorMessage="Enter the planned closing date of the task" ValidationGroup="Task"></asp:RequiredFieldValidator>
           
            <asp:RegularExpressionValidator ID="CLSDTFVal" runat="server" ControlToValidate="CLSDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Task"></asp:RegularExpressionValidator>
           
            <asp:CustomValidator id="CLSDTF2Val" runat="server" ValidationGroup="Task" Display="None"
            ControlToValidate = "CLSDTTxt" ErrorMessage = "Planned close date should be greater than or equals the planned date of the management review"
            ClientValidationFunction="comparePlannedReviewDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="CLSDTF4Val" runat="server" ValidationGroup="Task" 
            ControlToValidate = "CLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
       </div>
       
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActualCloseDateLabel" class="labeldiv">Actual Close Date:</div>
            <div id="ActualCloseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ACTCLSDT" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
   
            <asp:RegularExpressionValidator ID="ACTCLSDTVal" runat="server" ControlToValidate="ACTCLSDT"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Task"></asp:RegularExpressionValidator>
            
            <asp:CustomValidator id="ACTCLSDTFVal" runat="server" ValidationGroup="Task" 
            ControlToValidate = "ACTCLSDT" Display="None" ErrorMessage = "Actual close date shouldn't be in future"
            ClientValidationFunction="comparePast">
            </asp:CustomValidator>

            <asp:CustomValidator id="ACTCLSDTF1Val" runat="server" ValidationGroup="Task" 
            ControlToValidate = "ACTCLSDT" Display="None" ErrorMessage = "Actual close date should be greater than or equals the planned date of the management review"
            ClientValidationFunction="comparePlannedReviewDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="ACTCLSDTF2Val" runat="server" ValidationGroup="Task" 
            ControlToValidate = "ACTCLSDT"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
       </div>
       
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="TaskOwnerLabel" class="requiredlabel">Task Executive:</div>
            <div id="TaskOwnerField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="TSKEXETxt" runat="server" CssClass="readonly" Width="190px" ReadOnly="true"></asp:TextBox>
            </div>
            <span id="TSKEXESelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
           <asp:RequiredFieldValidator ID="TSKEXETxtVal" runat="server" Display="None" ControlToValidate="TSKEXETxt" ErrorMessage="Select task executive" ValidationGroup="Task"></asp:RequiredFieldValidator>              
       </div>

       <div id="SelectActionee" class="selectbox">
            <div id="closeACT" class="selectboxclose"></div>
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

       <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
       </div>
    </asp:Panel>
    
    <input id="reviewdate" type="hidden" value="" /> 

</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvTasks.ClientID%> tr:last-child").clone(true);

        loadTasks(empty);

        $("#refreshtask").bind('click', function ()
        {
            hideAll();

            loadTasks(empty);
        });

        $("#byREVCAT").bind('click', function ()
        {
            hideAll();

            /*load review category*/
            loadReviewCategory();

            $("#ReviewCategoryContainer").show();
        });

        $("#byREVSTS").bind('click', function ()
        {
            hideAll();

            /*load review status*/
            loadComboboxAjax('loadReviewStatus', '#<%=REVSTSFCBox.ClientID%>', "#REVFSTS_LD");

            $("#ReviewtStatusContainer").show();
        });

        $("#byREVTTL").bind('click', function ()
        {
            hideAll();

            $("#<%=REVNMFTxt.ClientID%>").val('');

            $("#ReviewTitleContainer").show();
        });

        $("#byTSKNM").bind('click', function ()
        {
            hideAll();

            $("#<%=TSKTTLTxt.ClientID%>").val('');

            $("#TaskTitleContainer").show();
        });

        $("#byREVDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#ReviewDateContainer").show();
        });

        $("#<%=REVNMFTxt.ClientID%>").keyup(function ()
        {
            filterByMeetingTitle($(this).val(), empty);
        });

        $("#<%=TSKTTLTxt.ClientID%>").keyup(function ()
        {
            filterByTaskTitle($(this).val(), empty);
        });

        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterTaskByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);

        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterTaskByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });


        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterTaskByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterTaskByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        /*filter by status*/
        $("#<%=REVSTSFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByStatus($(this).val(), empty);
            }
        });

        $('#<%=REVCATFCBox.ClientID%>').change(function () {
            if ($(this).val() != 0) {
                filterByCategory($(this).val(), empty);
            }
        });

        $("#TaskClose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#<%=CLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
            }
        });

        $("#<%=ACTCLSDT.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
            }
        });


        $("#<%=TSKEXESelect.ClientID%>").bind('click', function (e) {
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=EMPCBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EMP_LD");
            }
        });

        $("#<%=EMPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                $("#<%=TSKEXETxt.ClientID%>").val($(this).val());
                $("#SelectActionee").hide('800');
            }
        });

        $("#closeACT").bind('click', function () {
            $("#SelectActionee").hide('800');
        });

        $("#save").bind('click', function () {

            var isPageValid = Page_ClientValidate("Task");
            if (isPageValid)
            {
                if (!$("#validation_dialog_task").is(":hidden")) {
                    $("#validation_dialog_task").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        var TRGTDTParts = getDatePart($("#<%=CLSDTTxt.ClientID%>").val());
                        var ACTDTParts = getDatePart($("#<%=ACTCLSDT.ClientID%>").val());

                        var task =
                        {
                            TaskID: $("#taskID").val(),
                            TaskName: $("#<%=TSKNMTxt.ClientID%>").val(),
                            Description: $("#<%=DTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DTLTxt.ClientID%>").val()),
                            Owner: $("#<%=TSKEXETxt.ClientID%>").val(),
                            PlannedCloseDate: new Date(TRGTDTParts[2], (TRGTDTParts[1] - 1), TRGTDTParts[0]),
                            ActualCloseDate: $("#<%=ACTCLSDT.ClientID%>").val() == '' ? null : new Date(ACTDTParts[2], (ACTDTParts[1] - 1), ACTDTParts[0])
                        }
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(task) + "\'}",
                            url: getServiceURL().concat('updateTask'),
                            success: function (data) {
                                $("#SaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    $("#cancel").trigger('click');
                                    $("#refreshtask").trigger('click');
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
                $("#validation_dialog_task").stop(true).hide().fadeIn(500, function ()
                {
                    
                });
            }
        });
    });
    function comparePlannedReviewDate(sender, args) {
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
                success: function (data) {
                    $("#REVFCAT_LD").fadeOut(500, function () {

                        if (data) {
                            var xml = $.parseXML(data.d);

                            loadComboboxXML(xml, 'Category', 'CategoryName', '#<%=REVCATFCBox.ClientID%>');
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#REVFCAT_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function showORGDialog(x, y) {
        $("#SelectActionee").css({ left: x - 380, top: y - 25 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
        $("#<%=EMPCBox.ClientID%>").empty();
        $("#SelectActionee").show();
    }

    function filterByStatus(status, empty) {
        $("#TSKwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat('filterManagementReviewsByStatus'),
                success: function (data) {
                    $("#TSKwait").fadeOut(500, function () {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review tasks filtered by the status of the management review");

                            if (data) {
                                loadTaskGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByTaskTitle(task, empty)
    {
        $("#TSKwait").stop(true).hide().fadeIn(500, function ()
        {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'task':'" + task + "'}",
                url: getServiceURL().concat('filterManagementReviewsByTaskTitle'),
                success: function (data)
                {
                    $("#TSKwait").fadeOut(500, function ()
                    {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review tasks filtered by their title");

                            if (data)
                            {
                                loadTaskGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#TSKwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }


    function filterByMeetingTitle(title, empty)
    {
        $("#TSKwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat('filterManagementReviewsByMeetingTitle'),
                success: function (data) {
                    $("#TSKwait").fadeOut(500, function () {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review tasks filtered by the title of the management review");

                            if (data) {
                                loadTaskGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByCategory(category, empty)
    {
        $("#TSKwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat('filterManagementReviewsByCategory'),
                success: function (data) {
                    $("#TSKwait").fadeOut(500, function () {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review tasks filtered by the category of the management review");

                            if (data)
                            {
                                loadTaskGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterTaskByDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#TSKwait").stop(true).hide().fadeIn(500, function () {
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
                    url: getServiceURL().concat('filterManagementReviewsByDate'),
                    success: function (data) {
                        $("#TSKwait").fadeOut(500, function () {

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(".modulewrapper").css("cursor", "default");

                                $(this).find('p').text("List of management review tasks where the planned review date range between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));

                                if (data) {
                                    loadTaskGridView(data.d, empty);
                                }
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#TSKwait").fadeOut(500, function () {

                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }


    function loadTasks(empty)
    {
        $("#TSKwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                url: getServiceURL().concat('loadManagementReviews'),
                success: function (data) {

                    $("#TSKwait").fadeOut(500, function ()
                    {
                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                        {

                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of all current management review tasks");

                            if (data) {
                                loadTaskGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadTaskGridView(data, empty)
    {
        var xmlReview = $.parseXML(data);

        var row = empty;

        $("#<%=gvTasks.ClientID%> tr").not($("#<%=gvTasks.ClientID%> tr:first-child")).remove();

        $(xmlReview).find('Review').each(function (i, review) {
            var xmlTasks = $.parseXML($(this).attr('XMLTasks'));

            $(xmlTasks).find("ReviewTask").each(function (j, task)
            {
                $("td", row).eq(0).html("<img id='delete_" + j + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton'/>");
                $("td", row).eq(1).html("<img id='edit_" + j + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html($(review).attr("ReviewNo"));
                $("td", row).eq(3).html($(review).attr("ReviewName"));
                $("td", row).eq(4).html(new Date($(review).attr("PlannedReviewDate")).format("dd/MM/yyyy"));
                $("td", row).eq(5).html($(this).attr("TaskName"));
                $("td", row).eq(6).html($(this).attr("Owner"));
                $("td", row).eq(7).html(new Date($(this).attr("PlannedCloseDate")).format("dd/MM/yyyy"));
                $("td", row).eq(8).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
                $("td", row).eq(9).html($(this).attr("IsClosed") == 'true' ? 'Closed' : 'Open');
                $("td", row).eq(10).html($(review).attr("ModeString"));

                $("#<%=gvTasks.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            /*clear previous data*/
                            resetGroup('.modalPanel');
                            
                            $("#taskID").val($(task).attr("TaskID"));

                            /* temporarily store the planned date of the review record for validation purposes*/
                            $("#reviewdate").val($(review).attr("PlannedReviewDate"));

                            $("#<%=TSKNMTxt.ClientID%>").val($(task).attr("TaskName"));

                            $("#<%=CLSDTTxt.ClientID%>").val(new Date($(task).attr("PlannedCloseDate")).format("dd/MM/yyyy"));

                            $("#<%=ACTCLSDT.ClientID%>").val($(task).find("ActualCloseDate").text() == '' ? '' : new Date($(task).find("ActualCloseDate").text()).format("dd/MM/yyyy"));

                            $("#<%=TSKEXETxt.ClientID%>").val($(task).attr("Owner"));

                            /*bind the details of the task*/
                            if ($(task).attr("Description") == '')
                            {
                                addWaterMarkText('Brief Description of the Task', '#<%=DTLTxt.ClientID%>');
                            }
                            else
                            {
                                if ($("#<%=DTLTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    $("#<%=DTLTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=DTLTxt.ClientID%>").html($(task).attr("Description")).text();
                            }

                            /*attach task name to limit plugin*/
                            $("#<%=TSKNMTxt.ClientID%>").limit({ id_result: 'TSKlimit', alertClass: 'alertremaining' });

                            $("#<%=TSKNMTxt.ClientID%>").keyup();

                            if ($(review).attr('ReviewStatus') == 'Completed' || $(review).attr('ReviewStatus') == 'Cancelled')
                            {
                                $("#TaskTooltip").find('p').text("Cannot apply changes on the current task record since the management review status is " + $(review).attr('ReviewStatus'));

                                if ($("#TaskTooltip").is(":hidden"))
                                {
                                    $("#TaskTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else if ($(task).attr("IsClosed") == 'true')
                            {
                                $("#TaskTooltip").find('p').text("Cannot apply changes on the current task record it is closed");

                                if ($("#TaskTooltip").is(":hidden")) {
                                    $("#TaskTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else
                            {
                                $("#TaskTooltip").find('p').text("Note: The planned management review date for this task is on " + new Date($(review).attr("PlannedReviewDate")).format("dd/MM/yyyy"));

                                if ($("#TaskTooltip").is(":hidden")) {
                                    $("#TaskTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*enable all modal controls for editing*/
                                ActivateAll(true);
                            }

                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                    else if ($(this).attr('id').search('delete') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            removeTask($(task).attr("TaskID"));
                        });
                    }
                });

                row = $("#<%=gvTasks.ClientID%> tr:last-child").clone(true);
            });
        });
    }

    function removeTask(ID)
    {
        var result = confirm("Are you sure you would like to remove the current task?");
        if (result == true) {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'taskID':'" + ID + "'}",
                url: getServiceURL().concat('removeTask'),
                success: function (data) {
                    $(".modulewrapper").css("cursor", "default");

                    $("#refreshtask").trigger('click');
                },
                error: function (xhr, status, error) {

                    $(".modulewrapper").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }
    }

    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
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
        else
        {
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

    function hideAll()
    {
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
