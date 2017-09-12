<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="ViewProblems.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ViewProblems" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
     <div class="toolbox">
            <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="/Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byPartyType">Filter by Affected Party Type</li>
                    <li id="byProblemType">Filter by Problem Type</li>
                    <li id="byRootCause">Filter by Root Cause</li>
                    <li id="byProblemStatus">Filter by Problem Status</li>
                    <li id="byRecordMode">Filter by Record Mode</li>
                </ul>
            </div>
     

     <div id="ProblemTypeContainer" class="filter"  style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemTypeLabel" class="filterlabel" style="width:100px;">Problem Type:</div>
        <div id="ProblemTypeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="PRMTYPCBox" runat="server"  Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

     <div id="RootCauseContainer"class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="RootCauseLabel" class="filterlabel" style="width:100px;">Root Cause:</div>
        <div id="RootCauseField" class="filterfield"  style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="RTCUSCBox"  runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>    
     </div>

     <div id="RecordModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="RecordModeLabel" class="filterlabel" style="width:100px;">Record Mode:</div>
        <div id="RecordModeField" class="filterfield"  style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="RECMODCBox"  runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

     <div id="ProblemStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemStatusLabel" class="filterlabel" style="width:100px;">Problem Status:</div>
        <div id="ProblemStatusField" class="filterfield"  style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="PRMSTSCBox" runat="server"  Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

     <div id="PartyTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="PartyTypeLabel" class="filterlabel" style="width:100px;">Affected Party Type:</div>
        <div id="PartyTypeField" class="filterfield"  style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="PRTYPCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
     </div>

         	<!--BEGIN: Display Fields -->
        <div id="Div1"  style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px;">
                <div id="Div2" style="width:80px;">Display Fields:</div>
                <div id="Div3" style="width:100px !important; left:0; float:left;" class="mid-width">
                                 <link href="../CSS/bootstrap.css" type="text/css" rel="Stylesheet" />
                                  <script type="text/javascript" src="../JS/bootstrap.js"></script>
                                 <link href="../CSS/bootstrap-multiselect.css" type="text/css" rel="Stylesheet" />
                                  <script type="text/javascript" src="../JS/bootstrap-multiselect.js"></script>

                                <script type="text/javascript">
                                    $(function () {
                                        $('[id*=lstFields]').multiselect({
                                            includeSelectAllOption: true,
                                            buttonText: function (options) {
                                                if (options.length == 0) {
                                                    return 'None selected ';
                                                } else {
                                                    var selected = 0;
                                                    options.each(function () {
                                                        selected += 1;
                                                    });
                                                    return selected + ' Selected ';
                                                }
                                            }
                                        });



                                    });

                                    $(document).ready(function () {
                                        //    $('[id*=lstFields]').multiselect('selectAll', false);
                                        //  $('[id*=lstFields]').multiselect('updateButtonText');

                                        if ("<%=IsPostBack%>" == "False") {
                                            // Call the JS Function Here
                                            $('[id*=lstFields]').multiselect('selectAll', false);
                                            $('[id*=lstFields]').multiselect('updateButtonText');

                                        }


                                    });
                                </script>
                                <asp:ListBox ID="lstFields" runat="server" SelectionMode="Multiple" >
                                   
                                    <asp:ListItem Text="Problem" Value="Problem" />
                                    <asp:ListItem Text="Problem Type" Value="ProblemType" />
                                    <asp:ListItem Text="Root Cause" Value="RootCause" />
                                    <asp:ListItem Text="Target Close On" Value="TargetCloseOn" />
                                       <asp:ListItem Text="Actual Close Date" Value="ActualCloseDate" />
                                         <asp:ListItem Text="Originator" Value="Originator" />
                                    <asp:ListItem Text="Status" Value="Status" />

                                </asp:ListBox>
                </div>
            </div>
			
			<!--END: Display Fields -->

     <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px; " OnClick="Search_Click"  />
        
         </div> <!-- ToolBox -->
     <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%" SizeToReportContent="True">
     </rsweb:ReportViewer>

        <script type="text/javascript" language="javascript">
            $(function () {
                $("#deletefilter").bind('click', function ()
                {
                    hideAll();
                    $("#<%=Search.ClientID%>").trigger('click');
                });

                $("#byPartyType").bind('click', function ()
                {
                    hideAll();

                    $("#<%=Search.ClientID%>").show();
                    $("#PartyTypeContainer").show();
                });


                $("#byProblemStatus").bind('click', function ()
                {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#ProblemStatusContainer").show();
                });

                $("#byProblemType").bind('click', function () {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#ProblemTypeContainer").show();
                });

                $("#byRootCause").bind('click', function () {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#RootCauseContainer").show();
                });

                $("#byRecordMode").bind('click', function () {
                    hideAll();
                    $("#<%=Search.ClientID%>").show();

                    $("#RecordModeContainer").show();
                });

            });

         function reset() {
             $(".filtertext").each(function () {
                 $(this).val('');
             });

             $(".comboboxfilter").each(function () {

                 $(this).val(-1);
             });
         }

         function hideAll() {
             $(".filter").each(function () {
                 $(this).css('display', 'none');
             });

             reset();
         }
    </script>

</div>
</asp:Content>
