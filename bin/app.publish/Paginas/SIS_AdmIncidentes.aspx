<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SIS_AdmIncidentes.aspx.cs" Inherits="SintecromNet.Paginas.SIS_AdmIncidentes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2>Administración de Incidentes</h2>
        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success"  Visible="false"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SintecromNet %>" SelectCommand="SP_Traer_Responsables" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
       <div class="panel panel-primary">
            <div class="panel-heading">
                <h4><asp:Button ID="btnAgregar" runat="server" class="btn btn-success btn-circle" Text="+" Font-Bold="True" Font-Size="Medium" OnClick="btnAgregar_Click"/>Agregar Un Nuevo Incidente</h4></div>
            <div class="panel-body">                
              <div class="input-group">
                  <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>                    
                    <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" placeholder="" Width="160px" TextMode="Date"></asp:Textbox>
                    <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Estado" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                     <asp:DropDownList ID="DropDownList3" CssClass="form-control" runat="server" TabIndex="20" Width="160px">
                        <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                        <asp:ListItem Value="A">Abierto</asp:ListItem>
                        <asp:ListItem Value="S">Asignado</asp:ListItem>
                        <asp:ListItem Value="C">Cerrado</asp:ListItem>
                    </asp:DropDownList>
                  <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Tipo" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="DropDownList4" runat="server" CssClass="form-control" TabIndex="30" Width="160px">
                        <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                        <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                        <asp:ListItem Value="Software">Software</asp:ListItem>
                        <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                        <asp:ListItem Value="SRP">SRP</asp:ListItem>
                        <asp:ListItem Value="Intranet">Intranet</asp:ListItem>
                    </asp:DropDownList>
                   </div>
                 <br />               
                <div class="input-group">
                    <asp:Label ID="Label6" runat="server" CssClass="form-control" Text="Fecha Hasta:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>                    
                    <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" placeholder="" Width="160px" TextMode="Date"></asp:Textbox>                                  
                  
                    <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="Asignado A" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                        <asp:DropDownList ID="ddAsignarB" runat="server" CssClass="form-control" DataTextField="Nombre" DataValueField="Nombre" TabIndex="40" Width="160px">
                        </asp:DropDownList> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                    <asp:Button ID="btnBuscar" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click" BackColor="#337AB7" BorderStyle="None" />
               </div>            
                 <br />                   
                    <asp:ImageButton ID="imgEditar" runat="server" ImageUrl="~/Images/editar.gif" 
                        style="margin-bottom: 0px; height: 16px;" ToolTip="Editar" 
                        onclick="imgEditar_Click" Visible="False" />               
                    <asp:ImageButton ID="imgBorrar" runat="server" ImageUrl="~/Images/eliminar.gif" 
                        ToolTip="Eliminar" onclick="imgBorrar_Click" OnClientClick="return estaseguro()" style="height: 16px; width: 16px;" 
                        Visible="False" />   
                 <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="~/Images/exc.jpg" 
                         style="margin-bottom: 0px; height: 16px;"
                        ToolTip="Exportar a Excel" onclick="imgExcel_Click" 
                        Visible="False" />          

                 <%--   <asp:ImageButton ID="imgExcel" runat="server" ImageUrl="~/Images/exc.jpg" 
                         style="height: 16px; width: 16px;"" ToolTip="Exportar a Excel" 
                        onclick="" Visible="False" />--%>
                    <asp:GridView ID="gwIncidentes" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" onrowcommand="gwIncidentes_RowCommand">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:TemplateField HeaderText="Seleccionar">
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="CheckBox2" runat="server" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="Numero" HeaderText="Numero">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaInicial" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha ">
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="FechaInicial" DataFormatString="{0:HH:mm}" HeaderText="Hora" />
                            <asp:BoundField DataField="Tipo" HeaderText="Tipo">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Status" HeaderText="Estado">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Usuario" HeaderText="Usuario">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Asignado" HeaderText="Asignado">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Comentario" HeaderText="Comentarios">
                            <ItemStyle Font-Size="8pt" HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="Respuesta" HeaderText="Respuesta">
                                <ItemStyle Font-Size="8pt" HorizontalAlign="Center"/>
                            </asp:BoundField>
                        </Columns>                      
                    </asp:GridView> 

                <div class="input-group">
                        <asp:Label ID="Label8" runat="server" ForeColor="White" Text="Fecha:" Width="90px" CssClass="form-control" Visible="False" BackColor="#003366"></asp:Label>                        
                        <asp:Label ID="lblFecha" runat="server" ForeColor="Black" Visible="False" CssClass="form-control" Width="120px"></asp:Label>
                        <br />
                        <br />
                        <asp:Label ID="Label9" runat="server" ForeColor="White" Text="Solicitante:" Visible="False" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:DropDownList ID="ddSolicitante" runat="server" CssClass="form-control" Visible="False" Width="180px"></asp:DropDownList>
                        <br />
                        <br />
                        <asp:Label ID="Label10" runat="server" ForeColor="White" Text="Tipo :" Visible="False" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" TabIndex="10" Visible="False" Width="180px">
                            <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                            <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                            <asp:ListItem Value="Software">Software</asp:ListItem>
                            <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                            <asp:ListItem Value="SRP">SRP</asp:ListItem>
                            <asp:ListItem Value="Intranet">Intranet</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        <asp:Label ID="Label3" runat="server" ForeColor="White" Text="Comentario:" Visible="False" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:TextBox ID="txtComentario" runat="server" CssClass="form-control" Height="59px" MaxLength="1000" TabIndex="20" TextMode="MultiLine" Visible="False" Width="462px"></asp:TextBox>
                        <br />
                        <br />
                        <asp:Label ID="Label11" runat="server" ForeColor="White" Text="Asignar a:" Visible="False" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:DropDownList ID="ddAsignar" runat="server" CssClass="form-control" DataTextField="Nombre" DataValueField="Nombre" TabIndex="30" Visible="False" Width="180px" DataSourceID="SqlDataSource1">
                        </asp:DropDownList>
                        <br />
                        <br />
                        <br />
                        <asp:Label ID="Label7" runat="server" ForeColor="White" Text="Imagen:" Visible="False" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:Button ID="btnImagen" runat="server" BackColor="#CCCCCC" onclick="btnImagen_Click" Text="Ver Imagen" Visible="False" Width="180px" CssClass="form-control" />
                        <br />
                        <br />
                        <asp:Label ID="Label12" runat="server" ForeColor="White" Text="Estado :" Visible="False" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" TabIndex="10" Visible="False" Width="180px">
                            <asp:ListItem Value="A">Abierto</asp:ListItem>
                            <asp:ListItem Value="S">Asignado</asp:ListItem>
                            <asp:ListItem Value="C">Cerrado</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        <br />
                        <asp:Button ID="btnAceptar" runat="server" class="btn btn-success btn-circle" Visible="False" width="130" Text="Aceptar" OnClick="btnAceptar_Click" />&nbsp;&nbsp;
                        <asp:Button ID="btnCancelar" runat="server" class="btn btn-danger btn-circle" Visible="False" width="130" Text="Cancelar" OnClick="btnCancelar_Click" />
                       
                     </div>
                    <br />
                    <br />
                    <br />
                    <br />
                        <asp:GridView ID="gwComentarios" runat="server" AutoGenerateColumns="False" onrowcommand="gwIncidentes_RowCommand" CssClass="table table-striped table-bordered table-hover">
                            <Columns>
                                <asp:BoundField DataField="FechaComentario" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha ">
                                <ItemStyle ForeColor="Black" HorizontalAlign="Center" VerticalAlign="Middle" />
                                </asp:BoundField>
                                <asp:BoundField DataField="UsuarioCom" HeaderText="Usuario">
                                <ItemStyle ForeColor="Black" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Descripcion" HeaderText="Comentarios">
                                <ItemStyle ForeColor="Black" />
                                </asp:BoundField>
                            </Columns>
                        </asp:GridView>
                    <br />      
           

           
                <a href="../Images/">Images</a></div>
    </div>
 </div>
    </form>
</asp:Content>