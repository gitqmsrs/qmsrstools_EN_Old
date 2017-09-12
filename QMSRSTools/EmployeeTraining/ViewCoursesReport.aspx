<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewCoursesReport.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.ViewCoursesReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

    <div class="toolbox">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byStatus">Filter by Course Status</li>
                <li id="byRECMOD">Filter by Record Mode</li>
                <li id="bySTRTDT">Filter by Course Start Date</li>
            </ul>
        </div>       
    

    <div id="CourseStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:5px; display:none;">
        <div id="CourseStatusFLabel" class="filterlabel" style="width:100px;">Course Status:</div>
        <div id="CourseStatusFField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="CSTSFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="RecordModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:5px; display:none;">
        <div id="RecordModeLabel" class="filterlabel" style="width:100px;">Record Mode:</div>
        <div id="RecordModeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="StartDateFilterContainer" class="filter" style=" float: left; width: 370px; margin-left: 10px; height: 20px; margin-top: 5px; display: none;">
        <div id="StartDateFLabel" class="filterlabel" style="width:70px;">Start Date:</div>
        <div id="StartDateFField" class="filterfield"  style="width:270px; left:0; float:left;">
            <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
            <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
            <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
        </div>
        <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
        <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
        </ajax:MaskedEditExtender>
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
                                   
                                    <asp:ListItem Text="Course No" Value="CourseNo" />
                                    <asp:ListItem Text="Duration" Value="Duration" />
                                    <asp:ListItem Text="Capacity" Value="Capacity" />
                                    <asp:ListItem Text="StartDate" Value="StartDate" />
                                       <asp:ListItem Text="End Date" Value="EndDate" />
                                         <asp:ListItem Text="Coordinator" Value="Coordinator" />
                                    <asp:ListItem Text="CourseStatus" Value="CourseStatus" />

                                </asp:ListBox>
                </div>
            </div>
			
			<!--END: Display Fields -->

    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px;" OnClick="Search_Click"  />
    </div> <!-- toolbox -->
    <rsweb:reportviewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%"  SizeToReportContent="True">
    </rsweb:reportviewer>
</div>

<script type="text/javascript" language="javascript">
        $(function ()
        {
            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

           
    
            $("#byStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#CourseStatusContainer").show();

              });

            $("#byRECMOD").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#RecordModeContainer").show();

            });

            $("#bySTRTDT").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                 $("#StartDateFilterContainer").show();
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
            $("#<%=Search.ClientID%>").hide();
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
            $('#filterList').attr('style', 'display:none  !important');
            reset();
        }

    </script>
</asp:Content>
