<%@ Page Title="QMSRS Product Tools" Language="C#" MasterPageFile="~/MasterPage/Site1.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="QMSRSTools.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div id="menu" class="menucontainer">
        <div class="toolbox">
            <img id="mainrefresh" src="<%=GetSitePath() + "/Images/refresh.png" %>" class="imgButton" title="Refresh Modules" alt="" />
            <!--<img id="visio" src="http://www.qmsrs.com/qmsrstools/Images/visio.jpg" class="imgButton" title="Maintain Visio Diagrams" alt="" /> -->
        </div>

        <div id="mainloader" class="loader">
            <div class="waittext">Please Wait...</div>
        </div>

        <div id="tooltree"></div>
    </div>

    <div id="controlcontainer" class="modulecontainer" style="display:none">
    </div>
     
    <iframe id="pagecontainer" class="modulecontainer" style="display:none">
    </iframe> 

    <asp:Button ID="alias" runat="server" style="display:none" />

    <ajax:ModalPopupExtender ID="Extender" runat="server" BehaviorID="Extender" TargetControlID="alias" PopupControlID="panel1" CancelControlID="cancel" BackgroundCssClass="modalBackground">
    </ajax:ModalPopupExtender>

    <asp:Panel ID="panel1" runat="server" CssClass="modalPanel">
        <div id="header" class="modalHeader">Maintain Visio Diagrams<span id="close" class="modalclose" title="Close">X</span></div>        
    
        <div id="SaveTooltip" class="tooltip">
            <img src="<%=GetSitePath() + "/Images/wait-loader.gif" %>" alt="Save" height="25" width="25" />
            <p>Saving...</p>
	    </div>

        <div class="toolbox">
            <img id="refreshlist" src="<%=GetSitePath() + "/Images/refresh.png" %>" alt="" title="Refresh Visio Diagrams" class="imgButton"/>
            <img id="delete" src="<%=GetSitePath() + "/Images/deletenode.png" %>" alt="" title="Remove Visio Diagram" class="imgButton" />
            <img id="new" src="<%=GetSitePath() + "/Images/new_file.png" %>" alt="" title="Add Visio Diagram" class="imgButton" />
        </div>
  
        <div style="float:left; width:100%; height:20px; margin-top:5px;">
            <div id="visiotreemenu" class="menucontainer" style="border: 1px solid #052556; overflow:auto; height:300px; width:37%;">
                <div id="visiowait" class="loader">
                    <div class="waittext">Please Wait...</div>
                </div>
                <div id="visiotree"></div>
            </div>
        
            <div id="visiotreefield" class="modulecontainer" style="border: 1px solid #052556; overflow:auto; height:300px; width:60%;">
                <div style="float:left; width:100%; height:20px; margin-top:10px;">
                    <div id="VisioNameLabel" class="requiredlabel">Diagram Name:</div>
                    <div id="VisioNameField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="VSNMTxt" runat="server" Width="240px" CssClass="textbox treefield"></asp:TextBox>
                    </div>
                </div>

                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="VSIOVWRLabel" class="labeldiv">Visio Viewer URL:</div>
                    <div id="VSIOVWRField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="VSIOVWRTxt" runat="server" Width="240px" CssClass="readonly treefield" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
        
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="NodeNavigationLabel" class="requiredlabel">Visio URL:</div>
                    <div id="NodeNavigationField" class="fielddiv" style="width:250px;">
                        <asp:TextBox ID="NAVTxt" runat="server" Width="240px" CssClass="textbox treefield"></asp:TextBox>
                    </div>
                </div>
   
                <div style="float:left; width:100%; height:20px; margin-top:15px;">
                    <div id="ParentNodeLabel" class="requiredlabel">Module Name:</div>
                    <div id="ParentNodeField" class="fielddiv" style="width:250px;">
                        <asp:DropDownList ID="MODULCBox" AutoPostBack="false" runat="server" Width="250px" CssClass="combobox">
                        </asp:DropDownList>
                    </div>

                    <div id="MODUL_LD" class="control-loader"></div> 
                </div>
            </div>
        </div>
        <div class="buttondiv">
            <input id="save" type="button" class="button" style="margin-left:300px;" value="Save" />
            <input id="cancel" type="button" class="button" value="Cancel" />
        </div>

    </asp:Panel>
    
    <input id="PRMSS" runat="server" type="hidden" value="" />
    
    <asp:Panel ID="LoadPanel" CssClass="savepanel" runat="server">
        <div style="padding:8px">
            <h2>Loading...</h2>
        </div>
    </asp:Panel>

    <ajax:ModalPopupExtender ID="LoadExtender" runat="server" TargetControlID="LoadPanel" PopupControlID="LoadPanel" BackgroundCssClass="modalBackground" DropShadow="true" >
    </ajax:ModalPopupExtender>
</div>
<script type="text/javascript" language="javascript">

  

    $(function ()
    {
        var node = false;

    
        $("#mainrefresh").bind('click', function ()
        {
            $('#pagecontainer').attr("src", "#");
            $('#pagecontainer').hide();

            refreshMain($("#<%=PRMSS.ClientID%>").val());
        });

        $("#visio").bind('click', function ()
        {
            /*refresh viso list*/
            refreshVisio();

            $('#pagecontainer').attr("src", '#');
            $('#pagecontainer').hide();

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#refreshlist").bind('click', function ()
        {
            var result = confirm('Reloading visio navigation list will cause unsaved changes to be lost, are you sure you would like to continue?');
            if (result == true)
            {
                /*refresh viso list*/
                refreshVisio();
            }
        });

        $("#delete").bind('click', function ()
        {
            var node = $('#visiotree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if (node.Status == 3)
                {
                    $('#visiotree').tree('removeNode', node);

                    ActivateTreeField(false);
                }
                else
                {
                    removeVisio(node);
                }
            }
            else
            {
                alert('Please select a visio diagram source from the list');
            }
        });

        $("#<%=VSNMTxt.ClientID%>").keyup(function (event)
        {
            var node = $('#visiotree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if ($(this).val() != '')
                {
                    if (node.Status == 3)
                    {
                        $('#visiotree').tree('updateNode', node, { name: $(this).val() });
                    }
                    else {
                        $('#visiotree').tree('updateNode', node, { name: $(this).val(), Status: 2 });
                    }
                }
                else
                {
                    alert("Cannot accept empty values");
                    event.preventDefault();
                }
            }
            else {
                event.preventDefault();
            }
        });

        $("#<%=NAVTxt.ClientID%>").keyup(function (event)
        {
            var node = $('#visiotree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if ($(this).val() != '')
                {
                    if (node.Status == 3)
                    {                        
                        $('#visiotree').tree('updateNode', node, { NavigationURL: $("#<%=VSIOVWRTxt.ClientID%>").val() + '=' + $(this).val() });
                    }
                    else {
                        $('#visiotree').tree('updateNode', node, { NavigationURL: $("#<%=VSIOVWRTxt.ClientID%>").val() + '=' + $(this).val(), Status: 2 });
                    }
                }
                else
                {
                    alert("Cannot accept empty values");
                    event.preventDefault();
                }
            }
            else {
                event.preventDefault();
            }
        });

        $("#<%=MODULCBox.ClientID%>").change(function ()
        {
            var node = $('#visiotree').tree('getSelectedNode');
            if (node != null && node != false)
            {
                if ($(this).val() != 0)
                {
                    if (node.Status == 3)
                    {
                        $('#visiotree').tree('updateNode', node, { RelatedModule: $(this).val() });
                    }
                    else
                    {
                        $('#visiotree').tree('updateNode', node, { RelatedModule: $(this).val(), Status: 2 });
                    }
                }
            }
        });
        $("#new").bind('click', function ()
        {
            $("#visiotree").tree('appendNode',
            {
                name: 'the name of visio diagram',
                PageExtension: 'aspx',
                RelatedModule: '',
                SecurityKey: 'View Processes',
                IsQueryString: true,
                IsModule: false,
                NavigationURL: 'Visio/Process.aspx?source=enter URL of the visio diagram',
                Status:3
            });
        });

        $("#tooltree").bind('tree.click', function (event)
        {
            var selected = event.node;

            if (selected.NavigationLink != null)
            {
                if ($.trim(selected.PageExtension) == 'ascx')
                {
                    //remove any links for visio viewer
                    $('#pagecontainer').attr("src", "#");
                    $('#pagecontainer').hide();
                    loadAjax(selected.NavigationLink, selected.PageExtension, $('#controlcontainer'));
                }
                else if ($.trim(selected.PageExtension) == 'aspx')
                {
                    /*trigger wait modal popup extender*/
    
                    $('#controlcontainer').hide();


                    $('#pagecontainer').attr("src", "#");

                    if ($("#pagecontainer").is(":hidden"))
                    {
                        $('#pagecontainer').show();
                    }

                    $find('<%= LoadExtender.ClientID %>').show();
                   // alert("will show loading now.");
                    if (selected.IsQueryString == true)
                    {
                        $('#pagecontainer').attr("src", selected.NavigationLink);
                    }
                    else
                    {
                        $('#pagecontainer').attr("src", selected.NavigationLink + "." + selected.PageExtension);
                    }
                }
            }
        });

        $('#pagecontainer').load(function ()
        {
            /* access iframe content to remove iframe's scrollbar */
            //if ($(this).contents().find('#pdf-main').length > 0) {
            //    var pdfMainHeight = $(this).contents().find('#pdf-main .d').outerHeight();


            //    $(this).contents().find('#pdf-main').attr("style", "overflow:hidden!important");
            //    $(this).outerHeight(pdfMainHeight + 103);
            //    $(".modulewrapper").outerHeight(pdfMainHeight + 31);
            //    //$(this).attr("style", "padding-bottom:68px");
            //    $('#wrapper #menu').outerHeight(pdfMainHeight + 35);
            //    //$("#footer").css("margin-top","100px");
            //} else {
            //    //$(this).attr("style", "padding-bottom:0");
            //    $('#wrapper #menu, .modulewrapper').css("height", "660px");
            //    $(this).css("height", "660px");
            //   // $("#footer").css("margin-top", "5px");
            //    $(".modulecontainer").css("margin-bottom", "0");
            //}
            

            /*remove wait modal popup extender, indicating that the page content has been loaded*/
            $find('<%= LoadExtender.ClientID %>').hide();
        });


        $('#visiotree').bind('tree.click', function (event)
        {
            // The clicked node is 'event.node'
            var node = event.node;

            if (node != null && node != false)
            {
                ActivateTreeField(true);

                $("#<%=VSNMTxt.ClientID%>").val(node.name);
                var navigationPart = node.NavigationURL.split('=');

                $("#<%=VSIOVWRTxt.ClientID%>").val(navigationPart[0]);
                $("#<%=NAVTxt.ClientID%>").val(navigationPart[1]);

                /*bind module name*/
                bindComboboxAjax('loadMainModules', '#<%=MODULCBox.ClientID%>', node.RelatedModule, "#MODUL_LD");
            }
        });

        $("#close").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to close the window?');
            if (result == true) {
                $("#cancel").trigger('click');
            }
        });

        $("#save").bind('click', function ()
        {
            var result = confirm('Are you sure you would like to commit changes?');
            if (result == true)
            {
                var Json = $('#visiotree').tree('toJson');

                saveData(Json);
            }
        });
    });

    function viewHomeProcess()
    {
        $('#pagecontainer').show();
        $('#pagecontainer').attr("src", getURL().concat('HTML/Business_Model.html'));
    }

    function News() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/Press_Releases.html'));
    }

    function Glossary() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/Glossary.htm'));
    }

    function Objectives() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/QMSrs_Objectives.html'));
    }
    function Calendar() {

        $('#pagecontainer').attr("src", getURL().concat('EmployeeTraining/Calendar.aspx'));
    }


    function QualityRecords() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/Quality Records.html'));
    }

    function OperationsManual() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/QMSrs Operations Manual.html'));
    }

    function OrgChart() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/Organisation Structure-QMSrs.html'));
    }

    function Polices() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/QMSrsPolices.html'));
    }

    function Processes() {

        $('#pagecontainer').attr("src", getURL().concat('HTML/Internal processes.html'));
    }

    function removeVisio(node)
    {
        var result = confirm("Are you sure you would like to remove the selected visio process diagram (" + node.name + ")");
        if (result == true)
        {
            $(".modalPanel").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'nodeID':'" + node.NodeID +"'}",
                url: getServiceURL().concat("removeVisioLink"),
                success: function (data)
                {
                    $(".modalPanel").css("cursor", "default");
                    refreshVisio();
                },
                error: function (xhr, status, error)
                {
                    $(".modalPanel").css("cursor", "default");

                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(xhr.responseText);
                }
            });
        }
    }

    function refreshVisio()
    {
        ActivateTreeField(false);

        $("#visiowait").stop(true).hide().fadeIn(500, function ()
        {
            $(".modalPanel").css("cursor", "wait");
            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                url: getServiceURL().concat('loadVisoProcesses'),
                success: function (data) {
                    $("#visiowait").fadeOut(500, function ()
                    {
                        $(".modalPanel").css("cursor", "default");

                        var existingjson = $('#visiotree').tree('toJson');
                        if (existingjson == null) {
                            $('#visiotree').tree(
                            {
                                data: $.parseJSON(data.d),
                                slide: false
                            });
                        }
                        else {
                            $('#visiotree').tree('loadData', $.parseJSON(data.d));
                        }
                    });
                },
                error: function (xhr, status, error) {
                    $("#visiowait").fadeOut(500, function () {
                        $(".modalPanel").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function saveData(jsondata)
    {
        $("#SaveTooltip").stop(true).hide().fadeIn(500, function ()
        {
            ActivateSave(false);

            var jsonparam = JSON.stringify({ json: jsondata });
            jsonparam = jsonparam.replace(new RegExp(/\//g), '\\\\/');
            jsonparam = jsonparam.replace("{}", "null");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: jsonparam,
                url: getServiceURL().concat("UploadVisioLinks"),
                success: function (data)
                {
                    $("#SaveTooltip").fadeOut(500, function () {
                        ActivateSave(true);

                        refreshMain($("#<%=PRMSS.ClientID%>").val());

                        $("#cancel").trigger('click');
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#SaveTooltip").fadeOut(500, function () {
                        ActivateSave(true);

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(xhr.responseText);
                    });
                }
            });
        });
    }

    function ActivateTreeField(isactive) {
        if (isactive == false) {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("textbox");
                $(this).addClass("readonly");
                $(this).attr('readonly', true);
            });

            $(".textremaining").each(function () {
                $(this).html('');
            });

            $(".combobox").each(function ()
            {
                $(this).empty();
                $(this).attr('disabled', true);
            });
        }
        else {
            $(".treefield").each(function () {
                $(this).val('');
                $(this).removeClass("readonly");
                $(this).addClass("textbox");
                $(this).attr('readonly', false);
            });

            $(".combobox").each(function ()
            {
                $(this).attr('disabled', false);
            });
        }
    }

    function refreshMain(permissions)
    {
        $("#mainloader").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'permissions':'" + permissions + "'}",
                url: getServiceURL().concat('loadModuleTree'),
                success: function (data)
                {
                    $("#mainloader").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        var existingjson = $('#tooltree').tree('toJson');

                        if (existingjson == null)
                        {
                            $('#tooltree').tree(
                            {
                                data: $.parseJSON(data.d),
                                slide: false,
                                dragAndDrop: false
                            });
                        }
                        else
                        {
                            $('#tooltree').tree('loadData', $.parseJSON(data.d));
                        }
                    });
                },
                error: function (xhr, status, error) 
                {
                    $("#mainloader").fadeOut(500, function ()
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
