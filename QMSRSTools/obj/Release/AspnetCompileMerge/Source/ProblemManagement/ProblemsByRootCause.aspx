﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" CodeBehind="ProblemsByRootCause.aspx.cs" Inherits="QMSRSTools.ProblemManagement.ProblemsByRootCause" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
 
</asp:Content>