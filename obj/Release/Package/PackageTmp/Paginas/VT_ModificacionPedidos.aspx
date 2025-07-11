<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_ModificacionPedidos.aspx.cs" Inherits="SintecromNet.Paginas.VT_ModificacionPedidos" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
        function btnGuardar_ClientCancel() {
            return false;
        }

        function nobackbutton(){
            window.location.hash="no-back-button";
            window.location.hash="Again-No-back-button" //chrome
            window.onhashchange=function(){window.location.hash="no-back-button";}
        }

        //onload="nobackbutton()"  --> poner esto en body
        //<body onload="nobackbutton();">
    

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
        function isDate(string) 
        { //string estará en formato dd/mm/yyyy (dí­as < 32 y meses < 13)
            var ExpReg = "/^(?:(?:(?:0?[1-9]|1\d|2[0-8])[/](?:0?[1-9]|1[0-2])|(?:29|30)[/](?:0?[13-9]|1[0-2])|31[/](?:0?[13578]|1[02]))[/](?:0{2,3}[1-9]|0{1,2}[1-9]\d|0?[1-9]\d{2}|[1-9]\d{3})|29[/]0?2[/](?:\d{1,2}(?:0[48]|[2468][048]|[13579][26])|(?:0?[48]|[13579][26]|[2468][048])00))$/";
            return (ExpReg.test(string));
        }

        function pulsar(e)
        {
            // averiguamos el código de la tecla pulsada (keyCode para IE y which para Firefox)
            tecla = (document.all) ? e.keyCode :e.which;
            // si la tecla no es 13 devuelve verdadero,  si es 13 devuelve false y la pulsación no se ejecuta
            return (tecla!=13);
        }

        function proximo(e, cajadestino) {
            // averiguamos el código de la tecla pulsada (keyCode para IE y which para Firefox)
            tecla = (document.all) ? e.keyCode : e.which;
            if (tecla == 13)
                document.getElementById(cajadestino).focus();
            return true;
        }

        function cambiaFoco(cajadestino)
        {
            /*Esta funcion funciona con KeyPress y recibe como parametro el nombre de la caja destino(que es una cadena)*/
            //Primero debes obtener el valor ascii de la tecla presionada 
            var key = window.event.keyCode;
            //Si es enter(13) 
            if (window.event.keyCode == 13 || window.event.which == 13)
                //Se pasa el foco a la caja destino 
                document.getElementById(cajadestino).focus();
        }

        function alerta(texto) {
            alert(texto);
        }

        //previene presionar dos veces un botón
        $(document).ready(function(){
            $('#idBoton').click(function(e){
                e.preventDefault();
                $(this).prop('disabled', true);
            }
            )}

  

        //var elInput = document.getElementById('TextBoxIni');
        //elInput.addEventListener('keyup', function (e) {
        //    var keycode = e.keyCode || e.which;
        //    if (keycode == 13) {
        //        document.getElementById('ddClientesPedidos').focus();
        //    }
        //});


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
    <div class="jumbotron">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Gestión Pedidos</h4></div>
            </div>
                <div class="panel-body">                
                <div class="input-group">
    
       <%--<div style="overflow:auto; width:1020px; ">--%> 
        <asp:Panel ID="Panel4" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
    
        <asp:GridView ID="gwPedidos" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-striped table-bordered table-hover" 
            
                    
                    
                    EmptyDataText="No hay Pedidos Pendientes Para Autorizar" 
                    onrowdatabound="gwPedidos_RowDataBound" onrowcommand="gwPedidos_RowCommand" DataKeyNames="NumeroPedido"
                    onselectedindexchanged="gwPedidos_SelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="CodCliente" HeaderText="Cod.Cli." />
            <asp:BoundField DataField="FechaPedido" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Pedido" />
            <asp:BoundField DataField="NumeroPedido" HeaderText="Pedido" />
            <asp:BoundField DataField="TipoCondicion" HeaderText="Condición" />
            <asp:BoundField DataField="TipoPedido" HeaderText="Tipo Pedido" />
            <asp:BoundField DataField="OrdenCompraCliente" HeaderText="Orden Compra" />
            <asp:BoundField DataField="totalpedido" DataFormatString="{0:0.00}" HeaderText="Total Pedido" />
            <asp:BoundField HeaderText="Cliente" DataField="RazonSocial" >
           
            </asp:BoundField>
            <asp:BoundField DataField="Reventa" HeaderText="Reventa" />
            <asp:BoundField DataField="RespetaPrecioPedido" HeaderText="Resp.Precio" />
            <asp:ButtonField ButtonType="Button" CommandName="VerPedido" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-info" HeaderText="Ver Pedido" Text="Ver">
            <ControlStyle BorderStyle="None" CssClass="btn btn-info" />
            </asp:ButtonField>
            <asp:ButtonField ButtonType="Button" CommandName="AprobarPedido" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-info" HeaderText="APROBAR" Text="Aprobar">
            <ControlStyle BorderStyle="None" CssClass="btn btn-success" />
            </asp:ButtonField>
            <asp:ButtonField ButtonType="Button" CommandName="EliminarPedido" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-info" HeaderText="Eliminar Pedido" Text="Eliminar">
            <ControlStyle BorderStyle="None" CssClass="btn btn-danger" />
            </asp:ButtonField>
        </Columns>
            <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
            </asp:Panel>  
              <%--</div>--%> 

   <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
            <br />
            <asp:Label ID="Label1" runat="server" Text="Pedido:"></asp:Label>
            <asp:Label ID="lblNroPedido" runat="server" Font-Bold="True"></asp:Label>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cliente:<asp:Label ID="lblCliente" runat="server" Font-Bold="True"></asp:Label>
       <div style="overflow:auto; height:350px; ">
            <asp:GridView ID="gwGrilla" runat="server"
                 CssClass="table table-striped table-bordered table-hover"  
                 AutoGenerateColumns="False" EmptyDataText="No se Encontraron Registros para la Selección" style="text-align: center" Font-Size="Smaller" OnRowDataBound="gwGrilla_RowDataBound" DataKeyNames="Producto" OnRowCommand="gwGrilla_RowCommand" OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged">
       
                
                <Columns>
                    <asp:BoundField DataField="Producto" HeaderText="Producto" />
                    <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                    <asp:BoundField DataField="FechaSolicitado" HeaderText="Fecha Solicitado" DataFormatString="{0:dd/MM/yyyy}" >
                    </asp:BoundField>
                    <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
                    <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unitario" />
                    <asp:BoundField DataField="PrecioLista" HeaderText="Precio Lista" />
                    <asp:BoundField DataField="Incremento" HeaderText="Incremento" />
                    <asp:BoundField DataField="BonificacionPorcentaje" HeaderText="Bonificación" />
                    <asp:BoundField DataField="LoteAVender" HeaderText="Lote" />
                    <asp:BoundField DataField="LoteAVender_Serie" HeaderText="Serie" Visible="False" />
                    <asp:BoundField DataField="TotalItem" HeaderText="Total Item" />
                    <asp:ButtonField ButtonType="Button" CausesValidation="True" CommandName="EliminarItem" DataTextField="EliminarItem" HeaderText="Eliminar Item" Text="Eliminar" />
                </Columns>
                <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />--%>
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:GridView>
           </div>
       <br />
            <asp:Button ID="btnAgregar" CssClass="btn btn-success btn-circle"  runat="server" OnClick="btnAgregar_Click" Text="Agregar" BorderStyle="None" />
          
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          
       <asp:Button ID="btnCerrar" runat="server"  BorderStyle="None" CssClass="btn btn-danger btn-circle" ForeColor="White" OnClick="btnCerrar_Click" Text="Cerrar" />
    </asp:Panel>

        <asp:Panel ID="Panel8" runat="server" Height="112px" Width="600px">
            <asp:Label ID="lblApruebaPedido" runat="server" BackColor="#993300" CssClass="form-control" ForeColor="White" Text="NUMERO DE PEDIDO:" Width="320px"></asp:Label>
            <br />  <br /> 
            <asp:Button ID="btnAprueba" runat="server" class="btn btn-success btn-circle" width="150px" Text="Aprueba" OnClick="btnAprueba_Click" BorderStyle="None"   />           
             &nbsp;&nbsp;           
            <asp:Button ID="btnCancelaAprueba" runat="server" class="btn btn-danger btn-circle" width="150px" Text="Cancela" OnClick="btnCancelaAprueba_Click" BorderStyle="None"  />           
        </asp:Panel>  

        <asp:Panel ID="Panel9" runat="server" Height="111px" Width="600px">
            <asp:Label ID="Label2" runat="server" BackColor="#993300" CssClass="form-control" ForeColor="White" Text="NUMERO DE PEDIDO:" Width="320px"></asp:Label>
             <br />  <br />
            <asp:Button ID="btnElimina" runat="server" class="btn btn-success btn-circle" width="150px" Text="Elimina" OnClick="btnElimina_Click" BorderStyle="None"   />           
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnCancelaElimina" runat="server" class="btn btn-danger btn-circle" width="150px" Text="Cancela" OnClick="btnCancelaElimina_Click" BorderStyle="None"   />           

        </asp:Panel>  

        <asp:Panel ID="Panel3" runat="server" Height="84px">
                         <asp:Label ID="lblPedidoResumen" runat="server" BackColor="#006699" CssClass="form-control" ForeColor="White" Text="Pedido:" Width="600px"></asp:Label>
                        <br /> 
                        <asp:Label ID="lblPedidoTotal" runat="server" BackColor="#006699" CssClass="form-control" ForeColor="White" Text="Total Pedido: " Width="450px"></asp:Label>
                        <asp:Button ID="btnVolver" runat="server" class="btn btn-success btn-circle" width="150px" Text="Volver" OnClick="btnVolver_Click" BorderStyle="None" BackColor="Maroon"  />           
                 </asp:Panel>
        
                <asp:Panel ID="Panel2" runat="server"  Width="675px">
                    <asp:Panel ID="Panel5" runat="server" BorderStyle="Outset" verticalalign="Left" BorderWidth="3px" Width="602px" BackColor="#CCCCCC" style="text-align: center" Visible="True"  HorizontalAlign="Left">
                        <asp:CheckBox ID="cbAutenticarProdCob" runat="server" Text="Autenticar Producto o Cobertura" />
                    </asp:Panel>

                    <asp:Label ID="Label12" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Producto:" Width="140px"></asp:Label>
            <asp:DropDownList ID="ddProductoItem" runat="server" CssClass="form-control" Width="460px" AutoPostBack="True" OnSelectedIndexChanged="ddProductoItem_SelectedIndexChanged" TabIndex="13">
                    </asp:DropDownList>
                        <br /><br /> 
                    <asp:Label ID="Label10" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fec.Solicitada:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtFechaSolicitada" runat="server" CssClass="form-control" Width="160px" TextMode="Date" onkeypress="return pulsar(event)" TabIndex="14"></asp:TextBox>
                    <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtCantidad" cssclass="form-control" runat="server" Width="160px" TextMode="Number" onkeypress="return pulsar(event)" TabIndex="15"></asp:TextBox>  
                        <br /><br /> 
                    <asp:Label ID="Label7" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Precio Unitario:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtPrecioUnitario" cssclass="form-control" runat="server" Width="160px" TextMode="Number" step="any" AutoPostBack="True" onkeypress="return pulsar(event)" TabIndex="16"></asp:TextBox> 
                    <asp:Label ID="Label9" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Precio Lista:" Width="140px" ></asp:Label>
                    <asp:TextBox ID="txtPrecioLista" runat="server" CssClass="form-control" Width="160px" TextMode="Number" step="any" AutoPostBack="True" onkeypress="return pulsar(event)" TabIndex="17" Enabled="False"></asp:TextBox>
                        <br /><br /> 
                    <asp:Label ID="Label18" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Incremento:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtIncremento" cssclass="form-control" runat="server" Width="160px" TextMode="Number" step="any" onkeypress="return pulsar(event)" TabIndex="18"></asp:TextBox> 
<%--                    <asp:Label ID="Label19" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cant.No Lineal:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtCantNoLineal" runat="server" CssClass="form-control" Width="160px" TextMode="Number" onkeypress="return pulsar(event)" TabIndex="19"></asp:TextBox>--%>
                    <asp:Label ID="Label20" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Bonificación:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtBonificacionPorcentaje" cssclass="form-control" runat="server" Width="160px" TextMode="Number" step="any" onkeypress="return pulsar(event)" TabIndex="19"></asp:TextBox> 
                    <br /><br />        
                    <asp:Button ID="btnAceptarItem" runat="server" BorderStyle="None" class="btn btn-success btn-circle" OnClick="btnAceptarItem_Click" Text="Aceptar Item" ValidationGroup="Aceptar" width="130" TabIndex="20" />
                    <br />

                            <%--EmptyDataText="No se Encontraron Datos"--%> 
                            <%--<asp:TemplateField HeaderText="Seleccionar">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelecciona" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <%--<asp:Label ID="Label10" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="150px"></asp:Label>--%>
                </asp:Panel>
            <asp:Panel ID="Panel7" runat="server" Height="600px">
                            <asp:Label ID="Label21" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Lote a Vender:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtLoteAVender" runat="server" AutoPostBack="True" cssclass="form-control" onkeypress="return pulsar(event)" OnTextChanged="txtLoteAVender_TextChanged" TabIndex="21" Width="160px"></asp:TextBox>
                            <asp:Label ID="LblLoteAVender" runat="server" BackColor="White" BorderColor="#3399FF" BorderStyle="Inset" CssClass="form-control" Font-Names="Arial" Font-Size="Smaller" ForeColor="Black" Width="300px" Height="100px"></asp:Label>
                            <br />
                            <br />
                            <br />
                            <br />
                            <asp:Label ID="Label22" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Producto:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtProducto" runat="server" AutoPostBack="True" cssclass="form-control" Font-Size="Smaller" onkeypress="return pulsar(event)" step="any" TabIndex="22" Width="460px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Label ID="Label23" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fec.Solicitada:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtFechaSolicitada0" runat="server" CssClass="form-control" onkeypress="return pulsar(event)" TabIndex="23" TextMode="Date" Width="160px"></asp:TextBox>
                            <asp:Label ID="Label24" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtCantidad0" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Number" Width="160px"></asp:TextBox>
                            <br /><br />
                            <asp:Label ID="Label25" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Precio Unitario:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtPrecioUnitario0" runat="server" AutoPostBack="True" cssclass="form-control" onkeypress="return pulsar(event)" step="any" TabIndex="25" TextMode="Number" Width="160px"></asp:TextBox>
                            <asp:Label ID="Label27" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Incremento:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtIncremento0" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" step="any" TabIndex="26" TextMode="Number" Width="160px"></asp:TextBox>
                            <br /><br />
                            <asp:Label ID="Label28" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Bonificación:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtBonificacionPorcentaje0" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" step="any" TabIndex="27" TextMode="Number" Width="160px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Button ID="btnAceptarItem0" runat="server" BorderStyle="None" class="btn btn-success btn-circle" OnClick="btnAceptarItem_Click" TabIndex="28" Text="Aceptar Item" ValidationGroup="Aceptar" width="130px" />
                            <asp:TextBox ID="txtSerieID" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Number" Visible="False" Width="160px"></asp:TextBox>
                            <asp:TextBox ID="txtLoteID" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Number" Visible="False" Width="160px"></asp:TextBox>
                            <asp:TextBox ID="txtLoteAVenderCompleto" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Number" Visible="False" Width="160px"></asp:TextBox>
                        </asp:Panel>
   
   </div>
   </div>
        </form>
   
</asp:Content>

