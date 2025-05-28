<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="DIR_Equipamiento.aspx.cs" Inherits="SintecromNet.Paginas.DIR_Equipamiento" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2>Equipamiento Sistemas Sintecrom</h2>
        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success"  Visible="false"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SintecromNet %>" SelectCommand="SP_Traer_Responsables" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
       <div class="panel panel-primary">
            <div class="panel-heading">
                <h4>Equipamiento Sistemas</h4></div>
            <div class="panel-body">                
              <div class="input-group">
                    <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Address" Width="90px" BackColor="#003366" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="txtNetAddress" runat="server" CssClass="form-control" MaxLength="50" TabIndex="20" TextMode="SingleLine" Width="150px"></asp:TextBox>                        
                  <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Usuario" Width="90px" BackColor="#003366" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" MaxLength="50" TabIndex="20" TextMode="SingleLine" Width="150px"></asp:TextBox>
                   <br />   <br />      
                  <asp:Label ID="Label3" runat="server" CssClass="form-control" Text="Equipo" Width="90px" BackColor="#003366" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="txtEquipo" runat="server" CssClass="form-control" MaxLength="50" TabIndex="20" TextMode="SingleLine" Width="150px"></asp:TextBox>
                  <asp:Label ID="Label11" runat="server" CssClass="form-control" Text="Tipo" Width="90px" BackColor="#003366" ForeColor="White"></asp:Label>
                  
                  <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control"  Width="150px">
                    <asp:ListItem Value="0">Todos</asp:ListItem>
                    <asp:ListItem Value="1">Server</asp:ListItem>
                    <asp:ListItem Value="2">PC Escritorio</asp:ListItem>
                    <asp:ListItem Value="3">Virtual</asp:ListItem>
                    <asp:ListItem Value="4">Notebook</asp:ListItem>
                      <asp:ListItem Value="6">Virtualizador</asp:ListItem>
                    <asp:ListItem Value="5">Otros</asp:ListItem>

                </asp:DropDownList>   
                  
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <asp:Button ID="btnBuscar" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click" BackColor="#337AB7" BorderStyle="None" />
                   
              </div>
                         
         
                    
<span style ="float:left;">
                      
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="false" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
                        </span>
                    
                <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" 
                        onrowdatabound="gwIncidentes_RowDataBound" OnPageIndexChanging="gwIncidentes_PageIndexChanging">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Net_address" HeaderText="Net_address">
                            </asp:BoundField>
                             <asp:BoundField DataField="Host" HeaderText="Equipo">
                            </asp:BoundField>                           
                            <asp:BoundField DataField="ip" HeaderText="IP">
                            </asp:BoundField>
                            <asp:BoundField DataField="Usuario" HeaderText="Usuario">
                            </asp:BoundField>
                            <asp:BoundField DataField="Sector" HeaderText="Sector">
                            </asp:BoundField>
                            <asp:BoundField DataField="Tipo" HeaderText="Tipo">
                            </asp:BoundField>
                            <asp:BoundField DataField="Otros" HeaderText="Otros" Visible="false">
                            </asp:BoundField>
                            <asp:BoundField DataField="ID" HeaderText="ID" Visible="false">
                            </asp:BoundField>                                 
                            <asp:BoundField HeaderText="Serie" Visible="False" />
                            <asp:BoundField DataField="Identificador" HeaderText="Ident" Visible="False" />
                            <asp:BoundField DataField="Tipo1" HeaderText="Tipo1" Visible="False" />
                            <asp:BoundField DataField="Otros" HeaderText="Otros" />
                        </Columns>  
                   <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    </asp:GridView> 

                           

           
        </div>
    </div>
 </div>
    </form>
</asp:Content>