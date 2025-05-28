<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MIS_EstadoIncidentes.aspx.cs" Inherits="SintecromNet.Paginas.MIS_EstadoIncidentes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2>Estado de Mis Incidentes</h2>
        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success"  Visible="false"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SintecromNet %>" SelectCommand="SP_Traer_Responsables" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
       <div class="panel panel-primary">
            <div class="panel-heading">
                </div>
            <div class="panel-body">                
              <div class="input-group">
                  <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha Desde:" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>                    
                    <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" placeholder="" Width="160px" TextMode="Date"></asp:Textbox>                     
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
                  
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                    <asp:Button ID="btnBuscar" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click" BackColor="#337AB7" BorderStyle="None" />
               </div>            
                 <br />                   
                    <asp:ImageButton ID="imgDetalle" runat="server" ImageUrl="~/Images/search.png" 
                        style="margin-bottom: 0px; height: 16px;" ToolTip="Editar" 
                        onclick="imgDetalle_Click1" Visible="False" />               
                    <asp:Label ID="lblMensaje" runat="server" Text="Seleccione un Incidente y luego presione el Icono para Ver el detalle" Visible="False"></asp:Label>
                    <asp:GridView ID="gwIncidentes" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" onrowcommand="gwIncidentes_RowCommand" 
                        PageSize="10" allowpaging="true" OnPageIndexChanging="gwIncidentes_PageIndexChanging">
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
                            <asp:BoundField DataField="FechaFinal" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Cierre">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
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
                        </Columns>                      
                    </asp:GridView> 

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
           

           
        </div>
    </div>
 </div>
    </form>
</asp:Content>