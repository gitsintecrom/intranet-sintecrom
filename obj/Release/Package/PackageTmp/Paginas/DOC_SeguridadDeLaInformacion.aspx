<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DOC_SeguridadDeLaInformacion.aspx.cs" Inherits="SintecromNet.Paginas.DOC_SeguridadDeLaInformacion" %>
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
    <h2>Seguridad De La Información</h2>
    <p>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
            Text="Descarga" />
&nbsp;Presione el Botón &quot;Descarga&quot; y luego verificar descargas, ejecute el Archivo 
        denominado &quot;Capacitación ISO 9001.pdf&quot;</p>
    <p>
        <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/seguridad.jpg" />
    </p></asp:Content>
