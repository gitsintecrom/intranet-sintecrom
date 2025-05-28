<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_RequerimientosProduccion.aspx.cs" Inherits="SintecromNet.Paginas.PROD_RequerimientosProduccion" %>
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
    <h2>Informe Requerimientos Produccion</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                        </asp:CalendarExtender>
                        <%--<br />--%>
                        <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Fecha Hasta:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="130px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                        </asp:CalendarExtender>
                       

                        
                        &nbsp;&nbsp;<br />
                        <br />
                        <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Sector:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtSector" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                       
                        <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="Proveedor:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtProveedor" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        &nbsp;<asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Buscar" OnClick="btnBuscar_Click"  />
                    
                    </div>

                    
                </div>
        </div>

       
   <h3>     
<asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="50px" ImageAlign="Middle" Visible="False" />   
          <span style="float:right;"><asp:Label ID="lblTotal" runat="server" CssClass="label label-warning" Visible="False" /></span>
        <span style="float:right;"><asp:Label ID="lblInfo" runat="server" Text="Total Pesos:" CssClass="label label-info" Visible="False" /></span>    
  </h3>
            
             <%--<br />--%>
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" ShowFooter="True" OnRowDataBound="gwGrilla_RowDataBound">
        <Columns>
            <asp:BoundField DataField="NumeroRequerimiento" HeaderText="Nro.Req" />
            <asp:BoundField DataField="ocnumero" HeaderText="Nro.OC" />
            <asp:BoundField DataField="detalle" HeaderText="Detalle" />
            <asp:BoundField DataField="proveedor" HeaderText="Proveedor" />       
            <asp:BoundField DataField="Sector" HeaderText="Sector" />
            <asp:BoundField DataField="Fechaoc" HeaderText="Fecha O.C" DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
             <asp:BoundField DataField="Fechareq" HeaderText="Fecha Req." DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            
            <asp:BoundField DataField="CantidadSolicitada" HeaderText="Cantidad" />
            <asp:BoundField DataField="CostoUnitario" HeaderText="Costo" DataFormatString="{0:0.00}" >
            </asp:BoundField>
            <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:0.00}" >
            </asp:BoundField>

            <asp:BoundField DataField="Moneda" HeaderText="Moneda" />
            <asp:BoundField DataField="Cotizacion" DataFormatString="{0:0.00}" HeaderText="Cotiza" />
            <asp:BoundField DataField="TotalPesos" DataFormatString="{0:0.00}" HeaderText="Total $" />

        </Columns>
       <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <br />
                
                
 
        </div>
    </form>
        </asp:Content>

