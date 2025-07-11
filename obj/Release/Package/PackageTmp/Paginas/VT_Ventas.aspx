<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="VT_Ventas.aspx.cs" Inherits="SintecromNet.Paginas.VT_Ventas" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">
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
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Ventas
    <asp:Label ID="lblUsuario" runat="server" Text="Label"></asp:Label>
</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Panel ID="Panel4" runat="server" BorderStyle="Outset" BorderWidth="3px" Height="210px" HorizontalAlign="Center" Width="420px" BackColor="#EEEEEE" style="text-align: center">
            <div style="text-align: center; width: 420px; height: 25px; background-color: #000000;">
                <h1 style="color: #FFFFFF">Filtros</h1>
                <br />
                <br />
            </div>
            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<div style="text-align: center; width: 420px; float: left;">
                &nbsp;<asp:Label ID="labelRes0" runat="server" style="text-align: left" Text="Fecha Desde:" Width="80px"></asp:Label>
                <asp:TextBox ID="TextBoxIni" runat="server" Width="100px"></asp:TextBox>
                <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                </asp:CalendarExtender>
                &nbsp;<br />&nbsp;<asp:Label ID="labelRes1" runat="server" style="text-align: left" Text="Fecha Hasta:" Width="80px"></asp:Label>
                <asp:TextBox ID="TextBoxFin" runat="server" TabIndex="10" Width="100px"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                </asp:CalendarExtender>
                &nbsp;<br />&nbsp;<asp:Label ID="lblPedido5" runat="server" style="text-align: left" Text="Cliente" Width="80px"></asp:Label>
                <asp:TextBox ID="txtCliente" runat="server" Width="100px"></asp:TextBox>
                &nbsp;<br />&nbsp;<asp:Label ID="lblVendedor" runat="server" style="text-align: left" Text="Vendedor:" Width="80px"></asp:Label>
                <asp:TextBox ID="txtVendedor" runat="server" Width="100px"></asp:TextBox>
                &nbsp;<br />
                <br />
            </div>
            <br />
            <asp:Button ID="btnVer0" runat="server" BackColor="Black" Font-Bold="False" ForeColor="White" Height="21px" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="100px" />
            <br />
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            &nbsp;</asp:Panel>
<asp:ImageButton ID="btnExcel" runat="server" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" />
            <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" DataKeyNames="Producto,DomicilioZona,CiudadZona" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
            <asp:BoundField DataField="Codigo" HeaderText="Producto" />
            <asp:BoundField DataField="Familia" HeaderText="Familia" />
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}">
            </asp:BoundField>
            <asp:BoundField DataField="Importe_Pesos" HeaderText="Pesos" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="ImporteDolares" HeaderText="Dolares" DataFormatString="{0:0.00}" />
            <asp:BoundField HeaderText="Pedido" DataField="NumeroPedido" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Numero_Documento" HeaderText="Nro.Documento" />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha " DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Producto" HeaderText="Producto" Visible="False" />
            <asp:BoundField DataField="DomicilioZona" HeaderText="DomicilioZona" Visible="False" />
            <asp:BoundField DataField="CiudadZona" HeaderText="CiudadZona" Visible="False" />
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <asp:Panel ID="Panel2" runat="server" BackColor="#EEEEEE" BorderStyle="Outset" BorderWidth="3px" style="text-align: left" Visible="False" Width="700px">
&nbsp;<div style="text-align: center; width: 700px; height: 25px; background-color: #000000;">
                        <h1 style="color: #FFFFFF; width: 700px;">Detalles</h1>                           
                        <br />
                        <br />
                    </div>
                    <br />
                    <asp:Label ID="Label8" runat="server" Text="Desc.Producto:" Width="130px"></asp:Label>
                    <asp:TextBox ID="txtProducto" runat="server" ReadOnly="True" Width="350px"></asp:TextBox>
                    &nbsp;&nbsp;&nbsp;&nbsp;<br />
                    <asp:Label ID="Label10" runat="server" Text="Domicilio Entrega:" Width="130px"></asp:Label>
                    <asp:TextBox ID="txtDomicilio" runat="server" ReadOnly="True" Width="350px"></asp:TextBox>
                    <br />
                    <asp:Label ID="Label12" runat="server" Text="Ciudad:" Width="130px"></asp:Label>
                    <asp:TextBox ID="txtCiudad" runat="server" ReadOnly="True" Width="350px"></asp:TextBox>
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <div style="text-align: center; width: 700px">
                        &nbsp;
                        <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" TabIndex="170" Text="Cerrar" />
                    </div>
                    <br />
                </asp:Panel>
    &nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;


        </asp:Content>

