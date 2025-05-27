<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SC_ParteDiario.aspx.cs" Inherits="SintecromNet.Paginas.SC_ParteDiario" %>
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
            width: 144px;
        }
        .style24
        {
        width: 144px;
        height: 26px;
    }
        </style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Parte Diario<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h2>
    <fieldset a 
    style="width: 200px; height: auto; " id="Recuadro">
                    <legend>Filtro</legend>       
            
                
        <table style="margin-left: 12px" __designer:mapid="132">
            <tr __designer:mapid="133">
                <td align="left" class="style19" __designer:mapid="134">
                    Fecha Inicial:</td>
                <td align="left" class="style19" __designer:mapid="135">
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
                    Fecha Final:</td>
                <td align="left" class="style24" __designer:mapid="135">
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
                    </td>
                <td align="left" class="style24" __designer:mapid="135">
    <asp:Button ID="btnVer" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="Maroon" Font-Bold="False" ForeColor="White" Height="28px" 
                        style="text-align: center" TabIndex="50" Width="65px"  />
                </td>
            </tr>
            </table>
            </fieldset a>
    <asp:GridView ID="gwParteDiario" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowdatabound="gwParteDiario_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="5%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="10%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="25%" Wrap="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="30%" Wrap="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="25%" Wrap="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="5%" Wrap="False" />
            </asp:BoundField>
        </Columns>
        <FooterStyle Wrap="False" />
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" Wrap="False" />
</asp:GridView>
    <br />
<asp:GridView ID="gwParteDiario0" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowdatabound="gwParteDiario0_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="25%" />
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="30%" />
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="25%" />
            </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="5%" />
            </asp:BoundField>
        </Columns>
        <FooterStyle Wrap="False" />
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
    <br />
<asp:GridView ID="gwParteDiario1" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowdatabound="gwParteDiario1_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >            
            <FooterStyle Width="5%" Wrap="False" />
            <HeaderStyle Width="5%" Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller" Width="5%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >            
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller"  Width="10%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >            
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller"  Width="25%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller"  Width="30%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller"  Width="25%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"
                 Font-Size="Smaller"  Width="5%"  Wrap="False"/>
            </asp:BoundField>
        </Columns>
        <FooterStyle Wrap="False" />
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
    <br />
<asp:GridView ID="gwParteDiario2" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowdatabound="gwParteDiario2_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >           
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                 Font-Size="Smaller"  Width="5%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >            
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller" Width="10%"  Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >            
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller" Width="25%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller" Width="30%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                Font-Size="Smaller" Width="25%"  Wrap="False"/>
            </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" 
                 Font-Size="Smaller"  Width="5%" Wrap="False"/>
            </asp:BoundField>
        </Columns>
        <FooterStyle Wrap="False" />
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" Wrap="False" />
</asp:GridView>
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
   
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

