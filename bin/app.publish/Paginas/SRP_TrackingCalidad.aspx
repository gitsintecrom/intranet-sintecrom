<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SRP_TrackingCalidad.aspx.cs" Inherits="SintecromNet.Paginas.SRP_TrackingCalidad" %>
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
    <h2>Tracking Calidad</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                        </asp:CalendarExtender>
                        <%--<br />--%>
                        <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Fecha Hasta:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="130px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                        </asp:CalendarExtender>
                    </div>

                    <div class="input-group">
                        <asp:Label ID="Label3" runat="server" CssClass="form-control" Text="Serie/Lote:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtBSerie" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        <%--<br />--%>
                        <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Dictamen:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               
                        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" Width="130px">
                        <asp:ListItem Value="9">--Seleccione</asp:ListItem>
                        <asp:ListItem Value="0">Pendiente</asp:ListItem>
                        <asp:ListItem Value="1">Aprobado</asp:ListItem>
                        <asp:ListItem Value="2">Rechazado</asp:ListItem>
                        <asp:ListItem Value="9">Todos</asp:ListItem>
                        </asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click" BackColor="#337AB7"  />
                    </div>
                </div>
        </div>



<asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="50px" Visible="False" ImageAlign="Middle" />
            <br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" DataKeyNames="SLOriginal,SLCalidad,NotaProduccion,NotaCalidad">
        <Columns>
            
            <asp:BoundField DataField="SLOriginal" HeaderText="S/L Original" />
            <asp:BoundField DataField="SLCalidad" HeaderText="S/L Calidad" />
            <asp:BoundField DataField="Familia" HeaderText="Flia" />
            <asp:BoundField DataField="Defecto" HeaderText="Def." />
            <asp:BoundField DataField="Gravedad" HeaderText="Grav." />
            <asp:BoundField HeaderText="Ubic." DataField="Ubicacion" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Kilos" HeaderText="Kilos">
            </asp:BoundField>
            <asp:BoundField DataField="Tarea" HeaderText="Tarea" />
            <asp:BoundField DataField="Dictamen" HeaderText="Dictamen"></asp:BoundField>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha " DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Clientes" HeaderText="Clientes"></asp:BoundField>
            <asp:BoundField DataField="Atados" HeaderText="Atados" Visible="False"></asp:BoundField>
            <asp:BoundField DataField="Rollos" HeaderText="Rol/Hoj"></asp:BoundField>
            <asp:BoundField DataField="Operacion_TotalAncho" HeaderText="Ancho" DataFormatString="{0:0.00}"></asp:BoundField>
            <asp:BoundField DataField="Espesor" HeaderText="Espesor" DataFormatString="{0:0.00}"></asp:BoundField>

            <asp:BoundField DataField="NotaProduccion" HeaderText="NotaProduccion" Visible="False" />
            <asp:BoundField DataField="NotaCalidad" HeaderText="NotaCalidad" Visible="False" />

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <br />
                <asp:GridView ID="gwGrilla0" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos" Visible="False">
        <Columns>
            <asp:BoundField DataField="SLOriginal" HeaderText="S/L Original" />
            <asp:BoundField DataField="SLCalidad" HeaderText="S/L Calidad" />
            <asp:BoundField DataField="Familia" HeaderText="Familia" />
            <asp:BoundField DataField="Defecto" HeaderText="Defecto" />
            <asp:BoundField DataField="Gravedad" HeaderText="Gravedad" />
            <asp:BoundField HeaderText="Ubicacion" DataField="Ubicacion" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Kilos" HeaderText="Kilos">
            </asp:BoundField>
            <asp:BoundField DataField="Tarea" HeaderText="Tarea" />
            <asp:BoundField DataField="Dictamen" HeaderText="Dictamen"></asp:BoundField>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha " DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Clientes" HeaderText="Clientes"></asp:BoundField>
            <asp:BoundField DataField="Atados" HeaderText="Atados"></asp:BoundField>
            <asp:BoundField DataField="Rollos" HeaderText="Rollos/Hojas"></asp:BoundField>
            <asp:BoundField DataField="Operacion_TotalAncho" HeaderText="Ancho" DataFormatString="{0:0.00}"></asp:BoundField>
            <asp:BoundField DataField="Espesor" HeaderText="Espesor" DataFormatString="{0:0.00}"></asp:BoundField>

            <asp:BoundField DataField="NotaProduccion" HeaderText="NotaProduccion" />
            <asp:BoundField DataField="NotaCalidad" HeaderText="NotaCalidad" />

        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <asp:Panel ID="Panel2" runat="server" CssClass="form-control"   BackColor="#337AB7" BorderStyle="Solid" BorderWidth="1" style="text-align: left" Visible="False" height="450px" Width="600px" >
<%--<div style="text-align: center; width: 800px; height: 50px; background-color: #000000;">
                        <h3 style="color: #FFFFFF;">Detalles</h3>                           
                       
                    </div>--%>
                    <h3 style="color: #FFFFFF;">Detalles</h3>
                    <br />
                     <div class="input-group">
                        <asp:Label ID="Label8" runat="server" CssClass="form-control" Text="S/L Original:" Width="150px"></asp:Label>
                        <asp:TextBox ID="txtSerieO" runat="server" CssClass="form-control" ReadOnly="True" Width="350px"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="S/L Calidad:" Width="150px"></asp:Label>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control" ReadOnly="True" Width="350px"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Label ID="Label11" runat="server" CssClass="form-control" Text="S/L Calidad:" Width="150px"></asp:Label>
                        <asp:TextBox ID="txtSerieC" runat="server" CssClass="form-control" ReadOnly="True" Width="350px"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Label ID="Label10" runat="server"  CssClass="form-control" Text="Nota Producción:" Width="150px"></asp:Label>
                        <asp:TextBox ID="txtNotaP" runat="server" CssClass="form-control" ReadOnly="True" Width="350px" TextMode="MultiLine"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Label ID="Label12" runat="server" CssClass="form-control" Text="Nota Calidad:" Width="150px"></asp:Label>
                        <asp:TextBox ID="txtNotaC" runat="server" CssClass="form-control" ReadOnly="True" TextMode="MultiLine" Width="350px"></asp:TextBox>
                    
                     </div>
                    <br />
                    <br />
                        <asp:Button ID="Button6" runat="server" CssClass="form-control" Width="70px" onclick="Button2_Click1" TabIndex="170" Text="Cerrar" />
                                       
                    <br />
                </asp:Panel>
 
        </div>
    </form>
        </asp:Content>

