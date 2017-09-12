<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManageDocumentFileType.aspx.cs" Inherits="QMSRSTools.Administration.ManageDocumentFileType" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="DocumentFileType_Header" class="moduleheader">Manage Document File Type</div>

    <div class="toolbox">
        <img id="new" src="../Images/new_file.png" class="imgButton" title="Create new document file type" alt=""/>   
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refersh Data" alt="" />
    </div>

    <div id="DOCFTYPWait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
        <asp:GridView id="gvDocFType" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
            <asp:BoundField DataField="DocFTypeID" HeaderText="ID" />
            <asp:BoundField DataField="ContentType" HeaderText="Content Type" />
            <asp:BoundField DataField="Extension" HeaderText="File Extension" />
            <asp:BoundField DataField="FileType" HeaderText="Type" />
            </Columns>
        </asp:GridView>
    </div>
    
    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="ModalExtender" runat="server" TargetControlID="alias" PopupControlID="modal" CancelControlID="cancel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>


    <asp:Panel ID="modal" runat="server" CssClass="modalPanel" style="height:300px;">
        <div id="header" class="modalHeader">Document File Type Details<span id="close" class="modalclose" title="Close">X</span></div>
    
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
        </div>
        
        <input id="DOCFTYPID" type="hidden" value="" /> 

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DOCFTypeLabel" class="requiredlabel">Document File Type:</div>
            <div id="DOCFTypeField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="DOCFTYPTxt" runat="server" CssClass="textbox" Width="390px"></asp:TextBox>
            </div> 

            <div id="TYPlimit" class="textremaining"></div>   
       
            <asp:RequiredFieldValidator ID="DOCFTYPVal" runat="server" Display="None" ControlToValidate="DOCFTYPTxt" ErrorMessage="Enter the file type of the document" ValidationGroup="General"></asp:RequiredFieldValidator>   
            
            <asp:CustomValidator id="DOCFTYPFVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DOCFTYPTxt" Display="None" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="ContentTypeLabel" class="requiredlabel">Content Type:</div>
            <div id="ContentTypeField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="CONTTYPTxt" CssClass="textbox" runat="server" Width="190px"></asp:TextBox>
            </div>
            
            <div id="CTYPlimit" class="textremaining"></div>   
       
            <asp:RequiredFieldValidator ID="CONTTYPTxtVal" runat="server" Display="None" ControlToValidate="CONTTYPTxt" ErrorMessage="Enter the content type of the file e.g.(application/vnd.ms-word for MS Word file)" ValidationGroup="General"></asp:RequiredFieldValidator>   
       
            <asp:RegularExpressionValidator ID="CONTTYPFVal" runat="server" ControlToValidate="CONTTYPTxt"
            Display="None" ErrorMessage="Invalid format for the content type e.g.(application/vnd.ms-excel)" ValidationExpression="^[a-z]+/[a-z0-9-\.]+$" ValidationGroup="General"></asp:RegularExpressionValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="FileExtLabel" class="requiredlabel">File Extension:</div>
            <div id="FileExtField" class="fielddiv" style="width:200px">
                <asp:TextBox ID="FEXTTxt" CssClass="textbox" runat="server" Width="190px"></asp:TextBox>
            </div>
            <asp:RequiredFieldValidator ID="FEXTTxtVal" runat="server" Display="None" ControlToValidate="FEXTTxt" ErrorMessage="Enter the extension file e.g.(.docx,.xlsx,...etc)" ValidationGroup="General"></asp:RequiredFieldValidator>   

            <asp:RegularExpressionValidator ID="FEXTTxtFval" runat="server" ControlToValidate="FEXTTxt"
            Display="None" ErrorMessage="Only words are allowed" ValidationExpression="^[\.]{1}[a-zA-Z]+$" ValidationGroup="General"></asp:RegularExpressionValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AttachFileLabel" class="labeldiv">Attach File:</div>
            <div id="AttachFileField" class="fielddiv" style="width:400px">
                <asp:TextBox ID="ATTFILText" CssClass="readonly" runat="server" Width="390px" ReadOnly="true"></asp:TextBox>
                <div class="uploaddiv">
                </div>
                <input id="fileupload" type="file" name="file" style="width:0; height:0; display:block;"/>
                <div id="uploadmessage">
                </div>
            </div>
        </div>

        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>
    </asp:Panel>


    <input id="MODE" type="hidden" value="" /> 
</div>
<script type="text/javascript" language="javascript">
    $(function ()
    {
        var empty = $("#<%=gvDocFType.ClientID%> tr:last-child").clone(true);

        /*load all document file types*/
        refresh(empty);

        $("#close").bind('click', function () {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#new").bind('click', function () {

            $("#validation_dialog_general").hide();

            /*clear all field*/
            reset();

            /*set the mode to add*/
            $("#MODE").val('ADD');

            /*attach document file type to limit plugin*/
            $("#<%=DOCFTYPTxt.ClientID%>").limit({ id_result: 'TYPlimit', alertClass: 'alertremaining', limit: 100 });

            /*attach the content file type to limit plugin*/
            $('#<%=CONTTYPTxt.ClientID%>').limit({ id_result: 'CTYPlimit', alertClass: 'alertremaining', limit: 100 });

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $(".uploaddiv").bind('click', function () {
            $('input[type=file]').trigger('click');
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
            done: function (e, data) {
                $("#uploadmessage").hide("2000");

                $("#<%=ATTFILText.ClientID%>").val(data.result.name);
            },
            fail: function (e, err) {
                $("#uploadmessage").hide("2000");

                alert(err.errorThrown);
            }
        });

        $("#trigger").click(function () {
            $("#upload").click();
        });

        $("#refresh").bind('click', function ()
        {
            refresh(empty);
        });

        $("#save").click(function () {
            var isGeneralValid = Page_ClientValidate('General');
            if (isGeneralValid)
            {
                if (!$("#validation_dialog_general").is(":hidden")) {
                    $("#validation_dialog_general").hide();
                }

                var result = confirm("Are you sure you would like to submit changes?");
                if (result == true)
                {
                    $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
                    {
                        ActivateSave(false);

                        if ($("#MODE").val() == 'ADD')
                        {
                            var docfiletype =
                            {
                                Extension: $("#<%=FEXTTxt.ClientID%>").val(),
                                ContentType: $("#<%=CONTTYPTxt.ClientID%>").val(),
                                FileType: $("#<%=DOCFTYPTxt.ClientID%>").val(),
                                Icon: $("#<%=ATTFILText.ClientID%>").val().replace(/\\/g, '/')
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(docfiletype) + "\'}",
                                url: getServiceURL().concat('createDocumentFileType'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refresh").trigger('click');
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        var r = jQuery.parseJSON(xhr.responseText);
                                        alert(r.Message);
                                    });
                                }
                            });
                        }

                        else if ($("#MODE").val() == 'EDIT') {
                            var docfiletype =
                            {
                                DocFileTypeID: $("#DOCFTYPID").val(),
                                Extension: $("#<%=FEXTTxt.ClientID%>").val(),
                                ContentType: $("#<%=CONTTYPTxt.ClientID%>").val(),
                                FileType: $("#<%=DOCFTYPTxt.ClientID%>").val(),
                                Icon: $("#<%=ATTFILText.ClientID%>").val().replace(/\\/g, '/')
                            }

                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: "{\'json\':\'" + JSON.stringify(docfiletype) + "\'}",
                                url: getServiceURL().concat('updateDocumentFileType'),
                                success: function (data) {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
                                        ActivateSave(true);

                                        $("#cancel").trigger('click');
                                        $("#refresh").trigger('click');
                                    });
                                },
                                error: function (xhr, status, error) {
                                    $("#SaveTooltip").fadeOut(500, function ()
                                    {
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
                $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                    alert("Please make sure that all warnings highlighted in red color are fulfilled");
                });
            }
        });
    });

    function refresh(empty)
    {
        $("#DOCFTYPWait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat("getDocumentFileType"),
                success: function (data) {
                    $("#DOCFTYPWait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");
                        loadGridView(data.d, empty);
                    });
                },
                error: function (xhr, status, error) {
                    $("#DOCFTYPWait").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");
                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function removeDocumentFileType(id, empty)
    {
        var result = confirm("Are you sure you would like to remove the current document file type?");
        if (result == true)
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               data: "{'ID':'" + id + "'}",
               url: getServiceURL().concat("removeDocumentFileType"),
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

    function loadGridView(data, empty) {
        var xml = $.parseXML(data);

        var row = empty;

        $("#<%=gvDocFType.ClientID%> tr").not($("#<%=gvDocFType.ClientID%> tr:first-child")).remove();


        $(xml).find("DocFileType").each(function (index, value) {
            /*work arround problem to refresh the updated image in grid view by sending a dummy date in seconds to the image hander*/
            var date = new Date();

            $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
            $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'  />");
            $("td", row).eq(2).html("<img id='icon_" + index + "' src='../ImageHandler.ashx?query=select Icon from DocumentList.DocumentFileType where DocumentFileTypeID=" + $(this).attr('DocFileTypeID') + "&width=20&height=20&date=" + date.getSeconds() + "' />");
            $("td", row).eq(3).html($(this).attr("DocFileTypeID"));
            $("td", row).eq(4).html($(this).attr("ContentType"));
            $("td", row).eq(5).html($(this).attr("Extension"));
            $("td", row).eq(6).html($(this).attr("FileType"));

            $("#<%=gvDocFType.ClientID%>").append(row);

            $(row).find('img').each(function () {
                if ($(this).attr('id').search('delete') != -1) {
                    $(this).bind('click', function () {
                        removeDocumentFileType(parseInt($(value).attr("DocFileTypeID")), empty);
                    });
                }
                else if ($(this).attr('id').search('edit') != -1) {
                    $(this).bind('click', function ()
                    {
                        $("#validation_dialog_general").hide();

                        reset();

                        /*set the mode to edit*/
                        $("#MODE").val('EDIT');

                        /* set the ID document file type*/
                        $("#DOCFTYPID").val($(value).attr("DocFileTypeID"));

                        /*bind document file type*/
                        $("#<%=DOCFTYPTxt.ClientID%>").val($(value).attr("FileType"));

                        /*bind content type*/
                        $("#<%=CONTTYPTxt.ClientID%>").val($(value).attr("ContentType"));

                        /*bind document extension*/
                        $("#<%=FEXTTxt.ClientID%>").val($(value).attr("Extension"));


                        /*attach document file type to limit plugin*/
                        $("#<%=DOCFTYPTxt.ClientID%>").limit({ id_result: 'TYPlimit', alertClass: 'alertremaining', limit: 100 });

                        /*attach the content file type to limit plugin*/
                        $('#<%=CONTTYPTxt.ClientID%>').limit({ id_result: 'CTYPlimit', alertClass: 'alertremaining', limit: 100 });


                        /*trigger keyup events to calculate the current characters in each of the fields*/
                        $("#<%=DOCFTYPTxt.ClientID%>").keyup();
                        $('#<%=CONTTYPTxt.ClientID%>').keyup();

                        $("#<%=alias.ClientID%>").trigger('click');
                    });
                }

            });

            row = $("#<%=gvDocFType.ClientID%> tr:last-child").clone(true);
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
