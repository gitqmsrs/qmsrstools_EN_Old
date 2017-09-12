﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture="en-GB" AutoEventWireup="true" CodeBehind="ManageProblems.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ManageProblems" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="wrapper" class="modulewrapper">
        <div id="Problem_Header" class="moduleheader">Manage Problems</div>

        <div class="toolbox">
            <img id="refresh" src="/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />

            <div id="filter_div">
                <img id="filter" src="/Images/filter.png" alt="" />
                <ul id="filterList" class="contextmenu">
                    <li id="byPRM">Filter by Problem Title</li>
                    <li id="byPRMTYP">Filter by Problem Type</li>
                    <li id="byORGIDT">Filter by Origination Date</li>
                    <li id="byPRMRTCAUS">Filter by Root Cause</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>
        </div>

        <div id="StartdateContainer" class="filter">
            <div id="StartDateLabel" class="filterlabel">Origination Date:</div>
            <div id="StartDateField" class="filterfield">
                <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" Style="width: 5px;"></asp:Label>
                <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            </div>
            <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
            <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
            </ajax:MaskedEditExtender>
        </div>

        <div id="ProblemContainer" class="filter">
            <div id="ProblemNameLabel" class="filterlabel">Problem:</div>
            <div id="ProblemNameField" class="filterfield">
                <asp:TextBox ID="PRMNMFTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
            </div>
        </div>

        <div id="RootCauseContainer" class="filter">
            <div id="RootCauseLabel" class="filterlabel">Root Cause:</div>
            <div id="RootCauseField" class="filterfield">
                <asp:DropDownList ID="RTCUSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RTCUS_LD" class="control-loader"></div>
        </div>

        <div id="ProblemTypeContainer" class="filter">
            <div id="ProblemTypeFLabel" class="filterlabel">Problem Type:</div>
            <div id="ProblemtypeFField" class="filterfield">
                <asp:DropDownList ID="PRMTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="PRMTYPF_LD" class="control-loader"></div>
        </div>

        <div id="RecordModeContainer" class="filter">
            <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
            <div id="RecordModeField" class="filterfield">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                </asp:DropDownList>
            </div>
            <div id="RECMODF_LD" class="control-loader"></div>
        </div>

        <div id="FilterTooltip" class="tooltip" style="margin-top: 10px;">
            <img src="/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p></p>
        </div>

        <div id="PRMwait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>

        <div id="scrollbar" class="gridscroll">

            <div id="RAGTooltip" class="tooltip" style="margin-top: 20px; background-color: transparent;">
                <div style="float: left; margin-top: 2px; margin-left: 2px; width: 30%">
                    <img id="RED" src="/Images/Red.gif" alt="" style="width: 20px; float: left" /><p style="font-size: 11px;">Red: Problem has passed target close date.</p>
                </div>

                <div style="float: left; margin-top: 2px; margin-left: 2px; width: 30%">
                    <img id="GREEN" src="/Images/Green.gif" alt="" style="width: 20px; float: left" /><p style="font-size: 11px;">Green: Problem is on schedule.</p>
                </div>
                <div style="float: left; margin-top: 2px; margin-left: 2px; width: 30%">
                    <img id="AMBER" src="/Images/Amber.gif" alt="" style="width: 20px; float: left" /><p style="font-size: 11px;">Amber: Problem will be overdue soon.</p>
                </div>
            </div>


            <asp:GridView ID="gvProblems" runat="server" AutoGenerateColumns="false" CssClass="grid" PagerStyle-CssClass="pgr"
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
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="CaseNo" HeaderText="Case No." />
                    <asp:BoundField DataField="PRMTitle" HeaderText="Problem" />
                    <asp:BoundField DataField="PRMType" HeaderText="Problem Type" />
                    <asp:BoundField DataField="AFFCTPRTYType" HeaderText="Affected Party Type" />
                    <asp:BoundField DataField="Originator" HeaderText="Originator" />
                    <asp:BoundField DataField="OriginationDate" HeaderText="Origination Date" />
                    <asp:BoundField DataField="TargetCloseDate" HeaderText="Target Close Date" />
                    <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="RECMode" HeaderText="Record Mode" />
                </Columns>
            </asp:GridView>
        </div>

        <asp:Button ID="alias" runat="server" Style="display: none" />

        <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
        </ajax:ModalPopupExtender>

        <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
            <div id="header" class="modalHeader">Problem Details<span id="close" class="modalclose" title="Close">X</span></div>

            <div id="ProblemTooltip" class="tooltip">
                <img src="/Images/Warning.png" alt="Help" height="25" width="25" />
                <p></p>
            </div>

            <div id="SaveTooltip" class="tooltip">
                <img src="/Images/wait-loader.gif" alt="Save" height="25" width="25" />
                <p>Saving...</p>
            </div>

            <ul id="tabul" style="margin-top: 30px;">
                <li id="Details" class="ntabs">Main Information</li>
                <li id="Causes" class="ntabs">Related Causes</li>
                <li id="Additional" class="ntabs">Additional information</li>
                <li id="Supplementary" class="ntabs">Supplementary information</li>
                <li id="Approval" class="ntabs">Approval Details</li>
            </ul>
            <div id="DetailsTB" class="tabcontent" style="display: none; height: 450px;">

                <div id="validation_dialog_general">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 10px;">
                    <div id="CaseNoLabel" class="requiredlabel">Case No:</div>
                    <div id="CaseNoField" class="fielddiv" style="width: 300px;">
                        <asp:TextBox ID="CaseNoTxt" runat="server" CssClass="readonly" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ProblemTypeLabel" class="requiredlabel">Problem Type:</div>
                    <div id="ProblemTypeField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="PRBLCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>

                    <div id="PTYP_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="PRBLTxtVal" runat="server" Display="None" ControlToValidate="PRBLCBox" ErrorMessage="Select the type of the problem" ValidationGroup="General"></asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="PRBLVal" runat="server" ControlToValidate="PRBLCBox"
                        Display="None" ErrorMessage="Select the type of the problem" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ProblemTitleLabel" class="requiredlabel">Problem:</div>
                    <div id="ProblemTitleField" class="fielddiv" style="width: 300px;">
                        <asp:TextBox ID="PRMNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
                    </div>
                    <div id="PRMNMlimit" class="textremaining"></div>

                    <asp:RequiredFieldValidator ID="PRMNMVal" runat="server" Display="None" ControlToValidate="PRMNMTxt" ErrorMessage="Enter the title of the problem" ValidationGroup="General"></asp:RequiredFieldValidator>

                    <asp:CustomValidator ID="PRMNMTxtFVal" runat="server" ValidationGroup="General"
                        ControlToValidate="PRMNMTxt" Display="None" ErrorMessage="Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                        ClientValidationFunction="validateSpecialCharacters">
                    </asp:CustomValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="AffectedPartyTypeLabel" class="requiredlabel">Affected Party Type:</div>
                    <div id="AffectedPartyTypeField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="AFFPRTTYPCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="AFFPRTTYP_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="AFFPRTTYPTxtVal" runat="server" Display="None" ControlToValidate="AFFPRTTYPCBox" ErrorMessage="Select the type of the affected party" ValidationGroup="General"></asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="AFFPRTTYPVal" runat="server" ControlToValidate="AFFPRTTYPCBox"
                        Display="None" ErrorMessage="Select the type of the affected party" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
                </div>

                <div id="external" class="selectionfield" style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="AffectedPartyLabel" class="labeldiv">Affected Party:</div>
                    <div id="AffectedPartyField" class="fielddiv" style="width: 300px;">
                        <asp:TextBox ID="AFFPRTYTxt" runat="server" CssClass="readonly" Width="290px" ReadOnly="true"></asp:TextBox>
                    </div>
                    <span id="AFFPRTYSelect" class="searchactive" style="margin-left: 10px" runat="server"></span>
                </div>


                <div id="internal" class="selectionfield" style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="AffectedDepartmentLabel" class="labeldiv">Affected Department:</div>
                    <div id="AffectedDepartmentField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="AFFORGUNT" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="AFFORGUNT_LD" class="control-loader"></div>
                </div>

                <div id="SearchCustomer" class="selectbox" style="width: 600px; height: 250px; top: 130px; left: 80px;">
                    <div class="toolbox">
                        <img id="party_delete_filter" src="/Images/filter-delete-icon.png" class="imgButton" alt="" />
                        <div id="party_filter_div">
                            <img id="party_filter" src="/Images/filter.png" alt="" />
                            <ul class="contextmenu">
                                <li id="byPRTYTYP">Filter By Party Type</li>
                            </ul>
                        </div>
                        <div id="closeBox" class="selectboxclose"></div>
                    </div>

                    <div id="PartyTypeContainer" class="selectboxfilter">
                        <div id="PartyTypeLabel" class="filterlabel">Filter by Type:</div>
                        <div id="PartyTypeField" class="filterfield">
                            <asp:DropDownList ID="PRTTYPCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                            </asp:DropDownList>
                        </div>
                        <div id="PRTYP_LD" class="control-loader"></div>
                    </div>

                    <div id="FLTR_LD" class="control-loader"></div>
                    <div id="scroll2" style="height: 250px; width: 96%; overflow: auto; margin-top: 15px; float: left">
                        <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" PageSize="10" AllowPaging="true" AlternatingRowStyle-CssClass="alt">
                            <Columns>
                                <asp:BoundField DataField="CustomerNo" HeaderText="Customer No." />
                                <asp:BoundField DataField="CustomerType" HeaderText="Type" />
                                <asp:BoundField DataField="CustomerName" HeaderText="Name" />
                                <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="AffectedDocumentLabel" class="labeldiv">Affected Document:</div>
                    <div id="AffectedDocumentField" class="fielddiv" style="width: 250px">
                        <asp:DropDownList ID="AFFCTDOCCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="AFFCTDOC_LD" class="control-loader"></div>

                    <span id="DOCSRCH" class="searchactive" runat="server" style="margin-left: 10px" title="Search for affected document"></span>
                </div>

                <div id="SelectDOC" class="selectbox">
                    <div id="closedoc" class="selectboxclose"></div>
                    <div style="float: left; width: 100%; height: 20px; margin-top: 5px;">
                        <div id="DocumentTypeLabel" class="labeldiv" style="width: 100px;">Document Type:</div>
                        <div id="DocumentTypeField" class="fielddiv" style="width: 130px">
                            <asp:DropDownList ID="DOCTYP" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="DOCTYP_LD" class="control-loader"></div>
                    </div>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ProblemDescriptionLabel" class="labeldiv">Problem Description:</div>
                    <div id="ProblemDescriptionField" class="fielddiv" style="width: 400px;">
                        <asp:TextBox ID="PRMDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                    </div>

                    <asp:CustomValidator ID="PRMDESCTxtVal" runat="server" ValidationGroup="General"
                        ControlToValidate="PRMDESCTxt" Display="None" ErrorMessage="Characters !@$%^*+=[]{}|<> are not allowed"
                        ClientValidationFunction="validateSpecialCharactersLongText">
                    </asp:CustomValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 135px;">
                    <div id="ProblemStatusLabel" class="requiredlabel">Problem Status:</div>
                    <div id="ProblemStatusField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="PRMSTSCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="PSTS_LD" class="control-loader"></div>

                    <asp:RequiredFieldValidator ID="PRMSTStxtVal" runat="server" Display="None" ControlToValidate="PRMSTSCBox" ErrorMessage="Select the status of the problem" ValidationGroup="General"></asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="PRMSTSVal" runat="server" ControlToValidate="PRMSTSCBox"
                        Display="None" ErrorMessage="Select the status of the problem" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
                </div>
            </div>
            <div id="CausesTB" class="tabcontent" style="display: none; height: 450px;">
                <span id="lblCauseMessage" class="validator"></span>
                <div class="toolbox">
                    <img id="undo" src="/Images/undo.png" class="imgButton" title="Undo Causes" alt="" />
                    <img id="delete" src="/Images/deletenode.png" alt="" class="imgButton" title="Remove Selected Cause" />
                    <img id="new" src="/Images/new_file.png" alt="" class="imgButton" title="New Child Cause" />

                    <div id="RootCauseFilterContainer" style="float: left; width: 400px; margin-left: 10px; height: 20px; margin-top: 3px;">
                        <div id="RootFilterCauseLabel" style="width: 100px;">Root Cause:</div>
                        <div id="RootFilterCauseField" style="width: 250px; left: 0; float: left;">
                            <asp:DropDownList ID="RTCAUSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                            </asp:DropDownList>
                            <asp:HiddenField ID="hfRootCauseID" runat="server" />
                        </div>
                        <div id="RTCAUS_LD" class="control-loader"></div>
                    </div>
                </div>

                <div id="treemenu" class="menucontainer" style="border: 1px solid #052556; overflow: auto; height: 370px; width: 29%;">
                    <div id="cause_LD" class="control-loader"></div>
                    <div id="causetree"></div>
                </div>
                <div id="datafield" class="modulecontainer" style="border: 1px solid #052556; overflow: visible; height: 370px; width: 67%;">
                    <div style="float: left; width: 100%; height: 20px; margin-top: 10px;">
                        <div id="CUSTitleLabel" class="requiredlabel">Cause Name:</div>
                        <div id="CUSTitleField" class="fielddiv" style="width: 250px;">
                            <asp:TextBox ID="CUSTTLTxt" runat="server" CssClass="textbox treefield" Width="240px"></asp:TextBox>
                        </div>
                        <div id="CUSTTLlimit" class="textremaining"></div>
                    </div>
                    <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                        <div id="ParentCauseLabel" class="labeldiv">Related to Cause:</div>
                        <div id="ParentCauseField" class="fielddiv" style="width: 250px;">
                            <asp:TextBox ID="PCUSTxt" runat="server" ReadOnly="true" CssClass="readonly" Width="240px"></asp:TextBox>
                        </div>
                    </div>
                    <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                        <div id="CUSDetailsLabel" class="labeldiv">More Information</div>
                        <div id="CUSDetailsField" class="fielddiv" style="width: 400px; height: 190px;">
                            <asp:TextBox ID="CUSDTLTxt" runat="server" CssClass="textbox treefield" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
            <div id="AdditionalTB" class="tabcontent" style="display: none; height: 450px;">
                <div id="validation_dialog_additional">
                    <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Additional" />
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ProblemOriginatorLabel" class="requiredlabel">Problem Originator:</div>
                    <div id="ProblemOriginatorField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="ORGCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="ORIG_LD" class="control-loader"></div>

                    <span id="ORIGSelect" class="searchactive" style="margin-left: 10px" runat="server"></span>

                    <asp:RequiredFieldValidator ID="ORGCBoxTxtVal" runat="server" Display="None" ControlToValidate="ORGCBox" ErrorMessage="Select the originator of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="ORGCBoxVal" runat="server" ControlToValidate="ORGCBox" ValidationGroup="Additional"
                        Display="None" ErrorMessage="Select the originator of the problem" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="OwnerLabel" class="requiredlabel">Problem Owner:</div>
                    <div id="OwnerField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>

                    <div id="OWNR_LD" class="control-loader"></div>

                    <span id="OWNRSelect" class="searchactive" style="margin-left: 10px" runat="server"></span>

                    <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select the owner of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="OWNRCBoxVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="Additional"
                        Display="None" ErrorMessage="Select the owner of the problem" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ExecutiveLabel" class="requiredlabel">Problem Executive:</div>
                    <div id="ExecutiveField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="EXECBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>

                    <div id="EXE_LD" class="control-loader"></div>

                    <span id="EXESelect" class="searchactive" style="margin-left: 10px" runat="server"></span>

                    <asp:RequiredFieldValidator ID="EXECBoxTxtVal" runat="server" Display="None" ControlToValidate="EXECBox" ErrorMessage="Select the executive of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>

                    <asp:CompareValidator ID="EXECBoxVal" runat="server" ControlToValidate="EXECBox" ValidationGroup="Additional"
                        Display="None" ErrorMessage="Select the executive of the problem" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                </div>

                <div id="SelectORG" class="selectbox">
                    <div id="closeORG" class="selectboxclose"></div>
                    <div style="float: left; width: 100%; height: 20px; margin-top: 5px;">
                        <div id="ORGUnitLabel" class="labeldiv" style="width: 100px;">ORG. Unit:</div>
                        <div id="ORGUnitField" class="fielddiv" style="width: 130px;">
                            <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                            </asp:DropDownList>
                        </div>
                        <div id="ORG_LD" class="control-loader"></div>
                    </div>
                </div>


                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ProblemRaiseDateLabel" class="requiredlabel">Raise Date:</div>
                    <div id="ProblemRaiseDateField" class="fielddiv" style="width: 150px">
                        <asp:TextBox ID="RISDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="RISDTVal" runat="server" Display="None" ControlToValidate="RISDTTxt" ErrorMessage="Enter the raise date of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="RISDTTxtFVal" runat="server" ControlToValidate="RISDTTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>

                    <asp:CustomValidator ID="RISDTTxtF2Val" runat="server" ValidationGroup="Additional"
                        ControlToValidate="RISDTTxt" Display="None" ErrorMessage="Raise date should not be in future"
                        ClientValidationFunction="comparePast">
                    </asp:CustomValidator>

                    <asp:CustomValidator ID="RISDTTxtF3Val" runat="server" ValidationGroup="Additional"
                        ControlToValidate="RISDTTxt" Display="None" ErrorMessage="Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                    </asp:CustomValidator>

                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="OriginationDateLabel" class="labeldiv">Origination Date:</div>
                    <div id="OriginationDateField" class="fielddiv" style="width: 150px">
                        <asp:TextBox ID="ORGDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>

                    <asp:RegularExpressionValidator ID="ORGDTTxtFval" runat="server" ControlToValidate="ORGDTTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>

                    <asp:CompareValidator ID="ORGDTVal" runat="server" ControlToCompare="RISDTTxt" ValidationGroup="Additional"
                        ControlToValidate="ORGDTTxt" ErrorMessage="Orgination date should be greater or equals raise date"
                        Operator="GreaterThanEqual" Type="Date" Display="None"></asp:CompareValidator>

                    <asp:CustomValidator ID="ORGDTF2Val" runat="server" ValidationGroup="Additional"
                        ControlToValidate="ORGDTTxt" Display="None" ErrorMessage="Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                    </asp:CustomValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="TRGTCloseDateLabel" class="requiredlabel">Target Close Date:</div>
                    <div id="TRGTCloseDateField" class="fielddiv" style="width: 150px">
                        <asp:TextBox ID="TRGTCLSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>
                    <asp:RequiredFieldValidator ID="TRGTCLSDTVal" runat="server" Display="None" ControlToValidate="TRGTCLSDTTxt" ErrorMessage="Enter the target closing date of the problem" ValidationGroup="Additional"></asp:RequiredFieldValidator>

                    <asp:RegularExpressionValidator ID="TRGTCLSDTTxtFval" runat="server" ControlToValidate="TRGTCLSDTTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>

                    <asp:CompareValidator ID="TRGTCLSDTFVal" runat="server" ControlToCompare="ORGDTTxt" ValidationGroup="Additional"
                        ControlToValidate="TRGTCLSDTTxt" ErrorMessage="Target closing date should be greater or equals origination date"
                        Operator="GreaterThanEqual" Type="Date"
                        Display="None"></asp:CompareValidator>

                    <asp:CustomValidator ID="TRGTCLSDTF2Val" runat="server" ValidationGroup="Additional"
                        ControlToValidate="TRGTCLSDTTxt" Display="None" ErrorMessage="Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                    </asp:CustomValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ACTUCloseDateLabel" class="labeldiv">Actual Close Date:</div>
                    <div id="ACTUCloseDateField" class="fielddiv" style="width: 150px">
                        <asp:TextBox ID="ACTCLSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>

                    <asp:RegularExpressionValidator ID="ACTCLSDTVal" runat="server" ControlToValidate="ACTCLSDTTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>

                    <asp:CustomValidator ID="ACTCLSDTF0Val" runat="server" ValidationGroup="Additional"
                        ControlToValidate="ACTCLSDTTxt" Display="None" ErrorMessage="Actual close date shouldn't be in future"
                        ClientValidationFunction="comparePast">
                    </asp:CustomValidator>

                    <asp:CompareValidator ID="ACTCLSDTF1Val" runat="server" ControlToCompare="ORGDTTxt" ValidationGroup="Additional"
                        ControlToValidate="ACTCLSDTTxt" ErrorMessage="Actual close date should be greater than or equals origination date"
                        Operator="GreaterThanEqual" Type="Date"
                        Display="None"></asp:CompareValidator>

                    <asp:CustomValidator ID="ACTCLSDTF2Val" runat="server" ValidationGroup="Additional"
                        ControlToValidate="ACTCLSDTTxt" Display="None" ErrorMessage="Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                    </asp:CustomValidator>

                </div>
                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="ReviewReportIssueDateLabel" class="labeldiv">Review Report Issue Date:</div>
                    <div id="ReviewReportIssueDateField" class="fielddiv" style="width: 150px">
                        <asp:TextBox ID="REVREPISSDTTxt" runat="server" Width="140px" CssClass="textbox" placeholder="dd/mm/yyyy"></asp:TextBox>
                    </div>

                    <asp:RegularExpressionValidator ID="REVREPISSDTFval" runat="server" ControlToValidate="REVREPISSDTTxt"
                        Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Additional"></asp:RegularExpressionValidator>

                    <asp:CompareValidator ID="REVREPISSDTVal" runat="server" ControlToCompare="ORGDTTxt" ValidationGroup="Additional"
                        ControlToValidate="REVREPISSDTTxt" ErrorMessage="Review report date should be greater or equals origination date"
                        Operator="GreaterThanEqual" Type="Date"
                        Display="None"></asp:CompareValidator>

                    <asp:CustomValidator ID="REVREPISSDTF2Val" runat="server" ValidationGroup="Additional"
                        ControlToValidate="REVREPISSDTTxt" Display="None" ErrorMessage="Enter a realistic date value"
                        ClientValidationFunction="validateDate">
                    </asp:CustomValidator>
                </div>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="AdditionalRemarksLabel" class="labeldiv">Additional Remarks:</div>
                    <div id="AdditionalRemarksField" class="fielddiv" style="width: 400px;">
                        <asp:TextBox ID="RMRKTxt" runat="server" CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
                    </div>

                    <asp:CustomValidator ID="CustomValidator1" runat="server" ValidationGroup="General"
                        ControlToValidate="PRMDESCTxt" Display="None" ErrorMessage="Characters !@$%^*+=[]{}|<> are not allowed"
                        ClientValidationFunction="validateSpecialCharactersLongText">
                    </asp:CustomValidator>
                </div>
            </div>
            <div id="SupplementaryTB" class="tabcontent" style="display: none; height: 450px;">
                <div style="float: left; width: 100%; height: 20px; margin-top: 10px;">
                    <div id="ReportedFromLabel" class="labeldiv">Reported From:</div>
                    <div id="ReportedFromField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="REPFRMCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="REPORG_LD" class="control-loader"></div>
                </div>
                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="RelatedORGLabel" class="labeldiv">Source of Problem:</div>
                    <div id="RelatedORGField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="RELORGCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="SRCORG_LD" class="control-loader"></div>
                </div>
                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="SeverityLabel" class="labeldiv">Severity Criteria:</div>
                    <div id="SeverityField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="SVRTCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="SVR_LD" class="control-loader"></div>
                </div>
                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="RiskCategoryLabel" class="labeldiv">Select Risk Category:</div>
                    <div id="RiskCategoryField" class="fielddiv" style="width: 250px;">
                        <asp:DropDownList ID="RSKCATCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <div id="RSKCAT_LD" class="control-loader"></div>
                </div>
                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="RiskListLabel" class="labeldiv">Assciated Risk List:</div>
                    <div id="RiskListField" class="fielddiv" style="width: 250px">
                        <div id="RSKCHK" class="checklist"></div>
                    </div>
                </div>
            </div>
            <div id="ApprovalTB" class="tabcontent" style="display: none; height: 400px;">
                <span id="lblApprovalMessage" class="validator"></span>

                <div style="float: left; width: 100%; height: 20px; margin-top: 15px;">
                    <div id="RequiresApprovalLabel" class="labeldiv">Requires Approval:</div>
                    <div id="RequiresApprovalField" class="fielddiv" style="width: 250px">
                        <input type="checkbox" id="APPRCHK" class="checkbox" />
                    </div>

                </div>

                <div id="ApprovalGroupHeader" class="groupboxheader" style="margin-top: 15px;">Approval Details</div>
                <div id="ApprovalGroupField" class="groupbox" style="height: 100px; display: none;">
                    <img id="newmember" src="/Images/new_file.png" class="imgButton" title="Add new Approval Member" alt="" />

                    <div id="table" class="table" style="display: none;">
                        <div id="row_header" class="tr">
                            <div id="col0_head" class="tdh" style="width: 50px"></div>
                            <div id="col1_head" class="tdh" style="width: 20%">Member</div>
                            <div id="col2_head" class="tdh" style="width: 20%">Type</div>
                            <div id="col3_head" class="tdh" style="width: 20%">Approval Status</div>
                            <div id="col4_head" class="tdh" style="width: 20%">Decision Details</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="buttondiv">
                <input id="save" type="button" class="button" style="margin-left: 300px;" value="Save" />
                <input id="cancel" type="button" class="button" value="Cancel" />
            </div>

        </asp:Panel>

        <input id="problemID" type="hidden" value="" />
        <input id="invoker" type="hidden" value="" />

    </div>
    <script type="text/javascript" language="javascript">
        $(function () {
            var empty = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);
        var customerempty = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);

        initMembersTable();

        /*load all problems in the system*/
        loadProblems(empty);

        $("#<%=RTCAUSCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var vals = $(this).val();
                $("#<%=hfRootCauseID.ClientID%>").val(vals);
                loadCauses(parseInt(vals));
            } else {
                ActivateTreeField(false);
                $("#causetree").empty();
            }
        });

        /* Undo any loaded cause tree by refrshing it with a new and default tree*/
        $("#undo").bind('click', function () {
            var result = confirm("Are you sure you would like to undo all modified causes?");
            if (result == true) {
                /*load original cause tree*/
                bindCauses($("#problemID").val());

                loadRootCauses("#RTCAUS_LD", "#<%=RTCAUSCBox.ClientID%>");
            }
        });


        $("#<%=RISDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=ORGDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=TRGTCLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#<%=ACTCLSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function ()
            { }
        });

        $("#<%=REVREPISSDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#byPRTYTYP").bind('click', function () {
            loadXMLPartyType("#PRTYP_LD", "#<%=PRTTYPCBox.ClientID%>");

            $("#PartyTypeContainer").show();

        });

        $("#byRECMOD").bind('click', function () {
            hideAll();
            $("#RecordModeContainer").show();

            /*load record mode*/
            loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMODF_LD");
        });

        $("#<%=RECMODCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByProblemMode($(this).val(), empty);
            }
        });

        $("#party_delete_filter").click(function () {
            hideAllSelectBoxFilter();

            loadCustomers(customerempty);
        });

        $("#<%=PRTTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterCustomerByType($(this).val(), customerempty);
            }
        });

        $("#<%=AFFPRTYSelect.ClientID%>").bind('click', function () {
            hideAllSelectBoxFilter();

            loadCustomers(customerempty);

            $("#SearchCustomer").show();
        });

        $("#closeBox").bind('click', function () {
            $("#SearchCustomer").hide('800');
        });

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
                $("#table").table("removeAll");
            }

        });

        $("#refresh").bind('click', function () {
            hideAll();
            loadProblems(empty);
        });

        $("#byPRM").bind('click', function () {
            hideAll();
            /*Clear text value*/
            $("#<%=PRMNMFTxt.ClientID%>").val('');

            $("#ProblemContainer").show();

        });

        $("#byPRMTYP").bind('click', function () {
            hideAll();

            $("#ProblemTypeContainer").show();

            loadProblemType();
        });

        $("#byPRMRTCAUS").bind('click', function () {
            hideAll();

            $("#RootCauseContainer").show();

            loadRootCauses("#RTCUS_LD", "#<%=RTCUSCBox.ClientID%>");
        });

        $("#byORGIDT").bind('click', function () {
            hideAll();

            /*Clear filter texts*/
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            $("#StartdateContainer").show();
        });
        /*filter by problem title*/
        $("#<%=PRMNMFTxt.ClientID%>").keyup(function () {
            filterByProblemTitle($(this).val(), empty);
        });

        /*filter by problem type*/
        $("#<%=PRMTYPFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                filterByProblemType($(this).val(), empty);
            }
        });

        $("#<%=RTCUSCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var vals = $(this).val();

                filterByProblemCause(vals, empty);
            }
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
            onSelect: function (date) {
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


        $("#tabul li").bind("click", function () {
            var isCausesValid = Page_ClientValidate('Causes')
            if (isCausesValid) {
                navigate($(this).attr("id"));
            }
            else {
                alert('Please make sure that the details of the cause name is in the correct format');
                return false;
            }
        });

        /*Load Risk Sub-categories*/
        $("#<%=RSKCATCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                loadSubcategories($(this).val());
            }
        });

        /*bind the details of the selected node*/
        $('#causetree').bind('tree.select', function (event) {
            var node = event.node;

            if (node != null && node != false) {
                if (!node.hasOwnProperty("CauseID")) {
                    $("#new").hide();
                } else {
                    $("#new").show();
                }

                var isCausesValid = Page_ClientValidate('Causes')
                if (isCausesValid) {
                    ActivateTreeField(true);

                    $("#<%=CUSTTLTxt.ClientID%>").val(node.name);
                    $("#<%=PCUSTxt.ClientID%>").val(node.parent.name);
                    //$("#<%=CUSDTLTxt.ClientID%>").html(node.Description).text();
                    $("#<%=CUSDTLTxt.ClientID%>").val($("#<%=CUSDTLTxt.ClientID%>").html(node.Description).text());

                    /*attach ID to limit plugin*/
                    $("#<%=CUSTTLTxt.ClientID%>").limit({ id_result: 'CUSTTLlimit', alertClass: 'alertremaining', limit: 100 });

                }
                else {
                    alert('Please make sure that the details of the cause name is in the correct format');
                    return false;
                }
            }
        });
        $("#<%=CUSTTLTxt.ClientID%>").keyup(function (event) {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                if ($(this).val() != '') {
                    if (node.Status == 3) {
                        $('#causetree').tree('updateNode', node, { name: $(this).val() });
                    }
                    else {
                        $('#causetree').tree('updateNode', node, { name: $(this).val(), Status: 2 });
                    }
                }
            }
            else {
                event.preventDefault();
            }
        });
        $("#<%=CUSDTLTxt.ClientID%>").keyup(function (event) {
            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                if (node.Status == 3) {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()) });
                }
                else {
                    $('#causetree').tree('updateNode', node, { Description: escapeHtml($(this).val()), Status: 2 });
                }
            }
            else {
                event.preventDefault();
            }
        });

        /* delete a cause node*/
        $("#delete").bind('click', function () {
            var node = $('#causetree').tree('getSelectedNode');

            if (node != null && node != false) {
                if (node.children.length > 0) {
                    alert("Cannot remove the process(" + node.name + ") because there is/are (" + node.children.length + ") assciated cause(s) which must be removed first");
                }
                else if (node.getLevel() == 1) {
                    alert("At least a main cause should be included with a problem");
                }
                else {
                    if (node.Status == 3) {
                        $('#causetree').tree('removeNode', node);
                    }
                    else {
                        removeCause(node.CauseID, $("#problemID").val());
                    }

                    $("#CUSTTLlimit").html('');

                    ActivateTreeField(false);
                }
            }
            else {
                alert('Please select a cause');
            }
        });

        /*add new cause node*/
        $("#new").bind('click', function () {

            var node = $('#causetree').tree('getSelectedNode');
            if (node != null && node != false) {
                $("#causetree").tree('appendNode',
                {
                    ParentID: node.CauseID,
                    name: 'new sub cause',
                    Description: '',
                    Status: 3
                }, node);
            }
            else {
                var json = $.parseJSON($('#causetree').tree('toJson'));
                if (json.length == 0) {
                    var cause =
                    [{
                        ParentID: node.CauseID,
                        name: 'new root cause',
                        Description: '',
                        Status: 3
                    }];

                    var existingjson = $('#causetree').tree('toJson');
                    if (existingjson == null) {
                        $('#causetree').tree(
                        {
                            ParentID: node.CauseID,
                            data: cause,
                            slide: true,
                            autoOpen: true
                        });
                    }
                    else {
                        $('#causetree').tree('loadData', cause);
                    }
                }
                else {
                    alert('Please select a cause and a subcause.');
                }
            }
        });

        /*show organization unit box when hovering over originator, owner, and exective cboxes*/
        /*set the position according to mouse x and y coordination*/

        $("#<%=ORIGSelect.ClientID%>").bind('click', function (e) {
            $("#invoker").val('Originator');
            showORGDialog(e.pageX, e.pageY);

        });

        $("#<%=OWNRSelect.ClientID%>").bind('click', function (e) {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=EXESelect.ClientID%>").bind('click', function (e) {
            $("#invoker").val('Executive');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=DOCSRCH.ClientID%>").click(function (e) {
            showDOCDialog(e.pageX, e.pageY);
        });


        /*populate the employees in owner, originator, and executive cboxes*/
        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            unitparam = "'unit':'" + $(this).val() + "'";
            var loadcontrols = new Array();

            switch ($("#invoker").val()) {
                case "Originator":
                    loadcontrols.push("#<%=ORGCBox.ClientID%>");
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORIG_LD");
                    break;
                case "Owner":
                    loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#OWNR_LD");
                    break;
                case "Executive":
                    loadcontrols.push("#<%=EXECBox.ClientID%>");
                    loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EXE_LD");
                    break;
            }
            $("#SelectORG").hide('800');
        });

        /*close document type box*/
        $("#closedoc").bind('click', function () {
            $("#SelectDOC").hide('800');
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /*save changes*/
        $("#save").bind('click', function () {
            var hasError = false;
            if ($(".tdl").children().length > 0) {
                $(".td1").children().css("display", "none");
            }
            
            if ($("#APPRCHK").is(":checked")) {
                var obj = $("#table").table("getJSON");
                var members = [];
                var membertypes = [];
                var hasDuplicates = false;

                for (x = 0; x < obj.length; x++) {
                    if (obj[x].Status != 4) {
                        members.push(obj[x].Member);
                        membertypes.push(obj[x].MemberType)
                    }
                }
                members = members.sort();

                for (y = 0; y < members.length; y++) {
                    if (members[y + 1] == members[y] && (members[y + 1] != "" || members[y] != "")) {
                        hasDuplicates = true;
                    }
                }

                if (members.length == 0) {
                    $("#lblApprovalMessage").html("<ul><li>Please choose one or more approval members.</li></ul>");
                    $("#lblApprovalMessage").show();
                    navigate('Approval');
                    hasError = true;
                }
                if (hasDuplicates) {
                    $("#lblApprovalMessage").html("<ul><li>Duplicate name exists.</li></ul>");
                    $("#lblApprovalMessage").show();
                    navigate('Approval');
                    hasError = true;
                }
                if (members.length > 0 && ($.inArray("", membertypes) > -1 || $.inArray("", members) > -1)) {
                    $("#lblApprovalMessage").html("<ul><li>Please fill out the blank cells.</li></ul>");
                    $("#lblApprovalMessage").show();
                    navigate('Approval');
                    hasError = true;
                }
                if ($("#<%=RTCAUSCBox.ClientID%>").val() == 0) {
                    $("#lblCauseMessage").html("<ul><li>Please select a cause.</li></ul>");
                    $("#lblCauseMessage").show();
                    navigate('Causes');
                    $("#CausesTB").animate({ scrollTop: 0 }, "slow");
                    hasError = true;
                }
                if ($("#<%=CUSTTLTxt.ClientID%>").val() == "") {
                    $("#lblCauseMessage").html("<ul><li>Please select a subcause.</li></ul>");
                    $("#lblCauseMessage").show();
                    navigate('Causes');
                    $("#CausesTB").animate({ scrollTop: 0 }, "slow");
                    hasError = true;
                }
            }

            if (!hasError) {
                funcGeneralValid()
            }

            function funcGeneralValid() {
                var isGeneralValid = Page_ClientValidate('General');
                if (isGeneralValid) {
                    if (!$("#validation_dialog_general").is(":hidden")) {
                        $("#validation_dialog_general").hide();
                    }

                    var isAdditionalValid = Page_ClientValidate('Additional');
                    if (isAdditionalValid) {
                        if (!$("#validation_dialog_additional").is(":hidden")) {
                            $("#validation_dialog_additional").hide();
                        }

                        var json = $.parseJSON($('#causetree').tree('toJson'));

                        if (json.length > 0) {
                            var result = confirm("Are you sure you would like to submit changes?");
                            if (result == true) {
                                if (!$("#APPRCHK").is(":checked")) {
                                   // $("#table").table("removeAll");
                                    // $("#table").table('addRow', { Status: 4 });
                                    var members = $("#table").table("getJSON");

                                    for (x = 0; x < members.length; x++) {
                                        members[x].Status = 4;
                                    }
                                } 

                                $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                                {
                                    ActivateSave(false);
                                    
                                    var subCauseName = $("#<%=CUSTTLTxt.ClientID%>").val();

                                    var selectedCause;                        

                                    var node = $('#causetree').tree('getSelectedNode');
                                    $('#causetree').tree('updateNode', node, { isSelected: true });

                                    var parentID;
                                   
                                    var hiddenRootCauseID = $("#<%=hfRootCauseID.ClientID%>").val();
                                    
                                    if (hiddenRootCauseID != null && hiddenRootCauseID != "") {
                                         parentID = hiddenRootCauseID;
                                    }
                                    else if (hiddenRootCauseID == null || hiddenRootCauseID == "")
                                    {
                                        var rootCauseID = $("#<%=RTCAUSCBox.ClientID%>").val();
                            
                                        hiddenRootCauseID = rootCauseID;
                                        if (hiddenRootCauseID != null) {
                                            parentID = hiddenRootCauseID;                                
                                        }
                                        else {
                                            parentID = 0;
                                        }
                                    }

                                    else {
                                        parentID = node.CauseID;                                   
                                    }

                            
                                    if (node != null && node != false && node.Status != 3) {                            
                                        selectedCause = '[{"CauseID":"' + node.CauseID + '", "ParentID": "' + parentID + '", "SelectedCauseID": "' + node.CauseID + '", "Description":"' + node.Description + '","name":"' + node.name + '","Status":"' + node.Status + '", "is_open":true,"children":null, "isSelecred":true}]';
                                    } else {

                                        selectedCause = '[{"ParentID": "' + node.parent.CauseID + '", "Description":"' + node.Description + '","name":"' + node.name + '","Status":"' + node.Status + '", "is_open":true,"children":null,"isSelecred":true}]';
                                    }

                            
                                var raisedate = getDatePart($("#<%=RISDTTxt.ClientID%>").val());
                                var origination = getDatePart($("#<%=ORGDTTxt.ClientID%>").val());
                                var target = getDatePart($("#<%=TRGTCLSDTTxt.ClientID%>").val());
                                var actual = getDatePart($("#<%=ACTCLSDTTxt.ClientID%>").val());
                                var review = getDatePart($("#<%=REVREPISSDTTxt.ClientID%>").val());
                               
                                var problem =
                                {
                                    ProblemType: $("#<%=PRBLCBox.ClientID%>").val(),
                                    AffectedPartyType: $("#<%=AFFPRTTYPCBox.ClientID%>").val(),
                                    AffectedDepartment: $("#<%=AFFPRTTYPCBox.ClientID%>").val() == "Internal" ? ($("#<%=AFFORGUNT.ClientID%>").val() == 0 || $("#<%=AFFORGUNT.ClientID%>").val() == null ? '' : $("#<%=AFFORGUNT.ClientID%>").val()) : "",
                                    ExternalParty: $("#<%=AFFPRTTYPCBox.ClientID%>").val() == "External" ? ($("#<%=AFFPRTYTxt.ClientID%>").val() == 0 || $("#<%=AFFPRTYTxt.ClientID%>").val() == null ? '' : $("#<%=AFFPRTYTxt.ClientID%>").val()) : "",
                                    AffectedDocument: ($("#<%=AFFCTDOCCBox.ClientID%>").val() == null || $("#<%=AFFCTDOCCBox.ClientID%>").val() == 0) ? '' : $("#<%=AFFCTDOCCBox.ClientID%>").val(),
                                    CaseNO: $("#<%=CaseNoTxt.ClientID%>").val(),
                                    Title: $("#<%=PRMNMTxt.ClientID%>").val(),
                                    CustomerNo: $("#<%=AFFPRTYTxt.ClientID%>").val(),
                                    Details: $("#<%=PRMDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=PRMDESCTxt.ClientID%>").val()),
                                    Originator: $("#<%=ORGCBox.ClientID%>").val(),
                                    Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                                    Executive: $("#<%=EXECBox.ClientID%>").val(),
                                    ReportDepartment: ($("#<%=REPFRMCBox.ClientID%>").val() == null || $("#<%=REPFRMCBox.ClientID%>").val() == 0) ? '' : $("#<%=REPFRMCBox.ClientID%>").val(),
                                    ProblemRelatedDepartment: ($("#<%=RELORGCBox.ClientID%>").val() == null || $("#<%=RELORGCBox.ClientID%>").val() == 0) ? '' : $("#<%=RELORGCBox.ClientID%>").val(),
                                    Severity: ($("#<%=SVRTCBox.ClientID%>").val() == null || $("#<%=SVRTCBox.ClientID%>").val() == 0) ? '' : $("#<%=SVRTCBox.ClientID%>").val(),
                                    ProblemStatusString: $("#<%=PRMSTSCBox.ClientID%>").val(),
                                    CustomerName: $("#<%=AFFPRTYTxt.ClientID%>").val(),
                                    RaiseDate: new Date(raisedate[2], (raisedate[1] - 1), raisedate[0]),
                                    OriginationDate: origination == '' ? null : new Date(origination[2], (origination[1] - 1), origination[0]),
                                    TargetCloseDate: new Date(target[2], (target[1] - 1), target[0]),
                                    ActualCloseDate: actual == '' ? null : new Date(actual[2], (actual[1] - 1), actual[0]),
                                    ReviewReportIssueDate: review == '' ? null : new Date(review[2], (review[1] - 1), review[0]),
                                    RiskSubcategory: getChecklistJSON(),
                                    Remarks: $("#<%=RMRKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMRKTxt.ClientID%>").val()),
                                    Causes: JSON.parse($('#causetree').tree('toJson')),
                                    SelectedCause: JSON.parse(selectedCause),
                                    Members: $("#table").table('getJSON')
                                }
                                console.log(JSON.stringify($("#table").table('getJSON')));
                                console.log(JSON.stringify(problem));
                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{'json':'" + JSON.stringify(problem) + "'}",
                                    url: getServiceURL().concat('updateProblem'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            showSuccessNotification(data.d);

                                            /*close modal popup extender*/
                                            $("#cancel").trigger('click');

                                            $("#refresh").trigger('click');

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
                            });
                        }
                    }
                    else {
                        alert("At least one root cause should be added with the problem record");
                        navigate('Causes');
                    }
                }
                else {
                    $("#validation_dialog_additional").stop(true).hide().fadeIn(500, function () {

                        navigate('Additional');

                    });
                }
            }
            else {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {

                    navigate('Details');

                });
            }
        }

        });


        $("#<%=DOCTYP.ClientID%>").change(function () {
            if ($(this).val() != 0) {

                loadDocuments("#AFFCTDOC_LD", "#<%=AFFCTDOCCBox.ClientID%>", $(this).val());
            }
        });


        $("#newmember").bind('click', function () {
            /*add a new approval member for the problem*/
            $("#table").table('addRow',
            {
                Member: '',
                MemberType: '',
                ApprovalStatusString: 'PENDING',
                ApprovalRemarks: '',
                Status: 3
            });
        });

        $("#<%=AFFPRTTYPCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                switch ($(this).val()) {
                    case "External":
                        $("#external").stop(true).hide().fadeIn(500, function ()
                        { });

                        $("#internal").fadeOut(500, function () { });

                        break;
                    case "Internal":
                        $("#internal").stop(true).hide().fadeIn(500, function () {
                            /*load the organization unit if the affected party is of type internal*/
                            loadComboboxAjax('getOrganizationUnits', "#<%=AFFORGUNT.ClientID%>", "#AFFORGUNT_LD");
                        });

                        $("#external").fadeOut(500, function () {
                        });
                        break;
                    case "None":
                        $(".selectionfield").each(function () {
                            $(this).fadeOut(500, function () {
                            });
                        });
                        break;
                }
            }
        });

        function initMembersTable() {
            var jsonmember =
                        [
                        ];

            var attributes = new Array();
            attributes.push("Member");
            attributes.push("MemberType");
            attributes.push("ApprovalStatusString");
            attributes.push("ApprovalRemarks");

            var json = $.parseJSON(JSON.stringify(jsonmember));

            /*set cell settings*/
            var settings = new Array();
            settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
            settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
            settings.push(JSON.stringify({ readonly: true }));

            $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 20 });
        }

        /*enable or disable adding approval members*/
        $("#APPRCHK").change(function (e) {

            if ($(this).is(":checked") == true) {

                $("#ApprovalGroupField").stop(true).hide().fadeIn(500, function () {
                });
            }
            else {
                /* if the approval status checkbox has been disabled, 
                then, all approval members defined previously will be removed*/

                $("#ApprovalGroupField").fadeOut(500, function () {
                    //$("#table").table('removeAll');

                });
            }

        });

    });

    function loadDocuments(loader, control, type) {
        $(loader).stop(true).hide().fadeIn(800, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("loadCurrentDocuments"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $(control));

                            $("#SelectDOC").hide('800');
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);

                        $("#SelectDOC").hide('800');
                    });
                }
            });
        });
    }

    function bindDocuments(loader, control, bound, type) {
        $(loader).stop(true).hide().fadeIn(800, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat("loadCurrentDocuments"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {
                        if (data) {
                            bindComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', bound, $(control));

                            $("#SelectDOC").hide('800');
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);

                        $("#SelectDOC").hide('800');
                    });
                }
            });
        });
    }

    function getChecklistJSON() {
        var checklist = new Array();
        $("#RSKCHK").children(".checkitem").each(function () {
            $(this).find('input').each(function (index, value) {
                var entity =
                {
                    SubCategoryID: $(value).attr('id'),
                    Status: $(value).val()
                };

                checklist.push(entity);

            });
        });
        if (checklist.length == 0)
            return null;

        return checklist;
    }

    function filterByDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#PRMwait").stop(true).hide().fadeIn(500, function () {
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
                    url: getServiceURL().concat('filterProblemByOriginationDate'),
                    success: function (data) {
                        $("#PRMwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                                $(this).find('p').text("List of all current problems where the origination date between " + startdate.format('dd/MM/yyyy') + " and " + enddate.format('dd/MM/yyyy') + ".Note: Closed, withdrawn, or archived problems cannot be modified");
                            });

                            /* show module tooltip */

                            $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                                $(this).slideDown(800, 'easeOutBounce');
                            });

                            if (data) {
                                loadGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#PRMwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            $("#FilterTooltip").fadeOut(800, function () {

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            });
                        });
                    }
                });
            });
        }
    }

    function filterByProblemMode(mode, empty) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'mode':'" + mode + "'}",
                url: getServiceURL().concat('filterProblemByMode'),
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').text("List of all current problems filtered according to their mode. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }

                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByProblemType(type, empty) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterProblemBytype'),
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current problems filtered according to their type. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByProblemCause(cause, empty) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            var vals = $(this).val();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'causeID':'" + cause + "'}",
                url: getServiceURL().concat('filterProblemByRootCause'),
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current problems filtered according to their root cause. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {

                        $("#FilterTooltip").fadeOut(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function filterByProblemTitle(title, empty) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat('filterProblemByName'),
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {

                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {

                            $(this).find('p').text("List of all current problems filtered according to their title. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {

                        $("#FilterTooltip").fadeOut(800, function () {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            showErrorNotification(r.Message);
                        });
                    });
                }
            });
        });
    }

    function loadProblems(empty) {
        $("#PRMwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadProblems'),
                success: function (data) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).find('p').text("List of all current problems. Note: Closed, withdrawn, or archived problems cannot be modified");
                        });

                        /* show module tooltip */

                        $("#RAGTooltip").stop(true).hide().fadeIn(800, function () {
                            $(this).slideDown(800, 'easeOutBounce');
                        });

                        if (data) {
                            loadGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        $("#FilterTooltip").fadeOut(800, function () {
                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(xhr.responseText);
                        });
                    });
                }
            });
        });
    }

    function removeCause(causeID, problemID) {
        var result = confirm("Are you sure you would like to remove the selected cause?");
        if (result == true) {
            $(".modalPanel").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeID':'" + causeID + "'}",
                url: getServiceURL().concat('removeCause'),
                success: function (data) {
                    $(".modalPanel").css("cursor", "default");

                    bindCauses(problemID);
                },
                error: function (xhr, status, error) {
                    $(".modalPanel").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                }
            });
        }
    }

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function loadGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvProblems.ClientID%> tr").not($("#<%=gvProblems.ClientID%> tr:first-child")).remove();

        $(xml).find("Problem").each(function (index, value) {
            /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
            var date = new Date();

            $("td", row).eq(0).html("<img id='icon_" + index + "' src='/RAGHandler.ashx?module=" + $(this).attr('ModuleName') + "&key=" + $(this).attr('ProblemID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
            $("td", row).eq(1).html("<img id='delete_" + index + "' src='/Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(2).html("<img id='edit_" + index + "' src='/Images/edit.png' class='imgButton'/>");

            $("td", row).eq(3).html($(this).attr("CaseNo"));
            $("td", row).eq(4).html($(this).attr("Title"));
            $("td", row).eq(5).html($(this).attr("ProblemType"));
            $("td", row).eq(6).html($(this).attr("AffectedPartyType"));
            $("td", row).eq(7).html($(this).attr("Originator"));

            var originationdate = new Date($(this).find("OriginationDate").text());
            originationdate.setMinutes(originationdate.getMinutes() + originationdate.getTimezoneOffset());

            $("td", row).eq(8).html($(this).find("OriginationDate").text() == '' ? '' : originationdate.format("dd/MM/yyyy"));

            var targetclosedate = new Date($(this).attr("TargetCloseDate"));
            targetclosedate.setMinutes(targetclosedate.getMinutes() + targetclosedate.getTimezoneOffset());

            $("td", row).eq(9).html(targetclosedate.format("dd/MM/yyyy"));

            var actualclosedate = new Date($(this).find("ActualCloseDate").text());
            actualclosedate.setMinutes(actualclosedate.getMinutes() + actualclosedate.getTimezoneOffset());

            $("td", row).eq(10).html($(this).find("ActualCloseDate").text() == '' ? '' : actualclosedate.format("dd/MM/yyyy"));
            $("td", row).eq(11).html($(this).attr("ProblemStatus"));
            $("td", row).eq(12).html($(this).attr("ModeString"));

            $("#<%=gvProblems.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function () {
                        /* clear all text and combo fields*/
                        resetGroup(".modalPanel");

                        /*Temporarly store problem ID*/
                        $("#problemID").val($(value).attr("ProblemID"));

                        /*bind case number of the problem*/
                        $("#<%=CaseNoTxt.ClientID%>").val($(value).attr("CaseNo"));

                        /*bind problem type*/
                        bindProblemType($(value).attr("ProblemType"));

                        /*bind problem name*/
                        $("#<%=PRMNMTxt.ClientID%>").val(($(value).attr("Title")));

                        /*bind problem description*/
                        if ($(value).attr("Details") == '') {
                            addWaterMarkText('The Details of the Problem', '#<%=PRMDESCTxt.ClientID%>');
                        }
                        else {
                            if ($("#<%=PRMDESCTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=PRMDESCTxt.ClientID%>").val('').removeClass("watermarktext");

                            }

                            $("#<%=PRMDESCTxt.ClientID%>").val($("#<%=PRMDESCTxt.ClientID%>").html($(value).attr("Details")).text());
                        }

                        /*bind affected party type*/
                        bindComboboxAjax('loadProblemPartyType', '#<%=AFFPRTTYPCBox.ClientID%>', $(value).attr("AffectedPartyType"), "#AFFPRTTYP_LD");

                        switch ($(value).attr("AffectedPartyType")) {
                            case "External":
                                $("#external").stop(true).hide().fadeIn(500, function () {
                                    /* bind customer name*/
                                    $("#<%=AFFPRTYTxt.ClientID%>").val($(value).attr('ExternalParty'));
                                });

                                $("#internal").fadeOut(500, function ()
                                { });

                                break;
                            case "Internal":
                                $("#internal").stop(true).hide().fadeIn(500, function () {
                                    /*load the organization unit if the affected party is of type internal*/
                                    bindComboboxAjax('getOrganizationUnits', "#<%=AFFORGUNT.ClientID%>", $(value).attr("AffectedDepartment"), "#AFFORGUNT_LD");
                                });

                                $("#external").fadeOut(500, function () {
                                });
                                break;
                            case "None":
                                $(".selectionfield").each(function () {
                                    $(this).fadeOut(500, function () {
                                    });
                                });
                                break;
                        }

                        /*bind affected document field*/
                        bindDocuments("#AFFCTDOC_LD", '#<%=AFFCTDOCCBox.ClientID%>', $(value).attr("AffectedDocument"), "All");

                        /*bind originator*/
                        bindComboboxAjax('loadEmployees', '#<%=ORGCBox.ClientID%>', $(value).attr("Originator"), "#ORIG_LD");

                        /*bind owner*/
                        bindComboboxAjax('loadEmployees', '#<%=OWNRCBox.ClientID%>', $(value).attr("Owner"), "#OWNR_LD");

                        /*bind executive*/
                        bindComboboxAjax('loadEmployees', '#<%=EXECBox.ClientID%>', $(value).attr("Executive"), "#EXE_LD");


                        var raisedate = new Date($(value).attr("RaiseDate"));
                        raisedate.setMinutes(raisedate.getMinutes() + raisedate.getTimezoneOffset());

                        /* bind raise date*/
                        $("#<%=RISDTTxt.ClientID%>").val(raisedate.format("dd/MM/yyyy"));

                        /* bind origination date*/
                        $("#<%=ORGDTTxt.ClientID%>").val($(value).find("OriginationDate").text() == '' ? '' : originationdate.format("dd/MM/yyyy"));

                        /* bind target close date*/
                        $("#<%=TRGTCLSDTTxt.ClientID%>").val(targetclosedate.format("dd/MM/yyyy"));

                        /* bind actual close date*/
                        $("#<%=ACTCLSDTTxt.ClientID%>").val($(value).find("ActualCloseDate").text() == '' ? '' : actualclosedate.format("dd/MM/yyyy"));


                        var reviewreportissuedate = new Date($(value).find("ReviewReportIssueDate").text());
                        reviewreportissuedate.setMinutes(reviewreportissuedate.getMinutes() + reviewreportissuedate.getTimezoneOffset());

                        /* bind review report issue date*/
                        $("#<%=REVREPISSDTTxt.ClientID%>").val($(value).find("ReviewReportIssueDate").text() == '' ? '' : reviewreportissuedate.format("dd/MM/yyyy"));

                        /*bind problem status*/
                        bindComboboxAjax('loadProblemStatus', '#<%=PRMSTSCBox.ClientID%>', $(value).attr("ProblemStatus"), "#PSTS_LD");

                        /*bind reported from department*/
                        bindComboboxAjax('getOrganizationUnits', '#<%=REPFRMCBox.ClientID%>', $(value).attr("ReportDepartment"), "#REPORG_LD");

                        /*bind source of problem department*/
                        bindComboboxAjax('getOrganizationUnits', '#<%=RELORGCBox.ClientID%>', $(value).attr("ProblemRelatedDepartment"), "#SRCORG_LD");

                        /*bind severity value*/
                        bindSeverity($(value).attr('Severity'));

                        /*load risk category*/
                        loadXMLRiskCategory();

                        /*bind risk subcategories*/
                        loadXMLSubcategories($(value).attr('XMLSubcategories'));

                        /*load causes tree*/
                        loadRootCauses("#RTCAUS_LD", "#<%=RTCAUSCBox.ClientID%>");

                        /*bind causes*/
                        bindCauses($(value).attr("ProblemID"));

                        /*Deactivate tree fields*/
                        ActivateTreeField(false);

                        /*load members involved in problem approval*/
                        var json = $.parseJSON($(value).attr('JSONMembers'));

                        if (json.length == 0) {
                            $("#ApprovalGroupField").fadeOut(500, function () {
                                /*enable approval check box*/
                                $("#APPRCHK").prop("checked", false);
                                $("#table").table("removeAll");
                            });

                        }
                        else {
                            $("#ApprovalGroupField").stop(true).hide().fadeIn(500, function () {

                                $("#APPRCHK").prop("checked", true);

                                var attributes = new Array();
                                attributes.push("Member");
                                attributes.push("MemberType");
                                attributes.push("ApprovalStatusString");
                                attributes.push("ApprovalRemarks");

                                /*set cell settings*/
                                var settings = new Array();
                                settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadEmployees") }));
                                settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadMemberTypes") }));
                                settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("ApprovalStatus") }));
                                settings.push(JSON.stringify({ readonly: true }));

                                $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 20 });
                            });
                        }

                        if ($(value).attr('ProblemStatus') == 'Closed' || $(value).attr('ProblemStatus') == 'Cancelled') {
                            $("#ProblemTooltip").find('p').text("Changes cannot take place since the problem is " + $(value).attr('ProblemStatus'));

                            if ($("#ProblemTooltip").is(":hidden")) {
                                $("#ProblemTooltip").slideDown(800, 'easeOutBounce');
                            }

                            /*disable all modal controls*/
                            ActivateAll(false);
                        }
                        else {
                            /*enable all modal controls for editing*/
                            ActivateAll(true);

                            /*if the status of the problem is open, then the user is no longer able to add or modify approval members*/
                            if ($(value).attr('ProblemStatus') == 'Open') {
                                ActivateApproval(false);
                            }
                            else {
                                ActivateApproval(true);
                            }

                            $("#ProblemTooltip").hide();
                        }


                        /*bind problem remarks*/
                        if ($(value).attr("Remarks") == '') {
                            addWaterMarkText('Additional remarks in the support of the problem record', '#<%=RMRKTxt.ClientID%>');
                        }
                        else {
                            if ($("#<%=RMRKTxt.ClientID%>").hasClass("watermarktext")) {
                                $("#<%=RMRKTxt.ClientID%>").val('').removeClass("watermarktext");
                            }

                            $("#<%=RMRKTxt.ClientID%>").val($("#<%=RMRKTxt.ClientID%>").html($(value).attr("Remarks")).text());
                        }



                        /*attach problem name to limit plugin*/
                        $("#<%=PRMNMTxt.ClientID%>").limit({ id_result: 'PRMNMlimit', alertClass: 'alertremaining', limit: 90 });

                        $("#<%=PRMNMTxt.ClientID%>").keyup();

                        /*set default tab navigation*/
                        navigate("Details");

                        /*trigger modal popup extender*/
                        $("#<%=alias.ClientID%>").trigger('click');

                    });
                }
                else if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeProblem($(value).attr("CaseNo"), empty);
                    });
                }
            });
            row = $("#<%=gvProblems.ClientID%> tr:last-child").clone(true);
        });
    }

    function loadXMLRiskCategory() {

        $("#RSKCAT_LD").stop(true).hide().fadeIn(500, function () {

            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCategory"),
                success: function (data) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $("#<%=RSKCATCBox.ClientID%>"));
                    }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
}

function removeProblem(caseNo, empty) {
    var result = confirm('Removing the selected problem record will also remove all its related actions (if any), are you sure you would like to continue?');
    if (result == true) {
        $(".modulewrapper").css("cursor", "wait");

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'caseNo':'" + caseNo + "'}",
            url: getServiceURL().concat('removeProblem'),
            success: function (data) {
                $(".modulewrapper").css("cursor", "default");

                $("#refresh").trigger('click');
            },
            error: function (xhr, status, error) {
                $(".modulewrapper").css("cursor", "default");

                var r = jQuery.parseJSON(xhr.responseText);
                showErrorNotification(r.Message);
            }
        });
    }
}

function loadRootCauses(loader, control) {
    $(loader).stop(true).hide().fadeIn(500, function () {

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadRootCauses"),
            async:false,
            success: function (data) {
                $(loader).fadeOut(500, function () {
                    if (data) {
                        loadComboboxXML2($.parseXML(data.d), 'Causes', 'name', $(control), '', 'CauseID');
                    }
                });
            },
            error: function (xhr, status, error) {
                $(loader).fadeOut(500, function () {

                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                });
            }
        });
    });

}

function loadProblemType() {
    $("#PRMTYPF_LD").stop(true).hide().fadeIn(500, function () {

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadProblemType"),
            success: function (data) {
                $("#PRMTYPF_LD").fadeOut(500, function () {

                    if (data) {
                        loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $("#<%=PRMTYPFCBox.ClientID%>"));
                    }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PRMTYPF_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
}

function bindProblemType(type) {
    $("#PTYP_LD").stop(true).hide().fadeIn(500, function () {

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadProblemType"),
            success: function (data) {
                $("#PTYP_LD").fadeOut(500, function () {

                    if (data) {
                        bindComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', type, $("#<%=PRBLCBox.ClientID%>"));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PTYP_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function bindCauses(ID) {
        $("#cause_LD").stop(true).hide().fadeIn(500, function () {
            /*Deactivate all textboxes in the causes*/
            ActivateTreeField(false);

            /*clear number of character values of the tree fields*/
            $("#CUSTTLlimit").html('');

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'problemID':'" + ID + "'}",
                async:false,
                url: getServiceURL().concat('loadProblemCauses'),
                success: function (data) {
                    $("#cause_LD").fadeOut(500, function () {
                        var existingjson = $('#causetree').tree('toJson');
                        if (existingjson == null) {
                            $('#causetree').tree(
                            {
                                data: $.parseJSON(data.d),
                                slide: true,
                                autoOpen: true
                            });
                        }
                        else {
                            $('#causetree').tree('loadData', $.parseJSON(data.d));
                        }

                        var obj = $.parseJSON(data.d);

                        var node = $('#causetree').tree('getNodeById', obj[0].SelectedCauseID);
                        $('#causetree').tree('selectNode', node);

                        $("#<%=RTCAUSCBox.ClientID%>").val(obj[0].CauseID);
                    });
                },
                error: function (xhr, status, error) {
                    $("#cause_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function loadCauses(ID) {
        $("#cause_LD").stop(true).hide().fadeIn(500, function () {

            /*Deactivate all textboxes in the causes*/
            ActivateTreeField(false);

            /*clear number of character values of the tree fields*/
            $("#CUSTTLlimit").html('');

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'causeid':'" + ID + "'}",
                async:false,
                url: getServiceURL().concat('loadChildCauseTree'),
                success: function (data) {
                    $("#cause_LD").fadeOut(500, function () {
                        var existingjson = $('#causetree').tree('toJson');
                        if (existingjson == null) {
                            $('#causetree').tree(
                            {
                                data: $.parseJSON(data.d),
                                slide: true,
                                autoOpen: true
                            });
                        }
                        else {
                            $('#causetree').tree('loadData', $.parseJSON(data.d));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#cause_LD").fadeOut(500, function () {
                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }


    function loadSubcategories(category) {
        $("#RSKCAT_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'categoryname':'" + category + "'}",
                url: getServiceURL().concat("loadSubcategories"),
                success: function (data) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            $("#RSKCHK").empty();

                            var checklist = JSON.parse(data.d);

                            $(checklist).each(function (index, value) {
                                if (SubcategoryExists("#RSKCHK", value.name) == false) {
                                    var html = '';
                                    html += "<div class='checkitem'>";
                                    html += "<input type='checkbox' id='" + value.SubCategoryID + "' name='checklist' value='" + 5 + "'/><div class='checkboxlabel'>" + value.name + "</div>";
                                    html += "</div>";

                                    $("#RSKCHK").append(html);

                                    $("#" + $(this).attr('SubCategoryID')).change(function () {
                                        if ($(this).is(":checked") == false) {
                                            if ($(this).val() == 3) {
                                                $(this).val(5);
                                            }
                                        }
                                        else {
                                            if ($(this).val() == 5) {
                                                $(this).val(3);
                                            }
                                        }
                                    });

                                }
                            });
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
    }

    function SubcategoryExists(control, subcat) {
        var found = false;

        $(control).children().each(function (index, value) {
            if ($(this).find('.checkboxlabel').text() == subcat) {
                found = true;
                return false;
            }
        });

        return found;
    }

    function loadXMLSubcategories(data) {
        var subcategory = $.parseXML(data);

        /*clear all previous values*/
        $("#RSKCHK").empty();

        $(subcategory).find('RiskSubcategory').each(function (index, value) {
            var html = '';
            html += "<div class='checkitem'>";
            html += "<input type='checkbox' id='" + $(this).attr('SubCategoryID') + "' name='checklist' value='" + $(this).attr('Status') + "'/><div class='checkboxlabel'>" + $(this).attr('SubCategory') + "</div>";
            html += "</div>";

            $("#RSKCHK").append(html);

            $("#" + $(this).attr('SubCategoryID')).prop('checked', true);

            $("#" + $(this).attr('SubCategoryID')).change(function () {
                if ($(this).is(":checked") == false) {
                    if ($(this).val() == 1) {
                        $(this).val(4);
                    }
                }
                else {
                    if ($(this).val() == 4) {
                        $(this).val(1);
                    }
                }
            });

        });
    }

    function filterCustomerByType(type, empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'type':'" + type + "'}",
                url: getServiceURL().concat('filterCustomerByType'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadCustomerGridView(data.d, empty);
                        }
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
    function loadCustomers(empty) {
        $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{}",
                url: getServiceURL().concat('loadCustomers'),
                success: function (data) {
                    $("#FLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadCustomerGridView(data.d, empty);
                        }
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

    function bindSeverity(name) {
        $("#SVR_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadSeverity"),
                success: function (data) {
                    $("#SVR_LD").fadeOut(500, function () {

                        if (data) {
                            /*Parse xml data and load severity cbox*/
                            bindComboboxXML($.parseXML(data.d), 'Severity', 'Criteria', name, "#<%=SVRTCBox.ClientID%>");
                    }
                    });
                },
                error: function (xhr, status, error) {
                    $("#SVR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    });
                }
            });
        });
}

function loadXMLPartyType(loader, control) {
    $(loader).stop(true).hide().fadeIn(500, function () {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadCustomerType"),
            success: function (data) {
                $(loader).fadeOut(500, function () {
                    if (data) {
                        loadComboboxXML($.parseXML(data.d), 'GenericType', 'TypeName', $(control));
                    }
                });
            },
            error: function (xhr, status, error) {
                $(loader).fadeOut(500, function () {
                    var r = jQuery.parseJSON(xhr.responseText);
                    showErrorNotification(r.Message);
                });
            }
        });
    });
}

function loadCustomerGridView(data, empty) {
    var xmlCustomers = $.parseXML(data);

    var row = empty;

    $("#<%=gvCustomers.ClientID%> tr").not($("#<%=gvCustomers.ClientID%> tr:first-child")).remove();

        $(xmlCustomers).find("Customer").each(function (index, value) {
            $("td", row).eq(0).html($(this).attr("CustomerNo"));
            $("td", row).eq(1).html($(this).attr("CustomerType"));
            $("td", row).eq(2).html($(this).attr("CustomerName"));
            $("td", row).eq(3).html($(this).attr("EmailAddress"));

            $("#<%=gvCustomers.ClientID%>").append(row);

            $(row).bind('click', function () {
                $("#SearchCustomer").hide('800');
                $("#<%=AFFPRTYTxt.ClientID%>").val($(value).attr("CustomerName"));
            });

            row = $("#<%=gvCustomers.ClientID%> tr:last-child").clone(true);
        });
    }


    function hideAllSelectBoxFilter() {
        $(".selectboxfilter").each(function () {
            $(this).css('display', 'none');
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

    function ActivateApproval(isactive) {
        if (isactive == false) {
            $("#ApprovalTB").children().each(function () {


                $(this).find(".table").each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find(".imgButton").each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('input[type="checkbox"]').each(function () {
                    $(this).attr('disabled', true);
                });


            });
        }
        else {
            $("#ApprovalTB").children().each(function () {

                $(this).find(".table").each(function () {
                    $(this).attr('disabled', false);
                });


                $(this).find(".imgButton").each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('input[type="checkbox"]').each(function () {
                    $(this).attr('disabled', false);
                });

            });
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

                $(this).find('.searchactive').each(function () {
                    $(this).css("pointer-events", "none");
                });

                $(this).find(".combobox").each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find(".imgButton").each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find(".textremaining").each(function () {
                    $(this).html('');
                });

                $(this).find('input[type="checkbox"]').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find(".hasDatepicker").each(function () {
                    $(this).datepicker('disable');
                })
            });

            $('#save').attr("disabled", true);
            $("#save").css({ opacity: 0.5 });

        }
        else {
            $(".modalPanel").children().each(function () {

                $(this).find(".readonlycontrolled").each(function () {
                    $(this).removeClass("readonlycontrolled");
                    $(this).addClass("textbox");
                    $(this).attr('readonly', false);
                });

                $(this).find('.searchactive').each(function () {
                    $(this).css("pointer-events", "auto");
                });

                $(this).find(".combobox").each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find(".imgButton").each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find('input[type="checkbox"]').each(function () {
                    $(this).attr('disabled', false);
                });

                $(this).find(".hasDatepicker").each(function () {
                    $(this).datepicker('enable');
                })

            });
            $('#save').attr("disabled", false);
            $("#save").css({ opacity: 100 });
        }
    }

    function ActivateTreeField(isactive) {
        if (isactive == false) {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("textbox");
                $(this).addClass("readonly");
                $(this).attr('readonly', true);
            });
        }
        else {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("readonly");
                $(this).addClass("textbox");
                $(this).attr('readonly', false);
            });
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

    function showDOCDialog(x, y) {
        $("#SelectDOC").css({ left: x - 310, top: y - 150 });
        loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYP.ClientID%>", "#DOCTYP_LD");
        $("#SelectDOC").show();
    }

    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 310, top: y - 150 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
        $("#SelectORG").show();
    }

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
    </script>
</asp:Content>
