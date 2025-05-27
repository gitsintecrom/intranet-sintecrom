<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MIS_ReqServicios.aspx.cs" Inherits="SintecromNet.Paginas.MIS_ReqServicios" %>
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
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Mis Requerimientos de servicios<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h2>
<table style="width:100%;">
        <tr>
            <td align="center" valign="middle">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gwOCServicios" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="Usted No tiene Requerimientos de Servicios Incumplidos" 
                    onrowdatabound="gwOCServicios_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwOCServicios_RowCommand" 
                    onselectedindexchanged="gwOCServicios_SelectedIndexChanged" 
                    DataKeyNames="IDMODI">
        <Columns>
            <asp:BoundField HeaderText="Orden de Compra" DataField="Nombre_OC" >
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="25%" />
            </asp:BoundField>
            <asp:BoundField DataField="Denominacion_Destinatario" HeaderText="Destinatario">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="20%" />
            </asp:BoundField>
            <asp:BoundField DataField="Solicitante" HeaderText="Solicitante" >
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="20%" />
            </asp:BoundField>
            <asp:BoundField DataField="Nota" HeaderText="Nota" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="FECHAENTREGA" HeaderText="Fecha Entrega" 
                DataFormatString="{0:dd/MM/yyyy}" >
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="10%" />
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Detalle" HeaderText="Detalle">
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="20%" />
            </asp:BoundField>
            <asp:BoundField DataField="Porcentaje" DataFormatString="{0:0.00}" 
                HeaderText="% Cumplido">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="IDMODI" HeaderText="IDMODI" Visible="False" />
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            </td>
        </tr>
    </table>
    &nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<asp:HiddenField ID="HiddenFieldError" runat="server" />


        <asp:Panel ID="Panel1" runat="server" Height="300px" Width="400px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999">
            <h2>
                <asp:Label ID="Label3" runat="server" Text="Orden"></asp:Label>
                <asp:TextBox ID="txtOrdendeCompra" runat="server" ReadOnly="True" Width="300px"></asp:TextBox>
            </h2> 
            <h2>
                <asp:Label ID="Label2" runat="server" Text="% Cumplimiento:"></asp:Label>
                <asp:TextBox ID="txtPorcentaje" runat="server" Width="66px">0</asp:TextBox>
            </h2>
            <h2>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtPorcentaje" ErrorMessage="Debe Ingresar un Valor" 
                    Font-Names="Arial" Font-Size="10pt" ForeColor="#CC0000" 
                    ValidationGroup="Validar"></asp:RequiredFieldValidator>
            </h2>
            <h2>
                &nbsp;</h2>
            <br />
            <asp:Button ID="btnModificar" runat="server" Enabled="False" 
                onclick="btnModificar_Click" Text="Modificar" ValidationGroup="Validar" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
                Text="Cerrar" />
            <br />
            <br />
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        </asp:Content>

