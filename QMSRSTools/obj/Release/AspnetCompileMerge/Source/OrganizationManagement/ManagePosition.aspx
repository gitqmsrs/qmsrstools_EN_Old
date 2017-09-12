<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManagePosition.aspx.cs" Inherits="QMSRSTools.OrganizationManagement.ManagePosition" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
        <img id="filter" src="../Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byPOS">Filter by Position</li>
                <li id="byORG">Filter by Organization Unit</li>
                <li id="byPOSSTS">Filter by Position Status</li>
                <li id="byOPNDT">Filter by Opening Date Range</li>
            </ul>
        </div>

        <div id="POSContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="PositionNameFilterLabel" style="width:100px;">Job Title:</div>
            <div id="PositionNameFilterField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="POSNMFTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
            </div>
        </div>
  
        <div id="POSStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="PositionStatusFilterLabel" style="width:100px;">Position Status:</div>
            <div id="PositionStatusFilterField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="POSSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="POSSTSF_LD" class="control-loader"></div>
        </div>
    
        <div id="ORGContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="OrganizationFilterLabel" style="width:100px;">Organization Unit:</div>
            <div id="OrganizationFilterField" style="width:170px; left:0; float:left;">
                <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="ORGUNTF_LD" class="control-loader"></div>
        </div>

        <div id="StartdateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
            <div id="StartDateLabel" style="width:120px;">Opening Date:</div>
            <div id="StartDateField" style="width:270px; left:0; float:left;">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>
    </div>

    <div id="FilterTooltip" class="tooltip" style="margin-top:10px;">
        <img src="../Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
	</div>
    
    
    <div id="POSwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvPositions" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="PositionID" HeaderText="ID" />
            <asp:BoundField DataField="Title" HeaderText="Job Title" />
            <asp:BoundField DataField="OpenDate" HeaderText="Opening Date" />
            <asp:BoundField DataField="CloseDate" HeaderText="Closing Date" />
            <asp:BoundField DataField="Supervisor" HeaderText="Report To" />
            <asp:BoundField DataField="PositionStatus" HeaderText="Status" />       
        </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Maintain Position<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
      
        <ul id="tabul" style="margin-top:35px;">
            <li id="Details" class="ntabs">Vacancy Details</li>
            <li id="Skills" class="ntabs">Required Skills</li>
        </ul>
        <div id="DetailsTB" class="tabcontent" style="display:none; height:480px;">
            
            <div id="validation_dialog_general" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>
                
            <input type="hidden" id="POSID" value="" />
        
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="POSTitleLabel" class="requiredlabel">Job Title:</div>
                <div id="POSTitleField" class="fielddiv" style="width:400px;">
                    <asp:TextBox ID="POSTxt" runat="server" Width="390px" CssClass="textbox"></asp:TextBox>
                </div>
                <div id="JTTLlimit" class="textremaining"></div>
       
                <asp:RequiredFieldValidator ID="POSTxtVal" runat="server" Display="None" ControlToValidate="POSTxt" ErrorMessage="Enter the title of the position" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:CustomValidator id="POSTxtF1Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "POSTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]';.\{}| are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator>  
           
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="POSDescriptionLabel" class="labeldiv">Job Description:</div>
                <div id="POSDescriptionField" class="fielddiv" style="width:400px; height:200px;">
                    <asp:TextBox ID="POSDTxt" runat="server" CssClass="textbox" Width="390px" Height="195px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="POSDTxtVal" runat="server" ValidationGroup="General" 
                ControlToValidate = "POSDTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]{}|<>; are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
           
            </div>
            <div style="float:left; width:100%; height:20px; margin-top:195px;">
                <div id="CreateDateLabel" class="requiredlabel">Opening Date:</div>
                <div id="CreateDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="ODateTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>

                <asp:RequiredFieldValidator ID="ODateDTVal" runat="server" Display="None" ControlToValidate="ODateTxt" ErrorMessage="Enter the open date of the position" ValidationGroup="General"></asp:RequiredFieldValidator>
                
                <asp:RegularExpressionValidator ID="ODateDTFVal" runat="server" ControlToValidate="ODateTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" CssClass="validator" ValidationGroup="General"></asp:RegularExpressionValidator>  

                <asp:CustomValidator id="ODateTxtF2Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "ODateTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>

            </div>        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ExpiryDateLabel" class="requiredlabel">Closing Date:</div>
                <div id="ExpiryDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="CLDateTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>
                <asp:RequiredFieldValidator ID="CLDateTxtVal" runat="server" Display="None" ControlToValidate="CLDateTxt" ErrorMessage="Enter the closing date of the position" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="CLDateTxtFVal" runat="server" ControlToValidate="CLDateTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator> 
            
                <asp:CompareValidator ID="CLDateTxtF2Val" runat="server" ControlToCompare="ODateTxt"  ValidationGroup="General"
                ControlToValidate="CLDateTxt" ErrorMessage="Closing date should be greater or equals the opening date"
                Operator="GreaterThanEqual" Type="Date" Display="None"></asp:CompareValidator>
                
                <asp:CustomValidator id="CLDateTxtF3Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "CLDateTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>  
            </div> 

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ORGUNTLabel" class="requiredlabel">Organization Unit:</div>
                <div id="ORGUNTField" class="fielddiv" style="width:300px">
                    <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="ORG_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="ORGUNTTxtVal" runat="server" Display="None" ControlToValidate="ORGUNTCBox" ErrorMessage="Select organization unit" ValidationGroup="General"></asp:RequiredFieldValidator>         
            
                <asp:CompareValidator ID="ORGUNTVal" runat="server" ControlToValidate="ORGUNTCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select organization unit" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div> 
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RepPositionLabel" class="labeldiv">Report To:</div>
                <div id="RepPositionField" class="fielddiv" style="width:300px;">
                    <asp:RadioButton ID="Self" GroupName="ReportPosition" runat="server" CssClass="radiobutton" Text="Self" />
                    <asp:RadioButton ID="Other" GroupName="ReportPosition" runat="server" CssClass="radiobutton" Text="Other position" />
                </div>    
            </div>

            <div id="OtherPosition" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                <div id="PositionLabel" class="labeldiv">Position:</div>
                <div id="PositionField" class="fielddiv" style="width:300px;">
                    <asp:DropDownList ID="REPPOS_CBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="REPPOS_LD" class="control-loader"></div>
            </div>
        
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="POSStatusLabel" class="requiredlabel">Status:</div>
                <div id="POSStatusField" class="fielddiv" style="width:150px">
                    <asp:DropDownList ID="POSSTSCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="POSSTS_LD" class="control-loader"></div>

                <asp:RequiredFieldValidator ID="POSSTSTxtVal" runat="server" Display="None" ControlToValidate="POSSTSCBox" ErrorMessage="Select the status of the position" ValidationGroup="General"></asp:RequiredFieldValidator>
        
                <asp:CompareValidator ID="POSSTSVal" runat="server" ControlToValidate="POSSTSCBox" ValidationGroup="General"
                Display="None" ErrorMessage="Select the status of the position" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>
        </div>
        <div id="SkillsTB" class="tabcontent" style="display:none; height:480px;">
            <img id="newskill" src="../Images/new_file.png" class="imgButton" title="Create new skill" alt=""/>
          
            <div id="table" style="display:none;">
                <div id="row_header" class="tr">
                    <div id="col0_head" class="tdh" style="width:50px"></div>
                    <div id="col1_head" class="tdh" style="width:35%">Skill</div>
                    <div id="col2_head" class="tdh" style="width:35%">Description</div>
                </div>
            </div>
        </div>
    
        <div id="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

</div>
<script language="javascript" type="text/javascript">
        $(function () {
            var empty = $("#<%=gvPositions.ClientID%> tr:last-child").clone(true);

            refresh(empty);

            $("#refresh").bind('click', function () {
                refresh(empty);
            });

            $("#deletefilter").bind('click', function () {
                refresh(empty);
            });

            $("#byPOS").bind('click', function () {
                hideAll();

                $("#<%=POSNMFTxt.ClientID%>").val('');
                $("#POSContainer").show();

            });

            $("#byORG").bind('click', function () {

                hideAll();

                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTFCBox.ClientID%>", "#ORGUNTF_LD");
                $("#ORGContainer").show();

            });

            $("#byPOSSTS").bind('click', function () {

                hideAll();

                loadComboboxAjax('loadPositionStatus', "#<%=POSSTSFCBox.ClientID%>", "#POSSTSF_LD");
                $("#POSStatusContainer").show();

            });

            $("#byOPNDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#StartdateContainer").show();
            });


            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date)
                {
                    filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
                }
            });


            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $("#<%=ORGUNTFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterPositionByUnit($(this).val(), empty);
                }
            });

            $("#<%=POSNMFTxt.ClientID%>").keyup(function () {
                filterPositionsByTitle($(this).val(), empty);
            });

            $("#<%=POSSTSFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterPositionsByStatus($(this).val(), empty);
                }
            });

            $("#<%=Self.ClientID%>").click(function () {
                $("#OtherPosition").stop(true).hide();
            });

            $("#<%=Other.ClientID%>").click(function () {
                if ($("#<%=ORGUNTCBox.ClientID%>").val() != 0) {
                    $("#OtherPosition").stop(true).hide().fadeIn(800, function () {
                        var loadcontrols = new Array();
                        loadcontrols.push('#<%=REPPOS_CBox.ClientID%>');
                        loadParamComboboxAjax('getParentDepPositions', loadcontrols, "'unit':'" + $("#<%=ORGUNTCBox.ClientID%>").val() + "'","#REPPOS_LD");
                    });
                }
                else {
                    alert("Please select an organization unit");

                    $(this).prop('checked', false);
                }
            });

            $("#tabul li").bind("click", function () {
                navigate($(this).attr("id"));
            });


            $("#<%=ODateTxt.ClientID%>").datepicker(
           {
               inline: true,
               dateFormat: "dd/mm/yy",
               onSelect: function () { }
           });

            $("#<%=CLDateTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#newskill").bind('click', function () {
                $("#table").table('addRow',
                {
                    SKL: 'New_Skill',
                    DESC: 'Description',
                    Status: 3
                });
            });


            $("#save").bind('click', function () {
                var isGeneralValid = Page_ClientValidate('General');
                if (isGeneralValid)
                {
                    if (!$("#validation_dialog_general").is(":hidden")) {
                        $("#validation_dialog_general").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {

                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);


                            var posOpenDate = getDatePart($("#<%=ODateTxt.ClientID%>").val());
                            var posCloseDate = getDatePart($("#<%=CLDateTxt.ClientID%>").val());

                            var position =
                            {
                                PositionID: $("#POSID").val(),
                                Title: $("#<%=POSTxt.ClientID%>").val(),
                                Description: $("#<%=POSDTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=POSDTxt.ClientID%>").val()),
                                OpenDate: new Date(posOpenDate[2], (posOpenDate[1] - 1), posOpenDate[0]),
                                CloseDate: new Date(posCloseDate[2], (posCloseDate[1] - 1), posCloseDate[0]),
                                Unit: $("#<%=ORGUNTCBox.ClientID%>").val(),
                                /*if the supervisor from other position was not provided, then the system assumes that the current position is also a supervisor*/
                                Supervisor: $("#<%=REPPOS_CBox.ClientID%>").val() == 0 || $("#<%=REPPOS_CBox.ClientID%>").val() == null ? 'Self' : $("#<%=REPPOS_CBox.ClientID%>").val(),
                                POSStatusStr: $("#<%=POSSTSCBox.ClientID%>").val(),
                                Skills: $("#table").table('getJSON')
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(position) + "\'}",
                                url: getServiceURL().concat('updatePosition'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function () {
                                        ActivateSave(true);

                                        /*close modal popup extender*/
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
                        });
                    }

                }
                else
                {
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                        navigate('Details');

                    });
                }
            });
        });


        function filterByDateRange(start, end, empty) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true) {

                $("#POSwait").stop(true).hide().fadeIn(500, function () {
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
                        url: getServiceURL().concat('filterPositionsByOpeningDateRange'),
                        success: function (data)
                        {
                            $("#POSwait").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                $("#FilterTooltip").stop(true).hide().fadeIn(800, function ()
                                {
                                    $(this).find('p').text("List of all current positions filtered where the opening date between " + startdate.format('dd/MM/yyyy') + " and " + enddate.format('dd/MM/yyyy'));
                                });

                                if (data)
                                {
                                    loadGridView(data.d, empty);
                                }
                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#POSwait").fadeOut(500, function ()
                            {
                                $(".modulewrapper").css("cursor", "default");

                                $("#FilterTooltip").fadeOut(800, function () {
                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);
                                });
                            });
                        }
                    });
                });
            }
        }

        function filterPositionsByTitle(title, empty) {
            $("#POSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'title':'" + title + "'}",
                    url: getServiceURL().concat("filterPositionsByTitle"),
                    success: function (data) {

                        $("#POSwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current positions filtered by position status");
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#POSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
        function filterPositionsByStatus(status, empty) {
            $("#POSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",
                    url: getServiceURL().concat("filterPositionsByStatus"),
                    success: function (data)
                    {
                        $("#POSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current positions filtered by position status");
                            });

                            if (data) {

                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#POSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }

        function filterPositionByUnit(unit, empty) {
            $("#POSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'unit':'" + unit + "'}",
                    url: getServiceURL().concat("filterPositionsByUnit"),
                    success: function (data)
                    {
                        $("#POSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).find('p').text("List of all current positions filtered by organization unit");
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#POSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
        function refresh(empty) {
            $("#POSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadPositions"),
                    success: function (data)
                    {
                        $("#POSwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(this).find('p').text("List of all current positions in the system");
                            });


                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#POSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }

        function removePosition(ID) 
        {
            var result = confirm("Are you sure you would like to remove the current position?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'positionID':'" + posid + "'}",
                    url: getServiceURL().concat("RemovePosition"),
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

        function loadGridView(data, empty) 
        {
            var xml = $.parseXML(data);

            var row = empty;


            $("#<%=gvPositions.ClientID%> tr").not($("#<%=gvPositions.ClientID%> tr:first-child")).remove();

            $(xml).find("Position").each(function (index, value) {
                $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html($(this).attr("PositionID"));
                $("td", row).eq(3).html($(this).attr("Title"));
                $("td", row).eq(4).html(new Date($(this).attr("OpenDate")).format("dd/MM/yyyy"));
                $("td", row).eq(5).html(new Date($(this).attr("CloseDate")).format("dd/MM/yyyy"));
                $("td", row).eq(6).html($(this).attr("Supervisor") == null ? '' : $(this).attr("Supervisor"));
                $("td", row).eq(7).html($(this).attr("POSStatus"));

                $("#<%=gvPositions.ClientID%>").append(row);

                $(row).find('img').each(function () {
                    if ($(this).attr('id').search('delete') != -1) {
                        $(this).bind('click', function () {
                            removePosition($(value).attr("PositionID"));
                        });
                    }
                    else if ($(this).attr('id').search('edit') != -1) {
                        $(this).bind('click', function () 
                        {
                            $("#validation_dialog_general").hide();

                            /*temporarly store position ID*/
                            $("#POSID").val($(value).attr("PositionID"));

                            /*bind the title of the position*/
                            $("#<%=POSTxt.ClientID%>").val($(value).attr("Title"));

                            /*attach job title to limit plugin*/
                            $("#<%=POSTxt.ClientID%>").limit({ id_result: 'JTTLlimit', alertClass: 'alertremaining', limit: 100 });
                            $("#<%=POSTxt.ClientID%>").keyup();
   
                            /*bind position description*/
                            if ($(value).attr("Description") == '') {
                                addWaterMarkText('Enter the description of the job', '#<%=POSDTxt.ClientID%>');
                            }
                            else {
                                if ($("#<%=POSDTxt.ClientID%>").hasClass("watermarktext")) {
                                    $("#<%=POSDTxt.ClientID%>").val('').removeClass("watermarktext");
                                }

                                $("#<%=POSDTxt.ClientID%>").html($(value).attr("Description")).text();

                            }

                            /*bind position opening and closing dates*/
                            $("#<%=ODateTxt.ClientID%>").val(new Date($(value).attr("OpenDate")).format("dd/MM/yyyy"));
                            $("#<%=CLDateTxt.ClientID%>").val(new Date($(value).attr("CloseDate")).format("dd/MM/yyyy"));

                            /*bind organization unit*/
                            bindComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", $(value).attr("Unit"), "#ORG_LD");


                            if($(value).attr("Supervisor")=='Self')
                            {
                                /*set the self radiobutton check to true indicating that the position reports to itself*/
                                $("#<%=Self.ClientID%>").prop('checked', true);
                            
                                $("#OtherPosition").stop(true).hide();
                            }
                            else
                            {
                                $("#<%=Other.ClientID%>").prop('checked', true);
                            
                                $("#OtherPosition").show();

                                /*bind related position*/
                                bindParamComboboxAjax('getParentDepPositions', "#<%=REPPOS_CBox.ClientID%>", "'unit':'" + $(value).attr("Unit") + "'", $(value).attr("Supervisor"), "#REPPOS_LD");
                            }
                        
                            /*bind position status*/
                            bindComboboxAjax('loadPositionStatus', "#<%=POSSTSCBox.ClientID%>", $(value).attr("POSStatus"), "#POSSTS_LD");


                            /*load skills data*/
                            var json = $.parseJSON($(value).attr('JSONSkills'));

                            var attributes = new Array();
                            attributes.push("SKL");
                            attributes.push("DESC");

                            var settings = new Array();
                            settings.push(JSON.stringify({}));
                            settings.push(JSON.stringify({}));

                            $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 35 });

                            navigate('Details');

                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                });
                row = $("#<%=gvPositions.ClientID%> tr:last-child").clone(true);
            });
        }
        function navigate(name) {
            $("#tabul li").removeClass("ctab");

            $(".tabcontent").each(function () {
                $(this).css('display', 'none');
            });

            $("#" + name).addClass("ctab");
            $("#" + name + "TB").css('display', 'block');
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
