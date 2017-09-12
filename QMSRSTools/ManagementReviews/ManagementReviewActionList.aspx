<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ManagementReviewActionList.aspx.cs" Inherits="QMSRSTools.ManagementReviews.ManagementReviewActionList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="toolbox" style="margin-top:0;">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                 <li id="byActionee">Filter by Actionee</li>
                 <li id="byACTTYP">Filter by Action Type</li>
                 <li id="byMeeting">Filter by Meeting</li>
                 <li id="byUnit">Filter by Organization unit</li>
                 <li id="byRECMOD">Filter by Record Mode</li>
            </ul>
        </div>
         <input type="hidden" name="HackSearch"  id="HackSearch" value="N"> </input>
        <div id="ActioneeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ActioneeLabel" style="width:100px;">Actionee:</div>
            <div id="ActioneeField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="ACTEECBox" runat="server" Width="150px" CssClass="combobox">
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

        <div id="ActionTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ActionTypeFLabel" style="width:100px;">Course Status:</div>
            <div id="ActionTypeFField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="ACTTYPFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
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

        <div id="ReviewMeetingContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ReviewMeetingLabel" style="width:100px;">Review Meeting Keyword:</div>
            <div id="ReviewMeetingField" style="width:150px; left:0; float:left;">
                <asp:TextBox ID="REVMTTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
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
                                   
                                    <asp:ListItem Text="ActionType" Value="ActionType" />
                                    <asp:ListItem Text="Target Date" Value="TargetDate" />
                                    <asp:ListItem Text="Delayed To" Value="DelayedTo" />
                                    <asp:ListItem Text="Completed" Value="Completed" />
                                       <asp:ListItem Text="Details" Value="Details" />
                                         <asp:ListItem Text="Status" Value="Status" />

                                </asp:ListBox>
                </div>
            </div>
			
			<!--END: Display Fields -->

        &nbsp;&nbsp;
        <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />
       
        </div> <!-- ToolBox -->
    
       <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%" SizeToReportContent="True">
       </rsweb:ReportViewer>
    
    <script type="text/javascript" language="javascript">

     

           $(function ()
           {
               $("#deletefilter").bind('click', function ()
               {
                   hideAll();
                   $("#<%=Search.ClientID%>").trigger('click');
               });

               $("#byActionee").bind('click', function () {
                   hideAll();
                   $("#<%=Search.ClientID%>").show();
                   $("#ActioneeContainer").show();
               });


               $("#byUnit").bind('click', function () {
                   hideAll();
                   $("#<%=Search.ClientID%>").show();
                   $("#UnitContainer").show();

               });

               $("#byMeeting").bind('click', function () {
                   hideAll();
                   $("#<%=Search.ClientID%>").show();

                   $("#ReviewMeetingContainer").show();
               });

               $("#byRECMOD").bind('click', function () {
                   hideAll();
                   $("#<%=Search.ClientID%>").show();

                   $("#RecordModeContainer").show();
               });


               $("#byACTTYP").bind('click', function () {
                   hideAll();
                   $("#<%=Search.ClientID%>").show();

                   $("#ActionTypeContainer").show();
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
        function hideAll() {
            $("#<%=Search.ClientID%>").hide();

            $(".filter").each(function () {
                $(this).css('display', 'none');
            });

            reset();
        }
    </script>
</asp:Content>
