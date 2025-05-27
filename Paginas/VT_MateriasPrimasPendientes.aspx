<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_MateriasPrimasPendientes.aspx.cs" Inherits="SintecromNet.Paginas.VT_MateriasPrimasPendientes" %>
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
        <h2>Materias Primas Pendientes</h2>
      <div class="panel panel-primary">
            <div class="panel-heading"><h4>Por Familia Espesor y Ancho</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                    
                        <div style="overflow:auto;  height: 400px;">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center" OnRowCommand="GridView1_RowCommand">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:ButtonField CommandName="Ver" HeaderText="Ver" ButtonType="Button" Text="Ver"  ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None">            
                            </asp:ButtonField>
                            <asp:BoundField DataField="Familia" HeaderText="Familia">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Espesor" HeaderText="Espesor" DataFormatString="{0:0.00}">
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Aleacion" HeaderText="Aleación" />
                            <asp:BoundField DataField="Temple" HeaderText="Temple" />
                            <asp:BoundField DataField="Ancho" HeaderText="Ancho" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Cantidad_Pendiente" HeaderText="Pendiente" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            
                           </Columns>  
                            <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>                    
                    </asp:GridView>
                            </div>
                    </div>
           
                </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Pendiente Por Fecha</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                    <asp:Chart ID="Chart4" runat="server"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="900px" Height="400px">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{D} " YValuesPerPoint="2" PostBackValue="#VALX" ChartType="StackedColumn">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">                   
                
                    <AxisX IntervalAutoMode="VariableCount">
                    </AxisX>
                    <AxisX2 IntervalAutoMode="VariableCount">
                    </AxisX2>
                
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
            <div class="panel-heading"><h4>Detalle <asp:Label ID="lblTitulo" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        
        
                    <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
                    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
                    ToolTip="Exportar a Excel" Width="50px" ImageAlign="Middle" BorderStyle="None" />
    
                      <br />
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />
                            <asp:BoundField DataField="Origen" HeaderText="Origen" />
                            <asp:BoundField DataField="OrdenCompra" HeaderText="Nro. OC">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaEntrega" HeaderText="F.Entrega Original" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Espesor" HeaderText="Espesor">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Ancho" HeaderText="Ancho" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Producto" HeaderText="Producto">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Calidad" HeaderText="Calidad" />
                            <asp:BoundField DataField="CantidadOriginal" DataFormatString="{0:n0}" HeaderText="Cant.Original" />
                            <asp:BoundField DataField="CantidadPendiente" DataFormatString="{0:n0}" HeaderText="Pendiente" />
                            <asp:BoundField DataField="PisoCredito" DataFormatString="{0:n0}" HeaderText="Kgs.Embarcados" />
                            <asp:BoundField DataField="ProximaEntrega" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Prox.Entrega" />
                            <asp:BoundField DataField="Tipo"  HeaderText="Tipo" />
                            <asp:BoundField DataField="Observacion"  HeaderText="Observacion" />
                            
                           </Columns>
                            <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>                      
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:GridView>

                    </div>
           
                </div>
        </div>
 </div>
    </form>
</asp:Content>
