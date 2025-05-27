<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VT_DetallePedidos.aspx.cs" Inherits="SintecromNet.Paginas.VT_DetallePedidos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">


fieldset
{
    margin: 1em 0px;
    padding: 1em;
    border: 1px solid #ccc;
    height: 716px;
}

legend 
{
    font-size: 1.1em;
    font-weight: 600;
    padding: 2px 4px 8px 4px;
}

a:link, a:visited
{
    color: #034af3;
}

    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <h2>Detalle del Pedido:
        <asp:Label ID="Label1" runat="server" Text="L"></asp:Label>
        </h2>
                <asp:GridView ID="gwPedidoSeleccionado" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    
            
            EmptyDataText="La Consulta No ha Arrojado Resultados, verifique las Variables seleccionadas." 
            Height="53px">
        <Columns>
            <asp:BoundField DataField="cantidadpedido" HeaderText="Cantidad Original" 
                DataFormatString="{0:0.00}" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="aprogramar" DataFormatString="{0:0.00}" 
                HeaderText="A Programar">
            <ItemStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="5%" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Programado" DataField="Programado" 
                DataFormatString="{0:0.00}" >
            <ItemStyle  HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" Font-Size="9pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="afabricar" DataFormatString="{0:0.00}" 
                HeaderText="A Fabricar">
            <ItemStyle  HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" Font-Size="9pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Fabricado" DataFormatString="{0:0.00}" 
                HeaderText="Fabricado">
            <ItemStyle  HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" Font-Size="9pt" Width="5%" />
            </asp:BoundField>
             <asp:BoundField DataField="A_Calidad" DataFormatString="{0:0.00}" 
                HeaderText="A Calidad">
            <ItemStyle  HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" Font-Size="9pt" Width="5%" />
            </asp:BoundField>
             <asp:BoundField DataField="aremitir" HeaderText="A Remitir" 
                DataFormatString="{0:0.00}" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
             <asp:BoundField DataField="remitido" HeaderText="Remitido" 
                DataFormatString="{0:0.00}" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
             <asp:BoundField DataField="aentregar" HeaderText="A Entregar" 
                DataFormatString="{0:0.00}" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Entregado" HeaderText="Entregado" 
                DataFormatString="{0:0.00}" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
             <asp:BoundField DataField="fechaentrega" HeaderText="Fecha de Entrega" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Saldo_Cartera" DataFormatString="{0:0.00}" 
                HeaderText="Saldo Cartera">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Porcentaje" DataFormatString="{0:0.00}" 
                HeaderText="% Cumplido">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="9pt" Width="5%" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" Font-Names="Arial" Font-Size="9pt" />
</asp:GridView>
            <p>
        <asp:Chart ID="Chart1" runat="server" Width="669px" BackColor="Maroon" 
            BackGradientStyle="Center" Visible="False">
            <Series>
                <asp:Series Name="Series1" Label="Total Pedido">
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
        </p>
        <p>
            &nbsp;</p>
            
    </div>
    </form>
</body>
</html>
