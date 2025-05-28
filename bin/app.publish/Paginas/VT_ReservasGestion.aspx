<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_ReservasGestion.aspx.cs" Inherits="SintecromNet.Paginas.VT_ReservasGestion" %>
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
    <h2>Gestión Reservas Materias Primas</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
        

       
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="LOTE_ID,SERIE_ID,PRODUCTO_ID,DEPOSITOORI,Cliente,Lote,Kilos,FechaHasta">
        <Columns>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha Reserva" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="FechaHasta" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Reservado Hasta" />

            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
            </asp:BoundField>
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:n0}" />
           
            <asp:BoundField DataField="Lote" HeaderText="Serie Lote" />
           
            <asp:BoundField DataField="Producto" HeaderText="Producto"  >
           </asp:BoundField>
            
            <asp:ButtonField CommandName="Estado"  
                            HeaderText="Estado" ButtonType="Button" text="Reservado" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" DataTextFormatString="{0:0.00}" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
                        </asp:ButtonField>
            <asp:ButtonField CommandName="Modificar" HeaderText="Modificar" ButtonType="Button" Text="Modificar"  ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None">            
                            </asp:ButtonField>
            
            <asp:BoundField DataField="LOTE_ID" HeaderText="Lote_ID" Visible="False" />
            <asp:BoundField DataField="SERIE_ID" HeaderText="SERIE_ID" Visible="False" />
            <asp:BoundField DataField="PRODUCTO_ID" HeaderText="PRODUCTO_ID" Visible="False" />

        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Small" />
                    
                    
        </asp:GridView>
        
        <div id="EditarPrecio" runat="server" class="panel panel-primary" visible="false">
            <div class="panel-heading"><h2>Cancelar Reserva</h2></div>
            <div class="panel-body">
                 <div class="input-group">
                
                  &nbsp;<asp:Label ID="Label5" runat="server" Text="Cliente:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="140px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Width="320px" TabIndex="20" ReadOnly="True"></asp:TextBox>           
                <br />
                <br />
                &nbsp;<asp:Label ID="Label7" runat="server" Text="Serie-Lote" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="110px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtSL" runat="server" CssClass="form-control" Width="120px" TabIndex="40" ReadOnly="True"></asp:TextBox>           
                   
                &nbsp;<asp:Label ID="Label1" runat="server" Text="Kilos:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="110px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtKilos" runat="server" CssClass="form-control" Width="120px" TabIndex="40" ReadOnly="True"></asp:TextBox>           
               
                <br /><br />
                      
                 &nbsp;<asp:Label ID="Label2" runat="server" Text="Presione Aceptar para Confirmar o Cancelar para Salir sin Modificar" CssClass="form-control" BackColor="Maroon" ForeColor="White" Width="460px"></asp:Label>
                  <br />
                    <br />
                <asp:Button ID="btnAceptar" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnAceptar_Click" Text="Aceptar" BorderStyle="None" ValidationGroup="Aceptar" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnCancelar" CssClass="btn btn-danger btn-circle" ForeColor="White" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" BorderStyle="None" ValidationGroup="Aceptar" />
      
                </div>
                  
                        
            </div>
        </div>
        <div id="EditarFecha" runat="server" class="panel panel-primary" visible="false">
            <div class="panel-heading"><h2>Modificar Fecha Reserva</h2></div>
            <div class="panel-body">
                 <div class="input-group">
                
                  &nbsp;<asp:Label ID="Label3" runat="server" Text="Cliente:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="140px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtClientefe" runat="server" CssClass="form-control" Width="530px" TabIndex="20" ReadOnly="True"></asp:TextBox>           
                <br />
                <br />
                &nbsp;<asp:Label ID="Label4" runat="server" Text="Serie-Lote" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="110px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtSLfe" runat="server" CssClass="form-control" Width="120px" TabIndex="40" ReadOnly="True"></asp:TextBox>           
                   
                &nbsp;<asp:Label ID="Label6" runat="server" Text="Kilos:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="100px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtKilosfe" runat="server" CssClass="form-control" Width="90px" TabIndex="40" ReadOnly="True"></asp:TextBox>           
               
                &nbsp;<asp:Label ID="Label9" runat="server" Text="Fecha Reservado:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="150px"></asp:Label>
                <%--&nbsp;<asp:TextBox ID="txtReservaHasta" runat="server" CssClass="form-control" Width="100px" TabIndex="40"></asp:TextBox>--%>  
                 &nbsp;<asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="100px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                    </asp:CalendarExtender>
               
                <br /><br />
                      
                 &nbsp;<asp:Label ID="Label8" runat="server" Text="Presione Aceptar para Confirmar o Cancelar para Salir sin Modificar" CssClass="form-control" BackColor="Maroon" ForeColor="White" Width="670px"></asp:Label>
                  <br />
                    <br />
                <asp:Button ID="btnAceptarf" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnAceptarf_Click" Text="Aceptar" BorderStyle="None" ValidationGroup="Aceptar" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="Button2" CssClass="btn btn-danger btn-circle" ForeColor="White" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" BorderStyle="None" ValidationGroup="Aceptar" />
      
                </div>
                  
                        
            </div>
        </div>

        
  
</div>
</form>
        </asp:Content>

