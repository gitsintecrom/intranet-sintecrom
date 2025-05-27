<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="GestionCalidad.aspx.cs" Inherits="SintecromNet.Paginas.GestionCalidad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date(); a = s.createElement(o),
  m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-67198984-1', 'auto');
    ga('send', 'pageview');
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Gestión de Calidad</h2><br />
    <br />
    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Descarga " 
    Width="115px" />
&nbsp;Presione el Botón &quot;Descarga&quot; y luego verificar descargas, ejecute el Archivo 
    denominado &quot;GestionCalidad.exe&quot;<br />
    <br />
    <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/Calidad.jpg" />
    </asp:Content>
