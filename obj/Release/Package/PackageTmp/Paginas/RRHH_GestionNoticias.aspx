<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RRHH_GestionNoticias.aspx.cs" Inherits="SintecromNet.Paginas.RRHH_GestionNoticias" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Eliminar el Certificado?')) return false;
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
    <h2>Gestión Noticias</h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="input-group">
         <asp:Label ID="lblPedido1" runat="server" style="text-align: left" Text="Ubicación:" Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" Width="300px" CssClass="form-control" Height="33px">
                    <asp:ListItem Value="0">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="1">Portada Izquierda</asp:ListItem>
                    <asp:ListItem Value="2">Portada Centro</asp:ListItem>
                    <asp:ListItem Value="3">Portada Derecha</asp:ListItem>
                    <asp:ListItem Value="4">Monitor Izquierda</asp:ListItem>
                    <asp:ListItem Value="5">Monitor  Derecha</asp:ListItem>
                    <asp:ListItem Value="6">Monitor Completo</asp:ListItem>
                </asp:DropDownList>
            &nbsp;&nbsp;
            
            <asp:Button ID="Button7" runat="server" cssclass ="btn btn-success btn-circle" Text="Modificar" Width="150px"  OnClick="Button7_Click" />           
             <br />
        <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Left" Width="650px" BackColor="#CCCCCC" style="float: left;" Visible="False">
        <h4><asp:Label ID="lblUbicacion" runat="server" Text="Seleccione"></asp:Label></h4>
            <div class="input-group">
<asp:Label ID="Label2" runat="server" style="text-align: left" Text="Panel:" Width="100px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" Width="130px" CssClass="form-control" Height="33px">
                    <asp:ListItem Value="0">Visible</asp:ListItem>
                    <asp:ListItem Value="1">Oculto</asp:ListItem>
                </asp:DropDownList>
            <br /><br />
            <asp:Label ID="Label1" runat="server" Text="Texto:" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Width="100px"></asp:Label>
                <asp:TextBox ID="txtMensaje" runat="server" CssClass="form-control" Height="93px" MaxLength="500" TextMode="MultiLine" Width="450px"></asp:TextBox>
            <br /><br />
                <asp:Image ID="Image1" runat="server"  Height="300px" Width="300px"   />
            
            <asp:Button ID="Button1" runat="server" cssclass ="btn btn-success btn-circle" Text="Cambiar Imagen" Width="150px"  OnClick="btnFoto_Click" BackColor="#FF9999" BorderStyle="None" />           
             <br />
             <br />
                            
            <asp:Button ID="Button2" runat="server" cssclass ="btn btn-success btn-circle" Text="Confirmar" Width="150px"  OnClick="Button2_Click" />           
             
            </div>
                 </asp:Panel>
       
    
    <asp:HiddenField ID="HiddenFieldError" runat="server" />


    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>

    

        <asp:Panel ID="Panel1" runat="server" Height="142px" Width="500px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
            <h3>Seleccione Imagen</h3>
                <asp:FileUpload ID="fuImagen" runat="server" CssClass="form-control" Width="360px" />            
            <br /><br />
            <asp:Button ID="btnModificar" runat="server" Enabled="True" class="btn btn-success btn-circle" onclick="btnModificar_Click" TabIndex="160" Text="Modificar" ValidationGroup="Validar" />
            &nbsp;&nbsp;<asp:Button ID="Button6" runat="server" class="btn btn-success btn-circle" onclick="Button2_Click1" TabIndex="170" Text="Cerrar" BackColor="#CC3300" BorderStyle="None" />
            <br />
           
        </asp:Panel>
            </div>
        </div>
        </form>
        </asp:Content>

