<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageDocument.aspx.cs" Inherits="QMSRSTools.DocumentList.ManageDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
<div id="wrapper" class="modulewrapper">
    
    <div id="DOC_Header" class="moduleheader">Manage Documents</div>

    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byDOC">Filter by Document Name</li>
                <li id="byDOCTYP">Filter by Document Type</li>
                <li id="byISSUDT">Filter by Issue Date Range</li>
                <li id="byDOCSTS">Filter by Document Status</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
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

    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>

    <div id="DOCwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">

    <div id="RAGTooltip" class="tooltip" style="margin-top:20px; background-color:transparent;"> 
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="RED" src="http://www.qmsrs.com/qmsrstools/Images/Red.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Red: Document is overdue for review.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="GREEN" src="http://www.qmsrs.com/qmsrstools/Images/Green.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Green: Document is not due for review.</p>
        </div>
        <div style="float:left;margin-top:2px; margin-left:2px; width:30%">
            <img id="AMBER" src="http://www.qmsrs.com/qmsrstools/Images/Amber.gif" alt="" style="width:20px; float:left" /><p style="font-size:11px;">Amber: Document will be due for review soon.</p>
        </div>
    </div>	

    <asp:GridView id="gvDocuments" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DOCNo" HeaderText="Document No." />
            <asp:BoundField DataField="DOCFType" HeaderText="File Type" />
            <asp:BoundField DataField="DOCType" HeaderText="Type" />
            <asp:BoundField DataField="DOCTitle" HeaderText="Name" />
            <asp:BoundField DataField="DOCRev" HeaderText="Reviewed Every" />
            <asp:BoundField DataField="IssueDate" HeaderText="IssueDate" />
            <asp:BoundField DataField="LastReviewDate" HeaderText="Last Reviewed" />
            <asp:BoundField DataField="NextReviewDate" HeaderText="Next Review" /> 
            <asp:BoundField DataField="DOCStatusString" HeaderText="Status" /> 
            <asp:BoundField DataField="RECMode" HeaderText="REC. Mode" />          
        </Columns>
    </asp:GridView>
</div>

<asp:Button ID="alias" runat="server" style="display:none" />

<ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
</ajax:ModalPopupExtender>

<asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
<div id="header" class="modalHeader">Document Details<span id="close" class="modalclose" title="Close">X</span></div>
    
    <div id="DOCWarning" class="tooltip">
        <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Warning" height="25" width="25" />
        <p></p>
	</div>	

    <div id="SaveTooltip" class="tooltip">
        <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
        <p>Saving...</p>
	</div>
    
    <div id="validation_dialog">
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
    </div>

    <input id="DOCID" type="hidden" value="" />
    
    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="DOCNameLabel" class="requiredlabel">Document Name:</div>
        <div id="DOCNameField" class="fielddiv" style="width:250px">
            <asp:TextBox ID="DOCNTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
        </div>
        <div id="DOCNMlimit" class="textremaining"></div>

        <asp:RequiredFieldValidator ID="DOCNVal" runat="server" Display="None" ControlToValidate="DOCNTxt" ErrorMessage="Enter the name of the document" ValidationGroup="General"></asp:RequiredFieldValidator>
        
        <asp:CustomValidator id="DOCNTxtFVal" runat="server" ValidationGroup="General" Display="None"
        ControlToValidate = "DOCNTxt" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
        ClientValidationFunction="validateSpecialCharacters">
        </asp:CustomValidator>
    </div>
   
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="DOCTYPLabel" class="requiredlabel">Document Type:</div>
        <div id="DOCTYPField" class="fielddiv" style="width:150px">
            <asp:DropDownList ID="DOCTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="DOCTYP_LD" class="control-loader"></div>

        <asp:RequiredFieldValidator ID="DOCTYPCTxtVal" runat="server" Display="None" ControlToValidate="DOCTYPCBox" ErrorMessage="Select document type" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
        <asp:CompareValidator ID="DOCTYPFVal" runat="server" ControlToValidate="DOCTYPCBox" ValidationGroup="General"
        Display="None" ErrorMessage="Select document type" Operator="NotEqual" Style="position: static"
        ValueToCompare="0"></asp:CompareValidator>
    </div>
    
    <div id="organization" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
        <div id="ORGUNTLabel" class="labeldiv">Organization Unit:</div>
        <div id="ORGUNTField" class="fielddiv" style="width:300px">
            <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
            </asp:DropDownList>           
        </div>
        <div id="ORG_LD" class="control-loader"></div>
    </div>
    
    <div id="project" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
        <div id="ProjectLabel" class="labeldiv">Project:</div>
        <div id="ProjectField" class="fielddiv" style="width:250px">
            <asp:DropDownList ID="PROJCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
            </asp:DropDownList>   
        </div>
         <div id="PROJ_LD" class="control-loader"></div>
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="DOCFTYPLabel" class="requiredlabel">Document File Type:</div>
        <div id="DOCFTYPField" class="fielddiv" style="width:150px">
            <asp:DropDownList ID="DOCFTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="DOCFTYP_LD" class="control-loader"></div>
      
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="None" ControlToValidate="DOCFTYPCBox" ErrorMessage="Select document file type" ValidationGroup="General"></asp:RequiredFieldValidator>         
       
        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="DOCFTYPCBox" ValidationGroup="General"
        Display="None" ErrorMessage="Select document file type" Operator="NotEqual" Style="position: static"
        ValueToCompare="0"></asp:CompareValidator>
    </div>
   
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="ReviewDurationLabel" class="requiredlabel">Review Duration</div>
        <div id="ReviewDurationField" class="fielddiv" style="width:200px">
            <asp:TextBox ID="REVDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
            <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:DropDownList ID="REVPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
            </asp:DropDownList>     
        </div>
        <div id="REVPRD_LD" class="control-loader"></div>

        <asp:RequiredFieldValidator ID="REVDURVal" runat="server" Display="None" ControlToValidate="REVDURTxt" ErrorMessage="Enter the review duration of the document (in days)" ValidationGroup="General"></asp:RequiredFieldValidator>
        
        <ajax:FilteredTextBoxExtender ID="REVDURFExt" runat="server" TargetControlID="REVDURTxt" FilterType="Numbers">
        </ajax:FilteredTextBoxExtender>
       
        <asp:CustomValidator id="REVDURTxtFVal" runat="server" ValidationGroup="General" Display="None" 
        ControlToValidate = "REVDURTxt" ErrorMessage = "The review duration should be greater than zero"
        ClientValidationFunction="validateZero">
        </asp:CustomValidator> 
        
        <asp:RequiredFieldValidator ID="REVPRDTxtVal" runat="server" Display="None" ControlToValidate="REVPRDCBox" ErrorMessage="Select review period" ValidationGroup="General"></asp:RequiredFieldValidator>         
       
        <asp:CompareValidator ID="REVPRDVal" runat="server" ControlToValidate="REVPRDCBox" ValidationGroup="General"
        Display="None" ErrorMessage="Select review period" Operator="NotEqual" Style="position: static"
        ValueToCompare="0"></asp:CompareValidator>
    </div>
   
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="REVDURDAYLabel" class="labeldiv">Review Duration in Days:</div>
        <div id="REVDURDAYField" class="fielddiv" style="width:100px">
            <asp:TextBox ID="REVDURDAYTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="90px"></asp:TextBox>
        </div>
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="IssueDateLabel" class="labeldiv">Issue Date</div>
        <div id="IssueDateField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="ISSUDTTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
        </div>      
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="LastReviewDateLabel" class="labeldiv">Last Review Date</div>
        <div id="LastReviewDateField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="LREVDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
        </div> 
        <asp:RegularExpressionValidator ID="LREVDTTxtFVal" runat="server" ControlToValidate="LREVDTTxt"
        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  
   
        <asp:CompareValidator ID="LREVDTVal" runat="server" ControlToCompare="ISSUDTTxt"
        ControlToValidate="LREVDTTxt" ErrorMessage="Last review date should be greater or equals the issue date of the document"  ValidationGroup="General"
        Operator="GreaterThanEqual" Type="Date"
        Display="None"></asp:CompareValidator>     
        
        <asp:CustomValidator id="LREVDTTxtF2Val" runat="server" ValidationGroup="General" 
        ControlToValidate = "LREVDTTxt" Display="None" ErrorMessage = "Last review date shouldn't be in future"
        ClientValidationFunction="comparePast">
        </asp:CustomValidator>     

        <asp:CustomValidator id="LREVDTTxtF3Val" runat="server" ValidationGroup="General" 
        ControlToValidate = "LREVDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
        ClientValidationFunction="validateDate">
        </asp:CustomValidator>
    </div>
    
    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="NextReviewDateLabel" class="labeldiv">Next Review Date</div>
        <div id="NextReviewDateField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="NXTREVDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
        </div> 
       
        <asp:RegularExpressionValidator ID="NXTREVDTTxtFVal" runat="server" ControlToValidate="NXTREVDTTxt"
        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        
        <asp:CompareValidator ID="NXTREVDTTxtF2Val" runat="server" ControlToCompare="LREVDTTxt"
        ControlToValidate="NXTREVDTTxt" ErrorMessage="Next review date should be greater or equals the last review date of the document"  ValidationGroup="General"
        Operator="GreaterThan" Type="Date"
        Display="None"></asp:CompareValidator>  

        <asp:CustomValidator id="NXTREVDTTxtF3Val" runat="server" ValidationGroup="General" 
        ControlToValidate = "NXTREVDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
        ClientValidationFunction="validateDate">
        </asp:CustomValidator> 
    </div>
   
   <div style="float:left; width:100%; height:20px; margin-top:15px;">
       <div id="RemarksLabel" class="labeldiv">Remarks</div>
       <div id="RemarksField" class="fielddiv" style="width:400px;">
            <asp:TextBox ID="RMKTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
       </div> 
       <asp:CustomValidator id="RMKTxtVal" runat="server" ValidationGroup="General" 
       ControlToValidate = "RMKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
       ClientValidationFunction="validateSpecialCharactersLongText">
       </asp:CustomValidator>
   </div>

   <div style="float:left; width:100%; height:20px; margin-top:122px;">
        <div id="DOCStatusLabel" class="labeldiv">Status</div>
        <div id="DOCStatusField" class="fielddiv" style="width:150px">
            <asp:TextBox ID="DOCSTSTxt" runat="server"  CssClass="readonly" Width="140px" ReadOnly="true" ></asp:TextBox>
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
        var empty = $("#<%=gvDocuments.ClientID%> tr:last-child").clone(true);

        /*get all document list*/
        loadDocuments(empty);

        $("#refresh").bind('click', function () {
            hideAll();
            loadDocuments(empty);
        });

        $("#byDOC").bind('click', function () {
            hideAll();
            $("#DOCContainer").show();

        });


        $("#byISSUDT").bind('click', function ()
        {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#IssueDateContainer").show();
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

        /*filter documents according to its status*/
        $("#<%=DOCSTSFCBox.ClientID%>").change(function () {
            filterByDOCStatus($(this).val(), empty);
        });

        /*filter documents according to its type*/
        $("#<%=DOCTYPFCBox.ClientID%>").change(function () {
            filterByDOCType($(this).val(), empty);
        });

        /*filter documents according to its title*/
        $("#<%=DOCNMTxt.ClientID%>").keyup(function () {
            filterByDOC($(this).val(), empty);
        });


        $("#<%=RECMODCBox.ClientID%>").change(function () {
            filterByRecordMode($(this).val(), empty);
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
            onSelect: function (date)
            {
                filterByIssueDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('General');
            if (isPageValid)
            {
                if (!$("#validation_dialog").is(":hidden"))
                {
                    $("#validation_dialog").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        var lrevpart = getDatePart($("#<%=LREVDTTxt.ClientID%>").val());
                        var nrevpart = getDatePart($("#<%=NXTREVDTTxt.ClientID%>").val());

                        var modifedDocument =
                        {
                            DOCNo: $("#DOCID").val(),
                            DOCTitle: $("#<%=DOCNTxt.ClientID%>").val(),
                            DOCType: ($("#<%=DOCTYPCBox.ClientID%>").val() == 0 || $("#<%=DOCTYPCBox.ClientID%>").val() == null ? '' : $("#<%=DOCTYPCBox.ClientID%>").val()),
                            DOCFileType: ($("#<%=DOCFTYPCBox.ClientID%>").val() == 0 || $("#<%=DOCFTYPCBox.ClientID%>").val() == null ? '' : $("#<%=DOCFTYPCBox.ClientID%>").val()),
                            Department: ($("#<%=ORGUNTCBox.ClientID%>").val() == 0 || $("#<%=ORGUNTCBox.ClientID%>").val() == null ? '' : $("#<%=ORGUNTCBox.ClientID%>").val()),
                            Project: ($("#<%=PROJCBox.ClientID%>").val() == 0 || $("#<%=PROJCBox.ClientID%>").val() == null ? '' : $("#<%=PROJCBox.ClientID%>").val()),
                            LastReviewDate: lrevpart == '' ? null : new Date(lrevpart[2], (lrevpart[1] - 1), lrevpart[0]),
                            NextReviewDate: nrevpart == '' ? null : new Date(nrevpart[2], (nrevpart[1] - 1), nrevpart[0]),
                            ReviewDuration: $("#<%=REVDURTxt.ClientID%>").val(),
                            ReviewPeriod: $("#<%=REVPRDCBox.ClientID%>").find('option:selected').text(),
                            DOCStatusString: $("#<%=DOCSTSTxt.ClientID%>").val(),
                            ReviewDurationDays: $("#<%=REVDURDAYTxt.ClientID%>").val(),
                            Remarks: $("#<%=RMKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMKTxt.ClientID%>").val())
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(modifedDocument) + "\'}",
                            url: getServiceURL().concat('updateDocument'),
                            success: function (data) {
                                $("#SaveTooltip").fadeOut(500, function ()
                                {
                                    ActivateSave(true);

                                    showSuccessNotification(data.d);

                                    $("#cancel").trigger('click');
                                    $("#refresh").trigger('click');
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
                $("#validation_dialog").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });

        $("#<%=REVPRDCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var period = $(this).val();
                var duration = parseInt($("#<%=REVDURTxt.ClientID%>").val());

                setExpiryDate($("#<%=LREVDTTxt.ClientID%>").val(), duration, period);

                if ($("#<%=REVDURTxt.ClientID%>").val() != '') {
                    $("#<%=REVDURDAYTxt.ClientID%>").val(convertDays($("#<%=REVDURTxt.ClientID%>").val(), $(this).val()));
                }
            }
        });

        $("#<%=LREVDTTxt.ClientID%>").keyup(function () {
            var period = $("#<%=REVPRDCBox.ClientID%>").find('option:selected').text();
            var duration = parseInt($("#<%=REVDURTxt.ClientID%>").val());

            setExpiryDate($(this).val(), duration, period);
        });

        $("#<%=REVDURTxt.ClientID%>").keyup(function () {
            if ($("#<%=REVPRDCBox.ClientID%>").val() != 0) {
                var period = $("#<%=REVPRDCBox.ClientID%>").val();
                var duration = parseInt($(this).val());

                setExpiryDate($("#<%=LREVDTTxt.ClientID%>").val(), duration, period);

                $("#<%=REVDURDAYTxt.ClientID%>").val(convertDays(duration, period));
            }
        });

        $("#<%=LREVDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                var period = $("#<%=REVPRDCBox.ClientID%>").find('option:selected').text();
                var duration = parseInt($("#<%=REVDURTxt.ClientID%>").val());

                setExpiryDate(date, duration, period);
            }
        });

        $("#<%=NXTREVDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function ()
            {}
        });

        $("#<%=DOCTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() == 'Origanizational')
            {
                if (!$("project").is(":hidden"))
                    $("#project").hide();

                $("#organization").show();

                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
            }
            else if ($(this).val() == 'Project')
            {
                if (!$("organization").is(":hidden"))
                    $("#organization").hide();

                $("#project").show();

                loadProjects();
            }
         });
    });

    function convertDays(duration, period)
    {
        var days = 0;

        switch (period) {
            case "Years":
                days = duration * 365;
                break;
            case "Months":
                days = duration * 30;
                break;
            case "Days":
                days = duration * 1;
                break;
        }
        return days;
    }

    function filterByRecordMode(mode, empty)
    {
        $("#DOCwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat("filterDocumentByMode"),
                success: function (data) {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(500, function () {

                            $(this).find('p').html("List of all documents filterd according to their mode. <br/> Note:Withdrawn, cancelled, archived, or pending documents cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#DOCwait").fadeOut(500, function ()
                    {
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
    
    function filterByDOCStatus(status, empty)
    {
        $("#DOCwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat("filterDocumentByStatus"),
                success: function (data)
                {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(500, function () {

                            $(this).find('p').text("List of all current documents filterd by their status. <br/> Note:Withdrawn, cancelled, archived, or pending documents cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByDOCType(type, empty)
    {
        $("#DOCwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("filterDocumentByType"),
                success: function (data) {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').html("List of all current documents filterd by their type. <br/> Note:Withdrawn, cancelled, archived, or pending documents cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByIssueDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true)
        {
            $("#DOCwait").stop(true).hide().fadeIn(800, function () {
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
                        $("#DOCwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').html("List of all current documents filterd by their issue date range. <br/> Note:Withdrawn, cancelled, archived, or pending documents cannot be modified");
                            });

                            /* show module tooltip */
                            $("#RAGTooltip").stop(true).hide().fadeIn(500, function () {
                                $(this).slideDown(800, 'easeOutBounce');
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#DOCwait").fadeOut(500, function () {
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

    function filterByDOC(name, empty)
    {
        $("#DOCwait").stop(true).hide().fadeIn(500, function ()
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
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            $(this).find('p').html("List of all current documents filterd by their title. <br/> Note:Withdrawn, cancelled, archived, or pending documents cannot be modified");
                        });

                        /* show module tooltip */
                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadDocuments(empty)
    {
        $("#DOCwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadDocumentList'),
                success: function (data)
                {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                        {
                            $(this).find('p').html("List of all current documents. <br/> Note:Withdrawn, cancelled, archived, or pending documents cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#DOCwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function ()
                        {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function removeDocument(docID, empty)
    {
        var result = confirm("Are you sure you would like to remove the selected document, and all its related CCN records (If Any)?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'ID':'" + docID + "'}",
                url: getServiceURL().concat('removeDocument'),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");

                    $("#refresh").trigger('click');
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

    function loadGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvDocuments.ClientID%> tr").not($("#<%=gvDocuments.ClientID%> tr:first-child")).remove();

        $(xml).find("DocFile").each(function (index, value)
        {
            /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
            var date = new Date();

            $("td", row).eq(0).html("<img id='icon_" + index + "' src='http://www.qmsrs.com/qmsrstools/RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('DOCID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
            $("td", row).eq(1).html("<img id='delete_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(2).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");

            $("td", row).eq(3).html($(this).attr("DOCNo"));
            $("td", row).eq(4).html($(this).attr("DOCFileType"));
            $("td", row).eq(5).html($(this).attr("DOCType"));
            $("td", row).eq(6).html($(this).attr("DOCTitle"));
            $("td", row).eq(7).html($(this).attr("ReviewDuration") + " " + $(this).attr("ReviewPeriod"));
            $("td", row).eq(8).html($(this).find("IssueDate").text() == '' ? '' : new Date($(this).find("IssueDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(9).html($(this).find("LastReviewDate").text() == '' ? '' : new Date($(this).find("LastReviewDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(10).html($(this).find("NextReviewDate").text() == '' ? '' : new Date($(this).find("NextReviewDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(11).html($(this).attr("DOCStatusString"));
            $("td", row).eq(12).html($(this).attr("ModeString"));

            $("#<%=gvDocuments.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('edit') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        /*clear all fields*/
                        resetGroup('.modalPanel');

                        /*bind document ID*/
                        $("#DOCID").val($(value).attr("DOCNo"));

                        /*bind document name*/
                        $("#<%=DOCNTxt.ClientID%>").val($(value).attr("DOCTitle"));

                        /*bind review duration*/
                        $("#<%=REVDURTxt.ClientID%>").val($(value).attr("ReviewDuration"));

                        /*bind review duration days*/
                        $("#<%=REVDURDAYTxt.ClientID%>").val($(value).attr("ReviewDurationDays"));

                        /*bind document remarks*/
                        if ($(value).attr("Remarks") == '')
                        {
                            addWaterMarkText('Additional details in the support of the document', '#<%=RMKTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=RMKTxt.ClientID%>").hasClass("watermarktext"))

                            {
                                $("#<%=RMKTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=RMKTxt.ClientID%>").html($(value).attr("Remarks")).val();
                        }

                        /*bind issue date*/
                        $("#<%=ISSUDTTxt.ClientID%>").val($(value).find("IssueDate").text() == '' ? '' : new Date($(value).find("IssueDate").text()).format("dd/MM/yyyy"));

                        /*bind last review date*/
                        $("#<%=LREVDTTxt.ClientID%>").val($(value).find("LastReviewDate").text() == '' ? '' : new Date($(value).find("LastReviewDate").text()).format("dd/MM/yyyy"));

                        /*bind next review date*/
                        $("#<%=NXTREVDTTxt.ClientID%>").val($(value).find("NextReviewDate").text() == '' ? '' : new Date($(value).find("NextReviewDate").text()).format("dd/MM/yyyy"));

                        /*bind document file type*/
                        bindComboboxAjax('loadDocumentFileTypes', '#<%=DOCFTYPCBox.ClientID%>', $(value).attr("DOCFileType"), "#DOCFTYP_LD");

                        /*bind document type*/
                        bindComboboxAjax('loadDocumentTypes', '#<%=DOCTYPCBox.ClientID%>', $(value).attr("DOCType"), "#DOCTYP_LD");

                        /*bind review period*/
                        bindComboboxAjax('loadPeriod', '#<%=REVPRDCBox.ClientID%>', $(value).attr("ReviewPeriod"), "#REVPRD_LD");

                        /*bind document status*/
                        $("#<%=DOCSTSTxt.ClientID%>").val($(value).attr("DOCStatusString"));

                        /*Check if the document is withdrawn or pending so that it may enable or disable changes*/
                        if ($(value).attr('DOCStatusString') == 'Pending')
                        {
                            $("#DOCWarning").find('p').html("Changes cannot be made since the document is in pending state.<br/> The DCR must be approved prior to issuing the document.");

                            if ($("#DOCWarning").is(":hidden"))
                            {
                                $("#DOCWarning").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else if ($(value).attr('DOCStatusString') == 'Withdrawn' || $(value).attr('DOCStatusString') == 'Cancelled')
                        {
                            $("#DOCWarning").find('p').html("Changes cannot be made since the document is " + $(value).attr('DOCStatusString'));

                            if ($("#DOCWarning").is(":hidden")) {
                                $("#DOCWarning").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else {
                            $("#DOCWarning").hide();

                            /*enable all modal controls for editing*/
                            ActivateAll(true);
                        }

                        /*attach the title of the document to limit plugin*/
                        $('#<%=DOCNTxt.ClientID%>').limit({ id_result: 'DOCNMlimit', alertClass: 'alertremaining', limit: 90 });

                       
                        switch ($(value).attr('DOCType'))
                        {
                            case "Origanizational":
                                $("#project").hide();
                                $("#organization").show();
                                bindComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", $(value).attr('Department'));

                                break;
                            case "Project":
                                $("#organization").hide();
                                $("#project").show();
                                bindProjects($(value).attr('Project'));
                                break;
                        }

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }
                else if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeDocument($(value).attr('DOCID'), empty);
                    });
                }

            });
            row = $("#<%=gvDocuments.ClientID%> tr:last-child").clone(true);
        });
    }

    function setExpiryDate(date, duration, period)
    {
        var sd = getDatePart(date);

        var startDate = new Date(sd[2], (sd[1] - 1), sd[0]);

        if (isNaN(startDate) == false) {
            switch (period) {
                case "Years":
                    $("#<%=NXTREVDTTxt.ClientID%>").val(startDate.addYears(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
                case "Months":
                    $("#<%=NXTREVDTTxt.ClientID%>").val(startDate.addMonths(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
                case "Days":
                    $("#<%=NXTREVDTTxt.ClientID%>").val(startDate.addDays(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
            }
        }
    }

    function loadProjects()
    {
        $("#PROJ_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProjects"),
                success: function (data) {
                    $("#PROJ_LD").fadeOut(500, function () {
                        if (data)
                        {
                            loadComboboxXML($.parseXML(data.d), 'Project', 'ProjectName', $("#<%=PROJCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJ_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function bindProjects(project)
    {
        $("#PROJ_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadProjects"),
                success: function (data)
                {
                    $("#PROJ_LD").fadeOut(500, function ()
                    {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'Project', 'ProjectName', project, $("#<%=PROJCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PROJ_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
            $(".textbox").each(function () {
                $(this).removeClass("textbox");
                $(this).addClass("readonlycontrolled");
                $(this).attr('readonly', true);
            });
            $(".combobox").each(function () {
                $(this).attr('disabled', true);
            });

            $('#save').attr("disabled", true);
            $("#save").css({ opacity: 0.5 });
        }
        else
        {
            $(".readonlycontrolled").each(function () {
                $(this).removeClass("readonlycontrolled");
                $(this).addClass("textbox");
                $(this).attr('readonly', false);
            });


            $(".combobox").each(function () {
                $(this).attr('disabled', false);
            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }


    function ActivateSave(isactive)
    {
        if (isactive == false)
        {
            $(".modalPanel").css("cursor", "wait");

            $('.button').attr("disabled", true);
            $('.button').css({ opacity: 0.5 });
        }
        else
        {
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
