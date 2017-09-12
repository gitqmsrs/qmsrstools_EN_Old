<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.CreateCCN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper"> 
       
    <div id="DCR_Header" class="moduleheader">Create New Document Change Request</div>

    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt=""/> 
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="DOCNOLabel" class="requiredlabel">Document No:</div>
        <div id="DOCNOField" class="fielddiv" style="width:250px;">
            <asp:TextBox ID="DOCNOTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
        </div>

        <div id="DOC_LD" class="control-loader"></div> 

        <span id="DOCSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
    </div>

    <div id="DocumentTooltip" class="tooltip" style="margin-top:10px;">
        <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="SelectDocument" class="selectbox">
        <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />

        <div class="toolbox">
            <div id="filter_div">
                <img id="filter" src="/Images/filter.png" alt=""/>
                <ul id="filterList" class="contextmenu">
                    <li id="byDOC">Filter by Document Name</li>
                    <li id="byDOCTYP">Filter by Document Type</li>
                    <li id="byDOCSTS">Filter by Document Status</li>
                    <li id="byISSUDT">Filter by Issue Date Range</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>

            <div id="closeDOC" class="selectboxclose"></div>
        </div>

        <div id="DOCContainer" class="filter">
            <div id="DocumentNameLabel" class="filterlabel">Document Title:</div>
            <div id="DocumentNameField" class="filterfield">
                <asp:TextBox ID="DOCNMTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
            </div>
        </div>
    
        <div id="RecordModeContainer" class="filter">
            <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
            <div id="RecordModeField" class="filterfield">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RECMODF_LD" class="control-loader"></div>
        </div>
    
        <div id="DOCStatusContainer" class="filter">
            <div id="DOCStatusFilterLabel" class="filterlabel">Document Status:</div>
            <div id="DOCStatusFilterField" class="filterfield">
                <asp:DropDownList ID="DOCSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="DOCSTSF_LD" class="control-loader"></div>
        </div>
    
        <div id="DOCTYPContainer" class="filter">
            <div id="DOCTYPFilterLabel" class="filterlabel">Document Type:</div>
            <div id="DOCTYPFilterField" class="filterfield">
                <asp:DropDownList ID="DOCTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="DOCTYPF_LD" class="control-loader"></div>
        </div>

        <div id="IssueDateContainer" class="filter">
            <div id="IssueDateFLabel" class="filterlabel">Issue Date:</div>
            <div id="IssueDateFField" class="filterfield">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="INSTFDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>

            <ajax:MaskedEditExtender ID="INSTTDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>
        
        <div id="FLTR_LD" class="control-loader"></div> 
    
        <div id="scrollbar" class="gridscroll">
            <asp:GridView id="gvDocuments" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:BoundField DataField="DOCNo" HeaderText="Document No." />
                <asp:BoundField DataField="DOCType" HeaderText="Document Type" />
                <asp:BoundField DataField="DOCTitle" HeaderText="Document Name" />
                <asp:BoundField DataField="IssueDate" HeaderText="IssueDate" />
                <asp:BoundField DataField="LastReviewDate" HeaderText="Last Reviewed" />
                <asp:BoundField DataField="NextReviewDate" HeaderText="Next Review" /> 
                <asp:BoundField DataField="DOCStatusString" HeaderText="Status" />
                <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />           
            </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="DCRGroupHeader" class="groupboxheader">DCR Details</div>
    <div id="DCRGroupField" class="groupbox" style="height:420px">
    
        <div id="validation_dialog_DCR">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="DCR" />
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="DCRTypeLabel" class="requiredlabel">DCR Type:</div>
            <div id="DCRTypeField" class="fielddiv" style="width:150px">
                <asp:DropDownList ID="DCRTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            
            <div id="DCRTYP_LD" class="control-loader"></div> 

            <asp:RequiredFieldValidator ID="DCRTYPTxtVal" runat="server" Display="None" ErrorMessage="Select DCR type" ControlToValidate="DCRTYPCBox" ValidationGroup="DCR">
            </asp:RequiredFieldValidator>
       
            <asp:CompareValidator ID="DCRTYPVal" runat="server" ControlToValidate="DCRTYPCBox" ValidationGroup="DCR"
            Display="None" ErrorMessage="Select DCR type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OriginationDateLabel" class="requiredlabel">Origination Date:</div>
            <div id="OriginationDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ORGNDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>        
            <asp:RequiredFieldValidator ID="ORIGNDTVal" runat="server" Display="None" ControlToValidate="ORGNDTTxt" ErrorMessage="Enter the orgination date of the DCR" ValidationGroup="DCR"></asp:RequiredFieldValidator>
        
            <asp:RegularExpressionValidator ID="ORIGNDTFVal" runat="server" ControlToValidate="ORGNDTTxt" ValidationGroup="DCR"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" CssClass="validator"></asp:RegularExpressionValidator> 
            
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
            <div id="OriginatorLabel" class="requiredlabel">DCR Originator:</div>
            <div id="OrginatorField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="ORIGCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="ORIGN_LD" class="control-loader"></div>       
            
            <span id="ORIGNSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the originator of the document"></span>
      
            <asp:RequiredFieldValidator ID="ORIGTxtVal" runat="server" Display="None" ErrorMessage="Select an originator" ControlToValidate="ORIGCBox" ValidationGroup="DCR">
            </asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="ORIGVal" runat="server" ControlToValidate="ORIGCBox"
            Display="None" ErrorMessage="Select an originator" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="DCR"></asp:CompareValidator>
        </div>
     
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OwnerLabel" class="requiredlabel">DCR Owner:</div>
            <div id="OwnerField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
        
            <div id="Owner_LD" class="control-loader"></div>       
        
            <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the document"></span>
      
            <asp:RequiredFieldValidator ID="OWNRTxtVal" runat="server" Display="None" ErrorMessage="Select an owner" ControlToValidate="OWNRCBox" ValidationGroup="DCR">
            </asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="OWNRVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="DCR"
            Display="None" ErrorMessage="Select an owner" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DCRDetailsLabel" class="labeldiv">Reason for Change:</div>
            <div id="DCRDetailsField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DCRDTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DCRDTLTxtVal" runat="server" ValidationGroup="DCR" 
            ControlToValidate = "DCRDTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>

    </div>

    <div id="SelectORG" class="selectbox">
        <div id="closeORG" class="selectboxclose"></div>

        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="SelectOrganizationLebel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
            <div id="SelectOrganizationField" class="fielddiv" style="width:130px;">
                <asp:DropDownList ID="SORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                </asp:DropDownList> 
            </div>
            <div id="ORG_LD" class="control-loader"></div>   
        </div>
    </div>

    <asp:Panel ID="panel1" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="panel1" PopupControlID="panel1" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

    
    <input id="invoker" type="hidden" value="" />
</div>

<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvDocuments.ClientID%> tr:last-child").clone(true);

        ActivateAll(false);

        addWaterMarkText('Additional details in the support of the DCR', '#<%=DCRDTLTxt.ClientID%>');

        /*disable view button*/
        disableViewButton(false);


        $("#refresh").bind('click', function () {
            hideAll();
            loadDocuments(empty);
        });

        $("#byDOC").bind('click', function () {
            hideAll();
            $("#DOCContainer").show();

        });

        $("#byDOCTYP").bind('click', function () {
            hideAll();
            $("#DOCTYPContainer").show();

            /*load document type*/
            loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYPFCBox.ClientID%>", "#DOCTYPF_LD");
        });

        $("#byDOCSTS").bind('click', function () {
            hideAll();
            $("#DOCStatusContainer").show();

            /*load document status*/
            loadComboboxAjax('loadDocumentStatus', "#<%=DOCSTSFCBox.ClientID%>", "#DOCSTSF_LD");
        });

        $("#byRECMOD").bind('click', function () {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#byISSUDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#IssueDateContainer").show();
        });

        /*filter documents by issue date range*/
        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByIssueDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByIssueDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByIssueDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByIssueDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        /*filter documents according to its status*/
        $("#<%=DOCSTSFCBox.ClientID%>").change(function () {
            filterByDOCStatus($(this).val(), empty);
        });

        /*filter documents according to its type*/
        $("#<%=DOCTYPFCBox.ClientID%>").change(function () {
            filterByDOCType($(this).val(), empty);
        });

        /*filter documents according to its title*/
        $("#<%=DOCNMTxt.ClientID%>").keyup(function ()
        {
            filterByDOC($(this).val(), empty);
        });


        $("#<%=RECMODCBox.ClientID%>").change(function () {
            filterByRecordMode($(this).val(), empty);
        });

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
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

        $("#closeORG").bind('click', function ()
        {
            $("#SelectORG").hide('800');
        });

        /*populate the employees in originatir, and owner cboxes*/
        $("#<%=SORGUNTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                switch ($("#invoker").val())
                {
                    case "Originator":
                        loadcontrols.push("#<%=ORIGCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORIGN_LD");
                        break;
                    case "Owner":
                        loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#Owner_LD");
                        break;
                }

                $("#closeORG").trigger('click');
            }
        });

       
        $("#<%=DOCURLTxt.ClientID%>").keyup(function ()
        {
            if ($(this).val() == '')
            {
                if ($("#VDOCBTN").is(":disabled") == false)
                {
                    /*disable view button*/
                    disableViewButton(false);
                }
            }
            else
            {
                if ($("#VDOCBTN").is(":disabled") == true) {
                    /*enable view button*/
                    disableViewButton(true);
                }
            }
        });

        /*At the current stage, documents can be viewed using google doc viewer tool where a customized document viewer can be added as a future work*/
        $("#VDOCBTN").bind('click', function () {
            window.open('http://docs.google.com/viewer?url=' + $("#<%=DOCURLTxt.ClientID%>").val());
        });

        $("#<%=DOCSelect.ClientID%>").bind('click', function (e)
        {
            hideAll();

            showDocumentDialog(e.pageX, e.pageY, empty);
        });

     
        $("#closeDOC").bind('click', function ()
        {
            $("#SelectDocument").hide('800');
        });

        $("#<%=ORGNDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $(".uploaddiv").bind('click', function ()
        {
            $('input[type=file]').trigger('click');
        });

        $("#fileupload").fileupload(
        {
            dataType: 'json',
            url: 'Upload.ashx',
            add: function (e, data) {
                var fileExtension = data.originalFiles[0]['name'].replace(/^.*\./, '');
                if (fileExtension == "doc" || fileExtension == "docx") {
                    data.submit();
                }
                else {
                    showErrorNotification("Please upload a word document (.doc/.docx) file");
                }
            },
            progress: function (e, data)
            {
                $("#uploadmessage").show();
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $("#uploadmessage").html("Uploading(" + progress + "%)");
            },
            done: function (e, data)
            {
                $.each(data.files, function (index, file) {
                    /*temporarly store the name of the file*/
                    $("#filename").val(file.name);
                });

                $("#uploadmessage").hide("2000");

                $("#<%=DOCFILText.ClientID%>").val(data.result.name);
            },
            fail: function (e, err) {
                $("#uploadmessage").hide("2000");
                showErrorNotification(err.errorThrown);
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate("DCR");
            if (isPageValid)
            {

                if (!$("#validation_dialog_DCR").is(":hidden"))
                {
                    $("#validation_dialog_DCR").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $find('<%= SaveExtender.ClientID %>').show();

                    var orginationDateParts = getDatePart($("#<%=ORGNDTTxt.ClientID%>").val());

                    var newDCR =
                    {
                        CCNTypeString: $("#<%=DCRTYPCBox.ClientID%>").find('option:selected').text(),
                        DocumentFileURL: $("#<%=DOCURLTxt.ClientID%>").val(),
                        DocumentFile: $("#<%=DOCFILText.ClientID%>").val() == '' ? '' : $("#<%=DOCFILText.ClientID%>").val().replace(/\\/g, '/'),
                        DocumentFileName: $("#filename").val(),
                        Originator: $("#<%=ORIGCBox.ClientID%>").find('option:selected').text(),
                        Owner: $("#<%=OWNRCBox.ClientID%>").find('option:selected').text(),
                        OrginationDate: new Date(orginationDateParts[2], (orginationDateParts[1] - 1), orginationDateParts[0]),
                        DCRDetails: $("#<%=DCRDTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DCRDTLTxt.ClientID%>").val())
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(newDCR) + "\','docID':'" + $("#<%=DOCNOTxt.ClientID%>").val() + "'}",
                        url: getServiceURL().concat('createNewDCR'),
                        success: function (data)
                        {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            showSuccessNotification(data.d);

                            resetGroup(".modulewrapper");

                            if (!$("#<%=DCRDTLTxt.ClientID%>").hasClass("watermarktext"))
                            {
                                addWaterMarkText('Additional details in the support of the DCR', '#<%=DCRDTLTxt.ClientID%>');
                            }

                            /*set opacity property to 50% indicating the document view button is disabled by default*/
                            $("#VDOCBTN").css({ opacity: 0.5 });

                            /*disable view button*/
                            disableViewButton(false);

                            ActivateAll(false);

                        },
                        error: function (xhr, status, error)
                        {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(xhr.responseText);
                        }
                    });
                }
            }
            else
            {
                $("#validation_dialog_DCR").stop(true).hide().fadeIn(500, function ()
                {
                    
                });
            }

        });

        $("#<%=DOCNOTxt.ClientID%>").keydown(function (event)
        {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13')
            {
                if (!$("#SelectDocument").is(':hidden'))
                    $("#SelectDocument").hide('800');

                var text = $(this).val();

                $("#DOC_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $(".modulewrapper").css("cursor", "wait");

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'docno':'" + text + "'}",
                        url: getServiceURL().concat('getDocument'),
                        success: function (data)
                        {
                            var xmldocument = $.parseXML(data.d);
                            var document = $(xmldocument).find('DocFile');

                            $("#DOC_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                if (document.attr('DOCStatusString') == 'Withdrawn') {

                                    $("#DocumentTooltip").stop(true).hide().fadeIn(500, function () {
                                        $(this).find('p').html("Cannot create document change request on the selected document since it is withdrawn");

                                        ActivateAll(false);

                                        resetGroup(".modulewrapper");
                                    });

                                }

                                else if (document.attr('DOCStatusString') == 'Cancelled')
                                {
                                    $("#DocumentTooltip").stop(true).hide().fadeIn(500, function () {
                                        $(this).find('p').html("Cannot create document change request on the selected document since it is cancelled");

                                        ActivateAll(false);

                                        resetGroup(".modulewrapper");
                                    });

                                }
                                else if (document.attr('DOCStatusString') == 'Pending')
                                {
                                    $("#DocumentTooltip").stop(true).hide().fadeIn(500, function () {
                                        $(this).find('p').html("The document is on (pending) state, cannot create a document change request until it is issued");

                                        ActivateAll(false);

                                        resetGroup(".modulewrapper");
                                    });
                                }
                                else
                                {
                                    $("#DocumentTooltip").hide();

                                    ActivateAll(true);

                                    var loadcontrols = new Array();
                                    loadcontrols.push('#<%=DCRTYPCBox.ClientID%>');

                                    var docparam = "'ID':'" + text + "'";
                                    loadParamComboboxAjax('loadDCRType', loadcontrols, docparam, "#DCRTYP_LD");
                                }

                            });

                        },
                        error: function (xhr, status, error)
                        {
                            $("#DOC_LD").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        }
                    });
                });
            }
        });
    });
   

    function disableViewButton(enabled)
    {
        if (enabled == false) {
            $(".button").each(function ()
            {
                $(this).attr('disabled', true);

                /*set opacity property to 50% indicating the document view button is disabled by default*/
                $(this).css({ opacity: 0.5 });
            });
        }
        else
        {
            $(".button").each(function ()
            {
                $(this).attr('disabled', false);

                /*set opacity property to 100% indicating the document view button is enabled*/
                $(this).css({ opacity: 1 });
            });
        }
    }

    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
            $(".groupbox").children().each(function ()
            {
                $(this).find('.textbox').each(function ()
                {
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
        else
        {
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

            });

            $('#save').attr("disabled", false);
        }
    }


    function filterByRecordMode(mode, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat("filterDocumentByMode"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByDOCStatus(status, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat("filterDocumentByStatus"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }
    function filterByDOCType(type, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("filterDocumentByType"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByIssueDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#FLTR_LD").stop(true).hide().fadeIn(800, function ()
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
                    url: getServiceURL().concat('filterDocumentsByIssueDate'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                        });
                    }
                });
            });
        }
    }

    function filterByDOC(name, empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'title':'" + name + "'}",
                url: getServiceURL().concat("filterDocumentByName"),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadDocuments(empty)
    {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadDocumentList'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });

                },
                error: function (xhr, status, error)
                {
                    $("#FLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

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

        $("#<%=gvDocuments.ClientID%> tr").not($("#<%=gvDocuments.ClientID%> tr:first-child")).remove();

        $(xml).find("DocFile").each(function (index, value)
        {
            $("td", row).eq(0).html($(this).attr("DOCNo"));
            $("td", row).eq(1).html($(this).attr("DOCType"));
            $("td", row).eq(2).html($(this).attr("DOCTitle"));

            var issuedate = new Date($(this).find("IssueDate").text());
            issuedate.setMinutes(issuedate.getMinutes() + issuedate.getTimezoneOffset());

            $("td", row).eq(3).html($(this).find("IssueDate").text() == '' ? '' : issuedate.format("dd/MM/yyyy"));

            var lastreviewdate = new Date($(this).find("LastReviewDate").text());
            lastreviewdate.setMinutes(lastreviewdate.getMinutes() + lastreviewdate.getTimezoneOffset());

            $("td", row).eq(4).html($(this).find("LastReviewDate").text() == '' ? '' : lastreviewdate.format("dd/MM/yyyy"));

            var nextreviewdate = new Date($(this).find("NextReviewDate").text());
            nextreviewdate.setMinutes(nextreviewdate.getMinutes() + nextreviewdate.getTimezoneOffset());

            $("td", row).eq(5).html($(this).find("NextReviewDate").text() == '' ? '' : nextreviewdate.format("dd/MM/yyyy"));
            $("td", row).eq(6).html($(this).attr("DOCStatusString"));
            $("td", row).eq(7).html($(this).attr("ModeString"));

            $("#<%=gvDocuments.ClientID%>").append(row);
            row = $("#<%=gvDocuments.ClientID%> tr:last-child").clone(true);
        });

        $("#<%=gvDocuments.ClientID%> tr").not($("#<%=gvDocuments.ClientID%> tr:first-child")).bind('click', function ()
        {
            $("#<%=DOCNOTxt.ClientID%>").val($("td", $(this)).eq(0).html());

            var e = jQuery.Event("keydown");
            e.which = 13; // # Some key code value
            $("#<%=DOCNOTxt.ClientID%>").trigger(e);
        });

    }
    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 300, top: y - 10 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#ORG_LD");
        $("#SelectORG").show();
    }


    function showDocumentDialog(x, y, empty)
    {
        loadDocuments(empty);

        $("#SelectDocument").css({ left: x - 280, top: y + 10 });
        $("#SelectDocument").css({ width: 700, height: 250 });
        $("#SelectDocument").show();
    }

    //function hideAll() {
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
