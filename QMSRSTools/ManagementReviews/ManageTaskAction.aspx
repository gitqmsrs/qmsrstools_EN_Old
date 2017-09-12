<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageTaskAction.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ManageTaskAction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="ACT_Header" class="moduleheader">Manage Review Actions</div>

    <div class="toolbox">
        <img id="refreshaction" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
           
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byREVSTS">Filter by Review Status</li>
                <li id="byREVCAT">Filter by Review Category</li>
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="byREVDT">Filter by Planned Review Date</li>
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

     <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
        <div id="RecordModeField" style="width:170px; left:0; float:left;">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RECMODF_LD" class="control-loader"></div>
     </div>

     <div id="TaskTitleContainer" class="filter">
        <div id="TaskTitleLabel" class="filterlabel">Task Name:</div>
        <div id="TaskTitleField" class="filterfield">
            <asp:TextBox ID="TSKTTLTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>
    	
    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="ACTwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>


    <div id="ActionScrollbar" class="gridscroll">
        <div id="RAGTooltip" class="tooltip" style="margin-top:20px; background-color:transparent;"> 
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="RED" src="/Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: Action has passed its target close date.</p>
            </div>
        
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="GREEN" src="/Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: Action is on schedule.</p>
            </div>
        
            <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
                <img id="AMBER" src="/Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: Action will be overdue soon.</p>
            </div>
        </div>

        <asp:GridView id="gvActions" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
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
                <asp:BoundField DataField="EventName" HeaderText="Meeting Title" />
                <asp:BoundField DataField="PlannedReviewDate" HeaderText="Planned Review Date" />
                <asp:BoundField DataField="Task" HeaderText="Task" />
                <asp:BoundField DataField="ActionType" HeaderText="Action Type" />
                <asp:BoundField DataField="TargetClosingDate" HeaderText="Target Close Date" />
                <asp:BoundField DataField="DelayedDate" HeaderText="Delayed To Date" />
                <asp:BoundField DataField="CompletedDate" HeaderText="Completed Date" />
                <asp:BoundField DataField="Actionee" HeaderText="Actionee" />
                <asp:BoundField DataField="ActionStatus" HeaderText="Action Status" />
                <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
        <div id="ActionHeader" class="modalHeader">Action Details<span id="ActionClose" class="modalclose" title="Close">X</span></div>
    
        <div id="validation_dialog_action">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Action" />
        </div>

        <div id="ActionTooltip" class="tooltip">
            <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
    
        <input id="ACTID" type="hidden" value="" />
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActionTypeLabel" class="requiredlabel">Action Type:</div>
            <div id="ActionTypeField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="ACTTYPCBox" AutoPostBack="false" runat="server" Width="230px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <asp:RequiredFieldValidator ID="ACTTYPTTxtVal" runat="server" Display="None" ErrorMessage="Select action type" ControlToValidate="ACTTYPCBox" ValidationGroup="Action">
            </asp:RequiredFieldValidator>

            <asp:CompareValidator ID="ACTTYPVal" runat="server" ControlToValidate="ACTTYPCBox"
            Display="None" ErrorMessage="Select action type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Action"></asp:CompareValidator>
        </div>   
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActioneeLabel" class="requiredlabel">Actionee:</div>
            <div id="ActioneeField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="ACTEETxt" Width="240px" runat="server" CssClass="readonly">
                </asp:TextBox>
            </div>
            <span id="ACTEESelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            <asp:RequiredFieldValidator ID="ACTEEVal" runat="server" Display="None" ControlToValidate="ACTEETxt" ErrorMessage="Select the name of the actionee" ValidationGroup="Action"></asp:RequiredFieldValidator>     
        </div>    

        <div id="SelectActionee" class="selectbox" style="top:140px;">
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
                <asp:TextBox ID="ACTDTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="ACTDTLTxtVal" runat="server" ValidationGroup="Action"
            ControlToValidate = "ACTDTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:92px;">
            <div id="TRGTDateLabel" class="requiredlabel">Target Close Date:</div>
            <div id="TRGTDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="TRGTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="TRGTDTVal" runat="server" Display="None" ControlToValidate="TRGTDTTxt" ErrorMessage="Enter the target close date of the action" ValidationGroup="Action"></asp:RequiredFieldValidator>   
    
            <asp:RegularExpressionValidator ID="TRGTDTTxtFVal" runat="server" ControlToValidate="TRGTDTTxt"
            ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" Display="None" ValidationGroup="Action"></asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="TRGTDTF2Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "TRGTDTTxt" Display="None" ErrorMessage = "Target close date should be greater than or equals the planned date of the review"
            ClientValidationFunction="comparePlannedReviewDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="TRGTDTF3Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "TRGTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DelayedDateLabel" class="labeldiv">Delayed Date:</div>
            <div id="DelatedDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="DLYDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
  
            <asp:RegularExpressionValidator ID="DLYDTTxtFVal" runat="server" ControlToValidate="DLYDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator>  
  
            <asp:CompareValidator ID="DLYDTTxtF2Val" runat="server" ControlToCompare="TRGTDTTxt"  ValidationGroup="Action"
            ControlToValidate="DLYDTTxt" ErrorMessage="Delayed date should be greater than target close date"
            Operator="GreaterThan" Type="Date" Display="None"></asp:CompareValidator>    
        
            <asp:CustomValidator id="DLYDTTxtF3Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "DLYDTTxt" Display="None" ErrorMessage = "Delayed date should be greater than or equals the planned date of the review"
            ClientValidationFunction="comparePlannedReviewDate">
            </asp:CustomValidator> 

            <asp:CustomValidator id="DLYDTF4Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "DLYDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CompletedDateLabel" class="labeldiv">Completion Date:</div>
            <div id="CompletedDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CMPLTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>

            <asp:RegularExpressionValidator ID="CMPLTDTTxtFval" runat="server" ControlToValidate="CMPLTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action"></asp:RegularExpressionValidator>  
             
            <asp:CustomValidator id="CMPLTDTF2Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "CMPLTDTTxt" Display="None" ErrorMessage = "Complete date shouldn't be in future"
            ClientValidationFunction="comparePast">
            </asp:CustomValidator>

            <asp:CustomValidator id="CMPLTDTF3Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "CMPLTDTTxt" Display="None" ErrorMessage = "Complete date should be greater than or equals the planned date of the review"
            ClientValidationFunction="comparePlannedReviewDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="CMPLTDTF4Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "CMPLTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="FollowCommentLabel" class="labeldiv">Follow Up Comments:</div>
            <div id="FollowCommentField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="FLLCOMTxt" runat="server"  CssClass="textbox" Width="390px" Height="90px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="FLLCOMTxtVal" runat="server" ValidationGroup="Action"
            ControlToValidate = "FLLCOMTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
    
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <input id="reviewdate" type="hidden" />
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);

        /* show RAG tooltip */
        if ($("#RAGTooltip").is(":hidden"))
        {
            $("#RAGTooltip").slideDown(800, 'easeOutBounce');
        }

        loadActions(empty);

        $("#refreshaction").bind('click', function () {
            hideAll();
            loadActions(empty);
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

        $("#byTSKNM").bind('click', function () {
            hideAll();

            $("#<%=TSKTTLTxt.ClientID%>").val('');

            $("#TaskTitleContainer").show();
        });

        $("#<%=TSKTTLTxt.ClientID%>").keyup(function () {
            filterByTaskTitle($(this).val(), empty);
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

        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);

          });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });


        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#ActionClose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#<%=ACTEESelect.ClientID%>").bind('click', function ()
        {
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
            $("#<%=EMPCBox.ClientID%>").empty();

            $("#SelectActionee").show();
        });

        $("#closeActionee").bind('click', function ()
        {
            $("#SelectActionee").hide('800');
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

        $("#<%=TRGTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () {
            }
        });

        $("#<%=DLYDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () {
            }
        });

        $("#<%=CMPLTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () {
            }
        });

        $("#save").bind('click', function () {

            var isPageValid = Page_ClientValidate("Action");
            if (isPageValid)
            {
                if (!$("#validation_dialog_action").is(":hidden")) {
                    $("#validation_dialog_action").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {

                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);


                        var TRGTDTParts = getDatePart($("#<%=TRGTDTTxt.ClientID%>").val());
                        var DLYDTParts = getDatePart($("#<%=DLYDTTxt.ClientID%>").val());
                        var COMPLTDTParts = getDatePart($("#<%=CMPLTDTTxt.ClientID%>").val());

                        var action =
                        {
                            ActionID: $("#ACTID").val(),
                            ActionType: $("#<%=ACTTYPCBox.ClientID%>").find('option:selected').text(),
                            Details: $("#<%=ACTDTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTDTLTxt.ClientID%>").val()),
                            Actionee: $("#<%=ACTEETxt.ClientID%>").val(),
                            FollowUpComments: $("#<%=FLLCOMTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=FLLCOMTxt.ClientID%>").val()),
                            TargetClosingDate: new Date(TRGTDTParts[2], (TRGTDTParts[1] - 1), TRGTDTParts[0]),
                            DelayedDate: $("#<%=DLYDTTxt.ClientID%>").val() == '' ? null : new Date(DLYDTParts[2], (DLYDTParts[1] - 1), DLYDTParts[0]),
                            CompleteDate: $("#<%=CMPLTDTTxt.ClientID%>").val() == '' ? null : new Date(COMPLTDTParts[2], (COMPLTDTParts[1] - 1), COMPLTDTParts[0])
                        }
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(action) + "\'}",
                            url: getServiceURL().concat('updateTaskAction'),
                            success: function (data)
                            {
                                $("#SaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    showSuccessNotification(data.d);

                                    $("#cancel").trigger('click');
                                    $("#refreshaction").trigger('click');
                                });
                            },
                            error: function (xhr, status, error)
                            {
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
                $("#validation_dialog_action").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });
    });

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

    function loadActions(empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                url: getServiceURL().concat('loadManagementReviews'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function () {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of all current management review task actions");

                            if (data) {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function ()
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

    function filterByStatus(status, empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat('filterManagementReviewsByStatus'),
                success: function (data)
                {
                    $("#ACTwait").fadeOut(500, function () {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review task actions filtered by the status of the management review");

                            if (data) {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function ()
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
    function filterByMode(mode, empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterManagementReviewsByMode'),
                success: function (data)
                {
                    $("#ACTwait").fadeOut(500, function () {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review task actions filtered by the record mode of the management review");

                            if (data) {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ACTwait").fadeOut(500, function ()
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

    function filterByTaskTitle(task, empty) {
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");


            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'task':'" + task + "'}",
                url: getServiceURL().concat('filterManagementReviewsByTaskTitle'),
                success: function (data) {
                    $("#ACTwait").fadeOut(500, function ()
                    {
                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review task actions filtered by task title");

                            if (data) {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ACTwait").fadeOut(500, function ()
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
    function filterByCategory(category, empty) {
        
        $("#ACTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat('filterManagementReviewsByCategory'),
                success: function (data)
                {
                    $("#ACTwait").fadeOut(500, function () {

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $(this).find('p').text("List of management review task actions filtered by the category of the management review");

                            if (data) {
                                loadActionGridView(data.d, empty);
                            }
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#ACTwait").fadeOut(500, function ()
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

    function filterByDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {

            $("#ACTwait").stop(true).hide().fadeIn(500, function ()
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
                    url: getServiceURL().concat('filterManagementReviewsByDate'),
                    success: function (data) {
                        $("#ACTwait").fadeOut(500, function () {

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(".modulewrapper").css("cursor", "default");

                                $(this).find('p').text("List of management review task actions where the planned review date range between " + startdate.format("dd/MM/yyyy") + " and " + enddate.format("dd/MM/yyyy"));

                                if (data) {
                                    loadActionGridView(data.d, empty);
                                }
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#ACTwait").fadeOut(500, function ()
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
    }


    function loadActionGridView(data, empty) {
        var xmlReviews = $.parseXML(data);

        var row = empty;

        $("#<%=gvActions.ClientID%> tr").not($("#<%=gvActions.ClientID%> tr:first-child")).remove();

        $(xmlReviews).find('Review').each(function (i, review)
        {
            var xmlTasks = $.parseXML($(this).attr('XMLTasks'));

            $(xmlTasks).find("ReviewTask").each(function (j, task) {
                var xmlActions = $.parseXML($(this).attr('XMLActions'));

                $(xmlActions).find("ManagementReviewAction").each(function (k, action) {
                    /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                    var date = new Date();

                    $("td", row).eq(0).html("<img id='icon_" + k + "' src='/RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('ActionID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
                    $("td", row).eq(1).html("<img id='delete_" + k + "' src='/Images/deletenode.png' class='imgButton'/>");
                    $("td", row).eq(2).html("<img id='edit_" + k + "' src='/Images/edit.png' class='imgButton'/>");
                    $("td", row).eq(3).html($(review).attr("ReviewName"));

                    var plannedreviewdate = new Date($(review).attr("PlannedReviewDate"));
                    plannedreviewdate.setMinutes(plannedreviewdate.getMinutes() + plannedreviewdate.getTimezoneOffset());

                    $("td", row).eq(4).html(plannedreviewdate.format("dd/MM/yyyy"));
                    $("td", row).eq(5).html($(task).attr("TaskName"));
                    $("td", row).eq(6).html($(this).attr("ActionType"));

                    var targetclosingdate = new Date($(this).attr("TargetClosingDate"));
                    targetclosingdate.setMinutes(targetclosingdate.getMinutes() + targetclosingdate.getTimezoneOffset());

                    $("td", row).eq(7).html(targetclosingdate.format("dd/MM/yyyy"));

                    var delayeddate = new Date($(this).find("DelayedDate").text());
                    delayeddate.setMinutes(delayeddate.getMinutes() + delayeddate.getTimezoneOffset());

                    $("td", row).eq(8).html($(this).find("DelayedDate").text() == '' ? '' : delayeddate.format("dd/MM/yyyy"));

                    var completedate = new Date($(this).find("CompleteDate").text());
                    completedate.setMinutes(completedate.getMinutes() + completedate.getTimezoneOffset());

                    $("td", row).eq(9).html($(this).find("CompleteDate").text() == '' ? '' : completedate.format("dd/MM/yyyy"));
                    $("td", row).eq(10).html($(this).attr("Actionee"));
                    $("td", row).eq(11).html($(this).attr("IsClosed") == 'true' ? 'Closed' : 'Open');
                    $("td", row).eq(12).html($(review).attr("ModeString"));

                    $("#<%=gvActions.ClientID%>").append(row);

                    $(row).find('img').each(function ()
                    {
                        if ($(this).attr('id').search('edit') != -1)
                        {
                            $(this).bind('click', function ()
                            {
                                /*clear previous data*/
                                resetGroup('.modalPanel');

                                $("#ACTID").val($(action).attr("ActionID"));

                                /*bind the type of the action*/
                                bindActionType($(action).attr("ActionType"));

                                /* temporarily store the planned date of the review record for validation purposes*/
                                $("#reviewdate").val($(review).attr("PlannedReviewDate"));

                                $("#<%=ACTEETxt.ClientID%>").val($(action).attr("Actionee"));
                                $("#<%=TRGTDTTxt.ClientID%>").val(targetclosingdate.format("dd/MM/yyyy"));
                                $("#<%=DLYDTTxt.ClientID%>").val($(action).find("DelayedDate").text() == '' ? '' : delayeddate.format("dd/MM/yyyy"));
                                $("#<%=CMPLTDTTxt.ClientID%>").val($(action).find("CompleteDate").text() == '' ? '' : completedate.format("dd/MM/yyyy"));

                                /*bind the details of the finding*/
                                if ($(action).attr("Details") == '') {
                                    addWaterMarkText('Brief Description of the Action', '#<%=ACTDTLTxt.ClientID%>');
                                }
                                else {
                                    if ($("#<%=ACTDTLTxt.ClientID%>").hasClass("watermarktext")) {
                                        $("#<%=ACTDTLTxt.ClientID%>").val('').removeClass("watermarktext");
                                    }

                                    $("#<%=ACTDTLTxt.ClientID%>").val($("#<%=ACTDTLTxt.ClientID%>").html($(action).attr("Details")).text());
                                }

                                if ($(action).attr("FollowUpComments") == '') {
                                    addWaterMarkText('Follow up Comment in the Support of the Action', '#<%=FLLCOMTxt.ClientID%>');

                                }
                                else
                                {
                                    if ($("#<%=FLLCOMTxt.ClientID%>").hasClass("watermarktext")) {
                                        $("#<%=FLLCOMTxt.ClientID%>").val('').removeClass("watermarktext");
                                    }
                                    $("#<%=FLLCOMTxt.ClientID%>").val($("#<%=FLLCOMTxt.ClientID%>").html($(action).attr("FollowUpComments")).text());
                                }

                               
                                if ($(review).attr('ReviewStatus') == 'Completed' || $(review).attr('ReviewStatus') == 'Cancelled') {
                                    $("#ActionTooltip").find('p').text("Changes cannot take place since the management review is " + $(review).attr('ReviewStatus'));

                                    if ($("#ActionTooltip").is(":hidden")) {
                                        $("#ActionTooltip").slideDown(800, 'easeOutBounce');
                                    }

                                    /*disable all modal controls*/
                                    ActivateAll(false);
                                }
                                else if ($(task).attr("IsClosed") == 'true')
                                {
                                    $("#ActionTooltip").find('p').text("Cannot apply changes on the current action since the relevant task is closed");

                                    if ($("#ActionTooltip").is(":hidden")) {
                                        $("#ActionTooltip").slideDown(800, 'easeOutBounce');
                                    }

                                    /*disable all modal controls*/
                                    ActivateAll(false);
                                }
                                else if ($(action).attr("IsClosed") == 'true')
                                {
                                    $("#ActionTooltip").find('p').text("Cannot apply changes on the current action since it is closed");

                                    if ($("#ActionTooltip").is(":hidden")) {
                                        $("#ActionTooltip").slideDown(800, 'easeOutBounce');
                                    }

                                    /*disable all modal controls*/
                                    ActivateAll(false);
                                }
                                else
                                {
                                    $("#ActionTooltip").find('p').text("Note: The planned management review date for this action is on " + new Date($(review).attr("PlannedReviewDate")).format("dd/MM/yyyy"));

                                    if ($("#ActionTooltip").is(":hidden")) {
                                        $("#ActionTooltip").slideDown(800, 'easeOutBounce');
                                    }

                                    /*enable all modal controls for editing*/
                                    ActivateAll(true);
                                }

                                $("#<%=alias.ClientID%>").trigger('click');
                            });
                        }
                        else if ($(this).attr('id').search('delete') != -1) {
                            $(this).bind('click', function () {
                                removeReviewAction(parseInt($(action).attr('ActionID')), empty);
                            });
                        }
                    });

                    row = $("#<%=gvActions.ClientID%> tr:last-child").clone(true);
                });
            });
        });
    }

    function bindActionType(value) {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadTaskActionType"),
            success: function (data) {
                var xml = $.parseXML(data.d);

                bindComboboxXML(xml, 'TaskActionType', 'TypeName', value, '#<%=ACTTYPCBox.ClientID%>');
            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                showErrorNotification(r.Message);
            }
        });
    }
    function removeReviewAction(ID, empty) {
        var result = confirm("Are you sure you would like to remove the current action?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'actionID':'" + ID + "'}",
                url: getServiceURL().concat('removeTaskAction'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    $("#refreshaction").trigger('click');
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
