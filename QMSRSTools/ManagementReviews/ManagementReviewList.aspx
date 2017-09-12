<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManagementReviewList.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ManagementReviewList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul  id="filterList" class="contextmenu">
                 <li id="byRepresentatives">Filter by Representative</li>
                 <li id="byUnit">Filter by Organization unit</li>
                 <li id="byReviewStatus">Filter by Review Status</li>
                 <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
    
        <div id="RepresentativeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RepresentativeLabel" style="width:100px;">Auditor:</div>
            <div id="RepresentativeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="REPRCBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
        </div>
            
        <div id="UnitContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="UnitLabel" style="width:100px;">Org. Unit:</div>
            <div id="UnitField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="UNTCBox" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div> 
        </div>

        <div id="ReviewStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ReviewStatusFLabel" style="width:100px;">Course Status:</div>
            <div id="ReviewStatusFField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="REVSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                </asp:DropDownList>
            </div>
        </div>

        <div id="RecordModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RecordModeLabel" style="width:100px;">Record Mode:</div>
            <div id="RecordModeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="combobox">
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
                                   
                                    <asp:ListItem Text="Review No" Value="ReviewNo" />
                                    <asp:ListItem Text="Category" Value="Category" />
                                    <asp:ListItem Text="Meeting Objectives" Value="MeetingObjectives" />
                                    <asp:ListItem Text="Planned On" Value="PlannedOn" />
                                       <asp:ListItem Text="Actual" Value="Actual" />
                                         <asp:ListItem Text="Close Date" Value="CloseDate" />
                                    <asp:ListItem Text="Status" Value="Status" />

                                </asp:ListBox>
                </div>
            </div>
			
			<!--END: Display Fields -->
        &nbsp;&nbsp;
        <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />
       
    </div> <!-- ToolBox -->
    
    <rsweb:reportviewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%"  SizeToReportContent="True">
    </rsweb:reportviewer>
            
    <script type="text/javascript" language="javascript">
        $(function () {
            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

            $("#byRepresentatives").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#RepresentativeContainer").show();
            });


            $("#byUnit").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#UnitContainer").show();

            });

            $("#byReviewStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#ReviewStatusContainer").show();
            });

            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#RecordModeContainer").show();
            });


            $("#byCAT").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#ReviewCategoryContainer").show();
            });
        });
        function reset() {
            $(".textbox").each(function () {
                $(this).val('');
            });
            $(".combobox").each(function () {

                $(this).val(-1);
            });
        }
        <%--function hideAll() {
            $("#<%=Search.ClientID%>").hide();

            $(".filter").each(function () {
                $(this).css('display', 'none');
            });

            reset();
        }--%>

        // Added by JP - Override the CSS Hover in contextmenu. 
        $("#filterList").hover(function () {
            $('#filterList').removeAttr('style');
        });

        // Added by JP - Hide the contextMenu after click
        function hideAll() {
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
            $('#filterList').attr('style', 'display:none  !important');
            reset();
        }
    </script>
</asp:Content>
