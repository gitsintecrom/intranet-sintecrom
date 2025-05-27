<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Monitor_Incidentes.aspx.cs" Inherits="SintecromNet.Paginas.Monitor_Incidentes" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">    
     function estaseguro() {

         if (!confirm('Esta Seguro de Eliminar el Incidente Seleccionado?')) return false;
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


        .style23
        {
            text-align: left;
        }
        .style21
        {
            width: 154px;
        }
        .align
        {}
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Monitor de incidentes Abiertos<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT [Id], [Nombre] FROM [Responsables] ORDER BY [Id] DESC"></asp:SqlDataSource>
   
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
   
    </h2>
<p>
    <table style="width:100%;">
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
                <asp:ImageButton ID="imgEditar" runat="server" ImageUrl="~/Images/editar.gif" 
                    style="margin-bottom: 0px; height: 16px; width: 16px;" ToolTip="Editar" 
                    onclick="imgEditar_Click" Visible="False" />               
                <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick">
                </asp:Timer>
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
                    <asp:CheckBox ID="CheckBox1" runat="server" />
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
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
            <ControlStyle Width="15%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
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
            <td width="50%">
                <asp:Label ID="Label1" runat="server" Text="Asignar a:" Visible="False" 
                    Width="90px"></asp:Label>
                <asp:DropDownList ID="ddAsignar" runat="server" Width="100px" 
                        DataTextField="Nombre" DataValueField="Nombre" 
                    TabIndex="40" Visible="False">
                </asp:DropDownList>
            </td>
            <td style="text-align: center" width="50%">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50%" colspan="2" style="width: 100%; text-align: center">
        <asp:Button ID="btnAceptar" runat="server" BackColor="Maroon" 
            Font-Names="Arial" ForeColor="White" onclick="btnAceptar_Click" Text="Aceptar" 
            ValidationGroup="Validar" Visible="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnCancelar" runat="server" BackColor="White" 
            Font-Names="Arial" ForeColor="Maroon" onclick="btnCancelar_Click" Text="Cancelar" 
                    Visible="False" style="text-align: left" />
            </td>
        </tr>
        </table>
   
    </p>
    <p>
         <asp:HiddenField ID="HiddenFieldError" runat="server" />

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
&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
    <p>
        &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    </asp:Content>
