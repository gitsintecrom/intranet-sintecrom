<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_SeguimientoViajes.aspx.cs" Inherits="SintecromNet.Paginas.PROD_SeguimientoViajes" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
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
       
    <div class="jumbotron">
    <h2>Seguimiento Viajes</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">              
                    
                    <div class="input-group">
                         <asp:Label ID="labelRes0" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                           <asp:Label ID="labelRes1" runat="server" CssClass="form-control" Text="Fecha Hasta:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="130px"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                </asp:CalendarExtender>
                        <br />
                        <br />
                <asp:Label ID="lblPedido4" runat="server" CssClass="form-control" Text="Chofer:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtChofer" runat="server" CssClass="form-control"  Width="130px"></asp:TextBox>
                
             
                <asp:Label ID="lblPedido7" runat="server" CssClass="form-control" Text="Camion:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="ddCamion" runat="server" CssClass="form-control" DataTextField="Descripcion" DataValueField="Codigo" TabIndex="40" Width="130px">
                </asp:DropDownList>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="130px" />

                        </div>
                    </div>
             </div>
        
<asp:ImageButton ID="btnExcel" runat="server" Height="51px" cssclass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" />
            <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-striped table-bordered table-hover"
                    
                    
                    EmptyDataText="No se Encontraron Datos" ShowFooter="True" OnRowDataBound="gwGrilla_RowDataBound1">
        <Columns>
            <asp:BoundField HeaderText="Nro.Viaje" DataField="NroViaje" >
            </asp:BoundField>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha " DataFormatString="{0:dd/MM/yyyy}" >
            </asp:BoundField>
            <asp:BoundField DataField="Camion" HeaderText="Camion" >
            </asp:BoundField>
            <asp:BoundField DataField="Chofer" HeaderText="Chofer" />
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}" >
            </asp:BoundField>
        </Columns>
          
</asp:GridView>
                
        </div>
        </form>

        </asp:Content>

