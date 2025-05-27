<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DIR_ProductosDefectuosos.aspx.cs" Inherits="SintecromNet.Paginas.DIR_ProductosDefectuosos" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Segura de ejecutar el Proceso?')) return false;
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
    <h2>Productos Defectuosos</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        
<asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="50px" Visible="False" ImageAlign="Middle" BorderStyle="None" />
    <asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Pendientes" OnClick="btnBuscar_Click" BackColor="#FF5050" BorderStyle="None"  />
    <asp:Button ID="Button1" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Realizados" OnClick="Button1_Click" BorderStyle="None"  />
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblEstado" runat="server" CssClass="form-control"  ForeColor="White" Visible="False" Width="400px" style="text-align:center"  BackColor="#003366" Font-Bold="True" Font-Size="Medium"></asp:Label>
               <br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="ID,Cliente,NUMERO_DOCUMENTO" OnRowCommand="gwGrilla_RowCommand" OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged" OnRowDataBound="gwGrilla_RowDataBound">
        <Columns>
           
            <asp:HyperLinkField DataTextField="Numero_Documento" HeaderText="Factura" />
            <%--<asp:BoundField DataField="Horneada" HeaderText="Horneada" />--%>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}" />

            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <br />
                <br />
                <br />  
        
      <asp:HiddenField ID="HiddenFieldError" runat="server" />          
    <asp:Panel ID="Panel1" runat="server" Height="460px" Width="850px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
        <asp:ImageButton ID="ImageButton1" runat="server" CssClass="form-control"  
    ImageUrl="~/Images/exc.jpg" onclick="ImageButton1_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="50px" ImageAlign="Middle" BorderStyle="None" />
    
        <asp:Label ID="Label1" runat="server" CssClass="form-control"  ForeColor="White" Width="600px" style="text-align:center"  BackColor="#003366" Font-Bold="True" Font-Size="Medium"></asp:Label>
         <div style="overflow:auto; height:350px; ">
        <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" Visible="False">
        <Columns>
           
            <%--<asp:HyperLinkField DataTextField="Horneada" HeaderText="Horneada" />--%>
            <asp:BoundField DataField="NumeroDocumento" HeaderText="Pedido" />
            <asp:BoundField DataField="TipoPedido" HeaderText="Tipo Pedido" />
            <asp:BoundField DataField="Egreso_Nro" HeaderText="Egreso" />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha" />
            <asp:BoundField DataField="Codigo" HeaderText="Producto" />
            <asp:BoundField DataField="Lote_Desc" HeaderText="S/L" />
            <asp:BoundField HeaderText="Kilos" DataField="Kilos" DataFormatString="{0:0.00}" />         
            <asp:BoundField DataField="Importe_Pesos" HeaderText="Pesos" DataFormatString="{0:0.00}" />
           

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
             </div>
     <asp:Button ID="btnEjecutar" runat="server" class="btn btn-success btn-circle" width="130" Text="Ejecutar" OnClick="btnEjecutar_Click" onclientclick="return estaseguro()" BorderStyle="None"  />

        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:Button ID="Button6" runat="server" class="btn btn-success btn-circle" width="130" onclick="Button2_Click1" 
                Text="Cerrar" TabIndex="170" BackColor="#CC3300" BorderStyle="None" />
          
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
        </div>
    </form>
        </asp:Content>

