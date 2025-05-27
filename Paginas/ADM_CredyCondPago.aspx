<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_CredyCondPago.aspx.cs" Inherits="SintecromNet.Paginas.ADM_CredyCondPago" %>
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
    <%--<p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>--%>
    <h2>Créditos y Tipo de Pago</h2>
 <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                <asp:Label ID="Label2" runat="server" CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Cliente:" Width="130px"></asp:Label>
                <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Width="200px"></asp:TextBox>
                &nbsp; <asp:Label ID="lblPedido1" runat="server" CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Vendedor:" Width="130px"></asp:Label>
                <asp:TextBox ID="txtVendedor" runat="server" CssClass="form-control" Width="200px"></asp:TextBox>
               
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" />

                        </div>
                    </div>
            </div>

        
                  
                    <div class="input-group">
                      <br />  
                        <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
                            ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
                            ToolTip="Exportar a Excel" Width="45px" ImageAlign="Middle" Visible="False" />
            
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center" DataKeyNames="Cliente_ID,razonsocial" OnRowCommand="gwGrilla_RowCommand">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="razonsocial" HeaderText="Razon Social">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="codigo" HeaderText="Zona">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="tipopago" HeaderText="Tipo de Pago">
                            <ItemStyle HorizontalAlign="Center"/>

                            </asp:BoundField> 
                            <asp:ButtonField CommandName="Cartera"  DataTextField="Cheques" 
                                HeaderText="En Cartera" ButtonType="Button"  DataTextFormatString="{0:n0}" ControlStyle-BorderStyle="None" 
                                ControlStyle-CssClass="btn btn-primary" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">            
                                <ControlStyle BorderStyle="None" CssClass="btn btn-primary"></ControlStyle>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                            </asp:ButtonField>
                             <asp:ButtonField CommandName="Pedidos"  DataTextField="TotaPediPend" 
                                HeaderText="Ped.Pendientes" ButtonType="Button"  DataTextFormatString="{0:n0}" ControlStyle-BorderStyle="None"
                                 ControlStyle-CssClass="btn btn-primary" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle">            
                                <ControlStyle BorderStyle="None" CssClass="btn btn-info"></ControlStyle>

<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                            </asp:ButtonField>
                            <asp:BoundField DataField="CreditoOtorgado" HeaderText="Crédito Otorgado en USD" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="saldototcc_dolar" DataFormatString="{0:n0}" HeaderText="Saldo en U$S" />
                            <asp:BoundField DataField="Cred_disponible_dolar" HeaderText="Crédito Disponible en USD" DataFormatString="{0:n0}">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="cliente_id" HeaderText="cliente_id" Visible="False" />
                        </Columns>  
                            <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:GridView>

                    </div>
         <div class="input-group">
                       <asp:Panel ID="Panel3" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
                                    <asp:ImageButton ID="ImageButton2" runat="server" CssClass="form-control"  
                            ImageUrl="~/Images/exc.jpg" onclick="ImageButton2_Click" style="margin-top: 0px; top: 0px; left: 0px;" 
                            ToolTip="Exportar a Excel" Width="45px" ImageAlign="Middle" />
                         
                           
                           <br />
                           <br />
            <asp:Label ID="Label4" runat="server" Text="Pedidos Pendientes: "></asp:Label>
            <asp:Label ID="Label5" runat="server" Font-Bold="True"></asp:Label>
            
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="gwPedidos" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center" ShowFooter="True">
       
                
                <Columns>
                    <asp:BoundField DataField="Codigo" HeaderText="Código" />
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" DataFormatString="{0:0.00}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="Pendiente" DataFormatString="{0:0.00}" HeaderText="Pendiente" />
                    <asp:BoundField DataField="aprogramar" DataFormatString="{0:0.00}" HeaderText="A Programar" />
                    <asp:BoundField DataField="fabricado" DataFormatString="{0:0.00}" HeaderText="Fabricado" />
                    <asp:BoundField DataField="aremitir" DataFormatString="{0:0.00}" HeaderText="A Remitir" />
                    <asp:BoundField DataField="PrecioUnitario" HeaderText="PrecioUnitario" DataFormatString="{0:0.00}" />
                    <asp:BoundField DataField="FechaSolicitada" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Solicitada" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                   <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="Button8" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button8_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>

        </div>

            
                            
                    <div class="input-group">
                       <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
                                    <asp:ImageButton ID="ImageButton1" runat="server" CssClass="form-control"  
                            ImageUrl="~/Images/exc.jpg" onclick="ImageButton1_Click" style="margin-top: 0px; top: 0px; left: 0px;" 
                            ToolTip="Exportar a Excel" Width="45px" ImageAlign="Middle" />
                         
                           
                           <br />
                           <br />
            <asp:Label ID="Label1" runat="server" Text="Valores en Cartera: "></asp:Label>
            <asp:Label ID="Label3" runat="server" Font-Bold="True"></asp:Label>
            
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="GridView2" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center" ShowFooter="True">
       
                
                <Columns>
                    <asp:BoundField DataField="Detalle" HeaderText="Detalle" />
                    <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
                    </asp:BoundField>
                    <asp:BoundField DataField="FechaVencimiento" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Vencimiento" />
                    <asp:BoundField DataField="Moneda" HeaderText="Moneda" />
                    <asp:BoundField DataField="Importe" DataFormatString="{0:0.00}" HeaderText="Importe" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                   <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                    <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="Button1" CssClass="btn btn-success btn-circle" BackColor="Red" ForeColor="White" runat="server" OnClick="Button1_Click" Text="Cerrar" BorderStyle="None" />
    </asp:Panel>
           
             

        

        </div>
        </form>
</asp:Content>

