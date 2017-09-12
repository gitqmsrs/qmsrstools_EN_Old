<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="RiskMaintenance.aspx.cs" Inherits="QMSRSTools.RiskManagement.RiskMaintenance" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div id="Risk_Header" class="moduleheader">Maintain Risk Assessment Guidelines</div>

    <div class="toolbox">
        <img id="refresh" src="../Images/refresh.png" class="imgButton" title="Refresh Data" alt="" />
        <img id="save" src="../Images/save.png" class="imgButton" title="Save Changes" alt="" /> 

        <div id="RiskTypeContainer" style=" float:left;width:500px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="RiskTypeLabel" style="width:100px;">Risk Type:</div>
            <div id="RiskTypeField" style="width:250px; left:0; float:left;">
                <asp:DropDownList ID="RSKTYPCBox" AutoPostBack="false" Width="250px" runat="server" CssClass="combobox">
                </asp:DropDownList>
            </div>
            <div id="RSKTYP_LD" class="control-loader"></div>
        </div>

    </div>

     <div id="rskmaintwait" class="loader">
        <div class="waittext">Retrieving Data, Please Wait...</div>
    </div>

    <div id="TimeInfoGroupHeader" class="groupboxheader">Timescale Guidlines</div>
    <div id="TimeInfoGroup" class="groupbox" style="height:200px;">
        <div id="Time_LD" class="control-loader"></div> 
       
        <div id="time" class="table" style=" margin-top:10px; display:none;">
            <div id="time_row_header" class="tr">
                <div id="time_col0_head" class="tdh" style="width:50px;"></div>
                <div id="time_col1_head" class="tdh" style="width:30%">Risk Criteria</div>
                <div id="time_col2_head" class="tdh" style="width:30%">TIMESCALE (MEASURED AGAINST MILESTONES)</div>
            </div>
        </div>
    </div>
        
    <div id="CostInfoGroupHeader" class="groupboxheader">Budget & Cost Estimation Guidlines</div>
    <div id="CostInfoGroup" class="groupbox" style="height:200px;">
        <div id="Cost_LD" class="control-loader"></div> 
          
        <div id="cost" class="table" style=" margin-top:10px; display:none;">
            <div id="cost_row_header" class="tr">
                <div id="cost_col0_head" class="tdh" style="width:50px;"></div>
                <div id="cost_col1_head" class="tdh" style="width:30%">Risk Criteria</div>
                <div id="cost_col2_head" class="tdh" style="width:30%">Budget (EFFORT)</div>
                <div id="cost_col3_head" class="tdh" style="width:30%">Budget (MATERIAL)</div>
            </div>
        </div>
    </div>

    <div id="QualityInfoGroupHeader" class="groupboxheader">Quality of Service Guidlines</div>
    <div id="QualityInfoGroup" class="groupbox" style="height:200px;">
        <div id="Quality_LD" class="control-loader"></div> 

        <div id="quality" class="table" style=" margin-top:10px; display:none;">
            <div id="quality_row_header" class="tr">
                <div id="quality_col0_head" class="tdh" style="width:50px;"></div>
                <div id="quality_col1_head" class="tdh" style="width:30%">Risk Criteria</div>
                <div id="quality_col2_head" class="tdh" style="width:30%">QOS (Functionality / Availability)</div>
                <div id="quality_col3_head" class="tdh" style="width:30%">QOS (Loss of Benefit)</div>
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

<script type="text/javascript" language="javascript">
    $(function ()
    {
        /*load ISO 30000 risk types*/
        loadComboboxAjax('loadISO30000RiskType', "#<%=RSKTYPCBox.ClientID%>", "#RSKTYP_LD");


        $("#<%=RSKTYPCBox.ClientID%>").change(function ()
        {
            if ($(this).val() != 0) {
                loadTimeImpactGuidLines($(this).val());
                loadCostImpactGuidLines($(this).val());
                loadQOSImpactGuidLines($(this).val());
            }
        });

        $("#refresh").bind('click', function ()
        {
            $("#<%=RSKTYPCBox.ClientID%>").trigger('change');
        });

      
        $("#save").bind('click', function ()
        {
            /*merge cost & time into the first temporary array*/
            var time = $("#time").table('getJSON');
            var cost = $("#cost").table('getJSON');
            var quality = $("#quality").table('getJSON');

            if (time != null && cost != null && quality != null)
            {
                var temparray1 = time.concat(cost);

                /*merge quality of service with the first temporary array to produce a complete impact JSON data*/

                var temparray2 = temparray1.concat(quality);

                if (temparray2.length > 0) {
                    var result = confirm("Are you sure you would like to submit changes?");
                    if (result == true) {
                        $find('<%= SaveExtender.ClientID %>').show();

                        $.ajax(
                        {
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            data: "{\'json\':\'" + JSON.stringify(temparray2) + "\'}",
                            url: getServiceURL().concat('UploadImpactGuidlines'),
                            success: function (data) {
                                $find('<%= SaveExtender.ClientID %>').hide();
                                $("#refresh").trigger('click');

                            },
                            error: function (xhr, status, error) {
                                $find('<%= SaveExtender.ClientID %>').hide();

                                var r = jQuery.parseJSON(xhr.responseText);
                                alert(r.Message);
                            }
                        });
                    }
                }
                else
                {
                    alert("There are no data which can be submitted");
                }
            }
        });
    });

    function loadTimeImpactGuidLines(risktype)
    {
        $("#Time_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadTimeImpactGuidLines"),
                success: function (data)
                {
                    $("#Time_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var json = $.parseJSON(data.d);
                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("Description1");

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));

                            $("#time").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#Time_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadCostImpactGuidLines(risktype)
    {
        $("#Cost_LD").stop(true).hide().fadeIn(500, function () {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadCostImpactGuidLines"),
                success: function (data)
                {
                    $("#Cost_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("Description1");
                            attributes.push("Description2");

                            var json = $.parseJSON(data.d);

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));
                            settings.push(JSON.stringify({}));

                            $("#cost").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#Cost_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }

    function loadQOSImpactGuidLines(risktype)
    {
        $("#Quality_LD").stop(true).hide().fadeIn(500, function ()
        {
            $(".modulewrapper").css("cursor", "wait");

            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{'risktype':'" + risktype + "'}",
                url: getServiceURL().concat("loadQOSImpactGuidLines"),
                success: function (data) {
                    $("#Quality_LD").fadeOut(500, function ()
                    {
                        $(".modulewrapper").css("cursor", "default");

                        if (data) {
                            var attributes = new Array();
                            attributes.push("RiskCriteria");
                            attributes.push("Description1");
                            attributes.push("Description2");

                            var json = $.parseJSON(data.d);

                            /*set cell settings*/
                            var settings = new Array();
                            settings.push(JSON.stringify({ readonly: true, type: 'select', loadurl: getServiceURL().concat("loadRiskCriteriaArray") }));
                            settings.push(JSON.stringify({}));
                            settings.push(JSON.stringify({}));

                            $("#quality").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                        }
                    });
                },
                error: function (xhr, status, error)
                {
                    $("#Quality_LD").fadeOut(500, function () {
                        $(".modulewrapper").css("cursor", "default");

                        var r = jQuery.parseJSON(xhr.responseText);
                        alert(r.Message);
                    });
                }
            });
        });
    }
</script>
</asp:Content>
