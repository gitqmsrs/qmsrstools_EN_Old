<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="OrganizationLevel.aspx.cs" Inherits="QMSRSTools.OrganizationManagement.OrganizationLevel" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
<div class="toolbox">
    <img id="save" src="../Images/save.png" class="imgButton" alt="" title="save changes" />
    <img id="refresh" src="../Images/refresh.png" class="imgButton" alt="" title="refresh data" />
    <img id="newlevel" src="../Images/new_file.png" class="imgButton" title="Add New Organization Level" alt=""/>
        
</div>

<div id="LVLWait" class="loader">
    <div class="waittext">Please Wait...</div>
</div>

<div id="table" style="display:none;">
    <div id="row_header" class="tr">
        <div id="col0_head" class="tdh" style="width:50px"></div>
        <div id="col1_head" class="tdh" style="width:30%">Organization Level</div>
    </div>
</div>
<script type="text/javascript" language="javascript">
    $(function () {
        refresh();

        $("#refresh").bind('click', function () {
            refresh();
        });

        $("#newlevel").click(function () {
            $("#table").table('addRow',
            {
                Level: 'New Level',
                Status: 3
            });

        });

        $("#save").bind('click', function () {
            saveData();
        });
    });
    function saveData() {
        var result = confirm("Are you sure you would like to submit changes?");
        if (result == true) {
            jsonparam = JSON.stringify({ json: $("#table").table('getJSON') });


            $.ajax(
            {
                type: "POST",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                data: "{\'json\':\'" + JSON.stringify($("#table").table('getJSON')) + "\'}",
                url: getServiceURL().concat("uploadOrganizationLevel"),
                success: function (data) {
                    if (data) {
                        refresh();
                    }
                },
                error: function (xhr, status, error) {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                }
            });
        }
    }
    function refresh() {
        $("#LVLWait").show();
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            url: getServiceURL().concat("loadJSONOrganizationLevel"),
            success: function (data) {
                if (data) {
                    $("#LVLWait").hide();

                    var json = $.parseJSON(data.d);

                    var attributes = new Array();
                    attributes.push("Level");

                    var settings = new Array();
                    settings.push(JSON.stringify({}));


                    $("#table").table({ JSON: json, Attributes: attributes, Settings: settings, Width: 30 });
                }
            },
            error: function (xhr, status, error) {
                $("#LVLWait").hide();
                var r = jQuery.parseJSON(xhr.responseText);
                alert(r.Message);
            }
        });
    }
</script>
       
</asp:Content>
