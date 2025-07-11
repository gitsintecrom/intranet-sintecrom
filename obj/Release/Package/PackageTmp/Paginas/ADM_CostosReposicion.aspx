<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_CostosReposicion.aspx.cs" Inherits="SintecromNet.Paginas.ADM_CostosReposicion" %>
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
    <h2>Costos Reposición</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
        
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
         <div style="overflow:scroll; width:1020px; ">        
        <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
           
            <asp:BoundField DataField="espintado" HeaderText="Es Pintado" />
            <asp:BoundField DataField="p_t" HeaderText="P_T" />
            <asp:BoundField DataField="supra_familia" HeaderText="Supra_familia" />
            <asp:BoundField DataField="calidad" HeaderText="Calidad" />
            <asp:BoundField DataField="Aleacion" HeaderText="Aleacion" />
            <asp:BoundField DataField="espesornominal" HeaderText="Espesor Nominal" />
            <asp:BoundField DataField="recubrimiento" HeaderText="Recubrimiento" />
            <asp:BoundField DataField="Temple" HeaderText="Temple" />
            <asp:BoundField DataField="tipopedido" HeaderText="tipopedido" />
            <asp:BoundField DataField="anchoenproceso" DataFormatString="{0:0.00}" HeaderText="Ancho en Proceso" />
            <asp:BoundField DataField="producto_cod" HeaderText="Cod.Producto" />

            <asp:BoundField DataField="tipotransaccion" HeaderText="TipoTR" />
            <asp:BoundField DataField="prod_origen" HeaderText="Prod_Origen" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
            <asp:BoundField DataField="fecha_doc" HeaderText="Fecha" />
            <asp:BoundField DataField="numero_documento" HeaderText="Numero" />
            <asp:BoundField DataField="ProdDescrip_Origen" HeaderText="ProdDescrip_Origen" />
            <asp:BoundField DataField="kilos" DataFormatString="{0:0.00}" HeaderText="kilos" />
            <asp:BoundField DataField="ImportePesos" DataFormatString="{0:0.00}" HeaderText="Imp.Pesos" />
            <asp:BoundField DataField="importeoriginal" DataFormatString="{0:0.00}" HeaderText="Imp.Orig" />
            <asp:BoundField DataField="importedolares" DataFormatString="{0:0.00}" HeaderText="Imp.dolares" />

            <asp:BoundField DataField="Operacion" HeaderText="Operación" />

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
               
        </div>
              
    

            
        </div>
    </form>
        </asp:Content>

