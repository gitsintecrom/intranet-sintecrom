<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_AutorizacionPedidosAdmin.aspx.cs" Inherits="SintecromNet.Paginas.VT_AutorizacionPedidosAdmin" %>
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
    <h2>Autorizaciones de Pedidos Administración</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
        
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="Pedido,ID,Flag_ID,OTE,IDPedido,VERIFICACION,Autorizacion_ID">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:BoundField DataField="Pedido" HeaderText="Pedido" >
            </asp:BoundField>
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
           
            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" >
           </asp:BoundField>
            <asp:BoundField DataField="FechaEntrega" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" />
            <asp:BoundField DataField="Total" DataFormatString="{0:n0}" HeaderText="Total" />
            <asp:BoundField DataField="Pago" HeaderText="Condición" />
            <asp:BoundField DataField="PagoPedido" HeaderText="Cond.Pedido" />
            <asp:BoundField DataField="Anticipo" HeaderText="Anticipo" />
            <asp:BoundField DataField="RespetaPrecio" HeaderText="Respeta Precio" />
            <asp:BoundField DataField="Transporte" HeaderText="Transporte" />
            <asp:ButtonField CommandName="Detalle"  
                ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="Detalle" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
            <asp:BoundField DataField="IDPedido" HeaderText="IDPedido" Visible="False" />
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="Flag_ID" HeaderText="FlagOrigen" Visible="False" />
            <asp:BoundField DataField="Verificacion" HeaderText="Verificacion" Visible="False" />
            <asp:BoundField DataField="Autorizacion_ID" HeaderText="Autorizacion_ID" Visible="False" />
        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="XX-Small" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White"  />
        </asp:GridView>
   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
    
                    <h2> Pedido Número: <asp:Label ID="lblDetalle1" runat="server" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" OnClick="LinkButton2_Click" ToolTip="Salir"></asp:LinkButton>
                       
                    </h2>
        
       <h3>
           Situación Crediticia
       </h3>
       <asp:Label ID="Label1" runat="server" ></asp:Label>
                     
                       
        <%--<li class="active"><a class="fa fa-sign-out fa-2x" style="color: #FFFFFF; background-color: #5698D1; text-align: right;"   href="..//default.aspx"></a></li>--%> 
                    
        <br />
        <div style="overflow:auto; width:960px; ">
        <asp:GridView ID="gwGrillaDetalle" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <%--<asp:BoundField DataField="Pedido_CodProducto" HeaderText="Producto" />--%>
            <asp:BoundField DataField="Codigo" HeaderText="Codigo" />
            <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" DataFormatString="{0:n0}" />
            <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unitario" DataFormatString="{0:0.000}" />
            <asp:BoundField DataField="Bonificacion" HeaderText="Bonificacion" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="FechaSolicitada" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Solicitada" />
        </Columns>
                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
                    <%--<RowStyle Font-Names="Arial" Font-Size="8px" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                    
                   
                    <FooterStyle BackColor="Black" ForeColor="White"  />
        </asp:GridView>
        </div>
                   <asp:Button ID="btnCerrar0" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnCerrar0_Click" Text="Autorizar" BorderStyle="None" />
    
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCerrar" runat="server" BackColor="Red" BorderStyle="None" CssClass="btn btn-success btn-circle" ForeColor="White" OnClick="btnCerrar_Click" Text="Rechazar" />
    
 </asp:Panel> 
  
</div>
</form>
        </asp:Content>

