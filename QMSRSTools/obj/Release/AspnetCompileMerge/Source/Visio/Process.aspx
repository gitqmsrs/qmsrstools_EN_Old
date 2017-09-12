<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Process.aspx.cs" Inherits="QMSRSTools.Visio.Process" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
    <script type="text/javascript" src="../JS/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="../JS/general.js"></script>
   
   <script language="javascript" type="text/javascript">
       function setVisioDiagram(src)
       {
           var visio = new StringBuilder('');

           visio.append('<object classid="CLSID:279D6C9A-652E-4833-BEFC-312CA8887857" codebase="http://download.microsoft.com/download/4/5/2/452f8090-413f-408f-83c0-edd66db786ee/vviewer.exe" id="viewer1" width="100%" height="700">');
           visio.append('<param name="BackColor" value="16777215"/>');
           visio.append('<param name="AlertsEnabled" value="1"/>');
           visio.append('<param name="ContextMenuEnabled" value="1"/>');
           visio.append('<param name="GridVisible" value="0"/>');
           visio.append('<param name="HighQualityRender" value="1"/>');
           visio.append('<param name="PageColor" value="16777215"/>');
           visio.append('<param name="PageVisible" value="1"/>');
           visio.append('<param name="PropertyDialogEnabled" value="1"/>');
           visio.append('<param name="ScrollbarsVisible" value="0"/>');
           visio.append('<param name="ToolbarVisible" value="1"/>');
           visio.append('<param name="Src" value="' + src + '"/>');
           visio.append('<param name="CurrentPageIndex" value="0"/>');
           visio.append('<param name="Zoom" value="-1"/>');
           visio.append('</object>');

           $("#<%=form1.ClientID%>").html(visio.toString());
       }
   </script>
</head>
<body>
    <form id="form1" runat="server">
       
    </form>
</body>
</html>
