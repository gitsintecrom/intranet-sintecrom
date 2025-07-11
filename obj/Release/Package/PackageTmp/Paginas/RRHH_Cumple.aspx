<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RRHH_Cumple.aspx.cs" Inherits="SintecromNet.Paginas.RRHH_Cumple" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
 
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




        .style19
        {
            width: 115px;
        }
        .style18
        {
            width: 314px;
        }
        


        .style24
        {
        width: 115px;
        height: 26px;
    }
        .style25
        {
            width: 314px;
            height: 26px;
        }
        </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Cumpleaños del Mes</h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
<table style="width:100%;">
        <tr>
            <td>
                <asp:GridView ID="gwLegajos" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos" Width="709px">
        <Columns>
            <asp:BoundField DataField="Empleado" HeaderText="Empleado">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="10pt" Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="Cumple" HeaderText="Cumpleaños" >
            <ItemStyle Width="50px" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            </td>
        </tr>
        </table>
    <br />
    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<br />


    <br />
         <br />
    <br />
    <br />
    

        
        </asp:Content>

