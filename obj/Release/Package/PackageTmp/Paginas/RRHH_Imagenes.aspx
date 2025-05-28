<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RRHH_Imagenes.aspx.cs" Inherits="SintecromNet.Paginas.RRHH_Imagenes" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:Image ID="Image1" runat="server"  Height="561px" Width="870px" />
    
    </div>
    <asp:Label ID="lblMensaje" runat="server" Font-Names="Courier New" 
        Font-Size="Medium" Visible="False"></asp:Label>
    </form>
</body>
</html>
