<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateAudit.aspx.cs" Inherits="QMSRSTools.AuditManagement.CreateAudit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="wrapper" class="modulewrapper">
    <div id="AUDT_Header" class="moduleheader">Schedule an Audit</div>
   
    <div class="toolbox">
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt=""/> 
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="AuditTypeLabel" class="requiredlabel">Audit Type:</div>
        <div id="AuditTypeField" class="fielddiv" style="width:250px">
            <asp:DropDownList ID="AUDTTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
            </asp:DropDownList>    
        </div>
        <div id="AUDTTYP_LD" class="control-loader"></div>

        <asp:RequiredFieldValidator ID="AUDTTYPTxtVal" runat="server" Display="None" ControlToValidate="AUDTTYPCBox" ErrorMessage="Select audit type" ValidationGroup="Details"></asp:RequiredFieldValidator>   
    
        <asp:CompareValidator ID="AUDTTYPVal" runat="server" ControlToValidate="AUDTTYPCBox" CssClass="validator"
        Display="None" ErrorMessage="Select audit type" Operator="NotEqual" Style="position: static"
        ValueToCompare="0" ValidationGroup="Details"></asp:CompareValidator>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:5px;">
        <ul id="tabul">
            <li id="Details" class="ntabs">Audit Information</li>
            <li id="ORGUnits" class="ntabs">Units for Audit</li>
            <li id="Auditors" class="ntabs">Auditors</li>
            <li id="Additional" class="ntabs">Additional Info</li>
        </ul>
    
        <div id="DetailsTB" class="tabcontent" style="display:none; height:520px;">
             <div id="validation_dialog_details" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Details" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="AUDTIDLabel" class="requiredlabel">Audit ID:</div>
                <div id="AUDTIDField" class="fielddiv" style="width:auto;">
                    <asp:TextBox ID="AUDTIDTxt" runat="server" CssClass="textbox"></asp:TextBox>
                    <asp:Label ID="AUDTIDLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
                </div>

                <div id="AUDTIDlimit" class="textremaining"></div>  

                <asp:RequiredFieldValidator ID="AUDTVal" runat="server" Display="None" ControlToValidate="AUDTIDTxt" ErrorMessage="Enter a unique ID of the audit record" ValidationGroup="Details"></asp:RequiredFieldValidator>
            
                <asp:CustomValidator id="AUDTIDFVal" runat="server" ValidationGroup="Details" 
                ControlToValidate = "AUDTIDTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
                ClientValidationFunction="validateIDField">
                </asp:CustomValidator>      
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AuditNameLabel" class="requiredlabel">Audit Title:</div>
                <div id="AuditNameField" class="fielddiv" style="width:300px">
                    <asp:TextBox ID="AUDTNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
                </div>

                <div id="AUDTNMlimit" class="textremaining"></div>  

                <asp:RequiredFieldValidator ID="AUDTNMTxtVal" runat="server" Display="None" ControlToValidate="AUDTNMTxt" ErrorMessage="Enter the title of the audit" ValidationGroup="Details"></asp:RequiredFieldValidator> 
            
                <asp:CustomValidator id="AUDTNMTxtFVal" runat="server" ValidationGroup="Details" 
                ControlToValidate = "AUDTNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>     
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ProcessDocumentLabel" class="labeldiv">Process Document:</div>
                <div id="ProcessDocumentField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="PROCDOCTxt" Width="240px" runat="server" CssClass="readonly">
                    </asp:TextBox>
                </div>
                <span id="DOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span>
            </div>
        
            <div id="SelectDOC" class="selectbox" style="top:110px;">
                <div id="closeSelect" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="DocumentTypeLabel" class="labeldiv" style="width:100px;">Document Type:</div>
                    <div id="DocumentTypeField" class="fielddiv" style="width:130px">
                        <asp:DropDownList ID="DOCTYP" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="DOCTYP_LD" class="control-loader"></div> 
                </div>
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="DocumentLabel" class="labeldiv" style="width:100px;">Select Document:</div>
                    <div id="DocumentField" class="fielddiv" style="width:130px">
                        <asp:DropDownList ID="DOCCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <div id="project" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="ProjectLabel" class="labeldiv">Select Project:</div>
                <div id="ProjectField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="PROJTxt" Width="240px" runat="server" CssClass="readonly">
                    </asp:TextBox>
                </div>
                <span id="PROJSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for projects"></span>
            </div>

            <div id="SearchProject" class="selectbox" style="width:700px; height:250px; top:130px; left:150px;">
                <div class="toolbox">
                    <div style="float:left; width:450px; height:20px; margin-top:4px;">
                        <div id="StartDateLabel" style="width:120px;">Project Start Date:</div>
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
                    <div id="projcloseBox" class="selectboxclose"></div>
                </div>

                <div id="PROJFLTR_LD" class="control-loader"></div> 
                
                <div id="scrollbarPROJ" style="height:250px; width:96%; overflow:auto; margin-top:15px; float:left">
                    <asp:GridView id="gvProjects" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
                    <Columns>
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
            </div>

            <div id="supplier" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="SupplierLabel" class="labeldiv">Select Supplier:</div>
                <div id="SupplierField" class="fielddiv" style="width:250px">
                    <asp:TextBox ID="SUPPTxt" Width="240px" runat="server" CssClass="readonly">
                    </asp:TextBox>
                </div>
                <span id="SUPPSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for suppliers"></span>
        
            </div>

            <div id="SearchSupplier" class="selectbox" style="width:500px; height:250px; top:130px; left:150px;">
                <div class="toolbox">
                    <div style="float:left; width:450px; height:20px; margin-top:4px;">
                        <div id="PartyTypeLabel" style="width:120px;">Party Type:</div>
                        <div id="PartyTypeField" style="width:150px;">
                            <asp:DropDownList ID="PRTYTYPCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                            </asp:DropDownList> 
                        </div>
                         <div id="PRTYP_LD" class="control-loader"></div>

                    </div>
                    <div id="suppclosebox" class="selectboxclose" style="margin-right:1px;"></div>
                </div>
                <div id="SUPPFLTR_LD" class="control-loader"></div> 

                <div id="scrollbarSUPP" style="height:250px; width:96%; overflow:auto; margin-top:15px; float:left">
                    <asp:GridView id="gvSuppliers" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:BoundField DataField="CustomerNo" HeaderText="Supplier No." />
                            <asp:BoundField DataField="CustomerType" HeaderText="Type" />
                            <asp:BoundField DataField="CustomerName" HeaderText="Name" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="AuditDateLabel" class="requiredlabel">Planned Audit Date:</div>
                <div id="AuditDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="AUDTDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="AUDTDTVal" runat="server" Display="None" ControlToValidate="AUDTDTTxt" ErrorMessage="Enter the planned audit date" ValidationGroup="Details"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="AUDTDTFVal" runat="server" ControlToValidate="AUDTDTTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Details"></asp:RegularExpressionValidator>  

                <asp:CustomValidator id="AUDTDTF2Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "AUDTDTTxt" Display="None" ErrorMessage = "Planned audit date should be in future"
                ClientValidationFunction="compareFuture">
                </asp:CustomValidator>

                <asp:CustomValidator id="AUDTDTF3Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "AUDTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ISOStandardLabel" class="labeldiv">Select ISO Standard:</div>
                <div id="ISOStandardField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="ISOSTDCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>      
                </div>

                <div id="ISO_LD" class="control-loader"></div>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ISOCheckLabel" class="labeldiv">Select ISO Checklists:</div>
                <div id="ISOCheckField" class="fielddiv" style="width:250px">
                    <div id="ISOCHK" class="checklist"></div>
                </div>
            </div>
        </div>
        <div id="ORGUnitsTB" class="tabcontent" style="display:none;height:520px;">
            <div class="toolbox">
                <img id="refresh" src="../Images/refresh.png" alt=""  class="selectBoxImg" title="Refresh Units"/>
                <div id="filter_div">
                    <img id="filter" src="../Images/filter.png" alt=""/>
                    <ul class="contextmenu">
                        <li id="clearFilter">View All Units</li>
                        <li id="byLocation">Filter by Location</li>
                    </ul>
                </div>
             
                <div id="LocationContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                    <div id="LocationLabel" style="width:100px;">Location</div>
                    <div id="LocationField" style="width:150px; left:0; float:left;">
                        <asp:DropDownList ID="LOCCBox" runat="server" Width="150px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="LOC_LD" class="control-loader"></div>   
                </div>
            </div>
            <div id="orgtreemenu" class="menucontainer" style="border: 1px solid #052556; margin-top:10px; height:440px;">   
                <div id="AUDTloader" class="loader">
                    <div class="waittext">Please Wait...</div>
                </div>
                <div id="orgtree"></div>
            </div>
            <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; margin-top:10px;height:440px;">
                <div id="table" style="display:none;">
                    <div id="row_header" class="tr">
                        <div id="col0_head" class="tdh" style="width:50px"></div>
                        <div id="col1_head" class="tdh" style="width:20%">ID</div>
                        <div id="col2_head" class="tdh" style="width:20%">ORG. Unit</div>
                        <div id="col3_head" class="tdh" style="width:20%">ORG. Level</div>
                        <div id="col4_head" class="tdh" style="width:20%">Location</div>
                    </div>
                </div>
            </div>
        </div>
        <div id="AuditorsTB" class="tabcontent" style="display:none;height:520px;">
            <img id="newAuditor" src="../Images/new_file.png" class="imgButton" title="Add new Auditor" alt=""/>
       
            <asp:GridView id="gvAuditors" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
            GridLines="None" AllowPaging="true" PageSize = "5" AlternatingRowStyle-CssClass="alt" style="margin-top:30px; width:50%">
            <Columns>
                <asp:TemplateField ShowHeader="false" HeaderStyle-Width="50px">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="false" HeaderStyle-Width="50px">
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="EmployeeName" HeaderText="Auditor" />
            </Columns>
            </asp:GridView>
        </div>
        <div id="AdditionalTB" class="tabcontent" style="display:none;height:520px;">
            
            <div id="validation_dialog_additional" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="ScopeSummery" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ScopeLabel" class="labeldiv">Scope:</div>
                <div id="ScopeField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="SCOPTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
            
                <asp:CustomValidator id="SCOPTxtVal" runat="server" ValidationGroup="Additional" 
                ControlToValidate = "SCOPTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>

            </div>

            <div style="float:left; width:100%; height:20px; margin-top:125px;">
                <div id="ORGUnitRecipientLabel" class="labeldiv">Select ORG. Unit:</div>
                <div id="ORGUnitRecipientField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="ORGUNTRECBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORG_LD" class="control-loader"></div>
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RecipientsLabel" class="labeldiv">Select Audit Recipients:</div>
                <div id="RecipientsField" class="fielddiv" style="width:570px;">
                    <div id="RECCHK" class="checklist" style="height:200px;"></div>
                    <div style="width:52px; height:200px; float:left; margin-left:2px;">
                        <input id="Add" type="button" class="button" style="width:50px; margin-top:100px;" value="Add" />
                    </div>
                    <div id="ToCHK" class="checklist" style="height:200px; margin-left:2px;"></div>
                </div>
            </div>
        </div>
    </div>

    <div id="DepartmentDialog" title="Select Organization Unit" style="display:none;">
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ORGUnitLabel" class="labeldiv">ORG. Unit:</div>
            <div id="ORGUnitField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="230px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="ORGUNT_LD" class="control-loader"></div> 
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="EMPNameLabel" class="labeldiv">Employee Name:</div>
            <div id="EMPNameField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="EMPCBox" AutoPostBack="false" Width="230px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
        </div>
        <p style="margin-top:20px; float:left;">Press Esc to cancel the selection</p>
    </div>

    <input id="MODE" type="hidden" value="" />
    <input id="DATA" type="hidden" value="" />

    <asp:Panel ID="panel3" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="panel3" PopupControlID="panel3" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvAuditors.ClientID%> tr:last-child").clone(true);
        var emptySUPP = $("#<%=gvSuppliers.ClientID%> tr:last-child").clone(true);
        var emptyPROJ = $("#<%=gvProjects.ClientID%> tr:last-child").clone(true);

        loadXMLISOStandards();

        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTRECBox.ClientID%>", "#ORG_LD");
        loadComboboxAjax('loadAuditType', "#<%=AUDTTYPCBox.ClientID%>", "#AUDTTYP_LD");

        loadLastIDAjax('getLastAuditNo', "#<%=AUDTIDLbl.ClientID%>");

        addWaterMarkText('The scope of which the audit is focusing on', '#<%=SCOPTxt.ClientID%>');

        /*attach audit name to limit plugin*/
        $('#<%=AUDTNMTxt.ClientID%>').limit({ id_result: 'AUDTNMlimit', alertClass: 'alertremaining', limit: 100 });

        /*attach audit ID to limit plugin*/
        $('#<%=AUDTIDTxt.ClientID%>').limit({ id_result: 'AUDTIDlimit', alertClass: 'alertremaining', limit: 50 });

        /*prepare initial setup*/
        refresh();

        navigate('Details');

        initializeUnits();

        //remove the empty row in the gridview
        $("#<%=gvAuditors.ClientID%> tr").not($("#<%=gvAuditors.ClientID%> tr:first-child")).remove();

        $("#refresh").bind('click', function () {
            refresh();
        });

        $("#<%=AUDTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=SUPPSRCH.ClientID%>").bind('click',function ()
        {
            loadComboboxAjax('loadCustomerType', "#<%=PRTYTYPCBox.ClientID%>", "#PRTYP_LD");
          
            loadSuppliers(emptySUPP);
            $("#SearchSupplier").show();
        });

        $("#<%=PROJSRCH.ClientID%>").bind('click',function ()
        {
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            loadProjects(emptyPROJ);
            $("#SearchProject").show();
        });

        $("#<%=AUDTTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                switch ($(this).val()) {
                    case "Internal":
                        $("#supplier").hide();
                        $("#project").hide();
                        break;
                    case "Supplier":
                        $("#supplier").show();
                        $("#project").hide();
                        break;
                    case "Project":
                        $("#supplier").hide();
                        $("#project").show();
                        break;
                }
            }
            $("#<%=SUPPTxt.ClientID%>").val('');
            $("#<%=PROJTxt.ClientID%>").val('');

        });
        $("#byLocation").bind('click', function () {
            hideAll();

            loadComboboxAjax('loadCountries', "#<%=LOCCBox.ClientID%>", "#LOC_LD");

            $("#LocationContainer").show();

        });

        $("#clearFilter").bind('click', function () {
            hideAll();

            refresh();
        });

        $('#orgtree').bind('tree.click', function (event) {
            //disable single selection
            event.preventDefault();

            if ($(this).tree('isNodeSelected', event.node)) {
                $(this).tree('removeFromSelection', event.node);
                removeUnit(event.node);
            }
            else {
                $(this).tree('addToSelection', event.node);

                addUnit(event.node);
            }
        });

        $("#newAuditor").bind('click', function () {
            $("#MODE").val('LOAD');
            showORGDialog();
        });


        $("#<%=EMPCBox.ClientID%>").change(function () {
            var row = null;
            if ($("#MODE").val() == 'LOAD') {
                var length = $("#<%=gvAuditors.ClientID%> tr").not($("#<%=gvAuditors.ClientID%> tr:first-child")).children().length;

                if (length == 0) {
                    addAuditor(empty, length += 1, $(this).val());
                }
                else {
                    var row = $("#<%=gvAuditors.ClientID%> tr:last-child").clone(true);
                    addAuditor(row, length += 1, $(this).val());
                }
            }
            else {
                var JSONObject = JSON.parse($("#DATA").val());
                updateRow(JSONObject.Name, $(this).val())
            }

            $("#DepartmentDialog").dialog("close");
        });

        $("#<%=LOCCBox.ClientID%>").change(function () {
            filter($(this).val());
        });

        //code to control the choice of the document to process
        $("#<%=DOCSRCH.ClientID%>").bind('click', function ()
        {
            loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYP.ClientID%>", "#DOCTYP_LD");
            $("#<%=DOCCBox.ClientID%>").empty();

            $("#SelectDOC").show();
        });

        $("#<%=DOCTYP.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                $("DOCTYP_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $(".modulewrapper").css("cursor", "wait");

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'type':'" + $(this).val() + "'}",
                        url: getServiceURL().concat("filterDocumentByType"),
                        success: function (data) {
                            $("DOCTYP_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                if (data)
                                {
                                    loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $("#<%=DOCCBox.ClientID%>"), $("DOCORG_LD"));
                                }
                            });
                        },
                        error: function (xhr, status, error)
                        {

                            $("DOCTYP_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#<%=DOCCBox.ClientID%>").change(function () {
            $("#<%=PROCDOCTxt.ClientID%>").val($(this).val());

            $("#SelectDOC").hide("800");
        });

        $("#closeSelect").bind('click', function () {
            $("#SelectDOC").hide("800");
        });

        /*load all potential recipients to recipient checkbox*/
        $("#<%=ORGUNTRECBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                $("#ORG_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $(".modulewrapper").css("cursor", "wait");

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'unit':'" + $(this).val() + "'}",
                        url: getServiceURL().concat("getDepEmployees"),
                        success: function (data) {
                            $("#ORG_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                var html = '';

                                $(data.d).each(function (index, value) {
                                    html += "<div class='checkitem'>"
                                    html += "<input type='checkbox' id='" + value + "' name='checklist' value='" + value + "'/><div class='checkboxlabel'>" + value + "</div>";
                                    html += "</div>"
                                });

                                $("#RECCHK").append(html);
                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#ORG_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#Add").bind('click', function () {
            setRecipients("#ToCHK");
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            loadcontrols.push("#<%=EMPCBox.ClientID%>");
            loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, $("#ORGUNT_LD"));

        });

        $("#<%=PRTYTYPCBox.ClientID%>").change(function ()
        {
            filterSupplier($(this).val(), emptySUPP);
        });
        $("#suppclosebox").bind('click', function ()
        {
            $("#SearchSupplier").hide('800');
        });

        $("#projcloseBox").bind('click', function ()
        {
            $("#SearchProject").hide('800');
        });


        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), emptyPROJ);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), emptyPROJ);
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

        $("#tabul li").bind("click", function ()
        {
            navigate($(this).attr("id"));
        });

        $("#<%=ISOSTDCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadISOChecklist($(this).val());
            }
            else {
                alert("Please Select an ISO Standard");
                return false;
            }
        });

        $("#save").bind('click', function ()
        {
            var isDetailsValid = Page_ClientValidate('Details');
            if (isDetailsValid)
            {
                if (!$("#validation_dialog_details").is(":hidden"))
                {
                    $("#validation_dialog_details").hide();
                }

                var isAdditionalValid = Page_ClientValidate('Additional');
                if (isAdditionalValid)
                {
                    if (!$("#validation_dialog_additional").is(":hidden")) {
                        $("#validation_dialog_additional").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {

                        $find('<%= SaveExtender.ClientID %>').show();

                        var AUDTDTParts = getDatePart($("#<%=AUDTDTTxt.ClientID%>").val());
                        var audit =
                        {
                            AuditNo: $.trim($("#<%=AUDTIDTxt.ClientID%>").val()),
                            AuditName: $("#<%=AUDTNMTxt.ClientID%>").val(),
                            AuditType: $("#<%=AUDTTYPCBox.ClientID%>").find('option:selected').text(),
                            PlannedAuditDate: new Date(AUDTDTParts[2], (AUDTDTParts[1] - 1), AUDTDTParts[0]),
                            ProcessDocument: $("#<%=PROCDOCTxt.ClientID%>").val() == '' ? '' : $("#<%=PROCDOCTxt.ClientID%>").val(),
                            Scope: $("#<%=SCOPTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=SCOPTxt.ClientID%>").val()),
                            Auditors: getAuditorsJSON(),
                            Supplier: $("#supplier").is(":hidden") == true ? '' : $("#<%=SUPPTxt.ClientID%>").val(),
                            Project: $("#project").is(":hidden") == true ? '' : $("#<%=PROJTxt.ClientID%>").val(),
                            CheckLists: getChecklistJSON(),
                            Units: $("#table").table('getJSON'),
                            Recipients: getRecipientsJSON()
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(audit) + "\'}",
                            url: getServiceURL().concat("createAudit"),
                            success: function (data) {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                alert(data.d);

                                //reset display controls
                                navigate('Details');
                                reset();
                                refresh();

                                $("#<%=gvAuditors.ClientID%> tr").not($("#<%=gvAuditors.ClientID%> tr:first-child")).remove();
                                $("#supplier").hide();
                                $("#project").hide();

                                $("#ISOCHK").empty();
                                $("#RECCHK").empty();
                                $("#ToCHK").empty();

                                addWaterMarkText('The scope of which the audit is focusing on', '#<%=SCOPTxt.ClientID%>');

                                loadLastIDAjax('getLastAuditNo', "#<%=AUDTIDLbl.ClientID%>");

                                /*trigger audit name keyup event*/
                                $('#<%=AUDTNMTxt.ClientID%>').keyup();

                                /*trigger audit ID keyup event*/
                                $('#<%=AUDTIDTxt.ClientID%>').keyup();

                                /*trigger scope keyup event*/
                                $('#<%=SCOPTxt.ClientID%>').keyup();

                            },
                            error: function (xhr, status, error) {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            }
                        });
                    }
                }
                else
                {
                    $("#validation_dialog_additional").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                        navigate('Additional');
                    });
                }
            }
            else
            {
                $("#validation_dialog_details").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    navigate('Details');
                });
            }
        });
    });

    function loadXMLISOStandards() {

        $("#ISO_LD").stop(true).hide().fadeIn(500, function () {

     
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISOStandards"),
                success: function (data) {
                    $("#ISO_LD").fadeOut(500, function () {
     
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'ISOStandard', 'ISOName', $("#<%=ISOSTDCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ISO_LD").fadeOut(500, function () {
     
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function getAuditorsJSON()
    {
        var auditors = new Array();
        $("#<%=gvAuditors.ClientID%> tr").not($("#<%=gvAuditors.ClientID%> tr:first-child")).each(function (index, value) {
            var auditor =
            {
                NameFormat: $("td", $(this)).eq(2).html(),
            };
            auditors.push(auditor);
        });

        if (auditors.length == 0)
            return null;

        return auditors;
    }

    function getChecklistJSON()
    {
        var checklist = new Array();
        $("#ISOCHK").children(".checkitem").each(function ()
        {
            $(this).find('input').each(function (index, value)
            {
                if ($(value).is(":checked") == true)
                {
                    var entity =
                    {
                        ISOProcessID: $(value).val()
                    };

                    checklist.push(entity);
                }
            });
        });

        if (checklist.length == 0)
            return null;

        return checklist;
    }

    function getRecipientsJSON() {
        var recipients = new Array();
        var ID = null;
        var recipient = null;

        $("#ToCHK").children(".infodiv").each(function () {
            recipient =
            {
                Employee: $(this).find('.infotext').text()
            }

            recipients.push(recipient);

        });


        if (recipients.length == 0)
            return null;

        return recipients;
    }

    function setRecipients(control) {
        $("#RECCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function () {
                if ($(this).is(":checked") == true) {
                    if (RecipientExists(control, $(this).val()) == false) {
                        var sb = new StringBuilder('');

                        sb.append("<div id='" + $(control).attr('id') + "_" + $(this).val().substring($(this).val().lastIndexOf(' ') + 1, $(this).val().length - 1) + "' class='infodiv'>");
                        sb.append("<div class='infotext'>" + $(this).val() + "</div>");
                        sb.append("<div id='delete_" + $(control).attr('id') + "_" + $(this).val().substring($(this).val().lastIndexOf(' ') + 1, $(this).val().length - 1) + "' class='infodelete'></div>");
                        sb.append("</div>");

                        $(control).append(sb.toString());

                        $("#delete_" + $(control).attr('id') + "_" + $(this).val().substring($(this).val().lastIndexOf(' ') + 1, $(this).val().length - 1)).bind('click', function () {
                            $(this).parent().remove();
                        });
                    }
                    else {
                        alert('The name already exists');
                    }
                }
            });
        });
    }

    function RecipientExists(control, employee) {
        var found = false;
        $(control).children().each(function (index, value) {
            if ($(this).find('.infotext').text() == employee) {
                found = true;
            }
        });

        return found;
    }

    function loadISOChecklist(standard)
    {
        $("#ISO_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'isoname':'" + standard + "'}",
                url: getServiceURL().concat("getISOChecklist"),
                success: function (data)
                {
                    $("#ISO_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");


                        if (data)
                        {
                            var checklist = JSON.parse(data.d);
                            var html = '';

                            $("#ISOCHK").empty();

                            $(checklist).each(function (index, value) {
                                html += "<div class='checkitem'>"
                                html += "<input type='checkbox' id='" + value.ISOProcessID + "' name='checklist' value='" + value.ISOProcessID + "'/><div class='checkboxlabel'>" + value.name + "</div>";
                                html += "</div>"
                            });

                            $("#ISOCHK").append(html);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ISO_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
   
    function addAuditor(row, length, value)
    {
        $("td", row).eq(0).html("<img id='remove_" + length + "' src='../Images/deletenode.png' class='imgButton'/>");
        $("td", row).eq(1).html("<img id='edit_" + length + "' src='../Images/edit.png' class='imgButton'/>");
        $("td", row).eq(2).html(value);

        $("#<%=gvAuditors.ClientID%>").append(row);

        $(row).find('img').each(function () {
            if ($(this).attr('id').search('edit') != -1) {
                $(this).bind('click', function () {
                    $("#MODE").val('EDIT');

                    var employeename =
                    {
                        Name: $("td", row).eq(2).html()
                    };

                    $("#DATA").val(JSON.stringify(employeename));

                    showORGDialog();
                });
            }
            else if ($(this).attr('id').search('remove') != -1) {
                $(this).bind('click', function () {
                    $(row).remove();
                });
            }
        });
    }

    function showORGDialog() {
        $("#DepartmentDialog").dialog(
        {
            width: 450,
            show: "slow",
            modal: true,
            height: 200,
            hide: "highlight",
            create: function (event, ui) {
                $("#ORGUNT_LD").show();
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");
            },
            close: function (event, ui) {
                $(this).dialog("destroy");
            }
        });
    }

    function initializeUnits() {
        var attr = new Array();
        attr.push("ORGID");
        attr.push("name");
        attr.push("ORGLevel");
        attr.push("Country");

        /*set cell settings*/

        var settings = new Array();
        settings.push(JSON.stringify({ readonly: true }));
        settings.push(JSON.stringify({ readonly: true }));
        settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadOrganizationLevel") }));
        settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadCountries") }));

        var units =
        [
        ]

        $("#table").table({ JSON: units, Attributes: attr, Settings: settings, Width: 20 });

    }

    function removeUnit(selected) {
        $("#table").table('removeRowAt', 'ORGID', selected.ORGID);
    }

    function addUnit(selected) {
        var result = $("#table").table('addRow',
         {
             ORGID: selected.ORGID,
             name: selected.name,
             ORGLevel: selected.ORGLevel,
             Country: selected.Country,
             Status: 3
         });
    }

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function filter(country) {
        $("#AUDTloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'country':'" + country + "'}",
                url: getServiceURL().concat("filterOrganizationUnit"),
                success: function (data)
                {
                    $("#AUDTloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var existingjson = $('#orgtree').tree('toJson');
                            if (existingjson == null) {
                                $('#orgtree').tree(
                                {
                                    data: $.parseJSON(data.d),
                                    slide: true,
                                    autoOpen: true
                                });
                            }
                            else {
                                $('#orgtree').tree('loadData', $.parseJSON(data.d));
                            }
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#AUDTloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function refresh()
    {
        $("#table").table('clear');

        $("#AUDTloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadOrganizationUnit"),
                success: function (data)
                {
                    $("#AUDTloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var existingjson = $('#orgtree').tree('toJson');
                            if (existingjson == null) {
                                $('#orgtree').tree(
                                {
                                    data: $.parseJSON(data.d),
                                    slide: true,
                                    autoOpen: true
                                });
                            }
                            else {
                                $('#orgtree').tree('loadData', $.parseJSON(data.d));
                            }
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#AUDTloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadSuppliers(empty)
    {
        $("#SUPPFLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadCustomers'),
                success: function (data)
                {
                    $("#SUPPFLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadSupplierGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#SUPPFLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterSupplier(value, empty)
    {
        $("#SUPPFLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'type':'" + value + "'}",
                url: getServiceURL().concat('filterCustomerByType'),
                success: function (data)
                {
                    $("#SUPPFLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadSupplierGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#SUPPFLTR_LD").fadeOut(500, function ()
                    {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadSupplierGridView(data, empty)
    {
        var xmlCustomers = $.parseXML(data);

        var row = empty;

        $("#<%=gvSuppliers.ClientID%> tr").not($("#<%=gvSuppliers.ClientID%> tr:first-child")).remove();

        $(xmlCustomers).find("Customer").each(function (index, value)
        {
            $("td", row).eq(0).html($(this).attr("CustomerNo"));
            $("td", row).eq(1).html($(this).attr("CustomerType"));
            $("td", row).eq(2).html($(this).attr("CustomerName"));
          

            $("#<%=gvSuppliers.ClientID%>").append(row);

            $(row).bind('click', function ()
            {
                $("#SearchSupplier").hide('800');
                $("#<%=SUPPTxt.ClientID%>").val($(value).attr("CustomerName"));
            });

            row = $("#<%=gvSuppliers.ClientID%> tr:last-child").clone(true);
        });

    }

    function loadProjects(empty) {

        $("#PROJFLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadProjects'),
                success: function (data)
                {
                    $("#PROJFLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadProjectGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PROJFLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterByDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true)
        {
            $("#PROJFLTR_LD").stop(true).hide().fadeIn(500, function () {

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
                        $("#PROJFLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data)
                            {
                                loadProjectGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#PROJFLTR_LD").fadeOut(500, function ()
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

    function loadProjectGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvProjects.ClientID%> tr").not($("#<%=gvProjects.ClientID%> tr:first-child")).remove();
        $(xml).find("Project").each(function (index, value)
        {
            $("td", row).eq(0).html($(this).attr("ProjectNo"));
            $("td", row).eq(1).html($(this).attr("ProjectName"));
            $("td", row).eq(2).html(new Date($(this).attr("StartDate")).format("dd/MM/yyyy"));
            $("td", row).eq(3).html(new Date($(this).attr("PlannedCloseDate")).format("dd/MM/yyyy"));
            $("td", row).eq(4).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(5).html($(this).attr("ProjectLeader"));
            $("td", row).eq(6).html($(this).attr("ProjectValue") + " " + $(this).attr("Currency"));
            $("td", row).eq(7).html($(this).attr("ProjectCost") + " " + $(this).attr("Currency"));
            $("td", row).eq(8).html($(this).attr("ProjectStatus"));

            $("#<%=gvProjects.ClientID%>").append(row);

            $(row).bind('click', function () {
                $("#SearchProject").hide('800');
                $("#<%=PROJTxt.ClientID%>").val($(value).attr("ProjectName"));
            });

            row = $("#<%=gvProjects.ClientID%> tr:last-child").clone(true);

        });
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
