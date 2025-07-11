<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_PosicionIVA.aspx.cs" Inherits="SintecromNet.Paginas.ADM_PosicionIVA" %>
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
    <h2>Posición IVA</h2>
            
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
            <br />
                <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <asp:BoundField DataField="ANIO_MES" HeaderText="Período" />
            <asp:BoundField DataField="DEBE" HeaderText="Debe" DataFormatString="{0:n2}" >
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="HABER" HeaderText="Haber" DataFormatString="{0:n2}" >
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
            <asp:BoundField DataField="Saldo" HeaderText="Saldo " DataFormatString="{0:n2}"  >
            <ItemStyle HorizontalAlign="Right" />
            </asp:BoundField>
        </Columns> 
                    <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>      
</asp:GridView>
                    </div>
           
                </div>
        </div>

   
        </div>
         </form>
        </asp:Content>

