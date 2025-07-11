<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_NovedadesPañol.aspx.cs" Inherits="SintecromNet.Paginas.PROD_NovedadesPañol" %>
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
    <h2>Remitos Pendientes de Ingreso al Pañol</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <asp:Panel ID="Panel2" runat="server" >
        

            <div class="input-group">
               
         
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos" DataKeyNames="NumeroDocumento,Fecha,Producto,Cantidad,ItemID,Descripcion,Valor,Moneda,Cotizacion" OnRowCommand="gwGrilla_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="NumeroDocumento" HeaderText="Remito" />
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Producto" HeaderText="Producto" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        <asp:BoundField DataField="Cantidad" DataFormatString="{0:0.00}" HeaderText="Cantidad" />
                        <asp:BoundField DataField="ItemID" HeaderText="ItemID" Visible="False" />
                        <asp:BoundField DataField="Valor" DataFormatString="{0:0.00}" HeaderText="Valor" Visible="False" />
                        <asp:BoundField DataField="Moneda" HeaderText="Moneda" Visible="False" />
                        <asp:BoundField DataField="Cotizacion" DataFormatString="{0:0.00}" HeaderText="Cotizacion" Visible="False" />



                        <asp:ButtonField CommandName="Editar"  
                        HeaderText="Ver" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Ver" >            
<ControlStyle BorderStyle="None" CssClass="btn btn-info"></ControlStyle>
            </asp:ButtonField>
                    </Columns>
                    <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                    <RowStyle Font-Size="Small" />
                </asp:GridView>
            </div>
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="panel panel-primary">

            <div class="panel-heading">             
              
                    
                 <span style ="float:right;">
                <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" OnClick="LinkButton2_Click" ToolTip="Salir" BackColor="White"></asp:LinkButton>
                </span>
                <h4>Detalle</h4>
                     </div>
                <div class="panel-body">                
                    <div class="input-group">
             <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Remito:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtRemito" cssclass="form-control" runat="server" Width="150px" ReadOnly="True"></asp:TextBox>   
            <br />   
            <br /> 
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fecha:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtFecha" cssclass="form-control" runat="server" Width="150px" ReadOnly="True"></asp:TextBox>           
            <br />   
            <br /> 
            <asp:Label ID="Label5" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Producto:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtProducto" cssclass="form-control" runat="server" Width="200px" ReadOnly="True"></asp:TextBox>   
            <br />   
            <br />
            <asp:Label ID="Label1" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Descripción:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtDescripcion" cssclass="form-control" runat="server" Width="300px" ReadOnly="True"></asp:TextBox>   
            <br />   
            <br />  
            <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCantidad" cssclass="form-control" runat="server" Width="150px" ReadOnly="True"></asp:TextBox>   
            <br />   
            <br />
        
            <br />  
            
   
                             <asp:Button ID="btnEjecutar" runat="server" class="btn btn-success btn-circle" width="130" Text="Aceptar" OnClick="btnEjecutar_Click" BorderStyle="None" ValidationGroup="Aceptar"  />
                         <%--onclientclick="return estaseguro()"--%> 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

        <asp:Button ID="Button1" runat="server" class="btn btn-success btn-circle" width="130" 
                Text="Rechazar" TabIndex="170" BackColor="#CC3300" BorderStyle="None" OnClick="Button1_Click" />
          
        
                   
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

