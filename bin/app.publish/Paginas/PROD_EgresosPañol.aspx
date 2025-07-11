<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_EgresosPañol.aspx.cs" Inherits="SintecromNet.Paginas.PROD_EgresosPañol" %>
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
       
    function validaFloat(numero, id) {

        var nombre = document.getElementById(id);
        if (!/^([0-9])*[.]?[0-9]*$/.test(numero)) {
            alert("El valor " + numero + " no es un Entero");
            nombre.focus();
        }
        else {
            if (numero == "") numero = "0";
            var monto = parseFloat(numero).toFixed(2);
            nombre.value = monto;
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

    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
     <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
    <h2>Egresos Pañol</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <br />
            <div class="panel panel-primary">

            <div class="panel-heading"><h4>Egresos del Pañol</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
             <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Código:" Width="150px"></asp:Label>
                        <asp:DropDownList ID="ddComboProducto" runat="server" Width="450px" Height="34px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddComboProducto" CssClass="alert-danger" ErrorMessage="Debe Seleccionar un Producto" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                        <br />
                        <br />
                       
           
            <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCantidad" cssclass="form-control" runat="server" Width="150px" TextMode="Number"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="El Campo Cantidad No Puede Estar Vacío" ControlToValidate="txtCantidad" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
           
            <br />   
            <br /> 
            <asp:Label ID="lblDestino" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Destino:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtDestino" cssclass="form-control" runat="server" Width="450px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El Campo Destino No Puede Estar Vacío" ControlToValidate="txtDestino" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
           
            <br />   
            <br /> 
           
            
   
                             <asp:Button ID="btnEjecutar" runat="server" class="btn btn-success btn-circle" width="130" Text="Aceptar" OnClick="btnEjecutar_Click" BorderStyle="None" ValidationGroup="Aceptar"  />
                         <%--onclientclick="return estaseguro()"--%> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:Button ID="Button1" runat="server" class="btn btn-success btn-circle" width="130" 
                Text="Cancelar" TabIndex="170" BackColor="#CC3300" BorderStyle="None" OnClick="Button1_Click" />
          
        
                   
                        <br />
                        <br />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />
          
        
                   
                    </div>
           
                </div>

        </div>
       
        
        
     
        </div>
        </form>
        </asp:Content>

