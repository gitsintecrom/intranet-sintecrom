<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MIS_ComunicacionAmbiental.aspx.cs" Inherits="SintecromNet.Paginas.MIS_ComunicacionAmbiental" %>
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
    <h2>Registro de Comunicaciones
    </h2>
    <div class="jumbotron">

<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <br />
    <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        
                    
                    CssClass="table table-striped table-bordered table-hover"
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" 
                    DataKeyNames="ID,Accion" style="text-align: left">
        <Columns>
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Ente" HeaderText="Ente" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField HeaderText="Responsable" DataField="Responsable" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Detalle" HeaderText="Detalle">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="8pt" />
            </asp:BoundField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="Accion" HeaderText="Accion" Visible="False" />
        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
</asp:GridView>
                <asp:Panel ID="Panel2" runat="server"  BackColor="#337AB7" BorderStyle="Solid" BorderWidth="1px" style="text-align: left" Visible="False" Width="600px" CssClass="form-control" Height="380px">
                   
                        <asp:ImageButton ID="ImageButton1" runat="server" Height="27px" ImageAlign="Right" ImageUrl="~/Images/salir.png" OnClick="ImageButton1_Click" style="margin-left: 5px" Width="25px" ToolTip="Salir" />

                    <div class="input-group">
                    <br />
                    <asp:Label ID="Label16" runat="server" Text="Ente:" Width="80px" CssClass="form-control"></asp:Label>
                    <asp:TextBox ID="txtEnte" runat="server" MaxLength="500" TabIndex="40" Width="400px" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                    <br /><br />
                    <asp:Label ID="Label15" runat="server" Text="Detalle:" Width="80px" CssClass="form-control"></asp:Label>
                    <asp:TextBox ID="txtDetalle" runat="server" Height="50px" MaxLength="500" TabIndex="40" TextMode="MultiLine" Width="400px" ReadOnly="True" CssClass="form-control"></asp:TextBox>
                    <br /><br />
                    <asp:Label ID="Label17" runat="server" Text="Acción:" Width="80px" CssClass="form-control"></asp:Label>
                    <asp:TextBox ID="txtAccion" runat="server" Height="50px" MaxLength="500" TabIndex="40" TextMode="MultiLine" Width="400px" CssClass="form-control"></asp:TextBox>
                    <br />
                        <br /><br /><br /><br /><br />
                        <asp:Button ID="btnModificar" runat="server" onclick="btnModificar_Click" onclientclick="return estaseguro()" TabIndex="160" Text="Confirma" CssClass="form-control" Width="100px" />
                       
                    <br />
                    </div>
                   
                </asp:Panel>
         </div>
        </form>
        </asp:Content>

