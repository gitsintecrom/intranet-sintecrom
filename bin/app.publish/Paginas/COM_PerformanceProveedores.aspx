<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_PerformanceProveedores.aspx.cs" Inherits="SintecromNet.Paginas.COM_PerformanceProveedores" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script>
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
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2>Perfomance Proveedores</h2>
      <div class="panel panel-primary">
            <div class="panel-heading"><h4>Cumplimiento y Demora Por Proveedor</h4></div>
                <div class="panel-body">                
                   
                        <div style="overflow:auto;  float:left; height: 450px;">
                    <asp:ImageButton ID="ImageButton1" runat="server" CssClass="form-control"  
                    ImageUrl="~/Images/exc.jpg" onclick="ImageButton1_Click" style="margin-top: 0px" 
                    ToolTip="Exportar a Excel" Width="50px" ImageAlign="Middle" BorderStyle="None" />
                        <asp:GridView ID="gwGrilla0" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center" DataKeyNames="Proveedor" OnRowCommand="gwGrilla0_RowCommand" OnRowDataBound="gwGrilla0_RowDataBound" OnSelectedIndexChanged="gwGrilla0_SelectedIndexChanged">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:HyperLinkField DataTextField="Proveedor" Text="Proveedor" HeaderText="Proveedor" />
                            <asp:BoundField DataField="Cumplimiento" HeaderText="Cumplimiento" DataFormatString="{0:0.00}" />
                            <asp:BoundField DataField="Demora" HeaderText="Demora" DataFormatString="{0:0.00}">
                            </asp:BoundField>
                            
                           </Columns>                      
                            <HeaderStyle Font-Size="8pt" />
                            <RowStyle Font-Size="7pt" />
                    </asp:GridView>

                    </div>

                </div>
        </div>
        
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle Por Proveedor <asp:Label ID="lblTitulo" runat="server"></asp:Label></h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        
        
                    <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
                    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
                    ToolTip="Exportar a Excel" Width="50px" ImageAlign="Middle" BorderStyle="None" />
    
                      <br />
                        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="oc_numero" HeaderText="Nro. OC">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Proveedor" HeaderText="Proveedor" />
                            <asp:BoundField DataField="OC_Descr" HeaderText="Descripción" />
                            <asp:BoundField DataField="oc_codigo" HeaderText="Código">
                            </asp:BoundField>
                            <asp:BoundField DataField="oc_cant_solicitada" HeaderText="Cantidad" DataFormatString="{0:0.00}">
                            </asp:BoundField>
                            <asp:BoundField DataField="co_fechaentrega_pactada" HeaderText="Fecha Entrega Pactada" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fecharemito" HeaderText="Fecha Remito" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="CantidadRecibida" DataFormatString="{0:0.00}" HeaderText="Cant.Recibida" />
                            
                           </Columns>                      
                            <HeaderStyle Font-Size="8pt" />
                            <RowStyle Font-Size="7pt" />
                    </asp:GridView>

                    </div>
           
                </div>
        </div>
 </div>
    </form>
</asp:Content>
