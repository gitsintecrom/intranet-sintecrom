<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MAN_Administracion_Incidentes.aspx.cs" Inherits="SintecromNet.Paginas.MAN_Administracion_Incidentes" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">    
     function estaseguro() {

         if (!confirm('Esta Seguro de Eliminar el Incidente Seleccionado?')) return false;
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
    <h2>Administración de incidentes de Mantenimiento</h2>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT [Id], [Nombre] FROM [Responsables] ORDER BY [Id] DESC"></asp:SqlDataSource>
   
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        
  
                <asp:ImageButton ID="imgNuevo" runat="server" ImageUrl="~/Images/add.gif" 
                    ToolTip="Agregar" onclick="imgNuevo_Click" 
                    style="width: 16px; height: 16px;" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" 
                    Text="Presione Agregar para Ingresar un Nuevo Incidente"></asp:Label>

                <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">

                 <asp:Label ID="Label9" runat="server" CssClass="form-control" Width="120px" Text="Fecha Desde:" BackColor="#337AB7" ForeColor="White"></asp:Label>
                         <asp:TextBox ID="TextBoxIni" CssClass="form-control"  runat="server" Width="120px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" 
                        TargetControlID="TextBoxIni" Mask="99/99/9999" CultureName="es-AR" 
                        UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                        <asp:Label ID="Label10" runat="server" CssClass="form-control" Width="120px" BackColor="#337AB7" ForeColor="White" Text="Fecha Hasta:"></asp:Label>
                         <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control"  Width="120px" TabIndex="10"></asp:TextBox>
                    <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" 
                        AutoComplete="False" MaskType="Date" PromptCharacter="_" 
                        TargetControlID="TextBoxFin" 
                        Mask="99/99/9999">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                        
                        <asp:Label ID="Label11" runat="server" CssClass="form-control" Width="120px" BackColor="#337AB7" ForeColor="White" Text="Estado:"></asp:Label>
                    <asp:DropDownList ID="DropDownList3" runat="server" Width="120px" CssClass="form-control" TabIndex="20">
                    <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="A">Abierto</asp:ListItem>
                    <asp:ListItem Value="S">Asignado</asp:ListItem>
                    <asp:ListItem Value="C">Cerrado</asp:ListItem>
                </asp:DropDownList>     
                        </br>
                         </br>
                                    
                <asp:Label ID="Label12" runat="server" CssClass="form-control" Width="120px" BackColor="#337AB7" ForeColor="White" Text="Tipo:"></asp:Label>
                <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control" Width="120px" TabIndex="30">
                    <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="Mecanico-Mantenimiento">Mecanico-Mantenimiento</asp:ListItem>
                    <asp:ListItem></asp:ListItem>
                    <asp:ListItem Value="Electrico">Mecanico-Mejora</asp:ListItem>
                    <asp:ListItem>Electrico-Mantenimiento</asp:ListItem>
                    <asp:ListItem Value="Electronico-Mantenimiento">Electronico-Mantenimiento</asp:ListItem>
                    <asp:ListItem>Electronico-Mejora</asp:ListItem>
                    <asp:ListItem>Electrico-MejoraEdilicio-Mantenimiento</asp:ListItem>
                    <asp:ListItem>Edilicio-Mejora</asp:ListItem>
                </asp:DropDownList>                   
                <asp:Label ID="Label13" runat="server" CssClass="form-control" Width="120px" BackColor="#337AB7" ForeColor="White" Text="Asignado:"></asp:Label>

                <asp:DropDownList ID="ddAsignarB" runat="server" CssClass="form-control" Width="120px" 
                        DataTextField="Nombre" DataValueField="Nombre" 
                    TabIndex="40">
                </asp:DropDownList>  
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        <asp:Button ID="btnVer" runat="server" onclick="ButtonVer_Click" 
                Text="Buscar" Font-Bold="False" ForeColor="White" Width="130px" 
                       CssClass="btn btn-success btn-circle"  />                
           
   
    </div>
                    </div>
                    </div>
              
                          
            
                <asp:ImageButton ID="imgEditar" runat="server" ImageUrl="~/Images/editar.gif" 
                    style="margin-bottom: 0px; height: 16px;" ToolTip="Editar" 
                    onclick="imgEditar_Click" Visible="False" />               
                <asp:ImageButton ID="imgBorrar" runat="server" ImageUrl="~/Images/eliminar.gif" 
                    ToolTip="Eliminar" onclick="imgBorrar_Click" OnClientClick="return estaseguro()" style="height: 16px;" 
                    Visible="False" />
            
<asp:GridView ID="gwIncidentes" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-striped table-bordered table-hover"  onrowcommand="gwIncidentes_RowCommand" 
                    onrowdatabound="gwIncidentes_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="Seleccionar">
                <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" />
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:TemplateField>
            <asp:BoundField DataField="Numero" HeaderText="Numero" >
            </asp:BoundField>
            <asp:BoundField DataField="FechaInicial" HeaderText="Fecha " 
                DataFormatString="{0:dd/MM/yyyy}" >
            </asp:BoundField>
            <asp:BoundField DataField="FechaFinal" HeaderText="Fecha Ultima Modif." 
                DataFormatString="{0:dd/MM/yyyy}" >
            </asp:BoundField>
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
            </asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Estado" >
            </asp:BoundField>
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
            <asp:BoundField DataField="Asignado" HeaderText="Asignado A" />
            <asp:BoundField DataField="Comentario" HeaderText="Comentarios" />
        </Columns>
        
</asp:GridView>
        <div class="input-group">
       
                <asp:Label ID="Label4" runat="server" Text="Fecha:" Visible="False" 
                    Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                    <asp:Label ID="lblFecha" runat="server" Visible="False" CssClass="form-control" Width="200px"></asp:Label>
                </br></br>
                <asp:Label ID="Label2" runat="server" Text="Solicitante:" Visible="False" 
                    Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="ddSolicitante" runat="server" Width="200px" 
                    Visible="False" CssClass="form-control">
                </asp:DropDownList>
            </br> </br>
                <asp:Label ID="Label5" runat="server" Text="Tipo :" Visible="False" 
                    Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                
                <asp:DropDownList ID="DropDownList1" runat="server" Width="200px" Visible="False" CssClass="form-control">
                    <asp:ListItem>Mecanico-Mantenimiento</asp:ListItem>
                    <asp:ListItem>Mecanico-Mejora</asp:ListItem>
                    <asp:ListItem>Electrico-Mantenimiento</asp:ListItem>
                    <asp:ListItem>Electrico-Mejora</asp:ListItem>
                    <asp:ListItem>Electronico-Mantenimiento</asp:ListItem>
                    <asp:ListItem>Electronico-Mejora</asp:ListItem>
                    <asp:ListItem>Edilicio-Mantenimiento</asp:ListItem>
                    <asp:ListItem>Edilicio-Mejora</asp:ListItem>
                </asp:DropDownList>
         </br>
         </br>
            
                <asp:Label ID="Label3" runat="server" Text="Comentario:" Visible="False" 
                    Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtComentario" runat="server" MaxLength="1000" 
                    Width="400px" Height="144px" TextMode="MultiLine" TabIndex="20" 
                    Visible="False" CssClass="form-control"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtComentario" CssClass="failureNotification" 
                    ErrorMessage="El Campo No puede estar vacío" ValidationGroup="Validar"></asp:RequiredFieldValidator>
               </br>
         </br>
        
                <asp:Label ID="Label1" runat="server" Text="Asignar a:" Visible="False" 
                    Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="ddAsignar" runat="server" Width="200px" 
                    DataSourceID="SqlDataSource1" DataTextField="Nombre" DataValueField="Nombre" 
                    TabIndex="30" Visible="False" CssClass="form-control">
                </asp:DropDownList>
            </br>
         </br>
            
                <asp:Label ID="Label6" runat="server" Text="Estado :" Visible="False" 
                    Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" Width="200px" TabIndex="10" 
                    Visible="False" CssClass="form-control">
                    <asp:ListItem Value="A">Abierto</asp:ListItem>
                    <asp:ListItem Value="S">Asignado</asp:ListItem>
                    <asp:ListItem Value="C">Cerrado</asp:ListItem>
                </asp:DropDownList>
           </br>
         </br>
                <asp:Label ID="Label7" runat="server" Text="Imagen:" Visible="False" 
                    Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:Button ID="btnImagen" runat="server" BackColor="#CCCCCC" 
                    onclick="btnImagen_Click" Text="Ver Imagen" Visible="False" Width="180px" CssClass="form-control" />
         
         </br>
        <asp:Button ID="btnAceptar" runat="server"
            Font-Names="Arial" ForeColor="White" onclick="btnAceptar_Click" Text="Aceptar" cssclass="btn btn-success btn-circle" Width="200px"
            ValidationGroup="Validar" Visible="False" />
           
         &nbsp;<asp:Button ID="btnCancelar" runat="server" onclick="btnCancelar_Click" Text="Cancelar" backcolor="Red"
                    Visible="False" cssclass="btn btn-success btn-circle" Width="200px" BorderStyle="None"  />
     </div>    
           
<asp:GridView ID="gwComentarios" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowcommand="gwIncidentes_RowCommand">
        <Columns>
            <asp:BoundField DataField="FechaComentario" HeaderText="Fecha " 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="5%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="UsuarioCom" HeaderText="Usuario">
            <HeaderStyle Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="Descripcion" HeaderText="Comentarios" >
            <ControlStyle Width="85%" />
            </asp:BoundField>
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
           
   
         <asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="120px" Width="326px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center">
            <br />
            <asp:Label ID="LabelErr" runat="server" Text="Label" ForeColor="Black" 
                CssClass="align"></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
               Text="Aceptar" />
           
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <p>
            &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
        </div>
        </form>
    </asp:Content>
