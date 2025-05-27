<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_ComunicacionAmbiental.aspx.cs" Inherits="SintecromNet.Paginas.ADM_ComunicacionAmbiental" %>
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
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
    <h2>Registro de Comunicaciones<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h2>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:ImageButton ID="imgAlta" runat="server" ImageUrl="~/Images/add.gif" 
                    onclick="imgAlta_Click" style="width: 16px" ImageAlign="Left" />
                        <br />
    <asp:Label ID="lblMensaje" runat="server" Text="Ingresar una Nueva Comunicación "></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;
    <br />
    <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        
                    CssClass="table table-striped table-bordered table-hover"
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" 
                    DataKeyNames="ID,Usuario" style="text-align: left">
        <Columns>
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" >
            </asp:BoundField>
            <asp:BoundField DataField="Ente" HeaderText="Ente" >
            </asp:BoundField>
            <asp:BoundField HeaderText="Responsable" DataField="Responsable" >
            </asp:BoundField>
            <asp:BoundField DataField="Detalle" HeaderText="Detalle">
            </asp:BoundField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" Visible="False" />
        </Columns>
        
</asp:GridView>
                <asp:Panel ID="Panel2" runat="server" cssclass="form-control" BackColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px" style="text-align: left" Visible="False" Width="630px" Height="300px">
                    <div class="input-group">
                   
                        <asp:ImageButton ID="ImageButton1" runat="server" Height="27px" ImageAlign="Right" ImageUrl="~/Images/salir.png" OnClick="ImageButton1_Click" style="margin-left: 5px; text-align: left;" Width="25px" ToolTip="Salir" />

&nbsp;<br /> 
                    <br />
                    <asp:Label ID="Label16" runat="server" cssclass="form-control" Text="Ente:" Width="100px" BackColor="#336699" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="txtEnte" runat="server" cssclass="form-control" MaxLength="500" TabIndex="40" Width="500px"></asp:TextBox>
                    <br />
                        <br />
                    <asp:Label ID="Label10" runat="server" cssclass="form-control" Text="Dirigido A:" Width="100px" BackColor="#336699" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="ddResponsable" cssclass="form-control" runat="server" Width="200px">
                    </asp:DropDownList>                    
                        <br />
                        <br />
                    <asp:Label ID="Label15" runat="server" cssclass="form-control" Text="Detalle:" Width="100px" BackColor="#336699" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="txtDetalle" runat="server" cssclass="form-control" Height="43px" MaxLength="500" TabIndex="40" TextMode="MultiLine" Width="500px"></asp:TextBox>
                    <br />
                        <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                   
                        <br />
                        <asp:Button ID="btnModificar" runat="server" cssclass ="btn btn-success btn-circle" onclick="btnModificar_Click" onclientclick="return estaseguro()" TabIndex="160" Text="Confirma" />
                        &nbsp;
                        <asp:Button ID="Button6" runat="server" cssclass ="btn btn-success btn-circle" onclick="Button2_Click1" onclientclick="return estaseguro()" TabIndex="170" Text="Eliminar" BackColor="#CC3300" BorderStyle="None" />
                    </div>
                   
                </asp:Panel>
               </div>         
        </form>
        </asp:Content>

