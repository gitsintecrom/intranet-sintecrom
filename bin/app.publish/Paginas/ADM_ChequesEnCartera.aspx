<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_ChequesEnCartera.aspx.cs" Inherits="SintecromNet.Paginas.ADM_ChequesEnCartera" %>
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
    <h2>Cheques en Cartera</h2>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Cheques Por Vencimiento</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                       

   
        <asp:Chart ID="Chart4" runat="server" class="img-responsive"  BackColor="0, 51, 102" 
            BackGradientStyle="Center" Palette="SeaGreen" Width="800px" OnClick="Chart4_Click">
                      
            <Series>
                <asp:Series ChartArea="ChartArea1" Name="Series1" ToolTip="#VAL{C} #VALX" YValuesPerPoint="2" PostBackValue="#VALX">
                </asp:Series>
            </Series>
                      
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">                    
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Cheques En Cartera">
                </asp:Title>
            </Titles>
        </asp:Chart>
        <asp:Label ID="Label10" runat="server" CssClass="form-control" Text="Cheques En Cartera"  Width="160px" align="Center" BackColor="#3379B6" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblSaldoChequesCartera" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                    </div>
           
                </div>
        </div>

         
     <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="True" ImageAlign="Middle" />


        
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle Cheques en Cartera <asp:Label ID="lblTitulo" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                      <br />

  

                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center" Visible="False">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
    

 
                        <Columns>
                            <asp:BoundField DataField="Banco" HeaderText="Banco">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaVen" HeaderText="Fecha Vto." DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipovalor" HeaderText="Tipo Valor">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="ValorImporte" HeaderText="Importe" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="RazonSocial" HeaderText="Cliente">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                        </Columns>   
                    <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                                               
                    </asp:GridView>

                    </div>
           
                </div>
        </div> 

        

        </div>
        </form>
</asp:Content>

