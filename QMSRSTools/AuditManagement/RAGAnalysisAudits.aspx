<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="RAGAnalysisAudits.aspx.cs" Inherits="QMSRSTools.AuditManagement.RAGAnalysisAudits" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="toolbox">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
          <asp:HiddenField id="dropdownchange" runat="server" />
        <asp:HiddenField id="activedropdown" runat="server" />
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byAuditors">Filter by Auditors</li>
                <li id="byUnit">Filter by Organization unit</li>  
                <li id="byAUDTTYP">Filter by Audit Type</li>
                <li id="byAUDTSTS">Filter by Audit Status</li>  
            </ul>
        </div>
   
    
    <div id="AuditorContainer" class="filter"  style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="AuditorLabel" class="filterlabel" style="width:100px;">Auditors:</div>
        <div id="AuditorField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="AUDTRCBox" runat="server" Width="140px" CssClass="comboboxfilter" AutoPostBack="true" OnSelectedIndexChanged="AUDTRCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div> 
    </div>
            
    <div id="UnitContainer" class="filter"  style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="UnitLabel" class="filterlabel" style="width:100px;">Org. Unit:</div>
        <div id="UnitField" class="filterfield"  style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="UNTCBox" runat="server" Width="140px" CssClass="comboboxfilter" AutoPostBack="true" OnSelectedIndexChanged="UNTCBox_SelectedIndexChanged" >
            </asp:DropDownList>
        </div> 
    </div>

    <div id="AuditTypeContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="AuditTypeFilterLabel" class="filterlabel" style="width:100px;">Audit Type:</div>
        <div id="AuditTypeFilterField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="AUDTTYPCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="AUDTTYPCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
        
    </div>

    <div id="AuditStatusContainer" class="filter"  style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="AuditStatusFilterLabel" class="filterlabel"  style="width:100px;">Audit Status:</div>
        <div id="AuditStatusFilterField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="AUDTSTSCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="AUDTSTSCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
    </div>
     <asp:ImageButton ID="Reset" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; display:none;" OnClick="Reset_Click"  />    

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

                                        if ("<%=IsPostBack%>" == "False" || $('#<%=dropdownchange.ClientID%>').val() == "changed") {
                                            // Call the JS Function Here
                                            $('[id*=lstFields]').multiselect('selectAll', false);
                                            $('[id*=lstFields]').multiselect('updateButtonText');

                                        }


                                    });
                                </script>
                                <asp:ListBox ID="lstFields" runat="server" SelectionMode="Multiple" >
                                     <asp:ListItem Text="Red" Value="Red" />
                                    <asp:ListItem Text="Amber" Value="Amber" />
                                    <asp:ListItem Text="Green" Value="Green" />
                                </asp:ListBox>
                </div>
            </div>
               &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />


</div> <!-- Toolbox -->

   <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500" width="100%">
            <param name="movie" value="/Reports/Flash/fcp-pie-chart.swf" />
            <param name="bgcolor" value="#ffffff" />
            <param name="quality" value="high" />
            <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
            <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500"
            name="flashchart" quality="high" src="/Reports/Flash/fcp-pie-chart.swf" type="application/x-shockwave-flash"
            width="900"></embed>
         </object>
    </div>
        <script type="text/javascript" language="javascript">
            $(function () {
                $("#deletefilter").bind('click', function () {
                    hideAll();
                    $("#<%=Reset.ClientID%>").trigger('click');
                });

                $("#byAuditors").bind('click', function () {
                    hideAll();

                    $("#AuditorContainer").show();
                });


                $("#byUnit").bind('click', function () {
                    hideAll();

                    $("#UnitContainer").show();

                });

                $("#byAUDTTYP").bind('click', function () {
                    hideAll();

                    $("#AuditTypeContainer").show();

                });

                $("#byAUDTSTS").bind('click', function () {
                    hideAll();

                    $("#AuditStatusContainer").show();

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

            //function hideAll() {

            //    $(".filter").each(function () {
            //        $(this).css('display', 'none');
            //    });

            //    reset();
            //}
            // Added by JP - Override the CSS Hover in contextmenu. 
            $("#filterList").hover(function () {
                $('#filterList').removeAttr('style');
            });

            // Added by JP - Hide the contextMenu after click
            function hideAll() {
                $(".filter").each(function () {
                    $(this).css('display', 'none');
                });
                $('#filterList').attr('style', 'display:none  !important');
                reset();
            }

    </script>

</asp:Content>
