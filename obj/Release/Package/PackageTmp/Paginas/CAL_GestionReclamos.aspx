<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CAL_GestionReclamos.aspx.cs" Inherits="SintecromNet.Paginas.CAL_GestionReclamos" %>
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
    <h2>Gestión de Reclamos</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">              
                    
                    <div class="input-group">
                        <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Cliente:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtCliente" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                       
                        <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="Reclamo:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>               
                        <asp:TextBox ID="txtReclamo" runat="server" CssClass="form-control" Width="130px"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="Label20" runat="server" cssclass="form-control" Text="Estado:" Width="130px" BackColor="#337AB7" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList1"  cssclass="form-control" runat="server" Width="150px">
                <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                <asp:ListItem Value="Pendiente">Pendientes</asp:ListItem>
                <asp:ListItem Value="Rechazado">Rechazado</asp:ListItem>
                <asp:ListItem>En Proceso</asp:ListItem>
                <asp:ListItem Value="Anulado">Anulado</asp:ListItem>
                <asp:ListItem>Cerrado</asp:ListItem>
            </asp:DropDownList>
                        &nbsp;
                        <asp:Button ID="btnVer0" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click"   />
                    </div>
                </div>
        </div>
        
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="ID,Contacto,Caracteristicas,Motivo,Emite,Observaciones,ReclamoExterno,Cliente,Responsable,Grupo" 
                    OnRowCommand="gwGrilla_RowCommand" OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged" OnRowDataBound="gwGrilla_RowDataBound">
        <Columns>
           
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
            
            <asp:ButtonField ButtonType="Button" CommandName="Detalle" HeaderText="Ver Detalle" ControlStyle-CssClass="btn btn-info" Text="Ver Detalle" >
<ControlStyle CssClass="btn btn-info"></ControlStyle>
            </asp:ButtonField>
            <asp:ButtonField ButtonType="Button" CommandName="Gestion" HeaderText="Gestión"  ControlStyle-CssClass="btn btn-warning" Text="Gestión" >
<ControlStyle CssClass="btn btn-warning"></ControlStyle>
            </asp:ButtonField>
            <asp:ButtonField ButtonType="Button" CommandName="Respuesta" HeaderText="Respuesta"  ControlStyle-CssClass="btn btn-primary" Text="Respuesta" >
<ControlStyle CssClass="btn btn-primary"></ControlStyle>
            </asp:ButtonField>
            <asp:ButtonField ButtonType="Button" CommandName="Envio" HeaderText="Envío"  ControlStyle-CssClass="btn btn-success" Text="Envío" >

<ControlStyle CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
               <%-- <br />
                <br />
                <br /> --%> 
        
      <asp:HiddenField ID="HiddenFieldError" runat="server" />          
    <asp:Panel ID="Panel1" runat="server" 
        Height="550px" Width="600px" style="overflow:auto; height:600px; "
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
                Text="Salir" TabIndex="170" BackColor="#669999" BorderStyle="None"  />
                 
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
            <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-success" onclick="btnAgregar_Click2" TabIndex="160" Text="Agregar" />
        &nbsp;<asp:Button ID="btnSalir" runat="server" CssClass="btn btn-danger" onclick="btnSalir_Click" TabIndex="170" Text="Cerrar" />
        <br />
                

    </asp:Panel>
        <asp:HiddenField ID="HiddenField2" runat="server" />
        <asp:Panel ID="Panel2" runat="server" BackColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px" height="600px" Width="660px" 
            style="overflow:auto; height:600px; " CssClass="form-control">
       
            <br />
        
            <asp:Label ID="Label19" runat="server" BackColor="#003366" CssClass="form-control" Font-Bold="True" Font-Size="Medium" ForeColor="White" style="text-align:center" Width="630px"></asp:Label>
            
            <%--<asp:GridView ID="gwSeguimiento" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No existen Adjuntos Para El Reclamo Seleccionado" onrowdatabound="gwSeguimiento_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Grupo" HeaderText="Grupo" />
                    <asp:BoundField DataField="Responsable" HeaderText="Responsable" />
                    <asp:BoundField DataField="Acciones" HeaderText="Acciones" />
                    <asp:BoundField DataField="Definiciones" HeaderText="Definiciones" />
                </Columns>
            </asp:GridView>--%>
           
            <asp:Label ID="Label18" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fecha:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtFecha" runat="server" cssclass="form-control" ReadOnly="True" Width="350px"></asp:TextBox>
            <%--<br />--%>
           
            <asp:Label ID="Label17" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Dueño Proceso:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtResponsable" runat="server" cssclass="form-control" Width="350px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtResponsable" CssClass="alert-danger" Display="Dynamic" ErrorMessage="El Campo Fecha No puede Estar Vacio" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
            <br />
            
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Grupo:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtGrupo" runat="server" cssclass="form-control" Width="550px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtGrupo" CssClass="alert-danger" Display="Dynamic" ErrorMessage="El Campo Fecha No puede Estar Vacio" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
            
            <asp:Label ID="Label15" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Definiciones:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtDefiniciones" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="550px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtDefiniciones" CssClass="alert-danger" Display="Dynamic" ErrorMessage="El Campo Fecha No puede Estar Vacio" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
            
            <asp:Label ID="Label16" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Acciones:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtAcciones" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="550px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtAcciones" CssClass="alert-danger" Display="Dynamic" ErrorMessage="El Campo Fecha No puede Estar Vacio" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
        
            <br />
        
        <asp:Button ID="Button2" runat="server" CssClass="btn btn-success" TabIndex="160" Text="Agregar" OnClick="Button2_Click2" />
        &nbsp;<asp:Button ID="Button3" runat="server" CssClass="btn btn-danger" TabIndex="170" Text="Cerrar" OnClick="Button3_Click" />
        <br />
    </asp:Panel>
         <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" 
        TargetControlID="HiddenField2" 
        PopupControlID="Panel2" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modal-scrollbar-measure">
    </asp:ModalPopupExtender>
        <asp:HiddenField ID="HiddenField3" runat="server" />
        <asp:ModalPopupExtender ID="ModalPopupExtender3" runat="server" 
        TargetControlID="HiddenField3" 
        PopupControlID="Panel3" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modal-scrollbar-measure">
    </asp:ModalPopupExtender>

        <asp:Panel ID="Panel3" runat="server" BackColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px" Height="550px" Visible="True" Width="660px" CssClass="form-control">
        <asp:Label ID="Label23" runat="server" Font-Size="Medium" BackColor="#003366" CssClass="form-control" Font-Bold="True" ForeColor="White" style="text-align:center" Width="630px"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label21" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Causa:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCausa" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="550px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtCausa" CssClass="alert-danger" Display="Dynamic" ErrorMessage="El Campo Causa No puede Estar Vacio" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
            <asp:Label ID="Label22" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Corrección:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCorreccion" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="550px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtCorreccion" CssClass="alert-danger" Display="Dynamic" ErrorMessage="El Campo Corrección No puede Estar Vacio" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
            <br />
            <asp:Label ID="Label24" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Kilos Aceptados:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtKilosAceptados" runat="server" cssclass="form-control" style="text-align: right" Width="150px">0</asp:TextBox>
            <asp:Label ID="Label25" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="SAC:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtSAC" runat="server" cssclass="form-control"  style="text-align: right" Width="150px">0</asp:TextBox>
       
        <br />       
        <asp:Button ID="Button4" runat="server" onclick="Button4_Click" TabIndex="160" Text="Agregar" CssClass="btn btn-success" />
        &nbsp;<asp:Button ID="Button5" runat="server" onclick="Button5_Click" TabIndex="170" Text="Salir" CssClass="btn btn-danger" />
            <br />
            <br />
        <br />
    </asp:Panel>

        
       <asp:Panel ID="Panel5" runat="server" BackColor="#CCCCFF" BorderStyle="Outset" BorderWidth="3px" Height="65px" Visible="False" Width="660px">
           &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:ImageButton ID="ImageButton2" runat="server" OnClick="ImageButton2_Click" Height="60px" style="text-align:left" ImageUrl="~/Images/icono-pdf.jpg" Visible="True" Width="70px" />
           
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <asp:ImageButton ID="ImageButton3" runat="server" Height="60px" ImageUrl="~/Images/salir.png" OnClick="ImageButton3_Click" style="text-align:right" Visible="True" Width="70px" />
           
    </asp:Panel>
        <asp:Panel ID="Panel4" runat="server" BackColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px" Height="550px" Visible="False" Width="660px">
                                      
                <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
        <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <div style="float:left;">
               <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Logo1.jpg" Height="70px" Width="90px" /></div>
                    <b><asp:Label ID="Label26" runat="server" Font-Size="15pt"  Font-Bold="True" ForeColor="White" style="text-align:center" Width="540px" BorderStyle="None"></asp:Label></b>
            </td>
        </tr>
        <tr>
            <td><b>Material:
                <asp:Label ID="lblMaterial" runat="server" Font-Size="11pt"></asp:Label>&nbsp;Caracteristicas:
                <asp:Label ID="lblCaracteristicas" runat="server" Font-Size="11pt"></asp:Label>
                </b></td>                     
        </tr> 
        <tr>
            <td>
            <b>Remito:
                <asp:Label ID="lblRemito" runat="server" Font-Size="11pt"></asp:Label>&nbsp;Serie/Lote:
                <asp:Label ID="lblSL" runat="server" Font-Size="11pt"></asp:Label>
                &nbsp;Reclamo Cliente:
                <asp:Label ID="lblReclamoExterno" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
                     <tr>
            <td>
                
                    <b>Contacto Cliente:
                <asp:Label ID="lblContacto" runat="server" Font-Size="11pt"></asp:Label>&nbsp;Email:
                <asp:Label ID="lblEmail" runat="server" Font-Size="11pt"></asp:Label> &nbsp;Cantidad:
                <asp:Label ID="lblCantidad" runat="server" Font-Size="11pt"></asp:Label>
               </b>
            </td>
        </tr>
                         
    </table>                       
           
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <asp:Label ID="Label3" runat="server" Font-Size="12pt" Text="Motivo" ForeColor="White"></asp:Label>
                    </td>
        </tr>
                 <tr>
            <td>
            <b>
                <asp:Label ID="lblMotivo" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                
                    <b>Emite:
                <asp:Label ID="lblEmite" runat="server" Font-Size="11pt" ForeColor="White"></asp:Label>&nbsp;Aprueba:
                <asp:Label ID="Label8" runat="server" Font-Size="11pt" Text="Gastón Broide" ForeColor="White"></asp:Label>
               </b>
            </td>
        </tr>
                 <tr>
            <td>
            <b>Observaciones:
                <asp:Label ID="lblObservaciones" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
                
    </table>
           
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <asp:Label ID="Label6" runat="server" Font-Size="12pt" Text="Analisis de la Causa" ForeColor="White"></asp:Label>
                    </td>
        </tr>
                 <tr>
            <td>
            <b>
                <asp:Label ID="lblCausa" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>
             
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <asp:Label ID="Label9" runat="server" Font-Size="12pt" Text="Acción Inmediata" ForeColor="White"></asp:Label>
                    </td>
        </tr>
                 <tr>
            <td>
            <b>
                <asp:Label ID="lblCorreccion" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>
            
                    <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <b>Aprueba:<asp:Label ID="Label10" runat="server" Font-Size="11pt" Text=" Gastón Broide" ForeColor="White"></asp:Label>
                    
                &nbsp;Kilos Aceptados:<asp:Label ID="lblKilosAceptados" runat="server" Font-Size="11pt"  ForeColor="White"></asp:Label>
            </b></td>
        </tr>
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
            <b>
                 SAC:&nbsp;<asp:Label ID="lblSAC" runat="server" Font-Size="11pt"></asp:Label>
                 Estado:&nbsp;<asp:Label ID="lblEstado" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
                         <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
            <b>
                 Fecha Respuesta:&nbsp;<asp:Label ID="lblFechaRespuesta" runat="server" Font-Size="11pt"></asp:Label>
                 Informe Impreso el:&nbsp;<asp:Label ID="lblFechaHoy" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>

            
    </asp:Panel>
       
          <br />
             <br />
             <br />
        </div>
    </form>
        </asp:Content>

