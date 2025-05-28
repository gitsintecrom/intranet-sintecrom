<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DIR_ControlSaldosProveedores.aspx.cs" Inherits="SintecromNet.Paginas.DIR_ControlSaldosProveedores" %>
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
    
    <form id="form1" runat="server">
    <h3>Saldos Proveedores Contable e Histórico Desde
        <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
&nbsp;Hasta
        <asp:Label ID="Label6" runat="server" Text="Label"></asp:Label>
        </h3>
    
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                &nbsp;&nbsp;
                <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 1px; left: 0px;" Text="Proveedor:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtProveedor" runat="server" CssClass="form-control"  Width="250px"></asp:TextBox>
                <%--<br />  <br />--%>
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
            <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />--%>
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span>&nbsp;Buscar</asp:LinkButton>
            
        
          
                        </div>
                    </div>
             </div>
         <asp:Panel ID="Panel1" runat="server" Visible="False">
         <h3>
        <span style="float:right;"><asp:Label ID="lblTotal" runat="server" CssClass="label label-warning" /></span>
        <span style="float:right;"><asp:Label ID="lblInfo" runat="server" Text="Saldo Contable:" CssClass="label label-info" Visible="True" /></span>
        <span style="float:left;"><asp:Label ID="lblInfo1" runat="server" Text="Saldo Histórico:" CssClass="label label-info" Visible="True" /></span>
        <span style="float:left;"><asp:Label ID="lblTotal1" runat="server" CssClass="label label-warning" Visible="True" /></span>

    </h3>   
             <br /> 
         <h3><asp:Label ID="Label3" runat="server" Text="Resumen Histórico Proveedor"></asp:Label>
             </h3>  
        
       
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="Denominacion" HeaderText="Proveedor" />
            <asp:BoundField DataField="TipoMovimiento" HeaderText="Tipo Movimiento" >
            </asp:BoundField>
            <asp:BoundField DataField="Saldo" HeaderText="Importe" DataFormatString="{0:0.00}" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>




  
         <br />
          <h3>
              <asp:Label ID="Label4" runat="server" Text="Resumen Contable Proveedor "></asp:Label>
             </h3>  
<asp:GridView ID="gwGrilla0" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="Denominacion" HeaderText="Proveedor" />
            <asp:BoundField DataField="Cuenta" HeaderText="Cuenta" >
            </asp:BoundField>
            <asp:BoundField DataField="Saldo" HeaderText="Importe" DataFormatString="{0:0.00}" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>


         </asp:Panel>




  
</div>
</form>
        </asp:Content>

