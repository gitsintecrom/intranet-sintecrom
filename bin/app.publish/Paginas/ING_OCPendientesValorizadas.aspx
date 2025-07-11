<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ING_OCPendientesValorizadas.aspx.cs" Inherits="SintecromNet.Paginas.ING_OCPendientesValorizadas" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Guardar la Modificación?')) return false;
    }
    function alerta(texto) {
        alert(texto);
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
    <form id="form1" runat="server">
    <div class="jumbotron">
    <h2>Ordenes de Compra Pendientes Valorizadas</h2>    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        
        
    
<%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>--%>
<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click"  ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
    
         <div style="overflow:auto; width:1020px; ">
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-striped table-bordered table-hover" 
            
                    
                    
                    EmptyDataText="La Consulta No ha Arrojado Resultados, verifique las Variables seleccionadas.">
        <Columns>
            <%--<asp:BoundField DataField="FechaALTE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Ingreso Alte" />--%>
            
            <asp:BoundField DataField="NumeroOC" HeaderText="Numero" >
            
            </asp:BoundField>
             <asp:BoundField DataField="Item" HeaderText="Item" >
            
            </asp:BoundField>
            <asp:BoundField DataField="DescripcionProducto" HeaderText="Desc.Producto">
            
            </asp:BoundField>
            <asp:BoundField DataField="CantidadPendiente" DataFormatString="{0:0.00}" HeaderText="Cantidad Pendiente" />
            <asp:BoundField DataField="cantidadoriginal" HeaderText="Cantidad Original" DataFormatString="{0:0.00}" >
            
            </asp:BoundField>



            

            <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" >          
           
            </asp:BoundField>
             <asp:BoundField DataField="FechaProximaEntrega" HeaderText="Proxima Entrega" DataFormatString="{0:dd/MM/yyyy}" >          
           
            </asp:BoundField>
            <asp:BoundField HeaderText="Tipo" DataField="Tipo" >
           
            </asp:BoundField>
            <asp:BoundField DataField="NombreMoneda" HeaderText="Moneda" />
            <asp:BoundField DataField="Cotizacion" DataFormatString="{0:0.00}" HeaderText="Cotizacion" />
            <asp:BoundField DataField="Valor" DataFormatString="{0:0.00}" HeaderText="Valor" />
            <asp:BoundField DataField="totalimporte" DataFormatString="{0:0.00}" HeaderText="Total" />



            

        </Columns>
            <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>

             </div>
    <br />
   
   
   
   </div>
        </form>
   
</asp:Content>

