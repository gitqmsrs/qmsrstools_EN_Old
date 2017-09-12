<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ProblemsByRootCause.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ProblemsByRootCause" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">

      <asp:HiddenField id="dropdownchange" runat="server" />
        <asp:HiddenField id="activedropdown" runat="server" />
     <div class="toolbox">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul class="contextmenu">
                <li id="byProblemType">Filter by Problem Type</li>
                <li id="byProblemStatus">Filter by Problem Status</li>
                <li id="byPartyType">Filter by Affected Party Type</li>
                <li id="byRecordMode">Filter by Record Mode</li>
            </ul>
        </div>
    

    <div id="ProblemTypeContainer" class="filter" style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemTypeLabel" class="filterlabel" style="width:80px;">Problem Type:</div>
        <div id="ProblemTypeField" class="filterfield" style="left:0; float:left;" >
            <asp:DropDownList ID="PRMTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRMTYPCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="ProblemStatusContainer" class="filter" style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="ProblemStatusLabel" class="filterlabel" style="width:80px;">Problem Status:</div>
        <div id="ProblemStatusField" class="filterfield" style="left:0; float:left;">
            <asp:DropDownList ID="PRMSTSCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRMSTSCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div> 
    </div>  

    <div id="PartyTypeContainer" class="filter" style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="PartyTypeLabel" class="filterlabel" style="width:80px;">Affected Party Type:</div>
        <div id="PartyTypeField" class="filterfield" style="left:0; float:left;">
            <asp:DropDownList ID="PRTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRTYPCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
    </div>
            
    <div id="RecordModeContainer" class="filter" style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="RecordModeLabel" class="filterlabel" style="width:80px;">Record Mode:</div>
        <div id="RecordModeField" class="filterfield" style="left:0; float:left;">
            <asp:DropDownList ID="RECMODCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="RECMODCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
    </div>
          <div id="Div1"  style=" float:left;width:200px; margin-left:50px; height:20px; margin-top:3px;">
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

                                        if ("<%=IsPostBack%>" == "False" || $('#<%=dropdownchange.ClientID%>').val() == "changed" || $('#<%=dropdownchange.ClientID%>').val() == "reset") {
                                            // Call the JS Function Here
                                            $('[id*=lstFields]').multiselect('selectAll', false);
                                            $('[id*=lstFields]').multiselect('updateButtonText');

                                        }


                                    });
                                </script>
                                <asp:ListBox ID="lstFields" runat="server" SelectionMode="Multiple" >
                                     
                                </asp:ListBox>
                </div>
            </div>
               &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />

         </div> <!-- toolbox -->

    <div style="float:left; width:100%; height:500px; margin-top:15px;">         
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="500">
            <param name="movie" value="/Reports/Flash/fcp-bars.swf" />
            <param name="bgcolor" value="#ffffff" />
            <param name="quality" value="high" />
            <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
            <embed type="application/x-shockwave-flash" src="/Reports/Flash/fcp-bars.swf" width="900"
            height="500" name="flashchart" bgcolor="#ffffff" quality="high" flashvars='xml_file=<%=Session["Guid"] %>' />
        </object>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />
    

       
</div> 

<script type="text/javascript" language="javascript">
    $(function ()
    {
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
   
        $("#byPartyType").bind('click', function () {
            hideAll();

            $("#PartyTypeContainer").show();
        });

        $("#byRecordMode").bind('click', function () {
            hideAll();

            $("#RecordModeContainer").show();
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

    function hideAll() {
        $(".filter").each(function () {
            $(this).css('display', 'none');
        });

        reset();
    }
</script>
</asp:Content>