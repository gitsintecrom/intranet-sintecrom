<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_TrackingSerieLote.aspx.cs" Inherits="SintecromNet.Paginas.INV_TrackingSerieLote" %>
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
    <h2>Tracking Serie Lote</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                &nbsp;&nbsp;
                <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Serie:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtBSerie" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
               
                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />

            
          
                        </div>
                    </div>
             </div>

        <asp:Panel ID="Panel1" runat="server" Visible="false">
            <asp:GridView ID="gwSerie" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="ID" OnRowCommand="gwSerie_RowCommand">
        <Columns>
            
            <asp:BoundField DataField="Lote" HeaderText="Serie Lote" />
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:ButtonField ButtonType="Button" CommandName="Ver" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-info" HeaderText="Ver" Text="Ver">
            <ControlStyle BorderStyle="None" CssClass="btn btn-info" />
            </asp:ButtonField>

        </Columns>
                     <%--<HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="11pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    --%>
        </asp:GridView>
        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server" Visible="false">
<span style ="float:right;"><asp:ImageButton ID="btnExcel" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/salir.png" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Salir" Width="53px" Visible="True" ImageAlign="Middle" /></span>
        <%-- <h3>
        <span style="float:right;"><asp:Label ID="lblTotal" runat="server" CssClass="label label-warning" Visible="False" /></span>
        <span style="float:right;"><asp:Label ID="lblInfo" runat="server" Text="Total Kilos:" CssClass="label label-info" Visible="False" /></span>

    </h3>  --%>  
        <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" >
           </asp:BoundField>
            <asp:BoundField DataField="Origen" HeaderText="Origen" />
            <asp:BoundField DataField="Destino" HeaderText="Destino" />
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="CodigoProducto" HeaderText="Cod.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Descripcion" HeaderText="Des.Producto" />
            <asp:BoundField DataField="Lote" HeaderText="Serie Lote" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>
            </asp:Panel>
  
</div>
</form>
        </asp:Content>

