<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_GestionPañol.aspx.cs" Inherits="SintecromNet.Paginas.PROD_GestionPañol" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

  

        function calculoRepo() {
            var txt22 = $('#<%=txtReposicion.ClientID %>');
            txt22.prop('readonly', false);

            var txt = $('#<%=txtConsumo.ClientID %>').val();
            var txt2 = $('#<%=txtTiempo.ClientID %>').val();
            var total = ((parseFloat(txt2) * parseFloat(txt)) / 30);
           
            txt22.val(parseFloat(total).toFixed(2));
            //txt22.prop('readonly', true);


            
        }
       
        function validaFloat(nombre) {
            var numero = $(nombre).val();
            if (!/^([0-9])*[.]?[0-9]*$/.test(numero)) {
                alert("El valor " + numero + " no es un Número");
                nombre.focus();
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
    <h2>Gestión Pañol</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <asp:Panel ID="Panel2" runat="server" >
        

            <div class="input-group" >
               
         
                <span style ="float:right;">
                      
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="True" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
                        </span>
                 <span style ="float:left;">
                      
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="" OnClick="LinkButton1_Click" Visible="True" ToolTip="Nuevo Insumo"><i class="fas fa-file fa-2x"></i></asp:LinkButton>
                       <%--<i class="fas fa-file"></i>--%>
                        </span>
                <br />
                <br />
                <br />
                <div style="OVERFLOW: auto; HEIGHT:450px; width:850px">
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos" DataKeyNames="ID,Codigo,Descripcion,Ubicacion,Reposicion,Consumo,Requerimiento,TiempoCompra,UnidadMedida,Observaciones,Valor,Moneda,Cotizacion,rubro_id,fech_venc" OnRowCommand="gwGrilla_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        <asp:BoundField DataField="Rubro" HeaderText="Rubro" />
                        <asp:BoundField DataField="Ubicacion" HeaderText="Ubicación" />
                        <asp:BoundField DataField="Consumo" DataFormatString="{0:0.00}" HeaderText="Consumo" />
                        <asp:BoundField DataField="TiempoCompra" DataFormatString="{0:0.00}" HeaderText="L.Time" />
                        <asp:BoundField DataField="Reposicion" DataFormatString="{0:0.00}" HeaderText="Reposición" />
                        <asp:BoundField DataField="Stock" DataFormatString="{0:0.00}" HeaderText="Stock" />
                        <asp:BoundField DataField="Requerimiento" HeaderText="Req." />
                        <asp:BoundField DataField="UnidadMedida" HeaderText="U.M" />
                        <asp:BoundField DataField="fech_venc" HeaderText="Vencimiento" DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Observaciones" HeaderText="Obs." />

                        <asp:ButtonField CommandName="Editar"  
                        HeaderText="Editar" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Editar" >            
<ControlStyle BorderStyle="None" CssClass="btn btn-info"></ControlStyle>
            </asp:ButtonField>
            <asp:ButtonField CommandName="Eliminar"  
                HeaderText="Eliminar" ButtonType="Button" ControlStyle-CssClass="btn btn-danger" ControlStyle-BorderStyle="None" Text="Eliminar" >            
<ControlStyle BorderStyle="None" CssClass="btn btn-danger"></ControlStyle>
            </asp:ButtonField>
                        <asp:BoundField HeaderText="ID" Visible="False" />
                        <asp:BoundField DataField="rubro_ID" HeaderText="Rubro_ID" Visible="False" />
                    </Columns>
                    <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                    <RowStyle Font-Size="Small" />
                </asp:GridView>

            </div>
            </div>
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="panel panel-primary">

            <div class="panel-heading"><h4><asp:Label ID="Label1" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Font-Bold="True" Font-Size="Large"></asp:Label>
</h4></div>
                <div class="panel-body">     
                       <asp:GridView ID="gwGrillaProducto" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos" DataKeyNames="Codigo,Descripcion" OnRowCommand="gwGrillaProducto_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        

                        <asp:ButtonField CommandName="Seleccionar"  
                        HeaderText="Seleccionar" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Seleccionar" >            
                        <ControlStyle BorderStyle="None" CssClass="btn btn-info"></ControlStyle>
                        </asp:ButtonField>
          
                    </Columns>
                    <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                    <RowStyle Font-Size="Small" />
                </asp:GridView>
                    <div id="alta" runat="server" class="input-group">
             <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Código:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCodigo" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="El Campo Código No Puede Estar Vacio" ControlToValidate="txtCodigo" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Descripción:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtDescripcion" cssclass="form-control" runat="server" Width="600px"></asp:TextBox>           
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Descripción No puede Estar Vacio" ControlToValidate="txtDescripcion" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label14" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Rubro:" Width="150px"></asp:Label>
            <asp:DropDownList ID="ddRubro" runat="server" CssClass="form-control" Width="200px">
            </asp:DropDownList>
            <asp:Label ID="Label15" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Vencimiento:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtVenci" cssclass="form-control" runat="server"  Width="150px" TextMode="date"></asp:TextBox>
            
            <br />   
            <br />
            <asp:Label ID="Label5" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Ubicación:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtUbicacion" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="El Campo Ubicación No Puede Estar Vacío" ControlToValidate="txtUbicacion" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
              
            <br />   
            <br /> 
            <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Consumo:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtConsumo" cssclass="form-control" runat="server" onchange="calculoRepo();" Width="300px" TextMode="Number"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="El Campo Consumo No Puede Estar Vacío" ControlToValidate="txtConsumo" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label8" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Tiempo en Días:"  Width="150px"></asp:Label>
            <asp:TextBox ID="txtTiempo" cssclass="form-control" runat="server" onblur="calculoRepo();" Width="100px" TextMode="Number"></asp:TextBox>
            <br />   
            <br /> 
            <asp:Label ID="Label11" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Reposición:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtReposicion" cssclass="form-control" runat="server" Width="300px" TextMode="Number"></asp:TextBox>            
            <br />   
            <br /> 
            <asp:Label ID="Label7" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Requerimiento:" Width="150px"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" Width="100px">
                <asp:ListItem Value="S">Si</asp:ListItem>
                <asp:ListItem Value="N">No</asp:ListItem>
                        </asp:DropDownList>
              
            <br />   
            <br /> 
            <asp:Label ID="Label9" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Unidad de Medida:" Width="150px"></asp:Label>
            <asp:DropDownList ID="DropDownList2" runat="server" Width="100px">
                <asp:ListItem Value="Unidades">Unidades</asp:ListItem>
                <asp:ListItem Value="Kilos">Kilos</asp:ListItem>
                <asp:ListItem Value="Litros">Litros</asp:ListItem>
                <asp:ListItem Value="Metros">Metros</asp:ListItem>
                <asp:ListItem Value="m2">mts²</asp:ListItem>
                <asp:ListItem Value="Cajas">Caja</asp:ListItem>
                <asp:ListItem Value="Paquetes">Paquetes</asp:ListItem>
                        </asp:DropDownList>
            <br />   
            <br /> 
            <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Valor:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtValor" cssclass="form-control" runat="server" onchange="validaFloat(this);" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El Campo Valor No Puede Estar Vacío" ControlToValidate="txtValor" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label12" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Moneda:" Width="150px"></asp:Label>
            <asp:DropDownList ID="DropDownList3" runat="server" Width="100px">
                <asp:ListItem Value="Pesos">Pesos</asp:ListItem>
                    <asp:ListItem Value="Dólares">Dólares</asp:ListItem>               
                </asp:DropDownList>
            <br />   
            <br /> 
            <asp:Label ID="Label13" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Cotización:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCotizacion" cssclass="form-control" runat="server" onchange="validaFloat(this);" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="El Campo Cotización No Puede Estar Vacío" ControlToValidate="txtCotizacion" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label10" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Observaciones:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtObservaciones" cssclass="form-control" runat="server" Width="600px" TextMode="MultiLine"></asp:TextBox>   
            
            
            <br />  
            <br />
            <br />  
            
   
        <asp:Button ID="btnEjecutar" runat="server" class="btn btn-success btn-circle" width="130" Text="Aceptar"  OnClientClick="calculoRepo();" OnClick="btnEjecutar_Click" BorderStyle="None" ValidationGroup="Aceptar"  />
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

