<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROG_ReservaMP.aspx.cs" Inherits="SintecromNet.Paginas.PROG_ReservaMP" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de de Habilitar todos los Items?')) return false;
    }
    function estaseguro1() {

        if (!confirm('Esta Seguro de Deshabilitar todos los Items?')) return false;
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
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <h2>Reservas Materias Primas</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
        

       
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="LOTE_ID,SERIE_ID,PRODUCTO_ID,DEPOSITOORI,Cliente,Lote,Kilos">
        <Columns>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha Reserva" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="FechaHasta" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Reservado Hasta" />

            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
            </asp:BoundField>
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:n0}" />
           
            <asp:BoundField DataField="Lote" HeaderText="Serie Lote" />
           
            <asp:BoundField DataField="CodigoProducto" HeaderText="Producto" />
           
            <asp:BoundField DataField="Producto" HeaderText="Descripcion"  >
           </asp:BoundField>
            
            <asp:BoundField DataField="LOTE_ID" HeaderText="Lote_ID" Visible="False" />
            <asp:BoundField DataField="SERIE_ID" HeaderText="SERIE_ID" Visible="False" />
            <asp:BoundField DataField="PRODUCTO_ID" HeaderText="PRODUCTO_ID" Visible="False" />

        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Small" />
                    
                    
        </asp:GridView>
        
        

        
  
</div>
</form>
        </asp:Content>

