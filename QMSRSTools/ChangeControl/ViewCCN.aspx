<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.ViewCCN" %>
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
                <li id="ByDOCTYP">Filter by Document Type</li>
                <li id="byDCRType">Filter by DCR Type</li>
                <li id="byDCRStatus">Filter by DCR Status</li>
            </ul>
        </div>
    

    <div id="DOCTypeContainer" class="filter" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="DocumentTypeLabel" class="filterlabel"  style="width:100px;">Document Type:</div>
        <div id="DocumentTypeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="DOCTYPCBox" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="DCRStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="DCRStatusLabel" class="filterlabel" style="width:100px;">DCR Status:</div>
        <div id="DCRStatusField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="DCRSTSCBox" runat="server" Width="150px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="DCRtypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="DCRTypeLabel" class="filterlabel" style="width:100px;">DCR Type:</div>
        <div id="DCRTypeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="DCRTYPCBox" runat="server" Width="150px" CssClass="comboboxfilter">
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
                                   
                                    <asp:ListItem Text="Version" Value="Version" />
                                    <asp:ListItem Text="Type" Value="Type" />
                                    <asp:ListItem Text="Originator" Value="Originator" />
                                    <asp:ListItem Text="Owner" Value="Owner" />
                                       <asp:ListItem Text="DCRStatus" Value="DCRStatus" />
                                      

                                </asp:ListBox>
                </div>
            </div>
			
			<!--END: Display Fields -->
          
    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px; " OnClick="Search_Click"  />
        </div> <!-- toolbox -->
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%" SizeToReportContent="True">
    </rsweb:ReportViewer>
</div>   

<script type="text/javascript" language="javascript">

    $(function ()
    {
        $("#deletefilter").bind('click', function () {
            hideAll();
            $("#<%=Search.ClientID%>").trigger('click');
        });

        $("#byDCRType").bind('click', function () {

            hideAll();

            $("#<%=Search.ClientID%>").show();
            $("#DCRtypeContainer").show();
        });

        $("#ByDOCTYP").bind('click', function () {
            hideAll();

            $("#<%=Search.ClientID%>").show();

            $("#DOCTypeContainer").show();
        });

        $("#byDCRStatus").bind('click', function () {
            hideAll();

            $("#<%=Search.ClientID%>").show();

            $("#DCRStatusContainer").show();
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
