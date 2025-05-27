<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_CompraInsumosAnual.aspx.cs" Inherits="SintecromNet.Paginas.COM_CompraInsumosAnual" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro Actualizar el Reclamo?')) return false;
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
    <h2>Compras de Insumos Anuales por Proveedor</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
        
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="Proveedores" 
                    OnRowCommand="gwGrilla_RowCommand" OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged" OnRowDataBound="gwGrilla_RowDataBound">
        <Columns>
           
            <asp:BoundField DataField="Proveedores" HeaderText="Proveedores" />
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:0.00}" />

            <asp:ButtonField ButtonType="Button" CommandName="Detalle" HeaderText="Ver Detalle" ControlStyle-CssClass="btn btn-info" Text="Ver Detalle" >
<ControlStyle CssClass="btn btn-info"></ControlStyle>
            </asp:ButtonField>

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
               <%-- <br />
                <br />
                <br /> --%> 
        
              
    <asp:Panel ID="Panel1" runat="server" 
        Width="650px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke"  
    ForeColor="#999999" Visible="False" >
    
        <asp:Label ID="Label1" runat="server" CssClass="form-control"  ForeColor="White" Width="650px" style="text-align:center"  BackColor="#003366" Font-Bold="True" Font-Size="Medium"></asp:Label>
            
        
        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton1_Click" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
     
        <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
           
            <asp:BoundField DataField="Numero" HeaderText="Numero" />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="Destinatario" HeaderText="Centro de Costos" />
            <asp:BoundField DataField="Detalle" HeaderText="Detalle" />

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView> 
        <br />
        <br />
        <asp:Button ID="Button5" runat="server" onclick="Button5_Click" TabIndex="170" Text="Cerrar" CssClass="btn btn-danger" />
        
        
     
          
        </asp:Panel>

            
        </div>
    </form>
        </asp:Content>

