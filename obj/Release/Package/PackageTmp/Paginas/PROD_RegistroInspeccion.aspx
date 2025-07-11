<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_RegistroInspeccion.aspx.cs" Inherits="SintecromNet.Paginas.PROD_RegistroInspeccion" %>
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
    <h2>Registro de Inspección (Plancha y Slitter)</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
                <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White"  Text="Serie / Lote:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtSerie" runat="server" CssClass="form-control"  Width="250px"></asp:TextBox>
               
                       
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />

            
          
                        </div>
                    </div>
             </div>
<%--<asp:ImageButton ID="btnExcel" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" ImageAlign="Middle" />--%>
            <br />
        <div style="overflow:auto; width:1020px; ">
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="Operacion_ID,Calidad">
        <Columns>
            <asp:BoundField DataField="Operacion" HeaderText="Operacion" />
            <asp:BoundField DataField="SerieLoteE" HeaderText="S/L Entrante" >
            </asp:BoundField>
            <asp:BoundField DataField="SerieLoteS" HeaderText="S/L Saliente" />
            <asp:BoundField DataField="OrdenProduccion" HeaderText="OrdenProd." >
           </asp:BoundField>
            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="Calidad" HeaderText="Calidad" Visible="False" />
             <asp:ButtonField CommandName="Pasadas"  
                HeaderText="Pasadas/Items" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Pasadas/Items" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success" />
            </asp:ButtonField>
            <asp:BoundField DataField="Operacion_ID" HeaderText="Operacion_ID" Visible="False" />
        </Columns>
                    <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView>
  </div>
   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label1" runat="server" Text="Notas Calidad: "></asp:Label>
            <asp:Label ID="lblCalidad" runat="server" Font-Bold="True"></asp:Label>
       <%--<div style="overflow:auto; width:950px; ">--%>
            <asp:GridView ID="GridView1" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center" OnRowCommand="GridView1_RowCommand" DataKeyNames="PasadaItem">
       
                
                <Columns>
                    <asp:ButtonField CommandName="Anchos"  DataTextField="PasadaItem" 
                    HeaderText="Pasada Item" ButtonType="Button"  ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-primary" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">            
                    <ControlStyle BorderStyle="None" CssClass="btn btn-primary" />
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:ButtonField>
                    <asp:BoundField DataField="EspesorBLM" HeaderText="EspesorBLM" DataFormatString="{0:0.00}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="EspesorBLO" DataFormatString="{0:0.00}" HeaderText="EspesorBLO" />
                    <asp:BoundField DataField="EspesorC" DataFormatString="{0:0.00}" HeaderText="EspesorC" />
                    <asp:BoundField DataField="AnchoRealBobina" DataFormatString="{0:0.00}" HeaderText="Ancho" />
                    <asp:BoundField DataField="DiametroInterno" DataFormatString="{0:0.00}" HeaderText="Diametro Interno" />
                    <asp:BoundField DataField="DiametroExterno" DataFormatString="{0:0.00}" HeaderText="Diametro Externo" />
                    <asp:BoundField DataField="DesplazamientoEspiras" DataFormatString="{0:0.00}" HeaderText="Espiras" />
                    <asp:BoundField DataField="Camber" DataFormatString="{0:0.00}" HeaderText="Camber" />
                    <asp:BoundField DataField="LargoCorte" DataFormatString="{0:0.00}" HeaderText="Largo " />
                    <asp:BoundField DataField="Escuadra" DataFormatString="{0:0.00}" HeaderText="Escuadra" />
                    <asp:BoundField DataField="EfectoTeja" DataFormatString="{0:0.00}" HeaderText="EfectoTeja" />
                    <asp:BoundField DataField="Embalaje" HeaderText="Embalaje" />
                     <%--<asp:ButtonField CommandName="Anchos"  
                HeaderText="Anchos/Paquetes" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Anchos/Paquetes" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success" />
            </asp:ButtonField>--%>
                </Columns>
               <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
         
            </asp:GridView>
           <%--</div>--%>
       <br />
            <asp:Button ID="btnCerrar" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="btnCerrar_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel> 
        <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label2" runat="server" Text="Ancho Pasada/Paquete: "></asp:Label>
            <asp:Label ID="Label3" runat="server" Font-Bold="True"></asp:Label>
            
            <asp:GridView ID="GridView2" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center" ShowFooter="True">
       
                
                <Columns>
                    <asp:BoundField DataField="Ancho" HeaderText="Ancho / Hojas" />
                    <asp:BoundField DataField="Item" HeaderText="Item" >
                    </asp:BoundField>
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
               <HeaderStyle Font-Size="9pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                   
                <RowStyle Font-Names="Arial" Font-Size="9pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
       <br />
            <asp:Button ID="Button1" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button1_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>    

</div>
</form>
        </asp:Content>

