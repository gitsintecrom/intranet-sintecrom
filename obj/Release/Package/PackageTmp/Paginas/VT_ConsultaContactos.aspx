<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_ConsultaContactos.aspx.cs" Inherits="SintecromNet.Paginas.VT_ConsultaContactos" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
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
    <h2>Consulta Potenciales Clientes</h2>
            
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
           <asp:ImageButton ID="btnExcel" runat="server" Height="51px" cssclass ="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" ImageAlign="Middle" />
            <br />
                <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="Empresa" HeaderText="Empresa" />
            <asp:BoundField DataField="Contacto" HeaderText="Contacto" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Telefono" HeaderText="Telefono" />
            <asp:BoundField DataField="Celular" HeaderText="Celular" />
            <asp:BoundField DataField="Direccion" HeaderText="Direccion" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
        </Columns>       
</asp:GridView>
                    </div>
           
                </div>
        </div>

   
        </div>
         </form>
        </asp:Content>

