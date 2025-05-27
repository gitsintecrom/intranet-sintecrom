<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ADM_OC_Servicios.aspx.cs" Inherits="SintecromNet.Paginas.ADM_OC_Servicios" %>
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
    <h2>Ordenes de Compra de Servicios<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h2>
<table style="width:100%;">
        <tr>
            <td align="center" valign="middle">
<fieldset a 
    style="width: auto; height: auto; " id="Recuadro">
                    <legend>Filtro</legend>
        <table style="margin-left: 12px" __designer:mapid="132">
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Fecha Desde:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:TextBox ID="TextBoxIni" runat="server" Width="65px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" 
                        TargetControlID="TextBoxIni" Mask="99/99/9999" CultureName="es-AR" 
                        UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Fecha Hasta:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:TextBox ID="TextBoxFin" runat="server" Width="65px" TabIndex="10"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" PromptCharacter="_" 
                        TargetControlID="TextBoxFin" 
                        Mask="99/99/9999">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Estado:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="126px">
                        <asp:ListItem Value="Todos">Todos</asp:ListItem>
                        <asp:ListItem Value="Pendiente">Pendiente</asp:ListItem>
                        <asp:ListItem Value="Cumplido">Cumplido</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Proveedor</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:TextBox ID="txtProveedor" runat="server" Width="278px"></asp:TextBox>
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
                </fieldset a><br />
                <asp:ImageButton ID="btnExcel" runat="server" Height="51px" 
                    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click1" Visible="False" 
                    Width="53px" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gwOCServicios" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="El Filtro Seleccionado no ha Arrojado Resultados">
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
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            </td>
        </tr>
    </table>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="100px" Width="400px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999">
            <asp:Label ID="LabelErr" runat="server" CssClass="align" ForeColor="Black" 
                Text="Label"></asp:Label>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
                Text="Cerrar" />
            <br />
            <br />
        </asp:Panel>
</asp:Content>

