<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SC_EstadoMatching.aspx.cs" Inherits="SintecromNet.Paginas.SC_EstadoMatching" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
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
    <h2>Estado de Matching</h2>
            <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
            
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" ToolTip="Refrescar"><i class="fa fa-refresh fa-2x"></i></asp:LinkButton>
          
            <br />
                <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="nromatching" HeaderText="Nro.Matching" />
            <asp:BoundField DataField="ClientePedido" HeaderText="Clientes " />
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
        </Columns>       
</asp:GridView>
                    </div>
           
                </div>
        </div>
            <asp:Timer ID="Timer1" runat="server" Interval="150000" OnTick="Timer1_Tick">
        </asp:Timer>
   
        </div>
         </form>
        </asp:Content>

