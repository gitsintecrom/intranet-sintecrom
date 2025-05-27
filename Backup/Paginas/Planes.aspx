<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Planes.aspx.cs" Inherits="SintecromNet.Paginas.Planes" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
 <script language="javascript" type="text/javascript">


     function sumar() {
     debugger       
         var a, b, r, nombre, nombreb;
         a = document.getElementById('<%= txtPesoFleje.ClientID %>').value;
         nombre = document.getElementById('<%= txtPesoFleje.ClientID %>');
         validaFloat(nombre, a);

         b = document.getElementById('<%= txtPesoHoja.ClientID %>').value;
         nombreb = document.getElementById('<%= txtPesoHoja.ClientID %>');
         validaFloat(nombreb, b);

         r = parseFloat(a) + parseFloat(b);           
         document.getElementById('<%= txtPesoTotal.ClientID %>').value = r;
     }


     function validaFloat(campo, numero) {

         if (!/^([0-9])*[.]?[0-9]*$/.test(numero)) {
             alert("El valor " + numero + " no es decimal, el formato correcto es 00.00");
             campo.focus();
             

         }

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
    .style1
    {
        text-align: left;
    }
        .style2
        {
            text-align: left;
            width: 193px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>PLanes<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
   
    </h2>
    <asp:GridView ID="gwPlanes" runat="server" AutoGenerateColumns="False" 
        onrowcommand="gwPlanes_RowCommand" onrowediting="gwPlanes_RowEditing" 
        Width="648px" DataKeyNames="Id">
        <Columns>
            <asp:BoundField DataField="Tipo" HeaderText="Tipo">
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia">
            </asp:BoundField>
            <asp:BoundField DataField="PesoFleje" HeaderText="Peso Fleje" 
                DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="PesoHoja" HeaderText="Peso Hoja" 
                DataFormatString="{0:0.00}" />
            <asp:BoundField DataField="PesoTotal" HeaderText="Peso Total" 
                DataFormatString="{0:0.00}" />
            <asp:ButtonField CommandName="Editar" Text="Editar">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:ButtonField>
            <asp:BoundField DataField="id" HeaderText="Id" Visible="False" />
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" />
</asp:GridView>
    <p>
&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
    <p>
        <table style="width: 100%;">
            <tr>
                <td class="style2">
                    <asp:Label ID="Label6" runat="server" Visible="False">Peso Fleje:</asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtPesoFleje" runat="server" Height="22px"  
             Visible="False" Width="100px" onblur="javascript:sumar(this);">0</asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    <asp:Label ID="Label7" runat="server" Visible="False">Peso Hoja:</asp:Label>
                </td>
                <td>
        <asp:TextBox ID="txtPesoHoja" runat="server" Height="22px" 
            ValidationGroup="Validar" Visible="False" Width="100px" onblur="javascript:sumar(this);">0</asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    <asp:Label ID="Label8" runat="server" Visible="False">Peso Total:</asp:Label>
                </td>
                <td>                
        <asp:TextBox ID="txtPesoTotal" runat="server" Height="22px" 
            ValidationGroup="Validar" Visible="False" Width="100px" onblur="javascript:validaFloat(id, value);">0</asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td>
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style2">
                    &nbsp;</td>
                <td class="style1">
        <asp:Button ID="btnAceptar" runat="server" BackColor="Maroon" 
            Font-Names="Arial" ForeColor="White" onclick="btnAceptar_Click" Text="Aceptar" 
            ValidationGroup="Validar" Visible="False" style="text-align: left" />
                </td>
            </tr>
        </table>
<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    </asp:Content>
