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
        <asp:HiddenField ID="hfTimeZone" runat="server" />
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
   
    function getTimezoneName() {
        tmSummer = new Date(Date.UTC(2005, 6, 30, 0, 0, 0, 0));
        so = -1 * tmSummer.getTimezoneOffset();
        tmWinter = new Date(Date.UTC(2005, 12, 30, 0, 0, 0, 0));
        wo = -1 * tmWinter.getTimezoneOffset();

        if (-660 == so && -660 == wo) return 'Pacific/Midway';
        if (-600 == so && -600 == wo) return 'Pacific/Tahiti';
        if (-570 == so && -570 == wo) return 'Pacific/Marquesas';
        if (-540 == so && -600 == wo) return 'America/Adak';
        if (-540 == so && -540 == wo) return 'Pacific/Gambier';
        if (-480 == so && -540 == wo) return 'US/Alaska';
        if (-480 == so && -480 == wo) return 'Pacific/Pitcairn';
        if (-420 == so && -480 == wo) return 'US/Pacific';
        if (-420 == so && -420 == wo) return 'US/Arizona';
        if (-360 == so && -420 == wo) return 'US/Mountain';
        if (-360 == so && -360 == wo) return 'America/Guatemala';
        if (-360 == so && -300 == wo) return 'Pacific/Easter';
        if (-300 == so && -360 == wo) return 'US/Central';
        if (-300 == so && -300 == wo) return 'America/Bogota';
        if (-240 == so && -300 == wo) return 'US/Eastern';
        if (-240 == so && -240 == wo) return 'America/Caracas';
        if (-240 == so && -180 == wo) return 'America/Santiago';
        if (-180 == so && -240 == wo) return 'Canada/Atlantic';
        if (-180 == so && -180 == wo) return 'America/Montevideo';
        if (-180 == so && -120 == wo) return 'America/Sao_Paulo';
        if (-150 == so && -210 == wo) return 'America/St_Johns';
        if (-120 == so && -180 == wo) return 'America/Godthab';
        if (-120 == so && -120 == wo) return 'America/Noronha';
        if (-60 == so && -60 == wo) return 'Atlantic/Cape_Verde';
        if (0 == so && -60 == wo) return 'Atlantic/Azores';
        if (0 == so && 0 == wo) return 'Africa/Casablanca';
        if (60 == so && 0 == wo) return 'Europe/London';
        if (60 == so && 60 == wo) return 'Africa/Algiers';
        if (60 == so && 120 == wo) return 'Africa/Windhoek';
        if (120 == so && 60 == wo) return 'Europe/Amsterdam';
        if (120 == so && 120 == wo) return 'Africa/Harare';
        if (180 == so && 120 == wo) return 'Europe/Athens';
        if (180 == so && 180 == wo) return 'Africa/Nairobi';
        if (240 == so && 180 == wo) return 'Europe/Moscow';
        if (240 == so && 240 == wo) return 'Asia/Dubai';
        if (270 == so && 210 == wo) return 'Asia/Tehran';
        if (270 == so && 270 == wo) return 'Asia/Kabul';
        if (300 == so && 240 == wo) return 'Asia/Baku';
        if (300 == so && 300 == wo) return 'Asia/Karachi';
        if (330 == so && 330 == wo) return 'Asia/Calcutta';
        if (345 == so && 345 == wo) return 'Asia/Katmandu';
        if (360 == so && 300 == wo) return 'Asia/Yekaterinburg';
        if (360 == so && 360 == wo) return 'Asia/Colombo';
        if (390 == so && 390 == wo) return 'Asia/Rangoon';
        if (420 == so && 360 == wo) return 'Asia/Almaty';
        if (420 == so && 420 == wo) return 'Asia/Bangkok';
        if (480 == so && 420 == wo) return 'Asia/Krasnoyarsk';
        if (480 == so && 480 == wo) return 'Australia/Perth';
        if (540 == so && 480 == wo) return 'Asia/Irkutsk';
        if (540 == so && 540 == wo) return 'Asia/Tokyo';
        if (570 == so && 570 == wo) return 'Australia/Darwin';
        if (570 == so && 630 == wo) return 'Australia/Adelaide';
        if (600 == so && 540 == wo) return 'Asia/Yakutsk';
        if (600 == so && 600 == wo) return 'Australia/Brisbane';
        if (600 == so && 660 == wo) return 'Australia/Sydney';
        if (630 == so && 660 == wo) return 'Australia/Lord_Howe';
        if (660 == so && 600 == wo) return 'Asia/Vladivostok';
        if (660 == so && 660 == wo) return 'Pacific/Guadalcanal';
        if (690 == so && 690 == wo) return 'Pacific/Norfolk';
        if (720 == so && 660 == wo) return 'Asia/Magadan';
        if (720 == so && 720 == wo) return 'Pacific/Fiji';
        if (720 == so && 780 == wo) return 'Pacific/Auckland';
        if (765 == so && 825 == wo) return 'Pacific/Chatham';
        if (780 == so && 780 == wo) return 'Pacific/Enderbury'
        if (840 == so && 840 == wo) return 'Pacific/Kiritimati';
        return 'US/Pacific';
    }

    function getTimezoneNameSync() {
        tmSummer = new Date(Date.UTC(2005, 6, 30, 0, 0, 0, 0));
        so = -1 * tmSummer.getTimezoneOffset();
        tmWinter = new Date(Date.UTC(2005, 12, 30, 0, 0, 0, 0));
        wo = -1 * tmWinter.getTimezoneOffset();

        if (-660 == so && -660 == wo) return 'Samoa Standard Time';
        if (-600 == so && -600 == wo) return 'Pacific/Tahiti';
        if (-570 == so && -570 == wo) return 'Pacific/Marquesas';
        if (-540 == so && -600 == wo) return 'America/Adak';
        if (-540 == so && -540 == wo) return 'Pacific/Gambier';
        if (-480 == so && -540 == wo) return 'US/Alaska';
        if (-480 == so && -480 == wo) return 'Pacific/Pitcairn';
        if (-420 == so && -480 == wo) return 'US/Pacific';
        if (-420 == so && -420 == wo) return 'US/Arizona';
        if (-360 == so && -420 == wo) return 'US/Mountain';
        if (-360 == so && -360 == wo) return 'America/Guatemala';
        if (-360 == so && -300 == wo) return 'Pacific/Easter';
        if (-300 == so && -360 == wo) return 'US/Central';
        if (-300 == so && -300 == wo) return 'America/Bogota';
        if (-240 == so && -300 == wo) return 'US/Eastern';
        if (-240 == so && -240 == wo) return 'America/Caracas';
        if (-240 == so && -180 == wo) return 'America/Santiago';
        if (-180 == so && -240 == wo) return 'Canada/Atlantic';
        if (-180 == so && -180 == wo) return 'America/Montevideo';
        if (-180 == so && -120 == wo) return 'America/Sao_Paulo';
        if (-150 == so && -210 == wo) return 'America/St_Johns';
        if (-120 == so && -180 == wo) return 'America/Godthab';
        if (-120 == so && -120 == wo) return 'America/Noronha';
        if (-60 == so && -60 == wo) return 'Atlantic/Cape_Verde';
        if (0 == so && -60 == wo) return 'Atlantic/Azores';
        if (0 == so && 0 == wo) return 'Africa/Casablanca';
        if (60 == so && 0 == wo) return 'Europe/London';
        if (60 == so && 60 == wo) return 'Africa/Algiers';
        if (60 == so && 120 == wo) return 'Africa/Windhoek';
        if (120 == so && 60 == wo) return 'Europe/Amsterdam';
        if (120 == so && 120 == wo) return 'Africa/Harare';
        if (180 == so && 120 == wo) return 'Europe/Athens';
        if (180 == so && 180 == wo) return 'Africa/Nairobi';
        if (240 == so && 180 == wo) return 'Europe/Moscow';
        if (240 == so && 240 == wo) return 'Asia/Dubai';
        if (270 == so && 210 == wo) return 'Asia/Tehran';
        if (270 == so && 270 == wo) return 'Asia/Kabul';
        if (300 == so && 240 == wo) return 'Asia/Baku';
        if (300 == so && 300 == wo) return 'Asia/Karachi';
        if (330 == so && 330 == wo) return 'Asia/Calcutta';
        if (345 == so && 345 == wo) return 'Asia/Katmandu';
        if (360 == so && 300 == wo) return 'Asia/Yekaterinburg';
        if (360 == so && 360 == wo) return 'Asia/Colombo';
        if (390 == so && 390 == wo) return 'Asia/Rangoon';
        if (420 == so && 360 == wo) return 'Asia/Almaty';
        if (420 == so && 420 == wo) return 'Asia/Bangkok';
        if (480 == so && 420 == wo) return 'Asia/Krasnoyarsk';
        if (480 == so && 480 == wo) return 'Australia/Perth';
        if (540 == so && 480 == wo) return 'Asia/Irkutsk';
        if (540 == so && 540 == wo) return 'Asia/Tokyo';
        if (570 == so && 570 == wo) return 'Australia/Darwin';
        if (570 == so && 630 == wo) return 'Australia/Adelaide';
        if (600 == so && 540 == wo) return 'Asia/Yakutsk';
        if (600 == so && 600 == wo) return 'Australia/Brisbane';
        if (600 == so && 660 == wo) return 'Australia/Sydney';
        if (630 == so && 660 == wo) return 'Australia/Lord_Howe';
        if (660 == so && 600 == wo) return 'Asia/Vladivostok';
        if (660 == so && 660 == wo) return 'Pacific/Guadalcanal';
        if (690 == so && 690 == wo) return 'Pacific/Norfolk';
        if (720 == so && 660 == wo) return 'Asia/Magadan';
        if (720 == so && 720 == wo) return 'Pacific/Fiji';
        if (720 == so && 780 == wo) return 'Pacific/Auckland';
        if (765 == so && 825 == wo) return 'Pacific/Chatham';
        if (780 == so && 780 == wo) return 'Pacific/Enderbury'
        if (840 == so && 840 == wo) return 'Pacific/Kiritimati';
        return 'US/Pacific';
    }


    function setTimezoneName()
    {
        //var timeZone = getTimezoneName();
        $("#<%=hfTimeZone.ClientID%>").val((new Date).toString().split('(')[1].slice(0, -1));
    }
    </script>
</asp:Content>
