<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Customer_Order_Handling.aspx.cs" Inherits="QMSRSTools.VisioLinks.Customer_Order_Handling" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Untitled Page</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <object classid="CLSID:279D6C9A-652E-4833-BEFC-312CA8887857" 
        codebase="http://download.microsoft.com/download/4/5/2/452f8090-413f-408f-83c0-edd66db786ee/vviewer.exe" 
        id="viewer1" width="100%" height="700"> 
        <param name="BackColor" value="16777215"/>
        <param name="AlertsEnabled" value="1"/>
        <param name="ContextMenuEnabled" value="1"/>
        <param name="GridVisible" value="0"/>
        <param name="HighQualityRender" value="1"/>
        <param name="PageColor" value="16777215"/>
        <param name="PageVisible" value="1"/>
        <param name="PropertyDialogEnabled" value="1"/>
        <param name="ScrollbarsVisible" value="0"/>
        <param name="ToolbarVisible" value="1"/>
        <%--<param name="SRC" value="../VisioDiagrams/Customer_Order_Handling.vsd"/>--%>
        <param name="SRC" value="../VisioDiagrams/QMSrs-P-E-Ord Handling.vsd"/>
        <param name="CurrentPageIndex" value="0"/>
        <param name="Zoom" value="-1"/>
        </object>
    </div>
    </form>
</body>
</html>