<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DIR_Cobranzas.aspx.cs" Inherits="SintecromNet.Paginas.DIR_Cobranzas" %>
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
    <h2>Evolución Cobranzas</h2>
   
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>                    
                        <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="100px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" 
                        TargetControlID="TextBoxIni" Mask="99/99/9999" CultureName="es-AR" 
                        UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                       
                        <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Fecha Hasta:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>                    
                        <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" Width="100px"></asp:TextBox>
                   
                        <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" PromptCharacter="_" 
                        TargetControlID="TextBoxFin" 
                        Mask="99/99/9999">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                                            
                        <asp:Button ID="ButtonVer" runat="server" CssClass="form-control" onclick="ButtonVer_Click" 
                        Text="Buscar" BackColor="#0099CC" Font-Bold="False" ForeColor="White" Height="30px" 
                        style="text-align: center; top: 0px; left: 29px;" Width="122px"  />
                    </div>
           
                </div>
        </div>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Totales Cobranzas</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                       <asp:Label ID="lblTextoMes" runat="server" CssClass="form-control" 
                        Text="Total Acumulado Mes:" Width="270px" BackColor="#003366" ForeColor="White"></asp:Label>
                        <asp:Label ID="lblAcumuladoMes" runat="server" CssClass="form-control" Width="150px"></asp:Label>                       
                        <asp:Label ID="lblPromediol" runat="server" CssClass="form-control"
                        Text="Promedio Por Día del Mes:" Width="270px" BackColor="#003366" ForeColor="White"></asp:Label>
                        <asp:Label ID="lblPromedio" runat="server" CssClass="form-control" Width="150px"></asp:Label>
                        <br />   
                        <asp:Label ID="lblTexto" runat="server" CssClass="form-control"  
                        Text="Total Acumulado Rango:" Width="270px" BackColor="#003366" ForeColor="White" Visible="False"></asp:Label>
                        <asp:Label ID="lblAcumulado" runat="server" CssClass="form-control"  Width="150px" Visible="False"></asp:Label>                        
                        <asp:Label ID="lblTexto0" runat="server" CssClass="form-control"
                        Text="Acumulado Rango Mes Anterior:" Width="270px" ForeColor="White" Visible="False" BackColor="#003366"></asp:Label>                    
                        <asp:Label ID="lblAcumuladoMesA" runat="server" CssClass="form-control"
                         Text="Label" Width="150px" Visible="False"></asp:Label>   
                        <br />   
                        <asp:Label ID="lblPromediol0" runat="server"  CssClass="form-control"
                        Text="Promedio Por Día del Mes Anterior:"  Width="270px" ForeColor="White" Visible="False" BackColor="#003366"></asp:Label>
                        <asp:Label ID="lblPromedioMesA" runat="server" CssClass="form-control" Width="150px" Visible="False"></asp:Label>                                        
                        <asp:Label ID="lblTexto1" runat="server" CssClass="form-control" 
                        Text="Acumulado Rango Año Anterior:" Width="270px" ForeColor="White" Visible="False" BackColor="#003366"></asp:Label>
                        <asp:Label ID="lblAcumuladoAno" runat="server"  CssClass="form-control"  Width="150px" Visible="False"></asp:Label>   
                        <br />                     
                        <asp:Label ID="lblPromediol1" runat="server" CssClass="form-control"  
                        Text="Promedio Por Día del Año Anterior:"  ForeColor="White" Visible="False" Width="270px" BackColor="#003366"></asp:Label>
                         <asp:Label ID="lblPromedioAnoA" runat="server"  CssClass="form-control"  Width="150px" Visible="False"></asp:Label>
                        <br />


                    </div>
           
                </div>
        </div> 
        <asp:Panel ID="Panel1" runat="server" Visible="False">
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle Cobranzas</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                      <br />
                                       
         
                <span style ="float:left;">
                      
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="True" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
                        </span>
                 
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center" Visible="False">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="NumeroRecibo" HeaderText="Numero Recibo">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaPromedio" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Promedio" />
                            <asp:BoundField DataField="Cliente" HeaderText="Cliente">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Importe_Pesos" HeaderText="Importe" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                        </Columns>                      
                    </asp:GridView>

                    </div>
           
                </div>
        </div> 

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Evolución</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
           <asp:Chart ID="Chart1" runat="server" Width="712px" BackColor="Maroon" 
            BackGradientStyle="Center" Palette="Chocolate" Visible="False">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                    Text="Evolución Cobranzas Por Rango Seleccionado">
                </asp:Title>
            </Titles>
        </asp:Chart>
    <br />
        <asp:Chart ID="Chart2" runat="server" Width="712px" BackColor="Maroon" 
            BackGradientStyle="Center" Palette="SemiTransparent" Visible="False">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                    Text="Evolución Cobranzas Mes Anterior Por Rango Seleccionado">
                </asp:Title>
            </Titles>
        </asp:Chart>
    <br />
        <asp:Chart ID="Chart3" runat="server" Width="712px" BackColor="Maroon" 
            BackGradientStyle="Center" Palette="SeaGreen" Visible="False">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1">
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1">
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="Maroon" ForeColor="White" Name="Title1" 
                    Text="Evolución Cobranzas Año Anterior Por Rango Seleccionado">
                </asp:Title>
            </Titles>
        </asp:Chart>
                    </div>
           
                </div>
        </div>
            </asp:Panel>

        </div>
        </form>
</asp:Content>

