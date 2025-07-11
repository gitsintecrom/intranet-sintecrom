<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PRODUCTO_TraerCatalogoTernium.aspx.cs" Inherits="SintecromNet.Paginas.PRODUCTO_TraerCatalogoTernium" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
  
  

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
    <h2>Importar Catálogo Ternium</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Traer Catálogo</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span>&nbsp;Buscar</asp:LinkButton>
            
          
                        </div>
                    </div>
             </div>
<%--<span style ="float:left;">
    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>

</span>--%>
             
        <br />
                <%--<asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1">
        <Columns>
            <asp:BoundField DataField="Material" HeaderText="Cod.Producto" />
            <asp:BoundField DataField="DESCTOTAL" HeaderText="Des.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
           </asp:BoundField>
            <asp:BoundField DataField="Ancho" DataFormatString="{0:n0}" HeaderText="Ancho" />
            <asp:BoundField DataField="Largo" HeaderText="Largo" />
            <asp:BoundField DataField="Espesor" HeaderText="Espesor" />
            <asp:BoundField DataField="Aleacion" HeaderText="Aleación" />
            <asp:BoundField DataField="Recubrimiento" HeaderText="Recubrimiento" />
            <asp:BoundField DataField="Temple" HeaderText="Temple" />
            <asp:BoundField DataField="Forma" HeaderText="Forma" />
            <asp:BoundField DataField="DIAMETROINT" HeaderText="Diam.Int." />
            <asp:BoundField DataField="Empalmes" HeaderText="Empalme" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>--%>

        
  
</div>
</form>
        </asp:Content>

