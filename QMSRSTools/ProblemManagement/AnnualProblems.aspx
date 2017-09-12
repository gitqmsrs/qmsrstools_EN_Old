<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="AnnualProblems.aspx.cs" Inherits="QMSRSTools.ProblemManagement.AnnualProblems" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
         <asp:HiddenField id="dropdownchange" runat="server" />
        <asp:HiddenField id="activedropdown" runat="server" />
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
                <ul class="contextmenu"  id="filterList">
                    <li id="byYear">Filter by Year</li>
                    <li id="byPRMTYP">Filter by Problem Type</li>
                    <li id="byPRMRTCAUS">Filter by Root Cause</li>
                    <li id="byRECMOD">Filter by Record Mode</li>
                </ul>
            </div>
  
 
        <div id="YearContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="YearLabel" class="filterlabel" class="filterlabel" style="width:100px;">Year:</div>
            <div id="YearField" class="filterfield" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="YRCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="YRCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>
        
        <div id="ProblemTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="ProblemTypeLabel" class="filterlabel" style="width:100px;">Problem Type:</div>
            <div id="ProblemTypeField" class="filterfield"  style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="PRMTYPCBox" runat="server" AutoPostBack="true" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="PRMTYPCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>

        <div id="RootCauseContainer"class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RootCauseLabel" class="filterlabel" style="width:100px;">Root Cause:</div>
            <div id="RootCauseField" class="filterfield"  style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RTCUSCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter"  OnSelectedIndexChanged="RTCUSCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div>    
        </div>

        <div id="RecordModeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="RecordModeLabel" class="filterlabel" style="width:100px;">Record Mode:</div>
            <div id="RecordModeField" class="filterfield"  style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="RECMODCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="RECMODCBox_SelectedIndexChanged">
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

                                        if ("<%=IsPostBack%>" == "False" || $('#<%=dropdownchange.ClientID%>').val() == "changed" || $('#<%=dropdownchange.ClientID%>').val() == "reset") {
                                            // Call the JS Function Here
                                            $('[id*=lstFields]').multiselect('selectAll', false);
                                            $('[id*=lstFields]').multiselect('updateButtonText');

                                        }


                                    });
                                </script>
                                <asp:ListBox ID="lstFields" runat="server" SelectionMode="Multiple" >
                                        <asp:ListItem Text="January" Value="January" />
                                          <asp:ListItem Text="February" Value="February" />
                                    <asp:ListItem Text="March" Value="March" />
                                      <asp:ListItem Text="April" Value="April" />
                                      <asp:ListItem Text="May" Value="May" />
                                     <asp:ListItem Text="June" Value="June" />
                                      <asp:ListItem Text="July" Value="July" />
                                       <asp:ListItem Text="August" Value="August" />
                                     <asp:ListItem Text="September" Value="September" />
                                     <asp:ListItem Text="October" Value="October" />
                                        <asp:ListItem Text="November" Value="November" />
                                            <asp:ListItem Text="December" Value="December" />
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

         <asp:ImageButton ID="Alias" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px; display:none;" OnClick="Alias_Click"  />
    
 </div>
    <script type="text/javascript" language="javascript">
        $(function ()
        {
            $("#deletefilter").bind('click', function ()
            {
                hideAll();
                $("#<%=Alias.ClientID%>").trigger('click');
            });

            $("#byYear").bind('click', function ()
            {
                hideAll();
                $("#YearContainer").show();
            });

            $("#byPRMTYP").bind('click', function ()
            {
                hideAll();

                $("#ProblemTypeContainer").show();
            });

            $("#byPRMRTCAUS").bind('click', function ()
            {
                hideAll();
                $("#RootCauseContainer").show();
            });

            $("#byRECMOD").bind('click', function ()
            {
                hideAll();
                $("#RecordModeContainer").show();
            });


        });

        // Added by JP - Override the CSS Hover in contextmenu. 
        $("#filterList").hover(function () {
            $('#filterList').removeAttr('style');
        });

        function hideAll() {
            $(".filter").each(function () {
                $(this).css('display', 'none');
            });
            $('#filterList').attr('style', 'display:none  !important');
            reset();
        }

        function reset() {
            $(".filtertext").each(function () {
                $(this).val('');
            });

            $(".comboboxfilter").each(function () {

                $(this).val(-1);
            });
        }
    </script>
</asp:Content>
