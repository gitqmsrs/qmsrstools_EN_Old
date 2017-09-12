<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageTask.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ManageTask" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    
    <div id="TSK_Header" class="moduleheader">Manage Tasks</div>

    <div class="toolbox">
         <img id="refreshtask" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
         <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
           
         <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byREVSTS">Filter by Review Status</li>
                <li id="byREVCAT">Filter by Review Category</li>
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="byREVDT">Filter by Planned Review Date</li>
            </ul>
        </div>

        <div id="ReviewDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
            <div id="StartDateLabel" style="width:120px;">Planned Review Date:</div>
            <div id="StartDateField" style="width:270px; left:0; float:left;">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>
    
        <div id="ReviewtStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ReviewStatusFLabel" style="width:100px;">Review Status:</div>
            <div id="ReviewStatusFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="REVSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="REVFSTS_LD" class="control-loader"></div>
        </div>
        <div id="ReviewCategoryContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ReviewCategoryFLabel" style="width:100px;">Review Category:</div>
            <div id="ReviewCategoryFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="REVCATFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="REVFCAT_LD" class="control-loader"></div>
        </div>

        <div id="RecordModeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
            <div id="RecordModeField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RECMODF_LD" class="control-loader"></div>
        </div>
    </div>

    <div id="TSKwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="TaskScrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
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
                <asp:BoundField DataField="PlannedReviewDate" HeaderText="Planned Review Date" />
                <asp:BoundField DataField="TaskName" HeaderText="Task Name" />
                <asp:BoundField DataField="Owner" HeaderText="Task Executive" />
                <asp:BoundField DataField="PlannedCloseDate" HeaderText="Planned Close Date" />
                <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
                <asp:BoundField DataField="TaskStatus" HeaderText="Status" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="TaskHeader" class="modalHeader">Management Review Task Details<span id="TaskClose" class="modalclose" title="Close">X</span></div>
        
        <div id="TaskTooltip" class="tooltip">
            <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
         <div id="validation_dialog_task" style="display: none">
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

        $("#refreshtask").bind('click', function () {
            hideAll();
            loadTasks(empty);
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

        $("#deletefilter").bind('click', function () {
            hideAll();
            loadTasks(empty);
        });

        $("#byREVSTS").bind('click', function () {
            hideAll();

            /*load review status*/
            loadComboboxAjax('loadReviewStatus', '#<%=REVSTSFCBox.ClientID%>', "#REVFSTS_LD");

            $("#ReviewtStatusContainer").show();
        });


        $("#byREVDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#ReviewDateContainer").show();
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

        $("#<%=RECMODCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByMode($(this).val(), empty);
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
                                    alert(r.Message);
                                });
                            }
                        });
                    });
                }
            }
            else
            {
                $("#validation_dialog_task").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
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
                        alert(r.Message);
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
                        $(".modulewrapper").css("cursor", "default");

                        loadTaskGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function filterByMode(mode, empty) {
        $("#TSKwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterManagementReviewsByMode'),
                success: function (data) {
                    $("#TSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadTaskGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
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
                        $(".modulewrapper").css("cursor", "default");

                        loadTaskGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterTaskByDateRange(start, end, empty) {
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
                            $(".modulewrapper").css("cursor", "default");

                            loadTaskGridView(data.d, empty);
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#TSKwait").fadeOut(500, function () {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }


    function loadTasks(empty) {
        $("#TSKwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                url: getServiceURL().concat('loadManagementReviews'),
                success: function (data) {
                    $("#TSKwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadTaskGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#TSKwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadTaskGridView(data, empty) {
        var xmlReview = $.parseXML(data);

        var row = empty;

        $("#<%=gvTasks.ClientID%> tr").not($("#<%=gvTasks.ClientID%> tr:first-child")).remove();

        $(xmlReview).find('Review').each(function (i, review) {
            var xmlTasks = $.parseXML($(this).attr('XMLTasks'));

            $(xmlTasks).find("ReviewTask").each(function (j, task) {
                $("td", row).eq(0).html("<img id='delete_" + j + "' src='../Images/deletenode.png' class='imgButton'/>");
                $("td", row).eq(1).html("<img id='edit_" + j + "' src='../Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html($(review).attr("ReviewNo"));
                $("td", row).eq(3).html(new Date($(review).attr("PlannedReviewDate")).format("dd/MM/yyyy"));
                $("td", row).eq(4).html($(this).attr("TaskName"));
                $("td", row).eq(5).html($(this).attr("Owner"));
                $("td", row).eq(6).html(new Date($(this).attr("PlannedCloseDate")).format("dd/MM/yyyy"));
                $("td", row).eq(7).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
                $("td", row).eq(8).html($(this).attr("IsClosed") == 'true' ? 'Closed' : 'Open');

                $("#<%=gvTasks.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            $("#validation_dialog_task").hide();

                            $("#taskID").val($(task).attr("TaskID"));


                            /* temporarily store the planned date of the review record for validation purposes*/
                            $("#reviewdate").val($(review).attr("PlannedReviewDate"));

                            $("#<%=TSKNMTxt.ClientID%>").val($(task).attr("TaskName"));
                            $("#<%=CLSDTTxt.ClientID%>").val(new Date($(task).attr("PlannedCloseDate")).format("dd/MM/yyyy"));
                            $("#<%=ACTCLSDT.ClientID%>").val($(task).find("ActualCloseDate").text() == '' ? '' : new Date($(task).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
                            $("#<%=TSKEXETxt.ClientID%>").val($(task).attr("Owner"));

                            /*bind the details of the task*/
                            if ($(task).attr("Description") == '') {
                                addWaterMarkText('Brief Description of the Task', '#<%=DTLTxt.ClientID%>');
                            }
                            else {
                                if ($("#<%=DTLTxt.ClientID%>").hasClass("watermarktext")) {
                                    $("#<%=DTLTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=DTLTxt.ClientID%>").html($(task).attr("Description")).text();
                            }

                            /*attach task name to limit plugin*/
                            $("#<%=TSKNMTxt.ClientID%>").limit({ id_result: 'TSKlimit', alertClass: 'alertremaining' });
                            $("#<%=TSKNMTxt.ClientID%>").keyup();

                            if ($(task).attr("IsClosed") == 'true') {
                                $("#TaskTooltip").find('p').text("Cannot apply changes on the current task record since it is closed");

                                if ($("#TaskTooltip").is(":hidden")) {
                                    $("#TaskTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else if ($(review).attr('ReviewStatus') == 'Completed' || $(review).attr('ReviewStatus') == 'Cancelled') {
                                $("#TaskTooltip").find('p').text("Cannot apply changes on the current task record since the management review status is " + $(review).attr('ReviewStatus'));

                                if ($("#TaskTooltip").is(":hidden")) {
                                    $("#TaskTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);

                            }
                            else
                            {
                                $("#TaskTooltip").hide();

                                /*enable all modal controls for editing*/
                                ActivateAll(true);
                            }

                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                    else if ($(this).attr('id').search('delete') != -1) {
                        $(this).bind('click', function () {
                            removeTask($(task).attr("TaskID"));
                        });
                    }
                });

                row = $("#<%=gvTasks.ClientID%> tr:last-child").clone(true);
            });
        });
    }
    function removeTask(ID) {
        var result = confirm("Are you sure you would like to remove the current action?");
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
                    alert(r.Message);
                }
            });
        }
    }
    function ActivateAll(isactive) {
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
