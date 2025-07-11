<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_FichasTecnicas.aspx.cs" Inherits="SintecromNet.Paginas.VT_FichasTecnicas" %>
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
    <h2>Fichas Técnicas</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                
                <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Cliente:" Width="200px"></asp:Label>
                <asp:DropDownList ID="ddClientes" runat="server" CssClass="form-control" Width="200px" AutoPostBack="True">
                    </asp:DropDownList>                
                                  
                <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Familia:" Width="200px"></asp:Label>
                <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="200px">
                </asp:DropDownList>
                <br/> <br/> 
                <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Espesor:" Width="200px"></asp:Label>
                <asp:DropDownList ID="ddEspesor" runat="server" CssClass="form-control" Width="200px">
                </asp:DropDownList>
                
                <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Aleación:" Width="200px"></asp:Label>
                <asp:DropDownList ID="ddAleacion" runat="server" CssClass="form-control" Width="200px">
                </asp:DropDownList>
                <br />  <br /> 
                <asp:Label ID="Label1" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Temple:" Width="200px"></asp:Label>
                <asp:DropDownList ID="ddTemple" runat="server" CssClass="form-control" Width="200px">
                </asp:DropDownList>
                <asp:Label ID="Label3" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Forma:" Width="200px"></asp:Label>
                <asp:DropDownList ID="ddForma" runat="server" CssClass="form-control" Width="200px">
                </asp:DropDownList>

                <br /> <br />  
                
               <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span>&nbsp;Buscar</asp:LinkButton>
                <br />  <br /> 
          
                        </div>
                    </div>
             </div>
<span style ="float:left;"><%--<asp:ImageButton ID="btnExcel" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" />--%>
    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>

</span>
             
        <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1">
        <Columns>
            <asp:BoundField DataField="Espesor" HeaderText="Espesor" />
            <asp:BoundField DataField="Aleacion" HeaderText="Aleación" />
            <asp:BoundField DataField="Temple" HeaderText="Temple" />
            <asp:BoundField DataField="Forma" HeaderText="Forma" />
            <asp:BoundField DataField="Ancho" DataFormatString="{0:n0}" HeaderText="Ancho" />
            <asp:BoundField DataField="Largo" HeaderText="Largo" />
            <asp:BoundField DataField="Material" HeaderText="Cod.Producto" />
            <asp:BoundField DataField="DESCTOTAL" HeaderText="Des.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
           </asp:BoundField>
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="Recubrimiento" HeaderText="Recubrimiento" />
            <asp:BoundField DataField="DIAMETROINT" HeaderText="Diam.Int." />
            <asp:BoundField DataField="Empalmes" HeaderText="Empalme" />
        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1" Visible="False">
        <Columns>
             <asp:BoundField DataField="Espesor" HeaderText="Espesor" />
            <asp:BoundField DataField="Aleacion" HeaderText="Aleación" />
            <asp:BoundField DataField="Temple" HeaderText="Temple" />
            <asp:BoundField DataField="Forma" HeaderText="Forma" />
            <asp:BoundField DataField="Ancho" DataFormatString="{0:n0}" HeaderText="Ancho" />
            <asp:BoundField DataField="Largo" HeaderText="Largo" />
            <asp:BoundField DataField="Material" HeaderText="Cod.Producto" />
            <asp:BoundField DataField="DESCTOTAL" HeaderText="Des.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
           </asp:BoundField>
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="Recubrimiento" HeaderText="Recubrimiento" />
            <asp:BoundField DataField="DIAMETROINT" HeaderText="Diam.Int." />
            <asp:BoundField DataField="Empalmes" HeaderText="Empalme" />
            <asp:BoundField DataField="Origen" HeaderText="Origen" />
            <asp:BoundField DataField="calidadcli" HeaderText="Cal.Cliente" />
            <asp:BoundField DataField="calidadori" HeaderText="Cal.Original" />
            <asp:BoundField DataField="notas_produccion" HeaderText="Notas Prod." />
            <asp:BoundField DataField="Espesormax" HeaderText="Espesor Max." />
            <asp:BoundField DataField="Espesormin" HeaderText="Espesor Min." />
            <asp:BoundField DataField="Anchomax" HeaderText="Ancho Max." />
            <asp:BoundField DataField="anchomin" HeaderText="Ancho Min." />
            <asp:BoundField DataField="largomax" HeaderText="Largo Max." />
            <asp:BoundField DataField="largomin" HeaderText="Largo Min." />
            <asp:BoundField DataField="diamextmax" HeaderText="Diam.Ext.Max." />
            <asp:BoundField DataField="diamextmin" HeaderText="Diam.Ext.Min." />
            <asp:BoundField DataField="pesormax" HeaderText="Peso Max." />
            <asp:BoundField DataField="pesormin" HeaderText="Peso Min." />
            <asp:BoundField DataField="Sable" HeaderText="Sable" />
            <asp:BoundField DataField="Espiras" HeaderText="Espiras" />
            <asp:BoundField DataField="Tipoemb" HeaderText="Tipo Emb." />
            <asp:BoundField DataField="pesomaxbulto" HeaderText="Peso Max.Bulto" />



            <asp:BoundField DataField="codigoemb" HeaderText="Cod.Emb." />



        </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>
  
</div>
</form>
        </asp:Content>

