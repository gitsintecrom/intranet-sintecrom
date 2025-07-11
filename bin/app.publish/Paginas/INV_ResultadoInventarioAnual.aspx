<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_ResultadoInventarioAnual.aspx.cs" Inherits="SintecromNet.Paginas.INV_ResultadoInventarioAnual" %>
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
    <h2>Resultado Inventario Anual </h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Totales</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                <asp:Label ID="lblInicial"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left" Text="Stock Inicial:" Width="180px"></asp:Label>                               
                <asp:Button ID="btnInicial" runat="server" cssclass="btn btn-success btn-success" onclick="ButtonVer_Click"  TabIndex="50" Text="0" Width="140px" />
                <br />
                <asp:Label ID="Label1"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Altas Extraordinarias:" Width="180px"></asp:Label>                               
                <asp:Button ID="btnExtra" runat="server" cssclass="btn btn-success btn-success" onclick="btnExtra_Click" TabIndex="50" Text="0" Width="140px" />
                <br />
                <asp:Label ID="Label2"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left" Text="Ajustes:" Width="180px"></asp:Label>                               
                <asp:Button ID="btnAjuste" runat="server" cssclass="btn btn-success btn-success" onclick="btnAjuste_Click" TabIndex="50" Text="0" Width="140px" />
                <br />
                <asp:Label ID="Label3"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left" Text="Bajas:" Width="180px"></asp:Label>                               
                <asp:Button ID="Button1" runat="server" cssclass="btn btn-success btn-danger" onclick="Button1_Click" TabIndex="50" Text="0" Width="140px" />
                        <br />
                        <br />
                <br />
                <asp:Label ID="Label4"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left" Text="Resultado:" Width="180px"></asp:Label>                               
                <asp:Label ID="Label5"  CssClass="form-control" BackColor="#3399FF" ForeColor="White" runat="server" style="text-align: center; top: 0px; left: 0px;" Width="140px"></asp:Label>                               
               
          
               
          
                        </div>
                    </div>
             </div>
<span style ="float:left;"><asp:ImageButton ID="btnExcel" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" /></span>
         <h3>
        <span style="float:right;"><asp:Label ID="lblTotal" runat="server" CssClass="label label-warning" Visible="False" /></span>
        <span style="float:right;"><asp:Label ID="lblInfo" runat="server" Text="Total Kilos:" CssClass="label label-info" Visible="False" /></span>

    </h3>    
        <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="SL" HeaderText="Serie Lote" />
            <asp:BoundField DataField="CODPRODUCTO" HeaderText="Cod.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Deposito" HeaderText="Deposito" >
           </asp:BoundField>
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>
  
</div>
</form>
        </asp:Content>

