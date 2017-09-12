<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageProject.aspx.cs" Inherits="QMSRSTools.ProjectManagement.ManageProject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">     

    <div id="Project_Header" class="moduleheader">Manage Projects</div>

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
    
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byName">Filter by Project Title</li>
                <li id="byLeader">Filter by Project Leader</li>
                <li id="byStatus">Filter by Project Status</li>
                <li id="byStartDate">Filter by Project Start Date</li>
            </ul>
        </div>

        <div id="NameContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ProjectNameLabel" style="width:100px;">Project Title:</div>
            <div id="ProjectNameField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="PROJNMFTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
            </div>
        </div>
    
        <div id="LeaderContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="LeaderLabel" style="width:100px;">Project Leader:</div>
            <div id="LeaderField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="PROJLDRFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="PROJLDRF_LD" class="control-loader"></div>
        </div>
    
        <div id="StatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ProjectStatusFilterLabel" style="width:100px;">Project Status:</div>
            <div id="ProjectStatusFilterField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="PROJSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="PROJSTSF_LD" class="control-loader"></div>
        </div>

        <div id="ProjectDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
            <div id="ProjectDateLabel" style="width:120px;">Project Start Date:</div>
            <div id="ProjectDateField" style="width:270px; left:0; float:left;">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>
    </div>

    <div id="PROJwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    
    <div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvProjects" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
        GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="PROJNo" HeaderText="Project No." />
                <asp:BoundField DataField="PROJName" HeaderText="Project Title" />
                <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                <asp:BoundField DataField="PlannedCloseDate" HeaderText="Planned Close Date" />
                <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
                <asp:BoundField DataField="Leader" HeaderText="Project Leader" />
                <asp:BoundField DataField="Value" HeaderText="Project Value" /> 
                <asp:BoundField DataField="Cost" HeaderText="Project Cost" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
            </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    
    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Project Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="PRJTooltip" class="tooltip">
            <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_general" class="validationcontainer" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="ProjectNoLabel" class="labeldiv">Project No:</div>
            <div id="ProjectNoField" class="fielddiv" style="width:300px;">
                <asp:TextBox ID="PROJNoTxt" runat="server" CssClass="readonly" ReadOnly="true"></asp:TextBox>
            </div>
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectTitleLabel" class="requiredlabel">Project Title:</div>
            <div id="ProjectTitleField" class="fielddiv" style="width:300px;">
                <asp:TextBox ID="PROJNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
            </div>
            <div id="PROJNMlimit" class="textremaining"></div>  
          
            <asp:RequiredFieldValidator ID="PROJNMTxtVal" runat="server" Display="None" ControlToValidate="PROJNMTxt" ErrorMessage="Enter the title of the project" ValidationGroup="General"></asp:RequiredFieldValidator>

            <asp:CustomValidator id="PROJNMFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "PROJNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectDescriptionLabel" class="labeldiv">Project Description:</div>
            <div id="ProjectDescriptionField" class="fielddiv" style="width:400px; height:122px;">
                <asp:TextBox ID="PROJDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
        
            <asp:CustomValidator id="PROJDESCTxtVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "PROJDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:122px;">
            <div id="ProjectLabel" class="requiredlabel">Project Leader:</div>
            <div id="ProjectField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="PROJLDRCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="LDR_LD" class="control-loader"></div>

            <span id="PROJLDRSelect" class="searchactive" style="margin-left:10px;" runat="server"></span>
   
            <asp:RequiredFieldValidator ID="PROJLDRCBoxTxtVal" runat="server" Display="None" ControlToValidate="PROJLDRCBox" ErrorMessage="Select the leader of the project" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <asp:CompareValidator ID="PROJLDRCBoxVal" runat="server" Display="None" ControlToValidate="PROJLDRCBox" ValidationGroup="General"
            ErrorMessage="Select the leader of the project" Operator="NotEqual" Style="position: static"
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
                <div id="ORG_LD" class="control-loader"></div>
            </div>
        </div>

       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
            <div id="StartDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="STRTDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            
            <asp:RequiredFieldValidator ID="STRTDTTxtVal" runat="server" Display="None" ControlToValidate="STRTDTTxt" ErrorMessage="Enter the start date of the project"  ValidationGroup="General"></asp:RequiredFieldValidator>  
            
            <asp:RegularExpressionValidator ID="STRTDTTxtFVal" runat="server" ControlToValidate="STRTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>

            <asp:CustomValidator id="STRTDTTxtF3Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "STRTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div> 

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="PlannedCloseDateLabel" class="requiredlabel">Planned Close Date:</div>
            <div id="PlannedCloseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="PLNNDCLSDTTxt" runat="server" Width="140px" CssClass="date" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            <asp:RequiredFieldValidator ID="PLNCLSDTTxtVal" runat="server" Display="None" ControlToValidate="PLNNDCLSDTTxt" ErrorMessage="Enter the planned close date of the project"  ValidationGroup="General"></asp:RequiredFieldValidator>  
            
            <asp:RegularExpressionValidator ID="PLNCLSDTFVal" runat="server" ControlToValidate="PLNNDCLSDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" CssClass="validator" ValidationGroup="General"></asp:RegularExpressionValidator>  
            
            <asp:CompareValidator ID="PLNCLSDTF2Val" runat="server" ControlToCompare="STRTDTTxt"  ValidationGroup="General"
            ControlToValidate="PLNNDCLSDTTxt" ErrorMessage="Planned close date should be greater or equals start date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator> 

            <asp:CustomValidator id="PLNNDCLSDTF3Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "PLNNDCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ActualCloseDateLabel" class="labeldiv">Actual Close Date:</div>
            <div id="ActualCloseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ACTCLSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            
            <asp:RegularExpressionValidator ID="ACTCLSDTTxtVal" runat="server" ControlToValidate="ACTCLSDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  
            
            <asp:CompareValidator ID="ACTCLSDTTxtFVal" runat="server" ControlToCompare="STRTDTTxt"  ValidationGroup="General"
            ControlToValidate="ACTCLSDTTxt" ErrorMessage="Actual close date should be greater or equals start date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator> 

            <asp:CustomValidator id="ACTCLSDTTxtF2Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "ACTCLSDTTxt" Display="None" ErrorMessage = "Actual close date shouldn't be in future"
            ClientValidationFunction="comparePast">
            </asp:CustomValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectValueLabel" class="requiredlabel">Project Value:</div>
            <div id="ProjectValueField" class="fielddiv" style="width:240px">
                <asp:TextBox ID="PROJValTxt" runat="server" CssClass="textbox" Width="150px"></asp:TextBox>
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:DropDownList ID="CURRCBox" AutoPostBack="false" runat="server" Width="60px" CssClass="combobox">
                </asp:DropDownList>     
            </div>     
            <div id="CURR_LD" class="control-loader"></div>
            
            <asp:RequiredFieldValidator ID="PROJValTxtVal" runat="server" Display="None" ControlToValidate="PROJValTxt" ErrorMessage="Enter the value of the project" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <asp:RegularExpressionValidator ID="PROJValTxtFval" runat="server" ControlToValidate="PROJValTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]+)?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
            
            <asp:RequiredFieldValidator ID="CURRCBoxTxtVal" runat="server" Display="None" ControlToValidate="CURRCBox" ErrorMessage="Select currency" ValidationGroup="General"></asp:RequiredFieldValidator>         
            
            <asp:CompareValidator ID="CURRCBoxVal" runat="server" ControlToValidate="CURRCBox" ValidationGroup="General"
            Display="None" ErrorMessage="Select currency" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectCostLabel" class="requiredlabel">Project Cost:</div>
            <div id="ProjectCostField" class="fielddiv" style="width:240px">
                <asp:TextBox ID="PROJCSTTxt" runat="server" CssClass="textbox" Width="150px"></asp:TextBox>
                <asp:Label ID="Label2" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="PROJCSTCURR" runat="server" CssClass="readonly" ReadOnly="true" Width="50px"></asp:TextBox>
            </div>     
            <asp:RequiredFieldValidator ID="PROJCSTTxtVal" runat="server" Display="None" ControlToValidate="PROJCSTTxt" ErrorMessage="Enter the cost of the project" ValidationGroup="General"></asp:RequiredFieldValidator>
      
            <asp:RegularExpressionValidator ID="PROJCSTTxtFVal" runat="server" ControlToValidate="PROJCSTTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]+)?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CostAtCompletionLabel" class="labeldiv">Cost At Completion:</div>
            <div id="CostAtCompletionField" class="fielddiv" style="width:240px">
                <asp:TextBox ID="CSTCOMPLTxt" runat="server" CssClass="textbox" Width="150px"></asp:TextBox>
                <asp:Label ID="Label3" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="CSTCOMPLCURR" runat="server" CssClass="readonly" ReadOnly="true" Width="50px"></asp:TextBox>
            </div>     
            
            <asp:RegularExpressionValidator ID="CSTCOMPLTxtFVal" runat="server" ControlToValidate="CSTCOMPLTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]+)?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectStatusLabel" class="requiredlabel">Project Status:</div>
            <div id="ProjectStatusField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="PRJSTSCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="PROJSTS_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="PRJSTSCBoxtxtVal" runat="server" Display="None" ControlToValidate="PRJSTSCBox" ErrorMessage="Select the status of the project" ValidationGroup="General"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="PRJSTSCBoxVal" runat="server" ControlToValidate="PRJSTSCBox"
            Display="None" ErrorMessage="Select the status of the project" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>
    
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>    	
    </asp:Panel>
</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvProjects.ClientID%> tr:last-child").clone(true);

        loadProjects(empty);

        $("#deletefilter").bind('click', function () {
            hideAll();
            loadProjects(empty);
        });

        $("#refresh").bind('click', function () {
            hideAll();
            loadProjects(empty);
        });

        $("#byName").bind('click', function ()
        {
            hideAll();
            $("#NameContainer").show();

        });

        $("#byLeader").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('getProjectLeaders', "#<%=PROJLDRFCBox.ClientID%>", "#PROJLDRF_LD");

            $("#LeaderContainer").show();
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });


        $("#byStatus").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadProjectStatus', "#<%=PROJSTSFCBox.ClientID%>","#PROJSTSF_LD");

            $("#StatusContainer").show();
        });

        $("#byStartDate").bind('click', function () {
            hideAll();
           
            $("#ProjectDateContainer").show();
        });

        /*show organization unit box when hovering over the leader field cboxes*/
        /*set the position according to mouse x and y coordination*/
        $("#<%=PROJLDRSelect.ClientID%>").mousemove(function (e) {
            showORGDialog(e.pageX, e.pageY);
        });

        /*populate the employees in owner, originator, and executive cboxes*/
        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            loadcontrols.push("#<%=PROJLDRCBox.ClientID%>");
            loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#LDR_LD");

                $("#SelectORG").hide('800');
            });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /*filter projects according to title*/
        $("#<%=PROJNMFTxt.ClientID%>").keyup(function ()
        {
            filterByName($(this).val(), empty);
        });

        /*filter projects according to leader*/
        $("#<%=PROJLDRFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterByLeader($(this).val(), empty);
            }
        });

        /*filter projects according to status*/
        $("#<%=PROJSTSFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {
                filterByStatus($(this).val(), empty);
            }
        });

        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(),empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(),empty);
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date)
            {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#<%=STRTDTTxt.ClientID%>").datepicker(
           {
               inline: true,
               dateFormat: "dd/mm/yy"
           });

        $("#<%=PLNNDCLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy"
        });

        $("#<%=CURRCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                $("#<%=PROJCSTCURR.ClientID%>").val($(this).val());
                $("#<%=CSTCOMPLCURR.ClientID%>").val($(this).val());
            }
        });

        $("#<%=ACTCLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy"
        });

        $("#save").bind('click', function () {
            var isPageValid = Page_ClientValidate('General');
            if (isPageValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        var startdate = getDatePart($("#<%=STRTDTTxt.ClientID%>").val());
                        var target = getDatePart($("#<%=PLNNDCLSDTTxt.ClientID%>").val());
                        var actual = getDatePart($("#<%=ACTCLSDTTxt.ClientID%>").val());
                        var project =
                        {
                            ProjectNo: $("#<%=PROJNoTxt.ClientID%>").val(),
                            ProjectName: $("#<%=PROJNMTxt.ClientID%>").val(),
                            Description: $("#<%=PROJDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=PROJDESCTxt.ClientID%>").val()),
                            ProjectLeader: $("#<%=PROJLDRCBox.ClientID%>").val(),
                            Currency: $("#<%=CURRCBox.ClientID%>").val(),
                            ProjectValue: $("#<%=PROJValTxt.ClientID%>").val(),
                            ProjectCost: $("#<%=PROJCSTTxt.ClientID%>").val(),
                            StartDate: new Date(startdate[2], (startdate[1] - 1), startdate[0]),
                            PlannedCloseDate: new Date(target[2], (target[1] - 1), target[0]),
                            ActualCloseDate: actual == '' ? null : new Date(actual[2], (actual[1] - 1), actual[0]),
                            CostAtCompletion: $("#<%=CSTCOMPLTxt.ClientID%>").val() == '' ? 0 : $("#<%=CSTCOMPLTxt.ClientID%>").val(),
                            ProjectStatusStr: $("#<%=PRJSTSCBox.ClientID%>").val()
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(project) + "\'}",
                            url: getServiceURL().concat('updateProject'),
                            success: function (data)
                            {
                                $("#SaveTooltip").fadeOut(500, function ()
                                {
                                    ActivateSave(true);

                                    alert(data.d);

                                    $("#cancel").trigger('click');
                                    loadProjects(empty);
                                });
                            },
                            error: function (xhr, status, error)
                            {
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
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

    });
    function filterByStatus(status, empty) {
        $("#PROJwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat("filterProjectsByStatus"),
                success: function (data) {
                    $("#PROJwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function filterByDateRange(start, end,empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true)
        {
            $("#PROJwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

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
                    url: getServiceURL().concat('filterProjectsByDate'),
                    success: function (data) {
                        $("#PROJwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#PROJwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }
    function filterByLeader(leader, empty)
    {
        $("#PROJwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'leader':'" + leader + "'}",
                url: getServiceURL().concat("filterProjectsByLeader"),
                success: function (data) {
                    $("#PROJwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function filterByName(key, empty) {
        $("#PROJwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'key':'" + key + "'}",
                url: getServiceURL().concat("filterProjectsByName"),
                success: function (data) {
                    $("#PROJwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PROJwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProjects(empty) {

        $("#PROJwait").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadProjects'),
                success: function (data) {
                    $("#PROJwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvProjects.ClientID%> tr").not($("#<%=gvProjects.ClientID%> tr:first-child")).remove();

        $(xml).find("Project").each(function (index, value)
        {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");

            $("td", row).eq(2).html($(this).attr("ProjectNo"));
            $("td", row).eq(3).html($(this).attr("ProjectName"));
            $("td", row).eq(4).html(new Date($(this).attr("StartDate")).format("dd/MM/yyyy"));
            $("td", row).eq(5).html(new Date($(this).attr("PlannedCloseDate")).format("dd/MM/yyyy"));
            $("td", row).eq(6).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(7).html($(this).attr("ProjectLeader"));
            $("td", row).eq(8).html($(this).attr("ProjectValue") + " " + $(this).attr("Currency"));
            $("td", row).eq(9).html($(this).attr("ProjectCost") + " " + $(this).attr("Currency"));
            $("td", row).eq(10).html($(this).attr("ProjectStatus"));

            $("#<%=gvProjects.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        /*clear all fields*/
                        reset();

                        /*bind project number*/
                        $("#<%=PROJNoTxt.ClientID%>").val($(value).attr("ProjectNo"));

                        /*bind project name*/
                        $("#<%=PROJNMTxt.ClientID%>").val($(value).attr("ProjectName"));

                        /*bind project leader*/
                        bindComboboxAjax('loadEmployees', '#<%=PROJLDRCBox.ClientID%>', $(value).attr("ProjectLeader"),"#LDR_LD");

                        /*bind project description*/
                        if ($(value).attr("Description") == '')
                        {
                            addWaterMarkText('The Details of the Project', '#<%=PROJDESCTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=PROJDESCTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=PROJDESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=PROJDESCTxt.ClientID%>").html($(value).attr("Description")).text();
                        }

                        /*bind start date*/
                        $("#<%=STRTDTTxt.ClientID%>").val(new Date($(value).attr("StartDate")).format("dd/MM/yyyy"));

                        /*bind planned close date*/
                        $("#<%=PLNNDCLSDTTxt.ClientID%>").val(new Date($(value).attr("PlannedCloseDate")).format("dd/MM/yyyy"));

                        /*bind actual close date*/
                        $("#<%=ACTCLSDTTxt.ClientID%>").val($(value).find("ActualCloseDate").text() == '' ? '' : new Date($(value).find("ActualCloseDate").text()).format("dd/MM/yyyy"));

                        /*bind currency value*/
                        bindComboboxAjax('loadCurrencies', '#<%=CURRCBox.ClientID%>', $(value).attr("Currency"),"#CURR_LD");

                        $("#<%=PROJCSTCURR.ClientID%>").val($(value).attr("Currency"));

                        $("#<%=CSTCOMPLCURR.ClientID%>").val($(value).attr("Currency"));

                        /*bind project value*/
                        $("#<%=PROJValTxt.ClientID%>").val($(value).attr("ProjectValue"));

                        /*bind project cost*/
                        $("#<%=PROJCSTTxt.ClientID%>").val($(value).attr("ProjectCost"));

                     
                        /*bind cost at completion*/
                        $("#<%=CSTCOMPLTxt.ClientID%>").val($(value).attr("CostAtCompletion") == 0 ? '' : $(value).attr("CostAtCompletion"));

                        /*bind currency value*/
                        bindComboboxAjax('loadProjectStatus', '#<%=PRJSTSCBox.ClientID%>', $(value).attr("ProjectStatus"), "#PROJSTS_LD");

                        /*Check if the project status is completed or cancelled so that it may enable or disable changes*/
                        if ($(value).attr('ProjectStatus') == 'Cancelled' || $(value).attr('ProjectStatus') == 'Completed') {
                            $("#PRJTooltip").find('p').text("Changes cannot take place since the project is " + $(value).attr('ProjectStatus'));

                            if ($("#PRJTooltip").is(":hidden")) {
                                $("#PRJTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else
                        {
                            $("#PRJTooltip").hide();

                            /*enable all modal controls for editing*/
                            ActivateAll(true);
                        }

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }
                else if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeProject($(value).attr('ProjectID'), empty);
                    });
                }
            });
            row = $("#<%=gvProjects.ClientID%> tr:last-child").clone(true);
        });
    }
    function removeProject(projectID, empty) {
        var result = confirm("Are you sure you would like to remove the project record?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'projectID':'" + projectID + "'}",
                url: getServiceURL().concat('removeProject'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");
                    loadProjects(empty);
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

    function ActivateAll(isactive) {
        if (isactive == false) {
            $(".modalPanel").children().each(function () {
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

                $(this).find('.imgButton').each(function () {
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



    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
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

    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 230, top: y - 1 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
            $("#SelectORG").show();
        }
</script>
</asp:Content>
