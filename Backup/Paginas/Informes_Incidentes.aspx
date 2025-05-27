<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Informes_Incidentes.aspx.cs" Inherits="SintecromNet.Paginas.Informes_Incidentes" %>
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



        .style19
        {
            width: 301px;
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
            width: 301px;
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
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Informes Incidentes</h2>
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
                    Estado:</td>
                <td align="left" class="style17" __designer:mapid="135">
                <asp:DropDownList ID="DropDownList3" runat="server" Width="100px" TabIndex="20">
                    <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="A">Abierto</asp:ListItem>
                    <asp:ListItem Value="S">Asignado</asp:ListItem>
                    <asp:ListItem Value="C">Cerrado</asp:ListItem>
                </asp:DropDownList>
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Fecha Final:</td>
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
                <td align="left" class="style26" __designer:mapid="135">
                    Tipo:</td>
                <td align="left" class="style26" __designer:mapid="135">
                <asp:DropDownList ID="DropDownList4" runat="server" Width="100px" TabIndex="30">
                    <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                    <asp:ListItem Value="Software(No Calipso)">Software(No Calipso)</asp:ListItem>
                    <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                </asp:DropDownList>
                    </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Usuario:</td>
                <td align="left" class="style25" __designer:mapid="135">
                <asp:DropDownList ID="ddSolicitante" runat="server" Width="180px">
                </asp:DropDownList>
                </td>
                <td align="left" class="style26" __designer:mapid="135">
                    Asignado a:</td>
                <td align="left" class="style26" __designer:mapid="135">
                <asp:DropDownList ID="ddAsignarB" runat="server" Width="100px" 
                        DataTextField="Nombre" DataValueField="Nombre" 
                    TabIndex="40">
                </asp:DropDownList>
                    </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Sector:</td>
                <td align="left" class="style25" __designer:mapid="135">
                <asp:DropDownList ID="ddSector" runat="server" Width="180px">
                </asp:DropDownList>
                </td>
                <td align="left" class="style26" __designer:mapid="135">
                    &nbsp;</td>
                <td align="left" class="style26" __designer:mapid="135">
    <asp:Button ID="btnVer0" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="Maroon" Font-Bold="False" ForeColor="White" Height="28px" 
                        style="text-align: center" TabIndex="50" Width="100px"  />
                    </td>
            </tr>
            </table>
                </fieldset a><table style="width:100%;">
        <tr>
            <td align="center" valign="middle">
<asp:ImageButton ID="btnExcel" runat="server" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gwIncidentes" runat="server" AutoGenerateColumns="False" 
        
                    EmptyDataText="La Consulta No ha Arrojado Resultados, verifique las Variables seleccionadas.">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Numero" >
            <ControlStyle Width="5%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaInicial" HeaderText="Fecha " 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaFinal" HeaderText="Fecha Ultima Modif." 
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
            <asp:BoundField HeaderText="Sector" DataField="Sector" />
            <asp:BoundField DataField="Asignado" HeaderText="Asignado A" />
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


        <asp:Panel ID="Panel1" runat="server" Height="120px" Width="326px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center">
            <br />
            <asp:Label ID="LabelErr" runat="server" Text="Label" ForeColor="Black" 
                CssClass="align"></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
               Text="Aceptar" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
</asp:Content>

