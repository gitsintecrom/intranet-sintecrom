<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_TransaccionesInventario.aspx.cs" Inherits="SintecromNet.Paginas.INV_TransaccionesInventario" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de de Habilitar todos los Items?')) return false;
    }
    function estaseguro1() {

        if (!confirm('Esta Seguro de Deshabilitar todos los Items?')) return false;
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
    <h2>Informe Transacciones de Inventario</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="labelRes0" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Fecha Desde:" Width="150px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBoxIni" runat="server" Width="150px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                 &nbsp;<asp:Label ID="labelRes1" runat="server" style="text-align: left" Text="Fecha Hasta:" Width="150px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>

                        <asp:TextBox ID="TextBoxFin" runat="server" TabIndex="10" Width="150px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                       
                  <br /><br />
                       <asp:Label ID="lblPedido1" runat="server" style="text-align: left; top: 0px; left: -1px;" Text="Estado" Width="150px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="150px" CssClass="form-control">
                    <asp:ListItem Value="5">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="1">Aceptado</asp:ListItem>
                    <asp:ListItem Value="0">Pendiente Autorización</asp:ListItem>
                    <asp:ListItem Value="9">Rechazado</asp:ListItem>
                </asp:DropDownList>
               
                       <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 2px;" Text="Usuario" Width="150px"></asp:Label>
                     
                        
                &nbsp;<asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" Width="150px"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     
                        
                <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" />

                        </div>
                    </div>
            </div>
        <asp:Panel  ID="Panel2" runat="server" Visible="False">
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="SL,Kilos,Detalle,Tipo,Observaciones,ID">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:BoundField DataField="SL" HeaderText="S/L" >
            </asp:BoundField>
            <asp:BoundField DataField="Kilos" DataFormatString="{0:n0}" HeaderText="Kilos" />
            <asp:BoundField DataField="Prodori" HeaderText="Prod.Ori" />
           
            <asp:BoundField DataField="ProdDes" HeaderText="Prod.Des" />
              <asp:BoundField DataField="Depori" HeaderText="Dep.Ori" >
           </asp:BoundField>
            <asp:BoundField DataField="DepDes" HeaderText="Dep.Des" />
           
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
           </asp:BoundField>
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
            <asp:BoundField DataField="Autoriza" HeaderText="Autorizó" />
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" />
            <asp:BoundField DataField="Detalle" HeaderText="Motivo" Visible="False" />
            <asp:ButtonField CommandName="Detalle"  
                ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="Detalle" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" Visible="False" />
        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White"  />
        </asp:GridView>
        </asp:Panel> 
   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
    
                    <h2>Serie/Lote: <asp:Label ID="lblDetalle1" runat="server" ></asp:Label>
                        Kilos: <asp:Label ID="Label2" runat="server" ></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" OnClick="LinkButton2_Click" ToolTip="Salir"></asp:LinkButton>
                    </h2>
                     
                       
        <%--<li class="active"><a class="fa fa-sign-out fa-2x" style="color: #FFFFFF; background-color: #5698D1; text-align: right;"   href="..//default.aspx"></a></li>--%> 
                    
        
       <h3>Motivo Transacción: <asp:Label ID="Label1" runat="server" ></asp:Label></h3>
           <br />
       <div class="input-group">
            <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Observaciones:" Width="140px"></asp:Label>
           
            <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control" Width="350px" TextMode="MultiLine" ReadOnly="True"></asp:TextBox>
        </div>
             <br /> 
         <div style="text-align:center;width:990px;">
    
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    </div>
 </asp:Panel> 
  
</div>
</form>
        </asp:Content>

