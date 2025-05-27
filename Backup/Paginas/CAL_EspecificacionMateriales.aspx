<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CAL_EspecificacionMateriales.aspx.cs" Inherits="SintecromNet.Paginas.CAL_EspecificacionMateriales" %>
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
    <h2>Especificación Técnica de Materiales<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h2>
<table style="width:600px;">
        <tr>
            <td align="center" valign="middle">
                <asp:ImageButton ID="imgAlta" runat="server" ImageUrl="~/Images/add.gif" 
                    onclick="imgAlta_Click" style="width: 16px" />
&nbsp; Ingresar un Una Nueva Definición de Defecto</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" 
                    DataKeyNames="ID" Width="600px">
        <Columns>
            <asp:BoundField HeaderText="Familia" DataField="Familia" >
            <ItemStyle Font-Names="Arial" Font-Size="10pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="50px" />
            </asp:BoundField>
            <asp:BoundField DataField="Codigo" HeaderText="Código" >
            <ItemStyle Font-Names="Arial" Font-Size="10pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="50px" />
            </asp:BoundField>
            <asp:BoundField DataField="Descripcion" HeaderText="Descripción">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="10pt" Width="500px" />
            </asp:BoundField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
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


        <asp:Panel ID="Panel1" runat="server" Height="400px" Width="600px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
            <p>
                <asp:Label ID="Label4" runat="server" Text="Familia" Width="80px"></asp:Label>
                &nbsp;<asp:DropDownList ID="ddFamilia" runat="server" Width="100px">
                </asp:DropDownList>
                &nbsp;</p>
            <p>
                &nbsp;</p>
            <p>
               <asp:Label ID="Label5" runat="server" Text="Cod.Defecto:" Width="80px"></asp:Label>
                <asp:TextBox ID="txtDefecto" runat="server" Width="100px" TabIndex="20" 
                    MaxLength="3"></asp:TextBox>
            </p>
            <p>
                <asp:RequiredFieldValidator ID="rqDefecto" runat="server" 
                    ControlToValidate="txtDefecto" ErrorMessage="El campo no puede estar Vacío" 
                    ValidationGroup="Validar"></asp:RequiredFieldValidator>
                &nbsp;</p>
            <p>
                <asp:Label ID="Label7" runat="server" Text="Defecto:" Width="80px"></asp:Label>
                <asp:TextBox ID="txtDescripcion" runat="server" Width="500px" TabIndex="40" 
                    MaxLength="100"></asp:TextBox>
            </p>
             <p>
                 <asp:RequiredFieldValidator ID="rqDesc" runat="server" 
                     ControlToValidate="txtDescripcion" ErrorMessage="El Campo no puede Estar Vacío" 
                     ValidationGroup="Validar"></asp:RequiredFieldValidator>
                 &nbsp;</p>
            <br />
            <asp:Button ID="btnModificar" runat="server" 
                onclick="btnModificar_Click" Text="Aceptar" ValidationGroup="Validar" 
                TabIndex="160" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
                Text="Cerrar" TabIndex="170" />
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        </asp:Content>

