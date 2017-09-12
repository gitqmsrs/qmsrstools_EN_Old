<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateCourse.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.CreateCourse" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="Course_Header" class="moduleheader">Create a New Training Course</div>

    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt="Save Changes" /> 
    </div>

    <div class="tabcontent" style="margin-top:10px; height:600px; display:block;">
         <div id="validation_dialog_general">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
         </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="CRSIDLabel" class="requiredlabel">Course ID:</div>
            <div id="CRSIDField" class="fielddiv" style="width:auto;">
                <asp:TextBox ID="CRSIDTxt" runat="server" CssClass="textbox"></asp:TextBox>
                <asp:Label ID="CRSIDLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
            </div>

            <div id="IDlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="CRSIDVal" runat="server" Display="None" ControlToValidate="CRSIDTxt" ErrorMessage="Enter a unique ID of the course" ValidationGroup="General"></asp:RequiredFieldValidator>

            <asp:CustomValidator id="CRSIDTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "CRSIDTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
            ClientValidationFunction="validateIDField">
            </asp:CustomValidator>   
        </div>
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
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>

        </div>

        <div style="float:left; width:100%; height:20px; margin-top:122px;">
            <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
            <div id="StartDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="STDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="STDTVal" runat="server" Display="None" ControlToValidate="STDTTxt" ErrorMessage="Enter the start date of the course" ValidationGroup="General"></asp:RequiredFieldValidator>
        
            <asp:RegularExpressionValidator ID="STDTFVal" runat="server" ControlToValidate="STDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="STDTF2Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "STDTTxt" Display="None" ErrorMessage = "Start date of the course should be in future"
            ClientValidationFunction="compareFuture">
            </asp:CustomValidator>

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
                <asp:DropDownList ID="CRDTRCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="Coordinator_LD" class="control-loader"></div>       

            <span id="CRDSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting course coordinator"></span>
          
            <asp:RequiredFieldValidator ID="CRDTRCBoxTxtVal" runat="server" Display="None" ControlToValidate="CRDTRCBox" ErrorMessage="Select course coordinator" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CompareValidator ID="CRDTRCBoxVal" runat="server" ControlToValidate="CRDTRCBox"
            Display="None" ErrorMessage="Select course coordinator" Operator="NotEqual" Style="position: static"
            ValueToCompare="0" ValidationGroup="General"></asp:CompareValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
       
            <div id="CourseDocumentLabel" class="labeldiv">Course Material:</div>
            <div id="CourseDocumentField" class="fielddiv" style="width:250px">
                 <asp:DropDownList ID="DOCCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="DOC_LD" class="control-loader"></div>
     
            <span id="CDOCSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for document"></span> 
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
        </div>
        <div id="AccommodationGroupHeader" class="groupboxheader" style=" margin-top:30px;">Accommodation</div>
        <div id="AccommodationGroupField" class="groupbox" style="height:115px;">
            <div style="float:left; width:100%; height:20px; margin-top:10px;">
                <div id="LunchLabel" class="labeldiv">Including Lunch:</div>
                <div id="LunchField" class="fielddiv" style="width:250px">
                    <asp:CheckBox ID="LNCHCHK" runat="server" AutoPostBack="false" CssClass="checkbox" />
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="RefreshmentsLabel" class="labeldiv">Including Refreshments:</div>
                <div id="RefreshmentsField" class="fielddiv" style="width:250px">
                    <asp:CheckBox ID="REFCHK" runat="server" AutoPostBack="false" CssClass="checkbox" />
                </div>
            </div>

            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="TransportationLabel" class="labeldiv">Including Transportation:</div>
                <div id="TransportationField" class="fielddiv" style="width:250px">
                    <asp:CheckBox ID="TRNSCHK" runat="server" AutoPostBack="false" CssClass="checkbox" />
                </div>
            </div>
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
    </div>

    <asp:Panel ID="panel1" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="panel1" PopupControlID="panel1" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

</div>
<script type="text/javascript" language="javascript">
        $(function ()
        {
            var characterlength = 300;

            addWaterMarkText('The description of the course', '#<%=DESCTxt.ClientID%>');

            loadLastIDAjax('getCourseID', "#<%=CRSIDLbl.ClientID%>");

           
            loadComboboxAjax('loadPeriod', "#<%=COURSPRDCBox.ClientID%>", "#COURSPRD_LD");

            /*attach course ID to limit plugin*/
            $("#<%=CRSIDTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 90 });


            $("#<%=CDOCSRCH.ClientID%>").click(function (e)
            {
                showDOCTYPDialog(e.pageX, e.pageY);
            });

            /*filter course materials*/
            $("#<%=DOCTYPCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    var $obj = $(this);
                    $("#DOCTYP_LD").stop(true).hide().fadeIn(800, function ()
                    {
                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{'type':'" + $obj.val() + "'}",
                            url: getServiceURL().concat("loadCurrentDocuments"),
                            success: function (data)
                            {
                                $("#DOCTYP_LD").fadeOut(500, function ()
                                {
                                    if (data) {
                                        loadComboboxXML($.parseXML(data.d), 'DocFile', 'DOCTitle', $("#<%=DOCCBox.ClientID%>"), $("DOC_LD"));

                                        $("#SelectDOCTYP").hide('800');
                                    }
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $("#DOCTYP_LD").fadeOut(500, function ()
                                {
                                    var r = jQuery.parseJSON(xhr.responseText);
                                    alert(r.Message);

                                    $("#SelectDOCTYP").hide('800');
                                });
                            }
                        });
                    });
                }
            });
            

            $("#closeDOCTYP").bind('click', function () {
                $("#SelectDOCTYP").hide('800');
            });



            /*attach course title to limit plugin*/
            $('#<%=CRSNMTxt.ClientID%>').limit({ id_result: 'ttllimit', alertClass: 'alertremaining', limit: 250 });

            $("#<%=COURSPRDCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
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

            $("#<%=COURSDURTxt.ClientID%>").keyup(function ()
            {
                if ($("#<%=COURSPRDCBox.ClientID%>").val() != 0)
                {
                    var period = $("#<%=COURSPRDCBox.ClientID%>").val();
                    var duration = parseInt($(this).val());

                    setEndDate($("#<%=STDTTxt.ClientID%>").val(), duration, period);
                }
            });

           
            $("#<%=CRDSelect.ClientID%>").click(function (e)
            {
                showORGDialog(e.pageX, e.pageY);
            });

            /*populate the employees in coordinatorcboxes*/
            $("#<%=SORGUNTCBox.ClientID%>").change(function () 
            {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=CRDTRCBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#Coordinator_LD");
                
                $("#SelectORG").hide('800');
            });



            $("#<%=STDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function (date) {
                    var period = $("#<%=COURSPRDCBox.ClientID%>").find('option:selected').text();
                    var duration = parseInt($("#<%=COURSDURTxt.ClientID%>").val());

                    setEndDate(date, duration, period);
                }
            });


            $("#<%=ENDDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () {
                    $("#<%=COURSDURTxt.ClientID%>").val("");
                    $("#<%=COURSPRDCBox.ClientID%>").val("0");
                }
            });

            /*close organization unit box*/
            $("#closeORG").bind('click', function () {
                $("#SelectORG").hide('800');
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
                        $find('<%= SaveExtender.ClientID %>').show();

                        var startDateParts = getDatePart($("#<%=STDTTxt.ClientID%>").val());
                        var endDateParts = getDatePart($("#<%=ENDDTTxt.ClientID%>").val());

                        var course =
                        {
                            CourseNo:$("#<%=CRSIDTxt.ClientID%>").val(),
                            CourseTitle: $("#<%=CRSNMTxt.ClientID%>").val(),
                            Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val()),
                            Duration: $("#<%=COURSDURTxt.ClientID%>").val() == '' ? 0 : $("#<%=COURSDURTxt.ClientID%>").val(),
                            Period: ($("#<%=COURSPRDCBox.ClientID%>").val() == 0 || $("#<%=COURSPRDCBox.ClientID%>").val() == null ? '' : $("#<%=COURSPRDCBox.ClientID%>").val()),
                            StartDate: new Date(startDateParts[2], (startDateParts[1] - 1), startDateParts[0]),
                            EndDate: $("#<%=ENDDTTxt.ClientID%>").val() == '' ? null : new Date(endDateParts[2], (endDateParts[1] - 1), endDateParts[0]),
                            Material: ($("#<%=DOCCBox.ClientID%>").val() == 0 || $("#<%=DOCCBox.ClientID%>").val() == null ? '' : $("#<%=DOCCBox.ClientID%>").val()),
                            Coordinator: $("#<%=CRDTRCBox.ClientID%>").val(),
                            Capacity: $("#<%=CAPTxt.ClientID%>").val(),
                            IncludeLunch: $("#<%=LNCHCHK.ClientID%>").is(':checked'),
                            IncludeRefreshment: $("#<%=REFCHK.ClientID%>").is(':checked'),
                            IncludeTransporation: $("#<%=TRNSCHK.ClientID%>").is(':checked')
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(course) + "\'}",
                            url: getServiceURL().concat('createNewCourse'),
                            success: function (data) {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                alert(data.d);

                                resetGroup(".modulewrapper");

                                loadLastIDAjax('getCourseID', "#<%=CRSIDLbl.ClientID%>");

                                if (!$("#<%=DESCTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    addWaterMarkText('The description of the course', '#<%=DESCTxt.ClientID%>');
                                }

                                $("#<%=LNCHCHK.ClientID%>").prop('checked', false);
                                $("#<%=REFCHK.ClientID%>").prop('checked', false);
                                $("#<%=TRNSCHK.ClientID%>").prop('checked', false);
                 
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
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function ()
                    {
                        
                    });
                }
            });
        });

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
        $("#SelectORG").css({ left: x, top: y - 100 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#UNT_LD");
        $("#SelectORG").show();
    }

    function showDOCTYPDialog(x, y) {
        $("#SelectDOCTYP").css({ left: x, top: y - 100 });
        loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYPCBox.ClientID%>", "#DOCTYP_LD");
        $("#SelectDOCTYP").show();
    }

    </script>
</asp:Content>
