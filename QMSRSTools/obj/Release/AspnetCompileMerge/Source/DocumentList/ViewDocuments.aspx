<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewDocuments.aspx.cs" Inherits="QMSRSTools.DocumentList.ViewDocuments" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox" style="margin-top:0;">
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt="" />
        <div id="filter_div">
                <img id="filter" src="../../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byType">Filter by Document Type</li>
                    <li id="byUnit">Filter by Organization Unit</li>
                    <li id="byProject">Filter by Porject Name</li>
                    <li id="byStatus">Filter by Document Status</li>
                    
                </ul>
            </div>
            <div id="DOCTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="DocumentTypeLabel" style="width:100px;">Document Type:</div>
                 <div id="DocumentTypeField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="DOCTYPCBox" runat="server" Width="150px" CssClass="combobox">
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

            <div id="ProjectContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ProjectNameLabel" style="width:100px;">Project Name:</div>
                 <div id="ProjectNameField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="PRJCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>

            <div id="DocumentStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="DocumentStatusLabel" style="width:100px;">Document Status:</div>
                 <div id="DocumentStatusField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="DOCSTSCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>  
            
            &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; display:none;" OnClick="Search_Click"  />
        </div>
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%">
        </rsweb:ReportViewer>
         
      <script type="text/javascript" language="javascript">
          $(function ()
          {
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

              $("#byProject").bind('click', function ()
              {
                  hideAll();
                  $("#<%=Search.ClientID%>").show();
                  $("#ProjectContainer").show();

              });
              $("#byStatus").bind('click', function () {
                  hideAll();
                  $("#<%=Search.ClientID%>").show();

                  $("#DocumentStatusContainer").show();
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
