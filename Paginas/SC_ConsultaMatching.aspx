<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SC_ConsultaMatching.aspx.cs" Inherits="SintecromNet.Paginas.SC_ConsultaMatching" %>
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
    <h2>Consulta de Matching</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                &nbsp;&nbsp;
                    <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Número Matching:" Width="170px"></asp:Label>
                    <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control"  Width="170px" TextMode="Number">0</asp:TextBox>
                
                               
           &nbsp;&nbsp;&nbsp;&nbsp;
               
            <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />--%>
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span>&nbsp;Buscar</asp:LinkButton>
            
          
                        </div>
                    </div>
             </div>

        <br />
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="nromatching">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:BoundField DataField="nromatching" HeaderText="Numero" >
            </asp:BoundField>
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="Familia" HeaderText="Familia" />
           
            <asp:BoundField DataField="TipoMatching" HeaderText="Tipo" >
           </asp:BoundField>
            <asp:BoundField DataField="Ancho" DataFormatString="{0:n0}" HeaderText="Ancho" />
              <asp:BoundField DataField="ClientePedido" HeaderText="Clientes" >
           </asp:BoundField>
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" />
            <asp:ButtonField CommandName="Detalle"  
                ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="Detalle" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White"  />
        </asp:GridView>
   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
    
                    <h2> Matching Número: <asp:Label ID="lblDetalle1" runat="server" ></asp:Label></h2>
        <br />

        <asp:GridView ID="gwGrillaDetalle" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="kilosaproduccion" HeaderText="Kilos" DataFormatString="{0:n0}" >
            </asp:BoundField>
            <asp:BoundField DataField="Cabezal_Flejes" HeaderText="Flejes" />
           
            <asp:BoundField DataField="PesoRolloPaquete" HeaderText="Peso Rollo/Paquete" >
           </asp:BoundField>
            <asp:BoundField DataField="AnchoTotal" DataFormatString="{0:0.00}" HeaderText="Ancho Total" />
            <asp:BoundField DataField="Pasadas" HeaderText="Pasadas" />
           
            <asp:BoundField DataField="Corona" DataFormatString="{0:0.00}" HeaderText="Corona" />
            <asp:BoundField DataField="DiametroExterno" DataFormatString="{0:0.00}" HeaderText="Diametro Externo" />
              <asp:BoundField DataField="Pedido_Cantidad" HeaderText="Cantidad" />
              <asp:BoundField DataField="Pedido_Cliente" HeaderText="Cliente" >
           </asp:BoundField>
            <asp:BoundField DataField="Pedido_CodProducto" HeaderText="Producto" />
        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White"  />
        </asp:GridView>
                   <asp:Button ID="btnCerrar" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="btnCerrar_Click" Text="Cerrar" BorderStyle="None" />
    
 </asp:Panel> 
  
</div>
</form>
        </asp:Content>

