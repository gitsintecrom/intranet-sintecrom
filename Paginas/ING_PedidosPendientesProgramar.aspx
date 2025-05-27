<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ING_PedidosPendientesProgramar.aspx.cs" Inherits="SintecromNet.Paginas.ING_PedidosPendientesProgramar" %>
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
    <h2>Pedidos Pendientes de Programar</h2>    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        
        
    
<%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>--%>
<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click"  ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
    
         <div style="overflow:auto; width:1020px; ">
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-striped table-bordered table-hover" 
            
                    
                    
                    EmptyDataText="La Consulta No ha Arrojado Resultados, verifique las Variables seleccionadas.">
        <Columns>
            <asp:BoundField HeaderText="Cliente" DataField="Cliente" >
           
            </asp:BoundField>
            <asp:BoundField DataField="NroPedido" HeaderText="Pedido" >
            
            </asp:BoundField>
            <asp:BoundField DataField="Item" HeaderText="Item">
            
            </asp:BoundField>
            <asp:BoundField DataField="Clon" HeaderText="Clon">
            
            </asp:BoundField>
            <asp:BoundField DataField="CodProducto" HeaderText="Producto" >          
           
            </asp:BoundField>
             <asp:BoundField DataField="DescProducto" HeaderText="Desc.Producto" >          
           
            </asp:BoundField>
            <asp:BoundField DataField="FechaSolicitada" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Solicitada" />

            <asp:BoundField DataField="fechaaceptada" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Aceptada" >
            
            </asp:BoundField>
            <%--<asp:BoundField DataField="FechaALTE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Ingreso Alte" />--%>
            
            <asp:BoundField DataField="cantidadoriginal" HeaderText="Cantidad Original" 
                DataFormatString="{0:0.00}" >
           
            </asp:BoundField>
            <asp:BoundField DataField="CantidadPendiente" DataFormatString="{0:0.00}" HeaderText="Cantidad Pendiente" />
            <asp:BoundField DataField="Motivo" HeaderText="Motivo" >
            
            </asp:BoundField>



            

        </Columns>
            <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>

             </div>
    <br />
   
   
   
   </div>
        </form>
   
</asp:Content>

