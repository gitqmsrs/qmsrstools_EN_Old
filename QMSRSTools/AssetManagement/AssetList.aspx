<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="AssetList.aspx.cs" Inherits="QMSRSTools.AssetManagement.AssetList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="toolbox" style="margin-top:0;">
            <img id="deletefilter" src="<%=GetSitePath() + "/Images/filter-delete-icon.png" %>" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="<%=GetSitePath() + "/Images/filter.png" %>" alt=""/>
                <ul id="filterList" class="contextmenu">
                    <li id="byCAT">Filter by Asset Category</li>
                    <li id="byASSTSTS">Filter by Asset Status</li>
                    <li id="byORG">Filter by Organization Unit</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>

            <div id="AssetCategoryContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="AssetCategoryFLabel" style="width:100px;">Asset Category:</div>
                <div id="AssetCategoryFField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ASSTCATFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            </div>

            <div id="AssetOrganizationUnitContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="AssetOrganizationFLabel" style="width:100px;">Organization Unit:</div>
                <div id="AssetOrganizationFField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ORGUNTFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div>
            </div>

            <div id="AssetStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                <div id="AssetStatusFLabel" style="width:100px;">Asset Status:</div>
                <div id="AssetStatusFField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ASSTSTSFCBox" AutoPostBack="false" runat="server" Width="150px" CssClass="combobox">
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
        <div id="Div1"  style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px;">
                <div id="Div2" style="width:80px;">Display Fields:</div>
                <div id="Div3" style="width:100px !important; left:0; float:left;" class="mid-width">
                                 <link href="<%=GetSitePath() + "/CSS/bootstrap.css" %>" type="text/css" rel="Stylesheet" />
                                  <script type="text/javascript" src="<%=GetSitePath() + "/JS/bootstrap.js" %>"></script>
                                 <link href="<%=GetSitePath() + "/CSS/bootstrap-multiselect.css" %>" type="text/css" rel="Stylesheet" />
                                  <script type="text/javascript" src="<%=GetSitePath() + "/JS/bootstrap-multiselect.js" %>"></script>

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
                                   
                                    <asp:ListItem Text="Category Name" Value="CategoryName" />
                                    <asp:ListItem Text="Tag" Value="Tag" />
                                    <asp:ListItem Text="BarCode" Value="BarCode" />
                                    <asp:ListItem Text="Description" Value="Description" />
                                       <asp:ListItem Text="Price" Value="Price" />
                                         <asp:ListItem Text="Currency" Value="Currency" />
                                     <asp:ListItem Text="Purchase Date" Value="PurchaseDate" />
                                     <asp:ListItem Text="Installation Date" Value="InstallationDate" />
                                     <asp:ListItem Text="Owner" Value="Owner" />
                                     <asp:ListItem Text="Acquisition Method" Value="AcquisitionMethod" />

                                </asp:ListBox>
                </div>
            </div>

            &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; " OnClick="Search_Click"  />
        </div>
         
       <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%" SizeToReportContent="True">
       
       </rsweb:ReportViewer>
       <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="GetData" TypeName="QMSRSTools.QMSRSToolsENDataSetAssetListTableAdapters.AssetListTableAdapter" OldValuesParameterFormatString="original_{0}">
        
     </asp:ObjectDataSource>
       
       <script type="text/javascript" language="javascript">
           $(function () {
               $("#deletefilter").bind('click', function () {
                   hideAll();
                   $("#<%=Search.ClientID%>").trigger('click');
             });

             $("#byCAT").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();
                 $("#AssetCategoryContainer").show();
             });


             $("#byUnit").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();
                 $("#UnitContainer").show();

             });

             $("#byASSTSTS").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#AssetStatusContainer").show();
             });

             $("#byORG").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#AssetOrganizationUnitContainer").show();
             });

             $("#byRECMOD").bind('click', function () {
                 hideAll();
                 $("#<%=Search.ClientID%>").show();

                 $("#RecordModeContainer").show();
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

               $("#<%=Search.ClientID%>").hide();

               $(".filter").each(function () {
                   $(this).css('display', 'none');
               });
               $('#filterList').attr('style', 'display:none  !important');
               reset();
           }
    </script>
</asp:Content>
