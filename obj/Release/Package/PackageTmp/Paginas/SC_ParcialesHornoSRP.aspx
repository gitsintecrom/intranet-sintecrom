<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SC_ParcialesHornoSRP.aspx.cs" Inherits="SintecromNet.Paginas.SC_ParcialesHornoSRP" %>
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
        <h2>Operaciones Parciales En Hornos </h2>   
      <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle</h4></div>
                <div class="panel-body">                
                    <div class="input-group">

                        <!-- Pego DIV--> 
     
<asp:ImageButton ID="btnExcel" runat="server" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
   <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="NumeroDocumento" 
                HeaderText="Op.">            
            </asp:BoundField>
            <asp:BoundField DataField="KilosProgramadosEntrantes" DataFormatString="{0:0.00}" 
                HeaderText="Ks.Entr.">            
            </asp:BoundField>
            <asp:BoundField DataField="Kilos_Sobreorden" DataFormatString="{0:0.00}" 
                HeaderText="Ks.SO">          
            </asp:BoundField>
            <asp:BoundField DataField="Nro_Matching" HeaderText="Matching" > 
            </asp:BoundField>
            <asp:BoundField DataField="Operacion_Fecha_Temprana" DataFormatString="{0:dd/MM/yyyy}" HeaderText="F. Acepta">
            </asp:BoundField>
            <asp:BoundField DataField="Origen_Lote" HeaderText="S/L Origen" >           
            
            </asp:BoundField>
            <asp:BoundField DataField="Destino_Lote" HeaderText="S/L Destino">        
           
            </asp:BoundField>
            <asp:BoundField DataField="Clientes" HeaderText="Clientes" >
           </asp:BoundField>
            <asp:BoundField DataField="Ubicacion" HeaderText="Ubicacion">
            </asp:BoundField>
            <asp:BoundField DataField="Traccion" HeaderText="Tracción">
            </asp:BoundField>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha">
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Hora" HeaderText="Hora">
            </asp:BoundField>
        </Columns>
       
</asp:GridView>
                  

            <br />
                         </div>
                    </div>
          </div>
        </div>


    </form>
    
</asp:Content>

