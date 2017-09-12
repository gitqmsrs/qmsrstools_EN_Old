<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.ManageCCN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper"> 

    <div id="DCR_Header" class="moduleheader">Manage Document Change Requests</div>

    <div class="toolbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byDOC">Filter by Document</li>
                <li id="ByDOCTYP">Filter by Document Type</li>
                <li id="byDCRTYP">Filter by DCR Type</li>
                <li id="byORIGUDT">Filter by Origination Date Range</li>
            </ul>
        </div>
    </div>

    <div id="DOCContainer" class="filter">
        <div id="DocumentNameLabel" class="filterlabel">Title:</div>
        <div id="DocumentNameField" class="filterfield">
            <asp:TextBox ID="DOCNMTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>
    </div>

    <div id="DOCTypeContainer" class="filter">
        <div id="DocumentTypeLabel" class="filterlabel">Document Type:</div>
        <div id="DocumentTypeField" class="filterfield">
            <asp:DropDownList ID="DOCTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="DOCTYPF_LD" class="control-loader"></div>
    </div>

    <div id="DCRTYPContainer" class="filter">
        <div id="DCRTYPLabel" class="filterlabel">DCR Type:</div>
        <div id="DCRTYPField" class="filterfield">
            <asp:DropDownList ID="DCRTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="DCRTYPF_LD" class="control-loader"></div>
    </div>

    <div id="OriginationDateContainer" class="filter">
        <div id="OriginationDateFLabel" class="filterlabel">Origination Date:</div>
        <div id="OriginationDateFField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>

        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>

    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="DCRwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvDCR" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="DocumentNo" HeaderText="Document No" />
            <asp:BoundField DataField="Title" HeaderText="Document Name" />
            <asp:BoundField DataField="DCRType" HeaderText="DCR Type" />
            <asp:BoundField DataField="Originator" HeaderText="Originator" />
            <asp:BoundField DataField="Owner" HeaderText="Owner" />
            <asp:BoundField DataField="OrginationDate" HeaderText="Origination Date" />
            <asp:BoundField DataField="DCRStatus" HeaderText="Status" />
            <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
        </Columns>
        </asp:GridView>
    </div>
   
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:640px;">
    
        <div id="header" class="modalHeader">Document Change Request Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="DCRTooltip" class="tooltip">
            <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>	
 
        <div id="SaveTooltip" class="tooltip">
            <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <ul id="tabul" style="margin-top:45px;">
            <li id="DCRDetails" class="ntabs">DCR Info</li>
            <li id="DCRMembers" class="ntabs">Approval Members</li>
        </ul>

        <div id="DCRDetailsTB" class="tabcontent">

            <div id="validation_dialog_DCR">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="DCR" />
            </div>

            <input id="DCRID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="DCRTypeLabel" class="labeldiv">DCR Type:</div>
                <div id="DCRTypeField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="DCRTYPTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                </div>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DOCVersionLabel" class="labeldiv">Document Version:</div>
                <div id="DOCVersionField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="DOCVRTxt" runat="server"  CssClass="textbox" Width="140px"></asp:TextBox>
                </div>
                <div id="DVlimit" class="textremaining"></div> 
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OriginatorLabel" class="requiredlabel">DCR Originator:</div>
                <div id="OrginatorField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="ORIGCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="ORIGN_LD" class="control-loader"></div>       
            
                <span id="ORIGNSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the originator of the document"></span>
      
                <asp:RequiredFieldValidator ID="ORIGTxtVal" runat="server" Display="None" ControlToValidate="ORIGCBox" ErrorMessage="Select an originator" ValidationGroup="DCR"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="ORIGVal" runat="server" ControlToValidate="ORIGCBox" ValidationGroup="DCR"
                Display="None" ErrorMessage="Select an originator" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="IssuerLabel" class="requiredlabel">DCR Owner:</div>
                <div id="IssuerField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="Owner_LD" class="control-loader"></div>       
                
                <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the document"></span>
            
                <asp:RequiredFieldValidator ID="OWNRTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select an owner" ValidationGroup="DCR"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="OWNRVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="DCR"
                Display="None" ErrorMessage="Select an owner" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
     
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OriginationDateLabel" class="requiredlabel">Origination Date:</div>
                <div id="OriginationDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ORGNDTTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>           
                </div>        
            
                <asp:RequiredFieldValidator ID="ORIGNDTVal" runat="server" Display="None" ControlToValidate="ORGNDTTxt" ValidationGroup="DCR" ErrorMessage="Enter the orgination date of the DCR"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="ORIGNDTFVal" runat="server" Display="None" ControlToValidate="ORGNDTTxt" ValidationGroup="DCR"
                ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$"></asp:RegularExpressionValidator>  
             
                <asp:CustomValidator id="ORGNDTF2Val" runat="server" ValidationGroup="DCR" Display="None"
                ControlToValidate = "ORGNDTTxt" ErrorMessage = "Origination should not be in future"
                ClientValidationFunction="comparePast">
                </asp:CustomValidator>

                <asp:CustomValidator id="ORGNDTF3Val" runat="server" ValidationGroup="DCR" 
                ControlToValidate = "ORGNDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DOCURLLabel" class="labeldiv">Document File URL:</div>
                <div id="DOCURLField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="DOCURLTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
                </div>
                <input id="VDOCBTN" class="button" type="button" value="View" style="margin-left:5px; width:85px" />
 
                <asp:RegularExpressionValidator ID="DOCURLFVal" runat="server" ControlToValidate="DOCURLTxt"
                Display="None" ErrorMessage="invalid URL e.g.(http://www.example.com) or (www.example.com)" ValidationExpression="^(http(s)?\://)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+\s&amp;%\$#\=~])*$" ValidationGroup="DCR"></asp:RegularExpressionValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DocumentFileLabel" class="labeldiv">Document File:</div>
                <div id="DocumentFileField" class="fielddiv" style="width:400px">
                    <asp:TextBox ID="DOCFILText" CssClass="readonly" runat="server" Width="390px" ReadOnly="true"></asp:TextBox>
                    <div class="uploaddiv"></div>
                    <input id="fileupload" type="file" name="file" style="width:0; height:0; display:block;"/>
                    <input id="filename" type="hidden" value=""/>
                    <div id="uploadmessage"></div>
                </div>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DCRStatusLabel" class="requiredlabel">DCR Status:</div>
                <div id="DCRStatusField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="DCRSTSCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="DCRSTS_LD" class="control-loader"></div>
                
                <asp:RequiredFieldValidator ID="DCRSTSTxtVal" runat="server" Display="None" ControlToValidate="DCRSTSCBox" ErrorMessage="Select DCR status" ValidationGroup="DCR"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="DCRSTSVal" runat="server" ControlToValidate="DCRSTSCBox" ValidationGroup="DCR"
                Display="None" ErrorMessage="Select DCR status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
       
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DCRDetailsLabel" class="labeldiv">Reason for Change:</div>
                <div id="DCRDetailsField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="DCRCHNGTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <asp:CustomValidator id="DCRCHNGTxtVal" runat="server" ValidationGroup="DCR"
                ControlToValidate = "DCRCHNGTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>    

        <div id="DCRMembersTB" class="tabcontent">
            <span id="lblApprovalMessage" class="validator"></span>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <img id="newmember" src="/Images/new_file.png" class="imgButton" title="Add new Approval Member" alt=""/>
        
                <div id="table" class="table" style="display:none;">
                    <div id="row_header" class="tr">
                        <div id="col0_head" class="tdh" style="width:50px"></div>
                        <div id="col1_head" class="tdh" style="width:20%">Member</div>
                        <div id="col2_head" class="tdh" style="width:20%">Type</div>
                        <div id="col3_head" class="tdh" style="width:20%">Approval Status</div>
                        <div id="col4_head" class="tdh" style="width:20%">Decision Details</div>
                    </div>
                </div>
            </div>
        </div>
    
        <div id="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>

        <div id="SelectORG" class="selectbox">
            <div id="closeORG" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="SelectOrganizationLebel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="SelectOrganizationField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="SORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList> 
                </div>
                <div id="SORGUNT_LD" class="control-loader"></div> 
            </div>
        </div>
    </asp:Panel>
    <input id="invoker" type="hidden" value="" />
</div>

<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvDCR.ClientID%> tr:last-child").clone(true);

        refresh(empty);

        $("#<%=ORGNDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });


        $("#refresh").bind('click', function () {
            hideAll();
            refresh(empty);
        });

        
        $("#byDOC").bind('click', function ()
        {
            hideAll();

            $("#<%=DOCNMTxt.ClientID%>").val('');

            $("#DOCContainer").show();
        });

        $("#ByDOCTYP").bind('click', function () {
            hideAll();

            loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYPCBox.ClientID%>", "#DOCTYPF_LD");

            $("#DOCTypeContainer").show();
        });

        $("#byDCRTYP").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadAllDCRType', "#<%=DCRTYPCBox.ClientID%>", "#DCRTYPF_LD");

            $("#DCRTYPContainer").show();
        });

        $("#byORIGUDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#OriginationDateContainer").show();
        });
       
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        /*filter DCR according to document title*/
        $("#<%=DOCNMTxt.ClientID%>").keyup(function () {
            filterByDOC($(this).val(), empty);
        });

        /*filter DCR according to DCR type*/
        $("#<%=DCRTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByDCRType($(this).val(), empty);
            }
        });

        /*filter DCR according to Document type*/
        $("#<%=DOCTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterByDOCType($(this).val(), empty);
            }
        });

        /*filter documents by origination date range*/
        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByOriginationDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByOriginationDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByOriginationDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByOriginationDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#<%=DOCURLTxt.ClientID%>").keyup(function ()
        {
            if ($(this).val() == '') {
                if ($("#VDOCBTN").is(":disabled") == false) {
                    /*disable view button*/
                    disableViewButton(false);
                }
            }
            else {
                if ($("#VDOCBTN").is(":disabled") == true) {

                    /*enable view button*/
                    disableViewButton(true);
                }
            }
        });

        $("#<%=ORIGNSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Originator');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=OWNRSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });


        /*populate the employees in originatir, and owner cboxes*/
        $("#<%=SORGUNTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                switch ($("#invoker").val()) {
                    case "Originator":
                        loadcontrols.push("#<%=ORIGCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORIGN_LD");
                        break;
                    case "Owner":
                        loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#Owner_LD");
                        break;
                }
                $("#SelectORG").hide('800');
            }
        });


        /*At the current stage, documents can be viewed using google doc viewer tool where a customized document viewer can be added as a future work*/
        $("#VDOCBTN").bind('click', function ()
        {
            window.open('http://docs.google.com/viewer?url=' + $("#<%=DOCURLTxt.ClientID%>").val());
        });

       

        $(".uploaddiv").bind('click', function () {
            $('input[type=file]').trigger('click');
        });

        $("#fileupload").fileupload(
        {
            dataType: 'json',
            url: '/Upload.ashx',
            add: function (e, data) {
                var fileExtension = data.originalFiles[0]['name'].replace(/^.*\./, '');
                if (fileExtension == "doc" || fileExtension == "docx") {
                    data.submit();
                }
                else {
                    showErrorNotification("Please upload a word document (.doc/.docx) file");
                }
            },
            progress: function (e, data) {
                $("#uploadmessage").show();
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $("#uploadmessage").html("Uploading(" + progress + "%)");
            },
            done: function (e, data) {
                $.each(data.files, function (index, file) {
                    /*temporarly store the name of the file*/
                    $("#filename").val(file.name);
                });

                $("#uploadmessage").hide("2000");

                $("#<%=DOCFILText.ClientID%>").val(data.result.name);
            },
            fail: function (e, err) {
                $("#uploadmessage").hide("2000");
                alert(err.errorThrown);
            }
        });
        $("#newmember").bind('click', function ()
        {
            /*if DCR status is cancelled, then prevent adding a new approval member*/

            if ($("#<%=DCRSTSCBox.ClientID%>").val() == 'Cancelled')
            {
                alert('Cannot add a new approval member on a cancelled DCR record, please change the status');
            }
            else
            {
                $("#table").table('addRow',
                {
                    Member: '',
                    MemberType: '',
                    ApprovalStatusString: 'PENDING',
                    ApprovalRemarks: '',
                    Status: 3
                });
            }
        });

        $("#tabul li").bind("click", function () {
            $("#tabul li").removeClass("ctab");
            $(this).addClass("ctab");

            $(".tabcontent").each(function () {
                $(this).css('display', 'none');
            });

            $("#" + $(this).attr("id") + "TB").css('display', 'block');
        });

        /*save changes */
        $("#save").bind('click', function ()
        {
            var obj = $("#table").table("getJSON");
            var members = [];
            var membertypes = [];
            var hasDuplicates = false;
            var hasError = false;

            for (x = 0; x < obj.length; x++) {
                if (obj[x].Status != 4) {
                    members.push(obj[x].Member);
                    membertypes.push(obj[x].MemberType)
                }
            }
            members = members.sort();

            for (y = 0; y < members.length; y++) {
                if (members[y + 1] == members[y] && (members[y + 1] != "" || members[y] != "")) {
                    hasDuplicates = true;
                }
            }

            if (members.length == 0) {
                $("#lblApprovalMessage").html("<ul><li>Please choose one or more approval members.</li></ul>");
                $("#lblApprovalMessage").show();
                navigate('DCRMembers');
                hasError = true;
            }
            if (hasDuplicates) {
                $("#lblApprovalMessage").html("<ul><li>Duplicate name exists.</li></ul>");
                $("#lblApprovalMessage").show();
                navigate('DCRMembers');
                hasError = true;
            }
            if (members.length > 0 && ($.inArray("", membertypes) > -1 || $.inArray("", members) > -1)) {
                $("#lblApprovalMessage").html("<ul><li>Please fill out the blank cells.</li></ul>");
                $("#lblApprovalMessage").show();
                navigate('DCRMembers');
                hasError = true;
            }

            if (!hasError) {
                funcIsPageValid()
            }
            function funcIsPageValid() {
                var isPageValid = Page_ClientValidate('DCR');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_DCR").is(":hidden"))
                    {
                        $("#validation_dialog_DCR").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {

                            ActivateSave(false);

                            var orgdate = getDatePart($("#<%=ORGNDTTxt.ClientID%>").val());

                            var DCR =
                            {
                                CCNID: $("#DCRID").val(),
                                Version: $("#<%=DOCVRTxt.ClientID%>").val(),
                                OrginationDate: new Date(orgdate[2], (orgdate[1] - 1), orgdate[0]),
                                CCNDetails: $("#<%=DCRCHNGTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DCRCHNGTxt.ClientID%>").val()),
                                CCNStatusString: $("#<%=DCRSTSCBox.ClientID%>").find('option:selected').text(),
                                Originator: $("#<%=ORIGCBox.ClientID%>").find('option:selected').text(),
                                DocumentFileURL: $("#<%=DOCURLTxt.ClientID%>").val(),
                                DocumentFile: $("#<%=DOCFILText.ClientID%>").val().replace(/\\/g, '/'),
                                DocumentFileName: $("#filename").val(),
                                Owner: $("#<%=OWNRCBox.ClientID%>").find('option:selected').text(),
                                Members: $("#table").table('getJSON')
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(DCR) + "\'}",
                                url: getServiceURL().concat('updateDCR'),
                                success: function (data)
                                {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        showSuccessNotification(data.d);

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
                                        showErrorNotification(r.Message);
                                    });
                                }
                            });
                        });
                    }
                }
                else
                {
                    $("#validation_dialog_DCR").stop(true).hide().fadeIn(500, function ()
                    {
                    
                    });
                }
            }
            
        });
    });

    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 300, top: y - 60 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#SORGUNT_LD");
        $("#SelectORG").show();
    }

    function resetTab() {
        //clear previously activated tabs
        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        //bind to the first tab
        $("#tabul li").removeClass("ctab");
        $("#DCRDetails").addClass("ctab");
        $("#DCRDetailsTB").css('display', 'block');
    }

  
    function filterByDCRType(type, empty)
    {
        $("#DCRwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("filterDCRByType"),
                success: function (data) {
                    $("#DCRwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current DCR records filtered by their type.");
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#DCRwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByDOCType(type, empty) {
        $("#DCRwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("filterDocumentByType"),
                success: function (data)
                {
                    $("#DCRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current DCR records filtered by document type.");
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#DCRwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByOriginationDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#DCRwait").stop(true).hide().fadeIn(500, function ()
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
                    url: getServiceURL().concat('filterDocumentsByDCROriginationDate'),
                    success: function (data) {
                        $("#DCRwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(this).find('p').text("List of all DCR records records filterd where the origination date between " + startdate.format('dd/MM/yyyy') + " and " + enddate.format('dd/MM/yyyy') + ".");
                            });

                            if (data)
                            {
                                loadGridView(data.d, empty);
                            }
                        });

                    },
                    error: function (xhr, status, error)
                    {
                        $("#DCRwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(500, function ()
                            {
                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByDOC(name, empty)
    {
        $("#DCRwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'title':'" + name + "'}",
                url: getServiceURL().concat("filterDocumentByName"),
                success: function (data)
                {
                    $("#DCRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current DCR records filtered by document title.");
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#DCRwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function refresh(empty)
    {
        $("#DCRwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDocumentList"),
                success: function (data) {
                    $("#DCRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current DCR records.");
                        });

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#DCRwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadGridView(data, empty)
    {
        var xmlDOC= $.parseXML(data);
        var row = empty;

        /* remove all previous records */
        $("#<%=gvDCR.ClientID%> tr").not($("#<%=gvDCR.ClientID%> tr:first-child")).remove();

        $(xmlDOC).find('DocFile').each(function (i, document)
        {
            var xmlDCR = $.parseXML($(this).attr('XMLCCNList'));
            $(xmlDCR).find('CCN').each(function (j, DCR)
            {
                $("td", row).eq(0).html("<img id='edit_" + j + "' src='/Images/edit.png' class='imgButton'/>");
                $("td", row).eq(1).html("<img id='icon_" + j + "' src='/Images/download.png' class='imgButton'/>");

                $("td", row).eq(2).html($(document).attr("DOCNo"));
                $("td", row).eq(3).html($(document).attr("DOCTitle"));
                $("td", row).eq(4).html($(this).attr("CCNType"));
                $("td", row).eq(5).html($(this).attr("Originator"));
                $("td", row).eq(6).html($(this).attr("Owner"));

                var originationdate = new Date($(this).attr("OrginationDate"));
                originationdate.setMinutes(originationdate.getMinutes() + originationdate.getTimezoneOffset());

                $("td", row).eq(7).html(originationdate.format("dd/MM/yyyy"));
                $("td", row).eq(8).html($(this).attr("CCNStatus"));
                $("td", row).eq(9).html($(document).attr("ModeString"));

                $("#<%=gvDCR.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('icon') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            if ($(DCR).attr("DocumentFileName") != '')
                            {
                                /* this will trigger download.ashx to download the attached file*/
                                window.open(getURL().concat('/DocumentDownload.ashx?key=' + $(DCR).attr('CCNID') + '&module=DCR'));
                            }
                            else
                            {
                                alert("There is no associated document for the selected DCR record");
                            }
                        });

                    }
                    else if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            /*clear all fields*/
                            resetGroup('.modalPanel');

                            /*bind DCRID value*/
                            $("#DCRID").val($(DCR).attr('CCNID'));

                            /*bind DCR Type value*/
                            $("#<%=DCRTYPTxt.ClientID%>").val($(DCR).attr('CCNType'));

                            /*bind document version*/
                            $("#<%=DOCVRTxt.ClientID%>").val($(DCR).attr('Version'));

                            /*bind DCR originator*/
                            bindComboboxAjax('loadEmployees', '#<%=ORIGCBox.ClientID%>', $(DCR).attr("Originator"), "#ORIGN_LD");

                            /*bind DCR Owner*/
                            bindComboboxAjax('loadEmployees', '#<%=OWNRCBox.ClientID%>', $(DCR).attr("Owner"), "#Owner_LD");

                            /*bind orgination date value*/
                            $("#<%=ORGNDTTxt.ClientID%>").val(originationdate.format("dd/MM/yyyy"));

                            /*bind DCR status*/
                            bindComboboxAjax('loadDCRStatus', '#<%=DCRSTSCBox.ClientID%>', $(DCR).attr("CCNStatus"), "#DCRSTS_LD");

                            /*bind reason for change*/
                            if ($(DCR).attr("CCNDetails") == '')
                            {
                                addWaterMarkText('Reason for changing the document', '#<%=DCRCHNGTxt.ClientID%>');
                            }
                            else
                            {
                                if ($("#<%=DCRCHNGTxt.ClientID%>").hasClass("watermarktext"))
                                {

                                    $("#<%=DCRCHNGTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=DCRCHNGTxt.ClientID%>").html($(DCR).attr("CCNDetails")).text();
                            }

                            $("#<%=DOCURLTxt.ClientID%>").val($(DCR).attr('DocumentFileURL'));

                            /* check if there is a URL for the document to view*/
                            if ($(DCR).attr('DocumentFileURL') == '') {
                                /*set opacity property to 50% indicating the document view button is disabled by default*/
                                $("#VDOCBTN").css({ opacity: 0.5 });

                                /*disable view button*/
                                disableViewButton(false);
                            }
                            else {
                                /*set opacity property to 100% indicating the document view button is enabled*/
                                $("#VDOCBTN").css({ opacity: 1 });

                                /*activate view button*/
                                disableViewButton(true);
                            }

                            /*load members involved in DCR approval*/
                            var json = $.parseJSON($(DCR).attr('JSONMembers'));

                            var attributes = new Array();
                            attributes.push("Member");
                            attributes.push("MemberType");
                            attributes.push("ApprovalStatusString");
                            attributes.push("ApprovalRemarks");

                            /*set cell settings, and mark cells as readonly in case where DCR status is closed or cancelled*/
                            var settings = new Array();

                          
                            if ($(DCR).attr("CCNStatus") == 'Closed' || $(DCR).attr("CCNStatus") == 'Cancelled')
                            {
                              
                                $("#DCRTooltip").stop(true).hide().fadeIn(800, function () {
                                    $(this).find('p').text("Changes cannot take place since the DCR record is " + $(DCR).attr('CCNStatus'));

                                   
                                });

                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else if ($(document).attr('DOCStatusString') == 'Withdrawn' || $(document).attr('DOCStatusString') == 'Cancelled')
                            {
                              
                                $("#DCRTooltip").stop(true).hide().fadeIn(800, function ()
                                {
                                    $(this).find('p').text("Changes cannot take place since the document is either withdrawn or cancelled");
                                });

                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));


                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else if ($(document).attr('ModeString') == 'Archived')
                            {
                             
                                $("#DCRTooltip").stop(true).hide().fadeIn(800, function () {
                                    $(this).find('p').text("Changes cannot take place since the document was sent to archive");

                                });

                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));


                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else
                            {
                              
                                $("#DCRTooltip").stop(true).hide().fadeIn(800, function () {
                                    $(this).find('p').text("When uploading a file, make sure it is in " + $(document).attr("DOCFileType") + " format");
                                });

                                settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));

                                /*enable all modal controls for editing*/
                                ActivateAll(true);
                            }

                            $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 20 });

                            //activate the first TAB
                            resetTab();

                            /*attach document version to limit plugin*/
                            $('#<%=DOCVRTxt.ClientID%>').limit({ id_result: 'DVlimit', alertClass: 'alertremaining', limit: 50 });
       
                            $('.textbox').each(function ()
                            {
                                $(this).keyup();
                            });

                            /*trigger popup modal pane*/
                            $("#<%=alias.ClientID%>").trigger('click');

                        });
                    }
                });

                row = $("#<%=gvDCR.ClientID%> tr:last-child").clone(true);
            });
        });
    }

    function ActivateAll(isactive)
    {
        if (isactive == false) {
            $(".modalPanel").children().each(function ()
            {

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

    function disableViewButton(enabled)
    {
        if (enabled == false)
        {
            $("#VDOCBTN").attr('disabled', true);

            /*set opacity property to 50% indicating the document view button is disabled by default*/
            $("#VDOCBTN").css({ opacity: 0.5 });

        }
        else
        {
            $("#VDOCBTN").attr('disabled', false);

            /*set opacity property to 100% indicating the document view button is enabled*/
            $("#VDOCBTN").css({ opacity: 1 });

        }
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

    //function hideAll()
    //{
    //    $(".filter").each(function () {
    //        $(this).css('display', 'none');
    //    });
    //}

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

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

</script>


</asp:Content>
