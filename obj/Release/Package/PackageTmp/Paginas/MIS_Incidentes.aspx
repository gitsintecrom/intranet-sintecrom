<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MIS_Incidentes.aspx.cs" Inherits="SintecromNet.Paginas.MIS_Incidentes" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <style type="text/css">

        .style23
        {
            width: 267px;
            text-align: center;
        }
        .style21
        {
            width: 154px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <h2>Incidentes</h2>
        <asp:Label ID="lblMsg" runat="server" CssClass="alert alert-success"  Visible="false"></asp:Label>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
       <div class="panel panel-primary">
            <div class="panel-heading">
                <h4>Agregar Un Nuevo Incidente</h4></div>
            <div class="panel-body">                
              <div class="input-group">
                  <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Fecha:" Width="90px" BackColor="#003366" ForeColor="White"></asp:Label>                    
                    <asp:Label ID="lblFecha" runat="server" CssClass="form-control" Text="Estado" Width="90px" BackColor="White"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Usuario:" Width="90px" BackColor="#003366" ForeColor="White"></asp:Label>
                    <asp:Label ID="lblUsuario" runat="server" CssClass="form-control" Width="90px"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                    
                    <asp:Label ID="Label14" runat="server" CssClass="form-control" Text="Sector:" Width="90px" BackColor="#003366" ForeColor="White"></asp:Label>                    
                    <asp:Label ID="lblSector" runat="server" CssClass="form-control" Width="90px"></asp:Label>                    
                   </div>
                 <br />               
                 <br />                   

                <div class="input-group">
                        <asp:Label ID="Label10" runat="server" ForeColor="White" Text="Tipo :" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" TabIndex="10" Width="180px">
                            <asp:ListItem Value="0">Seleccione...</asp:ListItem>
                            <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                            <asp:ListItem Value="Software">Software</asp:ListItem>
                            <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                            <asp:ListItem Value="SRP">SRP</asp:ListItem>
                            <asp:ListItem Value="Intranet">Intranet</asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <br />
                        <asp:Label ID="Label3" runat="server" ForeColor="White" Text="Comentario:" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <asp:TextBox ID="txtComentario" runat="server" CssClass="form-control" Height="59px" MaxLength="1000" TabIndex="20" TextMode="MultiLine" Width="462px"></asp:TextBox>
                        <br />
                        <br />
                        <br />
                        <br />
                        <asp:Label ID="Label7" runat="server" ForeColor="White" Text="Imagen:" Width="90px" CssClass="form-control" BackColor="#003366"></asp:Label>
                        <input id="oFile" runat="server" class="form-control" name="oFile" onclick="return oFile_onclick()" type="file" width="180px" />
                        <br />
                        <br />
                        <br />
                        <br />
                        <br />
                        <br />
                        <asp:Button ID="btnAceptar" runat="server" class="btn btn-success btn-circle" width="130" Text="Aceptar" OnClick="btnAceptar_Click" />&nbsp;&nbsp;
                                               
                     </div>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />      
           

           
        </div>
    </div>
 </div>
    </form>
</asp:Content>