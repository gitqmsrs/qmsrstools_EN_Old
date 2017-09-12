<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="AuditListReport.aspx.cs" Inherits="QMSRSTools.AuditManagement.AuditListReport" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox" >
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byAuditor">Filter by Auditor</li>
                <li id="byUnit">Filter by Organization unit</li>
                <li id="byAuditStatus">Filter by Audit Status</li>
                <li id="byAUDTType">Filter by Audit type</li>
            </ul>
        </div>        
   
        
    <div id="AuditorContainer" class="filter" style ="width:220px;">
        <div id="AuditorLabel" class="filterlabel" style="width:50px;">Auditor:</div>
        <div id="AuditorField" class="filterfield">
            <asp:DropDownList ID="AUDTRCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>
       
    <div id="AuditTypeContainer" class="filter"  style ="width:220px;">
        <div id="AuditTypeFilterLabel" class="filterlabel" style="width:65px;">Audit Type:</div>
        <div id="AuditTypeFilterField" class="filterfield">
            <asp:DropDownList ID="AUDTTYPFCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div>
    </div>

    <div id="UnitContainer" class="filter"  style ="width:220px;">
        <div id="UnitLabelFilterLabel" class="filterlabel" style="width:65px;">Org. Unit:</div>
        <div id="UnitLabelFilterField" class="filterfield">
            <asp:DropDownList ID="UNTCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
      </div>
    </div>

    <div id="AuditStatusContainer" class="filter"  style ="width:220px;">
        <div id="AuditStatusLabel" class="filterlabel" style="width:65px;">Audit Status:</div>
        <div id="AuditStatusField" class="filterfield">
            <asp:DropDownList ID="AUDTSTSCBox" AutoPostBack="false" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
    </div>  
        <!-- BEGIN Display Fields -->
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
                                   
                                          <asp:ListItem Text="Audit No." Value="AuditNo" />
                                    <asp:ListItem Text="Type" Value="Type" />
                                    <asp:ListItem Text="Audit Title" Value="AuditTitle" />
                                     <asp:ListItem Text="Process Document" Value="ProcessDocument" />
                                    <asp:ListItem Text="Planned On" Value="PlannedOn" />
                                       <asp:ListItem Text="Actual Date" Value="ActualDate" />
                                     <asp:ListItem Text="Actual Close Date" Value="ActualCloseDate" />
                                     <asp:ListItem Text="AuditProgress" Value="AuditProgress" />
                                         <asp:ListItem Text="Status" Value="Status" />

                                </asp:ListBox>
                </div>
            </div>

            &nbsp;&nbsp;



          <!-- END Display Fields -->
            
    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" OnClick="Search_Click"  />
  </div> <!-- toolbox -->
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%" SizeToReportContent="True">
    </rsweb:ReportViewer>
</div>
     
<script type="text/javascript" language="javascript">
         $(function () {
             $("#deletefilter").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").trigger('click');
            });

            $("#byAuditor").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#AuditorContainer").show();
            });


            $("#byUnit").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();
                $("#UnitContainer").show();

            });

            $("#byAuditStatus").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#AuditStatusContainer").show();
            });

             $("#byAUDTType").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#AuditTypeContainer").show();
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
