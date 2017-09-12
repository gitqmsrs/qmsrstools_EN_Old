<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.ManageCCN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper"> 

    <div id="CCN_Header" class="moduleheader">Manage Document Change Requests</div>

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
   
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byDOC">Filter by Document</li>
                <li id="byCCNTYP">Filter by DCR Type</li>
                <li id="byRECMOD">Filter by Document's Record Mode</li>
            </ul>
        </div>

        <div id="DOCContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="DocumentNameLabel" style="width:100px;">Title:</div>
            <div id="DocumentNameField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="DOCNMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
            </div>
        </div>

        <div id="CCNTYPContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CCNTYPLabel" style="width:100px;">DCR Type:</div>
            <div id="CCNTYPField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="CCNTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="CCNTYPF_LD" class="control-loader"></div>
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

    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="../Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <div id="ccnwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:100%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvCCN" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
        GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
        <Columns>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="DocumentNo" HeaderText="Document No" />
            <asp:BoundField DataField="Title" HeaderText="Document Name" />
            <asp:BoundField DataField="CCNType" HeaderText="CCN Type" />
            <asp:BoundField DataField="Originator" HeaderText="Originator" />
            <asp:BoundField DataField="Owner" HeaderText="Owner" />
            <asp:BoundField DataField="OrginationDate" HeaderText="Origination Date" />
            <asp:BoundField DataField="CCNStatus" HeaderText="Status" />
        </Columns>
        </asp:GridView>
    </div>
   
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
    
        <div id="header" class="modalHeader">Document Change Request Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="CCNTooltip" class="tooltip">
            <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>	

        <div id="CCNFileDownload" class="tooltip">
            <img src="#" alt="Download" height="25" width="25" />
            <p></p>
   	    </div>
    
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <ul id="tabul" style="margin-top:45px;">
            <li id="CCNDetails" class="ntabs">CCN Info</li>
            <li id="CCNMembers" class="ntabs">Approval Members</li>
        </ul>

        <div id="CCNDetailsTB" class="tabcontent" style="display:none; height:450px;">

            <div id="validation_dialog_ccn" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="CCN" />
            </div>

            <input id="CCNID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="CCNTypeLabel" class="labeldiv">CCN Type:</div>
                <div id="CCNTypeField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="CCNTYPTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
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
                <div id="OriginatorLabel" class="requiredlabel">CCN Originator:</div>
                <div id="OrginatorField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="ORIGCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="ORIGN_LD" class="control-loader"></div>       
            
                <span id="ORIGNSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the originator of the document"></span>
      
                <asp:RequiredFieldValidator ID="ORIGTxtVal" runat="server" Display="None" ControlToValidate="ORIGCBox" ErrorMessage="Select an originator" ValidationGroup="CCN"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="ORIGVal" runat="server" ControlToValidate="ORIGCBox" ValidationGroup="CCN"
                Display="None" ErrorMessage="Select an originator" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="IssuerLabel" class="requiredlabel">CCN Owner:</div>
                <div id="IssuerField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="Owner_LD" class="control-loader"></div>       
                
                <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the document"></span>
            
                <asp:RequiredFieldValidator ID="OWNRTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select an owner" ValidationGroup="CCN"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="OWNRVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="CCN"
                Display="None" ErrorMessage="Select an owner" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
     
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OriginationDateLabel" class="requiredlabel">Origination Date:</div>
                <div id="OriginationDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ORGNDTTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>           
                </div>        
            
                <asp:RequiredFieldValidator ID="ORIGNDTVal" runat="server" Display="None" ControlToValidate="ORGNDTTxt" ValidationGroup="CCN" ErrorMessage="Enter the orgination date of the CCN"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="ORIGNDTFVal" runat="server" Display="None" ControlToValidate="ORGNDTTxt" ValidationGroup="CCN"
                ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$"></asp:RegularExpressionValidator>  
             
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
                    <input id="filename" type="hidden" value=""/>
                    <div id="uploadmessage"></div>
                </div>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CCNStatusLabel" class="requiredlabel">CCN Status:</div>
                <div id="CCNStatusField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="CCNSTSCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="CCNSTS_LD" class="control-loader"></div>
                
                <asp:RequiredFieldValidator ID="CCNSTSTxtVal" runat="server" Display="None" ControlToValidate="CCNSTSCBox" ErrorMessage="Select CCN status" ValidationGroup="CCN"></asp:RequiredFieldValidator>
            
                <asp:CompareValidator ID="CCNSTSVal" runat="server" ControlToValidate="CCNSTSCBox" ValidationGroup="CCN"
                Display="None" ErrorMessage="Select CCN status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
       
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CCNDetailsLabel" class="labeldiv">Reason for Change:</div>
                <div id="CCNDetailsField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="CCNCHNGTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
                
                <asp:CustomValidator id="CCNCHNGTxtVal" runat="server" ValidationGroup="CCN"
                ControlToValidate = "CCNCHNGTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>    

        <div id="CCNMembersTB" class="tabcontent" style="display:none;height:450px;">
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <img id="newmember" src="../Images/new_file.png" class="imgButton" title="Add new Approval Member" alt=""/>
        
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
        var empty = $("#<%=gvCCN.ClientID%> tr:last-child").clone(true);

        refresh(empty);

        $("#<%=ORGNDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });


        $("#deletefilter").bind('click', function ()
        {
            hideAll();
            refresh(empty);
        });


        $("#refresh").bind('click', function () {
            hideAll();
            refresh(empty);
        });

        $("#byRECMOD").bind('click', function ()
        {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#byDOC").bind('click', function ()
        {
            hideAll();

            $("#<%=DOCNMTxt.ClientID%>").val('');

            $("#DOCContainer").show();
        });

        $("#byCCNTYP").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadAllCCNType', "#<%=CCNTYPCBox.ClientID%>", "#CCNTYPF_LD");

            $("#CCNTYPContainer").show();
        });
       
        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        /*filter CCN according to document title*/
        $("#<%=DOCNMTxt.ClientID%>").keyup(function () {
            filterByDOC($(this).val(), empty);
        });


        $("#<%=RECMODCBox.ClientID%>").change(function () {
            filterByRecordMode($(this).val(), empty);
        });

        /*filter CCN according to CCN type*/
        $("#<%=CCNTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByCCNType($(this).val(), empty);
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

        /* this will trigger download.ashx to download the attached file*/
        $("#CCNFileDownload").bind('click', function ()
        {
            window.open(getURL().concat('DocumentDownload.ashx?CCNID=' + $("#CCNID").val()));
        });

        $(".uploaddiv").bind('click', function () {
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
            /*if CCN status is cancelled, then prevent adding a new approval member*/

            if ($("#<%=CCNSTSCBox.ClientID%>").val() == 'Cancelled')
            {
                alert('Cannot add a new approval member on a cancelled CCN record, please change the status');
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
            var isPageValid = Page_ClientValidate('CCN');
            if (isPageValid)
            {
                if (!$("#validation_dialog_ccn").is(":hidden"))
                {
                    $("#validation_dialog_ccn").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {

                        ActivateSave(false);

                        var orgdate = getDatePart($("#<%=ORGNDTTxt.ClientID%>").val());

                        var ccn =
                        {
                            CCNID: $("#CCNID").val(),
                            Version: $("#<%=DOCVRTxt.ClientID%>").val(),
                            OrginationDate: new Date(orgdate[2], (orgdate[1] - 1), orgdate[0]),
                            CCNDetails: $("#<%=CCNCHNGTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=CCNCHNGTxt.ClientID%>").val()),
                            CCNStatusString: $("#<%=CCNSTSCBox.ClientID%>").find('option:selected').text(),
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
                            data: "{\'json\':\'" + JSON.stringify(ccn) + "\'}",
                            url: getServiceURL().concat('updateCCN'),
                            success: function (data)
                            {
                                $("#SaveTooltip").fadeOut(500, function ()
                                {
                                    ActivateSave(true);

                                    alert(data.d);

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
                                    alert(r.Message);
                                });
                            }
                        });
                    });
                }
            }
            else
            {
                $("#validation_dialog_ccn").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
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
        $("#CCNDetails").addClass("ctab");
        $("#CCNDetailsTB").css('display', 'block');
    }

    function filterByRecordMode(mode, empty)
    {
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat("filterDocumentByMode"),
                success: function (data)
                {
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                }
            });
        });
    }
    function filterByCCNType(type, empty) {
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("filterCCNByType"),
                success: function (data) {
                    $("#ccnwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ccnwait").fadeOut(500, function () {

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
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
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
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                }
            });
        });
    }

    function refresh(empty)
    {
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDocumentList"),
                success: function (data) {
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(xhr.responseText);
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
        $("#<%=gvCCN.ClientID%> tr").not($("#<%=gvCCN.ClientID%> tr:first-child")).remove();

        $(xmlDOC).find('DocFile').each(function (i, document)
        {
            var xmlCCN = $.parseXML($(this).attr('XMLCCNList'));
            $(xmlCCN).find('CCN').each(function (j, ccn)
            {
                $("td", row).eq(0).html("<img id='edit_" + j + "' src='../Images/edit.png' class='imgButton'/>");
                $("td", row).eq(1).html($(document).attr("DOCNo"));
                $("td", row).eq(2).html($(document).attr("DOCTitle"));
                $("td", row).eq(3).html($(this).attr("CCNType"));
                $("td", row).eq(4).html($(this).attr("Originator"));
                $("td", row).eq(5).html($(this).attr("Owner"));
                $("td", row).eq(6).html(new Date($(this).attr("OrginationDate")).format("dd/MM/yyyy"));
                $("td", row).eq(7).html($(this).attr("CCNStatus"));
                $("td", row).eq(8).html($(this).attr("ModeString"));

                $("#<%=gvCCN.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            $("#validation_dialog_ccn").hide();
                            
                            /*bind CCNID value*/
                            $("#CCNID").val($(ccn).attr('CCNID'));

                            /*bind CCN Type value*/
                            $("#<%=CCNTYPTxt.ClientID%>").val($(ccn).attr('CCNType'));

                            /*bind document version*/
                            $("#<%=DOCVRTxt.ClientID%>").val($(ccn).attr('Version'));

                            /*bind CCN originator*/
                            bindComboboxAjax('loadEmployees', '#<%=ORIGCBox.ClientID%>', $(ccn).attr("Originator"), "#ORIGN_LD");

                            /*bind CCN Owner*/
                            bindComboboxAjax('loadEmployees', '#<%=OWNRCBox.ClientID%>', $(ccn).attr("Owner"), "#Owner_LD");

                            /*bind orgination date value*/
                            $("#<%=ORGNDTTxt.ClientID%>").val(new Date($(ccn).attr("OrginationDate")).format("dd/MM/yyyy"));

                            /*bind CCN status*/
                            bindComboboxAjax('loadCCNStatus', '#<%=CCNSTSCBox.ClientID%>', $(ccn).attr("CCNStatus"), "#CCNSTS_LD");

                            if ($(ccn).attr("DocumentFileName") != '')
                            {
                                $("#CCNFileDownload").stop(true).hide().fadeIn(500, function ()
                                {
                                    $(this).find('img').attr('src', "../ImageHandler.ashx?query=select Icon from DocumentList.DocumentFileType where FileType='" + $(document).attr("DOCFileType") + "'&width=20&height=20");
                                    $(this).find('p').text("Click here to download the file " + $(ccn).attr('DocumentFileName'));
                                });
                            }
                            else
                            {
                                $("#CCNFileDownload").hide();
                            }

                            /*bind reason for change*/
                            if ($(ccn).attr("CCNDetails") == '')
                            {
                                addWaterMarkText('Reason for changing the document', '#<%=CCNCHNGTxt.ClientID%>');
                            }
                            else
                            {
                                if ($("#<%=CCNCHNGTxt.ClientID%>").hasClass("watermarktext"))
                                {

                                    $("#<%=CCNCHNGTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=CCNCHNGTxt.ClientID%>").html($(ccn).attr("CCNDetails")).text();
                            }

                            $("#<%=DOCURLTxt.ClientID%>").val($(ccn).attr('DocumentFileURL'));

                            /* check if there is a URL for the document to view*/
                            if ($(ccn).attr('DocumentFileURL') == '') {
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

                            /*load members involved in CCN approval*/
                            var json = $.parseJSON($(ccn).attr('JSONMembers'));

                            var attributes = new Array();
                            attributes.push("Member");
                            attributes.push("MemberType");
                            attributes.push("ApprovalStatusString");
                            attributes.push("ApprovalRemarks");


                            /*set cell settings, and mark cells as readonly in case where CCN status is closed or cancelled*/
                            var settings = new Array();

                            if ($(ccn).attr("CCNStatus") == 'Closed' || $(ccn).attr("CCNStatus") == 'Cancelled')
                            {
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));

                                $("#CCNTooltip").find('p').text("Changes cannot take place since the CCN record is " + $(ccn).attr('CCNStatus'));

                                if ($("#CCNTooltip").is(":hidden")) {
                                    $("#CCNTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else if ($(document).attr('DOCStatusString') == 'Withdrawn' || $(document).attr('DOCStatusString') == 'Cancelled')
                            {
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));

                                $("#CCNTooltip").find('p').text("Changes cannot take place since the document is either withdrawn or cancelled");

                                if ($("#CCNTooltip").is(":hidden")) {
                                    $("#CCNTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else if ($(document).attr('ModeString') == 'Archived')
                            {
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));

                                $("#CCNTooltip").find('p').text("Changes cannot take place since the document was sent to archive");

                                if ($("#CCNTooltip").is(":hidden")) {
                                    $("#CCNTooltip").slideDown(800, 'easeOutBounce');
                                }

                                /*disable all modal controls*/
                                ActivateAll(false);
                            }
                            else
                            {
                                settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));

                                $("#CCNTooltip").hide();

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

                row = $("#<%=gvCCN.ClientID%> tr:last-child").clone(true);
            });
        });
    }

    function ActivateAll(isactive)
    {
        if (isactive == false) {
            $(".modalPanel").children().each(function ()
            {

                $(".textbox").each(function () {
                    $(this).removeClass("textbox");
                    $(this).addClass("readonlycontrolled");
                    $(this).attr('readonly', true);
                });

                $(".combobox").each(function () {
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
            $(".modalPanel").children().each(function ()
            {

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

                $(".combobox").each(function () {
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

    function hideAll()
    {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }

</script>


</asp:Content>
