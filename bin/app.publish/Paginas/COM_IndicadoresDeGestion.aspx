<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_IndicadoresDeGestion.aspx.cs" Inherits="SintecromNet.Paginas.COM_IndicadoresDeGestion" %>
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
        <h2>Requerimientos</h2>
        <asp:Label ID="lblPedido0" runat="server" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Text="Estado:" Width="100px"></asp:Label>
                         <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                                <asp:ListItem Value="Todos">Todos</asp:ListItem>
                                <asp:ListItem Value="NO">Pendiente</asp:ListItem>
                                <asp:ListItem Value="SI">Cumplido</asp:ListItem>
                                </asp:DropDownList>
      <div class="panel panel-primary">
            <div class="panel-heading"><h4>Requerimientos Por Sector</h4></div>
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
           <%-- <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Requerimiento Por Sector">
                </asp:Title>
            </Titles>--%>
        </asp:Chart>
                    </div>
           
                </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Requerimientos Por Proveedor</h4></div>
                <div class="panel-body">                
                    <%--<div class="input-group">--%>
                         <div style="overflow:auto; width: 850px; height: 500px; ">
                    <asp:Chart ID="Chart1" runat="server"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="800px" height="2500px"  OnClick="Chart1_Click"  BackImageAlignment="Center">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{D} #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="StackedBar" IsXValueIndexed="True">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" BackImageAlignment="TopRight" AlignmentStyle="AxesView" AlignmentOrientation="Horizontal">                    
                    <AxisY IntervalAutoMode="VariableCount" IsLabelAutoFit="True">
                        <LabelStyle Font="Microsoft Sans Serif, 6pt" />
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
            <%--<Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Requerimiento Por Proveedor">
                </asp:Title>
            </Titles>--%>
        </asp:Chart>
                             </div>
                    <%--</div>--%>
           
                </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle Requerimientos <asp:Label ID="lblTitulo" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">

         
     <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="True" ImageAlign="Middle" />


         <br />
                      <br />
                        <br />
                         <div style="overflow:auto;  height: 400px;">
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Req_Nombre" HeaderText="Requerimiento">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="nroitemreq" HeaderText="Item">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Req_Codigo" HeaderText="Codigo">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="req_descr" HeaderText="Descripcion">
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Req_UnidadMedida" HeaderText="Unidad Medida" />
                            <asp:BoundField DataField="Oc_Numero" HeaderText="Oc.Numero">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Req_Cant_Solicitada" DataFormatString="{0:0}" HeaderText="Cantidad Solicitada" />
                            
                           </Columns> 
                    <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                                                 
                    </asp:GridView>
                             </div>

                    </div>
           
                </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle Ordenes de Compra <asp:Label ID="Label1" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">

         
     <asp:ImageButton ID="ImageButton1" runat="server" CssClass="form-control" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="ImageButton1_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="True" ImageAlign="Middle" />


         <br />
                      <br />
                        <br />
                         <div style="overflow:auto;  height: 400px;">
                        <asp:GridView ID="gwoc" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="oc_nombre" HeaderText="Orden de Compra">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Proveedor" HeaderText="Proveedor">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="OC_Codigo" HeaderText="Codigo">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="oc_Observaciones" HeaderText="Descripcion">
                            </asp:BoundField>                            
                            <asp:BoundField DataField="oc_UnidadMedida" HeaderText="Unidad Medida" />
                            <asp:BoundField DataField="oc_Cant_Solicitada" HeaderText="Cantidad Solicitada" DataFormatString="{0:0}">
                            </asp:BoundField>
                            
                           </Columns> 
                    <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                                                 
                    </asp:GridView>
                             </div>

                    </div>
           
                </div>
        </div>
 </div>
    </form>
</asp:Content>
