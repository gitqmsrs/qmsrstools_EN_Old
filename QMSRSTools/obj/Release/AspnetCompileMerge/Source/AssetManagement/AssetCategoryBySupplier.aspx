﻿<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage/Site2.Master" AutoEventWireup="true" Culture = "en-GB" CodeBehind="AssetCategoryBySupplier.aspx.cs" Inherits="QMSRSTools.AssetManagement.AssetCategoryBySupplier" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div class="toolbox">
        <div id="AssetSupplierContainer" class="filter" style=" float:left;width:270px; margin-left:10px; height:20px; margin-top:3px;">
            <div id="AssetSupplierLabel" style="width:100px;">Asset Supplier:</div>
            <div id="AssetSupplierField" style="width:150px; left:0; float:left;">
                <asp:DropDownList ID="ASSTSUPPFCBox" AutoPostBack="true" runat="server" Width="150px" CssClass="combobox" OnSelectedIndexChanged="ASSTSUPPFCBox_SelectedIndexChanged">
                </asp:DropDownList>
            </div>
        </div>
     </div>
     <div style="float:left; width:100%; height:500px; margin-top:15px;">
        <object id="flashchart" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" height="500px" width="100%">
        <param name="movie" value="../../Reports/Flash/fcp-bars.swf"/>
        <param name="bgcolor" value="#ffffff"/>
        <param name="quality" value="high"/>
        <param name="flashvars" value='xml_file=<%=Session["Guid"] %>'/>
        <embed bgcolor="#ffffff" flashvars='xml_file=<%=Session["Guid"] %>' height="500" name="flashchart" quality="high" src="../../Reports/Flash/fcp-bars.swf" type="application/x-shockwave-flash" width="900"></embed>
        <param name="wmode" value="opaque" /></object>
    </div>
</asp:Content>
