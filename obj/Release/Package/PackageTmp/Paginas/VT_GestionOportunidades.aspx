<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="VT_GestionOportunidades.aspx.cs" Inherits="SintecromNet.Paginas.VT_GestionOportunidades" %>
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
</script>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <h2>Gestión Depósito Oportunidades</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                
                    <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Familia:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="140px">
                        </asp:DropDownList>

                        
                        
                <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Espesor:" Width="140px"></asp:Label>
                 <asp:DropDownList ID="ddEspesor" runat="server" CssClass="form-control" Width="140px">
                        </asp:DropDownList>
                        <br />  <br /> 
               <asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Aleación:" Width="140px"></asp:Label>
                <asp:DropDownList ID="ddAleacion" runat="server" CssClass="form-control" Width="140px">
                        </asp:DropDownList>
                        
                        <asp:Label ID="Label1" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Temple:" Width="140px"></asp:Label>
               <asp:DropDownList ID="ddTemple" runat="server" CssClass="form-control" Width="140px">
                        </asp:DropDownList>
               <br />  <br />
                        
                <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Forma:" Width="140px"></asp:Label>
                <asp:DropDownList ID="ddForma" runat="server" CssClass="form-control" Width="140px">
                </asp:DropDownList>
                 <asp:Label ID="Label4" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Terminación:" Width="140px"></asp:Label>
                    <asp:DropDownList ID="ddTerminacion" runat="server" CssClass="form-control" Width="140px">
                    </asp:DropDownList>
               
           &nbsp;&nbsp;&nbsp
               
<asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="Buscar" OnClick="LinkButton1_Click"><span class="glyphicon glyphicon-search"></span></asp:LinkButton>
            
          
                        </div>
                    </div>
             </div>

        <div id="Mensaje" runat="server" visible="false" class="alert-info">
            <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-dark" Text="" OnClick="LinkButton3_Click" ToolTip="Cerrar"><i class="fa fa-close"></i></asp:LinkButton>
                 <h3>Nota de Calidad</h3>
            
                 <br />
            
             <h5><asp:Label ID="Label5" runat="server" Text=""></asp:Label></h5>
            
          
        </div>
        <div id="Masivo" runat="server" visible="false" class="alert-info">
            <%--<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-dark" Text="" OnClick="LinkButton3_Click" ToolTip="Cerrar"><i class="fa fa-close"></i></asp:LinkButton>--%>
                 <h3>Modificación Masiva de Precios</h3>
            
                 <div class="input-group">
                
                <asp:Label ID="Label3" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Precio:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtPrecioMasivo" runat="server" CssClass="form-control"  Width="150px" ValidationGroup="Aceptar">0</asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                    ControlToValidate="txtPrecioMasivo" runat="server"
                    ErrorMessage="*"
                    ValidationExpression="\d+" ForeColor="#CC3300"></asp:RegularExpressionValidator>
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnAceptar" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnAceptar_Click" Text="Aceptar" BorderStyle="None" ValidationGroup="Aceptar" />
                        &nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCancelar" CssClass="btn btn-danger btn-circle" ForeColor="White" runat="server" OnClick="btnCancelar_Click" Text="Salir" BorderStyle="None" ValidationGroup="Aceptar" />
      
                <br />
                     <br />
                     <h2><asp:Label ID="Label6" runat="server" Text="" Visible="false"></asp:Label></h2>
                     <br />
                
                </div>
            
          
        </div>

<%--<asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
 
        <br />--%>
<asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-success" ToolTip="Modificación Masiva"  Visible="false" OnClick="LinkButton3_Click1"><span class="glyphicon glyphicon-usd"></span></asp:LinkButton>

        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound2" OnRowCommand="gwGrilla_RowCommand"
                    DataKeyNames="LOTE_ID,PRECIO,NotaCalidad" 
                    OnRowEditing="gwGrilla_RowEditing" OnRowUpdating="gwGrilla_RowUpdating" OnRowCancelingEdit="gwGrilla_RowCancelingEdit">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <%--<asp:BoundField DataField="DESPRODUCTO" HeaderText="Des.Producto" >
            </asp:BoundField>--%>
            <%--<asp:ButtonField  CommandName="editar"  DataTextField="precio" 
                HeaderText="Precio" ButtonType="Button"  DataTextFormatString="{0:0.000}" 
                ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-primary" ItemStyle-HorizontalAlign="Center" 
                ItemStyle-VerticalAlign="Middle">            
            <ControlStyle BorderStyle="None" CssClass="btn btn-primary"></ControlStyle>

            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
            </asp:ButtonField>--%>

            <asp:CommandField ShowEditButton="True" />
            <%--<asp:BoundField DataField="Kilos" HeaderText="Stock" DataFormatString="{0:n0}" />--%>
            <asp:TemplateField HeaderText="Des.Producto" ShowHeader="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="lblProd" runat="server" style="text-align:center" Text='<%# Eval("DESPRODUCTO") %>'></asp:Label>            
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblProd1" runat="server" style="text-align:center" Text='<%# Eval("DESPRODUCTO") %>'></asp:Label>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Stock" ShowHeader="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="lblStock" runat="server" style="text-align:center" Text='<%# Eval("Kilos") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblStock1" runat="server" style="text-align:center" Text='<%# Eval("Kilos") %>'></asp:Label>

                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Precio" ShowHeader="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="lblPrecio" runat="server" style="text-align:center" Text='<%# Eval("Precio") %>' Width="140px"></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control" Text='<%# Eval("Precio") %>' ></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                    ControlToValidate="txtPrecio" runat="server"
                    ErrorMessage="Debe ser un Importe !!"
                    ValidationExpression="[\d,.]+" ForeColor="#CC3300"></asp:RegularExpressionValidator>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Serie Lote" ShowHeader="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="lblSL" runat="server" style="text-align:center" Text='<%# Eval("SL") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblSL1" runat="server" style="text-align:center" Text='<%# Eval("SL") %>'></asp:Label>

                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Ancho en Proceso" ShowHeader="True" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Label ID="lblAncho" runat="server" style="text-align:center" Text='<%# Eval("AnchoEnProceso") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Label ID="lblAncho1" runat="server" style="text-align:center" Text='<%# Eval("AnchoEnProceso") %>'></asp:Label>

                </EditItemTemplate>
            </asp:TemplateField>

            
            <%--<asp:BoundField DataField="SL" HeaderText="Serie Lote" />--%>
           
            <%--<asp:BoundField DataField="AnchoEnProceso" HeaderText="Ancho en Proceso" DataFormatString="{0:n0}" >
           </asp:BoundField>--%>
            <asp:TemplateField HeaderText="Nota" ShowHeader="True">
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="Estado" Text='<%# Eval("Nota") %>'
                        CommandArgument='<%# Eval("NotaCalidad")%>'  />
                </ItemTemplate>
                <ControlStyle BorderStyle="None" CssClass="btn btn-primary" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:TemplateField>
            <asp:BoundField DataField="LOTE_ID" HeaderText="Lote_ID" Visible="False" />
            <asp:BoundField DataField="NotaCalidad" HeaderText="Notacalidad" Visible="False" />

        </Columns>
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="Small" />
                    
                    
        </asp:GridView>
        
       <%-- <div id="EditarPrecio" runat="server" class="panel panel-primary" visible="false">
            <div class="panel-heading">Editar Precio</div>
            <div class="panel-body">
                 <div class="input-group">
                
                <asp:Label ID="Label3" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Precio:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtPrecio" runat="server" CssClass="form-control"  Width="150px" ValidationGroup="Aceptar">0</asp:TextBox>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                    ControlToValidate="txtPrecio" runat="server"
                    ErrorMessage="*"
                    ValidationExpression="\d+" ForeColor="#CC3300"></asp:RegularExpressionValidator>
                <br /><br />
                <asp:Button ID="btnAceptar" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnAceptar_Click" Text="Aceptar" BorderStyle="None" ValidationGroup="Aceptar" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnCancelar" CssClass="btn btn-danger btn-circle" ForeColor="White" runat="server" OnClick="btnCancelar_Click" Text="Cancelar" BorderStyle="None" ValidationGroup="Aceptar" />
      
                </div>
                  
                        
            </div>
        </div>--%>

        
  
</div>
</form>
        </asp:Content>

