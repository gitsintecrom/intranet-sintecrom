<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SC_PendientesDePesada.aspx.cs" Inherits="SintecromNet.Paginas.SC_PendientesDePesada" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
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
    <h2>Pendientes de Ingreso ALTE</h2>
            
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle</h4></div>
                <div class="panel-body">                
                    <div class="input-group">

<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" ToolTip="Exportar a Excel"></asp:LinkButton>
            <br />
                <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="NumeroPedido" HeaderText="Pedido" />
            <asp:BoundField DataField="Item" HeaderText="Item" />
            <asp:BoundField DataField="Clon" HeaderText="Clon" />
            <asp:BoundField DataField="NroBatch" HeaderText="Nro.Batch" />
            <asp:BoundField DataField="Atados" HeaderText="Atados" />
            <asp:BoundField DataField="Rollos" HeaderText="Rollos" />
            <asp:BoundField DataField="Kilos_SobreOrden" HeaderText="SobreOrden" />
<asp:BoundField DataField="Kilos_Bruto" HeaderText="Kgs.Brutos ">
</asp:BoundField>
            <asp:BoundField DataField="Operacion_Fecha_Temprana" HeaderText="Fecha Temprana" DataFormatString="{0:dd/MM/yyyy}" >
            </asp:BoundField>
            <asp:BoundField HeaderText="Serie/Lote" DataField="LotePlanchaDesc" Visible="False" >
            </asp:BoundField>
            <asp:BoundField DataField="ClientePedido" HeaderText="Clientes Pedido" />
        </Columns>       
</asp:GridView>
                    </div>
           
                </div>
        </div>

   
        </div>
         </form>
        </asp:Content>

