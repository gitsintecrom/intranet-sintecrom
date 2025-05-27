<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SIS_Administracion_Incidentes.aspx.cs" Inherits="SintecromNet.Paginas.SIS_Administracion_Incidentes" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">    
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
    <style type="text/css">


        .style19
        {
            width: 301px;
        }
        .style18
        {
            width: 314px;
        }
        


        .style17
        {
            width: 231px;
        }
        .style23
        {
            text-align: left;
        }
        .style21
        {
            width: 154px;
        }
        .style24
        {
            width: 301px;
            height: 26px;
        }
        .style25
        {
            width: 314px;
            height: 26px;
        }
        .style26
        {
            width: 231px;
            height: 26px;
        }
        .align
        {}
        .style27
        {
            width: 231px;
            height: 26px;
            text-align: center;
        }
        .style28
        {
            width: 231px;
            text-align: center;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Administración de incidentes<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT [Id], [Nombre] FROM [Responsables] ORDER BY [Id] DESC"></asp:SqlDataSource>
   
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
   
    </h2>
<p>
    <table style="width:100%;">
        <tr>
            <td width="50%" style="text-align: center">
                <asp:ImageButton ID="imgNuevo" runat="server" ImageUrl="~/Images/add.gif" 
                    ToolTip="Agregar" onclick="imgNuevo_Click" 
                    style="width: 16px; height: 16px;" />
&nbsp;<asp:Label ID="lblMensaje" runat="server" 
                    Text="Presione Agregar para Ingresar un Nuevo Incidente"></asp:Label>
&nbsp;</td>
            <td width="50%">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50%">
<fieldset a 
    style="width: auto; height: auto; " id="Recuadro">
                    <legend>Filtro</legend>
        <table style="margin-left: 12px" __designer:mapid="132">
            <tr __designer:mapid="133">
                <td align="left" class="style19" __designer:mapid="134">
                    Fecha Inicial:</td>
                <td align="left" class="style18" __designer:mapid="135">
                    <asp:TextBox ID="TextBoxIni" runat="server" Width="65px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" 
                        TargetControlID="TextBoxIni" Mask="99/99/9999" CultureName="es-AR" 
                        UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                </td>
                <td align="left" class="style17" __designer:mapid="135">
                    Estado:</td>
                <td align="left" class="style17" __designer:mapid="135">
                <asp:DropDownList ID="DropDownList3" runat="server" Width="100px" TabIndex="20">
                    <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="A">Abierto</asp:ListItem>
                    <asp:ListItem Value="S">Asignado</asp:ListItem>
                    <asp:ListItem Value="C">Cerrado</asp:ListItem>
                </asp:DropDownList>
                </td>
                <td class="style28" __designer:mapid="135">
                    &nbsp;</td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    Fecha Final:</td>
                <td align="left" class="style25" __designer:mapid="135">
                    <asp:TextBox ID="TextBoxFin" runat="server" Width="65px" TabIndex="10"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" PromptCharacter="_" 
                        TargetControlID="TextBoxFin" 
                        Mask="99/99/9999">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                </td>
                <td align="left" class="style26" __designer:mapid="135">
                    Tipo:</td>
                <td align="left" class="style26" __designer:mapid="135">
                <asp:DropDownList ID="DropDownList4" runat="server" Width="100px" TabIndex="30">
                    <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                    <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                    <asp:ListItem Value="Software(No Calipso)">Software(No Calipso)</asp:ListItem>
                    <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                </asp:DropDownList>
                    </td>
                <td class="style27" __designer:mapid="135">
    <asp:Button ID="btnVer" runat="server" onclick="ButtonVer_Click" 
        Text="Buscar" BackColor="Maroon" Font-Bold="False" ForeColor="White" Height="30px" 
                        style="text-align: right" TabIndex="50"  />
                    </td>
            </tr>
            <tr __designer:mapid="133">
                <td align="left" class="style24" __designer:mapid="134">
                    &nbsp;</td>
                <td align="left" class="style25" __designer:mapid="135">
                    &nbsp;</td>
                <td align="left" class="style26" __designer:mapid="135">
                    Asignado a:</td>
                <td align="left" class="style26" __designer:mapid="135">
                <asp:DropDownList ID="ddAsignarB" runat="server" Width="100px" 
                        DataTextField="Nombre" DataValueField="Nombre" 
                    TabIndex="40">
                </asp:DropDownList>
                    </td>
                <td class="style27" __designer:mapid="135">
                    &nbsp;</td>
            </tr>
            </table>
                </fieldset a></td>
            <td style="text-align: center" width="50%">
                &nbsp;<fieldset b 

                </fieldset b 
                    style="width: auto; height: auto; background-color: #800000; color: #FFFFFF;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;<table style="width: 100%;">
                        <tr>
                            <td class="style23">
                                Incidentes Abiertos:</td>
                            <td>
                <asp:Label ID="lblAbiertos" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style23">
                                Incidentes Asignados:</td>
                            <td>
                <asp:Label ID="lblAsignados" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style23">
                                % Demora Asignados:</td>
                            <td>
                <asp:Label ID="lblDemoraA" runat="server"></asp:Label>
                &nbsp;Dias</td>
                        </tr>
                        <tr>
                            <td class="style23">
                                % Demora Cerrados:</td>
                            <td>
                <asp:Label ID="lblDemoraC" runat="server"></asp:Label>
                &nbsp;Dias</td>
                        </tr>
                        <tr>
                            <td class="style23">
                                Indicador Porcentual:&nbsp;&nbsp;</td>
                            <td>
                                <asp:Label ID="lblPorcentual" runat="server"></asp:Label>
                &nbsp;%</td>
                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;&nbsp;</td>
        </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
                <asp:ImageButton ID="imgEditar" runat="server" ImageUrl="~/Images/editar.gif" 
                    style="margin-bottom: 0px; height: 16px;" ToolTip="Editar" 
                    onclick="imgEditar_Click" Visible="False" />               
                <asp:ImageButton ID="imgBorrar" runat="server" ImageUrl="~/Images/eliminar.gif" 
                    ToolTip="Eliminar" onclick="imgBorrar_Click" OnClientClick="return estaseguro()" style="height: 16px;" 
                    Visible="False" />
            </td>
            </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23" colspan="2">
<asp:GridView ID="gwIncidentes" runat="server" AutoGenerateColumns="False" 
        Width="100%" onrowcommand="gwIncidentes_RowCommand" 
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
            <ControlStyle Width="5%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaInicial" HeaderText="Fecha " 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="FechaFinal" HeaderText="Fecha Ultima Modif." 
                DataFormatString="{0:dd/MM/yyyy}" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" >
            <ControlStyle Width="15%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Status" HeaderText="Estado" >
            <ControlStyle Width="10%" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
            <asp:BoundField DataField="Asignado" HeaderText="Asignado A" />
            <asp:BoundField DataField="Comentario" HeaderText="Comentarios" />
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            </td>
            </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23">
                &nbsp;</td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                &nbsp;</td>
        </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23">
                <asp:Label ID="Label4" runat="server" Text="Fecha:" Visible="False" 
                    Width="90px"></asp:Label>
                    <asp:Label ID="lblFecha" runat="server" Visible="False"></asp:Label>
                </td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                &nbsp;</td>
        </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23">
                <asp:Label ID="Label2" runat="server" Text="Solicitante:" Visible="False" 
                    Width="90px"></asp:Label>
                <asp:DropDownList ID="ddSolicitante" runat="server" Width="180px" 
                    Visible="False">
                </asp:DropDownList>
            </td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                &nbsp;</td>
        </tr>
        <tr>
            <td __designer:mapid="134" align="left" class="style23">
                <asp:Label ID="Label5" runat="server" Text="Tipo :" Visible="False" 
                    Width="90px"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="180px" TabIndex="10" 
                    Visible="False">
                    <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                    <asp:ListItem Value="Software(No Calipso)">Software(No Calipso)</asp:ListItem>
                    <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="70%">
                <asp:Label ID="Label3" runat="server" Text="Comentario:" Visible="False" 
                    Width="90px"></asp:Label>
                <asp:TextBox ID="txtComentario" runat="server" MaxLength="1000" 
                    Width="462px" Height="144px" TextMode="MultiLine" TabIndex="20" 
                    Visible="False"></asp:TextBox>
                <br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtComentario" CssClass="failureNotification" 
                    ErrorMessage="El Campo No puede estar vacío" ValidationGroup="Validar"></asp:RequiredFieldValidator>
                </td>
            <td style="text-align: center" width="50%">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50%">
                <asp:Label ID="Label1" runat="server" Text="Asignar a:" Visible="False" 
                    Width="90px"></asp:Label>
                <asp:DropDownList ID="ddAsignar" runat="server" Width="180px" 
                    DataSourceID="SqlDataSource1" DataTextField="Nombre" DataValueField="Nombre" 
                    TabIndex="30" Visible="False">
                </asp:DropDownList>
            </td>
            <td style="text-align: center" width="50%">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50%">
                <asp:Label ID="Label6" runat="server" Text="Estado :" Visible="False" 
                    Width="90px"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" Width="180px" TabIndex="10" 
                    Visible="False">
                    <asp:ListItem Value="A">Abierto</asp:ListItem>
                    <asp:ListItem Value="S">Asignado</asp:ListItem>
                    <asp:ListItem Value="C">Cerrado</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td style="text-align: center" width="50%">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50%">
                <asp:Label ID="Label7" runat="server" Text="Imagen:" Visible="False" 
                    Width="90px"></asp:Label>
                <asp:Button ID="btnImagen" runat="server" BackColor="#CCCCCC" 
                    onclick="btnImagen_Click" Text="Ver Imagen" Visible="False" Width="180px" />
            </td>
            <td style="text-align: center" width="50%">
                &nbsp;</td>
        </tr>
        <tr>
            <td width="50%" colspan="2" style="width: 100%; text-align: center">
        <asp:Button ID="btnAceptar" runat="server" BackColor="Maroon" 
            Font-Names="Arial" ForeColor="White" onclick="btnAceptar_Click" Text="Aceptar" 
            ValidationGroup="Validar" Visible="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnCancelar" runat="server" BackColor="White" 
            Font-Names="Arial" ForeColor="Maroon" onclick="btnCancelar_Click" Text="Cancelar" 
                    Visible="False" style="text-align: left" />
            </td>
        </tr>
        <tr>
            <td width="50%" colspan="2" style="width: 100%; text-align: center">
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
            </td>
        </tr>
    </table>
   
    </p>
    <p>
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
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Timer ID="Timer1" runat="server" ontick="Timer1_Tick">
</asp:Timer>
    <p>
        &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    </asp:Content>
