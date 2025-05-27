<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_InsumosPendientes.aspx.cs" Inherits="SintecromNet.Paginas.COM_InsumosPendientes" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script>
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
        <h2>Insumos Pendientes</h2>
      <div class="panel panel-primary">
            <div class="panel-heading"><h4>Pendiente Por Fecha</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                    <asp:Chart ID="Chart4" runat="server"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="900px" OnClick="Chart4_Click">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{D} #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="StackedColumn">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">                    
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Pendiente Por Fecha">
                </asp:Title>
            </Titles>
        </asp:Chart>
                    </div>
           
                </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Pendiente Por Proveedor</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                    <asp:Chart ID="Chart1" runat="server"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="900px" OnClick="Chart1_Click">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{D} #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="StackedColumn">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">                    
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Pendiente Por Proveedor">
                </asp:Title>
            </Titles>
        </asp:Chart>
                    </div>
           
                </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle <asp:Label ID="lblTitulo" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                      <br />
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="OrdenCompra" HeaderText="Nro. OC">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaEntrega" HeaderText="Fecha Entrega" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Espesor" HeaderText="Espesor">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Ancho" HeaderText="Ancho" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Producto" HeaderText="Detalle">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="CantidadOriginal" DataFormatString="{0:0.00}" HeaderText="Cant.Original" />
                            <asp:BoundField DataField="CantidadPendiente" DataFormatString="{0:0.00}" HeaderText="Pendiente" />
                            <asp:BoundField DataField="ProximaEntrega" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Prox.Entrega" />
                            <asp:BoundField DataField="Tipo"  HeaderText="Tipo" />
                            <asp:BoundField DataField="Observacion"  HeaderText="Observacion" />
                            
                           </Columns>                      
                    </asp:GridView>

                    </div>
           
                </div>
        </div>
 </div>
    </form>
</asp:Content>
