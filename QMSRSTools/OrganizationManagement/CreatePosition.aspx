<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="CreatePosition.aspx.cs" Inherits="QMSRSTools.OrganizationManagement.CreatePosition" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="POS_Header" class="moduleheader">Create New Position</div>

    <div class="toolbox">
        <img id="save" src="/Images/save.png" class="imgButton" title="Save Changes" alt=""/> 
    </div>

    <div style="float:left; width:100%; height:20px; margin-top:15px;">
        <ul id="tabul">
            <li id="Details" class="ntabs">Vacancy Details</li>
            <li id="Skills" class="ntabs">Required Skills</li>
        </ul>
    
        <div id="DetailsTB" class="tabcontent" style="display:none;">
            
            <div id="validation_dialog_general" style="display: none">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
            </div>        
            
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

               <%-- <asp:CustomValidator id="ODateTxtF2Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "ODateTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>--%>
            </div>        
            
            <div style="float:left; width:100%; height:20px; margin-top:15px;">
                <div id="ExpiryDateLabel" class="requiredlabel">Closing Date:</div>
                <div id="ExpiryDateField" class="fielddiv" style="width:150px">
                    <asp:TextBox ID="CLDateTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
                </div>

                <asp:RequiredFieldValidator ID="CLDateTxtVal" runat="server" Display="None" ControlToValidate="CLDateTxt" ErrorMessage="Enter the closing date of the position" ValidationGroup="General"></asp:RequiredFieldValidator>
            
                <asp:RegularExpressionValidator ID="CLDateTxtFVal" runat="server" ControlToValidate="CLDateTxt"
                Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$" ValidationGroup="General"></asp:RegularExpressionValidator> 
            
                <%--<asp:CompareValidator ID="CLDateTxtF2Val" runat="server" ControlToCompare="ODateTxt"  ValidationGroup="General"
                ControlToValidate="CLDateTxt" ErrorMessage="Closing date should be greater or equals the opening date"
                Operator="GreaterThanEqual" Type="Date" Display="None"></asp:CompareValidator>
                --%>
               <%-- <asp:CustomValidator id="CLDateTxtF3Val" runat="server" ValidationGroup="General" 
                ControlToValidate = "CLDateTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
                ClientValidationFunction="validateDate">
                </asp:CustomValidator>  --%>
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
        </div>
        <div id="SkillsTB" class="tabcontent" style="display:none;">
            <img id="newskill" src="/Images/new_file.png" class="imgButton" title="Create new skill" alt=""/>
          
            <div id="table" style="display:none;">
                <div id="row_header" class="tr">
                    <div id="col0_head" class="tdh" style="width:50px"></div>
                    <div id="col1_head" class="tdh" style="width:35%">Skill</div>
                    <div id="col2_head" class="tdh" style="width:35%">Description</div>
                </div>
            </div>
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

    loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>","#ORG_LD");

    /*attach job title to limit plugin*/
    $("#<%=POSTxt.ClientID%>").limit({ id_result: 'JTTLlimit', alertClass: 'alertremaining', limit: 100 });

    addWaterMarkText('Enter the description of the job', '#<%=POSDTxt.ClientID%>');

    var skillsjson =
    [
    ];

    var json = $.parseJSON(JSON.stringify(skillsjson));

    var attributes = new Array();
    attributes.push("SKL");
    attributes.push("DESC");

    var settings = new Array();
    settings.push(JSON.stringify({}));
    settings.push(JSON.stringify({}));

    $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 35 });

    navigate('Details');

    $("#newskill").bind('click', function () {
        $("#table").table('addRow',
        {
            SKL: 'New Skill',
            DESC: 'Description',
            Status: 3
        });
    });

    $("#tabul li").bind("click", function () {
        navigate($(this).attr("id"));
    });

    $("#<%=Self.ClientID%>").click(function ()
    {
        $("#OtherPosition").stop(true).hide();
    });

    $("#<%=Other.ClientID%>").click(function ()
    {
        if ($("#<%=ORGUNTCBox.ClientID%>").val() != 0) {
            $("#OtherPosition").stop(true).hide().fadeIn(800, function () {
                var loadcontrols = new Array();
                loadcontrols.push('#<%=REPPOS_CBox.ClientID%>');
                loadParamComboboxAjax('getParentDepPositions', loadcontrols, "'unit':'" + $("#<%=ORGUNTCBox.ClientID%>").val() + "'", "#REPPOS_LD");
            });
        }
        else {
            alert("Please select an organization unit");

            $(this).prop('checked', false);
        }
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

    $("#save").bind('click', function () {
        var isGeneralValid = Page_ClientValidate('General');
        if (isGeneralValid)
        {
            if (!$("#validation_dialog_general").is(":hidden")) {
                $("#validation_dialog_general").hide();
            }

            var result = confirm("Are you sure you would like to submit changes?");
            if (result == true)
            {
                $find('<%= SaveExtender.ClientID %>').show();

                var posOpenDate = getDatePart($("#<%=ODateTxt.ClientID%>").val());
                var posCloseDate = getDatePart($("#<%=CLDateTxt.ClientID%>").val());

                var newposition =
                {
                    Title: $("#<%=POSTxt.ClientID%>").val(),
                    Description: $("#<%=POSDTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=POSDTxt.ClientID%>").val()),
                    OpenDate: new Date(posOpenDate[2], (posOpenDate[1] - 1), posOpenDate[0]),
                    CloseDate: new Date(posCloseDate[2], (posCloseDate[1] - 1), posCloseDate[0]),
                    Unit: $("#<%=ORGUNTCBox.ClientID%>").val(),
                    /*if the supervisor from other position was not provided, then the system assumes that the current position is also a supervisor*/
                    Supervisor: $("#<%=REPPOS_CBox.ClientID%>").val() == 0 || $("#<%=REPPOS_CBox.ClientID%>").val() == null ? 'Self' : $("#<%=REPPOS_CBox.ClientID%>").val(),
                    Skills: $("#table").table('getJSON')
                }

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json",
                    dataType: "json",
                    data: "{\'json\':\'" + JSON.stringify(newposition) + "\','unit':'" + $("#<%=ORGUNTCBox.ClientID%>").val() + "'}",
                    url: getServiceURL().concat('createNewPosition'),
                    success: function (data) {
                        $find('<%= SaveExtender.ClientID %>').hide();

                        showSuccessNotification(data.d);

                        reset();

                        addWaterMarkText('Enter the description of the job', '#<%=POSDTxt.ClientID%>');

                        $("#<%=POSTxt.ClientID%>").keyup();

                        $("#table .tr").not($("#table .tr:first-child")).remove();

                        $("#<%=Self.ClientID%>").prop('checked', false);
                        $("#<%=Other.ClientID%>").prop('checked', false);

                        navigate('Details');
                    },
                    error: function (xhr, status, error) {
                        $find('<%= SaveExtender.ClientID %>').hide();

                        var r = jQuery.parseJSON(xhr.responseText);
                        showErrorNotification(r.Message);
                    }
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


        function navigate(name) {
            $("#tabul li").removeClass("ctab");

            $(".tabcontent").each(function () {
                $(this).css('display', 'none');
            });

            $("#" + name).addClass("ctab");
            $("#" + name + "TB").css('display', 'block');
        }


        function showSuccessNotification(message) {
            $().toastmessage('showSuccessToast', message);
        }

        function showErrorNotification(message) {
            $().toastmessage('showErrorToast', message);
        }
</script>   

</asp:Content>
