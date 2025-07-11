<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ING_GeneracionArchivos.aspx.cs" Inherits="SintecromNet.Paginas.ING_GeneracionArchivos" %>
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
    function alerta(texto) {
        alert(texto);
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
    <h2>Generación de Archivos</h2>  
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>  
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Seleccione el Archivo que Desea Generar</h4></div>
                <div class="panel-body">                
                    <div class="input-group">                        
                        <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Liberacion Crédito y Cobranzas" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
     
                        &nbsp;&nbsp;

                        
                        <asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="btnBuscar_Click"  />
                    
                        <br />
                        <br />
                        <asp:Label ID="Label8" runat="server" CssClass="form-control" Text="Pendientes Orden de Despacho" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
     
                        &nbsp;&nbsp;

                        
                        <asp:Button ID="Button7" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button7_Click"  />
                    
                        <br />
                        <br />
                         <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Pendiente Pesada" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
     
                        &nbsp;&nbsp;

                        
                        <asp:Button ID="Button3" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button3_Click"  />
                    
                        <br />
                        <br />
                        <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="Pendiente Viaje" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
     
                        &nbsp;&nbsp;

                        
                        <asp:Button ID="Button4" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button4_Click"  />
                    
                        <br />
                        <br />
                        <asp:Label ID="Label6" runat="server" CssClass="form-control" Text="Viajes Abiertos" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
     
                        &nbsp;&nbsp;

                        
                        <asp:Button ID="Button5" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button5_Click"  />
                    
                        <br />
                        <br />

                         <asp:Label ID="Label7" runat="server" CssClass="form-control" Text="Egresos Todos" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
     
                        &nbsp;&nbsp;

                        
                        <asp:Button ID="Button6" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button6_Click"  />
                    
                        <br />
                        <br />

                        <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Secuencia 1" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
                         &nbsp;&nbsp;
                        
                        <asp:Button ID="Button1" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button1_Click"  />
                       <br />
                        <br />

                          <asp:Label ID="Label9" runat="server" CssClass="form-control" Text="Secuencia 2 (BD_Batch_SP_Pedidos)" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
                         &nbsp;&nbsp;
                        
                        <asp:Button ID="Button8" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button8_Click"  />
                       <br />
                        <br />
                          <asp:Label ID="Label10" runat="server" CssClass="form-control" Text="Operaciones Sin Batch" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
                         &nbsp;&nbsp;
                        
                        <asp:Button ID="Button9" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button9_Click"  />
                       <br />
                        <br />

                          <asp:Label ID="Label11" runat="server" CssClass="form-control" Text="Pedidos" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
                         &nbsp;&nbsp;
                        
                        <asp:Button ID="Button10" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button10_Click"  />
                       <br />
                        <br />
                        <asp:Label ID="Label3" runat="server" CssClass="form-control" Text="Stock" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
                         &nbsp;&nbsp;
                        
                        <asp:Button ID="Button2" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button2_Click"  />
                    
                    
                        <br />
                        <br />
                        <asp:Label ID="Label12" runat="server" CssClass="form-control" Text="Insumos" Width="280px" BackColor="Maroon" ForeColor="White"></asp:Label>               
                         &nbsp;&nbsp;
                        
                        <asp:Button ID="Button11" runat="server" class="btn btn-success btn-circle" Visible="True" width="120" Text="Generar" OnClick="Button11_Click"  />
                    
                    
                        <br />
                        <br />
                        <asp:GridView ID="gwGrilla" runat="server" Visible="False">
                        </asp:GridView>
                    
                    
                    </div>

                    
                </div>
        </div>      
        
    

   
   
   </div>
        </form>
   
</asp:Content>

