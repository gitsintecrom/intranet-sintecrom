<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Pendientes_Por_Cliente.aspx.cs" Inherits="SintecromNet.Paginas.Pendientes_Por_Cliente" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
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



        .style17
        {
            width: 224px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Pendientes Por Clientes</h2>
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
<fieldset a 
    style="width: 350px; height: 100px; ">
                    <legend>Filtro</legend>
        <table style="margin-left: 12px" __designer:mapid="132">
            <tr __designer:mapid="133">
                <td align="left" class="style22" __designer:mapid="134">
                    Cliente:</td>
                <td align="left" class="style17" __designer:mapid="135">
                    <asp:TextBox ID="txtCliente" runat="server" Width="164px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtCliente" CssClass="failureNotification" 
                        ErrorMessage="El campo Cliente es obligatorio" ValidationGroup="Validar">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="right" class="style22" __designer:mapid="134" colspan="2">
    <asp:Button ID="ButtonVer" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="Maroon" Font-Bold="False" ForeColor="White" Height="30px" 
                        style="text-align: left" ValidationGroup="Validar"  />
                    </td>
            </tr>
            </table>
                </fieldset a>
   
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT * FROM [Totales_Cobranzas]"></asp:SqlDataSource>
   
    <asp:Label ID="lblTexto" runat="server" Font-Bold="True" Font-Size="Medium" 
        Text="Teléfono:"></asp:Label>
    <asp:Label ID="lblTelefono" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="#336699" Text="Label"></asp:Label>
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label 
        ID="labelEmail" runat="server" Font-Bold="True" Font-Size="Medium" 
        Text="Email:"></asp:Label>
    <asp:Label ID="lblEmail" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="#336699" Text="Label"></asp:Label>
   
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    <asp:Label ID="lblTextoSaldo" runat="server" Font-Bold="True" Font-Size="Medium" 
        Text="Saldo:"></asp:Label>
    <asp:Label ID="lblAcumulado" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="#336699" Text="Label"></asp:Label>
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<asp:ImageButton ID="btnExcel" runat="server" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" />
&nbsp;<asp:GridView ID="gwPendientes" runat="server" AutoGenerateColumns="False"  
        EmptyDataText="La Busqueda no Ha Arrojado Resultados">
        <Columns>
            <asp:BoundField DataField="Operador Comercial" HeaderText="Op. Comercial" >
            <ControlStyle Width="200px" Font-Names="Rod" />
            <HeaderStyle VerticalAlign="Middle" />
            <ItemStyle Font-Names="Arial" Font-Size="Smaller" />
            </asp:BoundField>
             <asp:BoundField DataField="Transaccion" HeaderText="Transaccion" >
             <ControlStyle Width="350px" />
            <HeaderStyle VerticalAlign="Middle" />
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
            <%--<asp:BoundField DataField="Transaccion" HeaderText="Transaccion"/>--%>
            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" >
            <ControlStyle Width="350px" />
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
            <asp:BoundField DataField="Saldo" DataFormatString="{0:0.00}" 
                HeaderText="Saldo $" >
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
            <asp:BoundField DataField="Importe Total" DataFormatString="{0:0.00}" 
                HeaderText="Importe Orig." >
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
            <asp:BoundField DataField="Cotización" DataFormatString="{0:0.0000}" 
                HeaderText="Cotización" >
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
            <asp:BoundField DataField="Fecha de Vencimiento" HeaderText="Fecha Vto." >
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" >
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
            <asp:BoundField DataField="Fecha Entrega Remito" 
                HeaderText="Fecha Entrega Remito" >
            <ControlStyle Font-Names="Arial" Font-Size="X-Small" />
            <ItemStyle Font-Names="Arial" Font-Size="X-Small" />
            </asp:BoundField>
        </Columns>
        <EditRowStyle VerticalAlign="Middle" />
        <HeaderStyle BackColor="Maroon" ForeColor="White" />
        <PagerStyle VerticalAlign="Middle" />
        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
    </asp:GridView>
   
    <p>
        </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    <p>
         &nbsp;</asp:Content>

