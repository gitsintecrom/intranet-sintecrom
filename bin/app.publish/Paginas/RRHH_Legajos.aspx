<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RRHH_Legajos.aspx.cs" Inherits="SintecromNet.Paginas.RRHH_Legajos" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Eliminar el Certificado?')) return false;
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
    <h2>Legajos Empleados</h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                 <asp:Label ID="Label1" runat="server" cssclass="form-control" Text="Legajo:" Width="100px" BackColor="#337AB7" ForeColor="White"></asp:Label>
            <asp:TextBox ID="txtLegajo" runat="server" cssclass="form-control" Width="150px"></asp:TextBox>
           <%-- <br />
            <br />--%>
            <asp:Label ID="Label2" runat="server" cssclass="form-control" Text="Empleado:" Width="100px" BackColor="#337AB7" ForeColor="White"></asp:Label>
            <asp:TextBox ID="txtNombre" cssclass="form-control" runat="server" Width="150px"></asp:TextBox>
           <%-- <br />
            <br />--%>
            <asp:Label ID="Label4" runat="server" cssclass="form-control" Text="Estado:" Width="100px" BackColor="#337AB7" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList1"  cssclass="form-control" runat="server" Width="150px">
                <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                <asp:ListItem Value="Activo">Activos</asp:ListItem>
                <asp:ListItem Value="Suspendido">Suspendidos</asp:ListItem>
                <asp:ListItem>Baja</asp:ListItem>
                <asp:ListItem Value="Todos">Todos</asp:ListItem>
            </asp:DropDownList>
           <%-- <br />
            <br />--%>
            <asp:Button ID="btnVer0" runat="server" onclick="ButtonVer_Click" 
            Text="Buscar" cssclass ="btn btn-success btn-circle" Width="100px"  />
                    </div>
           
                </div>
        </div>
    
    
        <asp:Panel ID="Panel5" runat="server" BorderStyle="Outset" cssclass="form-control" BorderWidth="3px" Height="250px" HorizontalAlign="Center" Width="520px" BackColor="#CCCCCC">
        <div class="input-group">
            <asp:Label ID="lblLegajo" runat="server" Text="Label"></asp:Label>
            &nbsp;<asp:Label ID="lblEmpleado" runat="server"></asp:Label>
            &nbsp;<asp:Label ID="lblEstado" runat="server" Text="True"></asp:Label>
            <%--&nbsp;&nbsp;<asp:Label ID="Label3" runat="server" Font-Bold="False" Font-Overline="False" Font-Size="Medium" Text="Certificados"></asp:Label>--%>
            <br />
            <asp:Image ID="imgFoto" runat="server"  Height="150px" Width="150px"   />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <asp:Button ID="btnFoto" runat="server" cssclass ="btn btn-success btn-circle" Text="Cambiar Foto" Width="150px"  OnClick="btnFoto_Click" />           
             <br />
             <br />
            <asp:Button ID="btnAusencias" runat="server" cssclass ="btn btn-success btn-circle" Text="Ausencias" Width="150px"  BackColor="Maroon" BorderStyle="None" ForeColor="White" OnClick="btnAusencias_Click" />
            &nbsp;
            <asp:Button ID="btnEstudio" runat="server" cssclass ="btn btn-success btn-circle" Text="Estudios" Width="150px"  BackColor="Maroon" BorderStyle="None" ForeColor="White" OnClick="btnEstudio_Click" />
            &nbsp;
            <asp:Button ID="btnSanciones" runat="server" cssclass ="btn btn-success btn-circle" Text="Sanciones" Width="150px"  BackColor="Maroon" BorderStyle="None" ForeColor="White" OnClick="btnSanciones_Click" />
             
            <br />
            <br />
            <%--<asp:Image ID="Image1" runat="server"  Height="150px" Width="150px"  ImageUrl='<%# Eval("nombrearchivo", "Manejador.ashx?nombrearchivo={0}") %>' />--%>
            <br />
            
        </div>
                 </asp:Panel>
        <br />

                <asp:GridView ID="gwLegajos" runat="server" AutoGenerateColumns="False" 
                 CssClass="table table-striped table-bordered table-hover"                   
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwLegajos_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwLegajos_RowCommand" 
                    onselectedindexchanged="gwLegajos_SelectedIndexChanged" 
                    DataKeyNames="ID,Usuario">
        <Columns>
            <asp:BoundField HeaderText="Legajo" DataField="Legajo" >            
            </asp:BoundField>
            <asp:BoundField DataField="Empleado" HeaderText="Empleado">           
            </asp:BoundField>
            <asp:BoundField DataField="Documento" HeaderText="Documento" >            
            </asp:BoundField>
            <asp:BoundField DataField="Categoria" HeaderText="Categoría" >            
            </asp:BoundField>
            <asp:BoundField DataField="Sector" HeaderText="Sector" >                   
            </asp:BoundField>
            <asp:BoundField DataField="Estado" HeaderText="Estado">            
            </asp:BoundField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" Visible="False" />
        </Columns>       
</asp:GridView>
         
   
         <br />
    <asp:Panel ID="Panel9" runat="server" BackColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px" Height="450px" Visible="False" Width="880px" CssClass="form-control">
        <asp:Label ID="lblCertificados" runat="server" Font-Size="Medium"></asp:Label>
        <br />
        <br />
        <div style="overflow:auto; height: 250px;">
        <asp:GridView ID="gwCertificados" runat="server"  CssClass="table table-striped table-bordered table-hover"  
            AutoGenerateColumns="False" AutoGenerateSelectButton="True" DataKeyNames="Numero" 
            onrowcommand="gwCertificados_RowCommand" 
            onrowdatabound="gwCertificados_RowDataBound" onselectedindexchanged="gwCertificados_SelectedIndexChanged" OnRowDeleting="gwCertificados_RowDeleting" >
            <Columns>
                <asp:BoundField DataField="Fecha" HeaderText="Fecha">
                </asp:BoundField>
                <asp:BoundField DataField="NombreArchivo" HeaderText="Nombre Archivo">
                </asp:BoundField>
                <asp:CommandField ButtonType="Button"  ShowCancelButton="False" ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
            </div>
        <br />
        <asp:FileUpload ID="fuICertificado" runat="server" Width="368px" CssClass="form-control" />
        <br />       
        <asp:Button ID="btnAgregar" runat="server" onclick="btnAgregar_Click" TabIndex="160" Text="Agregar" />
        &nbsp;<asp:Button ID="btnSalir" runat="server" onclick="Button2_Click1" TabIndex="170" Text="Cerrar" />
        <br />
    </asp:Panel>
    <br />
    <br />
    <asp:HiddenField ID="HiddenFieldError" runat="server" />


    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>

    

        <asp:Panel ID="Panel1" runat="server" Height="142px" Width="500px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
            <h2>
                &nbsp;</h2>
                <asp:FileUpload ID="fuImagen" runat="server" />            
            <br />
            <asp:Button ID="btnModificar" runat="server" Enabled="False" onclick="btnModificar_Click" TabIndex="160" Text="Modificar" ValidationGroup="Validar" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Button ID="Button6" runat="server" onclick="Button2_Click1" TabIndex="170" Text="Cerrar" />
            <br />
            <br />
        </asp:Panel>


         <asp:HiddenField ID="HiddenFieldError0" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError0_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError0" 
        PopupControlID="Panel7" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel7" runat="server" Height="94px" Width="334px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center">
            <br />
            <asp:Label ID="LabelErr" runat="server" Text="Label" ForeColor="Black" 
                CssClass="align"></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="Button8" runat="server" onclick="Button2_Click1" 
               Text="Aceptar"  />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>

        </div>
        </form>
        </asp:Content>

