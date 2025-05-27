<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="INV_IngresoInventarioAnual.aspx.cs" Inherits="SintecromNet.Paginas.INV_IngresoInventarioAnual" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sintecrom - Intranet</title>    
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="Intranet de Sintecrom S.A.I.C">
    <meta name="author" content="Jorge Navarro">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>  
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">    
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link href="/your-path-to-fontawesome/css/fontawesome.css" rel="stylesheet">
    
    <script type="text/javascript">
        function validalargo() {
    var lote = document.getElementById("txtLote").value
    if (lote.length !=3) {
        alert("El Campo Lote debe ser de 3 caracteres");
        document.getElementById("txtLote").value = ""
    }
        }

        function validaentrada() {
            var entrada = document.getElementById("txtEtiqueta").value
            if (entrada > 20000) {
                alert("El Numero de Etiqueta no puede ser mayor a 20000");
                document.getElementById("txtEtiqueta").value = ""
            }
        }
        function validaentrada1() {
            var entrada = document.getElementById("txtGalpon").value
            if (entrada > 6) {
                alert("El Numero de Galpon no puede ser mayor a 6");
                document.getElementById("txtGalpon").value = ""
            }
        }
    </script>
   
    
    <script>
        $(document).ready(function () {
            $('.dropdown-submenu a.test').on("click", function (e) {
                $(this).next('ul').toggle();
                e.stopPropagation();
                e.preventDefault();
            });
        });
</script>
<style>
    .dropdown-submenu {
    position: relative;
    /*position: static;*/
}
    /*$(function () {
  $('[data-toggle="tooltip"]').tooltip()
})*/

.dropdown-submenu>.dropdown-menu {
    top: 0;
    left: 100%;
    margin-top: -6px;
    margin-left: -1px;
    -webkit-border-radius: 0 6px 6px 6px;
    -moz-border-radius: 0 6px 6px;
    border-radius: 0 6px 6px 6px;
}

.dropdown-submenu:hover>.dropdown-menu {
    display: block;
    background-color: white;

}

.dropdown-submenu>a:after {
    display: block;
    content: " ";
    float: right;
    width: 0;
    height: 0;
    border-color: transparent;
    border-style: solid;
    border-width: 5px 0 5px 5px;
    border-left-color: #ccc;
    margin-top: 5px;
    margin-right: -10px;
}

.dropdown-submenu:hover>a:after {
    border-left-color: #fff;
}

.dropdown-submenu.pull-left {
    float: none;
}

.dropdown-submenu.pull-left>.dropdown-menu {
    left: -100%;
    margin-left: 10px;
    -webkit-border-radius: 6px 0 6px 6px;
    -moz-border-radius: 6px 0 6px 6px;
    border-radius: 6px 0 6px 6px;
}
</style>

</head>
<body>
    <form id="form1" runat="server">
    <div class="jumbotron jumbotron-fluid ">
    <div class="panel panel-primary">
            <div class="panel-heading">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <h3>Ingreso Etiquetas&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" OnClick="LinkButton2_Click" ToolTip="Salir" BorderColor="White" ForeColor="White"></asp:LinkButton>                       
        </h3>
                </div>
        </div>  
            
            <div runat="server" id="Respuesta" visible="false" class="input-group">
                <asp:Label ID="lblKilos" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Width="210px" Height="50px"></asp:Label>
                <asp:Label ID="lblResultado" runat="server" CssClass="form-control" ForeColor="White" Width="210px" Visible="False" Height="50px"></asp:Label>
                <asp:Label ID="lblDepo" runat="server" CssClass="form-control" ForeColor="White" Width="210px" Visible="False" Height="50px"></asp:Label>
                
                <br />
                <br />
                <br />
                <br />
                <br />
                  <br />
                   <asp:Button ID="btnAceptar" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnAceptar_Click" Text="Aceptar" BorderStyle="None" Width="100" />
                   &nbsp;
                   <asp:Button ID="btnSalir" CssClass="btn btn-danger btn-circle" ForeColor="White" runat="server" OnClick="btnSalir_Click" Text="Volver" BorderStyle="None" Width="100" />
      
    
                
              </div>        
       
            <div runat="server" id="Ingreso" class="input-group">               
                <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Etiqueta:" Width="100px"></asp:Label>
                <asp:TextBox ID="txtEtiqueta" runat="server" CssClass="form-control"  Width="100px" TextMode="Number" onblur="(validaentrada())"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtEtiqueta" CssClass="alert-danger" ErrorMessage="Debe Ingresar una Etiqueta" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                
                <br />
                <br />
                <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Galpon:" Width="100px"></asp:Label>
                <asp:TextBox ID="txtGalpon" runat="server" CssClass="form-control"  Width="100px" TextMode="Number" onblur="(validaentrada1())"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtGalpon" CssClass="alert-danger" ErrorMessage="Debe Ingresar un Galpon" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                
                <br />
                <br />
                <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Serie:" Width="100px"></asp:Label>
                <asp:TextBox ID="txtSerie" runat="server" CssClass="form-control"  Width="100px" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtSerie" CssClass="alert-danger" ErrorMessage="Debe Ingresar una Serie" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>

                <br />
                <br />
                <asp:Label ID="Label5" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Lote:" Width="100px"></asp:Label>
                <asp:TextBox ID="txtLote" runat="server" CssClass="form-control"  Width="100px" TextMode="Number" MaxLength="3" onblur="(validalargo())"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLote" CssClass="alert-danger" ErrorMessage="Debe Ingresar un Lote" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                
                <br />
                <br />
                <asp:Label ID="Label1" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Kgs Netos:" Width="100px"></asp:Label>
                <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control"  Width="100px" TextMode="Number"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtCantidad" CssClass="alert-danger" ErrorMessage="Debe Ingresar una Cantidad" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
               
                 <br />
                <br />
                <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Familia:" Width="100px"></asp:Label>
                           
            <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="150px">
        </asp:DropDownList>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ddFamilia" CssClass="alert-danger" ErrorMessage="Debe Seleccionar una Familia" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>

            <br />
            <br />
            <br />
                 <br />
                 <br />

                   <asp:Button ID="btnCerrar0" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnCerrar0_Click" Text="Aceptar" BorderStyle="None" Width="100" ValidationGroup="Aceptar" />
                
                        <br />
                        <br />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />
          
      
    </div>
                  
                        
 
    </div>
    </form>
</body>
</html>
