<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CourseSchedule.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.CourseSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="CourseSchedule_Header" class="moduleheader">Course Schedule</div>
    
    <div class="toolbox">
        <img id="refreshschedule" src="http://www.qmsrs.com/qmsrstools/Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        
        <div id="filter_div">
            <img id="filter" src="http://www.qmsrs.com/qmsrstools/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byNumber">Filter by Course Number</li>
                <li id="byTitle">Filter by Course Title</li>
                <li id="byStatus">Filter by Course Status</li>
                <li id="bySTRTDT">Filter by Course Start Date</li>
                <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
    </div>

     <div id="CourseNumberContainer" class="filter">
        <div id="CourseNumberLabel" class="filterlabel">Course No:</div>
        <div id="CourseNumberField" class="filterfield">
            <asp:TextBox ID="CRSNUMTxt" runat="server" CssClass="filtertext" Width="140px"></asp:TextBox>      
        </div>
     </div>

    <div id="CourseTitleContainer" class="filter">
        <div id="CourseTitleFLabel" class="filterlabel">Course Title:</div>
        <div id="CourseTitleFField" class="filterfield">
            <asp:DropDownList ID="CTTLFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="CTTLF_LD" class="control-loader"></div>
    </div>

    <div id="CourseStatusContainer" class="filter">
        <div id="CourseStatusFLabel" class="filterlabel">Course Status:</div>
        <div id="CourseStatusFField" class="filterfield">
            <asp:DropDownList ID="CSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="CSTSFTYP_LD" class="control-loader"></div>
     </div>

     <div id="RecordModeContainer" class="filter">
        <div id="RecordModeLabel" class="filterlabel">Record Mode:</div>
        <div id="RecordModeField" class="filterfield">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
        <div id="RECMOD_LD" class="control-loader"></div>
    </div>

    <div id="StartDateFilterContainer" class="filter">
        <div id="StartDateFLabel" class="filterlabel">Start Date:</div>
        <div id="StartDateFField" class="filterfield">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
    </div>

    <div id="CRSwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id='calendar'></div>
    
    <div id="CourseOption" class="optionbox" style="top:110px;">
        <div id="closeOption" class="optionclose"></div>

        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="CourseNoLabel" class="labeldiv" style="width:100px;">Course No:</div>
            <div id="CourseNoField" class="fielddiv" style="width:130px">
                <asp:TextBox ID="CRSIDTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="120px"></asp:TextBox>
            </div>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="CourseDateLabel" class="labeldiv" style="width:100px;">Course Date:</div>
            <div id="CourseDateField" class="fielddiv" style="width:130px">
                <asp:TextBox ID="CRSDTTxt" runat="server"  CssClass="readonly" ReadOnly="true" Width="120px"></asp:TextBox>
            </div>
        </div>

        <div class="buttondiv">
            <img id='delete_course' src='http://www.qmsrs.com/qmsrstools/Images/deletenode.png' class='imgButton' alt="Remove Course" style='float:left;' title='Remove course' />
            <img id='edit_course' src='http://www.qmsrs.com/qmsrstools/Images/edit.png' class='imgButton' alt="Edit Course" style='float:left;' title='Edit course' />
        </div>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="EditExtender" runat="server" TargetControlID="alias" PopupControlID="panel2" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel2" runat="server" CssClass="modalPanel">
          <div id="CourseHeader" class="modalHeader">Course Details<span id="Close" class="modalclose" title="Close">X</span></div>
        
          <div id="CourseTooltip" class="tooltip">
                <img src="http://www.qmsrs.com/qmsrstools/Images/Warning.png" alt="Help" height="25" width="25" />
                <p></p>
	      </div>

          <div id="SaveTooltip" class="tooltip">
                <img src="http://www.qmsrs.com/qmsrstools/Images/wait-loader.gif" alt="Save" height="25" width="25" />
                <p>Saving...</p>
	      </div>
        
          <div id="validation_dialog_general">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
          </div>

          <input id="CourseID" value="" type="hidden" />

          <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CourseNameLabel" class="requiredlabel">Course Title:</div>
            <div id="CourseNameField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="CRSNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
            </div>  
            <div id="ttllimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="CRSNMVal" runat="server" Display="None" ControlToValidate="CRSNMTxt" ErrorMessage="Enter the title of the training course" ValidationGroup="General"></asp:RequiredFieldValidator>

            <asp:CustomValidator id="CRSNMTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CRSNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="80px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
           
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:82px;">
            <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
            <div id="StartDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="STDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="STDTVal" runat="server" Display="None" ControlToValidate="STDTTxt" ErrorMessage="Enter the start date of the course" ValidationGroup="General"></asp:RequiredFieldValidator>
        
            <asp:RegularExpressionValidator ID="STDTFVal" runat="server" ControlToValidate="STDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="STDTF3Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "STDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CourseDurationLabel" class="labeldiv">Course Duration:</div>
            <div id="CourseDurationField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="COURSDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:DropDownList ID="COURSPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                </asp:DropDownList>     
            </div>     
            <div id="COURSPRD_LD" class="control-loader"></div> 

            <ajax:FilteredTextBoxExtender ID="DURFEXT" runat="server" TargetControlID="COURSDURTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>
            
            <asp:CustomValidator id="COURSDURZVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "COURSDURTxt" Display="None" ErrorMessage = "The duration of the course should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator>   
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="EndDateLabel" class="labeldiv">End Date:</div>
            <div id="EndDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ENDDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div> 

            <div id="AccommodationGroupField" class="groupbox" style="height:30px; width:auto;">
            <div id="LunchLabel" class="labeldiv">Including Lunch:</div>
            <div id="LunchField" class="fielddiv" style="width:20px;">
                <input type="checkbox" id="LNCHCHK" class="checkbox" />
            </div>

            <div id="RefreshmentsLabel" class="labeldiv">Including Refreshments:</div>
            <div id="RefreshmentsField" class="fielddiv" style="width:20px;">
                <input type="checkbox" id="REFCHK" class="checkbox" />
            </div>
            
            
            <div id="TransportationLabel" class="labeldiv">Including Transportation:</div>
            <div id="TransportationField" class="fielddiv" style="width:20px;">
                <input type="checkbox" id="TRNSCHK" class="checkbox" />
            </div>
       </div>
            <asp:RegularExpressionValidator ID="ENDDTVal" runat="server" ControlToValidate="ENDDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        
            <asp:CompareValidator ID="ENDDTFVal" runat="server" ControlToCompare="STDTTxt"  ValidationGroup="General"
            ControlToValidate="ENDDTTxt" ErrorMessage="The end date of the course should be greater or equals its start date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator> 

            <asp:CustomValidator id="ENDDTF2Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "ENDDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CourseCapacityLabel" class="requiredlabel">Course Capacity:</div>
            <div id="CourseCapacityField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="CAPTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="CAPTxtVal" runat="server" Display="None" ControlToValidate="CAPTxt" ErrorMessage="Enter the capacity of the course" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <ajax:FilteredTextBoxExtender ID="CAPFEXT" runat="server" TargetControlID="CAPTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender> 
           
            <asp:CustomValidator id="CAPTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CAPTxt" Display="None" ErrorMessage = "The capacity of the course should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator> 
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CoordinatorLabel" class="requiredlabel">Course Coordinator:</div>
            <div id="CoordinatorField" class="fielddiv" style="width:250px">
               <asp:TextBox ID="CRDTxt" runat="server" CssClass="readonly" Width="240px"></asp:TextBox>    
            </div>
            <span id="CRDSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting course coordinator"></span>
          
            <asp:RequiredFieldValidator ID="CRDTRCBoxTxtVal" runat="server" Display="None" ControlToValidate="CRDTxt" ErrorMessage="Select course coordinator" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CompareValidator ID="CRDTRCBoxVal" runat="server" ControlToValidate="CRDTxt"
            Display="None" ErrorMessage="Select course coordinator" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CourseDocumentLabel" class="labeldiv">Course Material:</div>
            <div id="CourseDocumentField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="CDOCTxt" runat="server" CssClass="readonly" Width="240px"></asp:TextBox>    
            </div>
            
            <span id="CDOCSelect" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span> 
        </div>

        <div id="SelectORG" class="selectbox">
            <div id="closeORG" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="SelectOrganizationLebel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="SelectOrganizationField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="SORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList> 
                </div>
                <div id="UNT_LD" class="control-loader"></div> 
            </div>           
           
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="SelectEmployeeLabel" class="labeldiv" style="width:100px;">Select Employee:</div>
                <div id="SelectEmployeeField" class="fielddiv" style="width:130px">
                    <asp:DropDownList ID="EMPCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="EMP_LD" class="control-loader"></div>
            </div>
        </div>

        <div id="SelectDOCTYP" class="selectbox">
            <div id="closeDOCTYP" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="DOCTYPLabel" class="labeldiv" style="width:100px;">Document Type:</div>
                <div id="DOCTYPField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="DOCTYPCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList> 
                </div>
            
                <div id="DOCTYP_LD" class="control-loader"></div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="DOCLabel" class="labeldiv" style="width:100px;">Document:</div>
                <div id="DOCField" class="fielddiv" style="width:130px">
                    <asp:DropDownList ID="DOCCBox" AutoPostBack="false" runat="server" Width="130px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
                <div id="DOC_LD" class="control-loader"></div>
            </div>
        </div>

       <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="RemarksLabel" class="labeldiv">Additional Notes:</div>
            <div id="RemarksField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="RMKTxt" runat="server"  CssClass="textbox" Width="390px" Height="80px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="RMKTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "RMKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:82px;">
            <div id="CourseStatusLabel" class="requiredlabel">Course Status:</div>
            <div id="CourseStatusField" class="fielddiv" style="width:250px">
                <asp:DropDownList ID="CRSTSCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="CRSSTS_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="CRSTSTxtVal" runat="server" Display="None" ControlToValidate="CRSTSCBox" ErrorMessage="Select course status" ValidationGroup="General"></asp:RequiredFieldValidator>   
          
            <asp:CompareValidator ID="CRSTSVal" runat="server" ControlToValidate="CRSTSCBox"
            Display="None" ErrorMessage="Select course status" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>

    <input id="course_id" type="hidden" value="" />
    <input id="CourseJSON" type="hidden" value="" />

</div>

<script type="text/javascript" language="javascript">
        $(function ()
        {
            loadCourseSchedule();

            $("#refreshschedule").bind('click', function ()
            {
                hideAll();
                loadCourseSchedule();
            });

            $("#byTitle").bind('click', function () {
                hideAll();

                /*load course status*/
                loadComboboxAjax('loadCourseTitle', '#<%=CTTLFCBox.ClientID%>', "#CTTLF_LD");

                $("#CourseTitleContainer").show();
            });

            $("#byNumber").bind('click', function () {
                hideAll();

                $("#<%=CRSNUMTxt.ClientID%>").val('');

                $("#CourseNumberContainer").show();
            });

            $("#byStatus").bind('click', function () {
                hideAll();

                /*load course status*/
                loadComboboxAjax('loadCourseStatus', '#<%=CSTSFCBox.ClientID%>', "#CSTSFTYP_LD");

                $("#CourseStatusContainer").show();
            });


            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#RecordModeContainer").show();

                /*load record mode*/
                loadComboboxAjax('loadRecordMode', "#<%=RECMODCBox.ClientID%>", "#RECMOD_LD");
            });

            $("#bySTRTDT").bind('click', function ()
            {
                hideAll();

                /*Clear filter texts*/
                $("#<%=FDTTxt.ClientID%>").val('');
                $("#<%=TDTTxt.ClientID%>").val('');

                $("#StartDateFilterContainer").show();
            });

            $("#<%=RECMODCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    filterByCourseMode($(this).val());
                }
            });


            $('#<%=CTTLFCBox.ClientID%>').change(function ()
            {
                if ($(this).val() != 0)
                {
                    filterByCourseTitle($(this).val());
                }
            });

            $('#<%=CSTSFCBox.ClientID%>').change(function ()
            {
                if ($(this).val() != 0)
                {
                    filterByCourseStatus($(this).val());
                }
            });

            /*filter by start date range*/
            $("#<%=FDTTxt.ClientID%>").keyup(function () {
                filterByStartDateRange($(this).val(), $("#<%=TDTTxt.ClientID%>").val());
            });

            $("#<%=TDTTxt.ClientID%>").keyup(function () {
                filterByStartDateRange($("#<%=FDTTxt.ClientID%>").val(), $(this).val());
            });

            $("#<%=FDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByStartDateRange(date, $("#<%=TDTTxt.ClientID%>").val());
                }
            });

            $("#<%=TDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    filterByStartDateRange($("#<%=FDTTxt.ClientID%>").val(), date);
                }
            });

            $("#<%=CRDSelect.ClientID%>").click(function (e) {
                showORGDialog(e.pageX, e.pageY);
            });

            $("#<%=CDOCSelect.ClientID%>").click(function (e)
            {
                showDOCTYPDialog(e.pageX, e.pageY);
            });

            /*populate the employees in coordinatorcboxes*/
            $("#<%=SORGUNTCBox.ClientID%>").change(function () {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=EMPCBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#EMP_LD");
            });

            /*filter by course number*/
            $("#<%=CRSNUMTxt.ClientID%>").keyup(function ()
            {
                filterByCourseNo($(this).val());
            });

            /*populate the documents for selecting course material*/
            $("#<%=DOCTYPCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0) {
                    var $obj = $(this);
                    $("#DOCTYP_LD").stop(true).hide().fadeIn(800, function () {
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{'type':'" + $obj.val() + "'}",
                            url: getServiceURL().concat("loadCurrentDocuments"),
                            success: function (data) {
                                $("#DOCTYP_LD").fadeOut(500, function () {
                                    if (data) {
                                        loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $("#<%=DOCCBox.ClientID%>"), $("DOC_LD"));
                                    }
                                });
                            },
                            error: function (xhr, status, error) {
                                $("#DOCTYP_LD").fadeOut(500, function () {
                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);

                                    $("#SelectDOCTYP").hide('800');
                                });
                            }
                        });
                    });
                }

            });

            $("#<%=DOCCBox.ClientID%>").change(function () {

                if ($(this).val() != 0) {
                    $("#<%=CDOCTxt.ClientID%>").val($(this).val());
                    $("#SelectDOCTYP").hide('800');
                }
            });

            $("#<%=EMPCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    $("#<%=CRDTxt.ClientID%>").val($(this).val());
                    $("#SelectORG").hide('800');
                }
            });

            /*close organization unit box*/
            $("#closeORG").bind('click', function () {
                $("#SelectORG").hide('800');
            });

            $("#closeDOCTYP").bind('click', function () {
                $("#SelectDOCTYP").hide('800');
            });

            $("#Close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            /*close course option box*/
            $("#closeOption").bind('click', function () {
                $("#CourseOption").hide('800');
            });

            $("#delete_course").bind('click', function ()
            {
                if ($("#CourseJSON").val() != '')
                {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());
                    removeCourse(courseJSON.ID);
                }
                else
                {
                    alert("Cannot find the related course record");
                }

                $("#CourseOption").hide('800');
            });

            $("#edit_course").bind('click', function ()
            {
                if ($("#CourseJSON").val() != '')
                {
                    var courseJSON = $.parseJSON($("#CourseJSON").val());

                    $(".modulewrapper").css("cursor", "wait");

                    $.ajax(
                    {
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: "{'courseID':'" + courseJSON.ID + "'}",
                        url: getServiceURL().concat("getCourse"),
                        success: function (data)
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data)
                            {
                                bindCourseData(data.d);
                            }
                        },
                        error: function (xhr, status, error)
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        }
                    });
                }
                else
                {
                    alert("Cannot find the related course record");
                }
            });

            $("#save").bind('click', function ()
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
                        if ($("#CourseJSON").val() != '')
                        {
                            var courseJSON = $.parseJSON($("#CourseJSON").val());

                            $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                            {
                                ActivateSave(false);

                                var startDateParts = getDatePart($("#<%=STDTTxt.ClientID%>").val());
                                var endDateParts = getDatePart($("#<%=ENDDTTxt.ClientID%>").val());

                                var course =
                                {
                                    CourseID: courseJSON.ID,
                                    CourseTitle: $("#<%=CRSNMTxt.ClientID%>").val(),
                                    Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val()),
                                    Notes: $("#<%=RMKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMKTxt.ClientID%>").val()),
                                    Duration: $("#<%=COURSDURTxt.ClientID%>").val() == '' ? 0 : $("#<%=COURSDURTxt.ClientID%>").val(),
                                    Period: ($("#<%=COURSPRDCBox.ClientID%>").val() == 0 || $("#<%=COURSPRDCBox.ClientID%>").val() == null ? '' : $("#<%=COURSPRDCBox.ClientID%>").val()),
                                    StartDate: new Date(startDateParts[2], (startDateParts[1] - 1), startDateParts[0]),
                                    EndDate: $("#<%=ENDDTTxt.ClientID%>").val() == '' ? null : new Date(endDateParts[2], (endDateParts[1] - 1), endDateParts[0]),
                                    Material: $("#<%=CDOCTxt.ClientID%>").val(),                           
                                    Coordinator: $("#<%=CRDTxt.ClientID%>").val(),
                                    Capacity: $("#<%=CAPTxt.ClientID%>").val(),
                                    IncludeLunch: $("#LNCHCHK").is(':checked'),
                                    IncludeRefreshment: $("#REFCHK").is(':checked'),
                                    IncludeTransporation: $("#TRNSCHK").is(':checked'),
                                    CourseStatusStr: $("#<%=CRSTSCBox.ClientID%>").val()
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(course) + "\'}",
                                    url: getServiceURL().concat('updateCourse'),
                                    success: function (data) {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            alert(data.d);

                                            $("#cancel").trigger('click');

                                            $("#refreshschedule").trigger('click');
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
                        else {
                            alert("Cannot find the related course record");
                        }
                    }
                }
                else
                {
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                        
                    });
                }
            });


            /*Calculate course end date */
            $("#<%=COURSPRDCBox.ClientID%>").change(function () {
                if ($(this).val() != 0) {
                    var period = $(this).val();
                    var duration = parseInt($("#<%=COURSDURTxt.ClientID%>").val());

                    setEndDate($("#<%=STDTTxt.ClientID%>").val(), duration, period);
                }
            });

            $("#<%=STDTTxt.ClientID%>").keyup(function () {
                var period = $("#<%=COURSPRDCBox.ClientID%>").find('option:selected').text();
                var duration = parseInt($("#<%=COURSDURTxt.ClientID%>").val());

                setEndDate($(this).val(), duration, period);
            });

            $("#<%=COURSDURTxt.ClientID%>").keyup(function () {
                if ($("#<%=COURSPRDCBox.ClientID%>").val() != 0) {
                    var period = $("#<%=COURSPRDCBox.ClientID%>").val();
                    var duration = parseInt($(this).val());

                    setEndDate($("#<%=STDTTxt.ClientID%>").val(), duration, period);
                }
            });

            $("#<%=STDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date)
                {
                    var period = $("#<%=COURSPRDCBox.ClientID%>").find('option:selected').text();
                    var duration = parseInt($("#<%=COURSDURTxt.ClientID%>").val());

                    setEndDate(date, duration, period);
                }
            });


            $("#<%=ENDDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

        });

        function showCourseOption(x, y)
        {
            $("#CourseOption").css({ left: x - 10, top: y + 20 });
            $("#CourseOption").show();
        }
        function removeCourse(ID)
        {
            var result = confirm("Removing the current course might cause all subsequent information to be remove accordignly, are you sure you would like to continue?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: "{'ID':'" + ID + "'}",
                    url: getServiceURL().concat("removeCourse"),
                    success: function (data)
                    {
                        $(".modulewrapper").css("cursor", "default");
                        loadCourseSchedule();
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

        function filterByCourseMode(mode)
        {
            $("#CRSwait").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                /*remove previous calendar data*/
                $("#calendar").empty();

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{'mode':'" + mode + "'}",
                    url: getServiceURL().concat('filterCourseScheduleByMode'),
                    success: function (data)
                    {
                        var data = $.parseJSON(data.d);

                        $("#CRSwait").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var eventdata = new Array();


                            $(data).each(function (index, value) {
                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(parseInt(value.start.substr(6))),

                                    end: value.end == null ? null : new Date(parseInt(value.end.substr(6)))
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                                eventClick: function (calEvent, jsEvent, view)
                                {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                     {
                                         type: "POST",
                                         contentType: "application/json; charset=utf-8",
                                         dataType: "json",
                                         data: "{'courseID':'" + calEvent.id + "'}",
                                         url: getServiceURL().concat("getCourse"),
                                         success: function (data)
                                         {
                                             $(".modulewrapper").css("cursor", "default");

                                             if (data)
                                             {
                                                 var xmlCourse = $.parseXML(data.d);
                                                 var course = $(xmlCourse).find('Course');

                                                 $("#<%=CRSIDTxt.ClientID%>").val(course.attr('CourseNo'));

                                                 if (course.find("EndDate").text() == '') {
                                                     $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy"));
                                                 }
                                                 else {
                                                     $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy") + " To " + new Date(course.find("EndDate").text()).format("dd/MM/yyyy"));
                                                 }


                                                 showCourseOption(jsEvent.pageX, jsEvent.pageY);

                                                 /* create temporary JSON course for future reference*/
                                                 var courseJSON =
                                                 {
                                                     ID: course.attr('CourseID'),
                                                     CourseNo: course.attr('CourseNo'),
                                                     Capacity: course.attr('Capacity'),
                                                     Status: course.attr('CourseStatus'),
                                                     Mode: course.attr('ModeString')
                                                 }

                                                 /*serialize and temprary store json data*/
                                                 $("#CourseJSON").val(JSON.stringify(courseJSON));
                                             }
                                         },
                                         error: function (xhr, status, error)
                                         {
                                             $(".modulewrapper").css("cursor", "default");

                                             $("#CourseJSON").val('');

                                             var r = jQuery.parseJSON(xhr.responseText);
                                             alert(r.Message);
                                         }
                                     });
                                },
                                editable: false,
                                events: eventdata
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }

    function filterByCourseStatus(status)
    {
        $("#CRSwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            /*remove previous calendar data*/

            $("#calendar").empty();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'status':'" + status + "'}",
                url: getServiceURL().concat('filterCourseScheduleByStatus'),
                success: function (data)
                {

                    var data = $.parseJSON(data.d);

                    $("#CRSwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var eventdata = new Array();


                        $(data).each(function (index, value) {
                            var event =
                            {
                                id: value.id,
                                title: value.title,
                                start: new Date(parseInt(value.start.substr(6))),

                                end: value.end == null ? null : new Date(parseInt(value.end.substr(6)))
                            };
                            eventdata.push(event);
                        });

                        $('#calendar').fullCalendar(
                        {
                            header: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month'
                            },
                            eventClick: function (calEvent, jsEvent, view)
                            {
                                $(".modulewrapper").css("cursor", "wait");

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{'courseID':'" + calEvent.id + "'}",
                                    url: getServiceURL().concat("getCourse"),
                                    success: function (data)
                                    {
                                        $(".modulewrapper").css("cursor", "default");

                                        if (data)
                                        {
                                            var xmlCourse = $.parseXML(data.d);
                                            var course = $(xmlCourse).find('Course');

                                            $("#<%=CRSIDTxt.ClientID%>").val(course.attr('CourseNo'));

                                            if (course.find("EndDate").text() == '') {
                                                $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy"));
                                            }
                                            else {
                                                $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy") + " To " + new Date(course.find("EndDate").text()).format("dd/MM/yyyy"));
                                            }


                                            showCourseOption(jsEvent.pageX, jsEvent.pageY);

                                            /* create temporary JSON course for future reference*/
                                            var courseJSON =
                                            {
                                                ID: course.attr('CourseID'),
                                                CourseNo: course.attr('CourseNo'),
                                                Capacity: course.attr('Capacity'),
                                                Status: course.attr('CourseStatus'),
                                                Mode: course.attr('ModeString')
                                            }

                                            /*serialize and temprary store json data*/
                                            $("#CourseJSON").val(JSON.stringify(courseJSON));
                                        }
                                    },
                                    error: function (xhr, status, error) {
                                        $(".modulewrapper").css("cursor", "default");

                                        $("#CourseJSON").val('');

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(r.Message);
                                    }
                                });
                            },
                            editable: false,
                            events: eventdata
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#CRSwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterByCourseNo(courseno)
    {
        $("#CRSwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");


            /*remove previous calendar data*/
            $("#calendar").empty();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'courseno':'" + courseno + "'}",
                url: getServiceURL().concat('filterCourseScheduleByNumber'),
                success: function (data) {

                    var data = $.parseJSON(data.d);

                    $("#CRSwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var eventdata = new Array();


                        $(data).each(function (index, value) {
                            var event =
                            {
                                id: value.id,
                                title: value.title,
                                start: new Date(parseInt(value.start.substr(6))),

                                end: value.end == null ? null : new Date(parseInt(value.end.substr(6)))
                            };
                            eventdata.push(event);
                        });

                        $('#calendar').fullCalendar(
                        {
                            header: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month'
                            },
                            eventClick: function (calEvent, jsEvent, view) {
                                $(".modulewrapper").css("cursor", "wait");

                                $.ajax(
                                 {
                                     type: "POST",
                                     contentType: "application/json; charset=utf-8",
                                     dataType: "json",
                                     data: "{'courseID':'" + calEvent.id + "'}",
                                     url: getServiceURL().concat("getCourse"),
                                     success: function (data) {
                                         $(".modulewrapper").css("cursor", "default");

                                         if (data) {
                                             var xmlCourse = $.parseXML(data.d);
                                             var course = $(xmlCourse).find('Course');

                                             $("#<%=CRSIDTxt.ClientID%>").val(course.attr('CourseNo'));

                                             if (course.find("EndDate").text() == '') {
                                                 $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy"));
                                             }
                                             else {
                                                 $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy") + " To " + new Date(course.find("EndDate").text()).format("dd/MM/yyyy"));
                                             }


                                             showCourseOption(jsEvent.pageX, jsEvent.pageY);

                                             /* create temporary JSON course for future reference*/
                                             var courseJSON =
                                             {
                                                 ID: course.attr('CourseID'),
                                                 CourseNo: course.attr('CourseNo'),
                                                 Capacity: course.attr('Capacity'),
                                                 Status: course.attr('CourseStatus'),
                                                 Mode: course.attr('ModeString')
                                             }

                                             /*serialize and temprary store json data*/
                                             $("#CourseJSON").val(JSON.stringify(courseJSON));
                                         }
                                     },
                                     error: function (xhr, status, error) {
                                         $(".modulewrapper").css("cursor", "default");

                                         $("#CourseJSON").val('');

                                         var r = jQuery.parseJSON(xhr.responseText);
                                         alert(r.Message);
                                     }
                                 });
                            },
                            editable: false,
                            events: eventdata
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#CRSwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }


    function filterByStartDateRange(start, end)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var startdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var enddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(startdate) != true && isNaN(enddate) != true) {
            $("#CRSwait").stop(true).hide().fadeIn(500, function () {
                $(".modulewrapper").css("cursor", "wait");


                /*remove previous calendar data*/
                $("#calendar").empty();

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
                    url: getServiceURL().concat('filterCourseScheduleByStartDate'),
                    success: function (data) {
                        var data = $.parseJSON(data.d);

                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var eventdata = new Array();


                            $(data).each(function (index, value) {
                                var event =
                                {
                                    id: value.id,
                                    title: value.title,
                                    start: new Date(parseInt(value.start.substr(6))),

                                    end: value.end == null ? null : new Date(parseInt(value.end.substr(6)))
                                };
                                eventdata.push(event);
                            });

                            $('#calendar').fullCalendar(
                            {
                                header: {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                                eventClick: function (calEvent, jsEvent, view) {
                                    $(".modulewrapper").css("cursor", "wait");

                                    $.ajax(
                                     {
                                         type: "POST",
                                         contentType: "application/json; charset=utf-8",
                                         dataType: "json",
                                         data: "{'courseID':'" + calEvent.id + "'}",
                                         url: getServiceURL().concat("getCourse"),
                                         success: function (data) {
                                             $(".modulewrapper").css("cursor", "default");

                                             if (data) {
                                                 var xmlCourse = $.parseXML(data.d);
                                                 var course = $(xmlCourse).find('Course');

                                                 $("#<%=CRSIDTxt.ClientID%>").val(course.attr('CourseNo'));

                                                 if (course.find("EndDate").text() == '') {
                                                     $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy"));
                                                 }
                                                 else {
                                                     $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy") + " To " + new Date(course.find("EndDate").text()).format("dd/MM/yyyy"));
                                                 }


                                                 showCourseOption(jsEvent.pageX, jsEvent.pageY);

                                                 /* create temporary JSON course for future reference*/
                                                 var courseJSON =
                                                 {
                                                     ID: course.attr('CourseID'),
                                                     CourseNo: course.attr('CourseNo'),
                                                     Capacity: course.attr('Capacity'),
                                                     Status: course.attr('CourseStatus'),
                                                     Mode: course.attr('ModeString')
                                                 }

                                                 /*serialize and temprary store json data*/
                                                 $("#CourseJSON").val(JSON.stringify(courseJSON));
                                             }
                                         },
                                         error: function (xhr, status, error) {
                                             $(".modulewrapper").css("cursor", "default");

                                             $("#CourseJSON").val('');

                                             var r = jQuery.parseJSON(xhr.responseText);
                                             alert(r.Message);
                                         }
                                     });
                                },
                                editable: false,
                                events: eventdata
                            });
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#CRSwait").fadeOut(500, function () {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }
    function filterByCourseTitle(title)
    {
        $("#CRSwait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");


            /*remove previous calendar data*/
            $("#calendar").empty();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                data: "{'title':'" + title + "'}",
                url: getServiceURL().concat('filterCourseScheduleByTitle'),
                success: function (data) {

                    var data = $.parseJSON(data.d);

                    $("#CRSwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                         var eventdata = new Array();


                        $(data).each(function (index, value) {
                            var event =
                            {
                                id: value.id,
                                title: value.title,
                                start: new Date(parseInt(value.start.substr(6))),

                                end: value.end == null ? null : new Date(parseInt(value.end.substr(6)))
                            };
                            eventdata.push(event);
                        });

                        $('#calendar').fullCalendar(
                        {
                            header: {
                                left: 'prev,next today',
                                center: 'title',
                                right: 'month'
                            },
                            eventClick: function (calEvent, jsEvent, view)
                            {
                                $(".modulewrapper").css("cursor", "wait");

                                $.ajax(
                                 {
                                     type: "POST",
                                     contentType: "application/json; charset=utf-8",
                                     dataType: "json",
                                     data: "{'courseID':'" + calEvent.id + "'}",
                                     url: getServiceURL().concat("getCourse"),
                                     success: function (data)
                                     {
                                         $(".modulewrapper").css("cursor", "default");

                                         if (data)
                                         {
                                             var xmlCourse = $.parseXML(data.d);
                                             var course = $(xmlCourse).find('Course');

                                             $("#<%=CRSIDTxt.ClientID%>").val(course.attr('CourseNo'));

                                             if (course.find("EndDate").text() == '') {
                                                 $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy"));
                                             }
                                             else {
                                                 $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy") + " To " + new Date(course.find("EndDate").text()).format("dd/MM/yyyy"));
                                             }


                                             showCourseOption(jsEvent.pageX, jsEvent.pageY);

                                             /* create temporary JSON course for future reference*/
                                             var courseJSON =
                                             {
                                                 ID: course.attr('CourseID'),
                                                 CourseNo: course.attr('CourseNo'),
                                                 Capacity: course.attr('Capacity'),
                                                 Status: course.attr('CourseStatus'),
                                                 Mode: course.attr('ModeString')
                                             }

                                             /*serialize and temprary store json data*/
                                             $("#CourseJSON").val(JSON.stringify(courseJSON));
                                         }
                                     },
                                     error: function (xhr, status, error)
                                     {
                                         $(".modulewrapper").css("cursor", "default");

                                         $("#CourseJSON").val('');

                                         var r = jQuery.parseJSON(xhr.responseText);
                                         alert(r.Message);
                                     }
                                 });
                            },
                            editable: false,
                            events: eventdata
                        });
                    });
                },
                error: function (xhr, status, error) {
                    $("#CRSwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadCourseSchedule() {
        $("#CRSwait").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");
            /*remove previous calendar data*/

            $("#calendar").empty();

            $.ajax(
            {
                type: "POST",
                contentType: "application/json",
                dataType: "json",
                url: getServiceURL().concat('loadCourseSchedule'),
                success: function (data) {

                    var data = $.parseJSON(data.d);

                    $("#CRSwait").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var eventdata = new Array();


                        $(data).each(function (index, value) {
                            var event =
                            {
                                id: value.id,
                                title: value.title,
                                start: new Date(parseInt(value.start.substr(6))),
                                end: value.end == null ? null : new Date(parseInt(value.end.substr(6)))
                            };
                            eventdata.push(event);
                        });

                        $('#calendar').fullCalendar(
                        {
                            header:
                                {
                                    left: 'prev,next today',
                                    center: 'title',
                                    right: 'month'
                                },
                            eventClick: function (calEvent, jsEvent, view) {

                                $(".modulewrapper").css("cursor", "wait");

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{'courseID':'" + calEvent.id + "'}",
                                    url: getServiceURL().concat("getCourse"),
                                    success: function (data)
                                    {
                                        $(".modulewrapper").css("cursor", "default");

                                        if (data)
                                        {
                                            var xmlCourse = $.parseXML(data.d);
                                            var course = $(xmlCourse).find('Course');

                                            $("#<%=CRSIDTxt.ClientID%>").val(course.attr('CourseNo'));

                                            if (course.find("EndDate").text() == '') {
                                                $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy"));
                                            }
                                            else {
                                                $("#<%=CRSDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy") + " To " + new Date(course.find("EndDate").text()).format("dd/MM/yyyy"));
                                            }


                                            showCourseOption(jsEvent.pageX, jsEvent.pageY);

                                            /* create temporary JSON course for future reference*/
                                            var courseJSON =
                                            {
                                                ID: course.attr('CourseID'),
                                                CourseNo: course.attr('CourseNo'),
                                                Capacity: course.attr('Capacity'),
                                                Status: course.attr('CourseStatus'),
                                                Mode: course.attr('ModeString')
                                            }

                                            /*serialize and temprary store json data*/
                                            $("#CourseJSON").val(JSON.stringify(courseJSON));
                                        }
                                    },
                                    error: function (xhr, status, error)
                                    {
                                        $(".modulewrapper").css("cursor", "default");

                                        $("#CourseJSON").val('');

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(r.Message);
                                    }
                                });
                            },
                            editable: false,
                            events: eventdata
                        });
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#CRSwait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function bindCourseData(data)
    {
        var xmlCourse = $.parseXML(data);

        var course = $(xmlCourse).find('Course');

        if (course != null)
        {
            /*clear previous data*/
            resetGroup('.modalPanel');

            /*store the ID of the course*/
            $("#CourseID").val(course.attr('CourseID'));

            $("#<%=CRSNMTxt.ClientID%>").val(course.attr('CourseTitle'));

            /*attach course title to limit plugin*/
            $('#<%=CRSNMTxt.ClientID%>').limit({ id_result: 'ttllimit', alertClass: 'alertremaining', limit: 250 });

            /*trigger course title keyup event to activate the remaining limit*/
            $('#<%=CRSNMTxt.ClientID%>').keyup();

            /*bind the name of the course material if exists*/
            $("#<%=CDOCTxt.ClientID%>").val(course.attr('Material'));

            if (course.attr('Description') != '' && course.attr('Description') != null)
            {
                if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext"))
                {
                    $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                }

                $("#<%=DESCTxt.ClientID%>").html(course.attr('Description')).text();
            }
            else
            {
                addWaterMarkText('The description of the course', '#<%=DESCTxt.ClientID%>');
            }

            $("#<%=STDTTxt.ClientID%>").val(new Date(course.attr('StartDate')).format("dd/MM/yyyy"));
            $("#<%=ENDDTTxt.ClientID%>").val(course.find("EndDate").text() == '' ? '' : new Date(course.find("EndDate").text()).format("dd/MM/yyyy"));

            $("#<%=CRDTxt.ClientID%>").val(course.attr('Coordinator'));
            $("#<%=CAPTxt.ClientID%>").val(course.attr('Capacity'));
            $("#<%=COURSDURTxt.ClientID%>").val(course.attr('Duration') == 0 ? '' : course.attr('Duration'));

            if (course.attr("IncludeLunch") == 'true') {
                $("#LNCHCHK").prop('checked', true);
            }
            else {
                $("#LNCHCHK").prop('checked', false);
            }

            if (course.attr("IncludeRefreshment") == 'true') {
                $("#REFCHK").prop('checked', true);
            }
            else {
                $("#REFCHK").prop('checked', false);
            }

            if (course.attr("IncludeTransporation") == 'true') {
                $("#TRNSCHK").prop('checked', true);
            }
            else {
                $("#TRNSCHK").prop('checked', false);
            }

            if (course.attr('Notes') != '' && course.attr('Notes') != null) {
                if ($("#<%=RMKTxt.ClientID%>").hasClass("watermarktext")) {
                    $("#<%=RMKTxt.ClientID%>").val('').removeClass("watermarktext");
                }

                /*decode the encrypted text*/

                $("#<%=RMKTxt.ClientID%>").html(course.attr('Notes')).text();
            }
            else {
                addWaterMarkText('Additional notes in the support of the course record', '#<%=RMKTxt.ClientID%>');
            }


            bindComboboxAjax('loadCourseStatus', "#<%=CRSTSCBox.ClientID%>", course.attr('CourseStatus'), "#CRSSTS_LD");
            bindComboboxAjax('loadPeriod', "#<%=COURSPRDCBox.ClientID%>", course.attr('Period'), "#COURSPRD_LD");

            if (course.attr('CourseStatus') == 'Completed' || course.attr('CourseStatus') == 'Cancelled') {
                $("#CourseTooltip").find('p').text("Changes cannot take place since the course status is " + course.attr('CourseStatus'));

                if ($("#CourseTooltip").is(":hidden")) {
                    $("#CourseTooltip").slideDown(800, 'easeOutBounce');
                }

                /*disable all modal controls*/
                ActivateAll(false);
            }
            else if (course.attr('ModeString') == 'Archived')
            {
                $("#CourseTooltip").find('p').text("Changes cannot take place since the course was sent to archive");

                if ($("#CourseTooltip").is(":hidden")) {
                    $("#CourseTooltip").slideDown(800, 'easeOutBounce');
                }

                /*disable all modal controls*/
                ActivateAll(false);
            }
            else 
            {
                $("#CourseTooltip").hide();

                /*enable all modal controls for editing*/
                ActivateAll(true);
            }

            $("#CourseOption").hide('800');
           
            $("#<%=alias.ClientID%>").trigger('click');
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

    function setEndDate(date, duration, period) {
        var sd = getDatePart(date);

        var startDate = new Date(sd[2], (sd[1] - 1), sd[0]);

        if (isNaN(startDate) == false) {
            switch (period) {
                case "Years":
                    $("#<%=ENDDTTxt.ClientID%>").val(startDate.addYears(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
                case "Months":
                    $("#<%=ENDDTTxt.ClientID%>").val(startDate.addMonths(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
                case "Days":
                    $("#<%=ENDDTTxt.ClientID%>").val(startDate.addDays(parseInt(duration)).format("dd/MM/yyyy"));
                    break;
            }
        }
    }

    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 310, top: y - 150 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#UNT_LD");
        $("#SelectORG").show();
    }

    function showDOCTYPDialog(x, y)
    {
        $("#SelectDOCTYP").css({ left: x - 310, top: y - 150 });
        loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYPCBox.ClientID%>", "#DOCTYP_LD");
        $("#SelectDOCTYP").show();
    }

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });
    }
    </script>
</asp:Content>
