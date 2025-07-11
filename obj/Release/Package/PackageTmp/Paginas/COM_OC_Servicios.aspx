<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_OC_Servicios.aspx.cs" Inherits="SintecromNet.Paginas.COM_OC_Servicios" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
  
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
     <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
    <h2>Requerimientos de Servicios
        </h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle</h4></div>
                <div class="panel-body">              
                    <asp:GridView ID="gwOCServicios" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No Existen Requerimientos de Servicios Incumplidos" 
                    onrowdatabound="gwOCServicios_RowDataBound" cssclass="table table-striped table-bordered table-hover"
                    AutoGenerateSelectButton="True" onrowcommand="gwOCServicios_RowCommand" 
                    onselectedindexchanged="gwOCServicios_SelectedIndexChanged" 
                    DataKeyNames="IDMODI">
        <Columns>
            <asp:BoundField HeaderText="Orden de Compra" DataField="Nombre_OC" >            
            </asp:BoundField>
            <asp:BoundField DataField="Denominacion_Destinatario" HeaderText="Destinatario">            
            </asp:BoundField>
            <asp:BoundField DataField="Solicitante" HeaderText="Solicitante" >            
            </asp:BoundField>
            <asp:BoundField DataField="Nota" HeaderText="Nota" >           
            </asp:BoundField>
            <asp:BoundField DataField="FECHAENTREGA" HeaderText="Fecha Entrega" 
                DataFormatString="{0:dd/MM/yyyy}" >            
            </asp:BoundField>
            <asp:BoundField DataField="Detalle" HeaderText="Detalle">            
            </asp:BoundField>
            <asp:BoundField DataField="Porcentaje" DataFormatString="{0:0.00}" 
                HeaderText="% Cumplido">            
            </asp:BoundField>
            <asp:BoundField DataField="IDMODI" HeaderText="IDMODI" Visible="False" />
        </Columns>        
</asp:GridView>
                    
                </div>
        </div>

                
         <asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="300px" Width="800px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999">
            <h2>
                <asp:Label ID="Label3" runat="server" Text="Orden "></asp:Label>
                <asp:TextBox ID="txtOrdendeCompra" runat="server" ReadOnly="True" Width="700px"></asp:TextBox>
            </h2> 
            <h2>
                <asp:Label ID="Label2" runat="server" Text="% Cumplimiento:"></asp:Label>
                <asp:TextBox ID="txtPorcentaje" runat="server" Width="65px">0</asp:TextBox>
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
        </div>
         </form>
</asp:Content>

