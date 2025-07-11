<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_ProgresoInventario.aspx.cs" Inherits="SintecromNet.Paginas.INV_ProgresoInventario" %>
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
    <div class="jumbotron">
    <%--<p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>--%>
    <h2>Progreso Inventario Anual </h2>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Progreso</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        
                        <asp:Chart ID="Chart4" runat="server"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="400px" Height="400px" OnClick="Chart4_Click">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="Doughnut">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">                    
                    <AxisY IntervalAutoMode="VariableCount">
                    </AxisY>
                    <AxisX IntervalAutoMode="VariableCount">
                    </AxisX>
                    <AxisX2 IntervalAutoMode="VariableCount">
                    </AxisX2>
                    <AxisY2 IntervalAutoMode="VariableCount">
                    </AxisY2>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Pendientes Por Kilos">
                </asp:Title>
            </Titles>
        </asp:Chart>
                        <asp:Chart ID="Chart1" runat="server"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="400px" Height="400px" OnClick="Chart1_Click">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="Doughnut">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">                    
                    <AxisY IntervalAutoMode="VariableCount">
                    </AxisY>
                    <AxisX IntervalAutoMode="VariableCount">
                    </AxisX>
                    <AxisX2 IntervalAutoMode="VariableCount">
                    </AxisX2>
                    <AxisY2 IntervalAutoMode="VariableCount">
                    </AxisY2>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Pendientes Por Cantidades">
                </asp:Title>
            </Titles>
        </asp:Chart>
                        
                    
           
                </div>
            </div>
        </div>
        
         
        <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle: <asp:Label ID="Label2" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                      
                         <br />
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" OnClick="LinkButton2_Click" Text="" ToolTip="Exportar a Excel" Visible="True"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
                        <br /> 
                           
            <div style="overflow:auto; height: 500px;">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="SL" HeaderText="Serie-Lote">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Deposito" HeaderText="Deposito" DataFormatString="{0:0.00}">
                            </asp:BoundField>
                            <asp:BoundField DataField="CodProducto" HeaderText="Producto">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}">
                            </asp:BoundField>
                        </Columns>                      
                    </asp:GridView>
                     </div>
                    </div>
           
                </div>
        </div>

        </asp:Panel>

        </div>
        </form>
</asp:Content>

