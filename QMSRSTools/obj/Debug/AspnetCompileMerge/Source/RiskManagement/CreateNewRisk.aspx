<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="CreateNewRisk.aspx.cs" Inherits="QMSRSTools.RiskManagement.CreateNewRisk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Risk_Header" class="moduleheader">Create a New Risk</div>

    <div class="toolbox">
        <img id="save" src="http://www.qmsrs.com/qmsrstools/Images/save.png" class="imgButton" title="Save Changes" alt="" /> 
    </div>    
    
    <div style="float:left; width:100%; height:20px; margin-top:10px;">
        <div id="RiskTypeLabel" class="requiredlabel">Risk Type:</div>
        <div id="RiskTypeField" class="fielddiv" style="width:250px;">
            <asp:DropDownList ID="RSKTYPCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
        <div id="RSKTYP_LD" class="control-loader"></div>
         
        <asp:RequiredFieldValidator ID="PRBLTxtVal" runat="server" Display="None" ControlToValidate="RSKTYPCBox" ErrorMessage="Select the type of the risk" ValidationGroup="Details"></asp:RequiredFieldValidator>
    
        <asp:CompareValidator ID="PRBLVal" runat="server" ControlToValidate="RSKTYPCBox"
        Display="None" ErrorMessage="Select the type of the risk" Operator="NotEqual" Style="position: static"
        ValueToCompare="0" ValidationGroup="Details"></asp:CompareValidator>
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <div id="RiskNoLabel" class="requiredlabel">Risk No:</div>
        <div id="RiskNoField" class="fielddiv" style="width:auto;">
            <asp:TextBox ID="RiskNoTxt" runat="server" CssClass="textbox"></asp:TextBox>
            <asp:Label ID="RiskNoLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
        </div>
        <div id="IDlimit" class="textremaining"></div>
        
        <asp:RequiredFieldValidator ID="RiskNoVal" runat="server" Display="None" ControlToValidate="RiskNoTxt" ErrorMessage="Enter a unique ID of the risk" ValidationGroup="Details"></asp:RequiredFieldValidator>

        <asp:CustomValidator id="RiskNoFVal" runat="server" ValidationGroup="Details" 
        ControlToValidate = "RiskNoTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
        ClientValidationFunction="validateIDField">
        </asp:CustomValidator>      
    </div>
    

    <div id="RiskGroupHeader" class="groupboxheader">Risk Details</div>
    <div id="RiskGroupField" class="groupbox" style="height:520px;">

        <ul id="tabul">
            <li id="Details" class="ntabs">Risk Information</li>
            <li id="Probability" class="ntabs">Risk Estimation</li>
        </ul>

        <div id="DetailsTB" class="tabcontent" style="display:none; height:480px;">

            <div id="validation_dialog_details" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Details" />
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="RiskNameLabel" class="requiredlabel">Risk Name:</div>
                <div id="RiskNameField" class="fielddiv" style="width:300px;">
                    <asp:TextBox ID="RSKNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
                </div>
                <div id="RSKNMlimit" class="textremaining"></div>
        
                <asp:RequiredFieldValidator ID="RSKNMVal" runat="server" Display="None" ControlToValidate="RSKNMTxt" ErrorMessage="Enter the name of the risk" ValidationGroup="Details"></asp:RequiredFieldValidator>

                <asp:CustomValidator id="RSKNMTxtFVal" runat="server" ValidationGroup="Details" 
                ControlToValidate = "RSKNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
                ClientValidationFunction="validateSpecialCharacters">
                </asp:CustomValidator> 
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskModeLabel" class="requiredlabel">Risk Mode:</div>
                <div id="RiskModeField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="RSKMODCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>

                <div id="RSKMOD_LD" class="control-loader"></div>
                
                <asp:RequiredFieldValidator ID="RSKMODCBoxVal" runat="server" ControlToValidate="RSKMODCBox" ErrorMessage="Select the risk mode" Display="None" ValidationGroup="Details"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="RSKMODCBoxFVal" runat="server" ControlToValidate="RSKMODCBox" Display="None"  ValidationGroup="Details"
                ErrorMessage="Select the risk mode" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskCategoryLabel" class="requiredlabel">Risk Category:</div>
                <div id="RiskCategoryField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="RSKCATCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            
                <div id="RSKCAT_LD" class="control-loader"></div> 

                <span id="CATADD" class="addnew" style="margin-left:10px;" runat="server" title="Create new risk category"></span>

                <asp:RequiredFieldValidator ID="RSKCATTxtVal" runat="server" ControlToValidate="RSKCATCBox" ErrorMessage="Select the category of the risk" Display="None" ValidationGroup="Details"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="RSKCATVal" runat="server" ControlToValidate="RSKCATCBox" Display="None"  ValidationGroup="Details"
                ErrorMessage="Select the category of the risk" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="DescriptionLabel" class="labeldiv">Description:</div>
                <div id="DescriptionField" class="fielddiv" style="width:400px; height:190px;">
                    <asp:TextBox ID="RSKDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
                </div>

                <asp:CustomValidator id="RSKDESCTxtVal" runat="server" ValidationGroup="Details" 
                ControlToValidate = "RSKDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
                ClientValidationFunction="validateSpecialCharactersLongText">
                </asp:CustomValidator>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:190px;">
                <div id="DateRegisteredDateLabel" class="requiredlabel">Date Registered:</div>
                <div id="DateRegisteredDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="REGDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>      
            
                <asp:RequiredFieldValidator ID="REGDTVal" runat="server" Display="None" ControlToValidate="REGDTTxt" ErrorMessage="Enter the date of the registration"  ValidationGroup="Details"></asp:RequiredFieldValidator>  
           
                <asp:RegularExpressionValidator ID="REGDTTxtFVal" runat="server" ControlToValidate="REGDTTxt"
                ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" Display="None" ValidationGroup="Details"></asp:RegularExpressionValidator>  
            
                <asp:CustomValidator id="REGDTTxtF2Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "REGDTTxt" Display="None" ErrorMessage = "the date of the registration should match today's date"
                ClientValidationFunction="compareEqualsToday">
                </asp:CustomValidator>

                <asp:CustomValidator id="REGDTTxtF3Val" runat="server" ValidationGroup="Details" 
                ControlToValidate = "REGDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RiskOwnerLabel" class="requiredlabel">Risk Owner:</div>
                <div id="RiskOwnerField" class="fielddiv" style="width:250px;">
                    <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="OWNR_LD" class="control-loader"></div>

                <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
                <asp:RequiredFieldValidator ID="OWNRCBoxTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select the owner of the risk" ValidationGroup="Details"></asp:RequiredFieldValidator>
                
                <asp:CompareValidator ID="OWNRCBoxVal" runat="server" ControlToValidate="OWNRCBox" Display="None"  ValidationGroup="Details"
                ErrorMessage="Select the owner of the risk" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
            </div>

            <div id="SelectORG" class="selectbox">
                <div id="closeORG" class="selectboxclose"></div>
                <div style="float:left; width:100%; height:20px; margin-top:5px;">
                    <div id="ORGUnitLabel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                    <div id="ORGUnitField" class="fielddiv" style="width:130px;">
                        <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                        </asp:DropDownList> 
                    </div>
                    <div id="ORG_LD" class="control-loader"></div>
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="CostCentreLabel" class="labeldiv">Cost Centre:</div>
                <div id="CostCentreField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="CSTCNTRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="CNTR_LD" class="control-loader"></div>      
          
                <span id="CNTRADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new cost centre"></span>
           </div>

           <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="OtherCostCentreLabel" class="labeldiv">Other Cost Centre:</div>
                <div id="OtherCostCentreField" class="fielddiv" style="width:250px">
                    <asp:DropDownList ID="OCSTCNTRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                <div id="OCNTR_LD" class="control-loader"></div>
           </div>
        </div>

        <div id="ProbabilityTB" class="tabcontent" style="display:none; height:480px;">

            <div id="RiskEstimationTooltip" class="tooltip" style="margin-top:10px;">
                <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
                <p></p>
            </div>

            <div id="validation_dialog_risk" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary6" runat="server" CssClass="validator" ValidationGroup="Risk" />
            </div>
          
            <div id="validation_dialog_ohsashaccp" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary9" runat="server" CssClass="validator" ValidationGroup="OHSASHACCP" />
            </div>
            
             <div id="validation_dialog_ems" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary10" runat="server" CssClass="validator" ValidationGroup="EMS" />
            </div>

            <div id="RiskEstimationGroupHeader" class="groupboxheader">Risk Estimation Details</div>
            <div id="RiskEstimationGroupDetails" class="groupbox" style="height:auto;">
           

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="ProbabilityLabel" class="requiredlabel">Probability:</div>
                <div id="ProbabilityField" class="fielddiv" style="width:100px">
                    <asp:DropDownList ID="PROBCBox" AutoPostBack="false" runat="server" Width="100px" CssClass="combobox">
                    </asp:DropDownList>    
                </div>
                
                <img id="PROBEdit" src="http://www.qmsrs.com/qmsrstools/Images/edit.png" class="imgButton" alt="" title="Edit Probability Criteria"/>
                                        
                <div id="PROB_LD" class="control-loader"></div>

                <div id="ProbabilityValueLabel" class="labeldiv" style="width:200px;">Probability Value:</div>
                <div id="ProbabilityValueField" class="fielddiv" style="width:150px;">
                    <asp:TextBox ID="PROBVALTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="140px"></asp:TextBox>
                </div>

                <asp:RequiredFieldValidator ID="PROBCBoxVal" runat="server" Display="None" ControlToValidate="PROBCBox" ErrorMessage="Select the probability percentage" ValidationGroup="Probability"></asp:RequiredFieldValidator>         
        
                <asp:CompareValidator ID="PROBCBoxTxtVal" runat="server" ControlToValidate="PROBCBox" Display="None" ValidationGroup="Probability"
                ErrorMessage="Select the probability percentage" Operator="NotEqual" Style="position: static"
                ValueToCompare="0"></asp:CompareValidator>
                
            </div>
               
            <div id="RiskGeneralEstimationGroupHeader" class="groupboxheader">Risk Estimation for Organizational, Projects, and Issue Risk Types</div>
            <div id="RiskGeneralEstimationGroup" class="groupbox" style="height:auto;">

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ORIRiskTypeLabel" class="labeldiv">ORI Risk Type:</div>
                    <div id="ORIRiskTypeField" class="fielddiv" style="width:auto;">
                        <asp:RadioButton  ID="ProjectRB" GroupName="ORIRiskType" CssClass="radiobutton" Text="Project" runat="server" />
                        <asp:RadioButton  ID="OrganizationalRB" GroupName="ORIRiskType" CssClass="radiobutton" Text="Organizational" runat="server" />
                    </div>     
                </div>

                <div id="project" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
                    <div id="ProjectLabel" class="requiredlabel">Select Project:</div>
                    <div id="ProjectField" class="fielddiv" style="width:250px">
                        <asp:TextBox ID="PROJTxt" Width="240px" runat="server" CssClass="readonly">
                        </asp:TextBox>
                    </div>

                    <span id="PROJSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for projects"></span>

                    <asp:RequiredFieldValidator ID="PROJTxtVal" runat="server" Display="None" ControlToValidate="PROJTxt" ErrorMessage="Select a Project" ValidationGroup="Project"></asp:RequiredFieldValidator> 
                </div>
    
                <div id="SearchProject" class="selectbox">
                    <div class="toolbox">  
                        <div id="projcloseBox" class="selectboxclose"></div>
                    </div>

                    <div id="projectcontainer" class="filterselectbox" style="display:block;">
                        <div id="StartDateLabel" class="filterlabel">Project Start Date:</div>
                        <div id="StartDateField" class="filterfield">
                            <asp:TextBox ID="FDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
                            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                            <asp:TextBox ID="TDTTxt" runat="server" CssClass="date" Width="120px"></asp:TextBox>
                        </div>
                        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                        </ajax:MaskedEditExtender>

                        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                        </ajax:MaskedEditExtender>
                    </div>
                    
                    <div id="PROJFLTR_LD" class="control-loader"></div> 
            
                    <div id="scrollbarPROJ" class="gridscroll">
                        <asp:GridView id="gvProjects" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:BoundField DataField="PROJNo" HeaderText="Project No." />
                            <asp:BoundField DataField="PROJName" HeaderText="Project Title" />
                            <asp:BoundField DataField="StartDate" HeaderText="Start Date" />
                            <asp:BoundField DataField="PlannedCloseDate" HeaderText="Planned Close Date" />
                            <asp:BoundField DataField="ActualCloseDate" HeaderText="Actual Close Date" />
                            <asp:BoundField DataField="Leader" HeaderText="Project Leader" />
                            <asp:BoundField DataField="Value" HeaderText="Project Value" /> 
                            <asp:BoundField DataField="Cost" HeaderText="Project Cost" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                        </Columns>
                        </asp:GridView>
                    </div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="TimeImpactLabel" class="requiredlabel">Time Impact:</div>
                    <div id="TimeImpactField" class="fielddiv" style="width:100px;">
                        <asp:DropDownList ID="TIMPCBox" AutoPostBack="false" Width="100px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <img id="TIMPEdit" src="http://www.qmsrs.com/qmsrstools/Images/edit.png" class="imgButton" alt="" title="Edit Time Impact Criteria"/>
                 
                    <div id="TIMP_LD" class="control-loader"></div>
                    
                    <div id="TimeProbabilityLabel" class="labeldiv">Probability Value:</div>
                    <div id="TimeProbabilityField" class="fielddiv" style="width:100px">
                        <asp:TextBox ID="TPROBTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                    </div>
                    <img id="TPROB_Help" src="http://www.qmsrs.com/qmsrstools/Images/help.png" class="searchactive" style="margin-left:10px;" alt="" title="Maintain Probability Percentage Matrix"/>
                    
                    <asp:RequiredFieldValidator ID="TPROBVal" runat="server" Display="None" ControlToValidate="TPROBTxt" ErrorMessage="Select the probability percentage of the time impact" ValidationGroup="Risk"></asp:RequiredFieldValidator> 
           
                </div>
                    
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="CostImpactLabel" class="requiredlabel">Cost Impact:</div>
                    <div id="CostImpactField" class="fielddiv" style="width:100px;">
                        <asp:DropDownList ID="CIMPCBox" AutoPostBack="false" Width="100px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div> 
                    <img id="CIMPEdit" src="http://www.qmsrs.com/qmsrstools/Images/edit.png" class="imgButton" alt="" title="Edit Cost Impact Criteria"/>
                   
                    <div id="CIMP_LD" class="control-loader"></div>
                    
                    <div id="CostProbabilityLabel" class="labeldiv">Probability Value:</div>
                    <div id="CostProbabilityField" class="fielddiv" style="width:100px">
                        <asp:TextBox ID="CPROBTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="CPROBVal" runat="server" Display="None" ControlToValidate="CPROBTxt" ErrorMessage="Select the probability percentage of the cost impact" ValidationGroup="Risk"></asp:RequiredFieldValidator> 
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="QOSImpactLabel" class="requiredlabel">QOS Impact:</div>
                    <div id="QOSImpactField" class="fielddiv" style="width:100px;">
                        <asp:DropDownList ID="QOSIMPCBox" AutoPostBack="false" Width="100px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    <img id="QOSIMPEdit" src="http://www.qmsrs.com/qmsrstools/Images/edit.png" class="imgButton" alt="" title="Edit Quality of Service Criteria"/>
                   
                    <div id="QOSIMP_LD" class="control-loader"></div>
                    
                    <div id="QOSProbabilityLabel" class="labeldiv">Probability Value:</div>
                    <div id="QOSProbabilityField" class="fielddiv" style="width:100px">
                        <asp:TextBox ID="QOSPROBTxt" runat="server" ReadOnly="true" Width="90px" CssClass="readonly"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="QOSPROBVal" runat="server" Display="None" ControlToValidate="QOSPROBTxt" ErrorMessage="Select the probability percentage of the QOS impact" ValidationGroup="Risk"></asp:RequiredFieldValidator> 
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="StandardImpactCostLabel" class="labeldiv">Standard Cost of Impact:</div>
                    <div id="StandardImpactCostField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="STDIMPCOSTTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    </div>
                    
                    <img id="STDIMPEdit" src="http://www.qmsrs.com/qmsrstools/Images/edit.png" class="imgButton" alt="" title="Edit Standard Impact Cost Criteria"/>
                   

                    <div id="StandardExposureLabel" class="labeldiv">Exposure:</div>
                    <div id="StandardExposureField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="STDEXPTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    </div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="AdjustedImpactCostLabel" class="labeldiv">Adjusted Cost of Impact:</div>
                    <div id="AdjustedImpactCostField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="ADJIMPCOSTTxt" runat="server" Width="140px" CssClass="textbox"></asp:TextBox>
                    </div>
                    
                    <asp:RegularExpressionValidator ID="ADJIMPCOSTTxtFVal" runat="server" ControlToValidate="ADJIMPCOSTTxt"
                    Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="Risk"></asp:RegularExpressionValidator>  
    
         
                    <div id="AdjustedExposureLabel" class="labeldiv">Exposure:</div>
                    <div id="AdjustedExposureField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="ADJEXPTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    </div>
                </div>
            </div>


            <div id="OHSASHACCPGroupHeader" class="groupboxheader">Risk Estimation for OHSAS & HACCP Risk Types</div>
            <div id="OHSASHACCPGroup" class="groupbox" style="height:100px;"> 
                
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="SeverityLabel" class="requiredlabel">Severity Criteria:</div>
                    <div id="SeverityField" class="fielddiv" style="width:250px;">
                        <asp:DropDownList ID="SVRTCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                    
                    <span id="SVRADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new severity criteria"></span>

                    <div id="SVR_LD" class="control-loader"></div>


                    <div id="CriticalLimitLabel" class="requiredlabel" style="width:80px;">Critical Limit:</div>
                    <div id="CriticalLimitField" class="fielddiv" style="width:auto;">
                        <asp:DropDownList ID="OPRCBox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                        </asp:DropDownList>

                        <div id="OPR_LD" class="control-loader"></div>
                    
                        <asp:Label ID="LMslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="LMTTxt" runat="server" Width="90px" CssClass="textbox"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="LMTTxtVal" runat="server" Display="None" ControlToValidate="LMTTxt" ErrorMessage="Select the critical limit value" ValidationGroup="OHSASHACCP"></asp:RequiredFieldValidator> 
           
                        <asp:RegularExpressionValidator ID="LMTTxtFVal" runat="server" ControlToValidate="LMTTxt"
                        Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="OHSASHACCP"></asp:RegularExpressionValidator>  
    
                        <asp:RequiredFieldValidator ID="OPRCTxtVal" runat="server" Display="None" ControlToValidate="OPRCBox" ErrorMessage="Select the sign of the critical limit" ValidationGroup="OHSASHACCP"></asp:RequiredFieldValidator>         
        
                        <asp:CompareValidator ID="OPRCVal" runat="server" ControlToValidate="OPRCBox" Display="None" ValidationGroup="OHSASHACCP"
                        ErrorMessage="Select the sign of the critical limit" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                    </div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">     
                    <div id="SeverityValueLabel" class="labeldiv">Severity Score:</div>
                    <div id="SeverityValueField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="SVRVALTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    </div>

                    <asp:RequiredFieldValidator ID="SVRVALTxtVal" runat="server" Display="None" ControlToValidate="SVRVALTxt" ErrorMessage="Select the score of the severity" ValidationGroup="OHSASHACCP"></asp:RequiredFieldValidator> 
           
                </div>
            </div>
           
            <div id="EMSGroupHeader" class="groupboxheader">Risk Estimation for EMS Risk Types</div>
            <div id="EMSGroup" class="groupbox" style="height:305px;">

                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="SeverityEnvironmentLabel" class="requiredlabel" style="width:200px;">Severity of Impact on Env.:</div>
                    <div id="SeverityEnvironmentField" class="fielddiv" style="width:auto">
                        <asp:DropDownList ID="SVRENVCBox" AutoPostBack="false" Width="300px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                 
                    <div id="SVRENV_LD" class="control-loader"></div>

                   
                    <div id="SeverityEnvironmentValueLabel" class="labeldiv">Severity Score:</div>
                    <div id="SeverityEnvironmentValueField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="SVRENVValTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    </div>
                    <span id="SVRENADD" class="addnew" style="margin-left:10px;" runat="server" title="Add new severity criteria"></span>

                    <asp:RequiredFieldValidator ID="SVRENVValTxtVal" runat="server" Display="None" ControlToValidate="SVRENVValTxt" ErrorMessage="Select the value of the sevrity of impact on environment" ValidationGroup="EMS"></asp:RequiredFieldValidator>         
        
               </div>
                
               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="SeverityHumanLabel" class="requiredlabel" style="width:200px;">Severity of Impact on Human:</div>
                    <div id="SeverityHumanField" class="fielddiv" style="width:300px;">
                        <asp:DropDownList ID="SVRHUMCBox" AutoPostBack="false" Width="300px" runat="server" CssClass="combobox">
                        </asp:DropDownList>
                    </div>
                 
                    <div id="SVRHUM_LD" class="control-loader"></div>

                    <div id="SeverityHumanScoreLabel" class="labeldiv">Severity Score:</div>
                    <div id="SeverityHumanScoreField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="SVRHUMValTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>

                    </div>
                    <asp:RequiredFieldValidator ID="SVRHUMValTxtVal" runat="server" Display="None" ControlToValidate="SVRHUMValTxt" ErrorMessage="Select the value of the sevrity of impact on human" ValidationGroup="EMS"></asp:RequiredFieldValidator>         
       
               </div>

               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ComplexityOperationalLabel" class="requiredlabel" style="width:200px;">Complexity of Operational Controls:</div>
                    <div id="ComplexityOperationalField" class="fielddiv" style="width:auto;">
                        <asp:TextBox ID="COMPOPRTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox> 
                   
                        <asp:RequiredFieldValidator ID="COMPOPRTxtVal" runat="server" Display="None" ControlToValidate="COMPOPRTxt" ErrorMessage="Select the score of the complexity of operational controls" ValidationGroup="EMS"></asp:RequiredFieldValidator>      
                   
                        <asp:Label ID="Label2" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="COMPOPRDSCTxt" runat="server" ReadOnly="true" Width="240px" CssClass="readonly"></asp:TextBox> 
            
                     </div>
                     <span id="COMPOPRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
               
               </div>
               
             
               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="LegalRegularityLabel" class="labeldiv" style="width:200px;">Legal/Regulatory Requirements:</div>
                    <div id="LegalRegularityField" class="fielddiv" style="width:auto;">
                        <asp:TextBox ID="LRRTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox> 
                 
                        <asp:Label ID="Label3" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="LRRDSCTxt" runat="server" ReadOnly="true" Width="240px" CssClass="readonly"></asp:TextBox> 
                 
                    </div>
                    <span id="LRRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>    
                    
                </div>
                    
               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="NuisanceLabel" class="labeldiv" style="width:200px;">Nuisance:</div>
                    <div id="NuisanceField" class="fielddiv" style="width:auto;">
                        <asp:TextBox ID="NuisanceTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox> 
                   
                        <asp:Label ID="Label4" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="NuisanceDSCTxt" runat="server" ReadOnly="true" Width="240px" CssClass="readonly"></asp:TextBox> 
              
                    </div>
                    <span id="NuisanceSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
                    
               </div>

               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="InterestedPartiesLabel" class="labeldiv" style="width:200px;">Interested Parties:</div>
                    <div id="InterestedPartiesField" class="fielddiv" style="width:auto;">
                        <asp:TextBox ID="INTPRTTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox> 
                    
                        <asp:Label ID="Label5" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="INTPRTDSCTxt" runat="server" ReadOnly="true" Width="240px" CssClass="readonly"></asp:TextBox> 
              
                    </div>
                    <span id="INTPRTSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
                    
               </div>
               
               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="LackInformationLabel" class="labeldiv" style="width:200px;">Lack of Information:</div>
                    <div id="LackInformationField" class="fielddiv" style="width:auto;">
                        <asp:TextBox ID="LINFOTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox> 
                    
                        <asp:Label ID="Label6" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="LINFODSCTxt" runat="server" ReadOnly="true" Width="240px" CssClass="readonly"></asp:TextBox> 
                    </div>
                    <span id="LINFOSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
               </div>
               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="PolicyIssuesLabel" class="labeldiv" style="width:200px;">Policy Issues:</div>
                    <div id="PolicyIssuesField" class="fielddiv" style="width:auto;">
                        <asp:TextBox ID="PLCYISSUTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    
                        <asp:Label ID="Label7" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="PLCYISSUDSCTxt" runat="server" ReadOnly="true" Width="240px" CssClass="readonly"></asp:TextBox> 
                    
                    </div>
                    <span id="PLCYISSUSelect" class="searchactive" style="margin-left:10px" runat="server"></span> 
               </div>
                    
               <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="SignRatingLabel" class="labeldiv" style="width:200px;">Significant Rating:</div>
                    <div id="SignRatingField" class="fielddiv" style="width:150px">
                        <asp:TextBox ID="SGNRATTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                    </div>  
                    
                    <img id="SGNRAT_Help" src="http://www.qmsrs.com/qmsrstools/Images/help.png" class="searchactive" style="margin-left:10px;" alt="" title="Maintain Significant Rating Criteria"/>   
                   
                    
                    <div id="EMSCriticalLimitsLabel" class="requiredlabel" style="width:80px;">Critical Limit:</div>
                    <div id="EMSCriticalLimitsField" class="fielddiv" style="width:auto;">
                        <asp:DropDownList ID="EMSOPRCbox" AutoPostBack="false" Width="150px" runat="server" CssClass="combobox">
                        </asp:DropDownList>

                        <div id="EMSOPR_LD" class="control-loader"></div>
                    
                        <asp:Label ID="EMSLMslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>

                        <asp:TextBox ID="EMSLMTTxt" runat="server" Width="90px" CssClass="textbox"></asp:TextBox>

                        <asp:RequiredFieldValidator ID="EMSLMTVal" runat="server" Display="None" ControlToValidate="EMSLMTTxt" ErrorMessage="Select the critical limit value" ValidationGroup="EMS"></asp:RequiredFieldValidator> 
           
                        <asp:RegularExpressionValidator ID="EMSLMTTxtFVal" runat="server" ControlToValidate="EMSLMTTxt"
                        Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]{2})?$" ValidationGroup="EMS"></asp:RegularExpressionValidator>  
   
                        <asp:RequiredFieldValidator ID="EMSOPRTxtVal" runat="server" Display="None" ControlToValidate="EMSOPRCbox" ErrorMessage="Select the sign of the critical limit" ValidationGroup="EMS"></asp:RequiredFieldValidator>         
        
                        <asp:CompareValidator ID="EMSOPRVal" runat="server" ControlToValidate="EMSOPRCbox" Display="None" ValidationGroup="EMS"
                        ErrorMessage="Select the sign of the critical limit" Operator="NotEqual" Style="position: static"
                        ValueToCompare="0"></asp:CompareValidator>
                    </div>      
               </div>
               
               <div id="SelectAssessment" class="selectbox" style="width:700px; height:250px;">
                    <div class="toolbox">
                         <img id="deletefilter" src="http://www.qmsrs.com/qmsrstools/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
                        <div id="filter_div">
                            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
                            
                            <ul class="contextmenu">
                                <li id="byACAT">Filter by Assessment Category</li>
                            </ul>
                        </div>

                        <div id="AssessmentCategoryContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                            <div id="AssessmentCategoryFLabel" style="width:110px;">Assessment Category:</div>
                            <div id="AssessmentCategoryFField" style="width:170px; left:0; float:left;">
                                <asp:DropDownList ID="ACATFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
                                </asp:DropDownList>
                            </div>
                            <div id="ACATF_LD" class="control-loader"></div>
                        </div>

                        <div id="guidclosebox" class="selectboxclose"></div>
                    
                   </div> 
                   <div id="AGUID_LD" class="control-loader"></div> 
            
                   <div id="AssessmentScrollbar" style="height:250px; width:96%; overflow:auto; margin-top:15px; float:left;">
                        <asp:GridView id="gvAssessmentGuide" runat="server" AutoGenerateColumns="false" CssClass="grid" GridLines="None" AllowPaging="true" PageSize="5" AlternatingRowStyle-CssClass="alt">
                        <Columns>
                            <asp:BoundField DataField="GuideID" HeaderText="ID" />
                            <asp:BoundField DataField="Category" HeaderText="Assessment Category" />
                            <asp:BoundField DataField="Assessment" HeaderText="Assessment Guidline" />
                            <asp:BoundField DataField="Value" HeaderText="Value" />
                            <asp:BoundField DataField="Score" HeaderText="Score" />
                        </Columns>
                        </asp:GridView>
                    </div>            
               </div> 
            </div>
            
            <div style="float:left; width:100%; height:20px; margin-top:30px;">
                <div id="RiskScoreLabel" class="requiredlabel">Risk Score:</div>
                <div id="RiskScoreField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="RSKSCRTxt" runat="server" ReadOnly="true" Width="140px" CssClass="readonly"></asp:TextBox>
                </div> 
                
                <div id="RSKSCR_LD" class="control-loader"></div> 
            </div>

            </div>
        </div>      
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />
    <asp:Button ID="rskcatalias" runat="server" style="display:none" />
    <asp:Button ID="cntralias" runat="server" style="display:none" />
    <asp:Button ID="ppalias" runat="server" style="display:none" />
    <asp:Button ID="timealias" runat="server" style="display:none" />
    <asp:Button ID="costalias" runat="server" style="display:none" />
    <asp:Button ID="qosalias" runat="server" style="display:none" />
    <asp:Button ID="stdcostalias" runat="server" style="display:none" />
    <asp:Button ID="svralias" runat="server" style="display:none" />
    <asp:Button ID="rcalias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="ProbCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="RiskCategoryExtender" runat="server" BehaviorID="RiskCategoryExtender" TargetControlID="rskcatalias" PopupControlID="RiskCategoryPanel" CancelControlID="CATCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>
     
    <ajax:ModalPopupExtender ID="CentreExtender" runat="server" BehaviorID="CentreExtender" TargetControlID="cntralias" PopupControlID="CentrePanel" CancelControlID="CNTRCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="PPExtender" runat="server" BehaviorID="PPExtender" TargetControlID="ppalias" PopupControlID="PercentageProbabilityPanel" CancelControlID="PPCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="TIMPExtender" runat="server" BehaviorID="TIMPExtender" TargetControlID="timealias" PopupControlID="TimeImpactCriteriaPanel" CancelControlID="TIMPCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="CostExtender" runat="server" BehaviorID="CostExtender" TargetControlID="costalias" PopupControlID="CostImpactCriteriaPanel" CancelControlID="CIMPCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="QualityExtender" runat="server" BehaviorID="QualityExtender" TargetControlID="qosalias" PopupControlID="QOSImpactCriteriaPanel" CancelControlID="QOSCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="STDCostExtender" runat="server" BehaviorID="STDCostExtender" TargetControlID="stdcostalias" PopupControlID="STDCostImpactCriteriaPanel" CancelControlID="STDCIMPCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="SVRExtender" runat="server" BehaviorID="SVRExtender" TargetControlID="svralias" PopupControlID="SeverityPanel" CancelControlID="SeverityCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <ajax:ModalPopupExtender ID="RTCRTExtender" runat="server" BehaviorID="RTCRTExtender" TargetControlID="rcalias" PopupControlID="RateCriteriaPanel" CancelControlID="RTCRTCancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
       <div id="probheader" class="modalHeader">Risk Probability Matrix<span id="probclose" class="modalclose" title="Close">X</span></div>
       
       <div id="ProbabilityMatrixTooltip" class="tooltip" style="margin-top:10px;">
            <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p></p>
	   </div>
       
       <div id="ProbabilityMatrixSaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	   </div>

       <div id="Matrixwait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
       </div>

       <table id="matrix" class="table" ></table>
        
       <div class="buttondiv">
            <input id="ProbSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="ProbCancel" type="button" class="button" value="Cancel" />
       </div>  
    </asp:Panel>

    <asp:Panel ID="SeverityPanel" runat="server" CssClass="modalPanel" style="height:250px;">
        <div id="SeverityHeader" class="modalHeader">Create New Severity<span id="SVRclose" class="modalclose" title="Close">X</span></div>
        
        <div id="SeveritySaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
    
        <div id="validation_dialog_severity" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="Severity" />
        </div>    
        
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CriteriaLabel" class="requiredlabel">Criteria</div>
            <div id="CriteriaField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="CRTTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div> 
             <div id="CRITlimit" class="textremaining"></div>   
       
            <asp:RequiredFieldValidator ID="CRTVal" runat="server" Display="None" ControlToValidate="CRTTxt" ErrorMessage="Enter the criteria of the severity" ValidationGroup="Severity"></asp:RequiredFieldValidator> 
            
            <asp:CustomValidator id="CRTTxtFVal" runat="server" ValidationGroup="Severity" 
            ControlToValidate = "CRTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
  
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="SeverityVLabel" class="requiredlabel">Severity Value</div>
            <div id="SeverityVField" class="fielddiv">
                <asp:TextBox ID="SVRVTxt" CssClass="textbox" runat="server"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="SVRVval" runat="server" Display="None" ControlToValidate="SVRVTxt" ErrorMessage="Enter the value of the severity" ValidationGroup="Severity"></asp:RequiredFieldValidator>   
            
            <ajax:FilteredTextBoxExtender ID="SVRVALFExt" runat="server" TargetControlID="SVRVTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>

            <asp:CustomValidator id="SVRVALZVal" runat="server" ValidationGroup="Severity" 
            ControlToValidate = "SVRVTxt" Display="None" ErrorMessage = "The value of the severity should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator>   
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="SeverityScoreLabel" class="requiredlabel">Severity Score</div>
            <div id="SeverityScoreField" class="fielddiv">
                <asp:TextBox ID="SVRSCRTxt" CssClass="textbox" runat="server"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="SVRSCRVal" runat="server" Display="None" ControlToValidate="SVRSCRTxt" ErrorMessage="Enter the score of the severity" ValidationGroup="Severity"></asp:RequiredFieldValidator>   
        
            <asp:RegularExpressionValidator ID="SVRSCRFVal" runat="server" ControlToValidate="SVRSCRTxt"
            Display="None" ErrorMessage="Enter a decimal number (e.g. 22.10)" ValidationExpression="^[0-9]+\.[0-9]{2}$" ValidationGroup="Severity"></asp:RegularExpressionValidator> 
        </div>
        
        <div class="buttondiv">
            <input id="SeveritySave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="SeverityCancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <asp:Panel ID="PercentageProbabilityPanel" runat="server" CssClass="modalPanel">
        <div id="PercentageProbabilityHeader" class="modalHeader">Percentage Probability Values<span id="PPclose" class="modalclose" title="Close">X</span></div>
        
        <div id="PercentageProbabilityTooltip" class="tooltip" style="margin-top:10px;">
            <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p></p>
	    </div>
       
        <div id="PercentageProbabilitySaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="PPwait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>
         
        <div id="table" class="table" style=" margin-top:10px; display:none;">
            <div id="row_header" class="tr">
                <div id="col0_head" class="tdh" style="width:50px;"></div>
                <div id="col1_head" class="tdh" style="width:30%">Risk Probability Criteria</div>
                <div id="col2_head" class="tdh" style="width:30%">Probability Value</div>
            </div>
        </div>
        
        <div class="buttondiv">
            <input id="PPSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="PPCancel" type="button" class="button" value="Cancel" />
        </div>  
    </asp:Panel>

    <asp:Panel ID="RateCriteriaPanel" runat="server" CssClass="modalPanel">
        <div id="RateCriteriaHeader" class="modalHeader">Rate Criteria Details<span id="RTCRTclose" class="modalclose" title="Close">X</span></div>
        
        <div class="toolbox">
            <img id="newrate" src="http://www.qmsrs.com/qmsrstools/Images/new_file.png" class="imgButton" title="Create New Significant Rate Criteria" alt=""/> 
        </div>
            
        <div id="RateCriteriaSaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="RTCRTwait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>
         
        <div id="ratetable" class="table" style=" margin-top:10px; display:none;">
            <div id="rate_row_header" class="tr">
                <div id="rate_col0_head" class="tdh" style="width:50px;"></div>
                <div id="rate_col1_head" class="tdh" style="width:30%">Comparator</div>
                <div id="rate_col2_head" class="tdh" style="width:30%">Rate</div>
                <div id="rate_col3_head" class="tdh" style="width:30%">Description</div>
            </div>
        </div>
        
        <div class="buttondiv">
            <input id="RTCRTSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="RTCRTCancel" type="button" class="button" value="Cancel" />
        </div>  
    </asp:Panel>

    <asp:Panel ID="TimeImpactCriteriaPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="TimeImpactCriteriaHeader" class="modalHeader">Time Impact Criteria<span id="TIMPclose" class="modalclose" title="Close">X</span></div>
  
        <div id="TimeImpactCriteriaSaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <div id="Timewait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>
        
        <div id="time" class="table" style=" margin-top:10px; display:none;">
            <div id="time_row_header" class="tr">
                <div id="time_col0_head" class="tdh" style="width:50px;"></div>
                <div id="time_col1_head" class="tdh" style="width:30%">Risk Criteria</div>
                <div id="time_col2_head" class="tdh" style="width:30%">TIMESCALE (MEASURED AGAINST MILESTONES)</div>
            </div>
        </div>
        
        <div class="buttondiv">
            <input id="TIMPSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="TIMPCancel" type="button" class="button" value="Cancel" />
        </div>  
    </asp:Panel>

    <asp:Panel ID="CostImpactCriteriaPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CostImpactCriteriaHeader" class="modalHeader">Cost of Impact Criteria<span id="CIMPclose" class="modalclose" title="Close">X</span></div>
  
        <div id="CostImpactCriteriaSaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <div id="Costwait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>
        
       <div id="cost" class="table" style=" margin-top:10px; display:none;">
            <div id="cost_row_header" class="tr">
                <div id="cost_col0_head" class="tdh" style="width:50px;"></div>
                <div id="cost_col1_head" class="tdh" style="width:30%">Risk Criteria</div>
                <div id="cost_col2_head" class="tdh" style="width:30%">Budget (EFFORT)</div>
                <div id="cost_col3_head" class="tdh" style="width:30%">Budget (MATERIAL)</div>
            </div>
        </div>
        
        <div class="buttondiv">
            <input id="CIMPSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="CIMPCancel" type="button" class="button" value="Cancel" />
        </div>  
    </asp:Panel>

    <asp:Panel ID="STDCostImpactCriteriaPanel" runat="server" CssClass="modalPanel">
        <div id="STDCostImpactCriteriaHeader" class="modalHeader">Standard Cost of Impact Criteria<span id="STDCIMPclose" class="modalclose" title="Close">X</span></div>
  
        <div id="STDCostImpactCriteriaTooltip" class="tooltip" style="margin-top:10px;">
            <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
            <p></p>
	    </div>

        <div id="STDCostImpactCriteriaSaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <div id="STDCostwait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>
        
       <div id="STDcost" class="table" style=" margin-top:10px; display:none;">
            <div id="STDcost_row_header" class="tr">
                <div id="STDcost_col0_head" class="tdh" style="width:50px;"></div>
                <div id="STDcost_col1_head" class="tdh" style="width:30%">Cost of Impact Criteria</div>
                <div id="STDcost_col2_head" class="tdh" style="width:30%">Standard Cost</div>
            </div>
        </div>
        
        <div class="buttondiv">
            <input id="STDCIMPSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="STDCIMPCancel" type="button" class="button" value="Cancel" />
        </div>  
    </asp:Panel>

    <asp:Panel ID="QOSImpactCriteriaPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="QOSImpactCriteriaHeader" class="modalHeader">Quality of Service Impact Criteria<span id="QOSclose" class="modalclose" title="Close">X</span></div>
  
        <div id="QOSImpactCriteriaSaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <div id="QOSwait" class="loader">
            <div class="waittext">Retrieving Data, Please Wait...</div>
        </div>
        
        <div id="quality" class="table" style=" margin-top:10px; display:none;">
            <div id="quality_row_header" class="tr">
                <div id="quality_col0_head" class="tdh" style="width:50px;"></div>
                <div id="quality_col1_head" class="tdh" style="width:30%">Risk Criteria</div>
                <div id="quality_col2_head" class="tdh" style="width:30%">QOS (Functionality / Availability)</div>
                <div id="quality_col3_head" class="tdh" style="width:30%">QOS (Loss of Benefit)</div>
            </div>
        </div>
     
        <div class="buttondiv">
            <input id="QOSSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="QOSCancel" type="button" class="button" value="Cancel" />
        </div>  
    </asp:Panel>

    <asp:Panel ID="RiskCategoryPanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CategoryHeader" class="modalHeader">Create New Risk Category<span id="CATclose" class="modalclose" title="Close">X</span></div>

        <div id="RiskCategorySaveTooltip" class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_category" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary4" runat="server" CssClass="validator" ValidationGroup="Category" />
        </div>    
        
        <input id="CategoryID" type="hidden" value="" />
      
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CategoryNameLabel" class="requiredlabel">Category Name</div>
            <div id="CategoryNameField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="CATNMTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div> 
             <div id="CATNMlimit" class="textremaining"></div>   
       
            <asp:RequiredFieldValidator ID="CATNMVal" runat="server" Display="None" ControlToValidate="CATNMTxt" ErrorMessage="Enter the name of the risk category" ValidationGroup="Category"></asp:RequiredFieldValidator> 
            
            <asp:CustomValidator id="CATNMTxtFVal" runat="server" ValidationGroup="Category" 
            ControlToValidate = "CATNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RiskCategoryDescriptionLabel" class="labeldiv">Description:</div>
            <div id="RiskCategoryDescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="RSKCATDESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="RSKCATDESCTxtFVal" runat="server" ValidationGroup="Category" 
            ControlToValidate = "RSKCATDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
       </div>

       <div class="buttondiv">
            <input id="CATSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="CATCancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>

    <asp:Panel ID="CentrePanel" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="CostCentre_header" class="modalHeader">Create New Cost Centre<span id="COSTCNTRclose" class="modalclose" title="Close">X</span></div>
        
        <div id="CostCentreSaveTooltip"  class="tooltip">
            <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_centre" class="validationcontainer" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary8" runat="server" CssClass="validator" ValidationGroup="Centre" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CentreNameLabel" class="requiredlabel">Cost Centre Name:</div>
            <div id="CentreNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="CTRNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            <div id="CNTRlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="CTRNMTxtVal" runat="server" Display="None" ControlToValidate="CTRNMTxt" ErrorMessage="Enter the name of the cost centre" ValidationGroup="Centre"></asp:RequiredFieldValidator>  

            <asp:CustomValidator id="CTRNMTxtFVal" runat="server" ValidationGroup="Centre" 
            ControlToValidate = "CTRNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>   
       </div>

     
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OrganizationUnitLabel" class="requiredlabel">ORG. Unit:</div>
            <div id="OrganizationUnitField" class="fielddiv" style="width:300px;">
                <asp:DropDownList ID="CNTRORGCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>    
            <div id="UNIT_LD" class="control-loader"></div>  
            
            <asp:RequiredFieldValidator ID="CNTRORGVal" runat="server" Display="None" ControlToValidate="CNTRORGCBox" ErrorMessage="Select an organization unit" ValidationGroup="Centre"></asp:RequiredFieldValidator>
                    
            <asp:CompareValidator ID="ORGUNTVal" runat="server" ControlToValidate="CNTRORGCBox"
            Display="None" ErrorMessage="Select an organization unit" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Centre"></asp:CompareValidator>
       </div>
        
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ManagerLabel" class="requiredlabel">Manager:</div>
            <div id="ManagerField" class="fielddiv" style="width:300px;">
                <asp:DropDownList ID="MGRCBox" Width="300px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>    
            <div id="MGR_LD" class="control-loader"></div> 
            
            <asp:RequiredFieldValidator ID="MGRCBoxTxtVal" runat="server" Display="None" ControlToValidate="MGRCBox" ErrorMessage="Select a manager" ValidationGroup="Centre"></asp:RequiredFieldValidator>         
            
            <asp:CompareValidator ID="MGRCBoxVal" runat="server" ControlToValidate="MGRCBox"
            Display="None" ErrorMessage="Select a manager" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Centre"></asp:CompareValidator>
       </div>
      
    
       <div class="buttondiv">
            <input id="CNTRSave" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="CNTRCancel" type="button" class="button" value="Cancel" />
       </div>   
    </asp:Panel>
</div>


<asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
    <div style="padding:8px">
        <h2>Saving...</h2>
    </div>
</asp:Panel>

<ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
</ajax:ModalPopupExtender>

<input id="xmlseverity" type="hidden" value="" />
<input id="invoker" type="hidden" value="" />
<input id="severitymode" type="hidden" value="" />


<script type="text/javascript" language="javascript">

    $(function ()
    {
        var emptyPROJ = $("#<%=gvProjects.ClientID%> tr:last-child").clone(true);
        var emptyAGUID = $("#<%=gvAssessmentGuide.ClientID%> tr:last-child").clone(true);

        $("#RiskEstimationGroupDetails").children('.groupbox').each(function ()
        {
            $(this).hide();

            $("#" + $(this).attr('id') + "Header").hide();
        });

        /*Activate the first TAB*/
        resetTab();          

        /*load risk types*/
        loadComboboxAjax('loadRiskType', "#<%=RSKTYPCBox.ClientID%>", "#RSKTYP_LD");

        /*load risk modes*/
        loadComboboxAjax('loadRiskMode', "#<%=RSKMODCBox.ClientID%>", "#RSKMOD_LD");

        /*load risk categories*/
        loadRiskCategory("#<%=RSKCATCBox.ClientID%>");

        /*Obtain the last ID of the risk for reference*/
        loadLastIDAjax('getRiskID', "#<%=RiskNoLbl.ClientID%>");

        /*attach review ID to limit plugin*/
        $("#<%=RiskNoTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

        loadCostCentre('#<%=CSTCNTRCBox.ClientID%>', "#CNTR_LD");

        loadCostCentre('#<%=OCSTCNTRCBox.ClientID%>', "#OCNTR_LD");

        addWaterMarkText('The description of the risk', '#<%=RSKDESCTxt.ClientID%>');

        

        /*Add new HCCAP, OHSAS severity*/
        $("#<%=SVRADD.ClientID%>").bind('click', function ()
        {
            clearModal();

            /*set severity mode to OHSAS so that when saving the severity details, the severity control in OHSAS group will re-load*/
            $("#severitymode").val('OHSAS');

            $("#validation_dialog_severity").hide();

            /*attach criteria file type to limit plugin*/
            $("#<%=CRTTxt.ClientID%>").limit({ id_result: 'CRITlimit', alertClass: 'alertremaining', limit: 90 });

            $("#<%=svralias.ClientID%>").trigger('click');

        });

        /*Add new EMS severity*/
        $("#<%=SVRENADD.ClientID%>").bind('click', function ()
        {
            clearModal();

            /*set severity mode to EMS so that when saving the severity details, the severity controls in EMS group will re-load*/
            $("#severitymode").val('EMS');

            $("#validation_dialog_severity").hide();

            /*attach criteria file type to limit plugin*/
            $("#<%=CRTTxt.ClientID%>").limit({ id_result: 'CRITlimit', alertClass: 'alertremaining', limit: 90 });

            $("#<%=svralias.ClientID%>").trigger('click');

        });

        /*Add new risk category*/
        $("#<%=CATADD.ClientID%>").bind('click', function ()
        {
            clearModal();

            $("#validation_dialog_category").hide();

            /*attach category name to limit plugin*/
            $('#<%=CATNMTxt.ClientID%>').limit({ id_result: 'CATNMlimit', alertClass: 'alertremaining', limit: 90 });

            addWaterMarkText('The description of the risk category', '#<%=RSKCATDESCTxt.ClientID%>');

            $("#<%=rskcatalias.ClientID%>").trigger('click');
        });

        $("#<%=CNTRADD.ClientID%>").bind('click', function () {
            clearModal();

            loadComboboxAjax('getOrganizationUnits', '#<%=CNTRORGCBox.ClientID%>', "#UNIT_LD");

            $('#<%=MGRCBox.ClientID%>').empty();

            /*attach cost centre name to limit plugin*/
            $("#<%=CTRNMTxt.ClientID%>").limit({ id_result: 'CNTRlimit', alertClass: 'alertremaining', limit: 90 });

            $("#<%=cntralias.ClientID%>").trigger('click');

        });

        $("#<%=CNTRORGCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var controls = new Array();
                controls.push('#<%=MGRCBox.ClientID%>');
                loadParamComboboxAjax('getDepEmployees', controls, "'unit':'" + $(this).val() + "'", "#MGR_LD");
            }
        });
        
        $("#<%=PROJSRCH.ClientID%>").bind('click', function (e) {
            $("#<%=FDTTxt.ClientID%>").val('');
            $("#<%=TDTTxt.ClientID%>").val('');

            showProjectDialog(e.pageX, e.pageY, emptyPROJ);

        });

        $("#projcloseBox").bind('click', function () {
            $("#SearchProject").hide('800');
        });

        $("#guidclosebox").bind('click', function () {
            $("#SelectAssessment").hide('800');
        });

        $("#<%=FDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), emptyPROJ);
        });

        $("#<%=TDTTxt.ClientID%>").keyup(function () {
            filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), emptyPROJ);
        });

        $("#<%=FDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), emptyPROJ);
           }
        });

        $("#<%=TDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function (date) {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, emptyPROJ);
            }
        });
        
        $("#deletefilter").bind('click', function ()
        {
            hideAll();
            loadAssessmentGuide(emptyAGUID);
        });

        $("#byACAT").bind('click', function ()
        {
            /*load ISO assessment category*/
            loadComboboxAjax('loadAssessmentCategory', "#<%=ACATFCBox.ClientID%>", "#ACATF_LD");

            $("#AssessmentCategoryContainer").show();
        });

        $("#<%=COMPOPRSelect.ClientID%>").bind('click', function (e)
        {
            /*set value to complexity for operational complexity field*/
            $("#invoker").val("Complexity");

            showAssessmentGuide(e.pageX, e.pageY, emptyAGUID);
        });

        $("#<%=LRRSelect.ClientID%>").bind('click', function (e) {
            /*set value to legal and regularity requirements field*/
            $("#invoker").val("Legal");

            showAssessmentGuide(e.pageX, e.pageY, emptyAGUID);
        });

        $("#<%=NuisanceSelect.ClientID%>").bind('click', function (e) {
            /*set value to Nuisance field*/
            $("#invoker").val("Nuisance");

            showAssessmentGuide(e.pageX, e.pageY, emptyAGUID);
        });

        $("#<%=INTPRTSelect.ClientID%>").bind('click', function (e)
        {
            /*set value to interested parties field*/
            $("#invoker").val("Party");

            showAssessmentGuide(e.pageX, e.pageY, emptyAGUID);
        });

        $("#<%=LINFOSelect.ClientID%>").bind('click', function (e) {
            /*set value to lack of information field*/
            $("#invoker").val("Information");

            showAssessmentGuide(e.pageX, e.pageY, emptyAGUID);
        });

        $("#<%=PLCYISSUSelect.ClientID%>").bind('click', function (e) {
            /*set value to policy issues field*/
            $("#invoker").val("Policy");

            showAssessmentGuide(e.pageX, e.pageY, emptyAGUID);
        });

        $("#<%=ACATFCBox.ClientID%>").change(function () {
            if ($(this).val() != 0)
            {
                filterAssessmentByCategory($(this).val(), emptyAGUID);
            }
        });

        $("#<%=ProjectRB.ClientID%>").click(function ()
        {
            if ($("#project").is(":hidden")) 
            {
                $("#project").stop(true).hide().fadeIn(500, function () 
                {
                    $("#<%=PROJTxt.ClientID%>").val('');
                });
            }
        });

        $("#<%=OrganizationalRB.ClientID%>").click(function () {

            if (!$("#project").is(":hidden"))
                $("#project").hide();
        });

        $("#<%=RSKTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var $obj = $(this);

                /*load probability criteria for all types of risk*/
                loadProbabilityCriteria("#PROB_LD", "#<%=PROBCBox.ClientID%>", $(this).val());

                switch ($(this).val())
                {
                    case "ORI":
                        $("#RiskGeneralEstimationGroup").stop(true).hide().fadeIn(500, function () {
                            loadProbabilityCriteria("#TIMP_LD", "#<%=TIMPCBox.ClientID%>", $obj.val());
                            loadProbabilityCriteria("#QOSIMP_LD", "#<%=QOSIMPCBox.ClientID%>", $obj.val());
                            loadProbabilityCriteria("#CIMP_LD", "#<%=CIMPCBox.ClientID%>", $obj.val());

                            $("#RiskGeneralEstimationGroupHeader").show();

                            resetGroup("#RiskEstimationGroupDetails");

                            $("#project").hide();

                            $("#OHSASHACCPGroupHeader").hide();
                            $("#OHSASHACCPGroup").hide();

                            $("#EMSGroupHeader").hide();
                            $("#EMSGroup").hide();

                            $("#RiskEstimationTooltip").fadeOut();

                            /*set the adjusted cost of impact to zero by default*/
                            $("#<%=ADJIMPCOSTTxt.ClientID%>").val(parseFloat(0).toFixed(2));

                            /*automaitically calculate the adjusted cost exposure value*/
                            var e = jQuery.Event("keydown");
                            e.which = 13; // # Some key code value
                            $("#<%=ADJIMPCOSTTxt.ClientID%>").trigger(e);

                        });
                        break;
                    case "OHSAS":
                    case "HACCP":
                        $("#OHSASHACCPGroup").stop(true).hide().fadeIn(500, function () {

                            $("#OHSASHACCPGroupHeader").show();

                            resetGroup("#RiskEstimationGroupDetails");

                            $("#RiskGeneralEstimationGroupHeader").hide();
                            $("#RiskGeneralEstimationGroup").hide();

                            $("#EMSGroupHeader").hide();
                            $("#EMSGroup").hide();

                            loadSeverity("#SVR_LD","#<%=SVRTCBox.ClientID%>");

                            loadComboboxAjax('loadComparatorOperators', "#<%=OPRCBox.ClientID%>", "#OPR_LD");

                            $("#RiskEstimationTooltip").fadeOut();
                        });
                        break;
                    case "EMS":
                        $("#EMSGroup").stop(true).hide().fadeIn(500, function ()
                        {
                            $("#RiskEstimationTooltip").stop(true).hide().fadeIn(500, function ()
                            {
                                $(this).find('p').html("The significant rating value can be estimated using the following equation: <br/> Rating= Risk Score + Legal/Regulatory Requirements + Nuisance + Interested Parties + Lack of Information + Policy Issues");
                            });
                            resetGroup("#RiskEstimationGroupDetails");
                            /*load severity of impact on env.*/
                            loadSeverity("#SVRENV_LD", "#<%=SVRENVCBox.ClientID%>");

                            /*load severity of impact on human*/
                            loadSeverity("#SVRHUM_LD", "#<%=SVRHUMCBox.ClientID%>");

                            $("#RiskGeneralEstimationGroupHeader").hide();
                            $("#RiskGeneralEstimationGroup").hide();

                            $("#OHSASHACCPGroupHeader").hide();
                            $("#OHSASHACCPGroup").hide();

                            $("#EMSGroupHeader").show();

                            loadComboboxAjax('loadComparatorOperators', "#<%=EMSOPRCbox.ClientID%>", "#EMSOPR_LD");

                        });
                        break;

                }
            }
        });

        /*populate the employees in  owner cbox*/
        $("#<%=ORGUNTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#OWNR_LD");
                $("#SelectORG").hide('800');
            }
        });

        /*obtain probability percentage or value depending on the type of the risk*/
        $("#<%=PROBCBox.ClientID%>").change(function ()
        {
            var $obj = $(this);

            if ($(this).val() != 0)
            {
                var risktype = $("#<%=RSKTYPCBox.ClientID%>").val();
                if (risktype != 0)
                {
                    /*calculate probability percentage*/
                    getProbabilityPercentage("#PROB_LD", $obj.val(), risktype);
                }
                else
                {
                    alert("Please select the type of the risk");

                    /*reset probability combo box*/
                    $(this).val(0);
                }
            }
        });

        /*bind severity score*/
        $("#<%=SVRTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var $combo = $(this);

                if ($("#xmlseverity").val() != '')
                {
                    var xmlSeverity = $.parseXML($("#xmlseverity").val());

                    $(xmlSeverity).find('Severity').each(function (index, severity)
                    {
                        if ($(this).attr('Criteria') == $combo.val())
                        {
                            $("#<%=SVRVALTxt.ClientID%>").val($(this).attr('Score'));
                        }
                    });

                    /*calculate risk score*/
                    calculateRisk();    
                }
            }
        });

        /*bind severity of impact on environment value*/
        $("#<%=SVRENVCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var $combo = $(this);

                if ($("#xmlseverity").val() != '')
                {
                    var xmlSeverity = $.parseXML($("#xmlseverity").val());

                    $(xmlSeverity).find('Severity').each(function (index, severity)
                    {
                        if ($(this).attr('Criteria') == $combo.val())
                        {
                            $("#<%=SVRENVValTxt.ClientID%>").val($(this).attr('Score'));
                        }
                    });

                    /*calculate risk score*/
                    calculateRisk();
                }
            }
        });


        /*bind severity of impact on human value*/
        $("#<%=SVRHUMCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                var $combo = $(this);

                if ($("#xmlseverity").val() != '')
                {
                    var xmlSeverity = $.parseXML($("#xmlseverity").val());

                    $(xmlSeverity).find('Severity').each(function (index, severity)
                    {
                        if ($(this).attr('Criteria') == $combo.val())
                        {
                            $("#<%=SVRHUMValTxt.ClientID%>").val($(this).attr('Score'));
                        }
                    });

                    /*calculate risk score*/
                    calculateRisk();

                }
            }
        });



        $("#<%=ADJIMPCOSTTxt.ClientID%>").keydown(function (event)
        {  
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13')
            {
                var isAdjustedValid = Page_ClientValidate('Adjusted');
                if (isAdjustedValid)
                {

                    var probability = $("#<%=PROBVALTxt.ClientID%>").val() == '' ? 0 : $("#<%=PROBVALTxt.ClientID%>").val();

                    /*calculate the adjusted exposure value, and store it in the adjusted exposure text field*/ 
                    var adjustedexposure = calculateExposure(parseFloat($(this).val()), probability);

                    $("#<%=ADJEXPTxt.ClientID%>").val(adjustedexposure.toFixed(2));
                }
                else
                {
                    alert("Please enter a decimal adjusted cost of impact");
                }
            }
        });
        
        $("#<%=OWNRSelect.ClientID%>").click(function (e)
        {
            showORGDialog(e.pageX, e.pageY);
        });


        $("#<%=REGDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#ProbSave").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true)
            {
                $("#ProbabilityMatrixSaveTooltip").stop(true).hide().fadeIn(500, function () {
                    ActivateSave(false);

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify($("#matrix").matrixtable('getJSON')) + "\'}",
                        url: getServiceURL().concat('uploadProbabilityMatrix'),
                        success: function (data) {
                            $("#ProbabilityMatrixSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                $("#ProbCancel").trigger('click');

                                getProbabilityPercentage("#PROB_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());

                            });
                        },
                        error: function (xhr, status, error) {
                            $("#ProbabilityMatrixSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(xhr.responseText);
                            });
                        }
                    });
                });
            }

        });

        $("#probclose").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#ProbCancel").trigger('click');
            }
        });

        $("#CATclose").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#CATCancel").trigger('click');
            }
        });

        $("#MODclose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#MODCancel").trigger('click');
            }
        });

        $("#PPclose").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#PPCancel").trigger('click');
            }
        });

        $("#COSTCNTRclose").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true)
            {
                $("#CNTRCancel").trigger('click');
            }
        });

        $("#SVRclose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#SeverityCancel").trigger('click');
            }
        });

        $("#RTCRTclose").bind('click', function () {

            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#RTCRTCancel").trigger('click');
            }
        });

        $("#PROBEdit").bind('click', function ()
        {
            loadProbabilityPercentage($("#<%=RSKTYPCBox.ClientID%>").val());
        });

        $("#TIMPEdit").bind('click', function ()
        {
            loadTimeImpactGuidLines($("#<%=RSKTYPCBox.ClientID%>").val());
        });


        $("#TIMPSave").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true) {
                var time = $("#time").table('getJSON');

                $("#TimeImpactCriteriaSaveTooltip").stop(true).hide().fadeIn(500, function () {
                    ActivateSave(false);

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(time) + "\'}",
                        url: getServiceURL().concat('UploadImpactGuidlines'),
                        success: function (data) {
                            $("#TimeImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                $("#TIMPCancel").trigger('click');
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#TimeImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#TIMPclose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#TIMPCancel").trigger('click');
            }
        });

        $("#CIMPEdit").bind('click', function () {
            loadCostImpactGuidLines($("#<%=RSKTYPCBox.ClientID%>").val());
        });


        $("#CIMPSave").bind('click', function () {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true) {
                var cost = $("#cost").table('getJSON');

                $("#CostImpactCriteriaSaveTooltip").stop(true).hide().fadeIn(500, function () {
                    ActivateSave(false);

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(cost) + "\'}",
                        url: getServiceURL().concat('UploadImpactGuidlines'),
                        success: function (data) {
                            $("#CostImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                $("#CIMPCancel").trigger('click');
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#CostImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });


        $("#CIMPclose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#CIMPCancel").trigger('click');
            }
        });


        $("#SGNRAT_Help").bind('click', function ()
        {
            loadSignificantRatingCriteria();
        });

        $("#newrate").bind('click', function ()
        {
            $("#ratetable").table('addRow',
            {
                Comparator: '',
                Rate: '',
                Description: '',
                Status: 3
            });
        });

        $("#RTCRTSave").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true)
            {
                var rate = $("#ratetable").table('getJSON');

                $("#RateCriteriaSaveTooltip").stop(true).hide().fadeIn(500, function ()
                {
                    ActivateSave(false);

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(rate) + "\'}",
                        url: getServiceURL().concat('UploadRateCriteria'),
                        success: function (data)
                        {
                            $("#RateCriteriaSaveTooltip").fadeOut(500, function ()
                            {
                                ActivateSave(true);

                                $("#RTCRTCancel").trigger('click');
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#RateCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#QOSIMPEdit").bind('click', function () {
            loadQOSImpactGuidLines($("#<%=RSKTYPCBox.ClientID%>").val());
        });



        $("#QOSSave").bind('click', function () {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true) {
                var quality = $("#quality").table('getJSON');

                $("#QOSImpactCriteriaSaveTooltip").stop(true).hide().fadeIn(500, function () {
                    ActivateSave(false);

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(quality) + "\'}",
                        url: getServiceURL().concat('UploadImpactGuidlines'),
                        success: function (data) {
                            $("#QOSImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                $("#QOSCancel").trigger('click');
                            });
                        },
                        error: function (xhr, status, error) {
                            $("#QOSImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });


        $("#QOSclose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#QOSCancel").trigger('click');
            }
        });


       
        $("#STDIMPEdit").bind('click', function ()
        {
            loadSTDCostImpactGuidLines($("#<%=RSKTYPCBox.ClientID%>").val());
        });

        $("#STDCIMPSave").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true)
            {
                var stdcost = $("#STDcost").table('getJSON');

                $("#STDCostImpactCriteriaSaveTooltip").stop(true).hide().fadeIn(500, function ()
                {
                    ActivateSave(false);

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(stdcost) + "\'}",
                        url: getServiceURL().concat('UploadSTDCostImpactGuidlines'),
                        success: function (data) {
                            $("#STDCostImpactCriteriaSaveTooltip").fadeOut(500, function ()
                            {
                                ActivateSave(true);

                                $("#STDCIMPCancel").trigger('click');

                                setStandardCost($("#<%=CIMPCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());

                            });
                        },
                        error: function (xhr, status, error) {
                            $("#STDCostImpactCriteriaSaveTooltip").fadeOut(500, function () {
                                ActivateSave(true);

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#STDCIMPclose").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#STDCIMPCancel").trigger('click');
            }
        });

        $("#newCriteria").click(function ()
        {
            $("#table").table('addRow',
            {
                Probability: 0,
                Criteria: '',
                Status: 3
            });
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        /*obtain the probability of the time impact criteria*/
        $("#<%=TIMPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                if ($("#<%=PROBCBox.ClientID%>").val() != 0)
                {
                    calculateImpactProbability("#<%=TPROBTxt.ClientID%>","#TIMP_LD", $("#<%=PROBCBox.ClientID%>").val(), $(this).val());
                }
            }
        });


        /*obtain the probability of the QOS impact criteria*/
        $("#<%=QOSIMPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                if ($("#<%=PROBCBox.ClientID%>").val() != 0)
                {
                    calculateImpactProbability("#<%=QOSPROBTxt.ClientID%>", "#QOSIMP_LD", $("#<%=PROBCBox.ClientID%>").val(), $(this).val());
                }
            }
        });

        $("#<%=CIMPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                /*get the standard cost*/
                setStandardCost($(this).val(), $("#<%=RSKTYPCBox.ClientID%>").val());

                if ($("#<%=PROBCBox.ClientID%>").val() != 0)
                {
                    calculateImpactProbability("#<%=CPROBTxt.ClientID%>", "#CIMP_LD", $("#<%=PROBCBox.ClientID%>").val(), $(this).val());
                }
            }
        });


        $("#SeveritySave").bind('click', function ()
        {
            var isGeneralValid = Page_ClientValidate('Severity');
            if (isGeneralValid) {
                if (!$("#validation_dialog_severity").is(":hidden")) {
                    $("#validation_dialog_severity").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {
                    $("#SeveritySaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        var severity =
                        {
                            Criteria: $("#<%=CRTTxt.ClientID%>").val(),
                            SeverityValue: $("#<%=SVRVTxt.ClientID%>").val(),
                            Score: $("#<%=SVRSCRTxt.ClientID%>").val()
                        }
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(severity) + "\'}",
                            url: getServiceURL().concat("createSeverity"),
                            success: function (data) {
                                $("#SeveritySaveTooltip").fadeOut(500, function ()
                                {
                                    ActivateSave(true);

                                    $("#SeverityCancel").trigger('click');
                                    
                                    switch ($("#severitymode").val())
                                    {

                                        case "OHSAS":
                                            loadSeverity("#SVR_LD", "#<%=SVRTCBox.ClientID%>");
                                            break;
                                        case "EMS":
                                            /*load severity of impact on env.*/
                                            loadSeverity("#SVRENV_LD", "#<%=SVRENVCBox.ClientID%>");

                                            /*load severity of impact on human*/
                                            loadSeverity("#SVRHUM_LD", "#<%=SVRHUMCBox.ClientID%>");
                                            break;
                                    }

                                });
                            },
                            error: function (xhr, status, error) {
                                $("#SeveritySaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);

                                });
                            }
                        });
                    });

                }
            }
            else {
                $("#validation_dialog_severity").stop(true).hide().fadeIn(500, function () {
                    
                });
            }

        });

        $("#PPSave").bind('click', function ()
        {
            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true)
            {
                $("#PercentageProbabilitySaveTooltip").stop(true).hide().fadeIn(500, function ()
                {
                    ActivateSave(false);

                    var json = $("#table").table('getJSON');

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json",
                        dataType: "json",
                        data: "{\'json\':\'" + JSON.stringify(json) + "\'}",
                        url: getServiceURL().concat('uploadProbabilityValues'),
                        success: function (data)
                        {
                            $("#PercentageProbabilitySaveTooltip").fadeOut(500, function ()
                            {
                                ActivateSave(true);

                                $("#PPCancel").trigger('click');

                                getProbabilityPercentage("#PROB_LD", $("#<%=PROBCBox.ClientID%>").val(), $("#<%=RSKTYPCBox.ClientID%>").val());

                            });

                        },
                        error: function (xhr, status, error)
                        {
                            $("#PercentageProbabilitySaveTooltip").fadeOut(500, function ()
                            {
                                ActivateSave(true);

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            });
                        }
                    });
                });
            }
        });

        $("#tabul li").bind("click", function ()
        {
            navigate($(this).attr("id"));
        });

        $("#TPROB_Help").click(function ()
        {
            $("#ProbabilityMatrixTooltip").stop(true).hide().fadeIn(800, function ()
            {
                $(this).find('p').text("The below matrix represents the cost, time, and QOS impact probability percentage, which can be determined by the criteria of the probability in the first column and the criteria of one of the impacts in the first row.");
            });

            /*trigger popup modal pane*/
            $("#<%=alias.ClientID%>").trigger('click');

            $("#Matrixwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                var html = '';
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'risktype':'" + $("#<%=RSKTYPCBox.ClientID%>").val() + "'}",
                    url: getServiceURL().concat('loadProbabilityMatrix'),
                    success: function (data)
                    {
                        $("#Matrixwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var json = $.parseJSON(data.d);

                            $("#matrix").matrixtable({ JSON: json, Width: 30 });
                        });

                    },
                    error: function (xhr, status, error)
                    {
                        $("#Matrixwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        });

        /*save a new cost centre*/
        $("#CNTRSave").click(function ()
        {
            var isCentreValid = Page_ClientValidate('Centre');
            if (isCentreValid)
            {
                if (!$("#validation_dialog_centre").is(":hidden"))
                {
                    $("#validation_dialog_centre").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#CostCentreSaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        var costcentre =
                        {
                            CostCentreName: $("#<%=CTRNMTxt.ClientID%>").val(),
                            ORGUnit: $("#<%=CNTRORGCBox.ClientID%>").val(),
                            Manager: $("#<%=MGRCBox.ClientID%>").val()
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(costcentre) + "\'}",
                            url: getServiceURL().concat('createCostCentre'),
                            success: function (data) {
                                $("#CostCentreSaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    $("#CNTRCancel").trigger('click');

                                    loadCostCentre('#<%=CSTCNTRCBox.ClientID%>', "#CNTR_LD");
                                    loadCostCentre('#<%=OCSTCNTRCBox.ClientID%>', "#OCNTR_LD");

                                });
                            },
                            error: function (xhr, status, error) {
                                $("#CostCentreSaveTooltip").fadeOut(500, function () {
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
                $("#validation_dialog_centre").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
        });

       
        /*save a new risk category*/
        $("#CATSave").bind('click', function () 
        {
            var isCategoryValid = Page_ClientValidate('Category');
            if (isCategoryValid)
            {
                if (!$("#validation_dialog_category").is(":hidden")) {
                    $("#validation_dialog_category").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true) {
                    $("#RiskCategorySaveTooltip").stop(true).hide().fadeIn(500, function () {
                        ActivateSave(false);

                        var category =
                        {
                            CategoryName: $("#<%=CATNMTxt.ClientID%>").val(),
                            Description: $("#<%=RSKCATDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RSKCATDESCTxt.ClientID%>").val())
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(category) + "\'}",
                            url: getServiceURL().concat('createNewRiskCategory'),
                            success: function (data) {
                                $("#RiskCategorySaveTooltip").fadeOut(500, function () {
                                    ActivateSave(true);

                                    $("#CATCancel").trigger('click');

                                    /*load risk categories*/
                                    loadRiskCategory("#<%=RSKCATCBox.ClientID%>");

                                });
                            },
                            error: function (xhr, status, error) {
                                $("#RiskCategorySaveTooltip").fadeOut(500, function ()
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
            else {
                $("#validation_dialog_category").stop(true).hide().fadeIn(500, function () {
                    
                });
            }
            
        });


        $("#save").bind('click', function ()
        {
            var isDetailsValid = Page_ClientValidate('Details');
            if (isDetailsValid)
            {
                if (!$("#validation_dialog_details").is(":hidden"))
                {
                    $("#validation_dialog_details").hide();
                }

                var isRiskEstimationValue = Page_ClientValidate('Probability');
                if (isRiskEstimationValue)
                {

                    var registeredDateParts = $("#<%=REGDTTxt.ClientID%>").val().split("/");

                    //set the default values of the risk JSON object
                    var risk =
                    {
                        RiskNo: $("#<%=RiskNoTxt.ClientID%>").val(),
                        RiskType: $("#<%=RSKTYPCBox.ClientID%>").val(),
                        RiskMode: $("#<%=RSKMODCBox.ClientID%>").val(),
                        RiskCategory: $("#<%=RSKCATCBox.ClientID%>").val(),
                        RiskName: $("#<%=RSKNMTxt.ClientID%>").val(),
                        Description: $("#<%=RSKDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RSKDESCTxt.ClientID%>").val()),
                        RegisterDate: new Date(registeredDateParts[2], (registeredDateParts[1] - 1), registeredDateParts[0]),
                        RiskProbability: $("#<%=PROBCBox.ClientID%>").val(),
                        Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                        ProjectName: '',
                        TimeImpact: '',
                        CostImpact: '',
                        QOSImpact: '',
                        CostCentre1: '',
                        CostCentre2: '',
                        AdjustedCostImpact: parseFloat(0),
                        Severity: '',
                        LimitSign: '',
                        CriticalLimit: parseFloat(0),
                        Score: parseFloat(0),
                        SeverityHuman: '',
                        SeverityEnvironment: '',
                        OperationalComplexity: '',
                        Nusiance: '',
                        Regularity: '',
                        InterestedParties: '',
                        LackInformation: '',
                        PolicyIssue: '',
                        SIR:-1

                    }

                    var risktype = $("#<%=RSKTYPCBox.ClientID%>").val();
                    switch (risktype)
                    {
                        case "ORI":
                            var isRiskValid = Page_ClientValidate('Risk');
                            if (isRiskValid)
                            {
                                if (!$("#validation_dialog_risk").is(":hidden"))
                                {
                                    $("#validation_dialog_risk").hide();
                                }

                                //adjust ORI JSON attribute values
                                risk.TimeImpact = $("#<%=TIMPCBox.ClientID%>").val();
                                risk.CostImpact = $("#<%=CIMPCBox.ClientID%>").val();
                                risk.QOSImpact = $("#<%=QOSIMPCBox.ClientID%>").val();
                                risk.CostCentre1 = ($("#<%=CSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=CSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=CSTCNTRCBox.ClientID%>").val();
                                risk.CostCentre2 = ($("#<%=OCSTCNTRCBox.ClientID%>").val() == 0 || $("#<%=OCSTCNTRCBox.ClientID%>").val() == null) ? '' : $("#<%=OCSTCNTRCBox.ClientID%>").val();
                                risk.AdjustedCostImpact = parseFloat($("#<%=ADJIMPCOSTTxt.ClientID%>").val());
                                risk.Score = parseFloat($("#<%=RSKSCRTxt.ClientID%>").val());

                                if ($("#<%=ProjectRB.ClientID%>").is(':checked'))
                                {
                                    var isProjectValid = Page_ClientValidate('Project');
                                    if (!isProjectValid) {
                                        alert("Please select the name of the project");
                                        navigate('Probability');
                                    }
                                    else {
                                        //set the name of the project in the above JSON data
                                        risk.ProjectName = $("#<%=PROJTxt.ClientID%>").val();
                                    }

                                }
                                else
                                {
                                    risk.ProjectName = '';
                                }

                                saveRisk(JSON.stringify(risk));
                            }
                            else
                            {
                                $("#validation_dialog_risk").stop(true).hide().fadeIn(500, function ()
                                {
                                    navigate('Probability');
                                });
                            }

                            break;

                        case "OHSAS":
                        case "HACCP":
                            var isOHSASHACCPValid = Page_ClientValidate('OHSASHACCP');
                            if (isOHSASHACCPValid)
                            {
                                if (!$("#validation_dialog_ohsashaccp").is(":hidden"))
                                {
                                    $("#validation_dialog_ohsashaccp").hide();
                                }

                                risk.Severity = $("#<%=SVRTCBox.ClientID%>").val();
                                risk.LimitSign = $("#<%=OPRCBox.ClientID%>").val();
                                risk.CriticalLimit = parseFloat($("#<%=LMTTxt.ClientID%>").val());
                                risk.Score = parseFloat($("#<%=RSKSCRTxt.ClientID%>").val());

                                saveRisk(JSON.stringify(risk));
                            }
                            else
                            {
                                $("#validation_dialog_ohsashaccp").stop(true).hide().fadeIn(500, function ()
                                {
                                    navigate('Probability');
                                });
                            }
                            break;

                        case "EMS":
                            var isEMSValid = Page_ClientValidate('EMS');
                            if (isEMSValid)
                            {
                                if (!$("#validation_dialog_ems").is(":hidden"))
                                {
                                    $("#validation_dialog_ems").hide();
                                }

                                risk.LimitSign = $("#<%=EMSOPRCbox.ClientID%>").val();
                                risk.CriticalLimit = parseFloat($("#<%=EMSLMTTxt.ClientID%>").val());
                                risk.SeverityHuman = $("#<%=SVRHUMCBox.ClientID%>").val();
                                risk.SeverityEnvironment = $("#<%=SVRENVCBox.ClientID%>").val();
                                risk.OperationalComplexity = $("#<%=COMPOPRDSCTxt.ClientID%>").val();
                                risk.LackInformation = $("#<%=LINFODSCTxt.ClientID%>").val();
                                risk.Nusiance = $("#<%=NuisanceDSCTxt.ClientID%>").val();
                                risk.Regularity = $("#<%=LRRDSCTxt.ClientID%>").val();
                                risk.InterestedParties = $("#<%=INTPRTDSCTxt.ClientID%>").val();
                                risk.PolicyIssue = $("#<%=PLCYISSUDSCTxt.ClientID%>").val();
                                risk.Score = parseFloat($("#<%=RSKSCRTxt.ClientID%>").val());
                                risk.SIR = parseFloat($("#<%=SGNRATTxt.ClientID%>").val());

                                saveRisk(JSON.stringify(risk));
                            }
                            else
                            {
                                $("#validation_dialog_ems").stop(true).hide().fadeIn(500, function ()
                                {
                                    navigate('Probability');
                                });
                            }

                            break;
                    }


                }
                else
                {
                    alert("Please select the risk probability percentage");
                    navigate('Probability');
                }
            }
            else
            {
                $("#validation_dialog_details").stop(true).hide().fadeIn(500, function ()
                {
                    navigate('Details');
                });
            }


        });
    });

    function saveRisk(json)
    {
        var result = confirm("Are you sure you would like to submit changes?");
        if (result == true) {
            $find('<%= SaveExtender.ClientID %>').show();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{\'json\':\'" + json + "\'}",
                url: getServiceURL().concat('createNewRisk'),
                success: function (data) {
                    $find('<%= SaveExtender.ClientID %>').hide();

                    alert(data.d);

                    reset();

                    resetGroup('.tabcontent');


                    if (!$("#<%=RSKDESCTxt.ClientID%>").hasClass("watermarktext")) {
                        addWaterMarkText('Additional details in the support of the document', '#<%=RSKDESCTxt.ClientID%>');
                    }

                    
                    /*Obtain the last ID of the risk for reference*/
                    loadLastIDAjax('getRiskID', "#<%=RiskNoLbl.ClientID%>");

                    
                    if (!$("#project").is(":hidden"))
                    {
                        $("#project").hide();
                    }

                    navigate('Details');


                },
                error: function (xhr, status, error) {
                    $find('<%= SaveExtender.ClientID %>').hide();

                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
    }

    function loadSeverity(loader,control)
    {
        $(loader).stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadSeverity"),
                success: function (data)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        if (data)
                        {
                            /*Parse xml data and load severity cbox*/
                            loadComboboxXML($.parseXML(data.d), 'Severity', 'Criteria', control);


                            /*Temporarly store the severity xml list*/
                            $("#xmlseverity").val(data.d);
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

    
    function setStandardCost(criteria,risktype)
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'risktype':'" + risktype + "'}",
            url: getServiceURL().concat("loadSTDCostImpactGuidLines"),
            success: function (data)
            {
                if (data)
                {
                    var json = $.parseJSON(data.d);

                    var stdcost = 0;

                    $(json).each(function (index, value)
                    {
                        if (value["RiskCriteria"] == criteria)
                        {
                            stdcost = parseFloat(value["STDCost"]);
                            $("#<%=STDIMPCOSTTxt.ClientID%>").val(stdcost.toFixed(2));

                            return false;
                        }
                    });

                    /*determine risk cost exposure*/

                    var probability = $("#<%=PROBVALTxt.ClientID%>").val() == '' ? 0 : $("#<%=PROBVALTxt.ClientID%>").val();

                    var exposure = calculateExposure(stdcost, probability);

                    $("#<%=STDEXPTxt.ClientID%>").val(exposure.toFixed(2));
                }
            },
            error: function (xhr, status, error)
            {
                var r = jQuery.parseJSON(xhr.responseText);
                alert(xhr.responseText);
            }
        });
    }

    function calculateExposure(stdcost, probability)
    {
        probability = probability / 100; //for example, if the probability is 8% then the desired value is 0.08

        return stdcost * probability;
    }

    function getProbabilityPercentage(loader,criteria,risktype)
    {
        $(loader).stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadProbability"),
                success: function (data)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var json = $.parseJSON(data.d);

                            switch (risktype) {

                                case "ORI":
                                    /*calculate probability percentage*/
                                    $(json).each(function (index, value) {
                                        if (value["Criteria"] == criteria)
                                        {
                                            $("#<%=PROBVALTxt.ClientID%>").val(parseFloat(value["Probability"]).toFixed(2));

                                            /*re-calculate time, cost, and QOS impact cost*/ 
                                            $("#<%=QOSIMPCBox.ClientID%>").trigger('change');
                                            $("#<%=TIMPCBox.ClientID%>").trigger('change');
                                            $("#<%=CIMPCBox.ClientID%>").trigger('change');

                                            return false;
                                        }
                                    });
                                    break;
                                case "OHSAS":
                                case "HACCP":
                                    /*calculate probability percentage*/
                                    $(json).each(function (index, value)
                                    {
                                        if (value["Criteria"] == criteria) {
                                            $("#<%=PROBVALTxt.ClientID%>").val(parseFloat(value["Probability"]).toFixed(2));

                                            /*calculate risk score*/
                                            calculateRisk();
                                            return false;
                                        }
                                    });

                                    break;
                                case "EMS":
                                    $(json).each(function (index, value) {
                                        if (value["Criteria"] == criteria)
                                        {
                                            $("#<%=PROBVALTxt.ClientID%>").val(parseFloat(value["Probability"]).toFixed(2));

                                            /*calculate risk score*/
                                            calculateRisk();
                                            return false;
                                        }
                                    });
                                    break;
                            }
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $(loader).fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);

                        /*clear probability percentage text*/
                        $("#<%=PROBVALTxt.ClientID%>").val('');
                    });
                }
            });
        });
    }

    function loadSTDCostImpactGuidLines(risktype)
    {
        $("#<%=stdcostalias.ClientID%>").trigger('click');


        $("#STDCostImpactCriteriaTooltip").stop(true).hide().fadeIn(800, function ()
        {
            $(this).find('p').text("The below table represents the predefined values of the standard cost, where by default, each value is set to zero indicating that the value for a certain cost of impact criteria might be assigned automatically and not being added in the system yet.");
        });

        $("#STDCostwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadSTDCostImpactGuidLines"),
                success: function (data)
                {
                    $("#STDCostwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var json = $.parseJSON(data.d);

                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("STDCost");

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));

                            $("#STDcost").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#STDCostwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function loadTimeImpactGuidLines(risktype)
    {
        $("#<%=timealias.ClientID%>").trigger('click');

        $("#Timewait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadTimeImpactGuidLines"),
                success: function (data)
                {
                    $("#Timewait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var json = $.parseJSON(data.d);
                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("Description1");

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));

                            $("#time").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#Timewait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadCostImpactGuidLines(risktype)
    {
        $("#<%=costalias.ClientID%>").trigger('click');

        $("#Costwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadCostImpactGuidLines"),
                success: function (data) {
                    $("#Costwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("Description1");
                            attributes.push("Description2");

                            var json = $.parseJSON(data.d);

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));
                            settings.push(JSON.stringify({}));

                            $("#cost").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#Costwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadSignificantRatingCriteria()
    {
        $("#<%=rcalias.ClientID%>").trigger('click');

        $("#RTCRTwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskRateCriteria"),
                success: function (data) {
                    $("#RTCRTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var attributes = new Array();
                            attributes.push("Comparator");
                            attributes.push("Rate");
                            attributes.push("Description");

                            var json = $.parseJSON(data.d);

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ type: 'select', loadurl: getServiceURL().concat("loadComparatorOperators") }));
                            settings.push(JSON.stringify({}));
                            settings.push(JSON.stringify({}));

                            $("#ratetable").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RTCRTwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });

    }

    function loadQOSImpactGuidLines(risktype)
    {
        $("#<%=qosalias.ClientID%>").trigger('click');

        $("#QOSwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadQOSImpactGuidLines"),
                success: function (data) {
                    $("#QOSwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("Description1");
                            attributes.push("Description2");

                            var json = $.parseJSON(data.d);

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));
                            settings.push(JSON.stringify({}));

                            $("#quality").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#QOSwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProbabilityPercentage(risktype)
    {
        $("#<%=ppalias.ClientID%>").trigger('click');

        $("#PercentageProbabilityTooltip").stop(true).hide().fadeIn(800, function ()
        {
            $(this).find('p').text("The below table represents the predefined percentage values of the probability, where by default, the percentage is zero indicating that the value for a certain risk criteria might be assigned automatically and not being added in the system yet");
        });

        $("#PPwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadProbability"),
                success: function (data)
                {
                    $("#PPwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            var attributes = new Array();
                            attributes.push("Criteria");
                            attributes.push("Probability");

                            var json = $.parseJSON(data.d);

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));

                            $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#PPwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProbabilityCriteria(loader,control,risktype)
    {
        $(loader).stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("filterCriteriaByRiskType"),
                success: function (data)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        if (data)
                        {
                            loadComboboxXML($.parseXML(data.d), 'RiskCriteria', 'Criteria', $(control));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $(loader).fadeOut(500, function ()
                    {
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 300, top: y - 170 });
        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
        $("#SelectORG").show();
    }

    function loadCostCentre(control, loader)
    {
        $(loader).stop(true).hide().fadeIn(500, function () {
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadCostCentres"),
                success: function (data) {
                    $(loader).fadeOut(500, function () {

                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'CostCentre', 'CostCentreName', $(control));
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

   
    function loadRiskCategory(control) {

        $("#RSKCAT_LD").stop(true).hide().fadeIn(500, function () {

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadRiskCategory"),
                success: function (data) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
                    
                        if (data) {
                            loadComboboxXML($.parseXML(data.d), 'Category', 'CategoryName', $(control));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#RSKCAT_LD").fadeOut(500, function () {
                    
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function resetTab()
    {
        //clear previously activated tabs
        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        //bind to the first tab
        $("#tabul li").removeClass("ctab");
        $("#Details").addClass("ctab");
        $("#DetailsTB").css('display', 'block');

        
    }

    function clearModal()
    {
        resetGroup(".modalPanel");
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

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function calculateImpactProbability(control,loader, probability, impact)
    {
        /*locate both impact and probability criterias*/
        /*The matrix is designed such that the probability criteria values are located 
        in the first column of the matrix, where the impact values are located in the first row of the matrix*/

        /*according to the matrix, the desired value is located in p(Xp,Yi)*/

        $(loader).stop(true).hide().fadeIn(500, function () {

            $.ajax(
                 {
                     type: "POST",
                     contentType: "application/json",
                     dataType: "json",
                     data: "{'risktype':'" + $("#<%=RSKTYPCBox.ClientID%>").val() + "'}",
                     url: getServiceURL().concat('loadProbabilityMatrix'),
                     success: function (data)
                     {
                         $(loader).fadeOut(500, function ()
                         {
                             $(".modulewrapper").css("cursor", "default");

                             var json = $.parseJSON(data.d);
                             var xp = 0;
                             var yi = 0;

                             $(json).each(function (index, value)
                             {
                                 if (parseInt(value["Y"]) == 0)
                                 {
                                     if (value["Value"] == probability)
                                     {
                                         xp = parseInt(value["X"]);
                                     }
                                 }
                                 else if (parseInt(value["X"]) == 0)
                                 {
                                     if (value["Value"] == impact)
                                     {
                                         yi = parseInt(value["Y"]);
                                     }
                                 }
                             });

                             var desiredprobability = locateMatrixValue(data.d, xp, yi);
                             $(control).val(desiredprobability.toFixed(2));

                             /*calculate risk score*/
                             calculateRisk();


                         });
                     },
                     error: function (xhr, status, error) {
                         $(loader).fadeOut(500, function () {
                             $(".modulewrapper").css("cursor", "default");

                             var r = jQuery.parseJSON(xhr.responseText);
                             alert(r.Message);
                         });
                     }
                 });
        });

    }

    function locateMatrixValue(jsondata,x, y)
    {

        var desired = 0;

        var json = $.parseJSON(jsondata);

        $(json).each(function (index, value)
        {
            if (parseInt(value["X"]) == x && parseInt(value["Y"]) == y)
            {
                desired = parseFloat(value["Value"]);
            }
        });

        return desired;
    }

    function calculateRisk()
    {
        var parameter = {};

        var riskscore = 0;
        var risktype = $("#<%=RSKTYPCBox.ClientID%>").val();

        switch (risktype)
        {
            case "ORI":
                parameter =
                {
                    TimeImpact: $("#<%=TPROBTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=TPROBTxt.ClientID%>").val()),
                    CostImpact: $("#<%=CPROBTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=CPROBTxt.ClientID%>").val()),
                    QOSImpact: $("#<%=QOSPROBTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=QOSPROBTxt.ClientID%>").val())
                }


                getRiskScore(JSON.stringify(parameter), risktype);
                break;

            case "OHSAS":
            case "HACCP":
                parameter =
                {
                    Severity: $("#<%=SVRVALTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=SVRVALTxt.ClientID%>").val()),
                    Probability: $("#<%=PROBVALTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=PROBVALTxt.ClientID%>").val()),
                }

                getRiskScore(JSON.stringify(parameter), risktype);
                break;
            case "EMS":
                
                parameter =
                {
                    SeverityHuman: $("#<%=SVRHUMValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=SVRHUMValTxt.ClientID%>").val()),
                    SeverityEnvironment: $("#<%=SVRENVValTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=SVRENVValTxt.ClientID%>").val()),
                    Probability: $("#<%=PROBVALTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=PROBVALTxt.ClientID%>").val()),
                    Complexity: $("#<%=COMPOPRTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=COMPOPRTxt.ClientID%>").val())
                }

                getRiskScore(JSON.stringify(parameter), risktype);
                break;

        }
    }

    function getRiskScore(parameter, risktype)
    {
        var score = 0;

        $("#RSKSCR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $.ajax(
            {
                type: "POST",
                url: "http://www.qmsrs.com/qmsrstools/FormulaHandler.ashx?param=" + parameter + "&risktype=" + risktype,
                dataType: "HTML",
                success: function (data)
                {
                    $("#RSKSCR_LD").fadeOut(500, function ()
                    {
                        score = parseFloat(data);

                        $("#<%=RSKSCRTxt.ClientID%>").val(parseFloat(score).toFixed(2));

                        if (risktype == "EMS")
                        {
                            var rating =
                            {
                                LegalRegularity: $("#<%=LRRTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=LRRTxt.ClientID%>").val()),
                                Nuisance: $("#<%=NuisanceTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=NuisanceTxt.ClientID%>").val()),
                                Parties: $("#<%=INTPRTTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=INTPRTTxt.ClientID%>").val()),
                                Information: $("#<%=LINFOTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=LINFOTxt.ClientID%>").val()),
                                Policy: $("#<%=PLCYISSUTxt.ClientID%>").val() == '' ? 0 : parseFloat($("#<%=PLCYISSUTxt.ClientID%>").val()),
                                Score:score
                            }

                            calculateSignificantRating(JSON.stringify(rating));
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#RSKSCR_LD").fadeOut(500, function () {

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function calculateSignificantRating(json)
    {
        var jsonparam = $.parseJSON(json);

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: "{'score':'" + parseFloat(jsonparam.Score) + "'}",
            url: getServiceURL().concat("getRiskScoreRating"),
            success: function (data)
            {
                var ratingscore = parseInt(data.d) + jsonparam.LegalRegularity + jsonparam.Nuisance + jsonparam.Parties + jsonparam.Information + jsonparam.Policy;

                $("#<%=SGNRATTxt.ClientID%>").val(ratingscore);

            },
            error: function (xhr, status, error) {
                var r = jQuery.parseJSON(xhr.responseText);
                alert(xhr.responseText);
            }
        });

    }

    function showAssessmentGuide(x, y, empty)
    {
        $("#SelectAssessment").css({ left: x - 500, top: y - 170 });
        loadAssessmentGuide(empty);
        $("#SelectAssessment").show();
    }

    function filterAssessmentByCategory(category, empty)
    {
        $("#AGUID_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'category':'" + category + "'}",
                url: getServiceURL().concat("filterloadISO14001GuideByCategory"),
                success: function (data) {
                    $("#AGUID_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadAssessmentGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#AGUID_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
    function loadAssessmentGuide(empty)
    {
        $("#AGUID_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("loadISO14001Guide"),
                success: function (data) {
                    $("#AGUID_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        loadAssessmentGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#AGUID_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadProjects(empty) {
        $("#PROJFLTR_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadProjects'),
                success: function (data) {
                    $("#PROJFLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            loadProjectGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJFLTR_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }


    function filterByDateRange(start, end, empty) {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true) {
            $("#PROJFLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                var dateparam =
                {
                    StartDate: plannedstartdate,
                    EndDate: plannedenddate
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(dateparam) + "\'}",
                    url: getServiceURL().concat('filterProjectsByDate'),
                    success: function (data) {
                        $("#PROJFLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadProjectGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#PROJFLTR_LD").fadeOut(500, function () {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }

    function loadAssessmentGridView(data, empty)
    {
        var xmlGuidline = $.parseXML(data);

        var row = empty;

        $("#<%=gvAssessmentGuide.ClientID%> tr").not($("#<%=gvAssessmentGuide.ClientID%> tr:first-child")).remove();

        $(xmlGuidline).find("ISO14001Guide").each(function (index, value)
        {
            $("td", row).eq(0).html($(this).attr("GuideID"));
            $("td", row).eq(1).html($(this).attr("Category"));
            $("td", row).eq(2).html($(this).attr("Guideline"));
            $("td", row).eq(3).html($(this).attr("Value"));
            $("td", row).eq(4).html(parseFloat($(this).attr("Score")).toFixed(2));

            $("#<%=gvAssessmentGuide.ClientID%>").append(row);
            row = $("#<%=gvAssessmentGuide.ClientID%> tr:last-child").clone(true);

        });


        $("#<%=gvAssessmentGuide.ClientID%> tr").not($("#<%=gvAssessmentGuide.ClientID%> tr:first-child")).bind('click', function ()
        {
            $("#SelectAssessment").hide('800');

            //set the value and the name of the ISO 14001 assessment guideline
            switch ($("#invoker").val())
            {
                case "Complexity":
                    $("#<%=COMPOPRTxt.ClientID%>").val($("td", $(this)).eq(4).html());
                    $("#<%=COMPOPRDSCTxt.ClientID%>").val($("td", $(this)).eq(2).html());
                    break;
                case "Legal":
                    $("#<%=LRRTxt.ClientID%>").val($("td", $(this)).eq(3).html());
                    $("#<%=LRRDSCTxt.ClientID%>").val($("td", $(this)).eq(2).html());
                    break;
                case "Nuisance":
                    $("#<%=NuisanceTxt.ClientID%>").val($("td", $(this)).eq(3).html());
                    $("#<%=NuisanceDSCTxt.ClientID%>").val($("td", $(this)).eq(2).html());
                    break;
                case "Party":
                    $("#<%=INTPRTTxt.ClientID%>").val($("td", $(this)).eq(3).html());
                    $("#<%=INTPRTDSCTxt.ClientID%>").val($("td", $(this)).eq(2).html());
                    break;
                case "Policy":
                    $("#<%=PLCYISSUTxt.ClientID%>").val($("td", $(this)).eq(3).html());
                    $("#<%=PLCYISSUDSCTxt.ClientID%>").val($("td", $(this)).eq(2).html());
                    break;
                case "Information":
                    $("#<%=LINFOTxt.ClientID%>").val($("td", $(this)).eq(3).html());
                    $("#<%=LINFODSCTxt.ClientID%>").val($("td", $(this)).eq(2).html());
                    break;
            }

            calculateRisk();
        });
    }

    function loadProjectGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvProjects.ClientID%> tr").not($("#<%=gvProjects.ClientID%> tr:first-child")).remove();
        $(xml).find("Project").each(function (index, value) {
            $("td", row).eq(0).html($(this).attr("ProjectNo"));
            $("td", row).eq(1).html($(this).attr("ProjectName"));
            $("td", row).eq(2).html(new Date($(this).attr("StartDate")).format("dd/MM/yyyy"));
            $("td", row).eq(3).html(new Date($(this).attr("PlannedCloseDate")).format("dd/MM/yyyy"));
            $("td", row).eq(4).html($(this).find("ActualCloseDate").text() == '' ? '' : new Date($(this).find("ActualCloseDate").text()).format("dd/MM/yyyy"));
            $("td", row).eq(5).html($(this).attr("ProjectLeader"));
            $("td", row).eq(6).html($(this).attr("ProjectValue") + " " + $(this).attr("Currency"));
            $("td", row).eq(7).html($(this).attr("ProjectCost") + " " + $(this).attr("Currency"));
            $("td", row).eq(8).html($(this).attr("ProjectStatus"));

            $("#<%=gvProjects.ClientID%>").append(row);
            row = $("#<%=gvProjects.ClientID%> tr:last-child").clone(true);

        });

        $("#<%=gvProjects.ClientID%> tr").not($("#<%=gvProjects.ClientID%> tr:first-child")).bind('click', function ()
        {
            $("#SearchProject").hide('800');
            $("#<%=PROJTxt.ClientID%>").val($("td", $(this)).eq(1).html());
        });
    }

    function showProjectDialog(x, y, empty) {
        loadProjects(empty);

        $("#SearchProject").css({ left: x - 420, top: y - 130 });
        $("#SearchProject").css({ width: 700, height: 250 });
        $("#SearchProject").show();
    }

    function hideAll()
    {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
</script>
</asp:Content>
