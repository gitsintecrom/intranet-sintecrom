<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DIR_TableroDireccion.aspx.cs" Inherits="SintecromNet.Paginas.DIR_TableroDireccion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2>Tablero Gerencial&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnRefrescar" runat="server" class="btn btn-success btn-circle" OnClick="btnRefrescar_Click" Text="Refrescar" Visible="True" />
            
        </h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:Timer ID="Timer1" runat="server" Interval="300000" OnTick="Timer1_Tick">
        </asp:Timer>
            <div class="panel panel-primary">
                <div class="panel-heading"><h4>Datos Gerencia Al
                    <asp:Label ID="lblDia" runat="server" Text=""  Width="70px" align="Right"></asp:Label></h4></div>
                <div class="panel-body">
                <asp:Label ID="Label10" runat="server" CssClass="form-control" Text="Cheques En Cartera"  Width="160px" align="Center" BackColor="#3379B6" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblSaldoChequesCartera" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnCheques" runat="server" class="btn btn-info" Visible="True" OnClick="btnCheques_Click" Text="Ver Detalle"/>                
                <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Cobranzas"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblAcumulado" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnCobranzas" runat="server" class="btn btn-info" Visible="True" OnClick="btnCobranzas_Click" Text="Ver Detalle"/> 
                <br />
                <br />
                <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Facturacion $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionP" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label3" runat="server" CssClass="form-control" Text="Facturacion U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionD" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnFacturacion" runat="server" class="btn btn-info" Visible="True" OnClick="btnFacturacion_Click" Text="Ver Detalle"/> 
                 <br />
                <br />
                <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Débitos $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblDebitosP" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label6" runat="server" CssClass="form-control" Text="Débitos U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblDebitosD" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnDebitos" runat="server" class="btn btn-info" Visible="True" OnClick="btnDebitos_Click" Text="Ver Detalle"/>
                <br />
                <br />
                <asp:Label ID="Label8" runat="server" CssClass="form-control" Text="Créditos $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblCreditosP" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label11" runat="server" CssClass="form-control" Text="Créditos U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblCreditosD" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnCreditos" runat="server" class="btn btn-info" Visible="True" OnClick="btnDebCred_Click" Text="Ver Detalle"/> 
                <br />
                <br />
                <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="Pedidos Kilos"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblPedidosKilos" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label9" runat="server" CssClass="form-control" Text="Pedidos U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblPedidosDolares" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnPedidos" runat="server" class="btn btn-info" Visible="True" OnClick="btnPedidos_Click" Text="Ver Detalle"/>
                    
                </div>
                <div class="panel-heading"><h4>Acumulado Mensual Al
                    <asp:Label ID="Label7" runat="server" Text=""  Width="70px" align="Right"></asp:Label></h4></div>
                <div class="panel-body">                
                <asp:Label ID="Label14" runat="server" CssClass="form-control" Text="Cobranzas"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblAcumuladoM" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label12" runat="server" CssClass="form-control" Text="Promedio Diario"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblPromedio" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>                
                <asp:Button ID="btnCobranzasM" runat="server" class="btn btn-info" Visible="True" OnClick="btnCobranzasM_Click" Text="Ver Detalle"/> 
                <br />
                <br />
                <asp:Label ID="Label16" runat="server" CssClass="form-control" Text="Facturacion $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionPM" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label18" runat="server" CssClass="form-control" Text="Facturacion U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionDM" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnFacturacionM" runat="server" class="btn btn-info" Visible="True" OnClick="btnFacturacionM_Click" Text="Ver Detalle"/> 
                 <br />
                <br />
                <asp:Label ID="Label20" runat="server" CssClass="form-control" Text="Débitos $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblDebitosPM" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label22" runat="server" CssClass="form-control" Text="Débitos U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblDebitosDM" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnDebitosM" runat="server" class="btn btn-info" Visible="True" OnClick="btnDebitosM_Click" Text="Ver Detalle"/>
                <br />
                <br />
                <asp:Label ID="Label24" runat="server" CssClass="form-control" Text="Créditos $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblCreditosPM" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label26" runat="server" CssClass="form-control" Text="Créditos U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblCreditosDM" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnCreditosM" runat="server" class="btn btn-info" Visible="True" OnClick="btnCreditosM_Click" Text="Ver Detalle"/> 
                <br />
                <br />                
                <asp:Label ID="Label13" runat="server" CssClass="form-control" Text="Pedidos Kilos"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="Label15" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label17" runat="server" CssClass="form-control" Text="Pedidos U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="Label19" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Button ID="btnPedidosM" runat="server" class="btn btn-info" Visible="True" OnClick="btnPedidosM_Click" Text="Ver Detalle"/>
                </div>
                <div class="panel-heading"><h4>Evolución Anual&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnFacturacionAnual" runat="server" class="btn btn-info" Visible="True" OnClick="btnFacturacionAnual_Click" Text="Ver Detalle"/> 
               
                    </h4></div>
                <div class="panel-body">                
                 
        <asp:Chart ID="Chart1" runat="server" class="img-responsive"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="950px" Height="500px" OnClick="Chart1_Click">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{D} #VALX" YValuesPerPoint="2" PostBackValue="#VALX" ChartType="StackedColumn">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">                    
                    <AxisX IntervalAutoMode="VariableCount" IsLabelAutoFit="False">
                        <LabelStyle Angle="90" Font="Microsoft Sans Serif, 9pt" />
                    </AxisX>
                    <AxisX2 IntervalAutoMode="VariableCount">
                    </AxisX2>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Evolución Facturación Anual en Dolares">
                </asp:Title>
            </Titles>
        </asp:Chart>
                     </div>   
                
            </div>
         
         <br />
        <br />
            
       
                           <%-- <button type="button" class="btn btn-default btn-circle"><i class="fa fa-check"></i>
                            </button>
                            <button type="button" class="btn btn-primary btn-circle"><i class="fa fa-list"></i>
                            </button>
                            <button type="button" class="btn btn-success btn-circle"><i class="fa fa-link"></i>
                            </button>
                            <button type="button" class="btn btn-info btn-circle"><i class="fa fa-check"></i>
                            </button>
                            <button type="button" class="btn btn-warning btn-circle"><i class="fa fa-times"></i>
                            </button>
                            <button type="button" class="btn btn-danger btn-circle"><i class="fa fa-heart"></i>
                            </button>--%>
   
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptSection" runat="server">
</asp:Content>