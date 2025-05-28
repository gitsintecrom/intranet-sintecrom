<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_OC_Servicios.aspx.cs" Inherits="SintecromNet.Paginas.ADM_OC_Servicios" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
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
     

    <h2>Ordenes de Compra de Servicios</h2>
                          
<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

           <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                        </asp:CalendarExtender>
                        <%--<br />--%>
                        <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Fecha Hasta:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               

                        <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="130px"></asp:TextBox>
                        <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                        </asp:CalendarExtender>
                    </div>

                    <div class="input-group">
                        <asp:Label ID="Label3" runat="server" CssClass="form-control" Text="Proveedor:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtProveedor" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        <%--<br />--%>
                        <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Estado:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>               
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" Width="130px">
                        <asp:ListItem Value="Todos">Todos</asp:ListItem>
                        <asp:ListItem Value="Pendiente">Pendiente</asp:ListItem>
                        <asp:ListItem Value="Cumplido">Cumplido</asp:ListItem>
                        </asp:DropDownList>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnVer" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnVer_Click" BackColor="#337AB7"  />
                    </div>
                </div>
        </div>

            <div class="panel panel-primary"> 
                <div class="panel-heading"><h4>Detalle</h4></div>
       
                <asp:ImageButton ID="btnExcel" runat="server" Height="51px" cssclass="form-control"
                    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click1" Visible="False" 
                    Width="53px" />
           
      
       
                <asp:GridView ID="gwOCServicios" runat="server" AutoGenerateColumns="False" 
        
                     CssClass="table table-striped table-bordered table-hover"
                    
                    EmptyDataText="El Filtro Seleccionado no ha Arrojado Resultados">
        <Columns>
            <asp:BoundField HeaderText="Orden de Compra" DataField="Nombre_OC" >
            
            </asp:BoundField>
            <asp:BoundField DataField="Denominacion_Destinatario" HeaderText="Destinatario">
            
            </asp:BoundField>
            <asp:BoundField DataField="Solicitante" HeaderText="Solicitante" >            
            </asp:BoundField>
            <asp:BoundField DataField="Nota" HeaderText="Nota" >
            
            </asp:BoundField>
            <asp:BoundField DataField="FECHAENTREGA" HeaderText="Fecha Entrega" 
                DataFormatString="{0:dd/MM/yyyy}" >            
            </asp:BoundField>
            <asp:BoundField DataField="Detalle" HeaderText="Detalle">            
            </asp:BoundField>
            <asp:BoundField DataField="Porcentaje" DataFormatString="{0:0.00}" 
                HeaderText="% Cumplido">           
            </asp:BoundField>
        </Columns>   
                    <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                         
</asp:GridView>


                
</div>
                    </div>
         
       
                    
          </form>
        
</asp:Content>

