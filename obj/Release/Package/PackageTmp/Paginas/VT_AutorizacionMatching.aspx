<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_AutorizacionMatching.aspx.cs" Inherits="SintecromNet.Paginas.VT_AutorizacionMatching" %>
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
    <h2>Autorizaciones de Matching</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
        
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="nromatching,Matching_ID,FlagOrigen,MotivoBloqueo">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:BoundField DataField="nromatching" HeaderText="Numero" >
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" />
           
            <asp:BoundField DataField="TipoMatching" HeaderText="Tipo" >
           </asp:BoundField>
            <asp:BoundField DataField="CodigoMP" HeaderText="MP" />
            <asp:BoundField DataField="Ancho" DataFormatString="{0:n0}" HeaderText="Ancho" />
              <asp:BoundField DataField="ClientePedido" HeaderText="Clientes" >
           </asp:BoundField>
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" />
            <asp:ButtonField CommandName="Detalle"  
                ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="Detalle" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
            <asp:BoundField DataField="Matching_ID" HeaderText="Matching_ID" Visible="False" />
            <asp:BoundField DataField="FlagOrigen" HeaderText="FlagOrigen" Visible="False" />
            <asp:BoundField DataField="motivobloqueo" HeaderText="motivobloqueo" Visible="False" />
        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White"  />
        </asp:GridView>
   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
    
                    <h2> Matching Número: <asp:Label ID="lblDetalle1" runat="server" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" OnClick="LinkButton2_Click" ToolTip="Salir"></asp:LinkButton>
                    </h2>
                     
                       
        <%--<li class="active"><a class="fa fa-sign-out fa-2x" style="color: #FFFFFF; background-color: #5698D1; text-align: right;"   href="..//default.aspx"></a></li>--%> 
                    
        <br />
       <asp:Label ID="Label1" runat="server" ></asp:Label>
        <div style="overflow:auto; width:960px; ">
        <asp:GridView ID="gwGrillaDetalle" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <%--<asp:BoundField DataField="Pedido_CodProducto" HeaderText="Producto" />--%>
            <asp:BoundField DataField="kilosaproduccion" DataFormatString="{0:n0}" HeaderText="Kilos" />
            <asp:BoundField DataField="Cabezal_Flejes" HeaderText="Flejes" />
            <asp:BoundField DataField="PesoRolloPaquete" HeaderText="Peso Rollo/Paquete" />
            <asp:BoundField DataField="AnchoTotal" DataFormatString="{0:0.00}" HeaderText="Ancho Total" />
            <asp:BoundField DataField="Pasadas" HeaderText="Pasadas" />
            <asp:BoundField DataField="Corona" DataFormatString="{0:0.00}" HeaderText="Corona" />
            <asp:BoundField DataField="DiametroExterno" DataFormatString="{0:0.00}" HeaderText="Diametro Externo" />
            <asp:BoundField DataField="Pedido_Cantidad" HeaderText="Cant.Ped." />
            <asp:BoundField DataField="Pedido_CodProducto" HeaderText="Prod.Pedido" />
            <asp:BoundField DataField="FTF_DiamExternoMin" DataFormatString="{0:0.00}" HeaderText="FT D.Ext.Min" />
            <asp:BoundField DataField="FTF_DiamExternoMax" DataFormatString="{0:0.00}" HeaderText="FT D.Ext.Max" />
            <asp:BoundField DataField="FTF_KilosMaximo" DataFormatString="{0:0.00}" HeaderText="FT KilosMaximo" />
            <asp:BoundField DataField="FTF_KilosMinimo" DataFormatString="{0:0.00}" HeaderText="FT KilosMinimo" />
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

