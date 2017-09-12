<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="AssetCategoryByOwner.aspx.cs" Inherits="QMSRSTools.AssetManagement.AssetCategoryByOwner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
   <div class="toolbox" style="margin-top:0;">
     <div id="AssetOwnerContainer" class="filter" style=" display:block; width:auto !important;">
        <div id="AssetOwnerLabel" class="filterlabel" style="width:auto !important;">Asset Owner:</div>
        <div id="AssetOwnerField" class="filterfield"  style="width:auto !important;">
            <asp:DropDownList ID="ASSTOWNRCBox" AutoPostBack="true" runat="server" Width="140px" CssClass="comboboxfilter" OnSelectedIndexChanged="ASSTOWNRCBox_SelectedIndexChanged">
            </asp:DropDownList>
            <asp:HiddenField id="dropdownchange" runat="server" />
        </div>
     </div>
        <div id="Div1"  style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px;display:none;">
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

                                        if ("<%=IsPostBack%>" == "True" && $('#<%=dropdownchange.ClientID%>').val() == "changed") {
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
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-top:-4px;display:none; " OnClick="Search_Click"  />
    </div>
     <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500px" width="100%">
        <param name="movie" value="<%=GetSitePath() + "/Reports/Flash/fcp-bars.swf" %>"/>
        <param name="bgcolor" value="#ffffff"/>
        <param name="quality" value="high"/>
        <param name="flashvars" value='xml_file=<%=Session["Guid"] %>'/>
        <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500" name="flashchart" quality="high" src="<%=GetSitePath() + "/Reports/Flash/fcp-bars.swf" %>" type="application/x-shockwave-flash" width="900"></embed>
        <param name="wmode" value="opaque" /></object>
    </div>

     <script type="text/javascript" language="javascript">
         $(document).ready(function () {
         
             if ($('#<%=dropdownchange.ClientID%>').val() == "changed" || $('#<%=dropdownchange.ClientID%>').val() == "CLICK") {
                 $('#<%=Search.ClientID%>').show();
                 $('#Div1').show();
             }



         });

        
       //  $('.AssetOwnerContainer').css('width', '');


     </script>


</asp:Content>


