<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ViewActionStatistics.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ViewActionStatistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
           
    <div class="toolbox" style="margin-top:0;">
            <img id="deletefilter" src="../Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
            <div id="filter_div">
                <img id="filter" src="../../Images/filter.png" alt=""/>
                <ul class="contextmenu">
                    <li id="byProblemType">Filter by Problem Type</li>
                    <li id="byTargetClose">Filter by Target Close Date</li>
                    <li id="byProblemStatus">Filter by Problem Status</li>
                </ul>
            </div>
            <div id="ProblemTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ProblemTypeLabel" style="width:100px;">Problem Type:</div>
                 <div id="ProblemTypeField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="PRMTYPCBox" runat="server" AutoPostBack="true" Width="150px" CssClass="combobox" OnSelectedIndexChanged="PRMTYPCBox_SelectedIndexChanged">
                    </asp:DropDownList>
                </div> 
            </div>
            <div id="ProblemStatusContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
                 <div id="ProblemStatusLabel" style="width:100px;">Problem Status:</div>
                 <div id="ProblemStatusField" style="width:150px; left:0; float:left;">
                    <asp:DropDownList ID="PRMSTSCBox" runat="server" Width="150px" CssClass="combobox" OnSelectedIndexChanged="PRMSTSCBox_SelectedIndexChanged">
                    </asp:DropDownList>
                </div> 
            </div>  

            <div id="TargetDateContainer" class="filter" style="float:left; width:450px;margin-left:10px; height:20px; margin-top:3px;display:none;">
                <div id="TargetDateLabel" style="width:120px;">Target Close Date:</div>
                <div id="TargetDateField" style="width:270px; left:0; float:left;">
                    <asp:TextBox ID="FDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                    <asp:Label ID="Label1" runat="server" Text="/" CssClass="label" style="width:5px;"></asp:Label>      
                    <asp:TextBox ID="TDTTxt" runat="server" CssClass="filtertext" Width="120px"></asp:TextBox>
                </div>
                <ajax:MaskedEditExtender ID="FDTExt" runat="server" TargetControlID="FDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
                <ajax:MaskedEditExtender ID="TDTExt" runat="server" TargetControlID="TDTTxt" Mask="99/99/9999" MaskType="Date" MessageValidatorTip="true" InputDirection="LeftToRight" ErrorTooltipEnabled="true">
                </ajax:MaskedEditExtender>
               
                <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />
            </div>
            
            <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />
        </div>

        <div style="float:left; width:100%; height:500px; margin-top:15px;">         
            <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="500">
                    <param name="movie" value="../../Reports/Flash/fcp-bars.swf" />
                    <param name="bgcolor" value="#ffffff" />
                    <param name="quality" value="high" />
                    <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
                    <embed type="application/x-shockwave-flash" src="../../Reports/Flash/fcp-bars.swf" width="900"
                    height="500" name="flashchart" bgcolor="#ffffff" quality="high" flashvars='xml_file=<%=Session["Guid"] %>' />
            </object>
        </div>

        <script type="text/javascript" language="javascript">
            $(function () {
                $("#deletefilter").bind('click', function () {
                    hideAll();

                    $("#<%=alias.ClientID%>").trigger('click');
                });

            $("#byProblemType").bind('click', function () {
                hideAll();
                $("#ProblemTypeContainer").show();
            });


            $("#byProblemStatus").bind('click', function () {
                hideAll();
                $("#ProblemStatusContainer").show();
            });

            $("#byTargetClose").bind('click', function () {
                hideAll();

                $("#TargetDateContainer").show();
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
    
