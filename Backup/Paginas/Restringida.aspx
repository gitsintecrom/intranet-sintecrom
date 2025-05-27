<%@ Page Title="Enlace Restringido" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Restringida.aspx.cs" Inherits="SintecromNet.Restringida" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
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
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        No Autorizado</h2>
        <p>Usted No Está Autorizado a Ingresar al Enlace solicitado</p>
    <p>
        <asp:Image ID="Image3" runat="server" ImageUrl="~/Images/21105644.png" />
    </p>
    
</asp:Content>
