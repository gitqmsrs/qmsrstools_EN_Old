<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateProject.aspx.cs" Inherits="QMSRSTools.ProjectManagement.CreateProject" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="Project_Header" class="moduleheader">Create a New Project</div>

    <div class="toolbox">
        <img id="save" src="http://www.qmsrs.com/qmsrstools/Images/save.png" class="imgButton" title="Save Changes" alt="Save Changes" /> 
    </div>
 
    <div id="ProjectGroupHeader" class="groupboxheader">Project Details</div>
    <div id="ProjectGroupField" class="groupbox" style="height:520px;">

        <div id="validation_dialog_general" class="validationcontainer" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>
   
        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="ProjectNoLabel" class="requiredlabel">Project No:</div>
            <div id="ProjectNoField" class="fielddiv" style="width:auto;">
                <asp:TextBox ID="PROJNoTxt" runat="server" CssClass="textbox"></asp:TextBox>
                <asp:Label ID="PROJNoLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
            </div>

            <div id="IDlimit" class="textremaining"></div>
           
            <asp:RequiredFieldValidator ID="PROJNoVal" runat="server" Display="None" ControlToValidate="PROJNoTxt" ErrorMessage="Enter a unique ID for the project" ValidationGroup="General"></asp:RequiredFieldValidator>
           
            <asp:CustomValidator id="PROJNoTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "PROJNoTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
            ClientValidationFunction="validateIDField">
            </asp:CustomValidator>   
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectTitleLabel" class="requiredlabel">Project Title:</div>
            <div id="ProjectTitleField" class="fielddiv" style="width:300px;">
                <asp:TextBox ID="PROJNMTxt" runat="server" CssClass="textbox" Width="290px"></asp:TextBox>
            </div>
            
            <div id="PROJNMlimit" class="textremaining"></div>  
          
            <asp:RequiredFieldValidator ID="PROJNMTxtVal" runat="server" Display="None" ControlToValidate="PROJNMTxt" ErrorMessage="Enter the title of the project" ValidationGroup="General"></asp:RequiredFieldValidator>

            <asp:CustomValidator id="PROJNMTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "PROJNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
    
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectDescriptionLabel" class="labeldiv">Project Description:</div>
            <div id="ProjectDescriptionField" class="fielddiv" style="width:400px; height:190px;">
                <asp:TextBox ID="PROJDESCTxt" runat="server" CssClass="textbox" Width="390px" Height="187px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="PROJDESCTxtVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "PROJDESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:189px;">
            <div id="ProjectLabel" class="requiredlabel">Project Leader:</div>
            <div id="ProjectField" class="fielddiv" style="width:250px;">
                <asp:DropDownList ID="PROJLDRCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="LDR_LD" class="control-loader"></div>

            <span id="PROJLDRSelect" class="searchactive" style="margin-left:10px" runat="server"></span>
            
            <asp:RequiredFieldValidator ID="PROJLDRCBoxTxtVal" runat="server" Display="None" ControlToValidate="PROJLDRCBox" ErrorMessage="Select the leader of the project" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <asp:CompareValidator ID="PROJLDRCBoxVal" runat="server" Display="None" ControlToValidate="PROJLDRCBox" ValidationGroup="General"
            ErrorMessage="Select the leader of the project" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="StartDateLabel" class="requiredlabel">Start Date:</div>
            <div id="StartDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="STRTDTTxt" runat="server" CssClass="date" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            
            <asp:RequiredFieldValidator ID="STRTDTTxtVal" runat="server" Display="None" ControlToValidate="STRTDTTxt" ErrorMessage="Enter the start date of the project"  ValidationGroup="General"></asp:RequiredFieldValidator>  
            
            <asp:RegularExpressionValidator ID="STRTDTTxtFVal" runat="server" ControlToValidate="STRTDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator>
            
            <asp:CustomValidator id="STRTDTTxtF2Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "STRTDTTxt" Display="None" ErrorMessage = "Start date of the project should match today's date"
            ClientValidationFunction="compareEqualsToday">
            </asp:CustomValidator>  

            <asp:CustomValidator id="STRTDTTxtF3Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "STRTDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div> 

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="PlannedCloseDateLabel" class="requiredlabel">Planned Close Date:</div>
            <div id="PlannedCloseDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="PLNNDCLSDTTxt" runat="server" Width="140px" CssClass="date" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>      
            <asp:RequiredFieldValidator ID="PLNCLSDTTxtVal" runat="server" Display="None" ControlToValidate="PLNNDCLSDTTxt" ErrorMessage="Enter the planned close date of the project"  ValidationGroup="General"></asp:RequiredFieldValidator>  
            
            <asp:RegularExpressionValidator ID="PLNCLSDTFVal" runat="server" ControlToValidate="PLNNDCLSDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" CssClass="validator" ValidationGroup="General"></asp:RegularExpressionValidator>  
            
            <asp:CompareValidator ID="PLNCLSDTF2Val" runat="server" ControlToCompare="STRTDTTxt"  ValidationGroup="General"
            ControlToValidate="PLNNDCLSDTTxt" ErrorMessage="Planned close date should be greater or equals start date"
            Operator="GreaterThanEqual" Type="Date"
            Display="None"></asp:CompareValidator> 

            <asp:CustomValidator id="PLNNDCLSDTF3Val" runat="server" ValidationGroup="General" 
            ControlToValidate = "PLNNDCLSDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectValueLabel" class="requiredlabel">Project Value:</div>
            <div id="ProjectValueField" class="fielddiv" style="width:240px">
                <asp:TextBox ID="PROJValTxt" runat="server" CssClass="textbox" Width="150px"></asp:TextBox>
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:DropDownList ID="CURRCBox" AutoPostBack="false" runat="server" Width="60px" CssClass="combobox">
                </asp:DropDownList>     
            </div>     
            <div id="CURR_LD" class="control-loader"></div>
            
            <asp:RequiredFieldValidator ID="PROJValTxtVal" runat="server" Display="None" ControlToValidate="PROJValTxt" ErrorMessage="Enter the value of the project" ValidationGroup="General"></asp:RequiredFieldValidator>
            
            <asp:RegularExpressionValidator ID="PROJValTxtFval" runat="server" ControlToValidate="PROJValTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]+)?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
            
            <asp:RequiredFieldValidator ID="CURRCBoxTxtVal" runat="server" Display="None" ControlToValidate="CURRCBox" ErrorMessage="Select currency" ValidationGroup="General"></asp:RequiredFieldValidator>         
            
            <asp:CompareValidator ID="CURRCBoxVal" runat="server" ControlToValidate="CURRCBox" ValidationGroup="General"
            Display="None" ErrorMessage="Select currency" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ProjectCostLabel" class="requiredlabel">Project Cost:</div>
            <div id="ProjectCostField" class="fielddiv" style="width:240px">
                <asp:TextBox ID="PROJCSTTxt" runat="server" CssClass="textbox" Width="150px"></asp:TextBox>
                <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                <asp:TextBox ID="PROJCSTCURR" runat="server" CssClass="readonly" ReadOnly="true" Width="50px"></asp:TextBox>
            </div>     
            <asp:RequiredFieldValidator ID="PROJCSTTxtVal" runat="server" Display="None" ControlToValidate="PROJCSTTxt" ErrorMessage="Enter the cost of the project" ValidationGroup="General"></asp:RequiredFieldValidator>
      
            <asp:RegularExpressionValidator ID="PROJCSTTxtFVal" runat="server" ControlToValidate="PROJCSTTxt"
            Display="None" ErrorMessage="Enter decimal amount e.g. 2500.75" ValidationExpression="^[0-9]+(\.[0-9]+)?$" ValidationGroup="General"></asp:RegularExpressionValidator>  
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
    </div>
    
    <asp:Panel ID="SavePanel" CssClass="savepanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Saving...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="SaveExtender" runat="server" TargetControlID="SavePanel" PopupControlID="SavePanel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

</div>    
<script type="text/javascript" language="javascript">
        $(function ()
        {
            /*Obtain the latest project ID*/
            loadLastIDAjax('getProjectID', "#<%=PROJNoLbl.ClientID%>");

            /*attach project ID to limit plugin*/
            $("#<%=PROJNoTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

            /*attach project name to limit plugin*/
            $('#<%=PROJNMTxt.ClientID%>').limit({ id_result: 'PROJNMlimit', alertClass: 'alertremaining', limit: 250 });

            addWaterMarkText('The Details of the Project', '#<%=PROJDESCTxt.ClientID%>');

            /*load the currencies*/
            loadComboboxAjax('loadCurrencies', "#<%=CURRCBox.ClientID%>", "#CURR_LD");

            /*show organization unit box when clicking over the leader field cboxes*/
            /*set the position according to mouse x and y coordination*/
            $("#<%=PROJLDRSelect.ClientID%>").bind('click',function (e)
            {
                showORGDialog(e.pageX, e.pageY);
            });

            /*populate the employees in owner, originator, and executive cboxes*/
            $("#<%=ORGUNTCBox.ClientID%>").change(function ()
            {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=PROJLDRCBox.ClientID%>");
                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam,"#LDR_LD");

                $("#SelectORG").hide('800');
            });

            /*close organization unit box*/
            $("#closeORG").bind('click', function ()
            {
                $("#SelectORG").hide('800');
            });

            $("#<%=STRTDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=PLNNDCLSDTTxt.ClientID%>").datepicker(
            {
                inline: true,
                dateFormat: "dd/mm/yy",
                onSelect: function () { }
            });

            $("#<%=CURRCBox.ClientID%>").change(function ()
            {
                if ($(this).val() != 0)
                {
                    $("#<%=PROJCSTCURR.ClientID%>").val($(this).val());
                }
            });

            /*Save changes*/
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
                        var startdate = getDatePart($("#<%=STRTDTTxt.ClientID%>").val());
                        var target = getDatePart($("#<%=PLNNDCLSDTTxt.ClientID%>").val());


                        var project =
                        {
                            ProjectNo: $("#<%=PROJNoTxt.ClientID%>").val(),
                            ProjectName: $("#<%=PROJNMTxt.ClientID%>").val(),
                            Description: $("#<%=PROJDESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=PROJDESCTxt.ClientID%>").val()),
                            ProjectLeader: $("#<%=PROJLDRCBox.ClientID%>").val(),
                            Currency: $("#<%=CURRCBox.ClientID%>").val(),
                            ProjectValue: $("#<%=PROJValTxt.ClientID%>").val(),
                            ProjectCost:  $("#<%=PROJCSTTxt.ClientID%>").val(),
                            StartDate: new Date(startdate[2], (startdate[1] - 1), startdate[0]),
                            PlannedCloseDate: new Date(target[2], (target[1] - 1), target[0])
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json",
                            dataType: "json",
                            data: "{'json':'" + JSON.stringify(project) + "'}",
                            url: getServiceURL().concat('createNewProject'),
                            success: function (data)
                            {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                alert(data.d);

                                /*reset default values*/

                                /*Obtain the latest project ID*/
                                loadLastIDAjax('getProjectID', "#<%=PROJNoLbl.ClientID%>");

                                reset();


                                $(".textbox").each(function ()
                                {
                                    $(this).keyup();
                                });

                                /*restore watermarks*/
                                if (!$("#<%=PROJDESCTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    addWaterMarkText('The Details of the Project', '#<%=PROJDESCTxt.ClientID%>');
                                }

                                $(".validationcontainer").each(function ()
                                {
                                    $(this).hide();
                                });
                            },
                            error: function (xhr, status, error)
                            {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(xhr.responseText);
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
        function showORGDialog(x, y)
        {
            $("#SelectORG").css({ left: x - 230, top: y - 1 });
            loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");
            $("#SelectORG").show();
        }
    </script>
</asp:Content>
