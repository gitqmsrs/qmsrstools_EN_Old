<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageRiskCriteria.aspx.cs" Inherits="QMSRSTools.RiskManagement.ManageRiskCriteria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="RISKCRT_Header" class="moduleheader">Manage Risk Criteria</div>
    
    <div class="toolbox">
        <img id="new" src="../Images/new_file.png" class="imgButton" title="Create New Risk Criteria" alt=""/> 
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
    
    <div id="RISKCRTwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>
    
     <div id="CriteriaScrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvRiskCriteria" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="CriteriaID" HeaderText="ID" />
                <asp:BoundField DataField="RiskType" HeaderText="Risk Type" />
                <asp:BoundField DataField="RiskCriteria" HeaderText="Risk Criteria" />
                <asp:BoundField DataField="Description" HeaderText="Details" />
            </Columns>
        </asp:GridView>
    </div>
    
    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CriteriaHeader" class="modalHeader">Risk Criteria Details<span id="close" class="modalclose" title="Close">X</span></div>

        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>    
        
        <input id="CriteriaID" type="hidden" value="" />
      
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
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
            <div id="CriteriaLabel" class="requiredlabel">Criteria:</div>
            <div id="CriteriaField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="CRTTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div> 
             <div id="CRITlimit" class="textremaining"></div>   
       
            <asp:RequiredFieldValidator ID="CRTVal" runat="server" Display="None" ControlToValidate="CRTTxt" ErrorMessage="Enter the criteria of the risk (e.g. High, Medium, ..etc)" ValidationGroup="General"></asp:RequiredFieldValidator> 
            
            <asp:CustomValidator id="CRTTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CRTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
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
        var empty = $("#<%=gvRiskCriteria.ClientID%> tr:last-child").clone(true);

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

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#cancel").trigger('click');
            }
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

        $("#new").bind('click', function ()
        {
            $("#validation_dialog_general").hide();

            reset();

            /*load risk types*/
            loadComboboxAjax('loadRiskType', "#<%=RSKTYPCBox.ClientID%>", "#RSKTYP_LD");

            addWaterMarkText('The description of the risk criteria', '#<%=DESCTxt.ClientID%>');

            /*attach category name to limit plugin*/
            $("#<%=CRTTxt.ClientID%>").limit({ id_result: 'CRITlimit', alertClass: 'alertremaining', limit: 90 });

            /*set modal mode to add*/
            $("#MODE").val('ADD');

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#save").click(function () 
        {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid) 
            {
                if (!$("#validation_dialog_general").is(":hidden")) 
                {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD')
                        {
                            var criteria =
                            {
                                RiskType: $("#<%=RSKTYPCBox.ClientID%>").val(),
                                Criteria: $("#<%=CRTTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                               type: "POST",
                               contentType: "application/json; charset=utf-8",
                               dataType: "json",
                               data: "{\'json\':\'" + JSON.stringify(criteria) + "\'}",
                               url: getServiceURL().concat('createCriteria'),
                               success: function (data)
                               {
                                   $("#SaveTooltip").fadeOut(500, function ()
                                   {
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
                        else if ($("#MODE").val() == 'EDIT')
                        {
                            var criteria =
                            {
                                RiskType: $("#<%=RSKTYPCBox.ClientID%>").val(),
                                RiskCriteriaID: $("#CriteriaID").val(),
                                Criteria: $("#<%=CRTTxt.ClientID%>").val(),
                                Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(criteria) + "\'}",
                                url: getServiceURL().concat('updateCriteria'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

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
                        }
                    });
                } 
            }
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });
    });

    function removeRiskCriteria(criteriaID)
    {
        var result = confirm("Are you sure you would like to remove the current risk criteria record?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'criteriaID':'" + criteriaID + "'}",
                url: getServiceURL().concat("removeRiskCriteria"),
                success: function (data)
                {
                    $(".modulewrapper").css("cursor", "default");
                    $("#refresh").trigger('click');
                },
                error: function (xhr, status, error)
                {
                    $(".modulewrapper").css("cursor", "default");
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
    }
    function filterByRiskType(risktype, empty)
    {
        $("#RISKCRTwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("filterCriteriaByRiskType"),
                success: function (data)
                {
                    $("#RISKCRTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RISKCRTwait").fadeOut(500, function ()
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
        $("#RISKCRTwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCriteria"),
                success: function (data)
                {
                    $("#RISKCRTwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RISKCRTwait").fadeOut(500, function ()
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
        var xmlCriteria = $.parseXML(data);

        var row = empty;

        $("#<%=gvRiskCriteria.ClientID%> tr").not($("#<%=gvRiskCriteria.ClientID%> tr:first-child")).remove();


        $(xmlCriteria).find("RiskCriteria").each(function (index, value) {
            $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'  />");
            $("td", row).eq(2).html($(this).attr("RiskCriteriaID"));
            $("td", row).eq(3).html($(this).attr("RiskType"));
            $("td", row).eq(4).html($(this).attr("Criteria"));
            $("td", row).eq(5).html(shortenText($(this).attr("Description"))).text();


            $("#<%=gvRiskCriteria.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeRiskCriteria($(value).attr("RiskCriteriaID"));
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function () {
                        $("#validation_dialog_general").hide();

                        reset();

                        /*set the mode to edit*/
                        $("#MODE").val('EDIT');

                        /* bind the ID of the risk criteria*/
                        $("#CriteriaID").val($(value).attr("RiskCriteriaID"));

                        /*bind the name of the risk criteria*/
                        $("#<%=CRTTxt.ClientID%>").val($(value).attr("Criteria"));


                        /*bind the description of the risk criteria*/
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

                        /*attach category name to limit plugin*/
                        $("#<%=CRTTxt.ClientID%>").limit({ id_result: 'CRITlimit', alertClass: 'alertremaining', limit: 90 });

                        $('#<%=CRTTxt.ClientID%>').keyup();

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }
            });

            row = $("#<%=gvRiskCriteria.ClientID%> tr:last-child").clone(true);
        });
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
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
</script>
</asp:Content>
