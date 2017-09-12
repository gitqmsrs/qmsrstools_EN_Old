<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="CreateNewRecord.aspx.cs" Inherits="QMSRSTools.QualityRecords.CreateNewRecord" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="QR_Header" class="moduleheader">Create a New Quality Record</div>

    <div class="toolbox">   
        <img id="save" src="http://www.qmsrs.com/qmsrstools/Images/save.png" class="imgButton" title="Save Changes" alt=""/>
    </div>

    <div id="RecordTooltip" class="tooltip" style="margin-top:10px;">
        <img src="http://www.qmsrs.com/qmsrstools/Images/HTML_Info.gif" alt="Help" height="25" width="25" />
        <p></p>
    </div>

    <ul id="tabul" style="margin-top:60px;">
        <li id="Details" class="ntabs">Details</li>
        <li id="Additional" class="ntabs">Additional Information</li>
    </ul>

    <div id="DetailsTB" class="tabcontent" style="display:none; height:480px;">
        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:10px;">
            <div id="QRNOLabel" class="requiredlabel">Record ID:</div>
            <div id="QRNOField" class="fielddiv" style="width:auto;">
                <asp:TextBox ID="QRNOTxt" runat="server" CssClass="textbox" Width="90px"></asp:TextBox>
                <asp:Label ID="QRNOLbl" runat="server" CssClass="label" style="width:auto;"></asp:Label>
            </div>
        
            <div id="IDlimit" class="textremaining"></div>
           
            <asp:RequiredFieldValidator ID="QRNOVal" runat="server" Display="None" ControlToValidate="QRNOTxt" ErrorMessage="Enter unique ID for the quality record" ValidationGroup="General"></asp:RequiredFieldValidator>     
    
            <asp:CustomValidator id="QRNOTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "QRNOTxt" Display="None" ErrorMessage = "Characters !@$#%^&*+=[]\\\';,.{}|:<> are not allowed"
            ClientValidationFunction="validateIDField">
            </asp:CustomValidator>   
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="QRNameLabel" class="requiredlabel">QR Name:</div>
            <div id="QRNameField" class="fielddiv" style="width:250px">
                <asp:TextBox ID="QRNMTxt" runat="server" CssClass="textbox" Width="240px"></asp:TextBox>
            </div>  
            <div id="QRNMlimit" class="textremaining"></div>   

            <asp:RequiredFieldValidator ID="QRNMTxtVal" runat="server" ControlToValidate="QRNMTxt" Display="None" ErrorMessage="Enter the name of the quality record" ValidationGroup="General"></asp:RequiredFieldValidator>
        
            <asp:CustomValidator id="QRNMTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "QRNMTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
        </div>
       
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ReviewDurationLabel" class="requiredlabel">Review Duration:</div>
            <div id="ReviewDurationField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="REVDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
            
                <asp:Label ID="revslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>
                  
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
            <div id="RetentionDurationLabel" class="requiredlabel">Retention Duration:</div>
            <div id="RetentionDurationField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="RETDURTxt" runat="server" CssClass="textbox" Width="50px"></asp:TextBox>
            
                <asp:Label ID="retslash" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>
                  
                <asp:DropDownList ID="RETPRDCBox" AutoPostBack="false" runat="server" Width="120px" CssClass="combobox">
                </asp:DropDownList>     
            </div>     
        
            <div id="RETPRD_LD" class="control-loader"></div>  
       
            <asp:RequiredFieldValidator ID="RETDURVal" runat="server" Display="None" ControlToValidate="RETDURTxt" ErrorMessage="Enter the retention duration of the record" ValidationGroup="General"></asp:RequiredFieldValidator>
        
            <ajax:FilteredTextBoxExtender ID="RETDURExt" runat="server" TargetControlID="RETDURTxt" FilterType="Numbers">
            </ajax:FilteredTextBoxExtender>
        
            <asp:CustomValidator id="RETDURFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "RETDURTxt" Display="None" ErrorMessage = "The retention duration should be greater than zero"
            ClientValidationFunction="validateZero">
            </asp:CustomValidator>  

            <asp:RequiredFieldValidator ID="RETPRDVal" runat="server" Display="None" ControlToValidate="RETPRDCBox" ErrorMessage="Select the retention period" ValidationGroup="General"></asp:RequiredFieldValidator>         
        
            <asp:CompareValidator ID="RETPRDFVal" runat="server" ControlToValidate="RETPRDCBox" Display="None" ValidationGroup="General"
            ErrorMessage="Select the retention period" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RECFTYPLabel" class="requiredlabel">Record File Type:</div>
            <div id="RECFTYPField" class="fielddiv" style="width:150px">
                <asp:DropDownList ID="RECFTYPCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>

            <div id="RECFTYP_LD" class="control-loader"></div>  
       
            <asp:RequiredFieldValidator ID="RECFTYPVal" runat="server" Display="None" ControlToValidate="RECFTYPCBox" ErrorMessage="Select the type of the record file" ValidationGroup="General"></asp:RequiredFieldValidator>         
       
            <asp:CompareValidator ID="RECFTYPFVal" runat="server" ControlToValidate="RECFTYPCBox" ValidationGroup="General"
            Display="None" ErrorMessage="Select the type of the record file" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="QRURLLabel" class="labeldiv">Record File URL:</div>
            <div id="QRURLField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="QRURLTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div>
            
            <input id="VQRBTN" class="button" type="button" value="View" style="margin-left:5px; width:85px" />
 
            <asp:RegularExpressionValidator ID="QRURLFVal" runat="server" ControlToValidate="QRURLTxt"
            ErrorMessage="invalid URL e.g.(http://www.example.com) or (www.example.com)" ValidationExpression="^(http(s)?\://)?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,3}(:[a-zA-Z0-9]*)?/?([a-zA-Z0-9\-\._\?\,\'/\\\+\s&amp;%\$#\=~])*$" Display="None" ValidationGroup="General"></asp:RegularExpressionValidator> 
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="QRFileLabel" class="labeldiv">Upload Record File:</div>
            <div id="QRFileField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="QRFTxt" CssClass="readonly" runat="server" Width="390px" ReadOnly="true"></asp:TextBox>
                <div class="uploaddiv"></div>
                <input id="fileupload" type="file" name="file" style="width:0; height:0; display:block;"/>
                <input id="filename" type="hidden" value=""/>
                <div id="uploadmessage"></div>
            </div>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RemarksLabel" class="labeldiv">Remarks:</div>
            <div id="RemarksField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="RMKTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>
            
            <asp:CustomValidator id="RMKTxtFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "RMKTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>
        </div>
    
    </div>
    <div id="AdditionalTB" class="tabcontent" style="display:none; height:480px;">
        <div id="validation_dialog_additional" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary2" runat="server" CssClass="validator" ValidationGroup="Additional" />
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ORGUNTLabel" class="requiredlabel">Organization Unit:</div>
            <div id="ORGUNTField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="ORGUNTCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>           
            </div>
            <div id="ORG_LD" class="control-loader"></div>

            <asp:RequiredFieldValidator ID="ORGUNTVal" runat="server" Display="None" ControlToValidate="ORGUNTCBox" ErrorMessage="Select the organization unit" ValidationGroup="Additional"></asp:RequiredFieldValidator>         
        
            <asp:CompareValidator ID="ORGUNTFVal" runat="server" ControlToValidate="ORGUNTCBox" Display="None" ValidationGroup="Additional"
            ErrorMessage="Select the organization unit" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
      
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RecordOriginatorLabel" class="requiredlabel">Record Originator:</div>
            <div id="RecordOriginatorField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="ORIGCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="ORIGN_LD" class="control-loader"></div>  
             
            <span id="ORIGNSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the originator of the quality record"></span>
        
            <asp:RequiredFieldValidator ID="ORIGTxtVal" runat="server" Display="None" ControlToValidate="ORIGCBox" ErrorMessage="Select quality record originator" ValidationGroup="Additional"></asp:RequiredFieldValidator>              
        
            <asp:CompareValidator ID="ORIGVal" runat="server" ControlToValidate="ORIGCBox" ValidationGroup="Additional"
            Display="None" ErrorMessage="Select quality record originator" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>
    
        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RecordOwnerLabel" class="requiredlabel">Record Owner:</div>
            <div id="RecordOwnerField" class="fielddiv" style="width:300px">
                <asp:DropDownList ID="OWNRCBox" AutoPostBack="false" runat="server" Width="300px" CssClass="combobox">
                </asp:DropDownList>    
            </div>
            <div id="Owner_LD" class="control-loader"></div>  
              
            <span id="OWNRSelect" class="searchactive" style="margin-left:10px" runat="server" title="Click for selecting the owner of the document"></span>
        
            <asp:RequiredFieldValidator ID="OWNRTxtVal" runat="server" Display="None" ControlToValidate="OWNRCBox" ErrorMessage="Select quality record owner"  ValidationGroup="Additional"></asp:RequiredFieldValidator>              
        
            <asp:CompareValidator ID="OWNRFVal" runat="server" ControlToValidate="OWNRCBox" ValidationGroup="Additional"
            Display="None" ErrorMessage="Select quality record owner" Operator="NotEqual" Style="position: static"
            ValueToCompare="0"></asp:CompareValidator>
        </div>

        <div id="SelectORG" class="selectbox">
            <div id="closeORG" class="selectboxclose"></div>
            <div style="float:left; width:100%; height:20px; margin-top:5px;">
                <div id="SelectOrganizationLebel" class="labeldiv" style="width:100px;">ORG. Unit:</div>
                <div id="SelectOrganizationField" class="fielddiv" style="width:130px;">
                    <asp:DropDownList ID="SORGUNTCBox" AutoPostBack="false" Width="130px" runat="server" CssClass="combobox">
                    </asp:DropDownList> 
                </div>
                <div id="ORGF_LD" class="control-loader"></div> 
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
        /*get the last ID of the quality record*/
        loadLastIDAjax('getLastQualityRecordID', "#<%=QRNOLbl.ClientID%>");

        $("#RecordTooltip").stop(true).hide().fadeIn(800, function () {
            $(this).find('p').text("When uploading a file, make sure it matches the type of the document file");
        });

        /*attach quality record ID to limit plugin*/
        $("#<%=QRNOTxt.ClientID%>").limit({ id_result: 'IDlimit', alertClass: 'alertremaining', limit: 50 });

        /*attach the title of the quality record to limit plugin*/
        $('#<%=QRNMTxt.ClientID%>').limit({ id_result: 'QRNMlimit', alertClass: 'alertremaining', limit: 90 });


        loadComboboxAjax('loadPeriod', "#<%=REVPRDCBox.ClientID%>", "#REVPRD_LD");

        loadComboboxAjax('loadPeriod', "#<%=RETPRDCBox.ClientID%>", "#RETPRD_LD");

        loadComboboxAjax('getOrganizationUnits', "#<%=ORGUNTCBox.ClientID%>", "#ORG_LD");

        loadComboboxAjax('loadDocumentFileTypes', "#<%=RECFTYPCBox.ClientID%>", "#RECFTYP_LD");
       
        addWaterMarkText('Additional details in the support of the quality record', '#<%=RMKTxt.ClientID%>');

        /*disable view button*/
        disableViewButton(false);

        $("#<%=QRURLTxt.ClientID%>").keyup(function () {
            if ($(this).val() == '') {
                if ($("#VQRBTN").is(":disabled") == false) {
                    /*set opacity property to 50% indicating the record view button is disabled by default*/
                    $("#VQRBTN").css({ opacity: 0.5 });

                    /*disable view button*/
                    disableViewButton(false);
                }
            }
            else {
                if ($("#VQRBTN").is(":disabled") == true) {
                    /*set opacity property to 100% indicating the record view button is enabled*/
                    $("#VQRBTN").css({ opacity: 1 });

                    /*enable view button*/
                    disableViewButton(true);
                }
            }
        });

        /*At the current stage, quality records can be viewed using google doc viewer tool where a customized document viewer can be added as a future work*/
        $("#VQRBTN").bind('click', function () {
            window.open('http://docs.google.com/viewer?url=' + $("#<%=QRURLTxt.ClientID%>").val());
        });

        $("#<%=ORIGNSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Originator');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=OWNRSelect.ClientID%>").click(function (e) {
            $("#invoker").val('Owner');
            showORGDialog(e.pageX, e.pageY);
        });

        $("#<%=ORGUNTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                loadcontrols.push("#<%=ORIGCBox.ClientID%>");
                loadcontrols.push("#<%=OWNRCBox.ClientID%>");

                loadParamComboboxAjax('getDepEmployees', loadcontrols, unitparam, "#ORG_LD");
            }

        });

        /*populate the employees in originatir, and owner cboxes*/
        $("#<%=SORGUNTCBox.ClientID%>").change(function () {
            if ($(this).val() != 0) {
                var unitparam = "'unit':'" + $(this).val() + "'";
                var loadcontrols = new Array();

                switch ($("#invoker").val()) {
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

        /*close organization unit box*/
        $("#closeORG").bind('click', function () {
            $("#SelectORG").hide('800');
        });

        $("#fileupload").fileupload(
        {
            dataType: 'json',
            url: 'http://www.qmsrs.com/qmsrstools/Upload.ashx',
            progress: function (e, data) {
                $("#uploadmessage").show();
                var progress = parseInt(data.loaded / data.total * 100, 10);
                $("#uploadmessage").html("Uploading(" + progress + "%)");
            },
            done: function (e, data) {
                $.each(data.files, function (index, file) {
                    /*temporarly store the name of the file*/
                    $("#filename").val(file.name);
                });

                $("#uploadmessage").hide("2000");

                $("#<%=QRFTxt.ClientID%>").val(data.result.name);
            },
            fail: function (e, err) {
                $("#uploadmessage").hide("2000");

                alert(err.errorThrown);
            }
        });

        $(".uploaddiv").bind('click', function () {
            $('input[type=file]').trigger('click');
        });

        $("#save").bind('click', function () {
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

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {
                        $find('<%= SaveExtender.ClientID %>').show();

                        var qualityrecord =
                        {
                            RecordNo: $("#<%=QRNOTxt.ClientID%>").val(),
                            Title: $("#<%=QRNMTxt.ClientID%>").val(),
                            Department: ($("#<%=ORGUNTCBox.ClientID%>").val() == 0 || $("#<%=ORGUNTCBox.ClientID%>").val() == null ? '' : $("#<%=ORGUNTCBox.ClientID%>").val()),
                            ReviewDuration: $("#<%=REVDURTxt.ClientID%>").val(),
                            ReviewPeriod: $("#<%=REVPRDCBox.ClientID%>").find('option:selected').text(),
                            RetentionDuration: $("#<%=RETDURTxt.ClientID%>").val(),
                            RetentionPeriod: $("#<%=RETPRDCBox.ClientID%>").find('option:selected').text(),
                            Remarks: $("#<%=RMKTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=RMKTxt.ClientID%>").val()),
                            Originator: $("#<%=ORIGCBox.ClientID%>").val(),
                            Owner: $("#<%=OWNRCBox.ClientID%>").val(),
                            RecordFileType: $("#<%=RECFTYPCBox.ClientID%>").val(),
                            RecordFileURL: $("#<%=QRURLTxt.ClientID%>").val(),
                            RecordFile: $("#<%=QRFTxt.ClientID%>").val().replace(/\\/g, '/'),
                            RecordFileName: $("#filename").val()
                        }

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(qualityrecord) + "\'}",
                            url: getServiceURL().concat('createNewQualityRecord'),
                            success: function (data) {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                showSuccessNotification(data.d);

                                reset();

                                navigate('Details');

                                if (!$("#<%=RMKTxt.ClientID%>").hasClass("watermarktext"))
                                {
                                    addWaterMarkText('Additional details in the support of the quality record', '#<%=RMKTxt.ClientID%>');
                                }

                                loadLastIDAjax('getLastQualityRecordID', "#<%=QRNOLbl.ClientID%>");

                                //trigger all textbox keyup events
                                $(".textbox").each(function () {
                                    $(this).keyup();
                                });
                            },
                            error: function (xhr, status, error) {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                var r = jQuery.parseJSON(xhr.responseText);
                                showErrorNotification(r.Message);
                            }
                        });
                    }
                }
                else {
                    $("#validation_dialog_additional").stop(true).hide().fadeIn(500, function () {

                        alert("Please make sure that all warnings in the additional TAB are fulfilled");
                        navigate('Additional');
                    });
                }
            }
            else {
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings in the details TAB are fulfilled");
                    navigate('Details');
                });
            }
        });

        /*navigate on clicking any tab according to it's ID*/
        $("#tabul li").bind("click", function () {
            navigate($(this).attr("id"));
        });

        navigate('Details');
    });

    function showORGDialog(x, y) {
        $("#SelectORG").css({ left: x - 290, top: y - 109 });
        loadComboboxAjax('getOrganizationUnits', "#<%=SORGUNTCBox.ClientID%>", "#ORGF_LD");
        $("#SelectORG").show();
    }

    function navigate(name) {
        $("#tabul li").removeClass("ctab");

        $(".tabcontent").each(function () {
            $(this).css('display', 'none');
        });

        $("#" + name).addClass("ctab");
        $("#" + name + "TB").css('display', 'block');
    }

    function disableViewButton(enabled) {
        if (enabled == false) {
            $(".button").each(function () {
                $(this).attr('disabled', true);

                /*set opacity property to 50% indicating the document view button is disabled by default*/
                $(this).css({ opacity: 0.5 });

            });
        }
        else {
            $(".button").each(function () {
                $(this).attr('disabled', false);

                /*set opacity property to 100% indicating the document view button is enabled*/
                $(this).css({ opacity: 1 });
            });
        }
    }

    function showSuccessNotification(message) {
        $().toastmessage('showSuccessToast', message);
    }

    function showErrorNotification(message) {
        $().toastmessage('showErrorToast', message);
    }
</script>
</asp:Content>
