<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ApproveProblem.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ApproveProblem" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper"> 
     <div id="CCNApproval_Header" class="moduleheader">CCN Approval</div>

    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
   
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byPRM">Filter by Problem Title</li>
                <li id="byAPPRSTS">Filter by Approval Status</li>
                <li id="byPRMTYP">Filter by Problem Type</li>
                <li id="byORGIDT">Filter by Origination Date</li>
                <li id="byPRMRTCAUS">Filter by Root Cause</li>
            </ul>
        </div>
    </div>

    <div id="ProblemTitleContainer" class="filter">
        <div id="ProblemNameLabel" class="filterlabel">Title:</div>
        <div id="ProblemNameField" class="filterfield">
            <asp:TextBox ID="PRMNMTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>

    <div id="StartdateContainer" class="filter">
        <div id="StartDateLabel" class="filterlabel">Origination Date:</div>
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

    <div id="RootCauseContainer"class="filter">
        <div id="RootCauseLabel" class="filterlabel">Root Cause:</div>
        <div id="RootCauseField" class="filterfield">
            <asp:DropDownList ID="RTCUSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RTCUS_LD" class="control-loader"></div>
    </div>

    <div id="APPStatusContainer" class="filter">
        <div id="APPStatusLabel" class="filterlabel">Approval Status:</div>
        <div id="APPStatusField" class="filterfield">
            <asp:DropDownList ID="APPSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="APPSTSF_LD" class="control-loader"></div>
    </div>

    <div id="ProblemTypeContainer" class="filter">
        <div id="ProblemTypeFLabel" class="filterlabel">Problem Type:</div>
        <div id="ProblemtypeFField" class="filterfield">
            <asp:DropDownList ID="PRMTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="PRMTYPF_LD" class="control-loader"></div>
    </div>

    <div id="ApprovalTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
        <p></p>
    </div>	
     
    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="EmployeeLabel" class="labeldiv">Employee Name:</div>
        <div id="EmployeeField" class="fielddiv" style="width:170px">
            <asp:TextBox ID="EMPTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
        </div>
    </div>

    <div id="PRMwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvProblems" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
        GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
        <Columns>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="CaseNo" HeaderText="Case No." />
            <asp:BoundField DataField="PRMTitle" HeaderText="Problem Title" />
            <asp:BoundField DataField="PRMType" HeaderText="Problem Type" />
            <asp:BoundField DataField="AFFCTPRTYType" HeaderText="Affected Party Type" />
            <asp:BoundField DataField="Originator" HeaderText="Originator" />
            <asp:BoundField DataField="OriginationDate" HeaderText="Origination Date" />
            <asp:BoundField DataField="TargetCloseDate" HeaderText="Target Close Date" />
            <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
            <asp:BoundField DataField="Status" HeaderText="Status" />
            <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
        </Columns>
        </asp:GridView>
    </div>
 
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>


    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Problem Record Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="ProblemTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>	
   
        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <ul id="tabul" style="margin-top:30px;">
            <li id="Details" class="ntabs">Main Information</li>
            <li id="Causes" class="ntabs">Related Causes</li>
            <li id="Additional" class="ntabs">Additional information</li>
            <li id="Supplementary" class="ntabs">Supplementary information</li>
            <li id="Approval" class="ntabs">Approval Details</li>
        </ul>
        <div id="DetailsTB" class="tabcontent" style="display:none; height:450px;">
                
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="CaseNoLabel" class="requiredlabel">Case No:</div>
                <div id="CaseNoField" class="fielddiv">
                    <asp:TextBox ID="CaseNoTxt" runat="server" CssClass="readonly" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemTypeLabel" class="requiredlabel">Problem Type:</div>
                <div id="ProblemTypeField" class="fielddiv">
                    <asp:TextBox ID="PRBLTYPTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                </div>
             </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemTitleLabel" class="requiredlabel">Problem Title:</div>
                <div id="ProblemTitleField" class="fielddiv">
                    <asp:TextBox ID="PRMTTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="290px"></asp:TextBox>
                </div>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AffectedPartyTypeLabel" class="requiredlabel">Affected Party Type:</div>
                <div id="AffectedPartyTypeField" class="fielddiv">
                    <asp:TextBox ID="AFFPRTTYPTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="240px"></asp:TextBox>
                </div>
            </div>
        
            <div id="external" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AffectedPartyLabel" class="labeldiv">Affected Party:</div>
                <div id="AffectedPartyField" class="fielddiv">
                    <asp:TextBox ID="AFFPRTYTxt" runat="server" CssClass="readonly" Width="290px" ReadOnly="true"></asp:TextBox>
                </div>

            </div>

            <div id="internal" class="selectionfield" style="float:left; width:100%; height:20px; margin-top:15px; display:none;"">
                <div id="AffectedDepartmentLabel" class="labeldiv">Affected Department:</div>
                <div id="AffectedDepartmentField" class="fielddiv">
                    <asp:TextBox ID="AFFORGUNTTxt" runat="server" CssClass="readonly" Width="290px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

   
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AffectedDocumentLabel" class="labeldiv">Affected Document:</div>
                <div id="AffectedDocumentField" class="fielddiv">
                    <asp:TextBox ID="AFFDOCTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

               
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemDescriptionLabel" class="labeldiv">Problem Description:</div>
                <div id="ProblemDescriptionField" class="fielddiv">
                    <asp:TextBox ID="PRMDESCTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:135px;">
                <div id="ProblemStatusLabel" class="requiredlabel">Problem Status:</div>
                <div id="ProblemStatusField" class="fielddiv">
                    <asp:TextBox ID="PRMSTSTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>   
            </div>
        </div>      
        <div id="CausesTB" class="tabcontent" style="display:none;height:450px;">
        
            <div id="treemenu" class="menucontainer" style="border: 1px solid #052556; overflow:visible;height:370px;width:29%;">
                <div id="cause_LD" class="control-loader"></div> 
                <div id="causetree"></div>
            </div>
            <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; overflow:visible;height:370px;width:67%;">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="CUSTitleLabel" class="requiredlabel">Cause Name:</div>
                    <div id="CUSTitleField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="CUSTTLTxt" runat="server" CssClass="textbox treefield" Width="240px"></asp:TextBox>
                    </div>
                </div>
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ParentCauseLabel" class="labeldiv">Related to Cause:</div>
                    <div id="ParentCauseField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="PCUSTxt" runat="server" ReadOnly="true" CssClass="readonly" Width="240px"></asp:TextBox>
                    </div>
                </div>
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="CUSDetailsLabel" class="labeldiv">More Information</div>
                    <div id="CUSDetailsField" class="fielddiv" style="width:400px; height:190px;">
                        <asp:TextBox ID="CUSDTLTxt" runat="server" CssClass="textbox treefield" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                    </div>
                </div>
            </div>  
        </div>
        <div id="AdditionalTB" class="tabcontent" style="display:none;height:450px;">
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemOriginatorLabel" class="requiredlabel">Problem Originator:</div>
                <div id="ProblemOriginatorField" class="fielddiv">
                    <asp:TextBox ID="ORGTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OwnerLabel" class="requiredlabel">Problem Owner:</div>
                <div id="OwnerField" class="fielddiv">
                    <asp:TextBox ID="OWNRTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
     
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ExecutiveLabel" class="requiredlabel">Problem Executive:</div>
                <div id="ExecutiveField" class="fielddiv">
                    <asp:TextBox ID="EXECTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProblemRaiseDateLabel" class="requiredlabel">Raise Date:</div>
                <div id="ProblemRaiseDateField" class="fielddiv">                
                    <asp:TextBox ID="RISDTTxt" runat="server" CssClass="readonly" Width="140px" ReadOnly="true" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>        
            </div>   
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OriginationDateLabel" class="labeldiv">Origination Date:</div>
                <div id="OriginationDateField" class="fielddiv">
                    <asp:TextBox ID="ORGDTTxt" runat="server" CssClass="readonly" Width="140px" ReadOnly="true" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
             </div> 
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="TRGTCloseDateLabel" class="requiredlabel">Target Close Date:</div>
                <div id="TRGTCloseDateField" class="fielddiv">
                    <asp:TextBox ID="TRGTCLSDTTxt" runat="server" CssClass="readonly" Width="140px" ReadOnly="true" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ACTUCloseDateLabel" class="labeldiv">Actual Close Date:</div>
                <div id="ACTUCloseDateField" class="fielddiv">
                    <asp:TextBox ID="ACTCLSDTTxt" runat="server" Width="140px" CssClass="readonly" ReadOnly="true" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>     
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ReviewReportIssueDateLabel" class="labeldiv">Review Report Issue Date:</div>
                <div id="ReviewReportIssueDateField" class="fielddiv">
                    <asp:TextBox ID="REVREPISSDTTxt" runat="server" Width="140px" CssClass="readonly" ReadOnly="true" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AdditionalRemarksLabel" class="labeldiv">Additional Remarks:</div>
                <div id="AdditionalRemarksField" class="fielddiv">
                    <asp:TextBox ID="RMRKTxt" runat="server" CssClass="readonly" Width="390px" Height="120px" ReadOnly="true" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
        </div>
        <div id="SupplementaryTB" class="tabcontent" style="display:none; height:450px;">
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="ReportedFromLabel" class="labeldiv">Reported From:</div>
                <div id="ReportedFromField" class="fielddiv">
                    <asp:TextBox ID="REPFRMTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RelatedORGLabel" class="labeldiv">Source of Problem:</div>
                <div id="RelatedORGField" class="fielddiv">
                    <asp:TextBox ID="RELORGTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="SeverityLabel" class="labeldiv">Severity Criteria:</div>
                <div id="SeverityField" class="fielddiv">
                    <asp:TextBox ID="SVRTTxt" runat="server" CssClass="readonly" Width="240px" ReadOnly="true"></asp:TextBox>
                </div>
            </div>       
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskListLabel" class="labeldiv">Assciated Risk List:</div>
                <div id="RiskListField" class="fielddiv">
                    <div id="RSKCHK" class="checklist"></div>
                </div>
            </div>
        </div>
        <div id="ApprovalTB" class="tabcontent" style="display:none; height:400px;">

            <div id="validation_dialog_approval" class="validation" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Approval" />
            </div>

            <input id="MEMID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="ApprovalStatusLabel" class="requiredlabel">Decision:</div>
                <div id="ApprovalStatusField" class="fielddiv">
                    <asp:DropDownList ID="APPSTSCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="APPR_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="APPSTSTxtVal" runat="server" Display="None" ControlToValidate="APPSTSCBox" ErrorMessage="Select approval status" ValidationGroup="Approval"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="APPSTSVal" runat="server" ControlToValidate="APPSTSCBox" CssClass="validator"
                Display="None" ErrorMessage="Select approval status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="Approval"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="JustificationLabel" class="labeldiv">Justification:</div>
                <div id="JustificationField" class="fielddiv">
                    <asp:TextBox ID="JUSTTxt" runat="server"  CssClass="textbox" Width="380px" Height="160px" TextMode="MultiLine"></asp:TextBox>
                </div>

                 <asp:CustomValidator id="JUSTTxtVal" runat="server" ValidationGroup="Approval"
                ControlToValidate = "JUSTTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
            
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);

        var employee = $("#<%=EMPTxt.ClientID%>").val().split(' ');

        $("#ApprovalTooltip").stop(true).hide().fadeIn(800, function ()
        {
            $(this).find('p').html("List of problems associated with the current user account");
        });

        // load all problem records based upon login name 
        loadProblemsByAPPMember(empty, employee);

        $("#deletefilter").bind('click', function () {
            hideAll();

            loadProblemsByAPPMember(empty, employee);
        });

        $("#refresh").bind('click', function () {
            hideAll();

            loadProblemsByAPPMember(empty, employee);
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });


        $("#byORGIDT").bind('click', function ()
        {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

              $("#StartdateContainer").show();
        });

        $("#byPRMRTCAUS").bind('click', function () {
            hideAll();

            $("#RootCauseContainer").show();

            loadRootCauses("#RTCUS_LD", "#<%=RTCUSCBox.ClientID%>");
        });

        // filter by approval status
        $("#byAPPRSTS").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadApprovalStatus', "#<%=APPSTSFCBox.ClientID%>", "#APPSTSF_LD");

            $("#APPStatusContainer").show();
        });

        /* filter by problem type */
        $("#byPRMTYP").bind('click', function ()
        {
            hideAll();
            loadProblemType();
            $("#ProblemTypeContainer").show();

        });

        $("#byPRM").bind('click', function ()
        {
            hideAll();
            /*Clear text value*/
            $("#<%=PRMNMTxt.ClientID%>").val('');

            $("#ProblemTitleContainer").show();

        });

        /*filter by start date range*/
        $("#<%=FDTTxt.ClientID%>").keyup(function ()
        {
            loadProblemsByAPPMemberNDDaterange(empty, employee, $(this).val(), $("#<%=TDTTxt.ClientID%>").val());
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function ()
        {
            loadProblemsByAPPMemberNDDaterange(empty, employee, $("#<%=FDTTxt.ClientID%>").val(), $(this).val());
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                loadProblemsByAPPMemberNDDaterange(empty, employee, date, $("#<%=TDTTxt.ClientID%>").val());
            }
        });


        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                loadProblemsByAPPMemberNDDaterange(empty, employee, $("#<%=FDTTxt.ClientID%>").val(), date);
            }
        });


        /*filter by problem title*/
        $("#<%=PRMNMTxt.ClientID%>").keyup(function ()
        {
            loadProblemsByAPPMemberNDTitle(empty, employee, $(this).val());
        });

        $("#<%=APPSTSFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                loadProblemsByAPPMemberNDAPPStatus(empty, employee, $(this).val());
            }
        });

        $("#<%=PRMTYPFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                loadProblemsByAPPMemberNDType(empty, employee, $(this).val());
            }
        });

   
        $("#<%=RTCUSCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var vals = $(this).val().split(" ");

                loadProblemsByAPPMemberNDRoot(empty, employee, vals[1]);
            }
        });

        /*bind the details of the selected node*/
        $('#causetree').bind('tree.select', function (event)
        {
            var node = event.node;

            if (node != null && node != false)
            {
                $("#<%=CUSTTLTxt.ClientID%>").val(node.name);
                $("#<%=PCUSTxt.ClientID%>").val(node.parent.name);
                $("#<%=CUSDTLTxt.ClientID%>").html(node.Description).text();
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('Approval');
            if (isPageValid)
            {
                if (!$("#validation_dialog_approval").is(":hidden"))
                {
                    $("#validation_dialog_approval").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        var member =
                        {
                            MemberID: $("#MEMID").val(),
                            ApprovalStatusString: $("#<%=APPSTSCBox.ClientID%>").val(),
                            ApprovalRemarks: $("#<%=JUSTTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=JUSTTxt.ClientID%>").val())
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            url: getServiceURL().concat("updateProblemApproval"),
                            data: "{\'json\':\'" + JSON.stringify(member) + "\'}",
                            success: function (data) {
                                $("#SaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    alert(data.d);

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
            }
            else {
                $("#validation_dialog_approval").stop(true).hide().fadeIn(500, function ()
                {
                    
                    navigate('Approval');
                });
            }
        });

        $("#tabul li").bind("click", function () {
            navigate($(this).attr("id"));
        })
    });

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function loadRootCauses(loader, control) {
        $(loader).stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRootCauses"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Causes', 'name', $(control));
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

    function loadProblemType() {
        $("#PRMTYPF_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemType"),
                success: function (data) {
                    $("#PRMTYPF_LD").fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $("#<%=PRMTYPFCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMTYPF_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProblemsByAPPMemberNDDaterange(empty, employee, start, end)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);
        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {

            $("#PRMwait").stop(true).hide().fadeIn(500, function ()
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
                    url: getServiceURL().concat("loadProblemsByApprovalMemberNDDaterange"),
                    data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "',\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    success: function (data) {
                        $("#PRMwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#PRMwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }

    function loadProblemsByAPPMemberNDTitle(empty, employee, title) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemsByApprovalMemberNDTitle"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "','title':'" + status + "'}",
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProblemsByAPPMemberNDAPPStatus(empty, employee, status)
    {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemsByApprovalMemberNDApprovalStatus"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "','status':'" + status + "'}",
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }


    function loadProblemsByAPPMemberNDRoot(empty, employee, cause)
    {
        $("#PRMwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemsByApprovalMemberNDRootCause"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "','causeID':'" + cause + "'}",
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProblemsByAPPMemberNDType(empty, employee, type)
    {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemsByApprovalMemberNDType"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "','type':'" + type + "'}",
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProblemsByAPPMember(empty, employee)
    {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProblemsByApprovalMember"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "'}",
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    
    function loadGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvProblems.ClientID%> tr").not($("#<%=gvProblems.ClientID%> tr:first-child")).remove();

        $(xml).find("Problem").each(function (index, value)
        {
            $("td", row).eq(0).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");
      
            $("td", row).eq(1).html($(this).attr("CaseNo"));
            $("td", row).eq(2).html($(this).attr("Title"));
            $("td", row).eq(3).html($(this).attr("ProblemType"));
            $("td", row).eq(4).html($(this).attr("AffectedPartyType"));
            $("td", row).eq(5).html($(this).attr("Originator"));
            $("td", row).eq(6).html($(this).find("OriginationDate").text() == '' ? '' : new Date($(this).find("OriginationDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(7).html(new Date($(this).attr("TargetCloseDate")).format("dd/MM/yyyy"));
            $("td", row).eq(8).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(9).html($(this).attr("ProblemStatus"));
            $("td", row).eq(10).html($(this).attr("ModeString"));

            $("#<%=gvProblems.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        /*clear all fields*/
                        resetGroup('.modalPanel');

                        /*bind case number of the problem*/
                        $("#<%=CaseNoTxt.ClientID%>").val($(value).attr("CaseNo"));

                        /*bind problem type*/
                        $("#<%=PRBLTYPTxt.ClientID%>").val($(value).attr("ProblemType"));

                        /*bind problem title*/
                        $("#<%=PRMTTxt.ClientID%>").val($(value).attr("Title"));

                        /*bind affected party title*/
                        $("#<%=AFFPRTTYPTxt.ClientID%>").val($(value).attr("AffectedPartyType"));

                        /*bind affected document*/
                        $("#<%=AFFDOCTxt.ClientID%>").val($(value).attr("AffectedDocument"));

                        /*bind problem details*/
                        $("#<%=PRMDESCTxt.ClientID%>").html($(value).attr("Details")).text();

                        /*bind problem originator*/
                        $("#<%=ORGTxt.ClientID%>").val($(value).attr("Originator"));

                        /*bind problem owner*/
                        $("#<%=OWNRTxt.ClientID%>").val($(value).attr("Owner"));

                        /*bind problem executive*/
                        $("#<%=EXECTxt.ClientID%>").val($(value).attr("Executive"));

                        /*bind problem status*/
                        $("#<%=PRMSTSTxt.ClientID%>").val($(value).attr("ProblemStatus"));

                        switch ($(value).attr("AffectedPartyType"))
                        {
                            case "External":
                                $("#external").stop(true).hide().fadeIn(500, function () {
                                    /* bind customer name*/
                                    $("#<%=AFFPRTYTxt.ClientID%>").val($(value).attr('ExternalParty'));
                                });

                                $("#internal").fadeOut(500, function ()
                                { });

                                break;
                            case "Internal":
                                $("#internal").stop(true).hide().fadeIn(500, function ()
                                {
                                    /*load the organization unit if the affected party is of type internal*/
                                    $("#<%=AFFORGUNTTxt.ClientID%>").val($(value).attr("AffectedDepartment"));
                                });

                                $("#external").fadeOut(500, function () {});
                                break;
                            case "None":
                                $(".selectionfield").each(function () {
                                    $(this).fadeOut(500, function () {
                                    });
                                });
                                break;
                        }

                        /* bind raise date*/
                        $("#<%=RISDTTxt.ClientID%>").val(new Date($(value).attr("RaiseDate")).format("dd/MM/yyyy"));

                        /* bind origination date*/
                        $("#<%=ORGDTTxt.ClientID%>").val($(value).find("OriginationDate").text() == '' ? '' : new Date($(value).find("OriginationDate").text()).format("dd/MM/yyyy"));

                        /* bind target close date*/
                        $("#<%=TRGTCLSDTTxt.ClientID%>").val(new Date($(value).attr("TargetCloseDate")).format("dd/MM/yyyy"));

                        /* bind actual close date*/
                        $("#<%=ACTCLSDTTxt.ClientID%>").val($(value).find("ActualCloseDate").text() == '' ? '' : new Date($(value).find("ActualCloseDate").text()).format("dd/MM/yyyy"));

                        /* bind review report issue date*/
                        $("#<%=REVREPISSDTTxt.ClientID%>").val($(value).find("ReviewReportIssueDate").text() == '' ? '' : new Date($(value).find("ReviewReportIssueDate").text()).format("dd/MM/yyyy"));

                        /*bind reported from department*/
                        $("#<%=REPFRMTxt.ClientID%>").val($(value).attr("ReportDepartment"));

                        /*bind source of problem department*/
                        $("#<%=RELORGTxt.ClientID%>").val($(value).attr("ProblemRelatedDepartment"));

                        /*bind severity value*/
                        $("#<%=SVRTTxt.ClientID%>").val($(value).attr('Severity'));

                        $("#<%=RMRKTxt.ClientID%>").html($(value).attr("Remarks")).text();

                        /*bind risk subcategories*/
                        loadXMLSubcategories($(value).attr('XMLSubcategories'));

                        /*bind causes*/
                        bindCauses($(value).attr("ProblemID"));

                        /*Deactivate tree fields*/
                        ActivateTreeField(false);

                        var xmlMember = $.parseXML($(value).attr('MemberString'));

                        /*Bind approval member ID*/
                        $("#MEMID").val($(xmlMember).find('ApprovalMember').attr('MemberID'));

                        /*bind approval member details */
                        bindComboboxAjax('loadApprovalStatus', "#<%=APPSTSCBox.ClientID%>", $(xmlMember).find('ApprovalMember').attr("ApprovalStatus"), "#APPR_LD");

                        if ($(xmlMember).find('ApprovalMember').attr("ApprovalRemarks") == '')
                        {
                            addWaterMarkText('Justification for the decision', '#<%=JUSTTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=JUSTTxt.ClientID%>").hasClass("watermarktext"))
                            {
                                $("#<%=JUSTTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=JUSTTxt.ClientID%>").html($(xmlMember).find('ApprovalMember').attr("ApprovalRemarks")).text();
                        }

                        if ($(value).attr('ProblemStatus') == 'Closed' || $(value).attr('ProblemStatus') == 'Cancelled' || $(value).attr('ProblemStatus') == 'Open')
                        {
                            $("#ProblemTooltip").find('p').text("Your decision cannot be altered since the problem is " + $(value).attr('ProblemStatus'));

                            if ($("#ProblemTooltip").is(":hidden")) {
                                $("#ProblemTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else
                        {
                            /*enable all modal controls for editing*/
                            ActivateAll(true);

                            $("#ProblemTooltip").hide();
                        }

                        /*set default tab navigation*/
                        navigate("Details");

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }
            });
            row = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);
        });
    }

    function loadXMLSubcategories(data) {
        var subcategory = $.parseXML(data);

        /*clear all previous values*/
        $("#RSKCHK").empty();

        $(subcategory).find('RiskSubcategory').each(function (index, value) {
            var html = '';
            html += "<div class='checkitem'>";
            html += "<input type='checkbox' id='" + $(this).attr('SubCategoryID') + "' name='checklist' value='" + $(this).attr('Status') + "'/><div class='checkboxlabel'>" + $(this).attr('SubCategory') + "</div>";
            html += "</div>";

            $("#RSKCHK").append(html);

            $("#" + $(this).attr('SubCategoryID')).prop('checked', true);

            $("#" + $(this).attr('SubCategoryID')).change(function () {
                if ($(this).is(":checked") == false) {
                    if ($(this).val() == 1) {
                        $(this).val(4);
                    }
                }
                else {
                    if ($(this).val() == 4) {
                        $(this).val(1);
                    }
                }
            });

        });
    }

    function bindCauses(ID) {
        $("#cause_LD").stop(true).hide().fadeIn(500, function () {
            /*Deactivate all textboxes in the causes*/
            ActivateTreeField(false);

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'problemID':'" + ID + "'}",
                url: getServiceURL().concat('loadProblemCauses'),
                success: function (data) {
                    $("#cause_LD").fadeOut(500, function () {
                        var existingjson = $('#causetree').tree('toJson');
                        if (existingjson == null) {
                            $('#causetree').tree(
                            {
                                data: $.parseJSON(data.d),
                                slide: true,
                                autoOpen: true
                            });
                        }
                        else {
                            $('#causetree').tree('loadData', $.parseJSON(data.d));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#cause_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
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

    function ActivateAll(isactive)
    {
        if (isactive == false) {
            $(".modalPanel").children().each(function () {

                $(this).find(".textbox").each(function () {
                    $(this).removeClass("textbox");
                    $(this).addClass("readonlycontrolled");
                    $(this).attr('readonly', true);
                });

                $(this).find(".combobox").each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.imgButton').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.searchactive').each(function () {
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

                $(this).find('.combobox').each(function () {
                    $(this).attr('disabled', false);
                });


                $(this).find('.imgButton').each(function () {
                    $(this).attr('disabled', false);
                });
            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }

    function ActivateTreeField(isactive) {
        if (isactive == false) {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("textbox");
                $(this).addClass("readonly");
                $(this).attr('readonly', true);
            });
        }
        else {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("readonly");
                $(this).addClass("textbox");
                $(this).attr('readonly', false);
            });
        }
    }

</script>
</asp:Content>
