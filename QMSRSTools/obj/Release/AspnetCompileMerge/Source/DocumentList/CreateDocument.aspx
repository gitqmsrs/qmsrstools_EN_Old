<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CreateDocument.aspx.cs" Inherits="QMSRSTools.DocumentList.CreateDocument" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="DOC_Header" class="moduleheader">Create a New Document</div>

    <div class="toolbox">   
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt=""/>
    </div>

    <div id="DocumentTooltip" class="tooltip" style="margin-top:10px;">
        <img src="../Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <ul id="tabul" style="margin-top:60px;">
        <li id="Details" class="ntabs">Document Details</li>
        <li id="CCN" class="ntabs">Additional Information</li>
    </ul>

    <div id="DetailsTB" class="tabcontent" style="display:none; height:480px;">
        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="DOCNOLabel" class="requiredlabel">Document ID:</div>
            <div id="DOCNOField" class="fielddiv" style="width:auto;">
                <asp:TextBox ID="DOCNOTxt" runat="server" CssClass="textbox" Width="90px"></asp:TextBox>
                <asp:Label ID="DOCNOLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
            </div>
        
            <div id="IDlimit" class="textremaining"></div>
           
            <asp:RequiredFieldValidator ID="DOCNOVal" runat="server" Display="None" ControlToValidate="DOCNOTxt" ErrorMessage="Enter unique ID for the document" ValidationGroup="General"></asp:RequiredFieldValidator>     
    
            <asp:CustomValidator id="DOCNOTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DOCNOTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
            ClientValidationFunction="validateIDField">
            </asp:CustomValidator>   
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DOCNameLabel" class="requiredlabel">Document Name:</div>
            <div id="DOCNameField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="DOCNTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
            </div>  
            <div id="DOCNMlimit" class="textremaining"></div>   

            <asp:RequiredFieldValidator ID="DOCNVal" runat="server" ControlToValidate="DOCNTxt" Display="None" ErrorMessage="Enter the name of the document" ValidationGroup="General"></asp:RequiredFieldValidator>
        
            <asp:CustomValidator id="DOCNTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DOCNTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DOCTYPLabel" class="requiredlabel">Document Type:</div>
            <div id="DOCTYPField" class="fielddiv" style="width:150px">
                <asp:DropDownList ID="DOCTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="DOCTYP_LD" class="control-loader"></div>  
        
            <asp:RequiredFieldValidator ID="DOCTYPTxtVal" runat="server" Display="None" ControlToValidate="DOCTYPCBox" ErrorMessage="Select document type" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
            <asp:CompareValidator ID="DOCTYPVal" runat="server" ControlToValidate="DOCTYPCBox" Display="None" ValidationGroup="General"
            ErrorMessage="Select document type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div id="organization" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
            <div id="ORGUNTLabel" class="labeldiv">Organization Unit:</div>
            <div id="ORGUNTField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>           
            </div>
            <div id="ORGF_LD" class="control-loader"></div>
        </div>
    
        <div id="project" style="float:left; width:100%; height:20px; margin-top:15px; display:none;">
            <div id="ProjectLabel" class="labeldiv">Select Project:</div>
            <div id="ProjectField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="PROJTxt" Width="240px" runat="server" CssClass="readonly">
                </asp:TextBox>
            </div>
            <span id="PROJSRCH" class="searchactive" runat="server" style="margin-left:10px" title="Search for projects"></span>
        </div>
    
        <div id="SearchProject" class="selectbox" style="width:700px; height:250px; top:130px; left:150px;">
            <div class="toolbox">
                <div style="float:left; width:450px; height:20px; margin-top:4px;">
                    <div id="StartDateLabel" style="width:120px;">Project Start Date:</div>
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
                <div id="projcloseBox" class="selectboxclose"></div>
            </div>
            <div id="PROJFLTR_LD" class="control-loader"></div> 
            <div id="scrollbarPROJ" style="height:250px; width:96%; overflow:auto; margin-top:15px; float:left">
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
            <div id="DOCFTYPLabel" class="requiredlabel">Document File Type:</div>
            <div id="DOCFTYPField" class="fielddiv" style="width:150px">
                <asp:DropDownList ID="DOCFTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="DOCFTYP_LD" class="control-loader"></div>  
       
            <asp:RequiredFieldValidator ID="DOCTYPCTxtVal" runat="server" Display="None" ControlToValidate="DOCFTYPCBox" ErrorMessage="Select document file type" ValidationGroup="General"></asp:RequiredFieldValidator>         
       
            <asp:CompareValidator ID="DOCTYPFVal" runat="server" ControlToValidate="DOCFTYPCBox" ValidationGroup="General"
            Display="None" ErrorMessage="Select document file type" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ReviewDurationLabel" class="requiredlabel">Review Duration:</div>
            <div id="ReviewDurationField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="REVDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
            
                <asp:Label ID="slash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>
                  
                <asp:DropDownList ID="REVPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                </asp:DropDownList>     
            </div>     
        
            <div id="REVPRD_LD" class="control-loader"></div>  
       
            <asp:RequiredFieldValidator ID="REVDURVal" runat="server" Display="None" ControlToValidate="REVDURTxt" ErrorMessage="Enter the review duration of the document" ValidationGroup="General"></asp:RequiredFieldValidator>
        
            <ajax:FilteredTextBoxExtender ID="REVDURFExt" runat="server" TargetControlID="REVDURTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>
        
            <asp:CustomValidator id="REVDURTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "REVDURTxt" Display="None" ErrorMessage = "The review duration should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator>  

            <asp:RequiredFieldValidator ID="REVPRDTxtVal" runat="server" Display="None" ControlToValidate="REVPRDCBox" ErrorMessage="Select review period" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
            <asp:CompareValidator ID="REVPRDVal" runat="server" ControlToValidate="REVPRDCBox" Display="None" ValidationGroup="General"
            ErrorMessage="Select review period" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="REVDURDAYLabel" class="labeldiv">Review Duration in Days:</div>
            <div id="REVDURDAYField" class="fielddiv" style="width:100px">
                <asp:TextBox ID="REVDURDAYTxt" runat="server" CssClass="readonly" ReadOnly="true" Width="90px"></asp:TextBox>
            </div>
   
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DOCURLLabel" class="labeldiv">Document File URL:</div>
            <div id="DOCURLField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DOCURLTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>
            
            <input id="VDOCBTN" class="button" type="button" value="View" style="margin-left:5px; width:85px" />
 
            <asp:RegularExpressionValidator ID="DOCURLFVal" runat="server" ControlToValidate="DOCURLTxt"
            ErrorMessage="invalid URL e.g.(http://www.example.com) or (www.example.com)" ValidationExpression="^(http(s)?\://)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+\s&amp;%\$#\=~])*$" Display="None" ValidationGroup="General"></asp:RegularExpressionValidator> 
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DocumentFileLabel" class="labeldiv">Document File:</div>
            <div id="DocumentFileField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="DOCFILText" CssClass="readonly" runat="server" Width="390px" ReadOnly="true"></asp:TextBox>
                <div class="uploaddiv"></div>
                <input id="fileupload" type="file" name="file" style="width:0; height:0; display:block;"/>
                <input id="filename" type="hidden" value=""/>
                <div id="uploadmessage"></div>
            </div>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RemarksLabel" class="labeldiv">Additional Information:</div>
            <div id="RemarksField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="RMKTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>
    </div>
    <div id="CCNTB" class="tabcontent" style="display:none; height:480px;"> 
        <div id="validation_dialog_ccn" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="CCN" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OriginatorLabel" class="requiredlabel">Document Originator:</div>
            <div id="OrginatorField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="ORIGCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="ORIGN_LD" class="control-loader"></div>  
             
            <span id="ORIGNSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the originator of the document"></span>
        
            <asp:RequiredFieldValidator ID="ORIGTxtVal" runat="server" Display="None" ControlToValidate="ORIGCBox" ErrorMessage="Select document originator" ValidationGroup="CCN"></asp:RequiredFieldValidator>              
        
            <asp:CompareValidator ID="ORIGVal" runat="server" ControlToValidate="ORIGCBox" ValidationGroup="CCN"
            Display="None" ErrorMessage="Select document originator" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="IssuerLabel" class="requiredlabel">Document Owner:</div>
            <div id="IssuerField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="Owner_LD" class="control-loader"></div>  
              
            <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the document"></span>
        
            <asp:RequiredFieldValidator ID="OWNRTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select document owner"  ValidationGroup="CCN"></asp:RequiredFieldValidator>              
        
            <asp:CompareValidator ID="OWNRFVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="CCN"
            Display="None" ErrorMessage="Select document owner" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="OriginationDateLabel" class="requiredlabel">Origination Date:</div>
            <div id="OriginationDateField" class="fielddiv" style="width:150px">
                <asp:TextBox ID="ORGNDTTxt" runat="server" CssClass="textbox" Width="140px" placeholder="dd/mm/yyyy"></asp:TextBox>
            </div>        
            <asp:RequiredFieldValidator ID="ORIGNDTVal" runat="server" Display="None" ControlToValidate="ORGNDTTxt" ErrorMessage="Enter the origination date of the document" ValidationGroup="CCN"></asp:RequiredFieldValidator>
       
            <asp:RegularExpressionValidator ID="ORGNDTFVal" runat="server" ControlToValidate="ORGNDTTxt"
            Display="None" ErrorMessage="Date format should be dd/MM/yyyy" ValidationExpression="^\d{2}\/\d{2}\/\d{4}$"  ValidationGroup="CCN"></asp:RegularExpressionValidator>  
        
            <asp:CustomValidator id="ORGNDTF2Val" runat="server" ValidationGroup="CCN" 
            ControlToValidate = "ORGNDTTxt" Display="None" ErrorMessage = "Origination date should match today's date"
            ClientValidationFunction="compareEqualsToday">
            </asp:CustomValidator>

            <asp:CustomValidator id="ORGNDTF3Val" runat="server" ValidationGroup="CCN" 
            ControlToValidate = "ORGNDTTxt"  Display="None" ErrorMessage = "Enter a realistic date value"
            ClientValidationFunction="validateDate">
            </asp:CustomValidator>
        </div>

        <div id="SelectORG" class="selectbox">
            <div id="closeORG" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="SelectOrganizationLebel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="SelectOrganizationField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="SORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList> 
                </div>
                <div id="ORG_LD" class="control-loader"></div> 
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

    <input id="invoker" type="hidden" value="" />
</div>
<script type="text/javascript" language="javascript">

    $(function ()
    {
        var emptyPROJ = $("#<%=gvProjects.ClientID%> tr:last-child").clone(true);

        /*attach document ID to limit plugin*/
        $("#<%=DOCNOTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

        /*attach the title of the document to limit plugin*/
        $('#<%=DOCNTxt.ClientID%>').limit({ id_result: 'DOCNMlimit', alertClass: 'alertremaining', limit: 100 });
  
        addWaterMarkText('Additional details in the support of the document', '#<%=RMKTxt.ClientID%>');

        loadComboboxAjax('loadDocumentTypes', "#<%=DOCTYPCBox.ClientID%>", "#DOCTYP_LD");
        loadComboboxAjax('loadDocumentFileTypes', "#<%=DOCFTYPCBox.ClientID%>","#DOCFTYP_LD");
        loadComboboxAjax('loadPeriod', "#<%=REVPRDCBox.ClientID%>", "#REVPRD_LD");

        loadLastIDAjax('getLastDocumentID', "#<%=DOCNOLbl.ClientID%>");

        navigate('Details');

        /*disable view button*/
        disableViewButton(false);

        
        $("#DocumentTooltip").stop(true).hide().fadeIn(800, function ()
        {
            $(this).find('p').text("When uploading a file, make sure it matches the type of the document");
        });

       
        $("#<%=DOCTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() == 'Origanizational')
            {
                if (!$("project").is(":hidden"))
                    $("#project").hide();


                $("#organization").show();
                loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORGF_LD");
            }
            else if ($(this).val() == 'Project') {
                if (!$("organization").is(":hidden"))
                    $("#organization").hide();


                $("#<%=PROJTxt.ClientID%>").val('');
                $("#project").show();
            }
            else if ($(this).val() == 'Training Material' || $(this).val()=='Other')
            {
                if (!$("organization").is(":hidden"))
                    $("#organization").hide();

                if (!$("project").is(":hidden"))
                    $("#project").hide();
            }

        });

        $("#<%=REVPRDCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                if ($("#<%=REVDURTxt.ClientID%>").val() != '') {
                    $("#<%=REVDURDAYTxt.ClientID%>").val(convertDays($("#<%=REVDURTxt.ClientID%>").val(), $(this).val()));
                }
            }
        });

        $("#<%=REVDURTxt.ClientID%>").keyup(function () {
            if ($("#<%=REVPRDCBox.ClientID%>").val() != 0) {
                $("#<%=REVDURDAYTxt.ClientID%>").val(convertDays($(this).val(), $("#<%=REVPRDCBox.ClientID%>").val()));
            }
        });

        $("#<%=DOCURLTxt.ClientID%>").keyup(function ()
        {
            if ($(this).val() == '') 
            {
                if ($("#VDOCBTN").is(":disabled") == false)
                {
                    /*set opacity property to 50% indicating the document view button is disabled by default*/
                    $("#VDOCBTN").css({ opacity: 0.5 });

                    /*disable view button*/
                    disableViewButton(false);
                }
            }
            else
            {
                if ($("#VDOCBTN").is(":disabled") == true)
                {
                    /*set opacity property to 100% indicating the document view button is enabled*/
                    $("#VDOCBTN").css({ opacity: 1 });

                    /*enable view button*/
                    disableViewButton(true);
                }
            }
        });

        /*At the current stage, documents can be viewed using google doc viewer tool where a customized document viewer can be added as a future work*/
        $("#VDOCBTN").bind('click', function ()
        {
            window.open('http://docs.google.com/viewer?url=' + $("#<%=DOCURLTxt.ClientID%>").val());
        });

        $("#<%=ORIGNSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Originator');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=OWNRSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });

       
        /*populate the employees in originatir, and owner cboxes*/
        $("#<%=SORGUNTCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0)
            {
                unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                switch ($("#invoker").val())
                {
                    case "Originator":
                        loadcontrols.push("#<%=ORIGCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORIGN_LD");
                        break;
                    case "Owner":
                        loadcontrols.push("#<%=OWNRCBox.ClientID%>");
                        loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#Owner_LD");
                        break;
                }
                $("#SelectORG").hide('800');
            }
        });

        $("#<%=PROJSRCH.ClientID%>").bind('click', function () {
            $("#<%=FDTTxt.ClientID%>").val('');
             $("#<%=TDTTxt.ClientID%>").val('');

             loadProjects(emptyPROJ);
             $("#SearchProject").show();
         });

        $("#projcloseBox").bind('click', function () {
            $("#SearchProject").hide('800');
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
           onSelect: function (date)
           {
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

        $(".uploaddiv").bind('click', function ()
        {
            $('input[type=file]').trigger('click');
        });

        /*close organization unit box*/
        $("#closeORG").bind('click', function ()
        {
            $("#SelectORG").hide('800');
        });

        $("#fileupload").fileupload(
        {
            dataType: 'json',
            url: '../Upload.ashx',
            progress: function (e, data) {
                $("#uploadmessage").show();
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $("#uploadmessage").html("Uploading(" + progress + "%)");
            },
            done: function (e, data)
            {
                $.each(data.files, function (index, file)
                {
                    /*temporarly store the name of the file*/
                    $("#filename").val(file.name);
                });

                $("#uploadmessage").hide("2000");

                $("#<%=DOCFILText.ClientID%>").val(data.result.name);
            },
            fail: function (e, err)
            {
                $("#uploadmessage").hide("2000");

                alert(err.errorThrown);
            }
        });

        $("#<%=ORGNDTTxt.ClientID%>").datepicker(
        {
            inline: true,
            dateFormat: "dd/mm/yy",
            onSelect: function () { }
        });

        $("#tabul li").bind("click", function () {
            navigate($(this).attr("id"));
        });

        $("#save").bind('click', function ()
        {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }
                var isCCNValid = Page_ClientValidate('CCN');
                if (isCCNValid)
                {
                    if (!$("#validation_dialog_ccn").is(":hidden"))
                    {
                        $("#validation_dialog_ccn").hide();
                    }
                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true)
                    {
                        $find('<%= SaveExtender.ClientID %>').show();

                        var orginationDateParts = $("#<%=ORGNDTTxt.ClientID%>").val().split("/");
                        var document =
                        {
                            DOCNo: $("#<%=DOCNOTxt.ClientID%>").val(),
                            DOCTitle: $("#<%=DOCNTxt.ClientID%>").val(),
                            DOCType: ($("#<%=DOCTYPCBox.ClientID%>").val() == 0 || $("#<%=DOCTYPCBox.ClientID%>").val() == null ? '' : $("#<%=DOCTYPCBox.ClientID%>").val()),
                            DOCFileType: ($("#<%=DOCFTYPCBox.ClientID%>").val() == 0 || $("#<%=DOCFTYPCBox.ClientID%>").val() == null ? '' : $("#<%=DOCFTYPCBox.ClientID%>").val()),
                            Department: ($("#<%=ORGUNTCBox.ClientID%>").val() == 0 || $("#<%=ORGUNTCBox.ClientID%>").val() == null?'':$("#<%=ORGUNTCBox.ClientID%>").val()),
                            Project: $("#<%=PROJTxt.ClientID%>").val(),
                            ReviewDuration: $("#<%=REVDURTxt.ClientID%>").val(),
                            ReviewPeriod: $("#<%=REVPRDCBox.ClientID%>").find('option:selected').text(),
                            ReviewDurationDays: $("#<%=REVDURDAYTxt.ClientID%>").val(),
                            Remarks: $("#<%=RMKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMKTxt.ClientID%>").val()),
                            CCNList:
                            [
                                {
                                    DocumentFileURL: $("#<%=DOCURLTxt.ClientID%>").val(),
                                    DocumentFile: $("#<%=DOCFILText.ClientID%>").val().replace(/\\/g, '/'),
                                    DocumentFileName: $("#filename").val(),
                                    Originator: $("#<%=ORIGCBox.ClientID%>").find('option:selected').text(),
                                    Owner: $("#<%=OWNRCBox.ClientID%>").find('option:selected').text(),
                                    OrginationDate: new Date(orginationDateParts[2], (orginationDateParts[1] - 1), orginationDateParts[0])
                                }
                            ]
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(document) + "\'}",
                            url: getServiceURL().concat('createNewDocument'),
                            success: function (data) {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                alert(data.d);
                                reset();
                                navigate('Details');

                                if (!$("#<%=RMKTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    addWaterMarkText('Additional details in the support of the document', '#<%=RMKTxt.ClientID%>');
                                }

                                loadLastIDAjax('getLastDocumentID', "#<%=DOCNOLbl.ClientID%>");

                                //trigger all textbox keyup events
                                $(".textbox").each(function ()
                                {
                                    $(this).keyup();
                                });
                                
                                $("#<%=ORGUNTCBox.ClientID%>").empty();

                                if (!$("#project").is(":hidden")) {
                                    $("#project").hide();
                                }

                                if (!$("organization").is(":hidden")) {
                                    $("#organization").hide();
                                }
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
                    $("#validation_dialog_ccn").stop(true).hide().fadeIn(500, function ()
                    {

                        alert("Please make sure that all warnings in the CCN TAB are fulfilled");
                        navigate('CCN');
                    });
                }
            }
            else
            {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings in the details TAB are fulfilled");
                    navigate('Details');
                });
            }
        });
    });

    function showORGDialog(x, y)
    {
        $("#SelectORG").css({ left: x - 290, top: y - 109 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>","#ORG_LD");
        $("#SelectORG").show();
    }

    function disableViewButton(enabled)
    {
        if (enabled == false) {
            $(".button").each(function ()
            {
                $(this).attr('disabled', true);

                /*set opacity property to 50% indicating the document view button is disabled by default*/
                $(this).css({ opacity: 0.5 });

            });
        }
        else
        {
            $(".button").each(function ()
            {
                $(this).attr('disabled', false);

                /*set opacity property to 100% indicating the document view button is enabled*/
                $(this).css({ opacity: 1 });
            });
        }
    }

    function loadProjects(empty)
    {
        $("#PROJFLTR_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadProjects'),
                success: function (data) {
                    $("#PROJFLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data)
                        {
                            loadProjectGridView(data.d, empty);
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#PROJFLTR_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function filterByDateRange(start, end, empty)
    {
        var sd = getDatePart(start);
        var ed = getDatePart(end);

        var plannedstartdate = new Date(sd[2], (sd[1] - 1), sd[0]);
        var plannedenddate = new Date(ed[2], (ed[1] - 1), ed[0]);

        if (isNaN(plannedstartdate) != true && isNaN(plannedenddate) != true)
        {
            $("#PROJFLTR_LD").stop(true).hide().fadeIn(500, function ()
            {
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
                    success: function (data)
                    {
                        $("#PROJFLTR_LD").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            if (data)
                            {
                                loadProjectGridView(data.d, empty);
                            }
                        });
                    },
                    error: function (xhr, status, error) {
                        $("#PROJFLTR_LD").fadeOut(500, function ()
                        {

                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
            });
        }
    }

    function loadProjectGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvProjects.ClientID%> tr").not($("#<%=gvProjects.ClientID%> tr:first-child")).remove();
        $(xml).find("Project").each(function (index, value)
        {
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
            $("#<%=PROJTxt.ClientID%>").val( $("td", $(this)).eq(1).html());
        });
    }
    function convertDays(duration, period)
    {
        var days = 0;

        switch (period) {
            case "Years":
                days = duration * 365;
                break;
            case "Months":
                days = duration * 30;
                break;
            case "Days":
                days = duration * 1;
                break;
        }
        return days;
    }

    function navigate(name)
    {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }
</script>
</asp:Content>
