<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="CreateMitigationAction.aspx.cs" Inherits="QMSRSTools.RiskManagement.CreateMitigationAction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="wrapper" class="modulewrapper">
    <div id="RSKACT_Header" class="moduleheader">Create a New Risk Mitigation Action</div>

    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt="" />
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="RiskIDLabel" class="requiredlabel">Risk ID:</div>
        <div id="RiskIDField" class="fielddiv" style="width:250px">
            <asp:TextBox ID="RSKIDTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
        </div>

        <span id="RSKIDSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for risk record"></span>
    
        <div id="RSKID_LD" class="control-loader"></div> 
    </div>
    
    <div id="SearchRisk" class="selectbox" style="width:600px; height:250px; top:80px; left:150px;">
        <div class="toolbox">
            <img id="deletefilter" src="/Images/filter-delete-icon.png" class="selectBoxImg" alt=""/>
            
            <div id="filter_div">
                <img id="filter" src="/Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byRSKTYP">Filter by Risk Type</li>
                    <li id="byRSKMOD">Filter by Risk Mode</li>
                    <li id="byRSKCAT">Filter by Risk Category</li>
                    <li id="byRSKSTS">Filter by Risk Status</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                    <li id="byRD">Filter by Register Date</li>
                    <li id="byCLSRDT">Filter by Closure Date</li>
                    <li id="byDUEDT">Filter by Due Date</li>
                </ul>
            </div>
            
            <div id="RiskStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RiskStatusFilterLabel" style="width:100px;">Risk Status:</div>
                <div id="RiskStatusFilterField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RSKSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RSKSTSF_LD" class="control-loader"></div>
            </div>

            <div id="RiskTYPContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RiskTYPFilterLabel" style="width:100px;">Risk Type:</div>
                <div id="RiskTYPFilterField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RSKTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RSKTYPF_LD" class="control-loader"></div>
            </div>

            <div id="RiskModeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RiskModeFilterLabel" style="width:100px;">Risk Mode:</div>
                <div id="RiskModeFilterField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RSKMODFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RSKMODF_LD" class="control-loader"></div>
            </div>

            <div id="RiskCategoryContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RiskCategoryFilterLabel" style="width:100px;">Risk Category:</div>
                <div id="RiskCategoryFilterField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RSKCATFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RSKCATF_LD" class="control-loader"></div>
            </div>

            <div id="RegisterDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                <div id="RegisterDateFilterLabel" style="width:120px;">Register Date:</div>
                <div id="RegisterDateFilterField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="RDFDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="RDTDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="RDFDTFExt" runat="server" TargetControlID="RDFDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="RDTDTFExt" runat="server" TargetControlID="RDTDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
            </div>

            <div id="ClosureDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                <div id="ClosureDateFilterLabel" style="width:120px;">Closure Date:</div>
                <div id="ClosureDateFilterField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="CLSRFDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label2" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="CLSRTDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="CLSRFDTFExt" runat="server" TargetControlID="CLSRFDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="CLSRTDTFExt" runat="server" TargetControlID="CLSRTDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
            </div>

            <div id="DueDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
               <div id="DueDateFilterLabel" style="width:120px;">Due Date:</div>
                <div id="DueDateFilterField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="DUEFDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label3" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="DUETDTFTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="DUEFDTFExt" runat="server" TargetControlID="DUEFDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="DUETDTFExt" runat="server" TargetControlID="DUETDTFTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
            </div>

            <div id="RecordModeContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
                <div id="RecordModeField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RECMODF_LD" class="control-loader"></div>
            </div>

            <div id="closeBox" class="selectboxclose"></div>
        </div>
        
        <div id="FLTR_LD" class="control-loader"></div> 

        <div id="scrollbar" style="height:195px; width:96%; overflow:auto; margin-top:15px; float:left">
            <asp:GridView id="gvRisks" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:BoundField DataField="RiskNo" HeaderText="Risk No." />
                    <asp:BoundField DataField="RiskName" HeaderText="Risk Name" />
                    <asp:BoundField DataField="RiskType" HeaderText="Risk Type" />
                    <asp:BoundField DataField="RiskMode" HeaderText="Risk Mode" />
                    <asp:BoundField DataField="RegisterDate" HeaderText="Register Date" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="MitigationActionGroupHeader" class="groupboxheader">Mitigation Action Details</div>
    <div id="MitigationActionGroupField" class="groupbox" style="height:auto">

        <div id="validation_dialog_action" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Action" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="MitigationTypeLabel" class="labeldiv">Mitigation Type:</div>
            <div id="MitigationTypeField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="MTGTYPCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
        
            <div id="MTGTYP_LD" class="control-loader"></div> 

            
            <span id="MTGADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new mitigation type"></span>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="PotentialImpactLabel" class="labeldiv">Potential Impact:</div>
            <div id="PotentialImpactField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="PIMPTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
     
            <asp:CustomValidator id="PIMPTxtVal" runat="server" ValidationGroup="Action" 
            ControlToValidate = "PIMPTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:122px;">
            <div id="CountermeasuresLabel" class="labeldiv">Countermeasures:</div>
            <div id="CountermeasuresField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="CMSURTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
     
            <asp:CustomValidator id="CMSURTxtVal" runat="server" ValidationGroup="Action" 
            ControlToValidate = "CMSURTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:122px;">
            <div id="ActionLabel" class="labeldiv">Actions:</div>
            <div id="ActionField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="ACTTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
     
            <asp:CustomValidator id="ACTTxtVal" runat="server" ValidationGroup="Action" 
            ControlToValidate = "ACTTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:122px;">
            <div id="RecordOwnerLabel" class="requiredlabel">Actionee:</div>
            <div id="RecordOwnerField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="ACTEECBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="ACTEE_LD" class="control-loader"></div>  
              
            <span id="ACTEESelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the actionee"></span>
        
            <asp:RequiredFieldValidator ID="ACTEEVal" runat="server" Display="None" ControlToValidate="ACTEECBox" ErrorMessage="Select the actionee"  ValidationGroup="Action"></asp:RequiredFieldValidator>              
        
            <asp:CompareValidator ID="ACTEEFVal" runat="server" ControlToValidate="ACTEECBox" ValidationGroup="Action"
            Display="None" ErrorMessage="Select the actionee" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="TRGTDateLabel" class="requiredlabel">Target Close Date:</div>
            <div id="TRGTDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="TRGTDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="TRGTDTVal" runat="server" Display="None" ControlToValidate="TRGTDTTxt" ErrorMessage="Enter the target close date of the action" ValidationGroup="Action"></asp:RequiredFieldValidator>   
       
            <asp:RegularExpressionValidator ID="TRGTDTxtFVal" runat="server" ControlToValidate="TRGTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Action">
            </asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="TRGTDTF2Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "TRGTDTTxt" Display="None" ErrorMessage = "Target close date should be greater than or equals the register date of the risk"
            ClientValidationFunction="compareRegisterDate">
            </asp:CustomValidator>

            <asp:CustomValidator id="TRGTDTF3Val" runat="server" ValidationGroup="Action" 
            ControlToValidate = "TRGTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator> 

        </div>

        <div id="SelectActionee" class="selectbox">
            <div id="closeActionee" class="selectboxclose"></div>

            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>

                <div id="ORGUNT_LD" class="control-loader"></div> 
            </div>
        </div>


    </div>
</div>

<asp:Button ID="MTGTYPalias" runat="server" style="display:none" />

<ajax:ModalPopupExtender ID="MitigationTypeExtender" runat="server" BehaviorID="MitigationTypeExtender" TargetControlID="MTGTYPalias" PopupControlID="MitigationTypePanel" CancelControlID="MTGTYPCancel" BackgroundCssClass="modalBackground">
</ajax:ModalPopupExtender>

<asp:Panel ID="MitigationTypePanel" runat="server" CssClass="modalPanel" style="height:300px;">
    <div id="MTGTYP_header" class="modalHeader">Create New Risk Mitigation Action Type<span id="MTGTYPclose" class="modalclose" title="Close">X</span></div>
    
    <div id="MitigationTypeSaveTooltip" class="tooltip">
        <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
        <p>Saving...</p>
	</div>
   
    <div id="validation_dialog_mitigation" class="validationcontainer" style="display: none">
        <asp:ValidationSummary ID="ValidationSummary6" runat="server" CssClass="validator" ValidationGroup="MitigationType" />
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="MitigationTypeNameLabel" class="requiredlabel">Mitigation Type:</div>
        <div id="MitigationTypeNameField" class="fielddiv" style="width:200px;">
            <asp:TextBox ID="MTGTYPNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
        </div>
        
        <div id="MTGTYPlimit" class="textremaining"></div>

        <asp:RequiredFieldValidator ID="MTGTYPNMTxtVal" runat="server" Display="None" ControlToValidate="MTGTYPNMTxt" ErrorMessage="Enter the name of the mitigation type" ValidationGroup="MitigationType"></asp:RequiredFieldValidator> 

        <asp:CustomValidator id="MTGTYPNMTxtFVal" runat="server" ValidationGroup="MitigationType" 
        ControlToValidate = "MTGTYPNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
        ClientValidationFunction="validateSpecialCharacters">
        </asp:CustomValidator>   
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="MitigationTypeDescriptionLabel" class="labeldiv">Description:</div>
        <div id="MitigationTypeDescriptionField" class="fielddiv" style="width:400px;">
            <asp:TextBox ID="MTGTYPDESTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
        </div>
           
        <asp:CustomValidator id="MTGTYPDESVal" runat="server" ValidationGroup="MitigationType" 
        ControlToValidate = "MTGTYPDESTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
        ClientValidationFunction="validateSpecialCharactersLongText">
        </asp:CustomValidator>
    </div>
    
    <div class="buttondiv">
        <input id="MTGTYPSave" type="button" class="button" style="margin-left:300px;" value="Save" />
        <input id="MTGTYPCancel" type="button" class="button" value="Cancel" />
    </div>   
</asp:Panel>

<asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
    <div style="padding:8px">
        <h2>Saving...</h2>
    </div>
</asp:Panel>

<ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
</ajax:ModalPopupExtender>

<input id="registerdate" type="hidden" />
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvRisks.ClientID%> tr:last-child").clone(true);

        /*deactivate all controls*/
        ActivateAll(false);

        $("#<%=RSKIDTxt.ClientID%>").keydown(function (event)
        {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13')
            {
                var text = $(this).val();

                $("#RSKID_LD").stop(true).hide().fadeIn(500, function ()
                {
                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'riskno':'" + text + "'}",
                        url: getServiceURL().concat('getRiskByID'),
                        success: function (data) 
                        {
                            $("#RSKID_LD").fadeOut(500, function ()
                            {
                                if (data)
                                {
                                    var xmlRisk = $.parseXML(data.d);

                                    var risk = $(xmlRisk).find("Risk");

                                    if ($(risk).attr('RiskStatusString') == 'Closed' || $(risk).attr('RiskStatusString') == 'Cancelled')
                                    {
                                        alert("Changes cannot take place since the risk record is " + $(audit).attr('RiskStatusString'));

                                        resetGroup('.groupbox');

                                        ActivateAll(false);
                                    }
                                    else
                                    {
                                        ActivateAll(true);

                                        loadMitigationType();

                                        if ($("#<%=PIMPTxt.ClientID%>").hasClass("watermarktext") == false)
                                        {
                                            addWaterMarkText('The description of the potential impact', '#<%=PIMPTxt.ClientID%>');
                                        }

                                        if ($("#<%=CMSURTxt.ClientID%>").hasClass("watermarktext") == false)
                                        {
                                            addWaterMarkText('The description of the countermeasures', '#<%=CMSURTxt.ClientID%>');
                                        }

                                        if ($("#<%=ACTTxt.ClientID%>").hasClass("watermarktext") == false)
                                        {
                                            addWaterMarkText('The description of the action', '#<%=ACTTxt.ClientID%>');
                                        }

                                        /*temporarly store the registeration date of the risk*/
                                        $("#registerdate").val($(risk).attr('RegisterDate'));
                                    }

                                }

                            });
                        },
                        error: function (xhr, status, error)
                        {
                            $("#RSKID_LD").fadeOut(500, function ()
                            {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);

                                ActivateAll(false);

                                resetGroup('.groupbox');

                            });
                        }
                    });
                });

            }
        });

        $("#deletefilter").bind('click', function () {
            hideAll();
            refreshRisks(empty);
        });

        $("#<%=RSKIDSRCH.ClientID%>").bind('click', function ()
        {
            refreshRisks(empty);

            $("#SearchRisk").show();
        });


        $("#closeBox").bind('click', function ()
        {
            $("#SearchRisk").hide('800');
        });

        $("#closeActionee").bind('click', function ()
        {
            $("#SelectActionee").hide('800');
        });

        $("#byRD").bind('click', function ()
        {
            hideAll();

            $("#<%=RDFDTFTxt.ClientID%>").val('');
            $("#<%=RDTDTFTxt.ClientID%>").val('');

            $("#RegisterDateContainer").show();
        });

        $("#byCLSRDT").bind('click', function () {
            hideAll();

            $("#<%=CLSRFDTFTxt.ClientID%>").val('');
            $("#<%=CLSRTDTFTxt.ClientID%>").val('');

            $("#ClosureDateContainer").show();
        });

        $("#byDUEDT").bind('click', function () {
            hideAll();

            $("#<%=DUEFDTFTxt.ClientID%>").val('');
            $("#<%=DUETDTFTxt.ClientID%>").val('');

            $("#DueDateContainer").show();
        });

        $("#byRECMOD").bind('click', function ()
        {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#byRSKTYP").bind('click', function () {
            hideAll();

            $("#RiskTYPContainer").show();

            /*load risk type*/
            loadComboboxAjax('loadRiskType', "#<%=RSKTYPFCBox.ClientID%>", "#RSKTYPF_LD");
        });

        $("#byRSKSTS").bind('click', function () {
            hideAll();

            $("#RiskStatusContainer").show();

            /*load risk status*/
            loadComboboxAjax('loadRiskStatus', "#<%=RSKSTSFCBox.ClientID%>", "#RSKSTSF_LD");

        });

        $("#byRSKMOD").bind('click', function () {
            hideAll();

            $("#RiskModeContainer").show();

            /*load risk mode*/
            loadComboboxAjax('loadRiskMode', "#<%=RSKMODFCBox.ClientID%>", "#RSKMODF_LD");

        });

        $("#byRSKCAT").bind('click', function () {
            hideAll();

            $("#RiskCategoryContainer").show();

            /*load risk category*/

            loadRiskCategory("#<%=RSKCATFCBox.ClientID%>", "#RSKCATF_LD");
        });

        /* to add new mitigation action type*/
        $("#<%=MTGADD.ClientID%>").bind('click', function ()
        {
            clearModal();

            /*attach mitigation action type to limit plugin*/
            $('#<%=MTGTYPNMTxt.ClientID%>').limit({ id_result: 'MTGTYPlimit', alertClass: 'alertremaining', limit: 90 });


            addWaterMarkText('The description of the risk mitigation action type', '#<%=MTGTYPDESTxt.ClientID%>');

            $("#<%=MTGTYPalias.ClientID%>").trigger('click');
        });

        /*filter by registration date range*/
        $("#<%=RDFDTFTxt.ClientID%>").keyup(function () {
            filterByRegisterDateRange($(this).val(), $("#<%=RDTDTFTxt.ClientID%>").val(), empty);
        });

        $("#<%=RDTDTFTxt.ClientID%>").keyup(function () {
            filterByRegisterDateRange($("#<%=RDFDTFTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=RDFDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByRegisterDateRange(date, $("#<%=RDTDTFTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=RDTDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByRegisterDateRange($("#<%=RDFDTFTxt.ClientID%>").val(), date, empty);
            }
        });

        /*filter by due date range*/
        $("#<%=DUEFDTFTxt.ClientID%>").keyup(function () {
            filterByDueDateRange($(this).val(), $("#<%=DUETDTFTxt.ClientID%>").val(), empty);
        });

        $("#<%=DUETDTFTxt.ClientID%>").keyup(function () {
            filterByDueDateRange($("#<%=DUEFDTFTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=DUEFDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDueDateRange(date, $("#<%=DUETDTFTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=DUETDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDueDateRange($("#<%=DUEFDTFTxt.ClientID%>").val(), date, empty);
            }
        });

        /*filter by closure date range*/
        $("#<%=CLSRFDTFTxt.ClientID%>").keyup(function () {
            filterByClosureDateRange($(this).val(), $("#<%=CLSRTDTFTxt.ClientID%>").val(), empty);
        });

        $("#<%=CLSRTDTFTxt.ClientID%>").keyup(function () {
            filterByClosureDateRange($("#<%=CLSRFDTFTxt.ClientID%>").val(), $(this).val(), empty);
        });

        $("#<%=CLSRFDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByClosureDateRange(date, $("#<%=CLSRTDTFTxt.ClientID%>").val(), empty);
            }
        });

        $("#<%=CLSRTDTFTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByClosureDateRange($("#<%=CLSRFDTFTxt.ClientID%>").val(), date, empty);
            }
        });

        $("#<%=RSKTYPFCBox.ClientID%>").change(function () {
            filterRisksByType($(this).val(), empty);
        });

        $("#<%=RSKSTSFCBox.ClientID%>").change(function () {
            filterRisksByStatus($(this).val(), empty);
        });

        $("#<%=RSKMODFCBox.ClientID%>").change(function () {
            filterRisksByMode($(this).val(), empty);
        });

        $("#<%=RSKCATFCBox.ClientID%>").change(function () {
            filterRisksByCategory($(this).val(), empty);
        });

        $("#<%=RECMODCBox.ClientID%>").change(function () {
            filterRisksByRecordMode($(this).val(), empty);
        });

       

        $("#MTGTYPclose").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#MTGTYPCancel").trigger('click');
            }
        });

        $("#<%=TRGTDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) { }
        });

        $("#MTGTYPSave").bind('click',function ()
        {
            var isPageValid = Page_ClientValidate('MitigationType');
            if (isPageValid)
            {

                if (!$("#validation_dialog_mitigation").is(":hidden"))
                {
                    $("#validation_dialog_mitigation").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#MitigationTypeSaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        var mitigationtype =
                        {
                            Type: $("#<%=MTGTYPNMTxt.ClientID%>").val(),
                            Description: $("#<%=MTGTYPDESTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=MTGTYPDESTxt.ClientID%>").val())
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(mitigationtype) + "\'}",
                            url: getServiceURL().concat('createNewMitigationType'),
                            success: function (data)
                            {
                                $("#MitigationTypeSaveTooltip").fadeOut(500, function ()
                                {
                                    ActivateSave(true);

                                    $("#MTGTYPCancel").trigger('click');

                                    loadMitigationType();

                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#MitigationTypeSaveTooltip").fadeOut(500, function ()
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
                $("#validation_dialog_mitigation").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

        $("#<%=ACTEESelect.ClientID%>").bind('click', function (e) {
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=ORGUNTCBox.ClientID%>").bind('click', function ()
        {
            if ($(this).val() != 0)
            {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=ACTEECBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, $("#ACTEE_LD"));

                $("#SelectActionee").hide('800');
            }
        });


        $("#save").bind('click', function () {

            var isPageValid = Page_ClientValidate('Action');
            if (isPageValid)
            {
                if (!$("#validation_dialog_action").is(":hidden"))
                {
                    $("#validation_dialog_action").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $find('<%= SaveExtender.ClientID %>').show();

                    var CLSDTParts = getDatePart($("#<%=TRGTDTTxt.ClientID%>").val());

                    var action =
                    {
                        MitigationType: $("#<%=MTGTYPCBox.ClientID%>").val() == 0 || $("#<%=MTGTYPCBox.ClientID%>").val() == null ? '' : $("#<%=MTGTYPCBox.ClientID%>").val(),
                        Countermeasures: $("#<%=CMSURTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=CMSURTxt.ClientID%>").val()),
                        PotentialImpact: $("#<%=PIMPTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=PIMPTxt.ClientID%>").val()),
                        Actions: $("#<%=ACTTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=ACTTxt.ClientID%>").val()),
                        Actionee: $("#<%=ACTEECBox.ClientID%>").val(),
                        TargetCloseDate: new Date(CLSDTParts[2], (CLSDTParts[1] - 1), CLSDTParts[0])
                    }

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'json':'" + JSON.stringify(action) + "','riskno':'" + $.trim($("#<%=RSKIDTxt.ClientID%>").val()) + "'}",
                        url: getServiceURL().concat("createNewMitigationAction"),
                        success: function (data)
                        {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            alert(data.d);

                            resetGroup('.groupbox');

                            ActivateAll(false);

                            addWaterMarkText('The description of the potential impact', '#<%=PIMPTxt.ClientID%>');
                            addWaterMarkText('The description of the countermeasures', '#<%=CMSURTxt.ClientID%>');
                            addWaterMarkText('The description of the action', '#<%=ACTTxt.ClientID%>');

                        },
                        error: function (xhr, status, error)
                        {
                            $find('<%= SaveExtender.ClientID %>').hide();

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        }
                    });
                }
            }
            else
            {
                $("#validation_dialog_action").stop(true).hide().fadeIn(500, function ()
                {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });

    });

    function compareRegisterDate(sender, args)
    {
        var targetdatepart = getDatePart(args.Value);
        var planneddatepart = getDatePart(new Date($("#registerdate").val()).format('dd/MM/yyyy'));


        var targetdate = new Date(targetdatepart[2], (targetdatepart[1] - 1), targetdatepart[0]);
        var planneddate = new Date(planneddatepart[2], (planneddatepart[1] - 1), planneddatepart[0]);

        if (targetdate < planneddate) {
            args.IsValid = false;
        }
        else {
            args.IsValid = true;
        }

        return args.IsValid;
    }

    function showORGDialog(x, y)
    {
        $("#SelectActionee").css({ left: x - 300, top: y - 90 });

        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGUNT_LD");

        $("#SelectActionee").show();
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

    function loadRiskCategory(control, loader) {

        $(loader).stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCategory"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $(control));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterRisksByType(type, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterRiskByType'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
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


    function filterRisksByStatus(status, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat('filterRiskByStatus'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
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


    function filterRisksByCategory(category, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat('filterRiskByCategory'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
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

    function filterRisksByMode(mode, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterRiskByMode'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
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


    function filterRisksByRecordMode(mode, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterRiskByRecordMode'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");


                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#FLTR_LD").fadeOut(500, function () {
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

    function refreshRisks(empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadRiskList'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
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

    function filterByRegisterDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#FLTR_LD").stop(true).hide().fadeIn(800, function () {
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
                    url: getServiceURL().concat('filterRiskByRegisterDate'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FLTR_LD").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByClosureDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#FLTR_LD").stop(true).hide().fadeIn(800, function () {
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
                    url: getServiceURL().concat('filterRiskByClosureDate'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                             loadGridView(data.d, empty);
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FLTR_LD").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByDueDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#FLTR_LD").stop(true).hide().fadeIn(800, function () {
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
                    url: getServiceURL().concat('filterRiskByDueDate'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            loadGridView(data.d, empty);
                        });

                    },
                    error: function (xhr, status, error) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FLTR_LD").stop(true).hide().fadeIn(800, function () {
                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }
    function loadGridView(data, empty)
    {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvRisks.ClientID%> tr").not($("#<%=gvRisks.ClientID%> tr:first-child")).remove();

        $(xml).find("Risk").each(function (index, value) {

            $("td", row).eq(0).html($(this).attr("RiskNo"));
            $("td", row).eq(1).html($(this).attr("RiskName"));
            $("td", row).eq(2).html($(this).attr("RiskType"));
            $("td", row).eq(3).html($(this).attr("RiskMode"));

            var registerdate = new Date($(this).attr("RegisterDate"));
            registerdate.setMinutes(registerdate.getMinutes() + registerdate.getTimezoneOffset());

            $("td", row).eq(4).html(registerdate.format("dd/MM/yyyy"));
            $("td", row).eq(5).html($(this).attr("RiskStatusString"));

            $("#<%=gvRisks.ClientID%>").append(row);

            row = $("#<%=gvRisks.ClientID%> tr:last-child").clone(true);
        });

        $("#<%=gvRisks.ClientID%> tr").not($("#<%=gvRisks.ClientID%> tr:first-child")).bind('click', function () {

            $("#SearchRisk").hide('800');
            $("#<%=RSKIDTxt.ClientID%>").val($("td", $(this)).eq(0).html());

            var e = jQuery.Event("keydown");
            e.which = 13; // # Some key code value
            $("#<%=RSKIDTxt.ClientID%>").trigger(e);

        });

    }

    function loadMitigationType()
    {
        $("#MTGTYP_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadMitigationTypes"),
                success: function (data) {
                    $("#MTGTYP_LD").fadeOut(500, function ()
                    {
                        if (data)
                        {
                            loadComboboxXML($.parseXML(data.d), 'MitigationType', 'Type', $("#<%=MTGTYPCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#MTGTYP_LD").fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function clearModal()
    {
        $(".modalPanel").children().each(function () {
            $(this).find('.textbox').each(function () {
                $(this).val('');
            });

            $(this).find('.combobox').each(function () {
                $(this).val(0);
            });

            /*trigger textbox keyup event to reset the character counter*/
            $(".textbox").each(function () {
                $(this).keyup();

            });

            $(".validationcontainer").each(function () {
                $(this).hide();
            });
        });
    }


    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }

    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
            $(".groupbox").children().each(function ()
            {
                $(this).find('.textbox').each(function () {
                    $(this).removeClass("textbox");
                    $(this).addClass("readonlycontrolled");
                    $(this).attr('readonly', true);
                });

                 $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.addnew').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.combobox').each(function () {
                    $(this).attr('disabled', true);
                });
            });


            $('#save').attr("disabled", true);
        }
        else
        {
            $(".groupbox").each(function ()
            {
                $(this).find('.readonlycontrolled').each(function ()
                {
                    $(this).removeClass("readonlycontrolled");
                    $(this).addClass("textbox");
                    $(this).attr('readonly', false);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('.addnew').each(function () 
                {
                    $(this).attr('disabled', false);
                });

                $(this).find('.combobox').each(function () {
                    $(this).attr('disabled', false);
                });
            });

     
            $('#save').attr("disabled", false);
        }
    }
</script>
</asp:Content>
