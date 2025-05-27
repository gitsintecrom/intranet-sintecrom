<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PRODUCTO_CatalogoTernium.aspx.cs" Inherits="SintecromNet.Paginas.PRODUCTO_CatalogoTernium" %>
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
    <h2>Gestión Catálogo Ternium</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                <asp:Label ID="Label4" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Codigo:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtCodigo" runat="server" CssClass="form-control"  Width="200px" Font-Size="X-Small"></asp:TextBox>
                        
                    <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Familia:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="200px">
                        </asp:DropDownList>

                        
                        
             <%--   
                <br />  <br /> 
               <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Aleación:" Width="140px"></asp:Label>
                <asp:DropDownList ID="ddAleacion" runat="server" CssClass="form-control" Width="160px">
                        </asp:DropDownList>
                        
                        <asp:Label ID="Label1" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Temple:" Width="140px"></asp:Label>
               <asp:DropDownList ID="ddTemple" runat="server" CssClass="form-control" Width="160px">
                        </asp:DropDownList>--%>
               <br />  <br />
                        
                <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Forma:" Width="140px"></asp:Label>
                <asp:DropDownList ID="ddForma" runat="server" CssClass="form-control" Width="200px">
                </asp:DropDownList>
                        <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Espesor:" Width="140px"></asp:Label>
                 <asp:DropDownList ID="ddEspesor" runat="server" CssClass="form-control" Width="200px">
                        </asp:DropDownList>
                 
               
           &nbsp;&nbsp;&nbsp
               
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            
          
                        </div>
                    </div>
             </div>

        

<%--<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
 
        <br />--%>
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound2" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="UDID,CodigoTernium">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:ButtonField CommandName="editar" 
                HeaderText="Editar" ButtonType="Button" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-success" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" Text="Editar">            
<ControlStyle BorderStyle="None" CssClass="btn btn-primary"></ControlStyle>

<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
            </asp:ButtonField>
            <asp:BoundField DataField="CODPRODUCTO" HeaderText="Codigo" />
            <asp:BoundField DataField="DESPRODUCTO" HeaderText="Des.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Ancho" HeaderText="Ancho" DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="CodigoTernium" HeaderText="Codigo Ternium" />
            <asp:BoundField DataField="Familia" HeaderText="Familia" />
           
            <asp:BoundField DataField="Aleacion" HeaderText="Aleacion" >
           </asp:BoundField>
            <asp:BoundField DataField="NotaCalidad" HeaderText="Temple" Visible="False" />

            <asp:BoundField DataField="Forma" HeaderText="Forma" />
            <asp:BoundField DataField="UDID" HeaderText="UDID" Visible="False" />

        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Small" />
                    
                    
        </asp:GridView>
        
        <div id="EditarPrecio" runat="server" class="panel panel-primary" visible="false">
            <div class="panel-heading">Editar Codigo</div>
            <div class="panel-body">
                 <div class="input-group">
                
                <asp:Label ID="Label3" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Codigo:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"  Width="150px" ValidationGroup="Aceptar" MaxLength="10">0</asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                    ControlToValidate="txtPrecio" runat="server"
                    ErrorMessage="El codigo debe ser de 10 posiciones por ejemplo 0001111111"
                    ValidationExpression=".{10}.*" ForeColor="#CC3300" SetFocusOnError="True"></asp:RegularExpressionValidator>
                <br /><br />
                <asp:Button ID="btnAceptar" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnAceptar_Click" Text="Aceptar" BorderStyle="None" ValidationGroup="Aceptar" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnCancelar" CssClass="btn btn-danger btn-circle" ForeColor="White" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" BorderStyle="None" ValidationGroup="Aceptar" />
      
                </div>
                  
                        
            </div>
        </div>

        
  
</div>
</form>
        </asp:Content>

