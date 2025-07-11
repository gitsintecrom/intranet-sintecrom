<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CAL_GestionMuestras.aspx.cs" Inherits="SintecromNet.Paginas.CAL_GestionMuestras" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>


<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">


        function Alertando(elemento, control) {


            <%--if (control == 1) {
                var txt = $('#<%=txtMailCertificado.ClientID %>');
                var lbl = $('#<%=Label10.ClientID %>');
            }--%>

            switch (control) {
                case 1:
                    var txt = $('#<%=txtMailCertificado.ClientID %>');
                    var lbl = $('#<%=Label10.ClientID %>');
                    break;
                case 2:
                    var txt = $('#<%=txtPlegado.ClientID %>');
                    var lbl = $('#<%=lblPlegado.ClientID %>');
                    break;
                case 3:
                    var txt = $('#<%=txtProfundidad.ClientID %>');
                    var lbl = $('#<%=lblProfundidad.ClientID %>');
                    break;
                case 4:
                    var txt = $('#<%=txtPintado.ClientID %>');
                    var lbl = $('#<%=lblPintado.ClientID %>');
                    break;
                case 5:
                    var txt = $('#<%=txtAnodizado.ClientID %>');
                    var lbl = $('#<%=lblAnodizado.ClientID %>');
                    break;
                case 6:
                    var txt = $('#<%=txtPerforado.ClientID %>');
                    var lbl = $('#<%=lblPerforado.ClientID %>');
                    break;
                case 7:
                    var txt = $('#<%=txtConformado.ClientID %>');
                    var lbl = $('#<%=lblConformado.ClientID %>');
                    break;
                case 8:
                    var txt = $('#<%=txtPotencial.ClientID %>');
                    var lbl = $('#<%=lblPotencial.ClientID %>');
                    var txtd = $('#<%=txtDomicilio.ClientID %>');
                    var lbld = $('#<%=lblDomicilio.ClientID %>');
                    var dd = $('#<%=ddClientes.ClientID %>');
                    var lbldd = $('#<%=lblClientes.ClientID %>');

                    break;
                case 9:
                    var txt = $('#<%=txtTransporte.ClientID %>');
                    var lbl = $('#<%=lblTransporte.ClientID %>');
                    break;
            }



            if ($(elemento).val() == "Si")
            {
                if (control == 8)
                {
                    txt.show();
                    lbl.show();
                    txtd.show();
                    lbld.show();
                    dd.hide();
                    lbldd.hide();
                }
                else
                {
                    txt.show();
                    lbl.show();

                }
               
            }
            else
            {
                if (control == 8) {
                    txt.hide();
                    lbl.hide();
                    txtd.hide();
                    lbld.hide();
                    dd.show();
                    lbldd.show();
                }
                else
                {
                    txt.hide();
                    lbl.hide();
                }
                
            }
        }


        function validalargo() {
            var lote = document.getElementById("txtLote").value
            if (lote.length != 3) {
                alert("El Campo Lote debe ser de 3 caracteres");
                document.getElementById("txtLote").value = ""
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
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <!-- Main component for a primary marketing message or call to action -->
        <div class="jumbotron">
            <h2>Solicitudes de Muestras</h2>

            <%--<div class="panel panel-primary">--%>
               <%--<div class="panel-default" style="background-color: #000066; color: #FFFFFF;">
                    <h4>Ingrese un Nuevo Pedido de Muestra</h4>
                </div>--%>



                <div class="input-group" style="border-style:groove; background-color:azure; border-radius:inherit">
                <h4 style="background-color: #000066; color: #FFFFFF;">Ingrese un Nuevo Pedido de Muestra</h4>


                    <asp:Label ID="Label22" runat="server" CssClass="form-control" Text="Cliente Nuevo:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="ddPotencial" CssClass="form-control" runat="server" onchange="Alertando(this, 8);" Width="200px">
                        <asp:ListItem Value="No">No</asp:ListItem>
                        <asp:ListItem Value="Si">Si</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Label ID="lblPotencial" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Potencial:" Width="200px"></asp:Label>
                    <asp:TextBox ID="txtPotencial" CssClass="form-control" runat="server" Style="display: none" Width="200px"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="lblDomicilio" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Domicilio:" Width="200px"></asp:Label>
                    <asp:TextBox ID="txtDomicilio" CssClass="form-control" runat="server" Style="display: none" Width="200px"></asp:TextBox>
                    

                    <asp:Label ID="lblClientes" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Cliente:" Width="200px"></asp:Label>
                    <asp:DropDownList ID="ddClientes" runat="server" CssClass="form-control" Width="200px" OnSelectedIndexChanged="ddClientes_SelectedIndexChanged" AutoPostBack="True">
                    </asp:DropDownList>

                    <asp:Label ID="Label4" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Vendedor:" Width="200px"></asp:Label>
                    <asp:DropDownList ID="ddVendedor" CssClass="form-control" runat="server" Width="200px">
                        <asp:ListItem Value="Milone">Antonio Milone</asp:ListItem>
                        <asp:ListItem Value="Casa Central">Casa Central</asp:ListItem>
                        <asp:ListItem Value="Facheli">Fernando Facheli</asp:ListItem>
                        <asp:ListItem Value="Estefania">Javier Estefania</asp:ListItem>
                        <asp:ListItem Value="Muschitiello">Jordan Muschitiello</asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="El Campo Vendedor No Puede Estar Vacio" ControlToValidate="ddVendedor" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
                    <br />
                    <br />
                    
                    <asp:Label ID="Label7" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Telefono:" Width="200px"></asp:Label>
                    <asp:TextBox ID="txtTelefono" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>

                    <asp:Label ID="Label5" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Email:" Width="200px"></asp:Label>
                    <asp:TextBox ID="txtEmail" CssClass="form-control" runat="server" Width="200px" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="El Campo Email No Puede Estar Vacío" ControlToValidate="txtEmail" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
                    <br />
                    <br />

                    <asp:Label ID="Label9" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Solicitada:" Width="200px"></asp:Label>
                    <asp:TextBox ID="txtFechaSolicitada" runat="server" CssClass="form-control" Width="200px" TextMode="Date"></asp:TextBox>
                    <br />
                    <br />


                    <asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Requiere Certificado:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="ddlCertificado" CssClass="form-control" runat="server" onchange="Alertando(this, 1);" Width="200px">
                        <asp:ListItem Value="No">No</asp:ListItem>
                        <asp:ListItem Value="Si">Si</asp:ListItem>
                    </asp:DropDownList>


                    <asp:Label ID="Label10" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Mail Certificado:" Width="200px"></asp:Label>
                    <asp:TextBox ID="txtMailCertificado" Style="display: none" CssClass="form-control" runat="server" Width="200px" TextMode="Email"></asp:TextBox>


                    <%--<asp:Button ID="Button2" runat="server" class="btn btn-success btn-circle" width="800px" Text="Ingresar Detalle" OnClick="Button2_Click" BorderStyle="None" BackColor="Maroon"  />--%>
                    <br />
                    <br />

                    <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Entrega:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="ddlEntrega" CssClass="form-control" runat="server" onchange="Alertando(this, 9);" Width="200px">
                        <asp:ListItem Value="No">No</asp:ListItem>
                        <asp:ListItem Value="Si">Si</asp:ListItem>
                    </asp:DropDownList>


                    <asp:Label ID="lblTransporte" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Transporte:" Width="200px"></asp:Label>
                    <asp:TextBox ID="txtTransporte" Style="display: none" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
                    <br />
                    <br />

                    <h4 style="background-color: #000066; color: #FFFFFF;">Detalle</h4>

           


            <asp:Label ID="Label8" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Línea:" Width="200px"></asp:Label>
            <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="200px">
            </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddFamilia" CssClass="alert-danger" ErrorMessage="Debe Seleccionar una Familia" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
            <asp:Label ID="Label6" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Espesor:" Width="200px"></asp:Label>
            <asp:DropDownList ID="ddEspesor" runat="server" CssClass="form-control" Width="200px">
            </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="El Campo Espesor No Puede Estar Vacío" ControlToValidate="ddEspesor" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label24" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Aleación:" Width="200px"></asp:Label>
            <asp:DropDownList ID="ddAleacion" runat="server" CssClass="form-control" Width="200px">
            </asp:DropDownList> 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="El Campo Aleación No Puede Estar Vacío" ControlToValidate="ddAleacion" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <asp:Label ID="Label25" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Temple:" Width="200px"></asp:Label>
            <asp:DropDownList ID="ddTemple" runat="server" CssClass="form-control" Width="200px">
            </asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="El Campo Temple No Puede Estar Vacío" ControlToValidate="ddTemple" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />
            <br />            
            <asp:Label ID="Label11" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Ancho (en mm):" Width="200px"></asp:Label>
            <asp:TextBox ID="txtAncho" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="El Campo Ancho No Puede Estar Vacío" ControlToValidate="txtAncho" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <asp:Label ID="Label3" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Largo (en mm):" Width="200px"></asp:Label>
            <asp:TextBox ID="txtLargo" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>     
                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="El Campo Largo No Puede Estar Vacío" ControlToValidate="txtLargo" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label14" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtCantidad" CssClass="form-control" runat="server" Width="200px" TextMode="Number">0</asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="El Campo Cantidad No Puede Estar Vacío" ControlToValidate="txtCantidad" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <asp:Label ID="Label12" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Unidad de Medida:" Width="200px"></asp:Label>
            <asp:DropDownList ID="ddUnidadMedida" CssClass="form-control" runat="server" Width="200px">
                <asp:ListItem Value="Kilogramos">Kilogramos</asp:ListItem>
                <asp:ListItem Value="Unidad">Unidad</asp:ListItem>
            </asp:DropDownList>
            <br />
            <br />
            <asp:Label ID="Label27" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Origen:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtOrigen" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <asp:Label ID="Label13" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Serie Sugerida:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtSerieSugerida" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label15" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Embalaje:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtEmbalaje" CssClass="form-control" runat="server" Width="600px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Embalaje No Puede Estar Vacío" ControlToValidate="txtEmbalaje" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />
            <br />
            <asp:Label ID="Label26" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Uso Final:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtUsoFinal" CssClass="form-control" runat="server" Width="600px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="El Campo Uso Final No Puede Estar Vacío" ControlToValidate="txtUsoFinal" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            
            <br />
            <br />

            <asp:Label ID="Label23" runat="server" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Observaciones:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtComentarios" CssClass="form-control" runat="server" Width="600px" TextMode="MultiLine"></asp:TextBox>

            <br />
            <br />
            <br />
            

            <h4 style="background-color: #000066; color: #FFFFFF;">Operaciones</h4>
      

            <asp:Label ID="Label16" runat="server" CssClass="form-control" Text="Plegado:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList1" CssClass="form-control" runat="server" onchange="Alertando(this, 2);" Width="200px">
                <asp:ListItem Value="No">No</asp:ListItem>
                <asp:ListItem Value="Si">Si</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblPlegado" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Plegado:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtPlegado" Style="display: none" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label17" runat="server" CssClass="form-control" Text="Embutido:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList2" CssClass="form-control" runat="server" onchange="Alertando(this, 3);" Width="200px">
                <asp:ListItem Value="No">No</asp:ListItem>
                <asp:ListItem Value="Si">Si</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblProfundidad" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Profundidad:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtProfundidad" Style="display: none" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label18" runat="server" CssClass="form-control" Text="Pintado:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList3" CssClass="form-control" runat="server" onchange="Alertando(this, 4);" Width="200px">
                <asp:ListItem Value="No">No</asp:ListItem>
                <asp:ListItem Value="Si">Si</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblPintado" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Pintado:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtPintado" Style="display: none" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label19" runat="server" CssClass="form-control" Text="Anodizado:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList4" CssClass="form-control" runat="server" onchange="Alertando(this, 5);" Width="200px">
                <asp:ListItem Value="No">No</asp:ListItem>
                <asp:ListItem Value="Si">Si</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblAnodizado" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Anodizado:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtAnodizado" Style="display: none" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label20" runat="server" CssClass="form-control" Text="Perforado:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList5" CssClass="form-control" runat="server" onchange="Alertando(this, 6);" Width="200px">
                <asp:ListItem Value="No">No</asp:ListItem>
                <asp:ListItem Value="Si">Si</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblPerforado" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Perforado:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtPerforado" Style="display: none" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label21" runat="server" CssClass="form-control" Text="Conformado:" Width="200px" BorderStyle="None" BackColor="#669999" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="DropDownList6" CssClass="form-control" runat="server" onchange="Alertando(this, 7);" Width="200px">
                <asp:ListItem Value="No">No</asp:ListItem>
                <asp:ListItem Value="Si">Si</asp:ListItem>
            </asp:DropDownList>
            <asp:Label ID="lblConformado" runat="server" Style="display: none" BackColor="#669999" CssClass="form-control" ForeColor="White" Text="Conformado:" Width="200px"></asp:Label>
            <asp:TextBox ID="txtConformado" Style="display: none" CssClass="form-control" runat="server" Width="200px"></asp:TextBox>
            <br />
            <br />
            <panel>
                <asp:Button ID="btnEjecutar" runat="server" class="btn btn-primary btn-lg btn-success" width="100%" Text="Aceptar" OnClick="btnEjecutar_Click" BorderStyle="None" ValidationGroup="Aceptar" />
            <br />            
                <asp:Button ID="Button1" runat="server" class="btn btn-primary btn-lg btn-danger" width="100%" Text="Cancelar" TabIndex="170" BorderStyle="None" OnClick="Button1_Click" />
            
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />
            </panel>
            
                
        <%--</div>--%>



            </div>
    </div>


        

        
     
        
    </form>
</asp:Content>

