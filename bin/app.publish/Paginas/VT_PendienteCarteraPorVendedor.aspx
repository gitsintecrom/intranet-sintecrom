<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_PendienteCarteraPorVendedor.aspx.cs" Inherits="SintecromNet.Paginas.VT_PendienteCarteraPorVendedor" %>
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
    <h2>Pedidos En Cartera <asp:Label ID="Label1" runat="server"></asp:Label></h2>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Pendiente Por Cliente</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
   
        <asp:Chart ID="Chart4" runat="server" BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="800px" OnClick="Chart4_Click" Height="500px">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{C} #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="StackedBar">
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
                    Text="ALTE Por Cliente">
                </asp:Title>
            </Titles>
        </asp:Chart>
                        
                    </div>
           
                </div>
        </div>
        
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>En Cartera Por Cliente: <asp:Label ID="lblTitulo" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                      <br />  
                        <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
                            ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
                            ToolTip="Exportar a Excel" Width="45px" ImageAlign="Middle" />
            
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="RazonSocial" HeaderText="Cliente">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                         
                            <asp:BoundField DataField="NumeroPedido" HeaderText="Numero Pedido">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="NroItem" HeaderText="Item" />
                            <asp:BoundField DataField="Producto" HeaderText="Producto">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaAceptada" HeaderText="Fecha Aceptada" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CANTIDADPEDIDO" HeaderText="Cant.Original" DataFormatString="{0:0}">
                            </asp:BoundField>
                            <asp:BoundField DataField="Programado" DataFormatString="{0:0}" HeaderText="Programado"></asp:BoundField>
                            <asp:BoundField DataField="Fabricado" DataFormatString="{0:0}" HeaderText="Fabricado">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>                      
                    </asp:GridView>

                    </div>
           
                </div>
        </div> 

        

        </div>
        </form>
</asp:Content>

