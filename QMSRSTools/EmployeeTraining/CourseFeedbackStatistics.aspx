<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" CodeBehind="CourseFeedbackStatistics.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.CourseFeedbackStatistics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

   

     <div class="toolbox" style="margin-top:0;">
      <asp:HiddenField id="dropdownchange" runat="server" />
        <asp:HiddenField id="activedropdown" runat="server" />
          <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
 <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byCourse">Filter by Course</li>
              
            </ul>
        </div>

    <div id="CourseNameContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
        <div id="CourseNameLabel" class="filterlabel" style="width:100px;">Course Number:</div>
        <div id="CourseNameField" class="filterfield" style="width:150px; left:0; float:left;">
            <asp:DropDownList ID="CRSNMCBox" AutoPostBack="true" runat="server" Width="200px" CssClass="comboboxfilter" OnSelectedIndexChanged="CRSNMCBox_SelectedIndexChanged">
            </asp:DropDownList>

        </div> 
    </div>
        <asp:ImageButton ID="Reset" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px; display:none;" OnClick="Reset_Click"  />

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

                                        if ("<%=IsPostBack%>" == "False" || $('#<%=dropdownchange.ClientID%>').val() == "changed") {
                                            // Call the JS Function Here
                                            $('[id*=lstFields]').multiselect('selectAll', false);
                                            $('[id*=lstFields]').multiselect('updateButtonText');

                                        }


                                    });
                                </script>
                                <asp:ListBox ID="lstFields" runat="server" SelectionMode="Multiple" >
                                       <asp:ListItem Text="Provided Feedback" Value="Provided Feedback" />
                                    <asp:ListItem Text="Didn't Provided Feedback" Value="Didn't Provided Feedback" />
                                   
                                </asp:ListBox>
                </div>
            </div>
               &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />

    </div> <!--toolbox -->
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

            $("#byCourse").bind('click', function () {
                    hideAll();

                    $("#CourseNameContainer").show();
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
 