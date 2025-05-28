<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_CuentaCorrientePorVendedor.aspx.cs" Inherits="SintecromNet.Paginas.VT_CuentaCorrientePorVendedor" %>
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
    <h2>Cuenta Corriente <asp:Label ID="Label1" runat="server"></asp:Label></h2>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Cuenta Corriente</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <div style="overflow:auto; width:480px;   float: right; height: 400px;">
            
                        <asp:GridView ID="gwGrilla0" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center" AutoGenerateSelectButton="True" DataKeyNames="Cliente,CodCli,Cliente_ID" OnRowCommand="gwGrilla0_RowCommand" OnRowDataBound="gwGrilla0_RowDataBound" OnSelectedIndexChanged="gwGrilla0_SelectedIndexChanged">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="COD_VENDEDOR" HeaderText="Cod.Vend." />
                            <asp:BoundField DataField="Cliente" HeaderText="Clientes">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Total" HeaderText="Total Pesos" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Codcli" HeaderText="Codcli" Visible="False" />
                            <asp:BoundField DataField="Vencido" DataFormatString="{0:n0}" HeaderText="Vencida Pesos" />
                            <asp:BoundField DataField="Cliente_ID" HeaderText="Cliente_ID" Visible="False" />
                        </Columns>    
                        <HeaderStyle  HorizontalAlign="Center" VerticalAlign="Middle"/>
                          <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />               
                    </asp:GridView>

                             </div>
                        <asp:Chart ID="Chart4" runat="server"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="430px" Height="400px">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{C} #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="Doughnut">
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
                    Text="Vencidos / A Vencer">
                </asp:Title>
            </Titles>
        </asp:Chart>
                        
                    
           
                </div>
            </div>
        </div>
        
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Resumen: <asp:Label ID="lblTitulo" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                       <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label3" runat="server" Text="Valores en Cartera: "></asp:Label>
            <asp:Label ID="Label4" runat="server" Font-Bold="True"></asp:Label>
            
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="GridView2" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center" ShowFooter="True">
       
                
                <Columns>
                    <asp:BoundField DataField="Detalle" HeaderText="Detalle" />
                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
                    </asp:BoundField>
                    <asp:BoundField DataField="FechaVencimiento" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Vencimiento" />
                    <asp:BoundField DataField="Moneda" HeaderText="Moneda" />
                    <asp:BoundField DataField="Importe" DataFormatString="{0:0.00}" HeaderText="Importe" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                   <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="Button1" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button1_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>
                        <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
                            ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
                            ToolTip="Exportar a Excel" Width="45px" ImageAlign="Middle" />
                         <br /> 
                         <br />                                             
            <div style="overflow:auto; height: 150px;">
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="Cliente_ID,Cliente">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Cliente" HeaderText="Cliente">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="MaxCreditoOtorgado" HeaderText="Crédito Otorgado u$s" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Cred_disponible_dolar" HeaderText="Credito Disponible u$s" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:ButtonField CommandName="Cartera"  DataTextField="Cheques" 
                                HeaderText="En Cartera" ButtonType="Button"  DataTextFormatString="{0:n0}" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-primary" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">            
                                <ControlStyle BorderStyle="None" CssClass="btn btn-primary"></ControlStyle>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                            </asp:ButtonField>
                            <%--<asp:BoundField DataField="Cheques" DataFormatString="{0:n0}" HeaderText="En Cartera " />--%>
                            <asp:BoundField DataField="TipoPAgo" HeaderText="Tipo de Pago">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PROMEDIO_DOLAR" HeaderText="Promedio Pago" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Total" DataFormatString="{0:n0}" HeaderText="Total  $" />
                            <asp:BoundField DataField="Vencido" DataFormatString="{0:n0}" HeaderText="Vencido $" />
                            <asp:BoundField DataField="Cliente_ID" HeaderText="Cliente_ID" Visible="False" />
                        </Columns>  
                             <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                          <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />               
                                       
                    </asp:GridView>
                
                     </div>
                    </div>
           
                </div>
            <div class="panel-heading"><h4>Detalle: <asp:Label ID="Label2" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                      
                        <asp:ImageButton ID="ImgExcel2" runat="server" CssClass="form-control"  
                            ImageUrl="~/Images/exc.jpg" onclick="ImgExcel2_Click" style="margin-top: 0px; top: 0px; left: 0px;" 
                            ToolTip="Exportar a Excel" Width="45px" ImageAlign="Middle" />
                       
                         <br />
                        <br /> 
                           
            <div style="overflow:auto; height: 400px;">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Transaccion" HeaderText="Factura">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="OrdenCompraCliente" HeaderText="Orden Compra" />
                            <asp:BoundField DataField="FechaVencimiento" HeaderText="Fecha Vencimiento">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaRemito" HeaderText="Fecha Remito">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Cotización" HeaderText="Cotización" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Saldo" HeaderText="Total $" DataFormatString="{0:n0}">
                            </asp:BoundField>
                            <asp:BoundField DataField="Vencido" DataFormatString="{0:n0}" HeaderText="Vencida $" />
                        </Columns> 
                             <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                          <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />               
                                        
                    </asp:GridView>
                     </div>
                    </div>
           
                </div>
        </div> 
        

        </div>
        </form>
</asp:Content>

