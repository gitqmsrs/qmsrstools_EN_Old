<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="CCNStatusMetrics.aspx.cs" Inherits="QMSRSTools.ChangeControl.CCNStatusMetrics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox">
        <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt="" />
        <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byMonth">Filter by Origination Date</li>
            </ul>
        </div>
  
     <asp:HiddenField id="dropdownchange" runat="server" />
        <asp:HiddenField id="activedropdown" runat="server" />
    <div id="MonthContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="MonthLabel" class="filterlabel" style="width:100px;">Month:</div>
        <div id="MonthField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="MNTHCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="MNTHCBox_SelectedIndexChanged">
            </asp:DropDownList>
        </div>
    </div>

    <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />
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
                                  
                                </asp:ListBox>
                </div>
            </div>
               &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />

          </div> <!-- toolbox-->
    <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500px" width="100%">
        <param name="movie" value="/Reports/Flash/fcp-bars.swf"/>
        <param name="bgcolor" value="#ffffff"/>
        <param name="quality" value="high"/>
        <param name="flashvars" value='xml_file=<%=Session["Guid"] %>'/>
        <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500" name="flashchart" quality="high" src="/Reports/Flash/fcp-bars.swf" type="application/x-shockwave-flash" width="900"></embed>
        <param name="wmode" value="opaque" /></object>
     </div>
</div>

<script type="text/javascript" language="javascript">
    $(function () {
        $("#deletefilter").bind('click', function ()
        {
            hideAll();

            $("#<%=alias.ClientID%>").trigger('click');
        });

        $("#byMonth").bind('click', function () {
            hideAll();
            $("#MonthContainer").show();
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
