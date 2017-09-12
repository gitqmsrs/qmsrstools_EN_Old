<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.CreateCCN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper"> 
       
    <div id="CCN_Header" class="moduleheader">Create New Document Change Request</div>

    <div class="toolbox">
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt=""/> 
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="DOCNOLabel" class="requiredlabel">Document No:</div>
        <div id="DOCNOField" class="fielddiv" style="width:250px;">
            <asp:TextBox ID="DOCNOTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
        </div>

        <div id="DOC_LD" class="control-loader"></div> 

        <span id="DOCSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
    </div>

    <div id="SelectDocument" class="selectbox" style="width:650px; height:250px; top:80px; left:150px;">
        <div class="toolbox">
            <img id="refresh" src="../Images/refresh.png" class="selectBoxImg" title="Refresh Data" alt="" />
            <img id="deletefilter" src="../Images/filter-delete-icon.png" class="selectBoxImg" alt=""/>

            <div id="filter_div">
                <img id="filter" src="../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byDOC">Filter by Document Name</li>
                    <li id="byDOCTYP">Filter by Document Type</li>
                    <li id="byDOCSTS">Filter by Document Status</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>

            <div id="DOCContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="DocumentNameLabel" style="width:100px;">Title:</div>
                <div id="DocumentNameField" style="width:150px; left:0; float:left;">
                    <asp:TextBox ID="DOCNMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
                </div>
            </div>
    
            <div id="RecordModeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
                <div id="RecordModeField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RECMODF_LD" class="control-loader"></div>
            </div>
    
            <div id="DOCStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="DOCStatusFilterLabel" style="width:100px;">Document Status:</div>
                <div id="DOCStatusFilterField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="DOCSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="DOCSTSF_LD" class="control-loader"></div>
            </div>
    
            <div id="DOCTYPContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="DOCTYPFilterLabel" style="width:100px;">Document Type:</div>
                <div id="DOCTYPFilterField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="DOCTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                 <div id="DOCTYPF_LD" class="control-loader"></div>
            </div>

            <div id="closeDOC" class="selectboxclose"></div>
        </div>

        <div id="FLTR_LD" class="control-loader"></div> 
    
        <div id="scrollbar" style="height:250px; width:96%; overflow:auto; margin-top:15px; float:left">
            <asp:GridView id="gvDocuments" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:BoundField DataField="DOCNo" HeaderText="Document No." />
                <asp:BoundField DataField="DOCType" HeaderText="Document Type" />
                <asp:BoundField DataField="DOCTitle" HeaderText="Document Name" />
                <asp:BoundField DataField="IssueDate" HeaderText="IssueDate" />
                <asp:BoundField DataField="LastReviewDate" HeaderText="Last Reviewed" />
                <asp:BoundField DataField="NextReviewDate" HeaderText="Next Review" /> 
                <asp:BoundField DataField="DOCStatusString" HeaderText="Status" />           
            </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="CCNGroupHeader" class="groupboxheader">CCN Details</div>
    <div id="CCNGroupField" class="groupbox" style="height:420px">
    
        <div id="validation_dialog_ccn" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="CCN" />
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CCNTypeLabel" class="requiredlabel">CCN Type:</div>
            <div id="CCNTypeField" class="fielddiv" style="width:150px">
                <asp:DropDownList ID="CCNTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            
            <div id="CCNTYP_LD" class="control-loader"></div> 

            <asp:RequiredFieldValidator ID="CCNTYPTxtVal" runat="server" Display="None" ErrorMessage="Select CCN type" ControlToValidate="CCNTYPCBox" ValidationGroup="CCN">
            </asp:RequiredFieldValidator>
       
            <asp:CompareValidator ID="CCNTYPVal" runat="server" ControlToValidate="CCNTYPCBox" ValidationGroup="CCN"
            Display="None" ErrorMessage="Select CCN type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OriginationDateLabel" class="requiredlabel">Origination Date:</div>
            <div id="OriginationDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ORGNDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>        
            <asp:RequiredFieldValidator ID="ORIGNDTVal" runat="server" Display="None" ControlToValidate="ORGNDTTxt" ErrorMessage="Enter the orgination date of the CCN" ValidationGroup="CCN"></asp:RequiredFieldValidator>
        
            <asp:RegularExpressionValidator ID="ORIGNDTFVal" runat="server" ControlToValidate="ORGNDTTxt" ValidationGroup="CCN"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" CssClass="validator"></asp:RegularExpressionValidator> 
            
            <asp:CustomValidator id="ORGNDTF2Val" runat="server" ValidationGroup="CCN" Display="None"  
            ControlToValidate = "ORGNDTTxt" ErrorMessage = "Origination date should equals today's date"
            ClientValidationFunction="compareEqualsToday">
            </asp:CustomValidator> 

            <asp:CustomValidator id="ORGNDTF3Val" runat="server" ValidationGroup="CCN" 
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
            Display="None" ErrorMessage="invalid URL e.g.(http://www.example.com) or (www.example.com)" ValidationExpression="^(http(s)?\://)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+\s&amp;%\$#\=~])*$" ValidationGroup="CCN"></asp:RegularExpressionValidator> 
     
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DocumentFileLabel" class="labeldiv">Document File:</div>
            <div id="DocumentFileField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="DOCFILText" CssClass="readonly" runat="server" Width="390px" ReadOnly="true"></asp:TextBox>
                <div class="uploaddiv"></div>
                <input id="fileupload" type="file" name="file" style="width:0; height:0; display:block;"/>
                <div id="uploadmessage"></div>
            </div>
        </div>
     
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OriginatorLabel" class="requiredlabel">CCN Originator:</div>
            <div id="OrginatorField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="ORIGCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="ORIGN_LD" class="control-loader"></div>       
            
            <span id="ORIGNSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the originator of the document"></span>
      
            <asp:RequiredFieldValidator ID="ORIGTxtVal" runat="server" Display="None" ErrorMessage="Select an originator" ControlToValidate="ORIGCBox" ValidationGroup="CCN">
            </asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="ORIGVal" runat="server" ControlToValidate="ORIGCBox"
            Display="None" ErrorMessage="Select an originator" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="CCN"></asp:CompareValidator>
        </div>
     
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OwnerLabel" class="requiredlabel">CCN Owner:</div>
            <div id="OwnerField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
        
            <div id="Owner_LD" class="control-loader"></div>       
        
            <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the document"></span>
      
            <asp:RequiredFieldValidator ID="OWNRTxtVal" runat="server" Display="None" ErrorMessage="Select an owner" ControlToValidate="OWNRCBox" ValidationGroup="CCN">
            </asp:RequiredFieldValidator>
        
            <asp:CompareValidator ID="OWNRVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="CCN"
            Display="None" ErrorMessage="Select an owner" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CCNDetailsLabel" class="labeldiv">Reason for Change:</div>
            <div id="CCNDetailsField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="CCNDTLTxt" runat="server"  CssClass="textbox" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="CCNDTLTxtVal" runat="server" ValidationGroup="CCN" 
            ControlToValidate = "CCNDTLTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
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

        addWaterMarkText('Additional details in the support of the CCN', '#<%=CCNDTLTxt.ClientID%>');

        /*disable view button*/
        disableViewButton(false);


        $("#deletefilter").bind('click', function () {
            hideAll();
            loadDocuments(empty);
        });


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

        $("#<%=DOCSelect.ClientID%>").bind('click', function ()
        {
            loadDocuments(empty);

            $("#SelectDocument").show();
        });

        /*filter documents according to title*/
        $("#<%=DOCNMTxt.ClientID%>").keyup(function ()
        {
            filterDOC($(this).val(), empty);
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
            url: '../Upload.ashx',
            progress: function (e, data) {
                $("#uploadmessage").show();
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $("#uploadmessage").html("Uploading(" + progress + "%)");
            },
            done: function (e, data) {
                $("#uploadmessage").hide("2000");

                $("#<%=DOCFILText.ClientID%>").val(data.result.name);
            },
            fail: function (e, err) {
                $("#uploadmessage").hide("2000");
                alert(err.errorThrown);
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate("CCN");
            if (isPageValid)
            {

                if (!$("#validation_dialog_ccn").is(":hidden"))
                {
                    $("#validation_dialog_ccn").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    var orginationDateParts = getDatePart($("#<%=ORGNDTTxt.ClientID%>").val());

                    var newCCN =
                    {
                        CCNTypeString: $("#<%=CCNTYPCBox.ClientID%>").find('option:selected').text(),
                        DocumentFileURL: $("#<%=DOCURLTxt.ClientID%>").val(),
                        DocumentFile: $("#<%=DOCFILText.ClientID%>").val() == '' ? '' : $("#<%=DOCFILText.ClientID%>").val().replace(/\\/g, '/'),
                        Originator: $("#<%=ORIGCBox.ClientID%>").find('option:selected').text(),
                        Owner: $("#<%=OWNRCBox.ClientID%>").find('option:selected').text(),
                        OrginationDate: new Date(orginationDateParts[2], (orginationDateParts[1] - 1), orginationDateParts[0]),
                        CCNDetails: $("#<%=CCNDTLTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=CCNDTLTxt.ClientID%>").val())
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(newCCN) + "\','docID':'" + $("#<%=DOCNOTxt.ClientID%>").val() + "'}",
                        url: getServiceURL().concat('createNewCCN'),
                        success: function (data)
                        {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            alert(data.d);

                            addWaterMarkText('Additional details in the support of the CCN', '#<%=CCNDTLTxt.ClientID%>');
                            reset();

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
                            alert(xhr.responseText);
                        }
                    });
                }
            }
            else
            {
                $("#validation_dialog_ccn").stop(true).hide().fadeIn(500, function ()
                {
                    alert('Please make sure that all warnings highlighted in red color are fulfilled');
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

                                if (document.attr('DOCStatusString') == 'Withdrawn')
                                {
                                    alert('Cannot create CCN record on this document since it is withdrawn');

                                    ActivateAll(false);
                                }

                                else if (document.attr('DOCStatusString') == 'Cancelled')
                                {
                                    alert('Cannot create CCN record on this document since it is cancelled');

                                    ActivateAll(false);
                                }
                                else if (document.attr('DOCStatusString') == 'Pending')
                                {
                                    alert('The document is on (pending) state, cannot create CCN until the document is issued');
                                    
                                    ActivateAll(false);
                                }
                                else if (document.attr('ModeString') == 'Archived')
                                {
                                    alert('Cannot create CCN record on this document since was sent to archive');
                                    
                                    ActivateAll(false);
                                }
                                else
                                {
                                    ActivateAll(true);

                                    var loadcontrols = new Array();
                                    loadcontrols.push('#<%=CCNTYPCBox.ClientID%>');

                                    var docparam = "'ID':'" + text + "'";
                                    loadParamComboboxAjax('loadCCNType', loadcontrols, docparam, "#CCNTYP_LD");
                                }

                            });

                        },
                        error: function (xhr, status, error)
                        {
                            $("#DOC_LD").fadeOut(500, function ()
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
                        alert(r.Message);
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
                        alert(r.Message);
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
                        alert(r.Message);
                    });
                }
            });
        });
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
                        alert(r.Message);
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

        $("#<%=gvDocuments.ClientID%> tr").not($("#<%=gvDocuments.ClientID%> tr:first-child")).remove();

        $(xml).find("DocFile").each(function (index, value)
        {
            $("td", row).eq(0).html($(this).attr("DOCNo"));
            $("td", row).eq(1).html($(this).attr("DOCType"));
            $("td", row).eq(2).html($(this).attr("DOCTitle"));
            $("td", row).eq(3).html($(this).find("IssueDate").text() == '' ? '' : new Date($(this).find("IssueDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(4).html($(this).find("LastReviewDate").text() == '' ? '' : new Date($(this).find("LastReviewDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(5).html($(this).find("NextReviewDate").text() == '' ? '' : new Date($(this).find("NextReviewDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(6).html($(this).attr("DOCStatusString"));

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

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
