<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="COM_GestionIPC.aspx.cs" Inherits="SintecromNet.Paginas.COM_GestionIPC" %>
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
    <h2>Gestión IPC</h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel-body">
                <h4><asp:Button ID="btnAgregar" runat="server" class="btn btn-success btn-circle" Text="+" Font-Bold="True" Font-Size="Medium" OnClick="btnAgregar_Click"/>&nbsp;Agregar Un Nuevo Indice</h4></div>

            <div id="divGrilla" runat="server" class="input-group">
                <asp:ImageButton ID="btnExcel" runat="server" cssclass="form-control" Height="51px" ImageAlign="Middle" ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px; top: 0px; left: -1px;" ToolTip="Exportar a Excel" Width="53px" />
                <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos" DataKeyNames="ID,Nombre,Indice,Fecha" OnRowCommand="gwGrilla_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
                        <asp:BoundField DataField="Indice" HeaderText="Indice" />
                        <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Mes" />
                        <asp:ButtonField CommandName="Editar"  
                        HeaderText="Editar" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Editar" >            
<ControlStyle BorderStyle="None" CssClass="btn btn-info"></ControlStyle>
            </asp:ButtonField>
            <asp:ButtonField CommandName="Eliminar"  
                HeaderText="Eliminar" ButtonType="Button" ControlStyle-CssClass="btn btn-danger" ControlStyle-BorderStyle="None" Text="Eliminar" >            
<ControlStyle BorderStyle="None" CssClass="btn btn-danger"></ControlStyle>
            </asp:ButtonField>
                        <asp:BoundField HeaderText="ID" Visible="False" />
                    </Columns>
                    <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                </asp:GridView>
            </div>
        <%--</div>--%>
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="panel panel-primary">

            <div class="panel-heading"><h4>Nuevo Indice</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
             <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Nombre:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtNombre" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="El Campo Nombre No Puede Estar Vacio" ControlToValidate="txtNombre" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Indice:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtIndice" cssclass="form-control" runat="server" Width="300px" TextMode="SingleLine"></asp:TextBox>           
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Indice No puede Estar Vacio" ControlToValidate="txtIndice" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label15" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Mes-Año:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtMes" cssclass="form-control" runat="server"  Width="150px"  TextMode="Month"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="El Campo Mes No Puede Estar Vacío" ControlToValidate="txtMes" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
           
            
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
        </asp:Panel>
        
        
     
        </div>
        </form>
        </asp:Content>

