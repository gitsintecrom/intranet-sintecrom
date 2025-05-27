<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PROD_VistoNovedadesTurnos.aspx.cs" Inherits="SintecromNet.Paginas.PROD_VistoNovedadesTurnos" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">


        .style23
        {
            text-align: left;
        }
        .style21
        {
            width: 154px;
        }
        </style>
        <script>
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
    <h2>Visto Novedades Turnos Producción<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT * FROM [Totales_Cobranzas]"></asp:SqlDataSource>
   
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
   
    </h2>
    <table style="width:100%;">
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
                <asp:ImageButton ID="imgDetalle" runat="server" ImageUrl="~/Images/icono_search.gif" 
                    style="margin-bottom: 0px; height: 16px;" ToolTip="Ver Detalle" 
                    onclick="imgDetalle_Click" Visible="False" />               
                &nbsp;<asp:Label ID="lblMensaje" runat="server" 
                    Text="Seleccione una Novedad y luego presione el Icono para Ver el detalle" 
                    Visible="False"></asp:Label>
            </td>
            </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
<asp:GridView ID="gwIncidentes" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowcommand="gwIncidentes_RowCommand" 
                    EmptyDataText="No se Encontraron Novedades para el rango seleccionado">
        <Columns>
            <asp:TemplateField HeaderText="Seleccionar">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox2" runat="server" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:TemplateField>
            <asp:BoundField DataField="ID" HeaderText="Novedad Nª">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaNovedad" HeaderText="Fecha Novedad" 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="15%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaVisto" HeaderText="Fecha Visto" 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Turno" HeaderText="Turno" >
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" >
            </asp:BoundField>
            <asp:BoundField DataField="VistoPor" HeaderText="Usuario Visto" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Comentario" HeaderText="Comentarios" />
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            </td>
            </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23">
                &nbsp;</td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                &nbsp;</td>
        </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
                <asp:Label ID="lblComentario" runat="server" Text="Comentario:" Visible="False"></asp:Label>
                <asp:TextBox ID="txtComentario" runat="server" MaxLength="1000" 
                    Width="462px" Height="144px" TextMode="MultiLine" ReadOnly="True" 
                    Visible="False"></asp:TextBox>
                </td>
            </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
                &nbsp;</td>
            </tr>
        <tr>
            <td width="50%" colspan="2" style="width: 100%; text-align: center">
                <asp:Button ID="btnCerrar" runat="server" onclick="btnCerrar_Click" 
                    Text="Cerrar" Visible="False" />
            </td>
        </tr>
    </table>
   
    <p>
         <asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="120px" Width="326px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke">
            <br />
            <asp:Label ID="LabelErr" runat="server" Text="Label" ForeColor="Black" 
                CssClass="align"></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
               Text="Aceptar" style="margin-left: 124px" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
    <p>
        &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    </asp:Content>
