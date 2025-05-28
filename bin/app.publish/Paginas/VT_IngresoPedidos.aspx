<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_IngresoPedidos.aspx.cs" Inherits="SintecromNet.Paginas.VT_IngresoPedidos" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
         
    <script  type="text/javascript">

        //javascript:window.history.forward(1); //Esto es para cuando le pulse al botón de Atrás
        //javascript:window.history.back(1); //Esto para cuando le pulse al botón  de Adelante
        //document.body.onload = function() {alert("ok");}

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

    var inputs = document.querySelectorAll("input,select");
    for (var i = 0 ; i < inputs.length; i++) {
        inputs[i].addEventListener("keypress", function(e){
            if (e.which == 13) {
                e.preventDefault();
                var nextInput = document.querySelectorAll('[tabIndex="' + (this.tabIndex + 1) + '"]');
                if (nextInput.length === 0) {
                    nextInput = document.querySelectorAll('[tabIndex="1"]');
                }
                nextInput[0].focus();
            }
        })
    }

    function pulsar(e)
    {
            // averiguamos el código de la tecla pulsada (keyCode para IE y which para Firefox)
            tecla = (document.all) ? e.keyCode :e.which;
            // si la tecla no es 13 devuelve verdadero,  si es 13 devuelve false y la pulsación no se ejecuta
            return (tecla!=13);
    }
    function stopRKey(evt) {
        var evt = (evt) ? evt : ((event) ? event : null);
        var node = (evt.target) ? evt.target : ((evt.srcElement) ? evt.srcElement : null);
        if ((evt.keyCode == 13) && (node.type == "text")) { return false; }
    }
    document.onkeypress = stopRKey;

    function proximo(e, cajadestino) {
        // averiguamos el código de la tecla pulsada (keyCode para IE y which para Firefox)
        tecla = (document.all) ? e.keyCode : e.which;
        if (tecla == 13)
            document.getElementById(cajadestino).focus();
        return true;
    }

    function disableEnterKey(e){
        var key;
        if(window.event){
            key = window.event.keyCode; //IE
        }else{
            key = e.which; //firefox
        }
        if(key==13){
            return false;
        }else{
            return true;
        }
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
    <%--<script src="assets/js/custom.js"></script>--%>
    
    <%-- <br /> --%><%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Cliente No puede Estar Vacio" ControlToValidate="ddClientesPedidos" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>--%>

    </asp:Content >


<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">

     <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        
        <div class="panel panel-primary">

            <div class="panel-heading"><h4>Ingreso de Pedidos</h4>
            </div>
                <div class="panel-body">                
                    <div class="input-group">
                              
                       
            <asp:Panel ID="Panel2" runat="server" Height="531px">
                <asp:Panel ID="Panel4" runat="server" BorderStyle="Outset" verticalalign="Left" BorderWidth="3px" Width="602px" BackColor="#CCCCCC" style="text-align: center" Visible="True"  HorizontalAlign="Left">
     
            <asp:CheckBox ID="CBOcultaBonif" runat="server" Text="Oculta Bonificación" Width="180px" style="text-align: left"/>            
            <asp:CheckBox ID="CBFacturaAnticipada" runat="server" Text="Factura Anticipada" Width="180px"  style="text-align: left" />
            <asp:CheckBox ID="CBRespetaPrecioPedido" runat="server" Text="Respeta Precio Pedido" Width="180px"  style="text-align: left"/>
            <br />  
            <asp:CheckBox ID="CBInhabilitaFiltro" runat="server" Text="Inhabilita Filtro Prod." Width="180px"  style="text-align: left" OnCheckedChanged="CBInhabilitaFiltro_CheckedChanged"/>
            <asp:CheckBox ID="CBFacturaAntes" runat="server" Text="Fact. Antes de Remitir" Width="180px"  style="text-align: left"/>
            <asp:CheckBox ID="CBLotesAVender" runat="server" Text="Reventa" Width="180px"  style="text-align: left" OnCheckedChanged="CBLotesAVender_CheckedChanged"/>
            </asp:Panel>
               
                   <%-- <br /> --%>               
            <asp:Label ID="Label1" runat="server" cssclass="form-control" Text="Tipo:" Width="140px" BorderStyle="None" BackColor="#337AB7" ForeColor="White"></asp:Label>
            <asp:DropDownList ID="ddTipo"  cssclass="form-control" runat="server" Width="160px" TabIndex="1" OnSelectedIndexChanged="ddTipo_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Value="Producto">--Seleccione</asp:ListItem>
                <asp:ListItem Value="V">Venta</asp:ListItem>
                <asp:ListItem Value="E">Exportación</asp:ListItem>
                <asp:ListItem Value="Z">Zstock</asp:ListItem>    
                <asp:ListItem Value="F">Fraccionamiento</asp:ListItem>              
            </asp:DropDownList>             
            <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fecha:" Width="140px"></asp:Label>
            <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="160px" TextMode="Date" TabIndex="2"></asp:TextBox>
            <br />  <br />
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cliente:" Width="140px"></asp:Label>
                         <asp:DropDownList ID="ddClientesPedidos" runat="server" CssClass="form-control" Width="460px" AutoPostBack="True" OnSelectedIndexChanged="ddClientesPedidos_SelectedIndexChanged" TabIndex="3">
                                </asp:DropDownList>           
            
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="ddClientesPedidos" CssClass="alert-danger" ErrorMessage="El Campo Cliente No puede Estar Vacío" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
            
            <br /><br /> 
            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Cliente No puede Estar Vacio" ControlToValidate="ddClientesPedidos" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>--%>
            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="El Campo Orden de Compra No Puede Estar Vacio" ControlToValidate="txtOrdenCompra" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>--%>
            <asp:Label ID="Label5" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Condición:" Width="140px"></asp:Label>
                         <asp:DropDownList ID="ddCondicion" runat="server" CssClass="form-control" Width="160px" TabIndex="4">
                                </asp:DropDownList>           
            <asp:Label ID="Label8" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Moneda:" Width="140px"></asp:Label>
            <asp:DropDownList ID="ddMoneda" runat="server" CssClass="form-control" Width="160px" TabIndex="5">
            </asp:DropDownList> 
            <br /><br /> 
            <asp:Label ID="Label15" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Tipo de Pago:" Width="140px"></asp:Label>
            <asp:DropDownList ID="ddTipoPago" runat="server" CssClass="form-control" Width="160px" TabIndex="6" Font-Size="Smaller">
            </asp:DropDownList>       
           
            <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Orden Compra:" Width="140px"></asp:Label>
            <asp:TextBox ID="txtOrdenCompra" cssclass="form-control" runat="server" Width="160px" type="text"  TabIndex="7"></asp:TextBox>   
            <br /><br /> 
           
            <asp:Label ID="Label14" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Transportista:" Width="140px"></asp:Label>
            <asp:DropDownList ID="ddTransportista" runat="server" CssClass="form-control" Width="160px" TabIndex="8" Font-Size="Smaller">
            </asp:DropDownList>
            <asp:Label ID="Label13" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Domicilio Entrega:" Width="140px"></asp:Label>
            <asp:DropDownList ID="ddDomicilioEntrega" runat="server" CssClass="form-control" Width="160px" TabIndex="9" Font-Size="Smaller">
            </asp:DropDownList>
             <br /><br />
            <asp:Label ID="Label11" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Nota Producción:" Width="140px"></asp:Label>
            <asp:TextBox ID="txtNotaProduccion" cssclass="form-control" runat="server" Width="460" TextMode="MultiLine" TabIndex="10"></asp:TextBox>  
            <br /><br />

            <asp:Label ID="Label16" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fact. Anticipadas:" Width="140px"></asp:Label>
            <asp:DropDownList ID="ddFacturasAnticipadas" runat="server" CssClass="form-control" Width="460px" TabIndex="11">
            </asp:DropDownList> 
                           
            <br />
            <asp:Button ID="btnIngresarItems" runat="server" class="btn btn-success btn-circle" width="160px" Text="Ingresar Items" OnClick="btnIngresarItems_Click" BorderStyle="None" BackColor="Maroon" TabIndex="12" />           
            
            </asp:Panel>

                    <asp:Panel ID="Panel3" runat="server">
                        <asp:Label ID="lblPedidoResumen" runat="server" BackColor="#006699" CssClass="form-control" ForeColor="White" Text="Pedido:" Width="600px"></asp:Label>
                        <br /><br /> 
                        <asp:Label ID="lblPedidoTotal" runat="server" BackColor="#006699" CssClass="form-control" ForeColor="White" Text="Total Pedido: " Width="450px"></asp:Label>
                        <asp:Button ID="btnVerCabecera" runat="server" class="btn btn-success btn-circle" width="150px" Text="Ver Cabecera" OnClick="btnVerCabecera_Click" BorderStyle="None" BackColor="Maroon" TabIndex="20"  />           
                    </asp:Panel>  

                    <asp:Panel ID="Panel8" runat="server" Height="200px" Width="500">
                        <asp:Label ID="lblNumeroPedido" runat="server" BackColor="#006699" CssClass="form-control" ForeColor="White" Text="NUMERO DE PEDIDO:" Width="300px"></asp:Label>
                        <asp:Button ID="btnOK" runat="server" class="btn btn-success btn-circle" width="150px" Text="Ok" OnClick="btnOK_Click" BorderStyle="None" BackColor="Maroon"  />           

                    </asp:Panel>  
                     
                        <br />
                <asp:Panel ID="Panel1" runat="server">  <%--Height="367px"--%>

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
                    <asp:TextBox ID="txtCantidad" cssclass="form-control" runat="server" Width="160px" TextMode="Number" type="text" onkeypress="return pulsar(event)" TabIndex="15"></asp:TextBox>  
                        <br /><br /> 
                    <asp:Label ID="Label7" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Precio Unitario:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtPrecioUnitario" cssclass="form-control" runat="server" Width="160px" TextMode="Number" step="any" onkeypress="return pulsar(event)" TabIndex="16"></asp:TextBox> 
                    <asp:Label ID="Label9" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Precio Lista:" Width="140px" ></asp:Label>
                    <asp:TextBox ID="txtPrecioLista" runat="server" CssClass="form-control" Width="160px" TextMode="Number" step="any" onkeypress="return pulsar(event)" TabIndex="17"></asp:TextBox>
                        <br /><br /> 
                    <asp:Label ID="Label18" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Incremento:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtIncremento" cssclass="form-control" runat="server" Width="160px" TextMode="Number" step="any" onkeypress="return pulsar(event)" TabIndex="18"></asp:TextBox> 
<%--                    <asp:Label ID="Label19" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cant.No Lineal:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtCantNoLineal" runat="server" CssClass="form-control" Width="160px" TextMode="Number" onkeypress="return pulsar(event)" TabIndex="19"></asp:TextBox>--%>
                    <asp:Label ID="Label20" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Bonificación:" Width="140px"></asp:Label>
                    <asp:TextBox ID="txtBonificacionPorcentaje" cssclass="form-control" runat="server" Width="160px" TextMode="Number" step="any" onkeypress="return pulsar(event)" TabIndex="19"></asp:TextBox> 
                    <br /><br />        
                    <asp:Button ID="btnAceptarItem" runat="server" BorderStyle="None" class="btn btn-success btn-circle" OnClick="btnAceptarItem_Click" Text="Aceptar Item" ValidationGroup="Aceptar" width="130" />
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
                        <br />
                        <asp:Panel ID="Panel7" runat="server" >
                            <asp:Label ID="Label21" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Lote a Vender: (XXXXX - XX)" Width="140px" Height="50px"></asp:Label>
                            <asp:TextBox ID="txtLoteAVender" runat="server" AutoPostBack="True" cssclass="form-control" onkeypress="return pulsar(event)" OnTextChanged="txtLoteAVender_TextChanged" TabIndex="22" Width="160px" Height="50px"></asp:TextBox>
                            <asp:Label ID="LblLoteAVender" runat="server" BackColor="White" BorderColor="#3399FF" BorderStyle="Inset" CssClass="form-control" Font-Names="Arial" Font-Size="Smaller" ForeColor="Black" Width="300px" Height="100px"></asp:Label>
                            <br />
                            <br />
                            <br />
                            <br />
                            <asp:Label ID="Label22" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Producto:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtProducto" runat="server" AutoPostBack="True" cssclass="form-control" Font-Size="Smaller" onkeypress="return pulsar(event)" step="any" TabIndex="23" Width="460px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Label ID="Label23" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fec.Solicitada:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtFechaSolicitada0" runat="server" CssClass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Date" Width="160px"></asp:TextBox>
                            <asp:Label ID="Label24" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtCantidad0" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="25" TextMode="Number" Width="160px"></asp:TextBox>
                            <br /><br />
                            <asp:Label ID="Label25" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Precio Unitario:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtPrecioUnitario0" runat="server" AutoPostBack="True" cssclass="form-control" onkeypress="return pulsar(event)" step="any" TabIndex="26" TextMode="Number" Width="160px"></asp:TextBox>
                            <asp:Label ID="Label27" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Incremento:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtIncremento0" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" step="any" TabIndex="27" TextMode="Number" Width="160px"></asp:TextBox>
                            <br /><br />
                            <asp:Label ID="Label28" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="% Bonificación:" Width="140px"></asp:Label>
                            <asp:TextBox ID="txtBonificacionPorcentaje0" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" step="any" TabIndex="28" TextMode="Number" Width="160px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Button ID="btnAceptarItem0" runat="server" BorderStyle="None" class="btn btn-success btn-circle" OnClick="btnAceptarItem_Click" Text="Aceptar Item" ValidationGroup="Aceptar" width="130px" />
                            <asp:TextBox ID="txtSerieID" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Number" Visible="False" Width="160px"></asp:TextBox>
                            <asp:TextBox ID="txtLoteID" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Number" Visible="False" Width="160px"></asp:TextBox>
                        </asp:Panel>


                            <asp:TextBox ID="txtLoteAVenderCompleto" runat="server" cssclass="form-control" onkeypress="return pulsar(event)" TabIndex="24" TextMode="Number" Visible="False" Width="160px"></asp:TextBox>
                        <asp:Panel ID="Panel6" runat="server">
                            <div style="overflow:auto; width:600px; height:130px; ">
                            <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover"  DataKeyNames ="CodigoProducto,Kilos"
                            onrowdatabound="gwGrilla_RowDataBound" AutoGenerateDeleteButton="True" OnRowDeleting="gwGrilla_RowDeleting" 
                            OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged" AutoGenerateColumns="False" TabIndex="23">
                                <Columns>
                                    <asp:BoundField DataField="CodigoProducto" HeaderText="Producto"/>
                                    <asp:BoundField DataField="DescProducto" HeaderText="Descripción" />
                                    <asp:BoundField DataField="FechaSolicitada" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Solicitada" />
                                    <asp:BoundField DataField="Kilos" DataFormatString="{0:n0}" HeaderText="Kilos" />
                                    <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio Unitario" />
                                    <asp:BoundField DataField="PrecioLista" HeaderText="Precio Lista" />
                                    <asp:BoundField DataField="Incremento" HeaderText="Incremento" />
                                    <asp:BoundField DataField="PrecioIncremento" HeaderText="Precio + Increm." />
                                    <asp:BoundField DataField="BonificacionPorcentaje" HeaderText="% Bonif." />
                                    <asp:BoundField DataField="LoteAVender" HeaderText="Lote a vender" />
                                    <asp:BoundField DataField="Autenticar_ProductoCobertura" HeaderText="Autenticar Prod. Cob." />
                                    <asp:BoundField DataField="TotalItem" HeaderText="Total" />
                                    <asp:BoundField DataField="LoteAVender_Serie" HeaderText="LoteAVender_Serie" Visible="False" />
                                    <asp:BoundField DataField="LoteAVender_Lote" HeaderText="LoteAVender_Lote" Visible="False" />
                                    <asp:BoundField DataField="LoteAVenderCompleto" HeaderText="LoteAVenderCompleto" />
                                </Columns>
                                <HeaderStyle  HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Smaller"/>
                                <RowStyle HorizontalAlign="Center" Font-Size="7pt" VerticalAlign="Middle" />
                            </asp:GridView>
                                </div>
                            <asp:Button ID="btnAceptarPedido" runat="server" class="btn btn-success btn-circle" width="130" Text="Aceptar Pedido" OnClick="btnAceptarPedido_Click" BorderStyle="None" ValidationGroup="Aceptar" TabIndex="30" />
                            <asp:Button ID="btnCancelarPedido" runat="server" class="btn btn-success btn-circle" width="130" Text="Cancelar" TabIndex="31" BackColor="#CC3300" BorderStyle="None" OnClick="btnCancelarPedido_Click"/>
                        </asp:Panel>
                 <%--       <br />
                        <br />--%>
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />      
                    </div>        
                </div>
        </div>             
        </div>
        </form>
        </asp:Content>

