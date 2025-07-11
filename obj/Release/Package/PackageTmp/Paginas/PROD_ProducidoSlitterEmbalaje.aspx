<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_ProducidoSlitterEmbalaje.aspx.cs" Inherits="SintecromNet.Paginas.PROD_ProducidoSlitterEmbalaje" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Autorizar el Traslado?')) return false;
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
        <!-- Main component for a primary marketing message or call to action -->
            <div class="jumbotron">

    <h2>Producido Slitter a Embalaje</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="140px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                        </asp:CalendarExtender>
                        <%--<br />--%>
                        <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Fecha Hasta:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="140px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                        </asp:CalendarExtender>
                         <br />
                         <br />
                        <asp:Label ID="Label4" runat="server" Text="Familia"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="130px"></asp:Label>
                        <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="140px">
                        </asp:DropDownList>

                        
                        <asp:Label ID="Label5" runat="server" Text="Máquina"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="130px"></asp:Label>
                        <asp:DropDownList ID="ddMaquina" runat="server" CssClass="form-control" Width="140px">
                            <asp:ListItem Value="ALL">Seleccione</asp:ListItem>
                            <asp:ListItem Value="SL1">Slitter 1</asp:ListItem>
                            <asp:ListItem Value="SL2">Slitter 2</asp:ListItem>
                        </asp:DropDownList>

                        
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span>&nbsp;Buscar</asp:LinkButton>

                        <%--<asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click"  />--%>
                    
                    </div>

                    
                </div>
        </div>



<%--<asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="50px" ImageAlign="Middle" Visible="False" />--%>
   <%-- <ul class="nav navbar-nav navbar-right"> 
                       
                    <%--<li class="active"><a class="fa fa-home fa-2x" style="color: #FFFFFF; background-color: #CC3300;" href="..//ContentPage.aspx"></a></li>--%> 
                                                                  
       
   <%--</ul>--%>
    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>

                <br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" ShowFooter="True">
        <Columns>
            
            <asp:BoundField DataField="Fechareg" HeaderText="Fecha " DataFormatString="{0:dd/MM/yyyy}" >
            <ItemStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Maquina" HeaderText="Maquina" />
            
            <asp:BoundField DataField="Codigo_ProductoS" HeaderText="Cod.Producto" />
            <asp:BoundField DataField="Familia" HeaderText="Familia" />
            <asp:BoundField DataField="Kilos_Sobreorden" HeaderText="Kilos" DataFormatString="{0:0.00}" >
            </asp:BoundField>

        </Columns>
       <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <FooterStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle" />               
        <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <br />
                
                
 
        </div>
    </form>
        </asp:Content>

