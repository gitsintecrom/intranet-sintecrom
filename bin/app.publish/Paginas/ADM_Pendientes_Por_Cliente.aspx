<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_Pendientes_Por_Cliente.aspx.cs" Inherits="SintecromNet.Paginas.ADM_Pendientes_Por_Cliente" %>
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
     <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        
    <h2>Pendientes Por Clientes</h2>
    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">              
                    
                    <div class="input-group">
                         <asp:TextBox ID="txtCliente" runat="server" CssClass = "form-control" Width="200px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtCliente" CssClass="failureNotification" 
                        ErrorMessage="El campo Cliente es obligatorio" ValidationGroup="Validar">*</asp:RequiredFieldValidator>
                        <asp:Button ID="ButtonVer" runat="server" cssclass = "btn btn-success btn-circle" OnClick ="ButtonVer_Click" 
                        Text="Buscar" Font-Bold="False" 
                         ValidationGroup="Validar"  />
                        <br />
                         <br />
                            
   
    <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="50px" Visible="False" ImageAlign="Middle" />
&nbsp;<asp:Label ID="lblTexto" runat="server" Font-Bold="True" Font-Size="Medium" 
        Text="Teléfono:"></asp:Label>
    <asp:Label ID="lblTelefono" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="#336699" Text="Label"></asp:Label>
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label 
        ID="labelEmail" runat="server" Font-Bold="True" Font-Size="Medium" 
        Text="Email:"></asp:Label>
    <asp:Label ID="lblEmail" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="#336699" Text="Label"></asp:Label>
   
    &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    <asp:Label ID="lblTextoSaldo" runat="server" Font-Bold="True" Font-Size="Medium" 
        Text="Saldo:"></asp:Label>
    <asp:Label ID="lblAcumulado" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="#336699" Text="Label"></asp:Label>
                        <asp:GridView ID="gwPendientes" CssClass="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="False"  
        EmptyDataText="La Busqueda no Ha Arrojado Resultados">
        <Columns>
            <asp:BoundField DataField="Operador Comercial" HeaderText="Op. Comercial" >
            
            </asp:BoundField>
             <asp:BoundField DataField="Transaccion" HeaderText="Transaccion" >
            
            </asp:BoundField>
            <%--<asp:BoundField DataField="Transaccion" HeaderText="Transaccion"/>--%>
            <asp:BoundField DataField="Descripcion" HeaderText="Descripción" >
            
            </asp:BoundField>
            <asp:BoundField DataField="Saldo" DataFormatString="{0:0.00}" 
                HeaderText="Saldo $" >           
            </asp:BoundField>
            <asp:BoundField DataField="Importe Total" DataFormatString="{0:0.00}" 
                HeaderText="Importe Orig." >            
            </asp:BoundField>
            <asp:BoundField DataField="Cotización" DataFormatString="{0:0.0000}" 
                HeaderText="Cotización" >
            </asp:BoundField>
            <asp:BoundField DataField="Fecha de Vencimiento" HeaderText="Fecha Vto." >
            </asp:BoundField>
            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" >
            </asp:BoundField>
            <asp:BoundField DataField="Fecha Entrega Remito" 
                HeaderText="Fecha Entrega Remito" >            
            </asp:BoundField>
        </Columns>   
                            <HeaderStyle  Font-Size="8pt" BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>     
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:GridView>
                    </div>
                </div>
        </div>
   

   
    <%--<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT * FROM [Totales_Cobranzas]"></asp:SqlDataSource>--%>
   

   
    <p>
        </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    <p>
        </div>
    </form>
         </asp:Content>

