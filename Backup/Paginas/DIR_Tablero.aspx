<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DIR_Tablero.aspx.cs" Inherits="SintecromNet.Paginas.DIR_Tablero" %>
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

        <h2>Laminados</h2>
        <p>
            <asp:ImageButton ID="ImageButton1" runat="server" Height="140px" 
                ImageUrl="~/Images/Laminados.jpg" onclick="ImageButton1_Click" 
                style="text-align: left" Width="189px" />
        </p>
<p>
            &nbsp;</p>
<p>
            &nbsp;</p>
        <br />
        <br />
        <br />
        <br />
</asp:Content>
