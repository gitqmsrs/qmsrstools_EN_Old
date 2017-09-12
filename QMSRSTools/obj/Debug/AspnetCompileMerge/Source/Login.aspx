<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site3.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QMSRSTools.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div id="logincontainer">
        
        <div style="float:left; width:100%; height:20px; margin-top:7px; margin-left:100px;">
            <p>Account Type:</p>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:20px; margin-left:100px;">
            <asp:DropDownList ID="USRTYPCBox" AutoPostBack="false" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>

        <div style="float:right; width:100%; height:7px; margin-top:10px; margin-right:100px;">
            <asp:RequiredFieldValidator ID="USRTYPTxtVal" runat="server" Display="Dynamic" CssClass="validator" ControlToValidate="USRTYPCBox" ErrorMessage="Select account type"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="USRTYPVal" runat="server" ControlToValidate="USRTYPCBox" CssClass="validator"
            Display="Dynamic" ErrorMessage="Select account type" Operator="NotEqual" Style="position: static"
            ValueToCompare="-1"></asp:CompareValidator>
        </div>

        <div style="float:left; width:100%; height:20px; margin-top:7px; margin-left:100px;">
            <p>User Name/Personnel ID:</p>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:20px; margin-left:100px;">
            <asp:TextBox ID="loginusr" runat="server" CssClass="logintextbox"></asp:TextBox>
        </div>
        
        <div style="float:left; width:100%; height:7px; margin-top:10px; margin-left:100px;">
            <asp:RequiredFieldValidator ID="PERSNNLIDVal" runat="server" Display="Dynamic" ControlToValidate="loginusr" ErrorMessage="Enter the personnel ID!"></asp:RequiredFieldValidator>   
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:7px; margin-left:100px;">
            <p>Password:</p>
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:20px; margin-left:100px;">
            <asp:TextBox ID="loginpw" runat="server" TextMode="Password" CssClass="logintextbox"></asp:TextBox>
            &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="loginButton" OnClick="Search_Click"/> 
        </div>
        <div style="float:left; width:100%; height:7px; margin-top:10px; margin-left:100px;">
            <asp:RequiredFieldValidator ID="PWVal" runat="server" Display="Dynamic" ControlToValidate="loginpw" ErrorMessage="Enter the password!"></asp:RequiredFieldValidator>   
        </div>
    
        <div style="float:left; width:100%; height:7px; margin-top:10px; margin-left:100px;">
            <asp:Label ID="Error" runat="server" style="width:70%; float:left; color:red;"></asp:Label>    
        </div>
        
    </div>

    <asp:Panel ID="LoadPanel" CssClass="loadpanel" runat="server" style="display:none">
        <div style="padding:8px">
            <h2>Please Wait...</h2>
        </div>
    </asp:Panel>


    <ajax:ModalPopupExtender ID="LoadExtender" runat="server" TargetControlID="LoadPanel" PopupControlID="LoadPanel" BackgroundCssClass="modalBackground" DropShadow="true">
    </ajax:ModalPopupExtender>

</div>

<script type="text/javascript" language="javascript">

    function checkLicenseValidation()
    {
        $find('<%= LoadExtender.ClientID %>').show();

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("isValidateLicense"),
            success: function (data) {
                $find('<%= LoadExtender.ClientID %>').hide();

                var isValid = data.d;
                if (isValid == 'true')
                {
                    ActivateAll(true);
                }
            },
            error: function (xhr, status, error)
            {
                $find('<%= LoadExtender.ClientID %>').hide();

                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);

                ActivateAll(false);
            }
        });

    }

    function ActivateAll(isactive)
    {
        if (isactive == false)
        {
            $("#logincontainer").children().each(function () {

                $(".logintextbox").each(function () {
                    $(this).removeClass("textbox");
                    $(this).addClass("readonlycontrolled");
                    $(this).attr('readonly', true);
                });

                $(this).find(".combobox").each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.loginButton').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.link').each(function () {
                    $(this).attr('disabled', true);
                });

            });
        }
        else
        {
            $("#logincontainer").children().each(function ()
            {
                $(".logintextbox").each(function () {
                    $(this).removeClass("readonlycontrolled");
                    $(this).addClass("textbox");
                    $(this).attr('readonly', false);
                });

                $(this).find(".combobox").each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.loginButton').each(function () {
                    $(this).attr('disabled', true);
                });

                $(this).find('.link').each(function () {
                    $(this).attr('disabled', true);
                });
            });
        }
    }
   
    </script>
</asp:Content>
