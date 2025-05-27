<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DiasHabiles.aspx.cs" Inherits="SintecromNet.Paginas.DiasHabiles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Días Hábiles<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT * FROM [Totales_Cobranzas]"></asp:SqlDataSource>
   
    </h2>
    <asp:GridView ID="gwDiasHabiles" runat="server" AutoGenerateColumns="False" 
        onrowcommand="gwDiasHabiles_RowCommand" onrowediting="gwDiasHabiles_RowEditing" 
        Width="267px">
        <Columns>
            <asp:BoundField DataField="Mes" HeaderText="Mes">
            <ControlStyle BackColor="Maroon" Font-Names="Arial" ForeColor="White" 
                Width="50px" />
            <FooterStyle Font-Names="Rod" />
            <HeaderStyle BackColor="Maroon" Font-Names="Arial" ForeColor="White" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="Dias" HeaderText="Dias">
            <ControlStyle Font-Names="Arial" Width="50px" />
            <HeaderStyle BackColor="Maroon" Font-Names="Arial" ForeColor="White" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:ButtonField CommandName="Editar" Text="Editar">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:ButtonField>
        </Columns>
</asp:GridView>
    <p>
        <asp:Label ID="Label1" runat="server" Text="Mes:" Visible="False"></asp:Label>
        <asp:Label ID="Label2" runat="server" Font-Bold="True" Text="Label" 
            Visible="False"></asp:Label>
&nbsp;&nbsp;
        <asp:Label ID="Label3" runat="server" Text="Dias:" Visible="False"></asp:Label>
        <asp:TextBox ID="txtDias" runat="server" Height="22px" 
            ValidationGroup="Validar" Visible="False" Width="39px"></asp:TextBox>
&nbsp;<asp:RangeValidator ID="RangeValidator1" runat="server" 
            ControlToValidate="txtDias" CssClass="failureNotification" 
            ErrorMessage="Dato Erróneo" MaximumValue="31" MinimumValue="0" 
            ValidationGroup="Validar"></asp:RangeValidator>
&nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
            ControlToValidate="txtDias" CssClass="failureNotification" 
            ErrorMessage="Debe Ingresar un Valor" ValidationGroup="Validar"></asp:RequiredFieldValidator>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnAceptar" runat="server" BackColor="Maroon" 
            Font-Names="Arial" ForeColor="White" onclick="btnAceptar_Click" Text="Aceptar" 
            ValidationGroup="Validar" Visible="False" />
    </p>
    <p>
        &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    </asp:Content>
