<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="SintecromNet._Default" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %> 

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Bienvenido</h2>
    <p>
        <asp:Image ID="imgAdvertencia" runat="server" Height="33px" 
            ImageUrl="~/Images/Advertencia.jpg" Visible="False" Width="50px" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" Font-Size="Medium" ForeColor="Red" 
            Text="Usted Tiene Requerimientos de Servicios Pendientes. Por Favor Verifique."></asp:Label>
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Image ID="Image3" runat="server" Height="146px" 
            ImageUrl="~/Images/piefoto.jpg" style="text-align: center; margin-top: 0px" 
            Width="914px" />
    </p>
    <p>
        &nbsp;</p>
</asp:Content>
