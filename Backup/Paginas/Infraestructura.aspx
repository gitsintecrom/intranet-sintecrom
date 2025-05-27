<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Infraestructura.aspx.cs" Inherits="SintecromNet.Paginas.Infraestructura" %>
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

        <h2>Infraestructura</h2>
        <p>
            <asp:Button ID="btnDescarga" runat="server" onclick="btnDescarga_Click"  
                Text="Descarga" />
            Presione el Botón &quot;Descarga&quot; y luego verificar descargas, ejecute el Archivo 
            denominado &quot;SERVIDORES.pdf&quot; </p>
        <p>
            <asp:Button ID="btnDescarga0" runat="server" onclick="btnDescarga0_Click"  
                Text="Descarga" />
            Presione el Botón &quot;Descarga&quot; y luego verificar descargas, ejecute el Archivo 
            denominado &quot;CAMBIAR SITIO WEB DE SINTECROM POR REDIRECCION.pdf&quot; </p>
        <p>
            <asp:Button ID="btnDescarga1" runat="server" onclick="btnDescarga1_Click"  
                Text="Descarga" />
            Presione el Botón &quot;Descarga&quot; y luego verificar descargas, ejecute el Archivo 
            denominado &quot;EQUIPO DE CONTINGENCIA SSERVER902 .pdf&quot; </p>
        <p>
            <asp:Button ID="btnDescarga2" runat="server" onclick="btnDescarga2_Click"  
                Text="Descarga" />
            Presione el Botón &quot;Descarga&quot; y luego verificar descargas, ejecute el Archivo 
            denominado &quot;Mail.pdf&quot; </p>
        <p>
            &nbsp;</p>
</asp:Content>
