<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CAL_PruebasTraccion.aspx.cs" Inherits="SintecromNet.Paginas.CAL_PruebasTraccion" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Autorizar el Traslado?')) return false;
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
    <h2>Pruebas de Tracción</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">              
                    
                    <div class="input-group">
                        <asp:Label ID="Label3" runat="server" CssClass="form-control" Text="Cliente:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                       
                        <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Aleación:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtAleacion" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        
                        <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Horneada:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtHorneada" runat="server" CssClass="form-control" Width="130px" TextMode="Number">0</asp:TextBox>
                        
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click" BackColor="#337AB7"  />
                    </div>
                </div>
        </div>



<asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="50px" Visible="False" ImageAlign="Middle" />
            <br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="Horneada" OnRowCommand="gwGrilla_RowCommand" OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged" OnRowDataBound="gwGrilla_RowDataBound">
        <Columns>
           
            <asp:HyperLinkField DataTextField="Horneada" HeaderText="Horneada" />
            <%--<asp:BoundField DataField="Horneada" HeaderText="Horneada" />--%>
            <asp:BoundField DataField="Horno" HeaderText="Horno" />
            <asp:BoundField DataField="ClientePedido" HeaderText="Cliente" />
            <asp:BoundField DataField="Aleacion" HeaderText="Aleacion" />
            <asp:BoundField DataField="Temple" HeaderText="Temple" />
            <asp:BoundField DataField="SL" HeaderText="S/L" />
            <asp:BoundField DataField="Kilos_Sobreorden" HeaderText="Kilos" />
            <asp:BoundField DataField="Espesor" HeaderText="Espesor" />
            <asp:BoundField HeaderText="Ancho" DataField="Ancho" />            
            <asp:BoundField DataField="Seccion" HeaderText="Seccion" /> 
            <asp:BoundField DataField="Carga" HeaderText="Carga" />         
            <asp:BoundField DataField="RT" HeaderText="RT" /> 
            <asp:BoundField DataField="Alargamiento" HeaderText="Alargamiento" />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha " DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <br />
                <br />
                <br />  
        
      <asp:HiddenField ID="HiddenFieldError" runat="server" />          
    <asp:Panel ID="Panel1" runat="server" Height="450" Width="850px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
        <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" Visible="False">
        <Columns>
           
            <%--<asp:HyperLinkField DataTextField="Horneada" HeaderText="Horneada" />--%>
            <asp:BoundField DataField="Horneada" HeaderText="Horneada" />
            <asp:BoundField DataField="Nro_Matching" HeaderText="Matching" />
            <asp:BoundField DataField="ClientePedido" HeaderText="Cliente" />
            <asp:BoundField DataField="Aleacion" HeaderText="Aleacion" />
            <asp:BoundField DataField="Temple" HeaderText="Temple" />
            <asp:BoundField DataField="Espesor" HeaderText="Espesor" />
            <asp:BoundField HeaderText="Ancho" DataField="Ancho" />         
            <asp:BoundField DataField="KilosHorneada" HeaderText="Kilos" />
            <asp:BoundField DataField="SL" HeaderText="S/L" />
           

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
        <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
                Text="Cerrar" TabIndex="170" />
          
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
        </div>
    </form>
        </asp:Content>

