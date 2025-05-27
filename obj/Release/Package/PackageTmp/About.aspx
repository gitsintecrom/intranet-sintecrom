<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="SintecromNet.About" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Acerca de</h2>
    <p>
        Sitio desarrollado por el Departamento de Sistemas de Sintecrom.</p>
    <p>
        <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/Desarrollo.jpg" />
    </p>
</asp:Content>
