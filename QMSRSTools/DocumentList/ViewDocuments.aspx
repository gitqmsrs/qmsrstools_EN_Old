<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewDocuments.aspx.cs" Inherits="QMSRSTools.DocumentList.ViewDocuments" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt="" />
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byType">Filter by Document Type</li>
                <li id="byUnit">Filter by Organization Unit</li>
                <li id="byProject">Filter by Porject Name</li>
                <li id="byStatus">Filter by Document Status</li>
                <li id="byOverDue">Filter by Overdue Duration</li>
            </ul>
        </div>
    

    <div id="DOCTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="DocumentTypeLabel" class="filterlabel" style="width:100px;">Document Type:</div>
        <div id="DocumentTypeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="DOCTYPCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="UnitContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="UnitLabel" class="filterlabel" style="width:100px;">Org. Unit:</div>
        <div id="UnitField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="UNTCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>

    <div id="ProjectContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProjectNameLabel" class="filterlabel"  style="width:100px;">Project Name:</div>
        <div id="ProjectNameField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="PRJCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>

    <div id="OverdueContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="OverdueDurationLabel" class="filterlabel"  style="width:100px;">Overdue Duration:</div>
        <div id="OverdueDurationField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="OVRDUECBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>

    <div id="DocumentStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="DocumentStatusLabel" class="filterlabel"  style="width:100px;">Document Status:</div>
        <div id="DocumentStatusField" class="filterfield"  style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="DOCSTSCBox" runat="server" Width="140px" CssClass="comboboxfilter">
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
                                   
                                    <asp:ListItem Text="Title" Value="Title" />
                                    <asp:ListItem Text="Type" Value="Type" />
                                    <asp:ListItem Text="Duration" Value="Duration" />
                                    <asp:ListItem Text="Issue Date" Value="IssueDate" />
                                       <asp:ListItem Text="Last Reviewed" Value="LastReviewed" />
                                         <asp:ListItem Text="Next Review Date" Value="NextReviewDate" />
                                    <asp:ListItem Text="Status" Value="Status" />

                                </asp:ListBox>
                </div>
            </div>
			
			<!--END: Display Fields -->

    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton"  OnClick="Search_Click"  />
 </div> <!-- ToolBox --> 
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%"  SizeToReportContent="True">
        <LocalReport EnableHyperlinks="True">
        </LocalReport>
     </rsweb:ReportViewer>
</div>         
<script type="text/javascript" language="javascript">
        $(function () {
            $("#deletefilter").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").trigger('click');
            });

            $("#byType").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#DOCTypeContainer").show();
            });


            $("#byUnit").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#UnitContainer").show();

            });

            $("#byProject").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#ProjectContainer").show();

            });

            $("#byOverDue").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#OverdueContainer").show();

            });

            $("#byStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#DocumentStatusContainer").show();
            });
        });

        function reset()
        {
            $(".filtertext").each(function () {
                $(this).val('');
            });

            $(".comboboxfilter").each(function () {

                $(this).val(-1);
            });
        }

    <%--function hideAll()
        {
            $("#<%=Search.ClientID%>").hide();

            $(".filter").each(function ()
            {
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
