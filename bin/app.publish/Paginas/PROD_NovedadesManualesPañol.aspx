<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_NovedadesManualesPañol.aspx.cs" Inherits="SintecromNet.Paginas.PROD_NovedadesManualesPañol" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
        }

        function Alertando(elemento, control) {


            <%--if (control == 1) {
                var txt = $('#<%=txtMailCertificado.ClientID %>');
                var lbl = $('#<%=Label10.ClientID %>');
            }--%>

            switch (control) {

                case 1:
                    var txt = $('#<%=txtValor.ClientID %>');
                    var txtd = $('#<%=txtCotizacion.ClientID %>');
                    var dd = $('#<%=DropDownList2.ClientID %>');
                    var txtdes = $('#<%=txtDestino.ClientID %>');

                    var lbl = $('#<%=Label1.ClientID %>');
                    var lbld = $('#<%=Label2.ClientID %>');
                    var lbldd = $('#<%=Label3.ClientID %>');
                    var lbldes = $('#<%=lblDestino.ClientID %>');

                    break;
               <%-- case 9:
                    var txt = $('#<%=txtTransporte.ClientID %>');
                        var lbl = $('#<%=lblTransporte.ClientID %>');
                        break;--%>
            }



            if ($(elemento).val() == 1) {

                txt.hide();
                lbl.hide();
                txtd.hide();
                lbld.hide();
                dd.hide();
                lbldd.hide();
                txtdes.show();
                lbldes.show();
            }
            else {
                txt.show();
                lbl.show();
                txtd.show();
                lbld.show();
                dd.show();
                lbldd.show();
                txtdes.hide();
                lbldes.hide();
            }
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
    <h2>Transacciones Pañol</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <br />
            <div class="panel panel-primary">

            <div class="panel-heading"><h4>Ingresos y Egresos del Pañol</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
             <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Código:" Width="150px"></asp:Label>
                        <asp:DropDownList ID="ddComboProducto" runat="server" Width="650px" Height="34px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddComboProducto" CssClass="alert-danger" ErrorMessage="Debe Seleccionar un Producto" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                        <br />
                        <br />
                       
           
            <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCantidad" cssclass="form-control" runat="server" Width="150px" TextMode="Number"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="El Campo Cantidad No Puede Estar Vacío" ControlToValidate="txtCantidad" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label7" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Tipo:" Width="150px"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" onchange="Alertando(this, 1);" Height="34px" Width="150px">
                <asp:ListItem Value="0">Ingreso</asp:ListItem>
                <asp:ListItem Value="1">Egreso</asp:ListItem>
                        </asp:DropDownList>
           <br />
           <br />  
            <asp:Label ID="Label1" runat="server" BackColor="#337AB7" CssClass="form-control"  ForeColor="White" Text="Valor:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtValor" cssclass="form-control" runat="server" Width="150px">0</asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El Campo Valor No Puede Estar Vacío" ControlToValidate="txtValor" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Moneda:" Width="150px"></asp:Label>
            <asp:DropDownList ID="DropDownList2" runat="server" Height="34px" Width="150px">
                <asp:ListItem Value="Pesos">Pesos</asp:ListItem>
                <asp:ListItem Value="Dólares">Dolares</asp:ListItem>
            </asp:DropDownList>
           <br />
           <br />
            <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cotizacion:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCotizacion" cssclass="form-control" runat="server" Width="150px">1</asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Cotización No Puede Estar Vacío" ControlToValidate="txtCotizacion" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="lblDestino" Style="display: none" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Destino:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtDestino" Style="display: none" cssclass="form-control" runat="server" Width="450px"></asp:TextBox>   
            
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

