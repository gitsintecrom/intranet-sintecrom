<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DOC_Funcional.aspx.cs" Inherits="SintecromNet.Paginas.DOC_Funcional" %>
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

        <h2>Documentacion Funcional</h2>
        <ul>
            <li><a href="DOC_AperturaEjercicio.aspx">Apertura Nuevo Ejercicio Contable</a></li>
            <li><a href="DOC_TrackingDePedido.aspx">Tracking De Pedido</a></li>
</ul>
        <p>
            &nbsp;</p>
</asp:Content>
