<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="AttendanceList.aspx.cs" Inherits="QMSRSTools.EmployeeTraining.AttendanceList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div class="toolbox">
         <img id="deletefilter" src="/Images/filter-delete-icon.png" class="imgButton" alt=""/>
    
       

    <div id="CourseTitleContainer" class="filter" style ="margin-left: 10px; height: 20px; width: 400px; float: left; padding-top: 7px;display:block;margin-top:0px;">
        <div id="CourseTitleFLabel" class="filterlabel" style="width:80px;">Course Title:</div>
        <div id="CourseTitleFField" class="filterfield">
            <asp:TextBox ID="CTTLTxt" runat="server" CssClass="filtertext" Width="300px"></asp:TextBox>
        </div>

        

    </div> <!-- CourseTitleContainer-->
      

        <div id="Div1"  style=" float:left;width:200px; margin-left:10px; height:20px; margin-top:3px;">
                <div id="Div2" style="width:80px;">Display Fields:</div>
                <div id="Div3" style="width:100px !important; left:0; float:left;" class="mid-width">
                                 <link href="../CSS/bootstrap.css" type="text/css" rel="Stylesheet" />
                                  <script type="text/javascript" src="../JS/bootstrap.js"></script>
                                 <link href="../CSS/bootstrap-multiselect.css" type="text/css" rel="Stylesheet" />
                                  <script type="text/javascript" src="../JS/bootstrap-multiselect.js"></script>

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

                                        if ("<%=IsPostBack%>" == "False") {
                                            // Call the JS Function Here
                                            $('[id*=lstFields]').multiselect('selectAll', false);
                                            $('[id*=lstFields]').multiselect('updateButtonText');

                                        }


                                    });
                                </script>
                                <asp:ListBox ID="lstFields" runat="server" SelectionMode="Multiple" >
                                   
                                    <asp:ListItem Text="Employee Name" Value="EmployeeName" />
                                    <asp:ListItem Text="Position" Value="Position" />
                                    <asp:ListItem Text="Department" Value="Department" />
                                    <asp:ListItem Text="Level" Value="Level" />
                                       <asp:ListItem Text="Attendance" Value="Attendance" />
                                      

                                </asp:ListBox>
                </div>
            </div>

            &nbsp;&nbsp;


    <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="imgButton" style="margin-left:5px;" OnClick="Search_Click"  />
    </div> <!-- toolbox -->
       
    <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="99%" SizeToReportContent="True">
    </rsweb:ReportViewer>

</div>   
<script type="text/javascript" language="javascript">
    $(function ()
    {
        $("#deletefilter").bind('click', function ()
        {
            reset();
            $("#<%=Search.ClientID%>").trigger('click');
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

    </script>
</asp:Content>
