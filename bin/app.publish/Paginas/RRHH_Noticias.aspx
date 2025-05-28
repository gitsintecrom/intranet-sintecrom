<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RRHH_Noticias.aspx.cs" Inherits="SintecromNet.Paginas.RRHH_Noticias" %>
<!DOCTYPE html>
<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">--%>

<html xmlns="http://www.w3.org/1999/xhtml" >
<html lang="en" >
<%@ Import Namespace="System.Web.Optimization" %>

<head id="Head1" runat="server">
    <title>Sintecrom - Intranet</title>    
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Intranet de Sintecrom S.A.I.C" />
    <meta name="author" content="Jorge Navarro" />
     <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
 


    <%--<asp:ContentPlaceHolder ID="StyleSection" runat="server" />--%>

</head>
<body style="background-color: #CC3300" >
    <asp:Image ID="Image6" runat="server" ImageUrl="~/Images/logo.jpg" ImageAlign="Left" />   
    <form id="form1" runat="server" style="background-color: #808080" >
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
                 <asp:Label ID="Label5" CssClass="h2" runat="server"  Width="290px" Text="Noticias Sintecrom" ForeColor="white" style="text-align:center" BorderStyle="None" BackColor="#808080"></asp:Label>            
    
    <br />
    <div style="width: 605px; float: left; vertical-align: middle; text-align: center; margin-bottom: 0px;">
                  
        <asp:Panel ID="Panel1" runat="server"  BackColor="#EEEEEE" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="602px">
        <asp:Label ID="lblNoticias1" CssClass="form-control" runat="server" ForeColor="Black"  Width="590px" style="text-align:center" 
                    Text="" BorderStyle="None" BackColor="#EEEEEE"  Font-Names="Arial Rounded MT Bold" Font-Size="Large"></asp:Label>
            <br/>
            
            
           <asp:Image ID="Image1" runat="server" Height="250px" ImageAlign="Middle" ImageUrl="~/Images/inun.jpg" Width="300px" />
           <br/>
            <br/>
             </asp:Panel>
        <br/>
       <br/>
        <asp:Panel ID="Panel2" runat="server"  BackColor="#EEEEEE" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1200px">
        <asp:Label ID="lblNoticias2" CssClass="form-control" runat="server" ForeColor="Black"  Width="1100px" style="text-align:center" 
                    Text="" BorderStyle="None" BackColor="#EEEEEE"  Font-Names="Arial Rounded MT Bold" Font-Size="Large"></asp:Label>
            <br/>
           <asp:Image ID="Image2" runat="server" Height="650px" ImageAlign="Middle" ImageUrl="~/Images/inun.jpg" Width="1100px" />
           <br/>
            <br/>
             </asp:Panel>
                  
                 
    </div>
        <div style="width: 605px; float: right; vertical-align: middle; text-align: center; margin-bottom: 0px; height: 250px;">
            
        <asp:Panel ID="Panel3" runat="server"  BackColor="#EEEEEE" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="602px">
        <asp:Label ID="lblNoticias3" runat="server" Height="65px" Width="590px" style="text-align:center" Text="" Font-Names="Arial Rounded MT Bold" Font-Size="Large" BackColor="#EEEEEE"></asp:Label>
             <br/>
            <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/Alina.png"  Height="250px" Width="300px" />
            <br/>
            <br/>
        </asp:Panel>                   
        <br />
           
   <%--    <asp:Panel ID="Panel4" runat="server"  BackColor="#EEEEEE" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="602px">
        <asp:Label ID="lblNoticias4" runat="server" Height="65px" Width="590px" style="text-align:center" Text="" Font-Names="Arial Rounded MT Bold" Font-Size="Large" BackColor="#EEEEEE"></asp:Label>
             <br/>
            <asp:Image ID="Image4" runat="server" ImageUrl="~/Images/Alina.png"  Height="250px" Width="300px" />
            <br/>
           <br/>
        </asp:Panel> --%>
             <br/>
           <br/>
            <asp:HyperLink ID="HyperLink1"  runat="server" NavigateUrl="~/ContentPage.aspx">[Volver]</asp:HyperLink>   
          
    </div>
    <asp:Timer ID="Timer1" runat="server" Interval="200000" OnTick="Timer1_Tick">
        </asp:Timer>
    </form>

</body>
</html>

