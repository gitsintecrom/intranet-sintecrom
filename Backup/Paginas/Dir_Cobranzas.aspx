<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dir_Cobranzas.aspx.cs" Inherits="SintecromNet.Paginas.Dir_Cobranzas" %>
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
            width: 231px;
        }
        .style18
        {
            width: 314px;
        }
        .style19
        {
            width: 177px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Evolución Cobranzas</h2>
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
        <table style="width: 100%;">
            <tr>
                <td width="50%">
<fieldset a 
    style="width: 416px; height: 106px; ">
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
    <asp:Button ID="ButtonVer" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="Maroon" Font-Bold="False" ForeColor="White" Height="30px" 
                        style="text-align: center" Width="122px"  />
                </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style19" __designer:mapid="134">
                    Fecha Final:</td>
                <td align="left" class="style18" __designer:mapid="135">
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
                <td align="left" class="style17" __designer:mapid="135">
    <asp:Button ID="btnVerProyectado" runat="server" onclick="btnVerProyectado_Click" 
        Text="Ver Proyectado" BackColor="Maroon" Font-Bold="False" 
    ForeColor="White" Height="30px" 
                        style="text-align: center" Width="122px"  />
                </td>
            </tr>
            </table>
                </fieldset a></td>
                <td width="25%" style="background-color: #800000">
   
                    <br />
                    <br />
   
    <asp:Label ID="lblTextoMes" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Total Acumulado Mes:" Font-Names="Arial" ForeColor="White"></asp:Label>
                    <br />
   
    <asp:Label ID="lblPromediol" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Promedio Por Día del Mes:" Font-Names="Arial" ForeColor="White"></asp:Label>
                    <br />
   
    <asp:Label ID="lblTexto" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Total Acumulado Rango:" Font-Names="Arial" ForeColor="White" Visible="False"></asp:Label>
                    <br />
   
    <asp:Label ID="lblTexto0" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Acumulado Rango Mes Anterior:" Font-Names="Arial" ForeColor="White" Visible="False"></asp:Label>
                    <br />
   
    <asp:Label ID="lblPromediol0" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Promedio Por Día del Mes Anterior:" Font-Names="Arial" ForeColor="White" 
                        Visible="False"></asp:Label>
                    <br />
   
    <asp:Label ID="lblTexto1" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Acumulado Rango Año Anterior:" Font-Names="Arial" ForeColor="White" Visible="False"></asp:Label>
                    <br />
   
    <asp:Label ID="lblPromediol1" runat="server" Font-Bold="False" Font-Size="Small" 
        Text="Promedio Por Día del Año Anterior:" Font-Names="Arial" ForeColor="White" 
                        Visible="False"></asp:Label>
                    <br />
                    <br />
                    <br />
                    <br />
   
                </td>
                <td width="25%" style="background-color: #800000; text-align: right;">
                    <br />
                    <br />
    <asp:Label ID="lblAcumuladoMes" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="White" Text="Label" Font-Names="Arial"></asp:Label>
   
                    <br />
    <asp:Label ID="lblPromedio" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="White" Text="Label" Font-Names="Arial"></asp:Label>
   
                    <br />
    <asp:Label ID="lblAcumulado" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="White" Text="Label" Font-Names="Arial" Visible="False"></asp:Label>
   
                    <br />
    <asp:Label ID="lblAcumuladoMesA" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="White" Text="Label" Font-Names="Arial" Visible="False"></asp:Label>
   
                    <br />
    <asp:Label ID="lblPromedioMesA" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="White" Text="Label" Font-Names="Arial" Visible="False"></asp:Label>
   
                    <br />
    <asp:Label ID="lblAcumuladoAno" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="White" Text="Label" Font-Names="Arial" Visible="False"></asp:Label>
   
                    <br />
    <asp:Label ID="lblPromedioAnoA" runat="server" Font-Bold="False" Font-Size="Small" 
        ForeColor="White" Text="Label" Font-Names="Arial" Visible="False"></asp:Label>
   
                    <br />
                    <br />
   
                    <br />
                    <br />
   
                </td>
            </tr>
        </table>
        <asp:Chart ID="Chart1" runat="server" Width="712px" BackColor="Maroon" 
            BackGradientStyle="Center" Palette="Chocolate" Visible="False">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                    Text="Evolución Cobranzas Por Rango Seleccionado">
                </asp:Title>
            </Titles>
        </asp:Chart>
    <br />
        <asp:Chart ID="Chart2" runat="server" Width="712px" BackColor="Maroon" 
            BackGradientStyle="Center" Palette="SemiTransparent" Visible="False">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                    Text="Evolución Cobranzas Mes Anterior Por Rango Seleccionado">
                </asp:Title>
            </Titles>
        </asp:Chart>
    <br />
        <asp:Chart ID="Chart3" runat="server" Width="712px" BackColor="Maroon" 
            BackGradientStyle="Center" Palette="SeaGreen" Visible="False">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                    Text="Evolución Cobranzas Año Anterior Por Rango Seleccionado">
                </asp:Title>
            </Titles>
        </asp:Chart>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
    &nbsp;<p>
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
</asp:Content>

