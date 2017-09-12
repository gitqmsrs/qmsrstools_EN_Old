<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ApproveCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.ApproveCCN" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper"> 
   
    <div id="CCNApproval_Header" class="moduleheader">CCN Approval</div>

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
   
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byAPPRSTS">Filter by Approval Status</li>
                <li id="byCCNTYP">Filter by CCN Type</li>
                <li id="byCCNSTS">Filter by CCN Status</li>
            </ul>
        </div>
    
        <div id="APPStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="APPStatusLabel" style="width:100px;">Approval Status:</div>
            <div id="APPStatusField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="APPSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="APPSTSF_LD" class="control-loader"></div>
        </div>

        <div id="CCNTYPContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CCNTYPLabel" style="width:100px;">CCN Type:</div>
            <div id="CCNTYPField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="CCNTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="CCNTYPF_LD" class="control-loader"></div>
        </div>

        <div id="CCNSTSContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="CCNSTSLabel" style="width:100px;">CCN Status:</div>
            <div id="CCNSTSField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="CCNSTSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="CCNSTSF_LD" class="control-loader"></div>
        </div>
    </div>

    <div id="ApprovalTooltip" class="tooltip" style="margin-top:10px;">
        <img src="../Images/Warning.png" alt="Help" height="25" width="25" />
        <p>The CCN list is loaded based on your login name, select one of the pending CCN records for approval.</p>
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

    <div id="scrollbar" style="height:400px; width:100%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvCCN" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
        GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
        <Columns>
            <asp:TemplateField ShowHeader="false">
                <ItemTemplate>
                </ItemTemplate>
            </asp:TemplateField>
 
            <asp:BoundField DataField="Version" HeaderText="Ducument Version" />
            <asp:BoundField DataField="CCNType" HeaderText="CCN Type" />
            <asp:BoundField DataField="Originator" HeaderText="Originator" />
            <asp:BoundField DataField="Owner" HeaderText="Owner" />
            <asp:BoundField DataField="OrginationDate" HeaderText="Origination Date" />
            <asp:BoundField DataField="ApprovalStatus" HeaderText="Approval" /> 
            <asp:BoundField DataField="CCNStatus" HeaderText="CCN Status" /> 
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

        <ul id="tabul" style="margin-top:35px;">
            <li id="CCNDetails" class="ntabs">CCN Info</li>
            <li id="Approval" class="ntabs">Approval Details</li>
        </ul>

        <div id="CCNDetailsTB" class="tabcontent" style="display:none; height:450px;">

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
                <div id="CCNStatusLabel" class="labeldiv">CCN Status:</div>
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

             <div id="validation_dialog_ccn" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="CCN" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="ApprovalStatusLabel" class="requiredlabel">Approval Status:</div>
                <div id="ApprovalStatusField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="APPSTSCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="APPR_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="APPSTSTxtVal" runat="server" Display="None" ControlToValidate="APPSTSCBox" ErrorMessage="Select approval status" ValidationGroup="CCN"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="APPSTSVal" runat="server" ControlToValidate="APPSTSCBox" CssClass="validator"
                Display="None" ErrorMessage="Select approval status" Operator="NotEqual" Style="position: static"
                ValueToCompare="0" ValidationGroup="CCN"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="JustificationLabel" class="labeldiv">Justification:</div>
                <div id="JustificationField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="JUSTTxt" runat="server"  CssClass="textbox" Width="380px" Height="160px" TextMode="MultiLine"></asp:TextBox>
                </div>

                 <asp:CustomValidator id="JUSTTxtVal" runat="server" ValidationGroup="CCN"
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

        // load all CCN records based upon login name 
        loadCCN(empty, employee);

        /*At the current stage, documents can be viewed using google doc viewer tool where a customized document viewer can be added as a future work*/
        $("#VDOCBTN").bind('click', function () {
            window.open('http://docs.google.com/viewer?url=' + $("#<%=DOCURLTxt.ClientID%>").val());
        });

        /* this will trigger download.ashx to download the attached file*/
        $("#CCNFileDownload").bind('click', function () {
            window.open(getURL().concat('DocumentDownload.ashx?CCNID=' + $("#CCNID").val()));
        });

        // show module tooltip
        if ($("#ApprovalTooltip").is(":hidden"))
        {
            $("#ApprovalTooltip").slideDown(800, 'easeOutBounce');
        }

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
        $("#byCCNTYP").bind('click', function () {
            hideAll();

            loadComboboxAjax('loadAllCCNType', "#<%=CCNTYPCBox.ClientID%>", "#CCNTYPF_LD");
            $("#CCNTYPContainer").show();

        });

        /* filter by CCN status*/ 
        $("#byCCNSTS").bind('click', function ()
        {
            hideAll();
            loadComboboxAjax('loadCCNStatus', "#<%=CCNSTSCBox.ClientID%>", "#CCNSTSF_LD");
            $("#CCNSTSContainer").show();

        });

        $("#deletefilter").bind('click', function ()
        {
            hideAll();
            loadCCN(empty, employee);
        });

        $("#refresh").bind('click', function () {
            hideAll();
            loadCCN(empty, employee);
        });

        $("#<%=APPSTSFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadCCNByApproval(empty, employee, $(this).val());
            }
        });

        $("#<%=CCNTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadCCNByType(empty, employee, $(this).val());
            }
        });

        $("#<%=CCNSTSCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadCCNByStatus(empty, employee, $(this).val());
            }
        });

        $("#save").bind('click', function ()
        {
            var isPageValid = Page_ClientValidate('CCN');
            if (isPageValid)
            {
                if (!$("#validation_dialog_ccn").is(":hidden")) {
                    $("#validation_dialog_ccn").hide();
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
                            ApprovalRemarks: $("#<%=JUSTTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=JUSTTxt.ClientID%>").val()),
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            url: getServiceURL().concat("updateCCNApproval"),
                            data: "{\'json\':\'" + JSON.stringify(member) + "\'}",
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

    function loadCCNByType(empty, employee, type)
    {

        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCCNByTypeEmployee"),
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
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function loadCCNByStatus(empty, employee, status)
    {
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCCNByStatusEmployee"),
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
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function loadCCNByApproval(empty, employee, approval) {
        $("#ccnwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCCNByApprovalEmployee"),
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
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function loadCCN(empty, employee) {
        $("#ccnwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCCNByEmployee"),
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
                        alert(xhr.responseText);
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
            $("td", row).eq(0).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");
            $("td", row).eq(1).html($(this).attr("Version"));
            $("td", row).eq(2).html($(this).attr("CCNType"));
            $("td", row).eq(3).html($(this).attr("Originator"));
            $("td", row).eq(4).html($(this).attr("Owner"));
            $("td", row).eq(5).html(new Date($(this).attr("OrginationDate")).format("dd/MM/yyyy"));
            $("td", row).eq(7).html($(this).attr("CCNStatus"));


            var xmlMember = $.parseXML($(this).attr('MemberString'));
            $("td", row).eq(6).html($(xmlMember).find('CCNApprovalMember').attr("ApprovalStatus"));

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

                        /*Bind CCN Details*/
                        $("#MEMID").val($(xmlMember).find('CCNApprovalMember').attr('MemberID'));

                        $("#<%=CCNTYPTxt.ClientID%>").val($(ccn).attr("CCNType"));
                        $("#<%=DOCVRTxt.ClientID%>").val($(ccn).attr("Version"));
                        $("#<%=ORIGTxt.ClientID%>").val($(ccn).attr("Originator"));
                        $("#<%=OWNRTxt.ClientID%>").val($(ccn).attr("Owner"));
                        $("#<%=ORGNDTTxt.ClientID%>").val(new Date($(ccn).attr("OrginationDate")).format("dd/MM/yyyy"));
                        $("#<%=CCNSTSTxt.ClientID%>").val($(ccn).attr("CCNStatus"));
                        $("#<%=CCNCHNGTxt.ClientID%>").val($(ccn).attr("CCNDetails"));

                        if ($(ccn).attr("DocumentFileName") != '') {
                            $("#CCNFileDownload").stop(true).hide().fadeIn(500, function () {
                                $(this).find('img').attr('src', "../ImageHandler.ashx?query=select Icon from DocumentList.DocumentFileType where FileType='" + $(document).attr("DOCFileType") + "'&width=20&height=20");
                                $(this).find('p').text("Click here to download the file " + $(ccn).attr('DocumentFileName'));
                            });
                        }
                        else {
                            $("#CCNFileDownload").hide();
                        }

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
                        loadComboboxAjax('loadApprovalStatus', "#<%=APPSTSCBox.ClientID%>", "#APPR_LD");


                        if ($(xmlMember).find('CCNApprovalMember').attr("ApprovalRemarks") == '')
                        {
                            addWaterMarkText('Justification for the decision', '#<%=JUSTTxt.ClientID%>');
                        }
                        else
                        {
                            if ($("#<%=JUSTTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=JUSTTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=JUSTTxt.ClientID%>").html($(xmlMember).find('CCNApprovalMember').attr("ApprovalRemarks")).text();
                        }

                        if ($(ccn).attr("CCNStatus") == 'Closed' || $(ccn).attr("CCNStatus") == 'Cancelled')
                        {
                            $("#CCNTooltip").find('p').text("Changes cannot take place since the CCN record is " + $(ccn).attr('CCNStatus'));

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

                $(".combobox").each(function () {
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

</script>
</asp:Content>
