<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ViewActions.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ViewActions" %>
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
                    <li id="byProblemType">Filter by Problem Type</li>
                    <li id="byActionType">Filter by Action Type</li>
                    <li id="byProblemStatus">Filter by Problem Status</li>
                    <li id="byActionee">Filter by Actionee</li>
                </ul>
            </div>
     
     
     
     <div id="ProblemTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemTypeLabel" class="filterlabel" style="width:100px;">Problem Type:</div>
        <div id="ProblemTypeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="PRMTYPCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
     </div>
            
     <div id="ActionTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ActionTypeLabel" class="filterlabel" style="width:100px;">Action Type:</div>
        <div id="ActionTypeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="ACTTYPCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
     </div>
     
     <div id="ProblemStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemStatusLabel" class="filterlabel" style="width:100px;">Problem Status:</div>
        <div id="ProblemStatusField" class="filterfield"  style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="PRMSTSCBox" runat="server" Width="140px" CssClass="comboboxfilter">
            </asp:DropDownList>
        </div> 
     </div>
      
     <div id="ActioneeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ActioneeLabel" class="filterlabel" style="width:100px;">Actionee:</div>
        <div id="ActioneeField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="ACTEECBox" runat="server" Width="140px" CssClass="comboboxfilter">
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
                                   
                                    <asp:ListItem Text="Action" Value="Action1" />
                                    <asp:ListItem Text="Type" Value="Type" />
                                    <asp:ListItem Text="Start Date" Value="StartDate" />
                                    <asp:ListItem Text="ExpectedClose" Value="ExpectedClose" />
                                       <asp:ListItem Text="ActualClose" Value="ActualClose" />
                                         <asp:ListItem Text="Actionee" Value="Actionee" />
                                    <asp:ListItem Text="Status" Value="Status" />

                                </asp:ListBox>
                </div>
            </div>
			
			<!--END: Display Fields -->

     <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px;" OnClick="Search_Click"  />
      
         </div> <!-- ToolBox -->  
     <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%" SizeToReportContent="True">
     </rsweb:ReportViewer>

</div>
        
     <script type="text/javascript" language="javascript">
         $(function () {
             $("#deletefilter").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").trigger('click');
             });

             $("#byProblemType").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();
                 $("#ProblemTypeContainer").show();
             });


             $("#byProblemStatus").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#ProblemStatusContainer").show();
             });

             $("#byActionType").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#ActionTypeContainer").show();
             });

             $("#byActionee").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#ActioneeContainer").show();
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

         function hideAll() {
             $(".filter").each(function () {
                 $(this).css('display', 'none');
             });

             reset();
         }
    </script>

</asp:Content>

   