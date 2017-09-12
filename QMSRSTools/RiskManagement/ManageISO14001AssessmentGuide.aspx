<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageISO14001AssessmentGuide.aspx.cs" Inherits="QMSRSTools.RiskManagement.ManageISO14001AssessmentGuide" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="ISO1401AGUID_Header" class="moduleheader">Manage ISO14001 Assessment Guidelines</div>
    
    <div class="toolbox">
        <img id="new" src="<%=GetSitePath() + "/Images/new_file.png" %>" class="imgButton" title="Create New Risk Criteria" alt=""/> 
        <img id="refresh" src="<%=GetSitePath() + "/Images/refresh.png" %>" alt=""  class="imgButton" title="Refresh Data"/>
        <img id="deletefilter" src="<%=GetSitePath() + "/Images/filter-delete-icon.png" %>" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="<%=GetSitePath() + "/Images/filter.png" %>" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byACAT">Filter by Assessment Category</li>
            </ul>
        </div>

        <div id="AssessmentCategoryContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="AssessmentCategoryFLabel" style="width:100px;">Assessment Category:</div>
            <div id="AssessmentCategoryFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="ACATFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ACATF_LD" class="control-loader"></div>
        </div>
    </div>  
    
    <div id="AGUIDwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

     <div id="AssessmentScrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvAssessmentGuide" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="GuideID" HeaderText="ID" />
                <asp:BoundField DataField="Category" HeaderText="Assessment Category" />
                <asp:BoundField DataField="Assessment" HeaderText="Assessment Guidline" />
                <asp:BoundField DataField="Value" HeaderText="Value" />
            </Columns>
        </asp:GridView>
    </div>

     <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:350px;">
        <div id="AssessmentHeader" class="modalHeader">ISO14001 Assessment Guideline Details<span id="close" class="modalclose" title="Close">X</span></div>

        <div id="SaveTooltip" class="tooltip">
            <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>    
        
        <input id="GuidlineID" type="hidden" value="" />
      
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="AssessmentCategoryLabel" class="requiredlabel">Assessment category:</div>
            <div id="AssessmentCategoryField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="ACATCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="ACAT_LD" class="control-loader"></div>
         
            <asp:RequiredFieldValidator ID="ACATTxtVal" runat="server" Display="None" ControlToValidate="ACATCBox" ErrorMessage="Select the category of the assessment" ValidationGroup="General"></asp:RequiredFieldValidator>
    
            <asp:CompareValidator ID="ACATVal" runat="server" ControlToValidate="ACATCBox"
            Display="None" ErrorMessage="Select the category of the assessment" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AssessmentDescriptionLabel" class="requiredlabel">Assessment Guideline:</div>
            <div id="AssessmentDescriptionField" class="fielddiv" style="width:250px;">
                <asp:TextBox ID="ADESCTxt" runat="server"  CssClass="textbox" Width="240px"></asp:TextBox>
            </div>

            <div id="ADESClimit" class="textremaining"></div>   


            <asp:RequiredFieldValidator ID="ADESCTxtVal" runat="server" Display="None" ControlToValidate="ADESCTxt" ErrorMessage="Enter the assessment guideline details" ValidationGroup="General"></asp:RequiredFieldValidator>
   
            <asp:CustomValidator id="ADESCTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "ADESCTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
       </div>
       
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AssessmentValueLabel" class="requiredlabel">Assessment Value:</div>
            <div id="AssessmentValueField" class="fielddiv">
                <asp:TextBox ID="AVALTxt" CssClass="textbox" runat="server"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="AVTxtVal" runat="server" Display="None" ControlToValidate="AVALTxt" ErrorMessage="Enter the value of the assessment" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <ajax:FilteredTextBoxExtender ID="AVTxtFExt" runat="server" TargetControlID="AVALTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>

            <asp:CustomValidator id="AVTxtF1Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "AVALTxt" Display="None" ErrorMessage = "The value of the assessment should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator>   
       
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AssessmentScoreLabel" class="labeldiv">Assessment Score:</div>
            <div id="AssessmentScoreField" class="fielddiv">
                <asp:TextBox ID="ASCRTxt" CssClass="textbox" type="number" runat="server"></asp:TextBox>
            </div>

            <asp:RegularExpressionValidator ID="ASCRTxtFVal" runat="server" ControlToValidate="ASCRTxt"
            Display="None" ErrorMessage="Assessment Score: Enter decimal amount (must have 2 digits after a decimal point) e.g. 2500.75." ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
      
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>
    
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <input id="MODE" type="hidden" value="" /> 

</div>
<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvAssessmentGuide.ClientID%> tr:last-child").clone(true);

        refresh(empty);

        $("#deletefilter").bind('click', function () {
            hideAll();
            refresh(empty);
        });

        $("#refresh").bind('click', function () {
            hideAll();
            refresh(empty);
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#byACAT").bind('click', function () {
            hideAll();

            /*load ISO assessment category*/
            loadComboboxAjax('loadAssessmentCategory', "#<%=ACATFCBox.ClientID%>", "#ACATF_LD");

            $("#AssessmentCategoryContainer").show();
        });

        $("#<%=ACATFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {
                filterByCategory($(this).val(), empty);
            }
        });

        $("#new").bind('click', function () {
            $("#validation_dialog_general").hide();

            reset();

            /*attach the guideline of the ISO14001 to limit plugin*/
            $('#<%=ADESCTxt.ClientID%>').limit({ id_result: 'ADESClimit', alertClass: 'alertremaining', limit: 90 });
  
            /*load ISO assessment category*/
            loadComboboxAjax('loadAssessmentCategory', "#<%=ACATCBox.ClientID%>", "#ACAT_LD");

            /*set modal mode to add*/
            $("#MODE").val('ADD');

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#save").click(function () {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid) {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD') {
                            var guide =
                            {
                                Category: $("#<%=ACATCBox.ClientID%>").val(),
                                Guideline: $("#<%=ADESCTxt.ClientID%>").val(),
                                Value: $("#<%=AVALTxt.ClientID%>").val(),
                                Score: $("#<%=ASCRTxt.ClientID%>").val() == "" ? 0 : $("#<%=ASCRTxt.ClientID%>").val()
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(guide) + "\'}",
                                url: getServiceURL().concat('createISO14001Guide'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

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
                        }
                        else if ($("#MODE").val() == 'EDIT') {
                            var guide =
                            {
                                GuideID: $("#GuidlineID").val(),
                                Category: $("#<%=ACATCBox.ClientID%>").val(),
                                Guideline: $("#<%=ADESCTxt.ClientID%>").val(),
                                Value: $("#<%=AVALTxt.ClientID%>").val(),
                                Score: $("#<%=ASCRTxt.ClientID%>").val() == "" ? 0 : $("#<%=ASCRTxt.ClientID%>").val()

                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(guide) + "\'}",
                                url: getServiceURL().concat('updateISO14001Guide'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

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
                        }
                    });
            }
        }
        else {
            $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                alert("Please make sure that all warnings highlighted in red color are fulfilled");
            });
        }
        });
    });

    function removeAssessmentGuide(guideID) {
        var result = confirm("Are you sure you would like to remove the current ISO 14001 assessment guide record?");
        if (result == true) {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'guideID':'" + guideID + "'}",
                url: getServiceURL().concat("removeISO14001Guide"),
                success: function (data) {
                    $(".modulewrapper").css("cursor", "default");
                    $("#refresh").trigger('click');
                },
                error: function (xhr, status, error) {
                    $(".modulewrapper").css("cursor", "default");
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
    }

    function filterByCategory(category, empty) {
        $("#AGUIDwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat("filterISO14001GuideByCategory"),
                success: function (data) {
                    $("#AGUIDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#AGUIDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function refresh(empty) {
        $("#AGUIDwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISO14001Guide"),
                success: function (data) {
                    $("#AGUIDwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#AGUIDwait").fadeOut(500, function () {
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
        var xmlGuidline = $.parseXML(data);

        var row = empty;

        $("#<%=gvAssessmentGuide.ClientID%> tr").not($("#<%=gvAssessmentGuide.ClientID%> tr:first-child")).remove();


        $(xmlGuidline).find("ISO14001Guide").each(function (index, value)
        {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'  />");
            $("td", row).eq(2).html($(this).attr("GuideID"));
            $("td", row).eq(3).html($(this).attr("Category"));
            $("td", row).eq(4).html($(this).attr("Guideline"));
            $("td", row).eq(5).html($(this).attr("Value"));
            $("td", row).eq(6).html($(this).attr("Score"));

            $("#<%=gvAssessmentGuide.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeAssessmentGuide($(value).attr("GuideID"));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function () {
                        $("#validation_dialog_general").hide();

                        reset();

                        /*set the mode to edit*/
                        $("#MODE").val('EDIT');

                        /* bind the ID of the assessment guid ID*/
                        $("#GuidlineID").val($(value).attr("GuideID"));

                        /*bind the description of the assessment guideline*/
                        $("#<%=ADESCTxt.ClientID%>").val($(value).attr("Guideline"));
                        
                        /*load risk types*/
                        bindComboboxAjax('loadAssessmentCategory', "#<%=ACATCBox.ClientID%>", $(value).attr("Category"), "#ACAT_LD");

                        /*bind the value of the assessment guideline*/
                        $("#<%=AVALTxt.ClientID%>").val($(value).attr("Value"));

                        /* bind score value */
                        $("#<%=ASCRTxt.ClientID%>").val(parseFloat($(value).attr("Score")).toFixed(2));

                        /*attach the guideline of the ISO14001 to limit plugin*/
                        $('#<%=ADESCTxt.ClientID%>').limit({ id_result: 'ADESClimit', alertClass: 'alertremaining', limit: 90 });
                        $('#<%=ADESCTxt.ClientID%>').keyup();

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvAssessmentGuide.ClientID%> tr:last-child").clone(true);
        });
    }

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

    function ActivateSave(isactive) {
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
</script>
</asp:Content>
