<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PROD_AjusteInventarioSRP.aspx.cs" Inherits="SintecromNet.Paginas.PROD_AjusteInventarioSRP" %>
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
    <h2>Ajuste De Inventario Generado por el SRP </h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
   
    <br />
    
    <div style="width: 449px; float: left; height: 202px;">
        <asp:Panel ID="Panel4" runat="server" BorderStyle="Outset" BorderWidth="3px" Height="169px" HorizontalAlign="Center" Width="400px" BackColor="#EEEEEE">
            <br />
            <asp:Label ID="Label4" runat="server" Text="Fecha Desde:" Width="100px"></asp:Label>
            <asp:TextBox ID="TextBoxIni" runat="server" style="text-align: center" Width="100px"></asp:TextBox>
            <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
            </asp:MaskedEditExtender>
            <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
            </asp:CalendarExtender>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Fecha Hasta:" Width="100px"></asp:Label>
            <asp:TextBox ID="TextBoxFin" runat="server" style="text-align: center" TabIndex="10" Width="100px"></asp:TextBox>
            <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" AutoComplete="False" Mask="99/99/9999" MaskType="Date" PromptCharacter="_" TargetControlID="TextBoxFin">
            </asp:MaskedEditExtender>
            <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
            </asp:CalendarExtender>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Serie/Lote:" Width="100px"></asp:Label>
            <asp:TextBox ID="txtSerie" runat="server" style="text-align: center" Width="100px"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="btnVer0" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="#620000" Font-Bold="False" ForeColor="White" Height="28px" 
                        style="text-align: center" TabIndex="50" Width="100px"  />
        </asp:Panel>
        <br />
    </div>
    <br />
&nbsp;<br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
<br />
<asp:ImageButton ID="btnExcel" runat="server" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
    <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        Width="100%">
        <Columns>
            <asp:BoundField DataField="Serie_Lote" HeaderText="Serie/Lote" >
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="15%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Nro_Batch" HeaderText="Nro_Batch" >
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="10%" Wrap="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Operacion" 
                HeaderText="Operacion">
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="20%" Wrap="True" />
            </asp:BoundField>
            <asp:BoundField DataField="Importe" HeaderText="Importe" DataFormatString="{0:0.00}">
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="10%" Wrap="True" />
            </asp:BoundField>
            <asp:BoundField DataField="KilosTeoricos" DataFormatString="{0:0.00}" 
                HeaderText="Kilos Teoricos">
            <FooterStyle Wrap="False" />
            <HeaderStyle Wrap="False" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller" 
                Width="10%" Wrap="False" />
            </asp:BoundField>
            <asp:BoundField DataField="Kilos_Reales" DataFormatString="{0:0.00}" 
                HeaderText="Kilos Reales">
            <ItemStyle Font-Size="Smaller" HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="AjusteInventario" DataFormatString="{0:0.00}" HeaderText="Ajuste Inventario" >
            <ItemStyle Font-Size="Smaller" HorizontalAlign="Center" VerticalAlign="Middle" Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha ">
            <ItemStyle Font-Size="Smaller" HorizontalAlign="Center" VerticalAlign="Middle" Width="15%" />
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

