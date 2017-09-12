<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="ManageAcquisitionMethod.aspx.cs" Inherits="QMSRSTools.AssetManagement.ManageAcquisitionMethod" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div id="wrapper" class="modulewrapper">
    <div id="AssetAcquisition_Header" class="moduleheader">Manage Asset Acquisition Method</div>
    
    <div class="toolbox">
        <img id="newacquisition" src="../Images/new_file.png" class="imgButton" title="Create new asset acquisition method" alt=""/>  
        <img id="refreshacquisition" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
    </div>

    <div id="ACQUloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
    <asp:GridView id="gvAcquisition" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="MethodID" HeaderText="ID" />
                <asp:BoundField DataField="MethodName" HeaderText="Acquisition Method Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
        </Columns>
    </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
    <div id="header" class="modalHeader">Acquisition Method Details<span id="close" class="modalclose" title="Close">X</span></div>
       <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
       </div>

       <div id="validation_dialog_general" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="General" />
       </div>
       
        <input id="MethodID" type="hidden" value="" />
      
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="AcquisitionMethodNameLabel" class="requiredlabel">Acquisition Method:</div>
            <div id="AcquisitionMethodNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="ACQNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>
            <div id="MTHDlimit" class="textremaining"></div>

            <asp:RequiredFieldValidator ID="ACQNMTxtVal" runat="server" Display="None" ControlToValidate="ACQNMTxt" ErrorMessage="Enter the name of the acquisition method" ValidationGroup="General"></asp:RequiredFieldValidator> 
            
            <asp:CustomValidator id="ACQNMTxtFVal" runat="server" ValidationGroup="General" Display="None"
            ControlToValidate = "ACQNMTxt" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
            ClientValidationFunction="validateSpecialCharacters">
            </asp:CustomValidator> 
       </div>

      <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="RemarksLabel" class="labeldiv">Description:</div>
            <div id="RemarksField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtVal" runat="server" ValidationGroup="General" 
            ControlToValidate = "DESCTxt" Display="None" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
            ClientValidationFunction="validateSpecialCharactersLongText">
            </asp:CustomValidator>

       </div>
       <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
       </div>   
</asp:Panel>


<asp:Button ID="alias" runat="server" style="display:none" />

<ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
</ajax:ModalPopupExtender>

<input id="MODE" type="hidden" value="" /> 

</div>
<script type="text/javascript" language="javascript">

        $(function () {
            var empty = $("#<%=gvAcquisition.ClientID%> tr:last-child").clone(true);

            /*load all cost centres*/
            refresh(empty);

            $("#refreshacquisition").bind('click', function () {
                refresh(empty);
            });

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#newacquisition").bind('click', function ()
            {
                $("#validation_dialog_general").hide();

                reset();

                addWaterMarkText('The description of the acquisition method', '#<%=DESCTxt.ClientID%>');

                /*attach method to limit plugin*/
                $('#<%=ACQNMTxt.ClientID%>').limit({ id_result: 'MTHDlimit', alertClass: 'alertremaining', limit: 50 });

                 /*set modal mode to add*/
                $("#MODE").val('ADD');

                $("#<%=alias.ClientID%>").trigger('click');
            });

            $("#save").click(function ()
            {
                var isPageValid = Page_ClientValidate('General');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_general").is(":hidden"))
                    {
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
                                var method =
                                {
                                    MethodName: $("#<%=ACQNMTxt.ClientID%>").val(),
                                    Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(method) + "\'}",
                                    url: getServiceURL().concat('createAcquisitionMethod'),
                                    success: function (data)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            refresh(empty);
                                        });
                                    },
                                    error: function (xhr, status, error)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            var r = jQuery.parseJSON(xhr.responseText);
                                            alert(r.Message);
                                        });
                                    }
                                });
                            }
                            else if ($("#MODE").val() == 'EDIT')
                            {
                                var method =
                                {
                                    MethodID: $("#MethodID").val(),
                                    MethodName: $("#<%=ACQNMTxt.ClientID%>").val(),
                                    Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(method) + "\'}",
                                    url: getServiceURL().concat('updateAcquisitionMethod'),
                                    success: function (data)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            refresh(empty);
                                        });
                                    },
                                    error: function (xhr, status, error)
                                    {
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
                    $("#validation_dialog_general").stop(true).hide().fadeIn(500, function () {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
            });
        });
    function removeAcquisitionMethod(methodid, empty) {
        var result = confirm("Are you sure you would like to remove the current asset acquisition method record?");
        if (result == true)
        {
           $(".modulewrapper").css("cursor", "wait");

           $.ajax(
           {
               type: "POST",
               contentType: "application/json; charset=utf-8",
               dataType: "json",
               data: "{'ID':'" + methodid + "'}",
               url: getServiceURL().concat("removeAcquisitionMethod"),
               success: function (data)
               {
                   $(".modulewrapper").css("cursor", "default");
                   refresh(empty);
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
        function refresh(empty)
        {
            $("#ACQUloader").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadAcquisitionMethods"),
                    success: function (data)
                    {
                        $("#ACQUloader").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var xml = $.parseXML(data.d);

                            var row = empty;

                            $("#<%=gvAcquisition.ClientID%> tr").not($("#<%=gvAcquisition.ClientID%> tr:first-child")).remove();


                            $(xml).find("Method").each(function (index, value) {

                                $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
                                $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'  />");
                                $("td", row).eq(2).html($(this).attr("MethodID"));
                                $("td", row).eq(3).html($(this).attr("MethodName"));
                                $("td", row).eq(4).html(shortenText($(this).attr("Description")));

                                $("#<%=gvAcquisition.ClientID%>").append(row);

                                $(row).find('img').each(function () {
                                    if ($(this).attr('id').search('delete') != -1) {
                                        $(this).bind('click', function () {
                                            removeAcquisitionMethod($(value).attr("MethodID"), empty);
                                        });
                                    }
                                    else if ($(this).attr('id').search('edit') != -1) {
                                        $(this).bind('click', function ()
                                        {
                                            $("#validation_dialog_general").hide();

                                            reset();

                                            /*set the mode to edit*/
                                            $("#MODE").val('EDIT');

                                            /* bind the ID of the Acquisition Method*/
                                            $("#MethodID").val($(value).attr("MethodID"));

                                            /*bind the name of the Acquisition Method*/
                                            $("#<%=ACQNMTxt.ClientID%>").val($(value).attr("MethodName"));

                                            /*attach method to limit plugin*/
                                            $('#<%=ACQNMTxt.ClientID%>').limit({ id_result: 'MTHDlimit', alertClass: 'alertremaining', limit: 50 });
                                            $('#<%=ACQNMTxt.ClientID%>').keyup();

                                            /*bind the description of the Acquisition Method*/
                                            if ($(value).attr("Description") == '') {

                                                addWaterMarkText('The description of the acquisition method', '#<%=DESCTxt.ClientID%>');

                                            }
                                            else
                                            {
                                                if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext"))
                                                {
                                                    $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                                                }

                                                $("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).val();
                                            }

                                            $("#<%=alias.ClientID%>").trigger('click');
                                        });
                                    }
                                });

                                row = $("#<%=gvAcquisition.ClientID%> tr:last-child").clone(true);
                            });
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#ACQUloader").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var r = jQuery.parseJSON(xhr.responseText);
                            alert(r.Message);
                        });
                    }
                });
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
