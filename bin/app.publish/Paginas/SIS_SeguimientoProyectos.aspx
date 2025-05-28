<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SIS_SeguimientoProyectos.aspx.cs" Inherits="SintecromNet.Paginas.SIS_SeguimientoProyectos" %>
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
    function alerta(texto) {
        alert(texto);
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
    <h2>Seguimiento Proyectos de Sistemas</h2>    
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="labelRes0" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Fecha Desde:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBoxIni" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                 &nbsp;<asp:Label ID="labelRes1" runat="server" style="text-align: left" Text="Fecha Hasta:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>

                        <asp:TextBox ID="TextBoxFin" runat="server" TabIndex="10" Width="130px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                       
              <%--<br /><br />--%>

                        
                        <asp:Label ID="lblPedido1" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Estado:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="130px" CssClass="form-control">
                    <asp:ListItem Value="9">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="0">En Proceso</asp:ListItem>
                    <asp:ListItem Value="1">Pendientes</asp:ListItem>
                    <asp:ListItem Value="2">Finalizados</asp:ListItem>
                    <asp:ListItem Value="3">Descartados</asp:ListItem>
                    <asp:ListItem Value="4">Realizados</asp:ListItem>
                </asp:DropDownList>

              
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
                <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" />--%>
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="" OnClick="LinkButton1_Click" ToolTip="Buscar"><i class="fa fa-search fa-2x"></i></asp:LinkButton>
                
                        </div>
                    </div>
            </div>
        
    
<%--<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>--%>
<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
    
         <div style="overflow:auto; width:1020px; ">
     <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos" OnRowDataBound="gwGrilla_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Descripción" />
                        <asp:BoundField DataField="usuario" HeaderText="Solicitante" />
                        <asp:BoundField DataField="Sector"  HeaderText="Sector" />
                        <asp:BoundField DataField="Detalle" HeaderText="Detalle" />
                        <asp:BoundField DataField="Inicio" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Inicio" />
                        <asp:BoundField DataField="Fin" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Fin" />
                        <asp:BoundField DataField="Responsables" HeaderText="Responsables" />
                        <asp:BoundField DataField="Costo" DataFormatString="{0:0.00}" HeaderText="Costo" />
                        <asp:BoundField DataField="Tiempo"  HeaderText="Tiempo (Dias)" />
                        <asp:BoundField DataField="Estadop" HeaderText="Estado" />
                    </Columns>
                    <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                    <RowStyle Font-Size="Small" />
                </asp:GridView>

             </div>
   
   </div>
        </form>
   
</asp:Content>

