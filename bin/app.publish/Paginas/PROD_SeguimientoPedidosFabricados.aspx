<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_SeguimientoPedidosFabricados.aspx.cs" Inherits="SintecromNet.Paginas.PROD_SeguimientoPedidosFabricados" %>
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
    <h2>Seguimiento de Pedidos Fecha Aceptada contra Fecha Entregada</h2>    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="labelRes0" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Fecha Desde:" Width="150px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBoxIni" runat="server" Width="150px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                 &nbsp;<asp:Label ID="labelRes1" runat="server" style="text-align: left" Text="Fecha Hasta:" Width="150px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>

                        <asp:TextBox ID="TextBoxFin" runat="server" TabIndex="10" Width="150px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                       
                <asp:Label ID="Label2" runat="server" CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Cliente:" Width="150px"></asp:Label>
                <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Width="150px"></asp:TextBox>
                &nbsp; 
                         <br /><br />
                         <asp:Label ID="lblPedido" runat="server" CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Pedido:" Width="150px"></asp:Label>
                        <asp:TextBox ID="txtNumeroPedido" runat="server" CssClass="form-control" Width="150px"></asp:TextBox>                
                        &nbsp; &nbsp;<asp:Label ID="lblPedido1" runat="server" style="text-align: left" Text="Demora:" Width="150px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="150px" CssClass="form-control">
                    <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="Demora">Demora</asp:ListItem>
                    <asp:ListItem Value="Todos">Todos</asp:ListItem>
                </asp:DropDownList>

                       <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Familia:" Width="150px"></asp:Label>
                    <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="150px">
                        </asp:DropDownList>

                        <br /><br /> 
                        
                <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" />

                        </div>
                    </div>
            </div>
        
    
<%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>--%>
<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
    
         <div style="overflow:auto; width:1020px; ">
        <asp:GridView ID="gwNoCumplidos" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-striped table-bordered table-hover" 
            
                    
                    
                    EmptyDataText="La Consulta No ha Arrojado Resultados, verifique las Variables seleccionadas." 
                    onrowdatabound="gwNoCumplidos_RowDataBound" onrowcommand="gwNoCumplidos_RowCommand" 
                    onselectedindexchanged="gwNoCumplidos_SelectedIndexChanged">
        <Columns>
            <asp:BoundField HeaderText="Cliente" DataField="RazonSocial" >
           
            </asp:BoundField>
            <asp:BoundField DataField="NumeroPedido" HeaderText="Pedido" >
            
            </asp:BoundField>
            <asp:BoundField DataField="NROITEM" HeaderText="Item">
            
            </asp:BoundField>
            <asp:BoundField DataField="NClonado" HeaderText="Clon">
            
            </asp:BoundField>
            <asp:BoundField DataField="Producto" HeaderText="Descripción Producto" >
            
            </asp:BoundField>
            <asp:BoundField DataField="Transporte" HeaderText="Medio Transporte" />
            <asp:BoundField DataField="fechasolicitada" HeaderText="F.Solicitada" >
           
            </asp:BoundField>
            <asp:BoundField DataField="fechaaceptada" HeaderText="F.Aceptada" >
            
            </asp:BoundField>
            <asp:BoundField DataField="FechaALTE" DataFormatString="{0:dd/MM/yyyy}" HeaderText="F.Ing.Alte" />
            <asp:BoundField DataField="DiferenciaALTE" HeaderText="Diferencia Alte" />
            <asp:BoundField DataField="FECHAENTREGA" HeaderText="F.Entrega">
            
            </asp:BoundField>
            <asp:BoundField DataField="DiferenciaEntrega" HeaderText="Diferencia Entrega" />
            <asp:BoundField DataField="cantidadpedido" HeaderText="Cantidad Original" 
                DataFormatString="{0:0.00}" >
           
            </asp:BoundField>
            <asp:BoundField DataField="Cancelado" DataFormatString="{0:0.00}" HeaderText="Cancelado" />

            <asp:BoundField DataField="Entregado" DataFormatString="{0:0.00}" HeaderText="Entregado" />

            <asp:BoundField DataField="FechAutoPedi" DataFormatString="{0:dd/MM/yyyy}" HeaderText="F.Aut.Pedido" />
            <asp:BoundField DataField="FechMatching" DataFormatString="{0:dd/MM/yyyy}" HeaderText="F.Matching" />
            <asp:BoundField DataField="FechAutMatch" DataFormatString="{0:dd/MM/yyyy}" HeaderText="F.Aut.Matching" />
            <asp:BoundField DataField="Motivo" HeaderText="Motivo" />
            <asp:BoundField DataField="Cumplido" HeaderText="Cumplido" />

        </Columns>
            <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>

             </div>
    <br />
   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label1" runat="server" Text="Pedido:"></asp:Label>
            <asp:Label ID="lblNroPedido" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label3" runat="server" Text="Item:"></asp:Label>
            <asp:Label ID="lblItem" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label5" runat="server" Text="Clon:"></asp:Label>
            <asp:Label ID="lblClon" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label7" runat="server" Text="Programado:"></asp:Label>
            <asp:Label ID="lblProgramado" runat="server" Font-Bold="True"></asp:Label>
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="gwGrilla" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center">
       
                
                <Columns>
                    <asp:BoundField DataField="Operacion" HeaderText="Operacion" />
                    <asp:BoundField DataField="Tarea" HeaderText="Tarea Pendiente" >
                    </asp:BoundField>
                    <asp:BoundField DataField="KilosProgramadosEntrantes" HeaderText="Kilos Programados" />
                    <asp:BoundField DataField="batch_FechaInicio" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Inicio" />
                    <asp:BoundField DataField="batch_FechaFin" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Fin" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="btnCerrar" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="btnCerrar_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>

        <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label4" runat="server" Text="Pedido:"></asp:Label>
            <asp:Label ID="Label6" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label8" runat="server" Text="Item:"></asp:Label>
            <asp:Label ID="Label9" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label10" runat="server" Text="Clon:"></asp:Label>
            <asp:Label ID="Label11" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label12" runat="server" Text="Programado:"></asp:Label>
            <asp:Label ID="Label13" runat="server" Font-Bold="True"></asp:Label>
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="gwGrilla1" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center">
       
                
                <Columns>
                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
                    </asp:BoundField>
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="CodProducto" HeaderText="Cod.Producto" />
                    <asp:BoundField DataField="DescProducto" HeaderText="Desc.Producto" />
                    <asp:BoundField DataField="Cantidad_Original" DataFormatString="{0:0.00}" HeaderText="Kilos" />
                    <asp:BoundField DataField="Lote" HeaderText="S/L" />
                    <asp:BoundField DataField="TipoPago" HeaderText="Tipo Pago" />
                    <asp:BoundField DataField="Flag" HeaderText="Flag" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="Button1" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button1_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>

        <asp:Panel ID="Panel3" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label14" runat="server" Text="Pedido:"></asp:Label>
            <asp:Label ID="Label15" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label16" runat="server" Text="Item:"></asp:Label>
            <asp:Label ID="Label17" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label18" runat="server" Text="Clon:"></asp:Label>
            <asp:Label ID="Label19" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label20" runat="server" Text="Programado:"></asp:Label>
            <asp:Label ID="Label21" runat="server" Font-Bold="True"></asp:Label>
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="gwGrilla2" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center">
                <Columns>
                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                    <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                    <asp:BoundField DataField="CodProducto" HeaderText="Cod.Producto" />
                    <asp:BoundField DataField="DescProducto" HeaderText="Desc.Producto" />
                    <asp:BoundField DataField="FechaEntrega" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Entrega" />
                    <asp:BoundField DataField="Cantidad_Original" DataFormatString="{0:0.00}" HeaderText="Kilos" />
                    <asp:BoundField DataField="Lote" HeaderText="S/L" />
                    <asp:BoundField DataField="TipoPago" HeaderText="Tipo Pago" />
                    <asp:BoundField DataField="Flag" HeaderText="Flag" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="Button2" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button2_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>

        <asp:Panel ID="Panel5" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label30" runat="server" Text="Pedido:"></asp:Label>
            <asp:Label ID="Label31" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label32" runat="server" Text="Item:"></asp:Label>
            <asp:Label ID="Label33" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label34" runat="server" Text="Clon:"></asp:Label>
            <asp:Label ID="Label35" runat="server" Font-Bold="True"></asp:Label>
            <asp:Label ID="Label36" runat="server" Text="A Programar:"></asp:Label>
            <asp:Label ID="Label37" runat="server" Font-Bold="True"></asp:Label>
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="gwGrilla3" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center">
       
                
                <Columns>
                    <asp:BoundField DataField="CodProducto" HeaderText="Cod.Producto" />
                    <asp:BoundField DataField="DescProducto" HeaderText="Desc.Producto" >
                    </asp:BoundField>
                    <asp:BoundField DataField="Cantidad_Original" HeaderText="Cantidad Original" DataFormatString="{0:0.00}" />
                    <asp:BoundField DataField="Cantidad_Pendiente" DataFormatString="{0:0.00}" HeaderText="Cantidad Pendiente" />
                    <asp:BoundField DataField="Motivo" HeaderText="Motivo" />
                    <asp:BoundField DataField="FECHAACEPTADA" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Aceptada" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="Button4" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button4_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>
            
   
   
   </div>
        </form>
   
</asp:Content>

