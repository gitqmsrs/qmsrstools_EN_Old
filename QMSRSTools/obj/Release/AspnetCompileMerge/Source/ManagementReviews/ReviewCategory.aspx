<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ReviewCategory.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ReviewCategory" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="ReviewCategory_Header" class="moduleheader">Manage Review Categories</div>

    <div class="toolbox">
        <img id="newcategory" src="../Images/new_file.png" class="imgButton" title="Create new management review category" alt=""/>  
        <img id="refreshcategory" src="../Images/refresh.png" class="imgButton" title="Refersh date" alt="" />
    </div>

    <div id="REVCATloader" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="scrollbar" style="height:78%; width:96%; overflow:auto; margin-top:15px; float:left">
    <asp:GridView id="gvCategory" runat="server" AutoGenerateColumns="false" CssClass="grid"  PagerStyle-CssClass="pgr"  
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
                <asp:BoundField DataField="CategoryID" HeaderText="ID" />
                <asp:BoundField DataField="CategoryName" HeaderText="Category Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
        </Columns>
    </asp:GridView>
    </div>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel" style="height:300px;">
    <div id="header" class="modalHeader">Review Category Details<span id="close" class="modalclose" title="Close">X</span></div>
       
        <div id="SaveTooltip" class="tooltip">
            <img src="../Images/wait-loader.gif" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	   </div>
       
       <div id="validation_dialog_category" style="display: none">
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="validator" ValidationGroup="Category" />
       </div>
       
       <input id="CategoryID" type="hidden" value="" />
      
       <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="CategoryNameLabel" class="requiredlabel">Category Name:</div>
            <div id="CategoryNameField" class="fielddiv" style="width:200px;">
                <asp:TextBox ID="CATNMTxt" CssClass="textbox" Width="190px" runat="server"></asp:TextBox>
            </div>

            <div id="CATNMlimit" class="textremaining"></div>
             
            <asp:RequiredFieldValidator ID="CATNMTxtVal" runat="server" Display="None" ControlToValidate="CATNMTxt" ErrorMessage="Enter the name of the asset category" ValidationGroup="Category"></asp:RequiredFieldValidator> 
           
           <asp:CustomValidator id="CATNMFVal" runat="server"
           ControlToValidate = "CATNMTxt" Display="None" ValidationGroup="Category" ErrorMessage = "Characters !@$%^&*+=[]\\\';.{}|:<> are not allowed"
           ClientValidationFunction="validateSpecialCharacters">
           </asp:CustomValidator>    
       </div>

        <div style="float:left; width:100%; height:20px; margin-top:15px;">
            <div id="DescriptionLabel" class="labeldiv">Description:</div>
            <div id="DescriptionField" class="fielddiv" style="width:400px;">
                <asp:TextBox ID="DESCTxt" runat="server"  CssClass="textbox" Width="390px" Height="120px" TextMode="MultiLine"></asp:TextBox>
            </div>

            <asp:CustomValidator id="DESCTxtFVal" runat="server" Display="None" ValidationGroup="Category"
            ControlToValidate = "DESCTxt" ErrorMessage = "Characters !@$%^*+=[]{}|<> are not allowed"
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
            var empty = $("#<%=gvCategory.ClientID%> tr:last-child").clone(true);

            /*load all cost centres*/
            refresh(empty);

            $("#refreshcategory").bind('click', function () {
                refresh(empty);
            });

            $("#close").bind('click', function () {
                var result = confirm('Are you sure you would like to close the window?');
                if (result == true) {
                    $("#cancel").trigger('click');
                }
            });

            $("#newcategory").bind('click', function ()
            {
                $("#validation_dialog_category").hide();

                reset();

                addWaterMarkText('The description of the review category', '#<%=DESCTxt.ClientID%>');

                /*set modal mode to add*/
                $("#MODE").val('ADD');


                /*attach category name to limit plugin*/
                $('#<%=CATNMTxt.ClientID%>').limit({ id_result: 'CATNMlimit', alertClass: 'alertremaining', limit: 100 });

                $("#<%=alias.ClientID%>").trigger('click');
            });

            $("#save").click(function ()
            {
                var isPageValid = Page_ClientValidate('Category');
                if (isPageValid)
                {
                    if (!$("#validation_dialog_category").is(":hidden")) {
                        $("#validation_dialog_category").hide();
                    }

                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {

                        $("#SaveTooltip").stop(true).hide().fadeIn(500, function () {
                            ActivateSave(false);

                            if ($("#MODE").val() == 'ADD')
                            {
                                var category =
                                {
                                    CategoryName: $("#<%=CATNMTxt.ClientID%>").val(),
                                    Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(category) + "\'}",
                                    url: getServiceURL().concat('createReviewCategory'),
                                    success: function (data)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function () {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            $("#refreshcategory").trigger('click');
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
                            else if ($("#MODE").val() == 'EDIT') {
                                var category =
                                {
                                    CategoryID: $("#CategoryID").val(),
                                    CategoryName: $("#<%=CATNMTxt.ClientID%>").val(),
                                    Description: $("#<%=DESCTxt.ClientID%>").hasClass("watermarktext") == true ? '' : escapeHtml($("#<%=DESCTxt.ClientID%>").val())
                                }

                                $.ajax(
                                {
                                    type: "POST",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    data: "{\'json\':\'" + JSON.stringify(category) + "\'}",
                                    url: getServiceURL().concat('updateReviewCategory'),
                                    success: function (data)
                                    {
                                        $("#SaveTooltip").fadeOut(500, function ()
                                        {
                                            ActivateSave(true);

                                            $("#cancel").trigger('click');
                                            $("#refreshcategory").trigger('click');
                                        });
                                    },
                                    error: function (xhr, status, error)
                                    {
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
                    $("#validation_dialog_category").stop(true).hide().fadeIn(500, function ()
                    {
                        alert("Please make sure that all warnings highlighted in red color are fulfilled");
                    });
                }
            });
        });
        function removeReviewCategory(categoryid, empty)
        {
            var result = confirm("Are you sure you would like to remove the current review category record?");
            if (result == true)
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                   type: "POST",
                   contentType: "application/json; charset=utf-8",
                   dataType: "json",
                   data: "{'ID':'" + categoryid + "'}",
                   url: getServiceURL().concat("removeReviewCategory"),
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
        function refresh(empty) {
            $("#REVCATloader").stop(true).hide().fadeIn(500, function ()
            {
                $(".modulewrapper").css("cursor", "wait");

                $.ajax(
                {
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    url: getServiceURL().concat("loadReviewCategories"),
                    success: function (data) {
                        $("#REVCATloader").fadeOut(500, function ()
                        {
                            $(".modulewrapper").css("cursor", "default");

                            var xml = $.parseXML(data.d);

                            var row = empty;

                            $("#<%=gvCategory.ClientID%> tr").not($("#<%=gvCategory.ClientID%> tr:first-child")).remove();


                            $(xml).find("Category").each(function (index, value) {

                                $("td", row).eq(0).html("<img id='delete_" + index + "' src='../Images/deletenode.png' class='imgButton' />");
                                $("td", row).eq(1).html("<img id='edit_" + index + "' src='../Images/edit.png' class='imgButton'  />");
                                $("td", row).eq(2).html($(this).attr("CategoryID"));
                                $("td", row).eq(3).html($(this).attr("CategoryName"));
                                $("td", row).eq(4).html(shortenText($(this).attr("Description")));

                                $("#<%=gvCategory.ClientID%>").append(row);

                                $(row).find('img').each(function () {
                                    if ($(this).attr('id').search('delete') != -1) {
                                        $(this).bind('click', function () {
                                            removeReviewCategory($(value).attr("CategoryID"), empty);
                                        });
                                    }
                                    else if ($(this).attr('id').search('edit') != -1)
                                    {
                                        $(this).bind('click', function ()
                                        {
                                            $("#validation_dialog_category").hide();

                                            reset();

                                            /*set the mode to edit*/
                                            $("#MODE").val('EDIT');

                                            /* bind the ID of the asset category*/
                                            $("#CategoryID").val($(value).attr("CategoryID"));

                                            /*bind the name of the asset category*/
                                            $("#<%=CATNMTxt.ClientID%>").val($(value).attr("CategoryName"));

                                            /*bind the description of the asset category*/
                                            if ($(value).attr("Description") == '') {
                                                addWaterMarkText('The description of the review category', '#<%=DESCTxt.ClientID%>');
                                            }
                                            else {
                                                if ($("#<%=DESCTxt.ClientID%>").hasClass("watermarktext")) {
                                                    $("#<%=DESCTxt.ClientID%>").val('').removeClass("watermarktext");
                                                }

                                                $("#<%=DESCTxt.ClientID%>").html($(value).attr("Description")).text();
                                            }

                                            /*attach category name to limit plugin*/
                                            $('#<%=CATNMTxt.ClientID%>').limit({ id_result: 'CATNMlimit', alertClass: 'alertremaining', limit: 100 });

                                            /*trigger category name keyup event to calculate the number of characters*/
                                            $('#<%=CATNMTxt.ClientID%>').keyup();


                                            $("#<%=alias.ClientID%>").trigger('click');
                                        });
                                    }
                                });

                                row = $("#<%=gvCategory.ClientID%> tr:last-child").clone(true);
                            });
                        });
                    },
                    error: function (xhr, status, error)
                    {
                        $("#REVCATloader").fadeOut(500, function ()
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
