<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_GestionStockDisponibleVentas.aspx.cs" Inherits="SintecromNet.Paginas.VT_GestionStockDisponibleVentas" %>
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
    <h2>Gestión Stock de Libre Disponibilidad</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                &nbsp;&nbsp;
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
                <asp:Label ID="Label3" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Depósito:" Width="140px"></asp:Label>
                <asp:DropDownList ID="ddDeposito" runat="server" CssClass="form-control" Width="140px">
                        </asp:DropDownList>
               
           &nbsp;&nbsp;&nbsp;&nbsp;
               
            <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />--%>
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span>&nbsp;Buscar</asp:LinkButton>
            
          
                        </div>
                    </div>
             </div>
        <div id="Mensaje" runat="server" visible="false" class="alert-info">
            <asp:LinkButton ID="LinkButton5" runat="server" CssClass="btn btn-dark" Text="" OnClick="LinkButton5_Click" ToolTip="Cerrar"><i class="fa fa-close"></i></asp:LinkButton>
                 <h3>Nota de Calidad</h3>
            
                 <br />
            
             <h5><asp:Label ID="Label5" runat="server" Text=""></asp:Label></h5>
            
          
             </div>

<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
  &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;       
<asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton3_Click" OnClientClick = "estaseguro()" Visible="False" ToolTip="Habilitar Todo"><i class="fa fa-flag-checkered fa-2x "></i></asp:LinkButton>
 &nbsp;&nbsp;&nbsp;
<asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-danger" Text="" OnClick="LinkButton4_Click" OnClientClick = "estaseguro1()" Visible="False" ToolTip="Deshabilitar Todo"><i class="fa fa-flag-checkered fa-2x "></i></asp:LinkButton>
                    
        <br />
        <br />
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound2" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="LOTE_ID">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:BoundField DataField="DESPRODUCTO" HeaderText="Des.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Kilos" HeaderText="Stock" DataFormatString="{0:n0}" />
            <asp:BoundField DataField="SL" HeaderText="Serie Lote" />
           
            <asp:BoundField DataField="Deposito" HeaderText="Deposito" >
           </asp:BoundField>
            <asp:BoundField DataField="Anchoenproceso" DataFormatString="{0:n0}" HeaderText="Ancho en Proceso" />
            <asp:TemplateField HeaderText="Nota" ShowHeader="True">
                <ItemTemplate>
                    <asp:Button ID="Button11" runat="server" CausesValidation="false" CommandName="Condicionado" Text='<%# Eval("Nota") %>'
                        CommandArgument='<%# Eval("NotaCalidad")%>'  />
                </ItemTemplate>
                <ControlStyle BorderStyle="None" CssClass="btn btn-primary" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Estado" ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="Estado" Text='<%# Eval("Estado") %>'
                        CommandArgument='<%# Eval("LOTE_ID")%>'  />
                </ItemTemplate>
                <ControlStyle BorderStyle="None" CssClass="btn btn-primary" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:TemplateField>
            <asp:BoundField DataField="LOTE_ID" HeaderText="Lote_ID" Visible="False" />
            <asp:BoundField DataField="NotaCalidad" HeaderText="Notacalidad" Visible="False" />

        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White"  />
        </asp:GridView>
  
</div>
</form>
        </asp:Content>

