<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="MAIL_GeneracionMailMasivo.aspx.cs" Inherits="SintecromNet.Paginas.MAIL_GeneracionMailMasivo" %>
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
    <h2>Generación de Mails Masivos</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <br />
            <div class="panel panel-primary">

            <div class="panel-heading"><h4>Ingrese La Información a Enviar</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
             <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Vendedor:" Width="150px"></asp:Label>
                        <asp:DropDownList ID="ddComboVendedor" runat="server" Width="350px" Height="38px">
                        </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Debe Seleccionar un Vendedor" ControlToValidate="ddComboVendedor" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
                        <br />
                        <br />
                       
           
            <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Asunto:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtAsunto" cssclass="form-control" runat="server" Width="450px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="El Campo Asunto No Puede Estar Vacío" ControlToValidate="txtAsunto" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
             <asp:Label ID="Label1" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Mensaje:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtMensaje" cssclass="form-control" runat="server" Width="450px" Height="140px" TextMode="MultiLine"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El Campo Asunto No Puede Estar Vacío" ControlToValidate="txtMensaje" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            
            
           <br />   
           <br />             
                
            <asp:Button ID="btnEjecutar" runat="server" class="btn btn-success btn-circle" width="130" Text="Aceptar" OnClick="btnEjecutar_Click" BorderStyle="None" ValidationGroup="Aceptar"  />
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" class="btn btn-success btn-circle" width="130" 
            Text="Cancelar" TabIndex="170" BackColor="#CC3300" BorderStyle="None" OnClick="Button1_Click" />        
        
                   
            <br />
            <br />
                        
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />
   
            <div id="elegidos" runat="server" class="panel panel-primary" style="float:inherit" visible="false">
            <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="comunicacion,vend" 
                    OnRowCommand="gwGrilla_RowCommand">
            <Columns>          
            
            
            <asp:BoundField DataField="comunicacion" HeaderText="Campaña" />
            <asp:BoundField DataField="cabececera" HeaderText="Asunto" />
            <asp:BoundField DataField="vend" HeaderText="Vendedor" />           
            <asp:ButtonField ButtonType="Button" CommandName="Eliminar" HeaderText="Eliminar" ControlStyle-CssClass="btn btn-danger" Text="Eliminar" >
            <ControlStyle CssClass="btn btn-danger"></ControlStyle>
            </asp:ButtonField>
           

        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
        </asp:GridView>
              <br />
             
            <asp:Button ID="Button2" runat="server" class="btn btn-success btn-circle" Text="Confirmar Envio de Campaña" OnClick="Button2_Click" BorderStyle="None" />
          
            &nbsp;&nbsp;
          
            <asp:Button ID="Button3" runat="server" class="btn btn-success btn-circle"
            Text="Salir y Descartar los Cambios" TabIndex="170" BackColor="#CC3300" BorderStyle="None" OnClick="Button3_Click" />        
        
                   
            </div>
                   
                    </div>
           
                </div>

        </div>
       
        
        
     
        </div>
        </form>
        </asp:Content>

