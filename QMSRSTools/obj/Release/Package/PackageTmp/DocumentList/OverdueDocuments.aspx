﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" Culture = "en-GB" AutoEventWireup="true" CodeBehind="OverdueDocuments.aspx.cs" Inherits="QMSRSTools.DocumentList.OverdueDocuments" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div id="wrapper" class="modulewrapper">
    <div>
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500" width="85%" style="margin-top:15px; margin-left:auto; margin-right:auto; position:relative; float:left;">
        <param name="movie" value="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-bars.swf"/>
        <param name="bgcolor" value="#ffffff" />
        <param name="quality" value="high" />
        <param name="flashvars" value='xml_file=<%=Session["Guid"] %>'/>
        <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500" name="flashchart" quality="high" src="http://www.qmsrs.com/qmsrstools/Reports/Flash/fcp-bars.swf" type="application/x-shockwave-flash" width="900"></embed>
        <param name="wmode" value="opaque" /></object>
    </div>
</div>
</asp:Content>
