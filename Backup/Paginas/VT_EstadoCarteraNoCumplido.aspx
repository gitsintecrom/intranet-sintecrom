<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VT_EstadoCarteraNoCumplido.aspx.cs" Inherits="SintecromNet.Paginas.VT_EstadoCarteraNoCumplido" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Guardar la Modificación?')) return false;
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



        .style19
        {
            width: 115px;
        }
        .style18
        {
            width: 314px;
        }
        


        .style24
        {
        width: 115px;
        height: 26px;
    }
        .style25
        {
            width: 314px;
            height: 26px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Estado Cartera de Pedidos </h2>
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
<fieldset a 
    style="width: auto; height: auto; " id="Recuadro">
                    <legend>Filtro</legend>
        <table style="margin-left: 12px" __designer:mapid="132">
            <tr __designer:mapid="133">
                <td align="left" class="style19" __designer:mapid="134">
                    Cliente:</td>
                <td align="left" class="style18" __designer:mapid="135">
                    <asp:TextBox ID="txtCliente" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Vendedor:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:TextBox ID="txtVendedor" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Nro. Pedido:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:TextBox ID="txtNumeroPedido" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Estado:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="126px">
                        <asp:ListItem Value="Todos">Todos</asp:ListItem>
                        <asp:ListItem Value="F">Pendiente</asp:ListItem>
                        <asp:ListItem Value="T">Cumplido</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    &nbsp;</td>
                <td align="left" class="style25" __designer:mapid="135">
    <asp:Button ID="btnVer0" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="Maroon" Font-Bold="False" ForeColor="White" Height="28px" 
                        style="text-align: center" TabIndex="50" Width="100px"  />
                </td>
            </tr>
            </table>
                </fieldset a><table style="width:100%;">
        <tr>
            <td align="center" valign="middle">
            &nbsp;<asp:ImageButton ID="imgImprimir" runat="server" Height="51px" 
                    ImageUrl="~/Images/imprimir.jpg" onclick="imgImprimir_Click" Width="53px" 
                    Visible="False" />
                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" 
                    Font-Size="8pt" InteractiveDeviceInfos="(Collection)" Visible="False" 
                    WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="936px">
                    <LocalReport ReportPath="Reportes\EstadoCartera.rdlc">
                    </LocalReport>
                </rsweb:ReportViewer>
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gwNoCumplidos" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="La Consulta No ha Arrojado Resultados, verifique las Variables seleccionadas." 
                    onrowdatabound="gwNoCumplidos_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwNoCumplidos_RowCommand" 
                    onselectedindexchanged="gwNoCumplidos_SelectedIndexChanged">
        <Columns>
            <asp:BoundField HeaderText="Razón Social" DataField="RazonSocial" >
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="18%" />
            </asp:BoundField>
            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="18%" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaPedido" HeaderText="Fecha Pedido" 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="NumeroPedido" HeaderText="Num.Pedido" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="4%" />
            </asp:BoundField>
            <asp:BoundField DataField="NROITEM" HeaderText="Item">
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="NClonado" HeaderText="Clon">
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Producto" HeaderText="Descripción Producto" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="25%" />
            </asp:BoundField>
            <asp:BoundField DataField="fechasolicitada" HeaderText="Fecha Solicitada" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="fechaaceptada" HeaderText="Fecha Aceptada" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="cantidadpedido" HeaderText="Cantidad Original" 
                DataFormatString="{0:0.00}" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Entregado" HeaderText="Entregado" 
                DataFormatString="{0:0.00}" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Saldo_Cartera" DataFormatString="{0:0.00}" 
                HeaderText="Saldo Cartera">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Porcentaje" DataFormatString="{0:0.00}" 
                HeaderText="% Cumplido">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            </td>
        </tr>
    </table>
    </p>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="680px" Width="950px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" ScrollBars="Vertical">
            <h2>Detalle del Pedido: 
                <asp:Label ID="Label2" runat="server" Text="L"></asp:Label>
            </h2> 
            <br />
            <asp:GridView ID="gwPedidoSeleccionado" runat="server" 
                AutoGenerateColumns="False" 
                EmptyDataText="La Consulta No ha Arrojado Resultados, verifique las Variables seleccionadas." 
                Height="53px">
                <Columns>
                    <asp:BoundField DataField="cantidadpedido" DataFormatString="{0:0.00}" 
                        HeaderText="Cantidad Original">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="aprogramar" DataFormatString="{0:0.00}" 
                        HeaderText="A Programar">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Programado" DataFormatString="{0:0.00}" 
                        HeaderText="Programado">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Fabricado" DataFormatString="{0:0.00}" 
                        HeaderText="Fabricado">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="A_Calidad" DataFormatString="{0:0.00}" 
                        HeaderText="A Calidad">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="aremitir" DataFormatString="{0:0.00}" 
                        HeaderText="A Remitir">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="remitido" DataFormatString="{0:0.00}" 
                        HeaderText="Remitido">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="aentregar" DataFormatString="{0:0.00}" 
                        HeaderText="A Entregar">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Entregado" DataFormatString="{0:0.00}" 
                        HeaderText="Entregado">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="fechaaceptada" HeaderText="Fecha Aceptada" 
                        DataFormatString="{0:dd/MM/yyyy}">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Saldo_Cartera" DataFormatString="{0:0.00}" 
                        HeaderText="Saldo Cartera">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Porcentaje" DataFormatString="{0:0.00}" 
                        HeaderText="% Cumplido">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="5%" />
                    </asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="Maroon" Font-Names="Arial" Font-Size="9pt" 
                    ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
            <asp:Chart ID="Chart1" runat="server" BackColor="Maroon" 
                BackGradientStyle="Center" Width="669px" Height="250px">
                <Series>
                    <asp:Series Label="Total Pedido" Name="Series1">
                        <SmartLabelStyle CalloutLineAnchorCapStyle="None" />
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Label="Programado" Name="Series2">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Label="Fabricado" Name="Series3">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Label="Remitido" Name="Series4">
                    </asp:Series>
                    <asp:Series ChartArea="ChartArea1" Label="Entregado" Name="Series5">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartArea1">
                        <AxisY Title="Kilos">
                        </AxisY>
                        <AxisX LineWidth="0">
                        </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
                <Titles>
                    <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                        Text="Detalle de Pedidos">
                    </asp:Title>
                </Titles>
            </asp:Chart>
            <br />
            <h2>En Fabricación:</h2> <asp:GridView ID="gwEnFabricacion" runat="server" 
                AutoGenerateColumns="False" 
                EmptyDataText="No Existen Items en Fabricación Para el Pedido Solicitado" 
                Height="53px">
                <Columns>
                    <asp:BoundField DataField="Nro_Matching" 
                        HeaderText="Matching">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="8%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="kgsSolicitados" DataFormatString="{0:0.00}" 
                        HeaderText="Kilos Solicitados">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="3%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="KgsprogramadosxItem" DataFormatString="{0:0.00}" 
                        HeaderText="Kilos Programados">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="3%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RegistradoCerradoporItemPedido" 
                        DataFormatString="{0:0.00}" HeaderText="Kilos Registrados">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="3%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Origen_Tarea" 
                        HeaderText="Tarea Origen">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="8%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Destino_Tarea" 
                        HeaderText="Tarea Destino">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="8%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Origen_Lote" 
                        HeaderText="Lote Origen">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="10%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Destino_Lote" 
                        HeaderText="Lote Destino">
                    <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                        VerticalAlign="Middle" Width="10%" />
                    </asp:BoundField>
                    <asp:BoundField DataField="FechaFinBatch" DataFormatString="{0:dd/MM/yyyy}" 
                        HeaderText="Fecha Fin Batch">
                    <ItemStyle Width="8%" />
                    </asp:BoundField>
                </Columns>
                <HeaderStyle BackColor="Maroon" Font-Names="Arial" Font-Size="9pt" 
                    ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
               Text="Cerrar" />
            <br />
            <br />
            <br />
        </asp:Panel>
</asp:Content>

