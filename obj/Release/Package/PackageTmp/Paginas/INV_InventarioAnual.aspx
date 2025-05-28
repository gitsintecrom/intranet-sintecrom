<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_InventarioAnual.aspx.cs" Inherits="SintecromNet.Paginas.INV_InventarioAnual" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Anular la Operación?')) return false;
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
    <h2>Estado Inicial Inventario Anual</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                <asp:Label ID="lblPedido2"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left" Text="Depósito:" Width="140px"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control"  Width="140px">
                    <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="ALTE">ALTE</asp:ListItem>
                    <asp:ListItem Value="Calidad">Calidad</asp:ListItem>
                    <asp:ListItem Value="Hojal Pack">Hojal Pack</asp:ListItem>
                    <asp:ListItem Value="Material en tránsito">Material en tránsito</asp:ListItem>
                    <asp:ListItem Value="Material Pintado">Material Pintado</asp:ListItem>
                    <asp:ListItem Value="Materiales a revisar">Materiales a revisar</asp:ListItem>                   
                    <asp:ListItem Value="Materiales con Matching_">Materiales con Matching</asp:ListItem>
                    <asp:ListItem Value="Materiales para desarrollo">Materiales para desarrollo</asp:ListItem>
                    <asp:ListItem Value="MP">MP</asp:ListItem>
                    <asp:ListItem Value="Plancha Tercera">Plancha Tercera</asp:ListItem>
                    <asp:ListItem Value="Pre-Cortes">Pre-Cortes</asp:ListItem>
                    <asp:ListItem Value="Producción_">Producción</asp:ListItem>
                    <asp:ListItem Value="Reserva">Reserva</asp:ListItem>
                    <asp:ListItem Value="Reventa">Reventa</asp:ListItem>
                    <asp:ListItem Value="Scrap productivo">Scrap productivo</asp:ListItem>
                    <asp:ListItem Value="Sobrante MP">Sobrante MP</asp:ListItem>
                    <asp:ListItem Value="Terceros MP">Terceros MP</asp:ListItem>
                    <asp:ListItem Value="Zstock_">Zstock</asp:ListItem>
                    <asp:ListItem Value="Todos">Todos</asp:ListItem>
                    <asp:ListItem>Oportunidades</asp:ListItem>
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Serie/Lote:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtBSerie" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
                <%--<br />  <br />--%>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />

            
          
                        </div>
                    </div>
             </div>
<span style ="float:left;"><asp:ImageButton ID="btnExcel" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" /></span>
         <h3>
        <span style="float:right;"><asp:Label ID="lblTotal" runat="server" CssClass="label label-warning" Visible="False" /></span>
        <span style="float:right;"><asp:Label ID="lblInfo" runat="server" Text="Total Kilos:" CssClass="label label-info" Visible="False" /></span>

    </h3>    
        <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="SL" HeaderText="Serie Lote" />
            <asp:BoundField DataField="CODPRODUCTO" HeaderText="Cod.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="DESPRODUCTO" HeaderText="Des.Producto" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
            <asp:BoundField DataField="Deposito" HeaderText="Deposito" >
           </asp:BoundField>
            <asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>
  
</div>
</form>
        </asp:Content>

