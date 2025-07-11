<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DIR_DetalleFacturacion.aspx.cs" Inherits="SintecromNet.Paginas.DIR_DetalleFacturacion" %>
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
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
    <h2>Facturación <asp:Label ID="lblTitulo" runat="server"></asp:Label></h2>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Gráficos</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
           <asp:Chart ID="Chart1" runat="server" Width="420px" BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Height="350px" ImageStorageMode="UseImageLocation">
            <Series>
                <asp:Series ChartType="Doughnut" Name="Series1" Legend="Legend1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" IsSameFontSizeForAllAxes="True">
                    <AxisY Title="Dolares">
                    </AxisY>
                    <AxisX MaximumAutoSize="50" IsLabelAutoFit="False">
                        <LabelStyle Angle="2" TruncatedLabels="True" />
                    </AxisX>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
               <Legends>
                   <asp:Legend BackColor="LightSkyBlue" BackGradientStyle="Center" LegendStyle="Column" Name="Legend1" Title="Dolares Por Familia">
                       <CellColumns>
                           <asp:LegendCellColumn Alignment="TopLeft" HeaderAlignment="Near" HeaderText="Familia" Name="Column1">
                               <Margins Left="15" Right="15" />
                           </asp:LegendCellColumn>
                           <asp:LegendCellColumn HeaderText="Dolares" Name="Column2" Text="#VAL{D}" Alignment="MiddleRight">
                               <Margins Left="15" Right="15" />
                           </asp:LegendCellColumn>
                       </CellColumns>
                   </asp:Legend>
               </Legends>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Facturación Por Familia Dolares">
                </asp:Title>
            </Titles>
        </asp:Chart>
    &nbsp;
                           <asp:Chart ID="Chart4" runat="server" Width="420px" BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Height="350px" ImageStorageMode="UseImageLocation">
            <Series>
                <asp:Series ChartType="Doughnut" Name="Series1" Legend="Legend1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" BackColor="White">
                    <AxisY Title="Pesos">
                    </AxisY>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
               <Legends>
                   <asp:Legend BackColor="LightSkyBlue" BackGradientStyle="Center" LegendStyle="Column" Name="Legend1" Title="Kilos Por Familia">
                       <CellColumns>
                           <asp:LegendCellColumn Alignment="TopLeft" HeaderAlignment="Near" HeaderText="Familia" Name="Column1">
                               <Margins Left="15" Right="15" />
                           </asp:LegendCellColumn>
                           <asp:LegendCellColumn HeaderText="Kilos" Name="Column2" Text="#VAL{D}" Alignment="MiddleRight">
                               <Margins Left="15" Right="15" />
                           </asp:LegendCellColumn>
                       </CellColumns>
                   </asp:Legend>
               </Legends>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Facturación Por Familia Kilos">
                </asp:Title>
            </Titles>
        </asp:Chart>
                        <br />
                        <br />
        <asp:Chart ID="Chart2" runat="server" Width="844px" BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1" YValuesPerPoint="2" ToolTip="#VAL{C}" PostBackValue="#VALX">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                    <AxisX IntervalAutoMode="VariableCount" IsLabelAutoFit="False">
                        <LabelStyle Angle="90" />
                    </AxisX>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Facturación por Vendedor en Dolares">
                </asp:Title>
            </Titles>
        </asp:Chart>
    <br />
                    </div>
           
                    <br />
           
                </div>
        </div>
        
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle Facturación</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                                                
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
  
                      
                      <br />
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" allowpaging="False" HorizontalAlign="Center" Visible="False">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Numero_documento" HeaderText="Numero">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Cliente" HeaderText="Cliente">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Calidad" HeaderText="Calidad">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Supra_Familia" HeaderText="Familia">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Pesos" HeaderText="Pesos" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Dolares" HeaderText="Dolares" DataFormatString="{0:0.00}">
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

