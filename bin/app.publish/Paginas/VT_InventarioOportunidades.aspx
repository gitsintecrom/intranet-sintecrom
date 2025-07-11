<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_InventarioOportunidades.aspx.cs" Inherits="SintecromNet.Paginas.VT_InventarioOportunidades" %>
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
    <h2>Stock Depósito Oportunidades</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                
                    <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Familia:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="140px">
                    </asp:DropDownList>                        
                        
                    <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Espesor:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddEspesor" runat="server" CssClass="form-control" Width="140px">
                    </asp:DropDownList>                     
                    <br />  <br />    
                    <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Aleación:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddAleacion" runat="server" CssClass="form-control" Width="140px">
                    </asp:DropDownList>
                       
                    <asp:Label ID="Label1" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Temple:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddTemple" runat="server" CssClass="form-control" Width="140px">
                    </asp:DropDownList>
                     <br />  <br />                        
                    <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Forma:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddForma" runat="server" CssClass="form-control" Width="140px">
                    </asp:DropDownList>

                    <asp:Label ID="Label4" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Terminación:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddTerminacion" runat="server" CssClass="form-control" Width="140px">
                    </asp:DropDownList>            
                         
                    <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />--%>
                    &nbsp;&nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="" OnClick="LinkButton1_Click" ToolTip="Buscar"><i class="fa fa-search "></i></asp:LinkButton>
            
          
                        </div>
                    </div>
             </div>
        
         <div id="pp" runat="server" visible="false" class="panel-group">
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click"  ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
             <div id="Mensaje" runat="server" visible="false" class="alert-info">
            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-dark" Text="" OnClick="LinkButton3_Click" ToolTip="Cerrar"><i class="fa fa-close"></i></asp:LinkButton>
                 <h3>Nota de Calidad</h3>
            
                 <br />
            
             <h5><asp:Label ID="Label3" runat="server" Text=""></asp:Label></h5>
            
          
             </div>
             <h5><b style="color: rgb(0, 0, 0); font-family: arial, helvetica, sans-serif; font-size: small; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-style: initial; text-decoration-color: initial;">Son precios unitarios por Kg., expresados en dólares estadounidenses y no incluyen I.V.A.</b></h5>
              <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="notacalidad" OnRowCommand="gwGrilla_RowCommand" OnRowDataBound="gwGrilla_RowDataBound">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>

            <%--<asp:ButtonField CommandName="ver"  DataTextField="Nota" 
                HeaderText="Condicional" ButtonType="Button"  ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-primary" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">            
<ControlStyle BorderStyle="None" CssClass="btn btn-primary"></ControlStyle>

<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
            </asp:ButtonField>--%>
            <asp:BoundField DataField="DESPRODUCTO" HeaderText="Des.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Kilos" HeaderText="Stock" DataFormatString="{0:n0}" />
            <asp:BoundField DataField="Precio" HeaderText="Precio" DataFormatString="{0:0.000}" />
            <asp:BoundField DataField="SL" HeaderText="Serie Lote" />
           
            <asp:BoundField DataField="AnchoEnProceso" HeaderText="Ancho en Proceso" DataFormatString="{0:n0}" >
           </asp:BoundField>
            <asp:TemplateField HeaderText="Nota" ShowHeader="True">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false"  CommandName="Estado" Text='<%# Eval("Nota") %>'
                        CommandArgument='<%# Eval("NotaCalidad")%>'  />
                </ItemTemplate>
                <ControlStyle BorderStyle="None" CssClass="btn btn-primary" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:TemplateField>
            <asp:BoundField DataField="NotaCalidad" HeaderText="Notacalidad" Visible="False" />

        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Small" />
                    
                    
        </asp:GridView>
</div>    
         
          
        

        
  
</div>
        
</form>
        </asp:Content>

