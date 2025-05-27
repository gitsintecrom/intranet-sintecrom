<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mis_Incidentes.aspx.cs" Inherits="SintecromNet.Paginas.Mis_Incidentes" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">


        .style19
        {
            width: 177px;
        }
        .style18
        {
            width: 314px;
        }
        


        .style17
        {
            width: 231px;
        }
        .style24
        {
            width: 177px;
            height: 26px;
        }
        .style25
        {
            width: 314px;
            height: 26px;
        }
        .style26
        {
            width: 231px;
            height: 26px;
        }
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
    <h2>Estado de Mis incidentes<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT * FROM [Totales_Cobranzas]"></asp:SqlDataSource>
   
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
   
    </h2>
    <table style="width:100%;">
        <tr>
            <td width="50%">
<fieldset a 
    style="width: 416px; height: 106px; " id="Recuadro">
                    <legend>Filtro</legend>
        <table style="margin-left: 12px" __designer:mapid="132">
            <tr __designer:mapid="133">
                <td align="left" class="style19" __designer:mapid="134">
                    Fecha Inicial:</td>
                <td align="left" class="style18" __designer:mapid="135">
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
                <td align="left" class="style17" __designer:mapid="135">
                    &nbsp;</td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Fecha Final:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:TextBox ID="TextBoxFin" runat="server" Width="65px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" PromptCharacter="_" 
                        TargetControlID="TextBoxFin" 
                        Mask="99/99/9999">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                </td>
                <td align="left" class="style26" __designer:mapid="135">
    <asp:Button ID="btnVer" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="Maroon" Font-Bold="False" ForeColor="White" Height="30px" 
                        style="text-align: right"  />
                    </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Tipo:</td>
                <td align="left" class="style25" __designer:mapid="135">
                <asp:DropDownList ID="DropDownList4" runat="server" Width="100px" TabIndex="30">
                    <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                    <asp:ListItem Value="Software(No Calipso)">Software(No Calipso)</asp:ListItem>
                    <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                </asp:DropDownList>
                </td>
                <td align="left" class="style26" __designer:mapid="135">
                    &nbsp;</td>
            </tr>
            </table>
                </fieldset a></td>
            <td style="text-align: center" width="50%">
&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
                <asp:ImageButton ID="imgDetalle" runat="server" ImageUrl="~/Images/icono_search.gif" 
                    style="margin-bottom: 0px; height: 16px;" ToolTip="Ver Detalle" 
                    onclick="imgDetalle_Click" Visible="False" />               
                &nbsp;<asp:Label ID="lblMensaje" runat="server" 
                    Text="Seleccione un Incidente y luego presione el Icono para Ver el detalle" 
                    Visible="False"></asp:Label>
            </td>
            </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
<asp:GridView ID="gwIncidentes" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowcommand="gwIncidentes_RowCommand">
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
            <asp:BoundField DataField="Numero" HeaderText="Numero" >
            <ControlStyle Width="5%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaInicial" HeaderText="Fecha " 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaFinal" HeaderText="Fecha Ultimo Estado" 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
            <ControlStyle Width="15%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Estado" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
            <asp:BoundField DataField="Asignado" HeaderText="Asignado A" />
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
            <td width="50%" colspan="2" style="width: 100%; text-align: center">
<asp:GridView ID="gwComentarios" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowcommand="gwIncidentes_RowCommand">
        <Columns>
            <asp:BoundField DataField="FechaComentario" HeaderText="Fecha " 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="5%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="UsuarioCom" HeaderText="Usuario">
            <HeaderStyle Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="Descripcion" HeaderText="Comentarios" >
            <ControlStyle Width="85%" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
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
