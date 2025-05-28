<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SRP_TrackingProduccion.aspx.cs" Inherits="SintecromNet.Paginas.SRP_TrackingProduccion" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Autorizar el Traslado?')) return false;
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
    <style type="text/css">
    .auto-style1 {
        color: #FFFFFF;
    }
</style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
    <h2>Tracking Produccion</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="labelRes0" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Fecha Desde:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBoxIni" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                 &nbsp;<asp:Label ID="labelRes1" runat="server" style="text-align: left" Text="Fecha Hasta:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>

                        <asp:TextBox ID="TextBoxFin" runat="server" TabIndex="10" Width="130px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                 &nbsp;<asp:Label ID="lblPedido" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Pedido:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBPedido" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
               
                <br />
                <br />                
                 <asp:Label ID="lblPedido3" runat="server" style="text-align: left" Text="Batch:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBBatch" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
                &nbsp;<asp:Label ID="lblPedido4" runat="server" style="text-align: left" Text="Maquina:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBMaquina" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
                &nbsp;<asp:Label ID="lblPedido5" runat="server" style="text-align: left" Text="Serie/Lote:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBSerie" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
               
                <br />
                <br />  
                <asp:Label ID="lblPedido7" runat="server" style="text-align: left" Text="Operacion:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBMatching" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
               
                <asp:Label ID="lblPedido1" runat="server" style="text-align: left" Text="Estado:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="130px" CssClass="form-control">
                    <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="Pendiente">Pendientes</asp:ListItem>
                    <asp:ListItem Value="Abierta">En Proceso</asp:ListItem>
                    <asp:ListItem Value="Cerrada">Cerradas</asp:ListItem>
                    <asp:ListItem Value="Anulada">Anuladas</asp:ListItem>
                    <asp:ListItem Value="Todos">Todos</asp:ListItem>
                </asp:DropDownList>

                <asp:Label ID="lblPedido2" runat="server" style="text-align: left" Text="Abastecida:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" Width="130px" CssClass="form-control">
                    <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="Si">Si</asp:ListItem>
                    <asp:ListItem Value="No">No</asp:ListItem>
                    <asp:ListItem Value="Todos">Todos</asp:ListItem>
                </asp:DropDownList>
                <br />
                 <br />

                <asp:Label ID="lblPedido6" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Con Stock:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList3" runat="server" Width="130px" CssClass="form-control">
                    <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="Si">Si</asp:ListItem>
                    <asp:ListItem Value="No">No</asp:ListItem>
                    <asp:ListItem Value="Todos">Todos</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="lblPedido8" runat="server" style="text-align: left" Text="Tipo:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList4" runat="server" Width="130px" CssClass="form-control">
                    <asp:ListItem Value="9">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="0">SobreOrden</asp:ListItem>
                    <asp:ListItem Value="1">Sobrante</asp:ListItem>
                    <asp:ListItem Value="2">Scrap</asp:ListItem>
                    <asp:ListItem Value="9">Todos</asp:ListItem>
                </asp:DropDownList>
                          <asp:Label ID="Label1" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="A Calidad:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList5" runat="server" Width="130px" CssClass="form-control">
                    <asp:ListItem Value="9">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="0">Si</asp:ListItem>
                    <asp:ListItem Value="1">No</asp:ListItem>
                    <asp:ListItem Value="9">Todos</asp:ListItem>
                </asp:DropDownList>

             &nbsp; &nbsp;<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle"  onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="100px" />

                
            </div>
           
                        </div>
                    </div>
             <%--</div>--%>
        
<asp:ImageButton ID="btnExcel" runat="server" Height="51px"  cssclass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" />
            <br />
        <div style="overflow:auto; width:1020px; ">
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-striped table-bordered table-hover"
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" DataKeyNames="NumeroDocumento,Clientes,Origen_Lote_Desc,Stock,Nombre_Solicitud,NumeroPedido,Operacion_ID" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="NumeroPedido" HeaderText="Pedido" />
            <asp:BoundField DataField="Nro_Matching" HeaderText="Matching" />
            <asp:BoundField DataField="NroBatch" HeaderText="Nro.Batch" />
            <asp:BoundField HeaderText="NumeroDocumento" DataField="NumeroDocumento" Visible="False" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Maquina" HeaderText="Maquina" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Clientes" HeaderText="Clientes" Visible="False" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Origen_Lote_Desc" HeaderText="S/L IN" />
            <asp:BoundField DataField="KilosProgramadosEntrantes" HeaderText="Programados ">
            </asp:BoundField>
            <asp:BoundField DataField="Kilos_Balanza" HeaderText="Entrantes" />
<asp:BoundField DataField="Kilos_Calidad" HeaderText="Kgs.Calidad ">
</asp:BoundField>
            <asp:BoundField DataField="Kilos_SobreOrden" HeaderText="SobreOrden" />
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
            <asp:BoundField DataField="Destino_Lote_Desc" HeaderText="S/L OUT" />
            <asp:BoundField DataField="Estado" HeaderText="Estado " />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha " DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
<asp:BoundField DataField="Abastecida" HeaderText="Abastecida">
</asp:BoundField>
            <asp:BoundField DataField="Stock" DataFormatString="{0:0.00}" HeaderText="Stock" Visible="False" />
            <asp:BoundField DataField="StockS" HeaderText="StockSaliente" Visible="False" />
            <asp:BoundField DataField="Deposito" HeaderText="Deposito" Visible="False" />
            <asp:BoundField DataField="DepositoS" HeaderText="DepositoS" Visible="False" />
            <asp:BoundField DataField="Nombre_Solicitud" HeaderText="Nombre_Solicitud" Visible="False" />
            <asp:BoundField DataField="Operacion_ID" HeaderText="Operacion_id" Visible="False" />
            <asp:BoundField DataField="Raiz" HeaderText="Raiz" />
        </Columns>
        
                    <HeaderStyle Font-Size="8pt" />
        
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
            </div>
                <asp:Panel ID="Panel2" runat="server" BackColor="#EEEEEE" BorderStyle="Outset" BorderWidth="3px" style="text-align: left" Visible="False"   Width="720px">
                <div class="input-group">
                    <h2>Detalles</h2> 

                    <br />
                    <asp:Label ID="Label12" runat="server" Text="Operación" Width="100px"></asp:Label>
                    <asp:TextBox ID="txtOperacion" runat="server" ReadOnly="True" Width="200px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label4" runat="server" Text="Clientes:" Width="100px"></asp:Label>
                    <asp:TextBox ID="txtClientes" runat="server" ReadOnly="True" Width="527px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label8" runat="server" Text="S/L Entrante:" Width="100px"></asp:Label>
                    <asp:TextBox ID="txtSerieE" runat="server" ReadOnly="True" Width="350px"></asp:TextBox>
                    &nbsp;<asp:Label ID="Label14" runat="server" Text="Stock SLE:" Width="80px"></asp:Label>
                    <asp:TextBox ID="txtStockE" runat="server" ReadOnly="True" Width="80px"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;<br />
                    <asp:Label ID="Label10" runat="server" Text="Solicitud:" Width="100px"></asp:Label>
                    <asp:TextBox ID="txtSolicitud" runat="server" ReadOnly="True" Width="310px"></asp:TextBox>
                    <br />
                    <br />
                    <div style="text-align: center; width: 700px; background-color: #000000;">
                        &nbsp; <span class="auto-style1"><strong>SobreOrden Por Item de Pedido</strong></span><br />
                        <asp:GridView ID="gvItemPedido" runat="server" AutoGenerateColumns="False" EmptyDataText="No se han Encontrado Items SobreOrden Para el Pedido Seleccionado" HorizontalAlign="Center">
                            <Columns>
                                <asp:BoundField DataField="KilosProgramadosEntrantes" HeaderText="Programados" />
                                <asp:BoundField DataField="numeroPedido" HeaderText="Pedido" />
                                <asp:BoundField DataField="numeroItem" HeaderText="Item" />
                                <asp:BoundField DataField="Kilos_SobreOrden" HeaderText="Kilos_SobreOrden" />
                            </Columns>
                            <HeaderStyle ForeColor="White" />
                            <RowStyle ForeColor="White" />
                        </asp:GridView>
                    </div>
                    &nbsp;<div style="text-align: center; width: 700px;">
                        &nbsp;
                        <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" TabIndex="170" Text="Cerrar" />
                    </div>
                    <br />
                    </div>
                </asp:Panel>

        </div>
        </form>
        </asp:Content>

