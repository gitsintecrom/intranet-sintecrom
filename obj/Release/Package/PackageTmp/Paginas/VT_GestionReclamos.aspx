<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_GestionReclamos.aspx.cs" Inherits="SintecromNet.Paginas.VT_GestionReclamos" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro Actualizar el Reclamo?')) return false;
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
    <h2>Reclamos Pendientes de Aprobación</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="ID,Contacto,Caracteristicas,Motivo,Emite,Observaciones,ReclamoExterno,Cliente" 
                    OnRowCommand="gwGrilla_RowCommand" OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged" OnRowDataBound="gwGrilla_RowDataBound">
        <Columns>
           
            <asp:ButtonField ButtonType="Button" CommandName="Detalle" HeaderText="Seleccionar" ControlStyle-CssClass="btn btn-info" Text="Ver Detalle" >
            
<ControlStyle CssClass="btn btn-info"></ControlStyle>
            </asp:ButtonField>
            
            <asp:BoundField DataField="ID" HeaderText="Número" />
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />

            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="Contacto" HeaderText="Contacto" Visible="False" />
            <asp:BoundField DataField="Email" HeaderText="Email" Visible="False" />
            <asp:BoundField DataField="Caracteristicas" HeaderText="Caracteristicas" Visible="False" />
            <asp:BoundField DataField="Motivo" HeaderText="Motivo" Visible="False" />
            <asp:BoundField DataField="Emite" HeaderText="Emite" Visible="False" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" Visible="False" />
            <asp:BoundField DataField="ReclamoExterno" HeaderText="ReclamoExterno" Visible="False" />
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
                <br />
                <br />
                <br />  
        
      <asp:HiddenField ID="HiddenFieldError" runat="server" />   
             
    <asp:Panel ID="Panel1" runat="server" 
        Height="600px" Width="600px" style="overflow:auto; height:600px; "
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke"  
    ForeColor="#999999" >
    
        <asp:Label ID="Label1" runat="server" CssClass="form-control"  ForeColor="White" Width="600px" style="text-align:center"  BackColor="#003366" Font-Bold="True" Font-Size="Medium"></asp:Label>
           <asp:GridView ID="GridView1" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos">
        <Columns>
           
            <asp:BoundField DataField="NroRemito" HeaderText="Remito" />
            <asp:BoundField DataField="SerieLote" HeaderText="Serie/Lote" />
            <asp:BoundField DataField="Kilos" HeaderText="Kilos" />
            <asp:BoundField DataField="CodigoP" HeaderText="Codigo" />
            <asp:BoundField DataField="DescripcionP" HeaderText="Descripcion" />

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView>  
        <div class="input-group">
            
             <asp:Label ID="Label11" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Motivo:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtMotivo" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="350px" ReadOnly="True"></asp:TextBox>
             <br />
             <asp:Label ID="Label12" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Observaciones:" Width="150px"></asp:Label>
             <asp:TextBox ID="txtObservaciones" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="350px" ReadOnly="True"></asp:TextBox>
             <br />
             <asp:Label ID="Label13" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Reclamo Externo:" Width="150px"></asp:Label>
             <asp:TextBox ID="txtReclamoExterno" runat="server" cssclass="form-control" Width="350px" ReadOnly="True"></asp:TextBox>
             <br />
             <asp:Label ID="Label14" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Emitido Por:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtEmite" runat="server" cssclass="form-control" Width="350px" ReadOnly="True"></asp:TextBox>
            <br /><br /> <br />
             <%--<asp:Button ID="Button2" runat="server" BorderStyle="None" class="btn btn-success btn-circle" OnClick="Button2_Click" width="160" />--%>
             <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/icon_attachments.png" OnClick="ImageButton1_Click" ToolTip="Visualizar Adjuntos" />
             <br />
            
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="Button1" runat="server" BorderStyle="None" class="btn btn-success btn-circle" OnClick="Button1_Click1" onclientclick="return estaseguro()" Text="Anular" width="130" BackColor="#CC3300" />
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="Button6" runat="server" class="btn btn-success btn-circle" width="130" onclick="Button2_Click1" 
                Text="Salir" TabIndex="170" BackColor="#669999" BorderStyle="None" />
                 
         </div>
     
          
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>

        <asp:Panel ID="Panel9" runat="server" BackColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px" Height="450px" Visible="False" Width="880px" CssClass="form-control">
        <asp:Label ID="lblReclamo" runat="server" Font-Size="Medium"></asp:Label>
        <br />
        <br />
        <div style="overflow:auto; height: 250px;">
        <asp:GridView ID="gwAdjuntos" runat="server"  CssClass="table table-striped table-bordered table-hover"  
            AutoGenerateColumns="False" AutoGenerateSelectButton="True" DataKeyNames="ID" 
            onrowcommand="gwAdjuntos_RowCommand" 
            onrowdatabound="gwAdjuntos_RowDataBound" onselectedindexchanged="gwAdjuntos_SelectedIndexChanged" OnRowDeleting="gwAdjuntos_RowDeleting" EmptyDataText="No existen Adjuntos Para El Reclamo Seleccionado" >
            <Columns>
                <asp:BoundField DataField="Numero" HeaderText="Reclamo">
                </asp:BoundField>
                <asp:BoundField DataField="NombreArchivo" HeaderText="Nombre Archivo">
                </asp:BoundField>
                <asp:CommandField ButtonType="Button"  ShowCancelButton="False" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
            </div>
        <br />
        <asp:FileUpload ID="fuImagen" runat="server" Width="368px" CssClass="form-control" />
        <br />       
        <asp:Button ID="btnAgregar" runat="server" onclick="btnAgregar_Click" TabIndex="160" Text="Agregar" />
        &nbsp;<asp:Button ID="btnSalir" runat="server" onclick="btnSalir_Click" TabIndex="170" Text="Cerrar" />
        <br />
    </asp:Panel>
          <br />
             <br />
             <br />
        </div>
    </form>
        </asp:Content>

