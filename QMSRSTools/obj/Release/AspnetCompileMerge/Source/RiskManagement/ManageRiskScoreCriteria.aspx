<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageRiskScoreCriteria.aspx.cs" Inherits="QMSRSTools.RiskManagement.ManageRiskScoreCriteria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="RISKSCR_Header" class="moduleheader">Manage Risk Score Criteria</div>
    
    <div class="toolbox">
        <img id="new" src="../Images/new_file.png" class="imgButton" title="Create New Risk Score Criteria" alt=""/> 
        <img id="refresh" src="../Images/refresh.png" alt=""  class="imgButton" title="Refresh Data"/>

        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byRSKTYP">Filter by Risk Type</li>
            </ul>
        </div>

        <div id="RiskTypeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RiskTypeFLabel" style="width:100px;">Risk Type:</div>
            <div id="RiskTypeFField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="RSKTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RSKTYPF_LD" class="control-loader"></div>
        </div>
    </div>  
    
    <div id="RISKSCRwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>
    
     <div id="ScoreScrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvRiskScoreCriteria" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ScoreCriteriaID" HeaderText="ID" />
                <asp:BoundField DataField="RiskType" HeaderText="Risk Type" />
                <asp:BoundField DataField="RiskScoreCriteria" HeaderText="Risk Score Criteria" />
                <asp:BoundField DataField="Rank" HeaderText="Rating" />
                <asp:BoundField DataField="Description" HeaderText="Details" />
            </Columns>
        </asp:GridView>
    </div>
    
    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:350px;">
        <div id="ScoreCriteriaHeader" class="modalHeader">Risk Score Criteria Details<span id="close" class="modalclose" title="Close">X</span></div>

        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>    
        
        <input id="ScoreID" type="hidden" value="" />
     
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RiskTypeLabel" class="requiredlabel">Risk Type:</div>
            <div id="RiskTypeField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="RSKTYPCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="RSKTYP_LD" class="control-loader"></div>
         
            <asp:RequiredFieldValidator ID="PRBLTxtVal" runat="server" Display="None" ControlToValidate="RSKTYPCBox" ErrorMessage="Select the type of the risk" ValidationGroup="General"></asp:RequiredFieldValidator>
    
            <asp:CompareValidator ID="PRBLVal" runat="server" ControlToValidate="RSKTYPCBox"
            Display="None" ErrorMessage="Select the type of the risk" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ComparatorLabel" class="requiredlabel">Score Criteria:</div>
            <div id="ComparatorField" class="fielddiv" style="width:auto;">
                <asp:DropDownList ID="COMPRCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                </asp:DropDownList>

                <div id="COMPR_LD" class="control-loader"></div>
                    
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                <asp:TextBox ID="COMPRTxt" runat="server" Width="90px" CssClass="textbox"></asp:TextBox>

                <asp:RequiredFieldValidator ID="COMPRTxtVal" runat="server" Display="None" ControlToValidate="COMPRTxt" ErrorMessage="Enter the score value" ValidationGroup="General"></asp:RequiredFieldValidator> 
           
                <asp:RegularExpressionValidator ID="COMPRTxtFVal" runat="server" ControlToValidate="COMPRTxt"
                Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
    
                <asp:RequiredFieldValidator ID="COMPRVal" runat="server" Display="None" ControlToValidate="COMPRCBox" ErrorMessage="Select the sign of the comparator" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
                <asp:CompareValidator ID="COMPRFVal" runat="server" ControlToValidate="COMPRCBox" Display="None" ValidationGroup="General"
                ErrorMessage="Select the sign of the comparator" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>   
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RatingValueLabel" class="requiredlabel">Rating Value:</div>
            <div id="RatingValueField" class="fielddiv" style="width:150px;">
                 <asp:TextBox ID="RTTxt" runat="server" Width="140px" CssClass="textbox"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="RTTxtVal" runat="server" Display="None" ControlToValidate="RTTxt" ErrorMessage="Enter the rating value" ValidationGroup="General"></asp:RequiredFieldValidator>
    
            <ajax:FilteredTextBoxExtender ID="RTTxtExt" runat="server" TargetControlID="RTTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
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
    $(function ()
    {
        var empty = $("#<%=gvRiskScoreCriteria.ClientID%> tr:last-child").clone(true);

        refresh(empty);

        $("#deletefilter").bind('click', function ()
        {
            hideAll();
            refresh(empty);
        });

        $("#refresh").bind('click', function ()
        {
            hideAll();
            refresh(empty);
        });

        $("#byRSKTYP").bind('click', function () {
            hideAll();

            /*load risk types*/
            loadComboboxAjax('loadRiskType', "#<%=RSKTYPFCBox.ClientID%>", "#RSKTYPF_LD");

            $("#RiskTypeContainer").show();
        });

        $("#<%=RSKTYPFCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                filterByRiskType($(this).val(), empty);
            }
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#new").bind('click', function () {
            $("#validation_dialog_general").hide();

            reset();

            addWaterMarkText('The description of the risk score criteria', '#<%=DESCTxt.ClientID%>');

            /*load risk types*/
            loadComboboxAjax('loadRiskType', "#<%=RSKTYPCBox.ClientID%>", "#RSKTYP_LD");

            loadComboboxAjax('loadComparatorOperators', "#<%=COMPRCBox.ClientID%>", "#COMPR_LD");

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
                            var criteria =
                            {
                                RiskType: $("#<%=RSKTYPCBox.ClientID%>").val(),
                                Comparator: $("#<%=COMPRCBox.ClientID%>").val(),
                                ComparatorValue: $("#<%=COMPRTxt.ClientID%>").val(),
                                Rank: $("#<%=RTTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(criteria) + "\'}",
                                url: getServiceURL().concat('createScoreCriteria'),
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
                            var criteria =
                            {
                                ScoreCriteriaID:$("#ScoreID").val(),
                                RiskType: $("#<%=RSKTYPCBox.ClientID%>").val(),
                                Comparator: $("#<%=COMPRCBox.ClientID%>").val(),
                                ComparatorValue: $("#<%=COMPRTxt.ClientID%>").val(),
                                Rank: $("#<%=RTTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(criteria) + "\'}",
                                url: getServiceURL().concat('updateScoreCriteria'),
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

    function removeRiskScoreCriteria(criteriaID)
    {
        var result = confirm("Are you sure you would like to remove the current risk score criteria record?");
        if (result == true) {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'ID':'" + criteriaID + "'}",
                url: getServiceURL().concat("removeRiskScoreCriteria"),
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

    function filterByRiskType(risktype, empty)
    {
        $("#RISKSCRwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("filterRiskScoreCriteriaByType"),
                success: function (data)
                {
                    $("#RISKSCRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RISKSCRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function refresh(empty)
    {
        $("#RISKSCRwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskScoreCriteria"),
                success: function (data)
                {
                    $("#RISKSCRwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(data.d, empty);    
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RISKSCRwait").fadeOut(500, function ()
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
        var row = empty;

        var xml = $.parseXML(data);

        $("#<%=gvRiskScoreCriteria.ClientID%> tr").not($("#<%=gvRiskScoreCriteria.ClientID%> tr:first-child")).remove();


        $(xml).find("ScoreCriteria").each(function (index, value) {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'  />");
            $("td", row).eq(2).html($(this).attr("ScoreCriteriaID"));
            $("td", row).eq(3).html($(this).attr("RiskType"));
            $("td", row).eq(4).html($(this).attr("Comparator") + " " + $(this).attr("ComparatorValue"));
            $("td", row).eq(5).html($(this).attr("Rank"));
            $("td", row).eq(6).html(shortenText($(this).attr("Description"))).text();

            $("#<%=gvRiskScoreCriteria.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeRiskScoreCriteria($(value).attr("ScoreCriteriaID"));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function () {
                        $("#validation_dialog_general").hide();

                        reset();

                        /*set the mode to edit*/
                        $("#MODE").val('EDIT');

                        /* bind the ID of the risk score criteria*/
                        $("#ScoreID").val($(value).attr("ScoreCriteriaID"));

                        /*bind the description of the risk score criteria*/
                        if ($(value).attr("Description") == '') {
                            addWaterMarkText('The description of the risk criteria', '#<%=DESCTxt.ClientID%>');
                        }
                        else {
                            if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text();
                        }

                        /*bind risk type*/
                        bindComboboxAjax('loadRiskType', "#<%=RSKTYPCBox.ClientID%>", $(value).attr("RiskType"), "#RSKTYP_LD");

                        /*bind comparator sign*/
                        bindComboboxAjax('loadComparatorOperators', "#<%=COMPRCBox.ClientID%>", $(value).attr("Comparator"), "#COMPR_LD");

                       
                        /*bind the comparator value of the risk*/
                        $("#<%=COMPRTxt.ClientID%>").val($(value).attr("ComparatorValue"));

                        /*bind the rank*/
                        $("#<%=RTTxt.ClientID%>").val($(value).attr("Rank"));


                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvRiskScoreCriteria.ClientID%> tr:last-child").clone(true);
        });
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

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
