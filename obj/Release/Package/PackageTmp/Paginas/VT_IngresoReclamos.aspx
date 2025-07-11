<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_IngresoReclamos.aspx.cs" Inherits="SintecromNet.Paginas.VT_IngresoReclamos" %>
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
    <h2>Ingreso Reclamos de Clientes</h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div class="panel panel-primary">

            <div class="panel-heading"><h4>Nuevo Reclamo</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                <asp:Label ID="Label1" runat="server" cssclass="form-control" Text="Tipo:" Width="150px" BorderStyle="None" BackColor="#337AB7" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList1"  cssclass="form-control" runat="server" Width="200px">
                <asp:ListItem Value="Producto">--Seleccione</asp:ListItem>
                <asp:ListItem Value="Producto">Producto</asp:ListItem>
                <asp:ListItem Value="Otros">Otros</asp:ListItem>                
            </asp:DropDownList>  
            <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fecha:" Width="150px"></asp:Label>
            <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="200px" ReadOnly="True"></asp:TextBox>
            
            <br /><br /> 
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cliente:" Width="150px"></asp:Label>
                         <asp:DropDownList ID="ddClientes" runat="server" CssClass="form-control" Width="200px">
                                </asp:DropDownList>           
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Cliente No puede Estar Vacio" ControlToValidate="ddClientes" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Contacto:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtContacto" cssclass="form-control" runat="server" Width="200px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="El Campo Contacto No Puede Estar Vacio" ControlToValidate="txtContacto" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label5" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Email:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtEmail" cssclass="form-control" runat="server" Width="200px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="El Campo Email No Puede Estar Vacío" ControlToValidate="txtEmail" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
           <%-- <br />   
            <br /> --%>
            <asp:Label ID="Label8" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Remito:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtRemito" cssclass="form-control" runat="server" Width="200px" TextMode="Number">0</asp:TextBox>   
            <asp:Button ID="Button2" runat="server" class="btn btn-success btn-circle" width="160px" Text="Detalle" OnClick="Button2_Click" BorderStyle="None" BackColor="Maroon"  />           
            <br />   
            <br /> 
            <%--<br />   
            <br />                         
            
            <br /> 
            <br />  
            <br />--%>
            
           <%-- <br />        
            <br />        
            <br /> 
            <br /> 
            <br />--%>
                           
          
        
                   
                      <%--  <br />
                        <br />--%>
                        <asp:Panel ID="Panel1" runat="server" Visible="False">
                            <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound1" DataKeyNames="Numero,SerieLote,Kilos,CodigoProducto,DescProducto">
                                <Columns>
                                    <asp:TemplateField HeaderText="Seleccionar">
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkSelecciona" runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Numero" HeaderText="Remito" />
                                    <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                                    <asp:BoundField DataField="Kilos" DataFormatString="{0:n0}" HeaderText="Kilos" />
                                    <asp:BoundField DataField="SerieLote" HeaderText="Serie Lote" />
                                    <asp:BoundField DataField="CodigoProducto" HeaderText="Producto" />
                                    <asp:BoundField DataField="DescProducto" HeaderText="Descripcion" />
                                </Columns>
                                <HeaderStyle  HorizontalAlign="Center" VerticalAlign="Middle"/>
                                <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:GridView>
                             <br />
                            <%--<asp:Label ID="Label10" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cantidad:" Width="150px"></asp:Label>--%>
                            <%--<asp:TextBox ID="txtCantidad" runat="server" cssclass="form-control" Width="200px"></asp:TextBox>--%>
                            <asp:Label ID="Label11" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Motivo:" Width="150px"></asp:Label>
                            <asp:TextBox ID="txtMotivo" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="200px"></asp:TextBox>
                           <%-- <br /> 
                            <br /> 
                            <br /> --%>
                            <asp:Label ID="Label12" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Observaciones:" Width="150px"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="El Campo Motivo No Puede Estar Vacío" ControlToValidate="txtMotivo" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtObservaciones" runat="server" cssclass="form-control" Height="70px" TextMode="MultiLine" Width="200px"></asp:TextBox>
                            <br /> 
                            <br /> 
                            <br /> 
                            <br />
                            <asp:Label ID="Label13" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Reclamo Externo:" Width="150px"></asp:Label>
                            <asp:TextBox ID="txtReclamoExterno" cssclass="form-control" runat="server" Width="200px"></asp:TextBox>  
                            <asp:Label ID="Label14" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Emitido Por:" Width="150px"></asp:Label>
                            <asp:TextBox ID="txtEmite" cssclass="form-control" runat="server" Width="200px"></asp:TextBox> 
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="El Campo Emite No Puede Estar Vacío" ControlToValidate="txtEmite" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
                            <br />  
                            <br /> 
                             <br />  
                              <asp:Button ID="btnEjecutar" runat="server" class="btn btn-success btn-circle" width="130" Text="Aceptar" OnClick="btnEjecutar_Click" BorderStyle="None" ValidationGroup="Aceptar"  />
                            <%--onclientclick="return estaseguro()"--%> 
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

                            <asp:Button ID="Button1" runat="server" class="btn btn-success btn-circle" width="130" 
                            Text="Cancelar" TabIndex="170" BackColor="#CC3300" BorderStyle="None" OnClick="Button1_Click" />
                            </asp:Panel>
          
        
                   
                        <br />
                        <br />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />
          
        
                   
                    </div>
           
                </div>

        </div>
        
     
        </div>
        </form>
        </asp:Content>

