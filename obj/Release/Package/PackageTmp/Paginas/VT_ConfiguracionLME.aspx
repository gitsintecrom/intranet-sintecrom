<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_ConfiguracionLME.aspx.cs" Inherits="SintecromNet.Paginas.VT_ConfiguracionLME" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de de Habilitar todos los Items?')) return false;
    }
    function estaseguro1() {

        if (!confirm('Esta Seguro de Deshabilitar todos los Items?')) return false;
    }

    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date(); a = s.createElement(o),
  m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

    ga('create', 'UA-67198984-1', 'auto');
        ga('send', 'pageview');
        $('#myModal').on('shown.bs.modal', function () {
            $('#myInput').trigger('focus')
        })
    </script>

    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <h2>Lista Aluminio LME</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Configuración&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="&lt;span class=&quot;glyphicon glyphicon-search&quot;&gt;&lt;/span&gt;" OnClick="LinkButton1_Click" ToolTip="Editar"></asp:LinkButton>
            
          
                        </h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
                    <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Lista N°:" Width="140px"></asp:Label>
                
                <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control" Width="140px" TextMode="Number"></asp:TextBox>
                
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNumero" CssClass="alert-danger" ErrorMessage="Debe Ingresar un Numero" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                
                        <asp:Label ID="labelRes0" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Vigencia:" Width="140px"></asp:Label>
                        <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="140px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxIni" CssClass="alert-danger" ErrorMessage="Debe Ingresar una Vigencia" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                        
                        <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                        </asp:MaskedEditExtender>
                        <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
                        </asp:CalendarExtender>
                    <br />  <br /> 
                        
                        
                <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" Width="140px"></asp:Label>
                
                <asp:TextBox ID="txtVersion" runat="server" CssClass="form-control" Width="140px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtVersion" CssClass="alert-danger" ErrorMessage="Debe Ingresar Version" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>
                
                        <asp:Label ID="Label1" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Activación:" Width="140px"></asp:Label>
                <asp:DropDownList ID="ddHabilita" runat="server" CssClass="form-control" Width="140px">
                    <asp:ListItem Value="0">No</asp:ListItem>
                    <asp:ListItem Value="1">Si</asp:ListItem>
                </asp:DropDownList>
              
               
           &nbsp;&nbsp;&nbsp
               
                          <asp:Button ID="btnAceptar" runat="server" cssclass="btn btn-success btn-circle" width="140px" OnClick ="btnAceptar_Click" style="text-align: center" TabIndex="50" Text="Aceptar" ValidationGroup="Aceptar" />
            
          
                          <asp:Button ID="btnEditar" runat="server" cssclass="btn-warning btn-circle" width="140px" OnClick ="btnEditar_Click" style="text-align: center" TabIndex="50" Text="Modificar" ValidationGroup="Aceptar" Visible="False" />
            
          
                        </div>
                    </div>
             </div>

 
    
<br />
        <%--<div id="Div1" runat="server" visible="false" class="alert-info">--%>
                            <div id="Div1" runat="server" visible="false"  class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title">Aviso</h5>
                        
                      </div>
                      <div class="modal-body">
                        <p>La Lista ingresada ya existe, desea modificarla?.</p>
                      </div>
                      <div class="modal-footer">
                          <asp:Button ID="btnModifica" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="btnModifica_click" style="text-align: center" TabIndex="50" Text="Modificar" />
                          <asp:Button ID="btnCancela" runat="server" cssclass="btn btn-danger btn-circle" width="150px" OnClick ="btnCancela_click" style="text-align: center" TabIndex="50" Text="Cancelar" />
                        </div>
                    </div>
                  </div>
            <%--</div>--%>
                <%--<asp:Label ID="lblError" runat="server"  CssClass="form-control" Visible ="false" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>--%>
        <div id="Div2" runat="server" visible="false"  class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title">Buscar
                            <asp:Label ID="Label3" runat="server"  CssClass="form-control" BackColor="#CC3300" ForeColor="White" style="text-align: left" Text="Lista N°:" Width="400px" Visible="False"></asp:Label>
                
                          </h5>
                        
                      </div>
                      <div class="modal-body">
                        <p>Ingrese la Lista que desee modificar.</p>
                            <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Lista N°:" Width="100px"></asp:Label>
                
                <asp:TextBox ID="txtBuscaLista" runat="server" CssClass="form-control" Width="100px" TextMode="Number"></asp:TextBox>
                
                      </div>
                      <div class="modal-footer">
                          <asp:Button ID="Button1" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="Button1_click" style="text-align: center" TabIndex="50" Text="Aceptar" />
                          <asp:Button ID="Button2" runat="server" cssclass="btn btn-danger btn-circle" width="150px" OnClick ="Button2_click" style="text-align: center" TabIndex="50" Text="Cancelar" />
                        </div>
                    </div>
                  </div>

                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />
          
      
        <div id="Mensaje" runat="server" visible="false" class="alert-info">
            <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="True"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
            <h4>
                   <asp:Label ID="Label4" runat="server"  CssClass="form-control" width="200px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Numero de Lista:" ></asp:Label>
                   <asp:Label ID="lblLista" runat="server"  CssClass="form-control" width="60px"  BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                   <asp:Label ID="Label5" runat="server"  CssClass="form-control" width="150px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Vigencia:" ></asp:Label>
               
                    <asp:Label ID="lblVigencia" runat="server"  CssClass="form-control"  width="100px" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                    <asp:Label ID="Label6" runat="server"  CssClass="form-control" width="100px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                
                    <asp:Label ID="lblVersion" runat="server"  CssClass="form-control"  width="100px"  BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Versión:" ></asp:Label>
                
                 <br />  <br /> 
                    <asp:Label ID="Label7" runat="server"  CssClass="form-control" width="550px"  BackColor="White" ForeColor="#337AB7" style="text-align: left; top: 0px; left: 0px;" Text="Los precios están expresados en dólares estadounidenses y no incluyen I.V.A." ></asp:Label>

                



                   <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos">
                       <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            
                           <asp:BoundField DataField="Zona" HeaderText="Zona" />
                           <asp:BoundField DataField="CodigoCliente" HeaderText="Cod.Cliente" />
                           <asp:BoundField DataField="Cliente" HeaderText="Cliente" />
                           <asp:BoundField DataField="DescripcionProducto" HeaderText="Producto" />
                           <asp:BoundField DataField="Calidad" HeaderText="Calidad" />
                           <asp:BoundField DataField="LME" DataFormatString="{0:n3}" HeaderText="Lista" />
                           <asp:BoundField DataField="PrecioTransf" DataFormatString="{0:n3}" HeaderText="Precio Transf" />
                           <asp:BoundField DataField="TotalPrecio" DataFormatString="{0:n3}" HeaderText="Total Neto" />
                            <asp:BoundField DataField="Estado" HeaderText="Estado" />
                       </Columns>
                       <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                       <RowStyle Font-Names="Arial" Font-Size="8px" HorizontalAlign="Center" VerticalAlign="Middle" />
                   </asp:GridView>

                



            </h4>			

            
 
</div>
        
  
</div>
</form>
        </asp:Content>

