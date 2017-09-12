<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ApproveCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.ApproveCCN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper"> 
   
    <div id="CCNApproval_Header" class="moduleheader">DCR Approval</div>

    <div class="toolbox">
        <img id="refresh" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
   
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byAPPRSTS">Filter by Approval Status</li>
                <li id="byDCRTYP">Filter by DCR Type</li>
                <li id="byDCRSTS">Filter by DCR Status</li>
                <li id="byORIGUDT">Filter by Origination Date Range</li>
            </ul>
        </div>
    </div>

    <div id="APPStatusContainer" class="filter">
        <div id="APPStatusLabel" class="filterlabel">Approval Status:</div>
        <div id="APPStatusField" class="filterfield">
            <asp:DropDownList ID="APPSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="APPSTSF_LD" class="control-loader"></div>
    </div>

    <div id="DCRTYPContainer" class="filter">
        <div id="DCRTYPLabel" class="filterlabel">DCR Type:</div>
        <div id="DCRTYPField" class="filterfield">
            <asp:DropDownList ID="DCRTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="DCRTYPF_LD" class="control-loader"></div>
    </div>

    <div id="DCRSTSContainer" class="filter">
        <div id="DCRSTSLabel" class="filterlabel">DCR Status:</div>
        <div id="DCRSTSField" class="filterfield">
            <asp:DropDownList ID="DCRSTSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="DCRSTSF_LD" class="control-loader"></div>
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

    <div id="ccnwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvCCN" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="Version" HeaderText="Ducument Version" />
            <asp:BoundField DataField="CCNType" HeaderText="DCR Type" />
            <asp:BoundField DataField="Originator" HeaderText="Originator" />
            <asp:BoundField DataField="Owner" HeaderText="Owner" />
            <asp:BoundField DataField="OrginationDate" HeaderText="Origination Date" />
            <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval" /> 
            <asp:BoundField DataField="CCNStatus" HeaderText="DCR Status" /> 
        </Columns>
        </asp:GridView>
    </div>
 
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>


    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Document Change Request Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="CCNTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
            <p></p>
	    </div>	
   
        <div id="SaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <ul id="tabul" style="margin-top:35px;">
            <li id="CCNDetails" class="ntabs">DCR Info</li>
            <li id="Approval" class="ntabs">Approval Details</li>
        </ul>

        <div id="CCNDetailsTB" class="tabcontent" style="display:none; height:450px;">

            <input id="CCNID" type="hidden" value="" />

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="CCNTypeLabel" class="labeldiv">DCR Type:</div>
                <div id="CCNTypeField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="CCNTYPTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DOCVersionLabel" class="labeldiv">Document Version:</div>
                <div id="DOCVersionField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="DOCVRTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DOCURLLabel" class="labeldiv">Document File URL:</div>
                <div id="DOCURLField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="DOCURLTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="390px"></asp:TextBox>
                </div>

                <input id="VDOCBTN" class="button" type="button" value="View" style="margin-left:5px; width:85px" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OriginatorLabel" class="labeldiv">Document Originator:</div>
                <div id="OrginatorField" class="fielddiv" style="width:300px">
                    <asp:TextBox ID="ORIGTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="290px"></asp:TextBox>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="IssuerLabel" class="labeldiv">Document Owner:</div>
                <div id="IssuerField" class="fielddiv" style="width:300px">
                    <asp:TextBox ID="OWNRTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="290px"></asp:TextBox>
                </div>
            </div>
     
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OriginationDateLabel" class="labeldiv">Origination Date:</div>
                <div id="OriginationDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ORGNDTTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                </div>        
            </div>
  
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CCNStatusLabel" class="labeldiv">DCR Status:</div>
                <div id="CCNStatusField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="CCNSTSTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                </div>
            </div>
       
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CCNDetailsLabel" class="labeldiv">Reason for Change:</div>
                <div id="CCNDetailsField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="CCNCHNGTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                </div>
            </div>
        </div>    
   
        <div id="ApprovalTB" class="tabcontent" style="display:none;height:450px;">
            <input id="MEMID" type="hidden" value="" />

             <div id="validation_dialog_approval">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Approval" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="ApprovalStatusLabel" class="requiredlabel">Approval Status:</div>
                <div id="ApprovalStatusField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="APPSTSCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="APPR_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="APPSTSTxtVal" runat="server" Display="None" ControlToValidate="APPSTSCBox" ErrorMessage="Select approval status" ValidationGroup="Approval"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="APPSTSVal" runat="server" ControlToValidate="APPSTSCBox" CssClass="validator"
                Display="None" ErrorMessage="Select approval status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="CCN"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="JustificationLabel" class="labeldiv">Justification:</div>
                <div id="JustificationField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="JUSTTxt" runat="server"  CssClass="textbox" Width="380px" Height="160px" TextMode="MultiLine"></asp:TextBox>
                </div>

                 <asp:CustomValidator id="JUSTTxtVal" runat="server" ValidationGroup="Approval"
                ControlToValidate = "JUSTTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>
        </div>

        <div id="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <input id="FLTRMOD" type="hidden" value="" />
</div>

<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvCCN.ClientID%> tr:last-child").clone(true);

        var employee = $("#<%=EMPTxt.ClientID%>").val().split(' ');

        $("#ApprovalTooltip").stop(true).hide().fadeIn(800, function ()
        {
            $(this).find('p').html("List of document change requests associated with the current user account");
        });

        // load all CCN records based upon login name 
        loadDCR(empty, employee);

        /*At the current stage, documents can be viewed using google doc viewer tool where a customized document viewer can be added as a future work*/
        $("#VDOCBTN").bind('click', function ()
        {
            window.open('http://docs.google.com/viewer?url=' + $("#<%=DOCURLTxt.ClientID%>").val());
        });

    
        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        // filter by approval status
        $("#byAPPRSTS").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadApprovalStatus', "#<%=APPSTSFCBox.ClientID%>", "#APPSTSF_LD");

            $("#APPStatusContainer").show();
        });

        /* filter by CCN type */ 
        $("#byDCRTYP").bind('click', function () {
            hideAll();

            loadComboboxAjax('loadAllDCRType', "#<%=DCRTYPCBox.ClientID%>", "#DCRTYPF_LD");
            $("#DCRTYPContainer").show();

        });

        /* filter by CCN status*/ 
        $("#byDCRSTS").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadDCRStatus', "#<%=DCRSTSCBox.ClientID%>", "#DCRSTSF_LD");
            $("#DCRSTSContainer").show();

        });

        $("#byORIGUDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

             $("#OriginationDateContainer").show();
        });

        /*filter DCR by origination date range*/
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

        $("#refresh").bind('click', function () {
            hideAll();
            loadDCR(empty, employee);
        });

        $("#<%=APPSTSFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadDCRByApproval(empty, employee, $(this).val());
            }
        });

        $("#<%=DCRTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadDCRByType(empty, employee, $(this).val());
            }
        });

        $("#<%=DCRSTSCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadDCRByStatus(empty, employee, $(this).val());
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('Approval');
            if (isPageValid)
            {
                if (!$("#validation_dialog_approval").is(":hidden")) {
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
                            url: getServiceURL().concat("updateDCRApproval"),
                            data: "{\'json\':\'" + JSON.stringify(member) + "\'}",
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

    function loadDCRByType(empty, employee, type)
    {

        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDCRByTypeEmployee"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "','type':'" + type + "'}",
                success: function (data) {
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

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function filterByOriginationDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#ccnwait").stop(true).hide().fadeIn(500, function () {
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
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
        }
    }

    function loadDCRByStatus(empty, employee, status)
    {
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDCRByStatusEmployee"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "','status':'" + status + "'}",
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
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadDCRByApproval(empty, employee, approval) {
        $("#ccnwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDCRByApprovalEmployee"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "','approval':'" + approval + "'}",
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
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadDCR(empty, employee) {
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadDCRByEmployee"),
                data: "{'firstname':'" + employee[0] + "','lastname':'" + employee[1] + "'}",
                success: function (data) {
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#ccnwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadGridView(data, empty) {
        var xmlCCN = $.parseXML(data);
        var row = empty;

        // remove all previous records

        $("#<%=gvCCN.ClientID%> tr").not($("#<%=gvCCN.ClientID%> tr:first-child")).remove();

        $(xmlCCN).find('CCN').each(function (index, ccn)
        {
            $("td", row).eq(0).html("<img id='edit_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton'/>");
            $("td", row).eq(1).html("<img id='icon_" + index + "' src='http://www.qmsrs.com/qmsrstools/Images/download.png' class='imgButton'/>");
            $("td", row).eq(2).html($(this).attr("Version"));
            $("td", row).eq(3).html($(this).attr("CCNType"));
            $("td", row).eq(4).html($(this).attr("Originator"));
            $("td", row).eq(5).html($(this).attr("Owner"));
            $("td", row).eq(6).html(new Date($(this).attr("OrginationDate")).format("dd/MM/yyyy"));
            $("td", row).eq(8).html($(this).attr("CCNStatus"));

            var xmlMember = $.parseXML($(this).attr('MemberString'));
            $("td", row).eq(7).html($(xmlMember).find('CCNApprovalMember').attr("ApprovalStatus"));

            $("#<%=gvCCN.ClientID%>").append(row);

            $(row).find('img').each(function ()
            {
                if ($(this).attr('id').search('icon') != -1)
                {
                    $(this).bind('click', function ()
                    {
                        if ($(ccn).attr("DocumentFileName") != '')
                        {
                            /* this will trigger download.ashx to download the attached file*/
                            window.open(getURL().concat('DocumentDownload.ashx?key=' + $(ccn).attr('CCNID') + '&module=DCR'));
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

                        /*bind CCNID value*/
                        $("#CCNID").val($(ccn).attr('CCNID'));

                        /*Bind CCN Details*/
                        $("#MEMID").val($(xmlMember).find('ApprovalMember').attr('MemberID'));

                        $("#<%=CCNTYPTxt.ClientID%>").val($(ccn).attr("CCNType"));
                        $("#<%=DOCVRTxt.ClientID%>").val($(ccn).attr("Version"));
                        $("#<%=ORIGTxt.ClientID%>").val($(ccn).attr("Originator"));
                        $("#<%=OWNRTxt.ClientID%>").val($(ccn).attr("Owner"));
                        $("#<%=ORGNDTTxt.ClientID%>").val(new Date($(ccn).attr("OrginationDate")).format("dd/MM/yyyy"));
                        $("#<%=CCNSTSTxt.ClientID%>").val($(ccn).attr("CCNStatus"));
                        $("#<%=CCNCHNGTxt.ClientID%>").val($(ccn).attr("CCNDetails"));

                        /* check if there is a URL for the document to view*/
                        if ($(ccn).attr('DocumentFileURL') == '')
                        {
                            /*set opacity property to 50% indicating the document view button is disabled by default*/
                            $("#VDOCBTN").css({ opacity: 0.5 });

                            /*disable view button*/
                            disableViewButton(false);
                        }
                        else
                        {
                            $("#<%=DOCURLTxt.ClientID%>").val($(ccn).attr('DocumentFileURL'));

                            /*set opacity property to 100% indicating the document view button is enabled*/
                            $("#VDOCBTN").css({ opacity: 1 });

                            /*activate view button*/
                            disableViewButton(true);
                        }

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

                        if ($(ccn).attr("CCNStatus") == 'Closed' || $(ccn).attr("CCNStatus") == 'Cancelled')
                        {
                            $("#CCNTooltip").find('p').text("Your decision cannot take place since the DCR record is " + $(ccn).attr('CCNStatus'));

                            if ($("#CCNTooltip").is(":hidden")) {
                                $("#CCNTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else
                        {
                            $("#CCNTooltip").hide();

                            /*enable all modal controls for editing*/
                            ActivateAll(true);
                        }

                        navigate('CCNDetails');

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });
            row = $("#<%=gvCCN.ClientID%> tr:last-child").clone(true);
        });
    }

    function disableViewButton(enabled)
    {
        if (enabled == false) {
            $("#VDOCBTN").attr('disabled', true);

            /*set opacity property to 50% indicating the document view button is disabled by default*/
            $("#VDOCBTN").css({ opacity: 0.5 });

        }
        else {
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

    function ActivateAll(isactive) {
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

                $(this).find(".textremaining").each(function () {
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

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
</script>
</asp:Content>
