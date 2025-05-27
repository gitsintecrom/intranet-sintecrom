<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_ListaDePreciosXV.aspx.cs" Inherits="SintecromNet.Paginas.VT_ListaDePreciosXV" %>
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
    <h2>Lista General de Precios</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
                    <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Cliente:" Width="140px"></asp:Label>
                
                <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Width="200px"></asp:TextBox>
                
                    <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Familia:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="200px">
                        </asp:DropDownList>
                    <br />  <br /> 
                        
                        
                <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Espesor:" Width="140px"></asp:Label>
                 <asp:DropDownList ID="ddEspesor" runat="server" CssClass="form-control" Width="200px">
                        </asp:DropDownList>                       
               <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Forma:" Width="140px"></asp:Label>
                <asp:DropDownList ID="ddForma" runat="server" CssClass="form-control" Width="200px">
                </asp:DropDownList>
              
               
           &nbsp;&nbsp;&nbsp
               
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            
          
                        </div>
                    </div>
             </div>

 
    
<br />
        <div id="Mensaje" runat="server" visible="false" class="alert-info">
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="True"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
            <h4><asp:Label ID="Label4" runat="server"  CssClass="form-control" width="200px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Numero de Lista:" ></asp:Label>
                   <asp:Label ID="lblLista" runat="server"  CssClass="form-control" width="60px"  BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                   <asp:Label ID="Label5" runat="server"  CssClass="form-control" width="150px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Vigencia:" ></asp:Label>
               
                    <asp:Label ID="lblVigencia" runat="server"  CssClass="form-control"  width="100px" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                    <asp:Label ID="Label6" runat="server"  CssClass="form-control" width="100px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                
                    <asp:Label ID="lblVersion" runat="server"  CssClass="form-control"  width="100px"  BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                
                 <br />  <br /> 
                    <asp:Label ID="Label7" runat="server"  CssClass="form-control" width="550px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Los precios están expresados en dólares estadounidenses y no incluyen I.V.A." ></asp:Label>
</h4>			

            
 
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >
            </asp:BoundField>
             <asp:BoundField DataField="Zona" HeaderText="Zona" >
            </asp:BoundField>
             <asp:BoundField DataField="CodigoCliente" HeaderText="Cod.Cliente" >
            </asp:BoundField>
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
            </asp:BoundField>
            <asp:BoundField DataField="DescripcionProducto" HeaderText="Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Calidad" HeaderText="Calidad" >
            </asp:BoundField>
            <asp:BoundField DataField="Lista" HeaderText="Lista" DataFormatString="{0:n3}" />           
            <asp:BoundField DataField="Bonificacion" HeaderText="Bonificacion" DataFormatString="{0:n3}" />           
            <asp:BoundField DataField="PrecioNeto" HeaderText="Precio Neto" DataFormatString="{0:n3}" />           
            
           
        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Small" />
                    
                    
        </asp:GridView>
        
  
</div>
        
  
</div>
</form>
        </asp:Content>

