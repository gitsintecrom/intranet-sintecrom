<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MIS_ReqServicios.aspx.cs" Inherits="SintecromNet.Paginas.MIS_ReqServicios" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
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
        <div class="jumbotron">
    <h2>Mis Requerimientos de servicios
    </h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

      
                <asp:GridView ID="gwOCServicios" runat="server" AutoGenerateColumns="False" 
        
                     CssClass="table table-striped table-bordered table-hover"
                    
                    EmptyDataText="Usted No tiene Requerimientos de Servicios Incumplidos" 
                    onrowdatabound="gwOCServicios_RowDataBound" 
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
       
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<asp:HiddenField ID="HiddenFieldError" runat="server" />


        <asp:Panel ID="Panel1" runat="server" Width="800px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999">
             <div class="input-group">
                <asp:Label ID="Label3" runat="server" cssclass="form-control" Text="Orden" ForeColor="White" BackColor="#337AB7" Width="150px"></asp:Label>
                <asp:TextBox ID="txtOrdendeCompra" runat="server" cssclass="form-control" ReadOnly="True" Width="450px"></asp:TextBox>
           
                <br />
                 <br />
           
                <asp:Label ID="Label2" runat="server" cssclass="form-control" Text="% Cumplimiento:" BackColor="#337AB7" ForeColor="White" Width="150px"></asp:Label>
                <asp:TextBox ID="txtPorcentaje" cssclass="form-control" runat="server" Width="66px">0</asp:TextBox>
           
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtPorcentaje" ErrorMessage="Debe Ingresar un Valor" 
                    Font-Names="Arial" Font-Size="10pt" ForeColor="#CC0000" 
                    ValidationGroup="Validar"></asp:RequiredFieldValidator>
          
           <br />
            <br />
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnModificar" runat="server" Enabled="False" 
                onclick="btnModificar_Click" Text="Modificar" ValidationGroup="Validar" CssClass="btn btn-success btn-circle" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
                Text="Cerrar" BackColor="#CC0000" BorderStyle="None" CssClass="btn btn-success btn-circle" />
            <br />
            <br />
                 </div>
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>

         </div>
        </form>
        </asp:Content>

