<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ViewActions.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ViewActions" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="toolbox" style="margin-top:0;">
            <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="../../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byProblemType">Filter by Problem Type</li>
                    <li id="byActionType">Filter by Action Type</li>
                    <li id="byProblemStatus">Filter by Problem Status</li>
                    <li id="byActionee">Filter by Actionee</li>
                    <li id="byOriginator">Filter by Originator</li>
                    <li id="byOwner">Filter by Owner</li>
                    <li id="byExecutive">Filter by Executive</li>
                </ul>
            </div>
            <div id="ProblemTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ProblemTypeLabel" style="width:100px;">Problem Type:</div>
                 <div id="ProblemTypeField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="PRMTYPCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>
            
            <div id="ActionTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ActionTypeLabel" style="width:100px;">Action Type:</div>
                 <div id="ActionTypeField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ACTTYPCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>
            <div id="ProblemStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ProblemStatusLabel" style="width:100px;">Problem Status:</div>
                 <div id="ProblemStatusField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="PRMSTSCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>  
           <div id="ActioneeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ActioneeLabel" style="width:100px;">Actionee:</div>
                 <div id="ActioneeField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ACTEECBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>  
            <div id="OriginatorContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="OriginatorLabel" style="width:100px;">Problem Originator:</div>
                 <div id="OriginatorField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="ORGCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div> 

            <div id="OwnerContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="OwnerLabel" style="width:100px;">Problem Owner:</div>
                 <div id="OwnerField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="OWNRCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>

            <div id="ExecutiveContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ExecutiveLabel" style="width:100px;">Problem Executive:</div>
                 <div id="ExecutiveField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="EXECCBox" runat="server" Width="150px" CssClass="combobox">
                    </asp:DropDownList>
                </div> 
            </div>
           &nbsp;&nbsp;
           <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; display:none;" OnClick="Search_Click"  />
        
           
        </div>
        
        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%">
        </rsweb:ReportViewer>

        
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

            $("#byTargetClose").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                 $("#TargetDateContainer").show();
             });

            $("#byActionee").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#ActioneeContainer").show();
            });

            $("#byOriginator").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#OriginatorContainer").show();
            });

            $("#byOwner").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#OwnerContainer").show();
            });

            $("#byExecutive").bind('click', function () {
                hideAll();
                $("#<%=Search.ClientID%>").show();

                $("#ExecutiveContainer").show();
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
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });

            reset();
        }
    </script>

</asp:Content>

   