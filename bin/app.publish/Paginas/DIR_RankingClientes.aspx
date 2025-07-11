<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DIR_RankingClientes.aspx.cs" Inherits="SintecromNet.Paginas.DIR_RankingClientes" %>
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
    <h2>Ranking Clientes</h2>

        <div class="panel panel-primary">
            <div class="panel-heading">
                <div class="input-group">
                        <asp:Label ID="Label2" runat="server" BackColor="#003366" CssClass="form-control" ForeColor="White" Text="Fecha Desde:" Width="130px"></asp:Label>
                        <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="100px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                        </asp:CalendarExtender>
                        <asp:Label ID="Label1" runat="server" BackColor="#003366" CssClass="form-control" ForeColor="White" Text="Fecha Hasta:" Width="130px"></asp:Label>
                        <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" Width="100px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" AutoComplete="False" Mask="99/99/9999" MaskType="Date" PromptCharacter="_" TargetControlID="TextBoxFin">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                        </asp:CalendarExtender>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="ButtonVer" runat="server" cssclass="btn btn-success btn-circle" Font-Bold="False" ForeColor="White" onclick="ButtonVer_Click" style="text-align: center" Text="Buscar" Width="122px" BackColor="SeaGreen" />
                        &nbsp;
                    </div>
                </div>
                <div class="panel-body">                

<%--<asp:ImageButton ID="imgExporta" runat="server" ImageUrl="~/Images/exc.jpg" 
                    onclick="imgAlta_Click"  CssClass="form-control" Height="50px" Width="50px" />--%>
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
                       
                       

    
                    <div style="overflow:auto; Width:950px; vertical-align:top; margin-top:0; text-align: left;">
        <asp:Chart ID="Chart5" runat="server" Width="2000px" BackColor="0, 51, 102" Palette="SeaGreen" Height="500px">
            <Series>
                <asp:Series ChartType="StackedColumn" Name="Series1" YValuesPerPoint="2" ToolTip="#VALX#VAL{C}" PostBackValue="#VALX" Font="Microsoft Sans Serif, 8.25pt">
                </asp:Series>
            </Series>
            <MapAreas>
                <asp:MapArea Coordinates="0,0,0,0" Shape="Circle" />
            </MapAreas>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" AlignmentOrientation="All">
                    <AxisY IntervalAutoMode="VariableCount" IsLabelAutoFit="False">
                        <LabelStyle ForeColor="White" />
                    </AxisY>
                    <AxisX IntervalAutoMode="VariableCount" IsLabelAutoFit="False">
                        <LabelStyle Font="Microsoft Sans Serif, 7pt"  ForeColor="White" Angle="90" />
                    </AxisX>
                    <AxisX2 IntervalAutoMode="VariableCount" IsLabelAutoFit="False">
                        <LabelStyle Font="Microsoft Sans Serif, 7pt" ForeColor="White" />
                    </AxisX2>
                    <AxisY2 IntervalAutoMode="VariableCount" IsLabelAutoFit="False">
                    </AxisY2>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <%--<Titles>
                <asp:Title BackColor="#003366" ForeColor="White" Name="Title1" 
                    Text="Ranking Clientes Por Facturación en Dolares">
                </asp:Title>
            </Titles>--%>
        </asp:Chart>
                     

                        </div>
                    <%--<div style="overflow:auto; Width:850px; Height:850px; vertical-align:top; margin-top:0; text-align: left;">--%>

                        <%--</div>--%>
    
                     

                    
                     
        <asp:Chart ID="Chart6" runat="server" Width="950px" BackColor="0, 51, 102" Palette="SeaGreen" Height="1050px">
            <Series>
                <asp:Series ChartType="Doughnut" Name="Series1" YValuesPerPoint="2" ToolTip="#VALX#VAL{C}" PostBackValue="#VALX" Font="Microsoft Sans Serif, 6pt" CustomProperties="PieLabelStyle=Outside" Label="#VALX #PERCENT{P2} ">
                    <SmartLabelStyle AllowOutsidePlotArea="Yes" CalloutStyle="Box" IsMarkerOverlappingAllowed="True" />
                </asp:Series>
            </Series>
            <MapAreas>
                <asp:MapArea Coordinates="0,0,0,0" Shape="Circle" />
            </MapAreas>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" AlignmentStyle="Position" AlignmentOrientation="All">
                    <AxisY IsLabelAutoFit="False">
                        <LabelStyle ForeColor="White" />
                    </AxisY>
                    <AxisX IsLabelAutoFit="False" TitleAlignment="Near" TitleFont="Microsoft Sans Serif, 4pt">
                        <LabelStyle Font="Microsoft Sans Serif, 4pt"  ForeColor="White" Angle="90" />
                    </AxisX>
                    <AxisX2 IsLabelAutoFit="False" TitleFont="Microsoft Sans Serif, 5.25pt">
                        <LabelStyle Font="Microsoft Sans Serif, 4pt" ForeColor="White" />
                    </AxisX2>
                    <AxisY2 IsLabelAutoFit="False">
                    </AxisY2>
                    <Area3DStyle Enable3D="True" />
                </asp:ChartArea>
            </ChartAreas>
            <Titles>
                <asp:Title BackColor="White" BackGradientStyle="Center" BackHatchStyle="DarkDownwardDiagonal" Font="Microsoft Sans Serif, 14pt, style=Bold" ForeColor="Navy" Name="Title1" Text="Ranking Clientes">
                </asp:Title>
            </Titles>
        </asp:Chart>
    
                     

                    
                     
                </div>
        </div>
        

        </div>
        </form>
</asp:Content>

