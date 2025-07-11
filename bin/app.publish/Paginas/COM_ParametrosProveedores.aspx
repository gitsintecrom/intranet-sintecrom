<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_ParametrosProveedores.aspx.cs" Inherits="SintecromNet.Paginas.COM_ParametrosProveedores" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
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
    <h2>Parametros Proveedores</h2>
    
    <form id="form1" runat="server">
       
    <div class="jumbotron">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    

               
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" 
                    DataKeyNames="ID,Denominacion	,diasbarco" >
        <Columns>
            <asp:BoundField DataField="Codigo" HeaderText="Código" >
            
            </asp:BoundField>
            <asp:BoundField HeaderText="Proveedor" DataField="Denominacion" >           
           
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
           
            </asp:BoundField>
            <asp:BoundField DataField="DIASBARCO" HeaderText="Tiempo Barco">
           
            </asp:BoundField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
        </Columns>
            <HeaderStyle  HorizontalAlign="Center" VerticalAlign="Middle"/>
            <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
           <asp:HiddenField ID="HiddenFieldError" runat="server" />


        <asp:Panel ID="Panel1" runat="server" Height="200px" Width="600px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
             <div class="input-group">
                
                <br />
                <br />            
                <asp:Label ID="Label5" runat="server" Text="Proveedor:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="130px"></asp:Label>
                <asp:TextBox ID="txtProveedor" runat="server" CssClass="form-control" Width="300px" TabIndex="20" ReadOnly="True"></asp:TextBox>           
                <br />
                <br />
                <asp:Label ID="Label7" runat="server" Text="Dias Barco:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="130px"></asp:Label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" Width="300px" TabIndex="40" 
                    MaxLength="4" TextMode="Number"></asp:TextBox>           
                 <asp:RequiredFieldValidator ID="rqDesc" runat="server" 
                     ControlToValidate="txtDescripcion" ErrorMessage="El Campo no puede Estar Vacío" 
                     ValidationGroup="Validar"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <br />
            <asp:Button ID="btnModificar" runat="server" 
                onclick="btnModificar_Click" Text="Aceptar" ValidationGroup="Validar" cssclass="btn btn-success btn-circle"
                TabIndex="160"  Width="130px" />
            &nbsp;
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" cssclass="btn btn-success btn-circle" BackColor="Red"
                Text="Cerrar" TabIndex="170" BorderStyle="None" Width="130px" />
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

