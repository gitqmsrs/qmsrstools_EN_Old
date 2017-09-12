<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="AnnualReviewTasks.aspx.cs" Inherits="QMSRSTools.ManagementReviews.AnnualReviewTasks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   
    <div class="toolbox">

       <asp:HiddenField id="dropdownchange" runat="server" />
        <asp:HiddenField id="activedropdown" runat="server" />
       
          <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
            <div id="filter_div">
            <img id="filter" src="/Images/filter.png" alt=""/>
            <ul id="filterList" class="contextmenu">
                <li id="byYear">Filter by Year</li>
              
            </ul>
        </div>



        <div  id="YearfilterContainer"  class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px; display:none;">
            <div id="YearLabel"  style="width:100px;">Select Year</div>
            <div id="YearField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="YRCBox" AutoPostBack="true" runat="server" Width="150px" CssClass="combobox" OnSelectedIndexChanged="YRCBox_SelectedIndexChanged">
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

                                        if ("<%=IsPostBack%>" == "False" || $('#<%=dropdownchange.ClientID%>').val() == "changed" ||  $('#<%=dropdownchange.ClientID%>').val() == "reset") {
                                            // Call the JS Function Here
                                            $('[id*=lstFields]').multiselect('selectAll', false);
                                            $('[id*=lstFields]').multiselect('updateButtonText');

                                        }


                                    });
                                </script>
                                <asp:ListBox ID="lstFields" runat="server" SelectionMode="Multiple" >
                                       <asp:ListItem Text="Open" Value="Open" />
                                    <asp:ListItem Text="Closed" Value="Closed" />
                                </asp:ListBox>
                </div>
            </div>
               &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;" OnClick="Search_Click"  />

   </div> <!-- toolbox -->
     
   <asp:Button ID="alias" runat="server" style="display:none;" OnClick="alias_Click" />

    <div style="float:left; width:100%; height:500px; margin-top:15px;">         
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" width="100%" height="500">
            <param name="movie" value="//Reports/Flash/fcp-bars.swf" />
            <param name="bgcolor" value="#ffffff" />
            <param name="quality" value="high" />
            <param name="flashvars" value='xml_file=<%=Session["Guid"] %>' />
            <embed type="application/x-shockwave-flash" src="/Reports/Flash/fcp-bars.swf" width="900"
            height="500" name="flashchart" bgcolor="#ffffff" quality="high" flashvars='xml_file=<%=Session["Guid"] %>' />
        </object>
    </div>
     <script type="text/javascript" language="javascript">
         $(function () {
             $("#deletefilter").bind('click', function () {
                 $("#<%=alias.ClientID%>").trigger('click');
             });

             $("#byYear").bind('click', function () {
                 hideAll();

                 $("#YearfilterContainer").show();
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

     
    </script>
</asp:Content>
