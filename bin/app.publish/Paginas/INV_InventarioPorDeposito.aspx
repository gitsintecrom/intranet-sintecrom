<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_InventarioPorDeposito.aspx.cs" Inherits="SintecromNet.Paginas.INV_InventarioPorDeposito" %>
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
    <h2>Inventario</h2>
    
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
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Serie/Lote:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtBSerie" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
                <br />  <br />
                <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Cod.Producto:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtProducto" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
                 &nbsp;&nbsp;<asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Des.Producto:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtDesProducto" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
               
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />

            
          
                        </div>
                    </div>
             </div>
        <asp:Panel ID="Panel1" runat="server">
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
                    onrowdatabound="gwGrilla_RowDataBound1" ShowFooter="True" DataKeyNames="Serie_ID,SL,CODPRODUCTO" OnRowCommand="gwGrilla_RowCommand1">
        <Columns>
            <asp:BoundField DataField="SL" HeaderText="Serie Lote" />
            <asp:BoundField DataField="CODPRODUCTO" HeaderText="Cod.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="DESPRODUCTO" HeaderText="Des.Producto" />
            <asp:BoundField DataField="Origen" HeaderText="Origen" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
            <asp:BoundField DataField="Deposito" HeaderText="Deposito" >
           </asp:BoundField>
            <asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}" />
            <asp:ButtonField CommandName="Ver"  
                ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="Ver" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
            <asp:BoundField DataField="Serie_ID" HeaderText="Serie_ID" Visible="False" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>
            </asp:Panel>

        
            
         <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">

              <h3> Serie Lote: <asp:Label ID="lblDetalle1" runat="server" Font-Bold="True" ForeColor="#990000" ></asp:Label>&nbsp;&nbsp;
                        Producto: <asp:Label ID="lblDetalle2" runat="server" Font-Bold="True" ForeColor="#990000" ></asp:Label>&nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" OnClick="LinkButton2_Click" ToolTip="Salir"></asp:LinkButton>
                       
                    </h3>
      
        <asp:GridView ID="gwDetalle" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="Transaccion" HeaderText="Transacción" />
            <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" >
            </asp:BoundField>
            <asp:BoundField DataField="NumeroExterno" HeaderText="Número Externo" />
            
             </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>

            </asp:Panel>
</div>
</form>
        </asp:Content>

