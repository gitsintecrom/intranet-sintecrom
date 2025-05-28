<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_InformeClientes.aspx.cs" Inherits="SintecromNet.Paginas.ADM_InformeClientes" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Anular la Operación?')) return false;
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
    <h2>Clientes</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
                <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White"  Text="Cliente:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control"  Width="250px"></asp:TextBox>
               
                       
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />

            
          
                        </div>
                    </div>
             </div>
<asp:ImageButton ID="btnExcel" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" />
            <br />
        <div style="overflow:auto; width:1020px; ">
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="DIRECCIONESELECTRONICAS_ID,Nombre,ID">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Codigo" HeaderText="Codigo" >
            </asp:BoundField>
            <asp:BoundField DataField="Ciudad" HeaderText="Ciudad" />
            <asp:BoundField DataField="Calle" HeaderText="Direccion" >
           </asp:BoundField>
            <asp:BoundField DataField="CODPOS" HeaderText="Cod.Postal" />
            <asp:BoundField DataField="CUIT" HeaderText="CUIT" />
            <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
             <asp:ButtonField CommandName="Detalle"  
                HeaderText="Detalle Emails" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Detalle" >            
            </asp:ButtonField>
            <asp:ButtonField CommandName="Valores"  
                HeaderText="En Cartera" ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="En Cartera" >            
            </asp:ButtonField>
            <asp:BoundField DataField="DIRECCIONESELECTRONICAS_ID" HeaderText="DIRECCIONESELECTRONICAS_ID" Visible="False" />
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
        </Columns>
                    <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView>
  </div>
   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label1" runat="server" Text="Direcciones Electronicas Cliente: "></asp:Label>
            <asp:Label ID="lblCliente" runat="server" Font-Bold="True"></asp:Label>
            
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="GridView1" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center">
       
                
                <Columns>
                    <asp:BoundField DataField="DireccionElectronica" HeaderText="Email" />
                    <asp:BoundField DataField="Observacion" HeaderText="Observacion" >
                    </asp:BoundField>
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                   
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="btnCerrar" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="btnCerrar_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel> 
        <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label2" runat="server" Text="Valores en Cartera: "></asp:Label>
            <asp:Label ID="Label3" runat="server" Font-Bold="True"></asp:Label>
            
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="GridView2" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center" OnRowDataBound="GridView2_RowDataBound" ShowFooter="True">
       
                
                <Columns>
                    <asp:BoundField DataField="Detalle" HeaderText="Detalle" />
                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
                    </asp:BoundField>
                    <asp:BoundField DataField="FechaVencimiento" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Vencimiento" />
                    <asp:BoundField DataField="Moneda" HeaderText="Moneda" />
                    <asp:BoundField DataField="Importe" DataFormatString="{0:0.00}" HeaderText="Importe" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                   <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="Button1" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button1_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>    

</div>
</form>
        </asp:Content>

