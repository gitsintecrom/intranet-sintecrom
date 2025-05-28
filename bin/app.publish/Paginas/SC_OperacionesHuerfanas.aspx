<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SC_OperacionesHuerfanas.aspx.cs" Inherits="SintecromNet.Paginas.SC_OperacionesHuerfanas" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h1>Operaciones Huerfanas</h1>
        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success"  Visible="false"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SintecromNet %>" SelectCommand="SP_Traer_Responsables" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
       <div class="panel panel-primary">
            <div class="panel-heading">
                </div>
            <div class="panel-body">                
              <div class="input-group">
                  <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Maquina" Width="130px" BackColor="#003366" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control" TabIndex="30" Width="160px">
                        <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                        <asp:ListItem Value="SL1">Slitter 1</asp:ListItem>
                        <asp:ListItem Value="SL2">Slitter 2</asp:ListItem>
                        <asp:ListItem Value="SL3">Slitter 3</asp:ListItem>
                        <asp:ListItem Value="PL1">Plancha 1</asp:ListItem>
                        <asp:ListItem Value="PL2">Plancha 2</asp:ListItem>
                        <asp:ListItem Value="PL3">Plancha 3</asp:ListItem>
                        <asp:ListItem>Pintado</asp:ListItem>
                        <asp:ListItem>Embalaje</asp:ListItem>
                        <asp:ListItem Value="HOR">Horno</asp:ListItem>
                        <asp:ListItem Value="Todos">Todos</asp:ListItem>
                    </asp:DropDownList>
                   </div>
                 <br />               
                <div class="input-group">
                  
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                    <asp:Button ID="btnVer" runat="server" class="btn btn-success btn-circle" Visible="True" width="130" Text="Buscar" OnClick="btnBuscar_Click" BackColor="#337AB7" BorderStyle="None" />
               </div>            
                 <asp:ImageButton ID="btnExcel" runat="server" Height="51px" ImageAlign="Middle" ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" ToolTip="Exportar a Excel" Visible="False" Width="53px" />
                 <br />                   
                    <asp:GridView ID="gwIncidentes" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" allowpaging="False" HorizontalAlign="Center">
                    <%--<HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White" />--%>
                        <EditRowStyle BackColor="#ffffcc" />
                        <EmptyDataRowStyle forecolor="Red" CssClass="table table-bordered" />
                        <emptydatatemplate>
                           No Existen datos para los Filtros seleccionados!  
                        </emptydatatemplate>
                  
 
                        <Columns>
                            <asp:BoundField DataField="Operacion" HeaderText="Operacion">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="SerieLote" HeaderText="Serie Lote">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Matching" HeaderText="Matching">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Maquina" HeaderText="Maquina">
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Batch" HeaderText="Batch">
                            <ItemStyle HorizontalAlign="Center"/>
                            </asp:BoundField>
                        </Columns>                      
                    </asp:GridView> 

                    <br />
                    <br />      
           

           
        </div>
    </div>
 </div>
    </form>
</asp:Content>