<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="ManageDepreciation.aspx.cs" Inherits="QMSRSTools.AssetManagement.ManageDepreciation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="AssetDepreciation_Header" class="moduleheader">Manage Asset Depreciation</div>
    <div class="toolbox">
        <img id="refresh" src="<%=GetSitePath() + "/Images/refresh.png" %>" class="imgButton" alt="" title="Refresh Data" />
        <img id="new" src="<%=GetSitePath() + "/Images/new_file.png" %>" class="imgButton" title="Add New Depreciation Record" alt=""/>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="AssetTAGLabel" class="requiredlabel">Asset TAG:</div>
        <div id="AssetTAGField" class="fielddiv" style="width:250px">
            <asp:TextBox ID="ASSTTAGTxt" Width="240px" runat="server" CssClass="textbox" ReadOnly="true">
            </asp:TextBox>
        </div>  
        <div id="Asset_LD" class="control-loader"></div>

        <span id="TAGSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the asset record"></span>      
        
        <asp:RequiredFieldValidator ID="ASSTTAGTxtVal" runat="server" Display="None" ControlToValidate="ASSTTAGTxt" ErrorMessage="Enter the TAG of the asset" ValidationGroup="TAG"></asp:RequiredFieldValidator>   
    </div>

    <div id="SearchAsset" class="selectbox">
    
    <div class="toolbox">
        
        <img id="deletefilter" src="<%=GetSitePath() + "/Images/filter-delete-icon.png" %>" class="selectBoxImg" alt=""/>

        <div id="filter_div">
            <img id="filter" src="<%=GetSitePath() + "/Images/filter.png" %>" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byCAT">Filter by Asset Category</li>
                <li id="byINSTDT">Filter by Installation Date</li>
                <li id="byPURDT">Filter by Purchase Date</li>
                <li id="byASSTSTS">Filter by Asset Status</li>
                <li id="byORG">Filter by Organization Unit</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
        <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
    
    </div>

    <div id="InstallationDateContainer" class="filter">
        <div id="InstallationDateFLabel" class="filterlabel">Installation Date:</div>
        <div id="InstallationDateFField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            <asp:Label ID="Label5" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="INSTFDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="INSTTDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>
        
    <div id="PurchaseDateContainer" class="filter">
        <div id="PurchaseDateFLabel" class="filterlabel">Purchase Date:</div>
        <div id="PurchaseDateFField" class="filterfield">
            <asp:TextBox ID="PURFDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
            <asp:Label ID="Label6" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="PURTDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="PURFDTTxtVal" runat="server" TargetControlID="PURFDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="PURTFTTxtVal" runat="server" TargetControlID="PURTDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>

    <div id="AssetCategoryContainer" class="filter">
        <div id="AssetCategoryFLabel" class="filterlabel">Asset Category:</div>
        <div id="AssetCategoryFField" class="filterfield">
            <asp:DropDownList ID="ASSTCATFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        
        <div id="ASSTCATF_LD" class="control-loader"></div>
    </div>

    <div id="AssetOrganizationUnitContainer" class="filter">
        <div id="AssetOrganizationFLabel" class="filterlabel">Organization Unit:</div>
        <div id="AssetOrganizationFField" class="filterfield">
            <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        
        <div id="ORGUNTF_LD" class="control-loader"></div>
    </div>

    <div id="AssetStatusContainer" class="filter">
        <div id="AssetStatusFLabel" class="filterlabel">Asset Status:</div>
        <div id="AssetStatusFField" class="filterfield">
            <asp:DropDownList ID="ASSTSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="ASSTSTSF_LD" class="control-loader"></div>
    </div>

    <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RECMODF_LD" class="control-loader"></div>
    </div>
    
    <div id="FLTR_LD" class="control-loader"></div> 
    
    <div id="AssetScroll" class="gridscroll">
            <asp:GridView id="gvAssets" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:BoundField DataField="TAG" HeaderText="Asset TAG" />
                    <asp:BoundField DataField="Model" HeaderText="Model" />
                    <asp:BoundField DataField="AssetCategory" HeaderText="Category" />
                    <asp:BoundField DataField="PurchasePrice" HeaderText="Purchase Price" />
                    <asp:BoundField DataField="Manufacturer" HeaderText="Manufacturer" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="AssetGroupHeader" class="groupboxheader" style=" margin-top:10px;">Asset Details</div>
    <div id="AssetGroupField" class="groupbox" style="height:170px">

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="AssetCategoryLabel" class="labeldiv">Asset Category:</div>
            <div id="AssetCategoryField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="ASSTCATTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>

            <div id="PurchasePriceLabel" class="labeldiv">Purchase Price:</div>
            <div id="PurchasePriceField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="PURCHPRCTxt" Width="150px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
                <asp:Label ID="Label2" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="PURCHCURRTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="70px"></asp:TextBox>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DepreciationMethodLabel" class="labeldiv">Depreciation Method:</div>
            <div id="DepreciationMethodField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="DEPMTHDTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>
            <div id="CurrentValueLabel" class="labeldiv">Current Asset Value:</div>
            <div id="CurrentValueField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="CURRPRCTxt" Width="150px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
                <asp:Label ID="Label3" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="CURRCURTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="70px"></asp:TextBox>
            </div>
            
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DepreciationLifeLabel" class="labeldiv">Depreciation Life:</div>
            <div id="DepreciationLifeField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="DEPRTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="50px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="DEPRDTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="120px"></asp:TextBox>
            </div>
            
            <div id="AssetStatusLabel" class="labeldiv">Asset Status:</div>
            <div id="AssetStatusField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="ASSTSTSTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
           </div>     
        </div>
      
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="InstallationDateLabel" class="labeldiv">Installation Date:</div>
            <div id="InstallationDateField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="INSTDTTxt" Width="240px" runat="server" CssClass="readonly" ReadOnly="true">
                </asp:TextBox>
            </div>     
        </div>
      
    </div>
    
    <div id="DEPWait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" class="gridscroll">
        <asp:GridView id="gvDepreciation" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="DepreciationDate" HeaderText="Depreciation Date" />
            <asp:BoundField DataField="Amount" HeaderText="Depreciable Amount" />
            <asp:BoundField DataField="CurrentAssetValue" HeaderText="Curr. Value" />
            <asp:BoundField DataField="AccumulativeDepreciation" HeaderText="Acc. Depreciation" />
            <asp:BoundField DataField="Currency" HeaderText="Currency" />
        </Columns>
        </asp:GridView>
    </div>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel" style="height:200px">
        <div id="header" class="modalHeader">Deprecitaion Details<span id="close" class="modalclose" title="Close">X</span></div>
      
        <div id="SaveTooltip" class="tooltip">
            <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
      
        
        <div id="DepreciationTooltip" class="tooltip">
            <img src="<%=GetSitePath() + "/Images/Warning.png" %>" alt="Help" height="25" width="25" />
            <p></p>
	    </div>
           
        <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <input id="DEPRECID" type="hidden" value="" />

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DepreciationAmountLabel" class="requiredlabel">Depreciation Amount:</div>
            <div id="DepreciationAmountField" class="fielddiv" style="width:280px">
                <asp:TextBox ID="DEPAMNTTxt" runat="server" Width="140px" CssClass="textbox"></asp:TextBox>
                <asp:Label ID="Label4" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="DEPCURRTxt" runat="server" Width="85px" CssClass="readonly" ReadOnly="true"></asp:TextBox>
            </div>  
            <asp:RequiredFieldValidator ID="DEPAMNTVal" runat="server" Display="None" ControlToValidate="DEPAMNTTxt" ErrorMessage="Enter the amount of the depreciation" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <asp:RegularExpressionValidator ID="DEPAMNTTxtval" runat="server" ControlToValidate="DEPAMNTTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
            
            <asp:CompareValidator ID="DEPAMNTTxtFVal" runat="server" ControlToCompare="CURRPRCTxt"  ValidationGroup="General"
            ControlToValidate="DEPAMNTTxt" ErrorMessage="The amount of depreciation should be less than the current value of the asset"
            Operator="LessThan" Type="Double" Display="None"></asp:CompareValidator>

        </div>
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DepreciationDateLabel" class="requiredlabel">Depreciation Date:</div>
            <div id="DepreciationDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="DEPDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>     
            <asp:RequiredFieldValidator ID="DEPDTTxtVal" runat="server" Display="None" ControlToValidate="DEPDTTxt" ErrorMessage="Enter the depreciation date" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <asp:RegularExpressionValidator ID="DEPDTVal" runat="server" ControlToValidate="DEPDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>
            
            <asp:CustomValidator id="DEPDTFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DEPDTTxt" Display="None" ErrorMessage = "Depreciation date should be greater than the installation date of the asset"
            ClientValidationFunction="compareInstallationDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="DEPDTF1Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "DEPDTTxt" Display="None" ErrorMessage = "Depreciation date should not be in future"
            ClientValidationFunction="comparePast">
            </asp:CustomValidator>
     
        </div>
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>
    
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <input id="assetJSON" type="hidden" value="" /> 
    <input id="MODE" type="hidden" value="" /> 
</div>

<script type="text/javascript" language="javascript">
    $(function () {
        var empty = $("#<%=gvAssets.ClientID%> tr:last-child").clone(true);
            var depempty = $("#<%=gvDepreciation.ClientID%> tr:last-child").clone(true);
            var currentassetvalue = 0;

            /*initially the add functionality must be disabled until the asset record is chosen*/
            disableAdd(true);

            $("#<%=TAGSelect.ClientID%>").click(function (e)
            {
                showAssetDialog(e.pageX, e.pageY, empty);
            });

            $("#deletefilter").bind('click', function () {
                hideAll();

                loadAssets(empty);
            });

            $("#byINSTDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#InstallationDateContainer").show();
            });

            $("#byPURDT").bind('click', function () {
                hideAll();

                /*Clear filter texts*/
                $("#<%=PURFDTTxt.ClientID%>").val('');
                $("#<%=PURTDTTxt.ClientID%>").val('');

                $("#PurchaseDateContainer").show();
            });

            $("#byASSTSTS").bind('click', function () {
                hideAll();

                loadComboboxAjax('loadAssetStatus', "#<%=ASSTSTSFCBox.ClientID%>", "#ASSTSTSF_LD");

                $("#AssetStatusContainer").show();
            });

            $("#byORG").bind('click', function () {
                hideAll();

                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTFCBox.ClientID%>", "#ORGUNTF_LD");

                $("#AssetOrganizationUnitContainer").show();
            });

            $("#byCAT").bind('click', function () {
                hideAll();

                loadAssetCategories();

                $("#AssetCategoryContainer").show();
            });

            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#RecordModeContainer").show();

                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
            });


            /*filter by installation date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByInstallationDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByInstallationDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), empty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByInstallationDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), empty);
                }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByInstallationDateRange($("#<%=FDTTxt.ClientID%>").val(), date, empty);
               }
            });


            /*filter by purchase date range*/
            $("#<%=PURFDTTxt.ClientID%>").keyup(function () {
                filterByPurchaseDateRange($(this).val(), $("#<%=PURTDTTxt.ClientID%>").val(), empty);
            });

            $("#<%=PURTDTTxt.ClientID%>").keyup(function () {
                filterByPurchaseDateRange($("#<%=PURFDTTxt.ClientID%>").val(), $(this).val(), empty);
            });


            $("#<%=PURFDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByPurchaseDateRange(date, $("#<%=PURTDTTxt.ClientID%>").val(), empty);
               }
            });

            $("#<%=PURTDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByPurchaseDateRange($("#<%=PURFDTTxt.ClientID%>").val(), date, empty);
                }
            });

            $("#<%=ORGUNTFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByDepartment($(this).val(), empty);
                }
            });

            $("#<%=ASSTCATFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByCategory($(this).val(), empty);
                }
            });

            $("#<%=ASSTSTSFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByAssetStatus($(this).val(), empty);
                }
            });

            $("#<%=RECMODCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterByAssetMode($(this).val(), empty);
                }
            });

            $("#refresh").bind('click', function () {
                if ($("#assetJSON").val() != '') {
                    loadDepreciationList(depempty);
                }
                else {
                    alert("Please select an asset record");
                }
            });


            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#closeBox").bind('click', function () {
                $("#SearchAsset").hide('800');
            });

            $("#save").bind('click', function () {
                var isAssetTAGValid = Page_ClientValidate('TAG');
                if (isAssetTAGValid) {
                    var isPageValid = Page_ClientValidate('General');
                    if (isPageValid) {
                        if (!$("#validation_dialog_general").is(":hidden")) {
                            $("#validation_dialog_general").hide();
                        }

                        var result = confirm("Are you sure you would like to submit changes?");
                        if (result == true) {

                            $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                                ActivateSave(false);

                                var depdatepart = getDatePart($("#<%=DEPDTTxt.ClientID%>").val());

                                if ($("#MODE").val() == 'ADD') {
                                    var depreciation =
                                    {
                                        DepreciationAmount: parseFloat($("#<%=DEPAMNTTxt.ClientID%>").val()),
                                        DepreciationDate: new Date(depdatepart[2], (depdatepart[1] - 1), depdatepart[0]),
                                        Currency: $("#<%=DEPCURRTxt.ClientID%>").val()
                                    }

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: "{\'json\':\'" + JSON.stringify(depreciation) + "\','TAG':'" + $("#<%=ASSTTAGTxt.ClientID%>").val() + "'}",
                                        url: getServiceURL().concat('createDepreciation'),
                                        success: function (data) {
                                            $("#SaveTooltip").fadeOut(500, function () {
                                                ActivateSave(true);

                                                $("#cancel").trigger('click');

                                                var e = jQuery.Event("keydown");
                                                e.which = 13; // # Some key code value
                                                $("#<%=ASSTTAGTxt.ClientID%>").trigger(e);
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
                                }
                                else {
                                    var depreciation =
                                    {
                                        DepreciationID: $("#DEPRECID").val(),
                                        DepreciationAmount: parseFloat($("#<%=DEPAMNTTxt.ClientID%>").val()),
                                        DepreciationDate: new Date(depdatepart[2], (depdatepart[1] - 1), depdatepart[0]),
                                        Currency: $("#<%=DEPCURRTxt.ClientID%>").val()
                                    }

                                    $.ajax(
                                    {
                                        type: "POST",
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: "{\'json\':\'" + JSON.stringify(depreciation) + "\'}",
                                        url: getServiceURL().concat('updateDepreciation'),
                                        success: function (data) {
                                            $("#SaveTooltip").fadeOut(500, function () {
                                                ActivateSave(true);

                                                $("#cancel").trigger('click');

                                                var e = jQuery.Event("keydown");
                                                e.which = 13; // # Some key code value
                                                $("#<%=ASSTTAGTxt.ClientID%>").trigger(e);
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
                                }
                            });
                        }

                    }
                    else {
                        $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {

                        });
                    }
                }
                else {
                    alert("Please enter a valid asset TAG number");
                }
            });

            $("#<%=DEPDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#new").bind('click', function () {
                if ($("#assetJSON").val() != '') {
                    var asset = $.parseJSON($("#assetJSON").val());

                    var totaldepreciation = calculateTotalDepreciation();

                    if (totaldepreciation < currentassetvalue)
                    {
                        resetGroup('.modalPanel');

                        $("#MODE").val("ADD");

                        /*clear all previous values*/
                        $("#<%=DEPAMNTTxt.ClientID%>").val('');
                        $("#<%=DEPCURRTxt.ClientID%>").val('');
                        $("#<%=DEPDTTxt.ClientID%>").val('');

                        /* set asset currency*/
                        $("#<%=DEPCURRTxt.ClientID%>").val(asset.Currency);

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');
                    }
                    else
                    {
                        alert("The accumulative depreciation amount must be less than the current value of the asset, in order to add a new depreciation record.");
                    }
                }
                else
                {
                    alert("Please select an asset record");
                }
            });

            $("#<%=ASSTTAGTxt.ClientID%>").keydown(function (event) {
                var $obj = $(this);

                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    $("#Asset_LD").stop(true).hide().fadeIn(500, function () {
                        $(".modulewrapper").css("cursor", "wait");

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'TAG':'" + $obj.val() + "'}",
                            url: getServiceURL().concat('getAsset'),
                            success: function (data) {
                                $("#Asset_LD").fadeOut(500, function () {

                                    $(".modulewrapper").css("cursor", "default");

                                    var xml = $.parseXML(data.d);
                                    var asset = $(xml).find('Asset');

                                    var assetjson =
                                    {
                                        AssetID: asset.attr('AssetID'),
                                        Mode: asset.attr('ModeString'),
                                        Currency: asset.attr('Currency'),
                                        InstallationDate: new Date(asset.attr('InstallationDate')).format("dd/MM/yyyy"),
                                    }

                                    /*serialize and temprary store json data*/
                                    $("#assetJSON").val(JSON.stringify(assetjson));

                                    if (asset.attr('ModeString') == 'Archived') {

                                        /*deactivate add button*/
                                        disableAdd(true);
                                    }
                                    else {
                                        /*activate add button*/
                                        disableAdd(false);
                                    }

                                    $("#<%=ASSTCATTxt.ClientID%>").val(asset.attr('AssetCategory'));
                                    $("#<%=PURCHPRCTxt.ClientID%>").val(asset.attr('PurchasePrice'));
                                    $("#<%=PURCHCURRTxt.ClientID%>").val(asset.attr('Currency'));
                                    $("#<%=DEPMTHDTxt.ClientID%>").val(asset.attr('DepreciationMethod'));
                                    $("#<%=CURRPRCTxt.ClientID%>").val(asset.attr('CurrentValue'));
                                    $("#<%=CURRCURTxt.ClientID%>").val(asset.attr('Currency'));
                                    $("#<%=DEPRTxt.ClientID%>").val(asset.attr('DepreciableLife'));
                                    $("#<%=DEPRDTxt.ClientID%>").val(asset.attr('DepreciablePeriod'));
                                    $("#<%=ASSTSTSTxt.ClientID%>").val(asset.attr('AssetStatus'));
                                    $("#<%=INSTDTTxt.ClientID%>").val(new Date(asset.attr('InstallationDate')).format("dd/MM/yyyy"));


                                    currentassetvalue = parseFloat(asset.attr('CurrentValue'));

                                    loadDepreciationList(depempty);
                                    
                                });
                            },
                            error: function (xhr, status, error) {
                                $("#Asset_LD").fadeOut(500, function () {
                                    $(".modulewrapper").css("cursor", "default");

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    showErrorNotification(r.Message);

                                    reset();


                                    $("#<%=gvDepreciation.ClientID%> tr").not($("#<%=gvDepreciation.ClientID%> tr:first-child")).empty();

                                    $("#assetJSON").val('');
                                });
                            }
                        });
                    });
                }

            });
        });
        function compareInstallationDate(sender, args) {
            var asset = $.parseJSON($("#assetJSON").val());

            var targetdatepart = getDatePart(args.Value);
            var installationdatepart = getDatePart(asset.InstallationDate);

            var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
            var installationdate = new Date(installationdatepart[2], (installationdatepart[1] - 1), installationdatepart[0]);

            if (targetdate > installationdate) {
                args.IsValid = true;
            }
            else {
                args.IsValid = false;
            }

            return args.IsValid;
        }
        function filterByPurchaseDateRange(start, end, empty) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true) {

                $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
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
                        url: getServiceURL().concat('filterAssetsByPurchaseDate'),
                        success: function (data) {

                            $("#FLTR_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                loadGridView(data.d, empty);
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
        }

        function filterByInstallationDateRange(start, end, empty) {
            var sd = getDatePart(start);
            var ed = getDatePart(end);

            var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
            var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

            if (isNaN(startdate) != true && isNaN(enddate) != true) {
                $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
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
                        url: getServiceURL().concat('filterAssetsByInstallationDate'),
                        success: function (data) {

                            $("#FLTR_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                loadGridView(data.d, empty);
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
        }
        function filterByDepartment(department, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'department':'" + department + "'}",
                    url: getServiceURL().concat('filterAssetsByDepartment'),
                    success: function (data) {

                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
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
        function filterByAssetMode(mode, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'mode':'" + mode + "'}",
                    url: getServiceURL().concat('filterAssetsByMode'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
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

        function filterByAssetStatus(status, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",
                    url: getServiceURL().concat('filterAssetsByStatus'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");
                            loadGridView(data.d, empty);
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

        function filterByCategory(category, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'category':'" + category + "'}",
                    url: getServiceURL().concat('filterAssetsByCategory'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
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

        function calculateTotalDepreciation()
        {
            var total = 0;

            $("#<%=gvDepreciation.ClientID%> tr").not($("#<%=gvDepreciation.ClientID%> tr:first-child")).each(function ()
            {
                total += parseFloat($("td", $(this)).eq(3).html());
            });

            return total;
        }

        function loadAssets(empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{}",
                    url: getServiceURL().concat('loadAssets'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
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

        function loadDepreciationGridView(data, empty) {
            var asset = $.parseJSON($("#assetJSON").val());

            var xmlDepreciation = $.parseXML(data);

            var row = empty;

            $("#<%=gvDepreciation.ClientID%> tr").not($("#<%=gvDepreciation.ClientID%> tr:first-child")).remove();

            $(xmlDepreciation).find("Depreciation").each(function (index, value)
            {
                $("td", row).eq(0).html("<img id='delete_" + index + "' src='<%=GetSitePath() + "/Images/deletenode.png" %>' class='imgButton' />");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='<%=GetSitePath() + "/Images/edit.png" %>' class='imgButton'/>");

                var depreciationdate = new Date($(this).attr("DepreciationDate"));
                depreciationdate.setMinutes(depreciationdate.getMinutes() + depreciationdate.getTimezoneOffset());

                $("td", row).eq(2).html(depreciationdate.format('dd/MM/yyyy'));
                $("td", row).eq(3).html($(this).attr("DepreciationAmount"));
                $("td", row).eq(4).html($(this).attr("CurrentAssetValue"));
                $("td", row).eq(5).html($(this).attr("AccumulativeDepreciation"));
                $("td", row).eq(6).html($(this).attr("Currency"));

                $("#<%=gvDepreciation.ClientID%>").append(row);

                $(row).find('img').each(function ()
                {
                    if ($(this).attr('id').search('edit') != -1)
                    {
                        $(this).bind('click', function ()
                        {
                            resetGroup('.modalPanel');

                            $("#DEPRECID").val($(value).attr('DepreciationID'));

                            $("#<%=DEPAMNTTxt.ClientID%>").val($(value).attr('DepreciationAmount'));
                            $("#<%=DEPCURRTxt.ClientID%>").val($(value).attr('Currency'));
                            $("#<%=DEPDTTxt.ClientID%>").val(depreciationdate.format('dd/MM/yyyy'));

                            if (asset.Mode == 'Archived')
                            {
                                $("#DepreciationTooltip").find('p').text("Changes cannot take place since the asset record is archived");

                                if ($("#DepreciationTooltip").is(":hidden")) {
                                    $("#DepreciationTooltip").slideDown(800, 'easeOutBounce');
                                }

                                ActivateAll(false);
                            }
                            else
                            {
                                $("#DepreciationTooltip").hide();
                                ActivateAll(true);
                            }

                            /*set mode to edit*/
                            $("#MODE").val("EDIT");

                            /*trigger modal popup extender*/
                            $("#<%=alias.ClientID%>").trigger('click');

                        });
                    }
                    else if ($(this).attr('id').search('delete') != -1) {
                        $(this).bind('click', function () {
                            removeDepreciation($(value).attr('DepreciationID'), empty);
                        });
                    }
                });

                row = $("#<%=gvDepreciation.ClientID%> tr:last-child").clone(true);
            });
        }

        function removeDepreciation(ID, empty) {
            var result = confirm("Are you sure you would like to remove the selected depreciation?");
            if (result == true) {
                $(".modulewrapper").css("cursor", "wait");
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'ID':'" + ID + "'}",
                    url: getServiceURL().concat('removeDepreciation'),
                    success: function (data) {
                        $(".modulewrapper").css("cursor", "default");
                        
                        var e = jQuery.Event("keydown");
                        e.which = 13; // # Some key code value
                        $("#<%=ASSTTAGTxt.ClientID%>").trigger(e);
                    },
                    error: function (xhr, status, error) {
                        $(".modulewrapper").css("cursor", "default");
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    }
                });
            }
        }

        function loadGridView(data, empty) {
            var xmlAssets = $.parseXML(data);

            var row = empty;

            $("#<%=gvAssets.ClientID%> tr").not($("#<%=gvAssets.ClientID%> tr:first-child")).remove();

            $(xmlAssets).find("Asset").each(function (index, value) {
                $("td", row).eq(0).html($(this).attr("TAG"));
                $("td", row).eq(1).html($(this).attr("Model"));
                $("td", row).eq(2).html($(this).attr("AssetCategory"));
                $("td", row).eq(3).html($(this).attr("PurchasePrice") + " " + $(this).attr("Currency"));
                $("td", row).eq(4).html($(this).attr("Manufacturer"));
                $("td", row).eq(5).html($(this).attr("AssetStatus"));
                $("td", row).eq(6).html($(this).attr("ModeString"));

                $("#<%=gvAssets.ClientID%>").append(row);

                row = $("#<%=gvAssets.ClientID%> tr:last-child").clone(true);
            });

            $("#<%=gvAssets.ClientID%> tr").not($("#<%=gvAssets.ClientID%> tr:first-child")).each(function () {
                $(this).bind('click', function () {
                    $("#SearchAsset").hide('800');


                    $("#<%=ASSTTAGTxt.ClientID%>").val($("td", $(this)).eq(0).html());

                    var e = jQuery.Event("keydown");
                    e.which = 13; // # Some key code value
                    $("#<%=ASSTTAGTxt.ClientID%>").trigger(e);
                });
            });
        }

    function loadDepreciationList(empty)
    {
        $("#DEPWait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'TAG':'" + $("#<%=ASSTTAGTxt.ClientID%>").val() + "'}",
                url: getServiceURL().concat('loadAssetDepreciation'),
                success: function (data)
                {
                    $("#DEPWait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");
                        loadDepreciationGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#DEPWait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);

                        reset();
                    });
                }
            });
        });
    }

        function disableAdd(value) {
            if (value == true) {
                $("#new").hide();
            }
            else {
                if ($("#new").is(":hidden")) {
                    $("#new").show();
                }
            }
        }

        function loadAssetCategories() {
            $("#ASSTCATF_LD").stop(true).hide().fadeIn(500, function () {

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadAssetCategories"),
                    success: function (data) {
                        $("#ASSTCATF_LD").fadeOut(500, function () {
                            if (data) {
                                loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $("#<%=ASSTCATFCBox.ClientID%>"));
                        }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#ASSTCATF_LD").fadeOut(500, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    }
                });
            });
    }

    function ActivateAll(isactive) {
        if (isactive == false) {
            $(".modalPanel").children().each(function () {
                $(this).find('.textbox').each(function () {
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

                $(this).find('.groupbox').each(function () {
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

                $(this).find('.imgButton').each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('.groupbox').each(function () {
                    $(this).attr('disabled', false);
                });

            });

            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
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

    function showAssetDialog(x, y, empty) {
        loadAssetCategories();
        loadAssets(empty);

        /*hide all filter fields in the select box*/
        hideAll();

        $("#SearchAsset").css({ left: x - 280, top: y + 10 });
        $("#SearchAsset").css({ width: 700, height: 250 });
        $("#SearchAsset").show();
    }

    //function hideAll() {
    //    $(".filter").each(function () {
    //        $(this).css('display', 'none');
    //    });
    //}

    // Added by JP - Override the CSS Hover in contextmenu. 
    $("#filter").hover(function () {
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
    </script>

</asp:Content>
