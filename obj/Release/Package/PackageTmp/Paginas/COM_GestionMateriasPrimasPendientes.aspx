<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_GestionMateriasPrimasPendientes.aspx.cs" Inherits="SintecromNet.Paginas.COM_GestionMateriasPrimasPendientes" %>
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
    <h2>Gestión Materias Primas Pendientes</h2>
    
    <form id="form1" runat="server">
       
    <div class="jumbotron">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Orden Compra:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtOrdenCompraB" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
                <asp:Label ID="lblPedido2"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Proveedor:" Width="140px"></asp:Label>
                 &nbsp;&nbsp;<asp:TextBox ID="txtProveedorB" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
                        &nbsp;
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />

            
          
                        </div>
                    </div>
             </div>

               
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    DataKeyNames="Item_ID,proveedor,numerooc,item,CantidadOriginal,CantidadPendiente" >
        <Columns>
            <asp:BoundField DataField="numerooc" HeaderText="OC" >
            
            </asp:BoundField>
            <asp:BoundField DataField="item" HeaderText="Item" />
            <asp:BoundField HeaderText="Proveedor" DataField="proveedor" >           
           
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
           
            </asp:BoundField>
            <asp:BoundField DataField="DescripcionProducto" HeaderText="Producto" />
            <asp:BoundField DataField="FechaProximaEntrega" HeaderText="Fecha Entrega" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="CantidadOriginal" HeaderText="Original" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="CantidadPendiente" HeaderText="Pendiente" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="Item_ID" HeaderText="ID" Visible="False" />
        </Columns>
            <HeaderStyle  HorizontalAlign="Center" VerticalAlign="Middle"/>
            <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
           <asp:HiddenField ID="HiddenFieldError" runat="server" />


        <asp:Panel ID="Panel1" runat="server" Height="300px" Width="480px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
             <div class="input-group">
                
                <br />
                <br />            
                &nbsp;<asp:Label ID="Label5" runat="server" Text="Proveedor:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="140px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtProveedor" runat="server" CssClass="form-control" Width="320px" TabIndex="20" ReadOnly="True"></asp:TextBox>           
                <br />
                <br />
                &nbsp;<asp:Label ID="Label7" runat="server" Text="Orden de Compra" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="220px"></asp:Label>
                &nbsp;<asp:TextBox ID="txtOrdenCompra" runat="server" CssClass="form-control" Width="100px" TabIndex="40" ReadOnly="True"></asp:TextBox>           
                 
                <asp:Label ID="Label1" runat="server" Text="Item:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="60px"></asp:Label>
                <asp:TextBox ID="txtItem" runat="server" CssClass="form-control" Width="80px" TabIndex="40" ReadOnly="True"></asp:TextBox>           
                 <br />
                    <br />
                 <asp:Label ID="Label8" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Original" Width="150px"></asp:Label>
                 <asp:TextBox ID="txtKilosOri" runat="server" CssClass="form-control" ReadOnly="True" TabIndex="40" Width="80px"></asp:TextBox>
                 <asp:Label ID="Label9" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Pendientes:" Width="150px"></asp:Label>
                 <asp:TextBox ID="txtKilosPend" runat="server" CssClass="form-control" ReadOnly="True" TabIndex="40" Width="80px"></asp:TextBox>
                 <br />
                  <br />
                 <br />
                 <asp:Button ID="btnModificar" runat="server" cssclass="btn btn-success btn-circle" onclick="btnModificar_Click" TabIndex="160" Text="Saldar Item" ValidationGroup="Validar" Width="150px" />
&nbsp;
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" cssclass="btn btn-success btn-circle" BackColor="Red"
                Text="Volver" TabIndex="170" BorderStyle="None" Width="150px" />
                 </div>
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
        </div>
        </form>

        </asp:Content>

