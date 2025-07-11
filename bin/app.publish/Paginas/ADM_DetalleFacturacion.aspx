<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_DetalleFacturacion.aspx.cs" Inherits="SintecromNet.Paginas.ADM_DetalleFacturacion" %>
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
    <p>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </p>
    <h2>Facturación</h2>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
    
                           <asp:Label ID="Label2" runat="server" BackColor="#003366" CssClass="form-control" ForeColor="White" Text="Fecha Desde:" Width="130px"></asp:Label>
                           <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="100px"></asp:TextBox>
                           <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                           </asp:MaskedEditExtender>
                           <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                           </asp:CalendarExtender>
                           
                           <asp:Label ID="Label1" runat="server" BackColor="#003366" CssClass="form-control" ForeColor="White" Text="Fecha Hasta:" Width="130px"></asp:Label>
                           <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" Width="100px"></asp:TextBox>
                           <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" AutoComplete="False" Mask="99/99/9999" MaskType="Date" PromptCharacter="_" TargetControlID="TextBoxFin">
                           </asp:MaskedEditExtender>
                           <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                           </asp:CalendarExtender>
                          
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                          
                           <asp:Button ID="ButtonVer" runat="server" cssclass="btn btn-success btn-circle" Font-Bold="False" ForeColor="White"  onclick="ButtonVer_Click" style="text-align: center" Text="Buscar" Width="122px" />
    
                        
                    </div>
           
                  </div>
        </div>
        <br />
        <div class="panel panel-primary">
                <div class="panel-heading"><h4>Facturación Al
                    <asp:Label ID="lblDia" runat="server" Text=""  Width="70px" align="Right"></asp:Label></h4></div>
                <div class="panel-body">
                
                <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Diaria $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionP" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="Diaria U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionD" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" CssClass="form-control" Text="Mensual $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionAcP" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label7" runat="server" CssClass="form-control" Text="Mensual U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="lblFacturacionAcD" runat="server" CssClass="form-control" Text=""  Width="160px" align="Center"></asp:Label>
                <br />
                <br />

                <asp:Label ID="Label6" runat="server" CssClass="form-control" Text="Rango $"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="Label8" runat="server" CssClass="form-control" Text="0"  Width="160px" align="Center"></asp:Label>
                <asp:Label ID="Label9" runat="server" CssClass="form-control" Text="Rango U$S"  Width="160px" align="Center" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                <asp:Label ID="Label10" runat="server" CssClass="form-control" Text="0"  Width="160px" align="Center"></asp:Label>
                
                </div>
            </div>
                                <asp:ImageButton ID="btnExcel" runat="server" CssClass="form-control"  
                            ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
                            ToolTip="Exportar a Excel" Width="45px" ImageAlign="Middle" />
            
                        
         
        <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" allowpaging="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Numero_documento" HeaderText="Numero">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Cliente" HeaderText="Cliente">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>                            
                            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Calidad" HeaderText="Calidad">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Supra_Familia" HeaderText="Familia">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Kilos" HeaderText="Kilos" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Pesos" HeaderText="Pesos" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Dolares" HeaderText="Dolares" DataFormatString="{0:0.00}">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns> 
                    <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
                                 
                    </asp:GridView>

        

        </div>
        </form>
</asp:Content>

