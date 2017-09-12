<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="ViewCCN.aspx.cs" Inherits="QMSRSTools.ChangeControl.ViewCCN" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox">
        <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt="" />
        
            <div id="filter_div">
                <img id="filter" src="../../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byDOCName">Filter by Document Name</li>
                    <li id="byCCNType">Filter by CCN Type</li>
                    <li id="byCCNStatus">Filter by CCN Status</li>
                </ul>
            </div>
         
            <div id="CCNStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="CCNStatusLabel" style="width:100px;">CCN Status</div>
                 <div id="CCNStatusField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="CCNSTSCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>
            
            <div id="CCNtypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="CCNTypeLabel" style="width:100px;">CCN Type</div>
                 <div id="CCNTypeField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="CCNTYPCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>
            <div id="DocumentContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="DOCNameLabel" style="width:100px;">Document Name</div>
                 <div id="DOCNameField" style="width:150px; left:0; float:left;">
                    <asp:TextBox ID="DOCNTxt" runat="server" CssClass="textbox" Width="140px"></asp:TextBox>
                 </div>
            </div>
        
            &nbsp;&nbsp;
           <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; display:none;" OnClick="Search_Click"  />
        </div>
        
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="100%">
        </rsweb:ReportViewer>
        <script type="text/javascript" language="javascript">
        $(function () {
            $("#deletefilter").bind('click', function () {
                hideAll();
                reset();

                $("#<%=Search.ClientID%>").trigger('click');
            });

            $("#byDOCName").bind('click', function () {
                hideAll();
                reset();

                $("#DocumentContainer").find(".textbox").val('');
                $("#<%=Search.ClientID%>").show();
                $("#DocumentContainer").show();
            });

            $("#byCCNType").bind('click', function () {

                hideAll();
                reset();

                $("#CCNtypeContainer").find(".combobox").val(-1);
                $("#<%=Search.ClientID%>").show();
                $("#CCNtypeContainer").show();
            });


            $("#byCCNStatus").bind('click', function () {
                hideAll();
                reset();

                $("#CCNStatusContainer").find(".combobox").val(-1);
                $("#<%=Search.ClientID%>").show();
                $("#CCNStatusContainer").show();

            });

        });
        function reset() {
            $(".textbox").each(function () {
                $(this).val();
            });
            $(".combobox").each(function () {

                $(this).val(-1);
            });


        }
        function hideAll() {
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
        }
    </script>
</asp:Content>
