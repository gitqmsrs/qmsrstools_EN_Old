<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Culture = "en-GB" Inherits="QMSRSTools.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />

    <link href="CSS/login.css" type="text/css" rel="stylesheet" />

    <script type="text/javascript" src="../JS/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="../JS/general.js"></script>
  
</head>
<body>
    <form id="form1" runat="server">
    <div class="headertop">
    <table id="Table_01" width="800" height="78" border="0" cellpadding="0" cellspacing="0" style="margin-top:2px;">
	    <tr>
		<td>
			<img src="../Images/Login_Logo_01.png" width="54" height="78" alt="" /></td>
		<td>
			<img src="../Images/Login_Logo_02.png" width="103" height="78" alt="" /></td>
		<td>
			<img src="../Images/Login_Logo_03.png" width="282" height="78" alt="" /></td>
		<td>
			<img src="../Images/Login_Logo_04.png" width="120" height="78" alt="" /></td>
		<td>
			<img src="../Images/Login_Logo_05.png" width="67" height="78" alt="" /></td>
		<td>
			<img src="../Images/Login_Logo_06.png" width="173" height="78" alt="" /></td>
		<td>
			<img src="../Images/Login_Logo_07.png" width="1" height="78" alt="" /></td>
	    </tr>
    </table>
    </div>
    <div class="container">
        <div id="logincontainer">
        
        <div style="float:left; width:100%; height:20px; margin-top:7px; margin-left:100px;">
            <p>Account Type:</p>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:20px; margin-left:100px;">
            <asp:DropDownList ID="USRTYPCBox" AutoPostBack="false" runat="server" CssClass="combobox">
            </asp:DropDownList>
        </div>
         <div style="float:right; width:100%; height:7px; margin-top:10px; margin-right:100px;">
            <asp:RequiredFieldValidator ID="USRTYPTxtVal" runat="server" Display="Dynamic" CssClass="validator" ControlToValidate="USRTYPCBox" ErrorMessage="Select account type"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="USRTYPVal" runat="server" ControlToValidate="USRTYPCBox" CssClass="validator"
            Display="Dynamic" ErrorMessage="Select account type" Operator="NotEqual" Style="position: static"
            ValueToCompare="-1"></asp:CompareValidator>
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:7px; margin-left:100px;">
            <p>User Name/Personnel ID:</p>
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:20px; margin-left:100px;">
            <asp:TextBox ID="loginusr" runat="server" CssClass="logintextbox"></asp:TextBox>
        </div>
        
        <div style="float:left; width:100%; height:7px; margin-top:10px; margin-left:100px;">
            <asp:RequiredFieldValidator ID="PERSNNLIDVal" runat="server" Display="Dynamic" ControlToValidate="loginusr" ErrorMessage="Enter the personnel ID!"></asp:RequiredFieldValidator>   
        </div>
        
        <div style="float:left; width:100%; height:20px; margin-top:7px; margin-left:100px;">
            <p>Password:</p>
        </div>
        <div style="float:left; width:100%; height:20px; margin-top:20px; margin-left:100px;">
            <asp:TextBox ID="loginpw" runat="server" TextMode="Password" CssClass="logintextbox"></asp:TextBox>
            &nbsp;&nbsp;
            <asp:ImageButton ID="Search" runat="server" ImageUrl="~/Images/find.png" CssClass="loginButton" OnClick="Search_Click"/> 
        </div>
        <div style="float:left; width:100%; height:7px; margin-top:10px; margin-left:100px;">
            <asp:RequiredFieldValidator ID="PWVal" runat="server" Display="Dynamic" ControlToValidate="loginpw" ErrorMessage="Enter the password!"></asp:RequiredFieldValidator>   
        </div>
        <div style="float:left; width:100%; height:10px; margin-top:20px; margin-left:100px;">
            <a id="forget" href="#" class="link">Forgot Your Credentials?</a>
        </div>
         <div style="float:left; width:100%; height:7px; margin-top:10px; margin-left:100px;">
            <asp:Label ID="Error" runat="server" style="width:70%; float:left; color:red;"></asp:Label>    
        </div>
        
    </div>
    </div>
    <div class="footer">© QMSrs, 2014, registered in England, the United Kingdom, No. 03836478.</div>
    </form>
</body>
</html>
