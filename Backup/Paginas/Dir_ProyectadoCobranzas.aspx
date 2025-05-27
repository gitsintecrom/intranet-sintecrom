<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dir_ProyectadoCobranzas.aspx.cs" Inherits="SintecromNet.Paginas.Dir_ProyectadoCobranzas" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Guardar la Modificación?')) return false;
    }
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date(); a = s.createElement(o),
  m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-67198984-1', 'auto');
    ga('send', 'pageview');
</script>
    <style type="text/css">
        .style1
        {
            height: 23px;
        }
    </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Proyectado Cobranzas</h2>
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT * FROM [Totales_Cobranzas]"></asp:SqlDataSource>
   
    <br />
    <table border="1" style="width:100%;">
        <tr>
            <td width="50%">
   
    <asp:Label ID="lblTextoMes" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Total Acumulado Mes en Curso" Font-Names="Arial"></asp:Label>
                :</td>
            <td width="50%">
    <asp:Label ID="lblAcumuladoMes" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="#336699" Text="Label" Font-Names="Arial"></asp:Label>
   
            </td>
        </tr>
        <tr>
            <td class="style1" width="50%">
   
    <asp:Label ID="lblTextoMes0" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Días Hábiles Transcurridos" Font-Names="Arial"></asp:Label>
            </td>
            <td class="style1" width="50%">
    <asp:Label ID="lblDiasT" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="#336699" Text="Label" Font-Names="Arial"></asp:Label>
   
            </td>
        </tr>
        <tr>
            <td width="50%">
   
    <asp:Label ID="label22" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Días Habiles Restantes:" Font-Names="Arial"></asp:Label>
            </td>
            <td width="50%">
    <asp:Label ID="lblDiasP" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="#336699" Text="Label" Font-Names="Arial"></asp:Label>
   
            </td>
        </tr>
        <tr>
            <td width="50%">
   
    <asp:Label ID="lblTextoMes1" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Total Proyectado Mes en Curso" Font-Names="Arial"></asp:Label>
            </td>
            <td width="50%">
    <asp:Label ID="lblProyectado" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="#336699" Text="Label" Font-Names="Arial"></asp:Label>
   
            </td>
        </tr>
    </table>
    <br />
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
    &nbsp;<br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <p>
        &nbsp;</p>
    <p>
         &nbsp;</asp:Content>

