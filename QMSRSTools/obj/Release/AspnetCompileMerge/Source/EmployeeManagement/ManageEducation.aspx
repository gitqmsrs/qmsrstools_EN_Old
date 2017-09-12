<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ManageEducation.aspx.cs" Inherits="QMSRSTools.EmployeeManagement.ManageEducation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="EmployeeEducation_Header" class="moduleheader">Maintain Employee Education</div>

     <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="new" src="../Images/new_file.png" class="imgButton" title="Add New Education" alt="" />  
          
        <div id="PersonnelIDContainer" style=" float:left;width:500px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="PersonnelIDLabel" style="width:100px;">Personnel ID:</div>
            <div id="PersonnelIDField" style="width:250px; left:0; float:left;">
                <asp:TextBox ID="PERSIDTxt" runat="server" CssClass="filtertext" Width="240px"></asp:TextBox>
            </div>
            <div id="PERSID_LD" class="control-loader"></div>      
            <span id="EMPSelect" class="searchactive" style="margin-left:10px" runat="server"></span>      
        </div>
    </div>

    <div id="SearchEmployee" class="selectbox" style="width:700px; height:250px; top:40px; left:150px;">
        <div class="toolbox">
            <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
            <div id="filter_div">
                <img id="filter" src="../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byFirst">Filter by First Name</li>
                    <li id="byLast">Filter by Last Name</li>
                    <li id="byREL">Filter by Religion</li>
                    <li id="byGND">Filter by Gender</li>
                    <li id="byMRT">Filter by Marital Status</li>
                    <li id="byDOB">Filter by Date of Birth Range</li>
                    <li id="byUNT">Filter by Organization Unit</li>
                </ul>
            </div>

            <div id="FirstNameContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="FirstNameFLabel" style="width:100px;">First Name:</div>
                <div id="FirstNameFField" style="width:150px; left:0; float:left;">
                    <asp:TextBox ID="FNMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
                </div>
            </div>
        
            <div id="GenderContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="GenderFLabel" style="width:100px;">Gender:</div>
                <div id="GenderFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="GNDRFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="GNDRF_LD" class="control-loader"></div>
            </div>

            <div id="ReligionContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="ReligionFLabel" style="width:100px;">Religion:</div>
                <div id="ReligionFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="RELFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="RELF_LD" class="control-loader"></div>
            </div>

            <div id="MaritalStatusContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="MaritalStatusFLabel" style="width:100px;">Marital Status:</div>
                <div id="MaritalStatusFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="MRTLSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="MRTLSTSF_LD" class="control-loader"></div>
            </div>

            <div id="OrganizationUnitContainer" class="filter" style=" float:left;width:310px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="OrganizationUnitFLabel" style="width:100px;">Organization Unit:</div>
                <div id="OrganizationUnitFField" style="width:170px; left:0; float:left;">
                    <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="comboboxfilter">
                    </asp:DropDownList>
                </div>
                <div id="ORGUNTF_LD" class="control-loader"></div>
            </div>

            <div id="LastNameContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="LastNameFLabel" style="width:100px;">Last Name:</div>
                <div id="LastNameFField" style="width:150px; left:0; float:left;">
                    <asp:TextBox ID="LNMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>
                </div>
            </div>

            <div id="StartdateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                <div id="StartDateFLabel" style="width:120px;">Date of Birth:</div>
                <div id="StartDateFField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
            </div>
            <div id="closeBox" class="selectboxclose" style="margin-right:1px;"></div>
        </div>
        <div id="FLTR_LD" class="control-loader"></div> 
        <div id="EmployeeScroll" style="height:200px; width:100%; overflow:auto; margin-top:15px; float:left">
            <asp:GridView id="gvEmployees" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
            GridLines="None" AllowPaging="true" PageSize="10" AlternatingRowStyle-CssClass="alt">
                <Columns>
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="PersonnelID" HeaderText="Personnel ID" />
                    <asp:BoundField DataField="CompleteName" HeaderText="CompleteName" />
                    <asp:BoundField DataField="KnownAs" HeaderText="Known As" />
                    <asp:BoundField DataField="DOB" HeaderText="Date of Birth" />
                    <asp:BoundField DataField="COB" HeaderText="Country of Birth" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" />
                    <asp:BoundField DataField="Religion" HeaderText="Religion" />
                    <asp:BoundField DataField="Marital" HeaderText="Marital Status" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <div id="EDUwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvEducation" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="Degree" HeaderText="Degree" />
            <asp:BoundField DataField="Award" HeaderText="Award Title" />
            <asp:BoundField DataField="Mode" HeaderText="Study Mode" />
            <asp:BoundField DataField="Institute" HeaderText="Institute" />
            <asp:BoundField DataField="Duration" HeaderText="Duration" />
            <asp:BoundField DataField="Grade" HeaderText="Grade" />
            <asp:BoundField DataField="Location" HeaderText="Location" />
        </Columns>
        </asp:GridView>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Education Details<span id="close" class="modalclose" title="Close">X</span></div>
        
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>
        
        <div id="validation_dialog_education" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary3" runat="server" CssClass="validator" ValidationGroup="Education" />
        </div>

        <input id="EducationID" type="hidden" value="" />

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="DegreeLabel" class="requiredlabel">Degree:</div>
            <div id="DegreeField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="DGRCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="DGR_LD" class="control-loader"></div>
                    
            <asp:RequiredFieldValidator ID="DGRTxtVal" runat="server" Display="None" ControlToValidate="DGRCBox" ErrorMessage="Select the degree" ValidationGroup="Education"></asp:RequiredFieldValidator>
         
            <asp:CompareValidator ID="DGRVal" runat="server" ControlToValidate="DGRCBox"
            Display="None" ErrorMessage="Select the degree" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Education"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AwardTitleLabel" class="requiredlabel">Award Title:</div>
            <div id="AwardTitleField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="AWRDTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>
                    
            <div id="AWRDlimit" class="textremaining"></div>
       
            <asp:RequiredFieldValidator ID="AWRDVal" runat="server" Display="None"  ControlToValidate="AWRDTxt" ErrorMessage="Enter the title of the degree" ValidationGroup="Education"></asp:RequiredFieldValidator>  
                    
            <asp:CustomValidator id="AWRD2FVal" runat="server" ValidationGroup="Education" 
            ControlToValidate = "AWRDTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>         
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="StudyModeLabel" class="requiredlabel">Study Mode:</div>
            <div id="StudyModeField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="STDYMODCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="STDYMOD_LD" class="control-loader"></div>
                    
            <asp:RequiredFieldValidator ID="STDYMODTxtVal" runat="server" Display="None" ControlToValidate="STDYMODCBox" ErrorMessage="Select study mode" ValidationGroup="Education"></asp:RequiredFieldValidator>
         
            <asp:CompareValidator ID="STDYMODVal" runat="server" ControlToValidate="STDYMODCBox" CssClass="validator"
            Display="None" ErrorMessage="Select study mode" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Education"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="InstituteLabel" class="requiredlabel">Institute/University:</div>
            <div id="InstituteField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="INSTTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>

            <div id="INSTLimit" class="textremaining"></div>
       
            <asp:RequiredFieldValidator ID="INSTTxtVal" runat="server" Display="None" ControlToValidate="INSTTxt" ErrorMessage="Enter the name of the institute or the university" ValidationGroup="Education"></asp:RequiredFieldValidator>  
                    
            <asp:CustomValidator id="INSTTxtFVal" runat="server" ValidationGroup="Education" 
            ControlToValidate = "INSTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>   
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
            <div id="StartDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="STRTDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>        
                
            <asp:RequiredFieldValidator ID="STRTDTVal" runat="server" Display="None" ControlToValidate="STRTDTTxt" ErrorMessage="Enter the start date of the degree" ValidationGroup="Education"></asp:RequiredFieldValidator>
                    
            <asp:RegularExpressionValidator ID="STRTDTFVal" runat="server" ControlToValidate="STRTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Education"></asp:RegularExpressionValidator> 

            <asp:CustomValidator id="STRTDTF2Val" runat="server" ValidationGroup="Education" 
            ControlToValidate = "STRTDTTxt" Display="None" ErrorMessage = "Start date shouldn't be in future"
            ClientValidationFunction="comparePast">
            </asp:CustomValidator>

            <asp:CustomValidator id="STRTDTF3Val" runat="server" ValidationGroup="Education" 
            ControlToValidate = "STRTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="EndDateLabel" class="labeldiv">End Date:</div>
            <div id="EndDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ENDDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>        
                    
            <asp:RegularExpressionValidator ID="ENDDTFVal" runat="server" ControlToValidate="ENDDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="Education"></asp:RegularExpressionValidator>
            
            <asp:CompareValidator ID="ENDDTF2Val" runat="server" ControlToCompare="STRTDTTxt"  ValidationGroup="Education"
            ControlToValidate="ENDDTTxt" ErrorMessage="The end date of the education should be greater than its start date"
            Operator="GreaterThan" Type="Date"
            Display="None"></asp:CompareValidator> 
               
            <asp:CustomValidator id="ENDDTF3Val" runat="server" ValidationGroup="Education" 
            ControlToValidate = "ENDDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

         <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="FacultyLabel" class="labeldiv">Faculty:</div>
            <div id="FacultyField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="FACULTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>

            <div id="FACULLimit" class="textremaining"></div>
       
                    
            <asp:CustomValidator id="FACULTxtFVal" runat="server" ValidationGroup="Education" 
            ControlToValidate = "FACULTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DepartmentLabel" class="labeldiv">Department:</div>
            <div id="DepartmentField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DEPRTTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>

            <div id="DEPRTLimit" class="textremaining"></div>
                    
            <asp:CustomValidator id="DEPRTTxtFVal" runat="server" ValidationGroup="Education" 
            ControlToValidate = "DEPRTTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="GradeSystemLabel" class="labeldiv">Grade System:</div>
            <div id="GradeSystemField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="GRDSYSCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="GRDSYS_LD" class="control-loader"></div>
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="GradeScoreLabel" class="labeldiv">Grade Score:</div>
            <div id="GradeScoreField" class="fielddiv" style="width:100px">
                <asp:TextBox ID="GRDSCRTxt" runat="server" CssClass="textbox" Width="90px"></asp:TextBox>
            </div>     

            <asp:RegularExpressionValidator ID="GRDSCRFval" runat="server" ControlToValidate="GRDSCRTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2.4 for GPA or 70.12 for Percentage" ValidationExpression="^[0-9]+(\.[0-9]{1,2})?$" ValidationGroup="Education"></asp:RegularExpressionValidator>  
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:20px;">
            <div id="Country" class="requiredlabel">Country:</div>
            <div id="CountryField" class="fielddiv" style="width:150px;">
                <asp:DropDownList ID="COUNTCBox" Width="150px" AutoPostBack="false" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>

            <div id="CTRY_LD" class="control-loader"></div>
                    
            <asp:RequiredFieldValidator ID="COUNTTxtVal" runat="server" Display="None" ControlToValidate="COUNTCBox" ErrorMessage="Select the country of the education" ValidationGroup="Education"></asp:RequiredFieldValidator>
         
            <asp:CompareValidator ID="COUNTVal" runat="server" ControlToValidate="COUNTCBox"
            Display="None" ErrorMessage="Select the country of the education" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="Education"></asp:CompareValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CityLabel" class="labeldiv">City:</div>
            <div id="CityField" class="fielddiv" style="width:150px;">
                <asp:TextBox ID="CTYTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
            </div>
            
            <div id="CTYlimit" class="textremaining"></div>
                    
            <asp:CustomValidator id="CTYTxtFVal" runat="server" ValidationGroup="Education" 
            ControlToValidate = "CTYTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>    
        </div>
      

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>
    
    <input id="MODE" type="hidden" value="" />
    <input id="EmployeeJSON" type="hidden" value="" />

</div>
<script type="text/javascript" language="javascript">
        $(function ()
        {
            var employeeempty = $("#<%=gvEmployees.ClientID%> tr:last-child").clone(true);
            var educationempty = $("#<%=gvEducation.ClientID%> tr:last-child").clone(true);

            $("#<%=STRTDTTxt.ClientID%>").datepicker(
           {
               inline: true,
               dateFormat: "dd/mm/yy",
               onSelect: function () { }
           });

            $("#<%=ENDDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=EMPSelect.ClientID%>").bind('click', function () {
                loadEmployees(employeeempty);

                $("#SearchEmployee").show();
            });

            $("#deletefilter").bind('click', function () {
                hideAll();
                loadEmployees(employeeempty);
            });

            $("#refresh").bind('click', function () {
                if ($("#EmployeeJSON").val() != '') {
                    var employeeJSON = $.parseJSON($("#EmployeeJSON").val());

                    loadEmployeeEducations(employeeJSON.PersonnelID, "#EDUwait", educationempty);

                }
                else {
                    alert("Please select an employee, or enter the desired personnel ID");
                }
            });

            $("#byFirst").bind('click', function () {
                hideAll();
                /*Clear text value*/
                $("#<%=FNMTxt.ClientID%>").val('');

                $("#FirstNameContainer").show();

            });

            $("#byLast").bind('click', function () {
                hideAll();
                /*Clear text value*/
                $("#<%=LNMTxt.ClientID%>").val('');

                $("#LastNameContainer").show();
            });

            $("#byREL").bind('click', function () {
                hideAll();
                loadComboboxAjax('loadReligions', "#<%=RELFCBox.ClientID%>","#RELF_LD");

                $("#ReligionContainer").show();
            });


            $("#byGND").bind('click', function () {
                hideAll();
                loadComboboxAjax('loadGenders', "#<%=GNDRFCBox.ClientID%>","#GNDRF_LD");

                $("#GenderContainer").show();
            });


            $("#byMRT").bind('click', function () {
                hideAll();
                loadComboboxAjax('loadMaritalStatus', "#<%=MRTLSTSFCBox.ClientID%>", "#MRTLSTSF_LD");

                $("#MaritalStatusContainer").show();
            });

            $("#byDOB").bind('click', function () {
                hideAll();
                /*Clear text value*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#StartdateContainer").show();
            });

            $("#byUNT").bind('click', function () {
                hideAll();
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTFCBox.ClientID%>", "#ORGUNTF_LD");

                $("#OrganizationUnitContainer").show();
              });


            $("#closeBox").bind('click', function () {
                $("#SearchEmployee").hide('800');
            });


            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            /*filter by first name*/
            $("#<%=FNMTxt.ClientID%>").keyup(function () {
                filterEmployeesByFirstName($(this).val(), employeeempty);
            });

            /*filter by last name*/
            $("#<%=LNMTxt.ClientID%>").keyup(function () {
                filterEmployeesByLastName($(this).val(), employeeempty);
            });

            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val(), employeeempty);
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val(), employeeempty);
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
               inline: true,
               dateFormat: "dd/mm/yy",
               onSelect: function (date) {
                   filterByDateRange(date, $("#<%=TDTTxt.ClientID%>").val(), employeeempty);
              }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByDateRange($("#<%=FDTTxt.ClientID%>").val(), date, employeeempty);
                }
            });

            $("#<%=RELFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByReligion($(this).val(), employeeempty);
                }
            });

            $("#<%=GNDRFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByGender($(this).val(), employeeempty);
                }
            });

            $("#<%=MRTLSTSFCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    filterEmployeesByMaritalStatus($(this).val(), employeeempty);
                }
            });

            $("#<%=PERSIDTxt.ClientID%>").keydown(function (event) {
                var $obj = $(this);

                var keycode = (event.keyCode ? event.keyCode : event.which);
                if (keycode == '13') {
                    var text = $(this).val();

                    loadEmployeeEducations(text, "#PERSID_LD", educationempty);
                }
            });

            $("#<%=ORGUNTFCBox.ClientID%>").change(function () {

                if ($(this).val() != 0) {
                    filterEmployeesByOrganization($(this).val(), employeeempty);
                }
            });

            $("#new").bind('click', function () {
                if ($("#EmployeeJSON").val() != '')
                {
                    $("#validation_dialog_education").hide();

                    var employeeJSON = $.parseJSON($("#EmployeeJSON").val());

                    /*load study mode combobox*/
                    loadComboboxAjax('loadStudyMode', "#<%=STDYMODCBox.ClientID%>","#STDYMOD_LD");
           
                    /*load degree combobox*/
                    loadComboboxAjax('loadEducationDegree', "#<%=DGRCBox.ClientID%>","#DGR_LD");

                    /*load country combobox*/
                    loadComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>", "#CTRY_LD");

                    /*load study mode combobox*/
                    loadComboboxAjax('loadEducationGradeSystem', "#<%=GRDSYSCBox.ClientID%>","#GRDSYS_LD");

                    /*attach award title to limit plugin*/
                    $("#<%=AWRDTxt.ClientID%>").limit({ id_result: 'AWRDlimit', alertClass: 'alertremaining', limit: 100 });

                    /*attach award title to limit plugin*/
                    $("#<%=INSTTxt.ClientID%>").limit({ id_result: 'INSTLimit', alertClass: 'alertremaining', limit: 100 });

                    /*attach faculty to limit plugin*/
                    $("#<%=FACULTxt.ClientID%>").limit({ id_result: 'FACULLimit', alertClass: 'alertremaining', limit: 100 });

                    /*attach department to limit plugin*/
                    $("#<%=DEPRTTxt.ClientID%>").limit({ id_result: 'DEPRTLimit', alertClass: 'alertremaining', limit: 100 });

                    /*attach city to limit plugin*/
                    $("#<%=CTYTxt.ClientID%>").limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 100 });

                    
                    /* clear all text and combo fields*/
                    $(".modalPanel").children().each(function () {
                        $(this).find('.textbox').each(function () {
                            $(this).val('');
                        });

                        $(this).find('.date').each(function () {
                            $(this).val('');
                        });

                        $(this).find('.readonly').each(function () {
                            $(this).val('');
                        });

                        $(this).find('.combobox').each(function () {
                            $(this).val(0);
                        });
                    });

                    /* set modal mode to add*/
                    $("#MODE").val('ADD');

                    /*trigger modal popup extender*/
                    $("#<%=alias.ClientID%>").trigger('click');
                }
                else
                {
                    alert("Please select an employee, or enter the desired personnel ID");
                }
            });

            $("#save").bind('click', function ()
            {
                var isGeneralValid = Page_ClientValidate('Education');
                if (isGeneralValid)
                {
                    if (!$("#validation_dialog_education").is(":hidden")) {
                        $("#validation_dialog_education").hide();
                    }


                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                        {
                            var employeeJSON = $.parseJSON($("#EmployeeJSON").val());

                            ActivateSave(false);

                            var startdatepart = getDatePart($("#<%=STRTDTTxt.ClientID%>").val());
                            var enddatepart = getDatePart($("#<%=ENDDTTxt.ClientID%>").val());

                            if ($("#MODE").val() == 'ADD') {
                                var education =
                                {
                                    Degree: $("#<%=DGRCBox.ClientID%>").val(),
                                    AwardTitle: $("#<%=AWRDTxt.ClientID%>").val(),
                                    StudyMode: $("#<%=STDYMODCBox.ClientID%>").val(),
                                    Institute: $("#<%=INSTTxt.ClientID%>").val(),
                                    StartDate: new Date(startdatepart[2], (startdatepart[1] - 1), startdatepart[0]),
                                    EndDate: enddatepart == '' ? null : new Date(enddatepart[2], (enddatepart[1] - 1), enddatepart[0]),
                                    Faculty: $("#<%=FACULTxt.ClientID%>").val(),
                                    Department: $("#<%=DEPRTTxt.ClientID%>").val(),
                                    GradeSystem: ($("#<%=GRDSYSCBox.ClientID%>").val() == 0 || $("#<%=GRDSYSCBox.ClientID%>").val() == null ? '' : $("#<%=GRDSYSCBox.ClientID%>").val()),
                                    Score: $("#<%=GRDSCRTxt.ClientID%>").val() == '' ? 0 : $("#<%=GRDSCRTxt.ClientID%>").val(),
                                    Country: $("#<%=COUNTCBox.ClientID%>").val(),
                                    City: $("#<%=CTYTxt.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(education) + "\','personnelID':'" + employeeJSON.PersonnelID + "'}",
                                    url: getServiceURL().concat('createNewEmployeeEducation'),
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
                            else {
                                var education =
                                {
                                    EducationID: $("#EducationID").val(),
                                    Degree: $("#<%=DGRCBox.ClientID%>").val(),
                                    AwardTitle: $("#<%=AWRDTxt.ClientID%>").val(),
                                    StudyMode: $("#<%=STDYMODCBox.ClientID%>").val(),
                                    Institute: $("#<%=INSTTxt.ClientID%>").val(),
                                    StartDate: new Date(startdatepart[2], (startdatepart[1] - 1), startdatepart[0]),
                                    EndDate: enddatepart == '' ? null : new Date(enddatepart[2], (enddatepart[1] - 1), enddatepart[0]),
                                    Faculty: $("#<%=FACULTxt.ClientID%>").val(),
                                    Department: $("#<%=DEPRTTxt.ClientID%>").val(),
                                    GradeSystem: ($("#<%=GRDSYSCBox.ClientID%>").val() == 0 || $("#<%=GRDSYSCBox.ClientID%>").val() == null ? '' : $("#<%=GRDSYSCBox.ClientID%>").val()),
                                    Score: $("#<%=GRDSCRTxt.ClientID%>").val() == '' ? 0 : $("#<%=GRDSCRTxt.ClientID%>").val(),
                                    Country: $("#<%=COUNTCBox.ClientID%>").val(),
                                    City: $("#<%=CTYTxt.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(education) + "\'}",
                                    url: getServiceURL().concat('updateNewEmployeeEducation'),
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
                else
                {
                    $("#validation_dialog_education").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
             });

        });

        function loadEmployeeEducations(personnelID, loader, empty)
        {
            
            $(loader).stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'personnelID':'" + personnelID + "'}",
                    url: getServiceURL().concat('getEmployeeByPersonnelID'),
                    success: function (data) {
                        $(loader).fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            var xmlEmployee = $.parseXML(data.d);
                            var employee = $(xmlEmployee).find("Employee");

                            var employeeJSON =
                            {
                                PersonnelID: employee.attr('PersonnelID')
                            }

                            /*serialize and temprary store json data*/
                            $("#EmployeeJSON").val(JSON.stringify(employeeJSON));

                            /*Load employee's education list in the grifview*/
                            loadEducationGridView(employee.attr('XMLEducation'), empty);
                        });
                    },
                    error: function (xhr, status, error) {
                        $(loader).fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);

                            $("#EmployeeJSON").val('');
                        });
                    }
                });
            });
        }

        function loadEmployees(empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat('getEmployees'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadEmployeeGridView(data.d, empty);
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

        function filterByDateRange(start, end, empty) {
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
                        url: getServiceURL().concat('filterEmployeesByDateOfBirth'),
                        success: function (data) {

                            $("#FLTR_LD").fadeOut(500, function () {
                                $(".modulewrapper").css("cursor", "default");

                                $(this).find('p').text("List of all current employees filtered by date of birth range.");

                                if (data) {
                                    loadEmployeeGridView(data.d, empty);
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
        }

        function filterEmployeesByMaritalStatus(status, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'status':'" + status + "'}",

                    url: getServiceURL().concat('filterEmployeesByMaritalStatus'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
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

        function filterEmployeesByGender(gender, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'gender':'" + gender + "'}",
                    url: getServiceURL().concat('filterEmployeesByGender'),
                    success: function (data) {

                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadEmployeeGridView(data.d, empty);
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

        function filterEmployeesByReligion(religion, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'religion':'" + religion + "'}",

                    url: getServiceURL().concat('filterEmployeesByReligion'),
                    success: function (data) {


                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
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

        function filterEmployeesByLastName(last, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'last':'" + last + "'}",

                    url: getServiceURL().concat('filterEmployeesByLastName'),
                    success: function (data) {

                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
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

        function filterEmployeesByOrganization(unit, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'unit':'" + unit + "'}",

                    url: getServiceURL().concat('filterEmployeesByOrganization'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");


                            if (data) {
                                loadEmployeeGridView(data.d, empty);
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

        function filterEmployeesByFirstName(first, empty) {
            $("#FLTR_LD").stop(true).hide().fadeIn(500, function () {

                $(".modulewrapper").css("cursor", "wait");


                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'first':'" + first + "'}",
                    url: getServiceURL().concat('filterEmployeesByFirstName'),
                    success: function (data) {
                        $("#FLTR_LD").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            if (data) {
                                loadEmployeeGridView(data.d, empty);
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
        function loadEmployeeGridView(data, empty) {
            var xml = $.parseXML(data);

            var row = empty;

            $("#<%=gvEmployees.ClientID%> tr").not($("#<%=gvEmployees.ClientID%> tr:first-child")).remove();

            $(xml).find("Employee").each(function (index, employee) {
                /*work arround problem to refresh the updated image inj grid view by sending a dummy date in seconds to the image hander*/
                var date = new Date();

                $("td", row).eq(0).html("<img id='icon_" + index + "' src='../ImageHandler.ashx?query=select ProfileImg from HumanResources.Employee where EmployeeID=" + $(this).attr('EmployeeID') + "&width=70&height=40&date=" + date.getSeconds() + "' />");

                $("td", row).eq(1).html($(this).attr("PersonnelID"));
                $("td", row).eq(2).html($(this).attr("CompleteName"));
                $("td", row).eq(3).html($(this).attr("KnownAs"));
                $("td", row).eq(4).html(new Date($(this).attr("DOB")).format("dd/MM/yyyy"));
                $("td", row).eq(5).html($(this).attr("COB"));
                $("td", row).eq(6).html($(this).attr("Gender"));
                $("td", row).eq(7).html($(this).attr("Religion"));
                $("td", row).eq(8).html($(this).attr("MaritalStatus"));
                $("td", row).eq(9).html($(this).attr("EmailAddress"));

                $("#<%=gvEmployees.ClientID%>").append(row);

                row = $("#<%=gvEmployees.ClientID%> tr:last-child").clone(true);
            });

            $("#<%=gvEmployees.ClientID%> tr").not($("#<%=gvEmployees.ClientID%> tr:first-child")).bind('click', function () {

                $("#SearchEmployee").hide('800');

                $("#<%=PERSIDTxt.ClientID%>").val($("td", $(this)).eq(1).html());

                var e = jQuery.Event("keydown");
                e.which = 13; // # Some key code value
                $("#<%=PERSIDTxt.ClientID%>").trigger(e);

            });
        }

        function loadEducationGridView(data, empty) {
            var xml = $.parseXML(data);

            var row = empty;


            $("#<%=gvEducation.ClientID%> tr").not($("#<%=gvEducation.ClientID%> tr:first-child")).remove();

            $(xml).find("Education").each(function (index, education)
            {
                $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
                $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'/>");
                $("td", row).eq(2).html($(this).attr("Degree"));
                $("td", row).eq(3).html($(this).attr("AwardTitle"));
                $("td", row).eq(4).html($(this).attr("StudyMode"));
                $("td", row).eq(5).html($(this).attr("Institute"));
                $("td", row).eq(6).html($(this).find("EndDate").text() == '' ? "From: " + new Date($(this).attr("StartDate")).format("dd/MM/yyyy") + " To: Present" : "From: " + new Date($(this).attr("StartDate")).format("dd/MM/yyyy") + " To: " + new Date($(this).find("EndDate").text()).format("dd/MM/yyyy"));
                $("td", row).eq(7).html($(this).attr("Score") + " In " + $(this).attr("GradeSystem") + " system");
                $("td", row).eq(8).html($(this).attr("City") + "/" + $(this).attr("Country"));

                $("#<%=gvEducation.ClientID%>").append(row);

                $(row).find('img').each(function () {
                    if ($(this).attr('id').search('delete') != -1) {
                        $(this).bind('click', function ()
                        {
                            removeEducation($(education).attr("EducationID"));
                        });
                    }
                    else if ($(this).attr('id').search('edit') != -1) {
                        $(this).bind('click', function ()
                        {
                            $("#validation_dialog_education").hide();

                            /*bind education ID*/
                            $("#EducationID").val($(education).attr('EducationID'));

                            /*bind degree combobox*/
                            bindComboboxAjax('loadEducationDegree', "#<%=DGRCBox.ClientID%>", $(education).attr('Degree'), "#DGR_LD");

                            /*bind award title*/
                            $("#<%=AWRDTxt.ClientID%>").val($(education).attr('AwardTitle'));

                            /*attach award title to limit plugin*/
                            $("#<%=AWRDTxt.ClientID%>").limit({ id_result: 'AWRDlimit', alertClass: 'alertremaining', limit: 100 });

                            /*bind study mode combobox*/
                            bindComboboxAjax('loadStudyMode', "#<%=STDYMODCBox.ClientID%>", $(education).attr('StudyMode'), "#STDYMOD_LD");

                            /*bind institute field*/
                            $("#<%=INSTTxt.ClientID%>").val($(education).attr('Institute'));

                            /*attach award title to limit plugin*/
                            $("#<%=INSTTxt.ClientID%>").limit({ id_result: 'INSTLimit', alertClass: 'alertremaining', limit: 100 });

                            /*bind start date field*/
                            $("#<%=STRTDTTxt.ClientID%>").val(new Date($(education).attr("StartDate")).format("dd/MM/yyyy"));

                            /*bind end date field*/
                            $("#<%=ENDDTTxt.ClientID%>").val($(education).find("EndDate").text() == '' ? '' : new Date($(education).find("EndDate").text()).format("dd/MM/yyyy"));

                            /*bind faculty field*/
                            $("#<%=FACULTxt.ClientID%>").val($(education).attr('Faculty'));

                            /*attach faculty to limit plugin*/
                            $("#<%=FACULTxt.ClientID%>").limit({ id_result: 'FACULLimit', alertClass: 'alertremaining', limit: 100 });

                            /*bind department field*/
                            $("#<%=DEPRTTxt.ClientID%>").val($(education).attr('Department'));

                            /*attach department to limit plugin*/
                            $("#<%=DEPRTTxt.ClientID%>").limit({ id_result: 'DEPRTLimit', alertClass: 'alertremaining', limit: 100 });

                            /*bind study mode combobox*/
                            bindComboboxAjax('loadEducationGradeSystem', "#<%=GRDSYSCBox.ClientID%>", $(education).attr('GradeSystem'),"#GRDSYS_LD");

                            /*bind grade score field*/
                            $("#<%=GRDSCRTxt.ClientID%>").val($(education).attr('Score') == 0 ? '' : $(education).attr('Score'));

                            /*bind country combobox*/
                            bindComboboxAjax('loadCountries', "#<%=COUNTCBox.ClientID%>", $(education).attr('Country'),"#CTRY_LD");

                            /*bind city field*/
                            $("#<%=CTYTxt.ClientID%>").val($(education).attr('City'));

                            /*attach city to limit plugin*/
                            $("#<%=CTYTxt.ClientID%>").limit({ id_result: 'CTYlimit', alertClass: 'alertremaining', limit: 100 });

                            $(".textbox").each(function () {
                                $(this).keyup();
                            });

                            /* set modal mode to add*/
                            $("#MODE").val('EDIT');

                            /*trigger modal popup extender*/
                            $("#<%=alias.ClientID%>").trigger('click');
                        });
                    }
                });
                row = $("#<%=gvEducation.ClientID%> tr:last-child").clone(true);
            });
        }
        function removeEducation(educationID) {
            var result = confirm("Are you sure you would like to remove the selected education record?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");
                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'educationID':'" + educationID + "'}",
                    url: getServiceURL().concat('removeEmployeeEducation'),
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
