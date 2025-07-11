<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SIS_GestionProyectos.aspx.cs" Inherits="SintecromNet.Paginas.SIS_GestionProyectos" %>
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
    <h2>Gestión Proyectos</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <asp:Panel ID="Panel2" runat="server" >
        

            <div class="input-group">
               
         
                <%--<span style ="float:right;">
                      
                        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="True" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
                        </span>--%>
                 <span style ="float:left;">
                      
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="" OnClick="LinkButton1_Click" Visible="True" ToolTip="Nuevo Proyecto"><i class="fas fa-file fa-2x"></i></asp:LinkButton>
                       <%--<i class="fas fa-file"></i>--%>
                        </span>
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos" DataKeyNames="nombre,usuario,sector,detalle,inicio,fin,responsables,costo,tiempo,estado,id" OnRowCommand="gwGrilla_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Descripción" />
                        <asp:BoundField DataField="usuario" HeaderText="Solicitante" />
                        <asp:BoundField DataField="Sector"  HeaderText="Detalle" />
                        <asp:BoundField DataField="Inicio" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Inicio" />
                        <asp:BoundField DataField="Fin" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Fin" />
                        <asp:BoundField DataField="Responsables" HeaderText="Responsables" />
                        <asp:BoundField DataField="Costo" DataFormatString="{0:0.00}" HeaderText="Costo" />
                        <asp:BoundField DataField="Tiempo"  HeaderText="Tiempo" />
                        <asp:BoundField DataField="EstadoT" HeaderText="Estado." />
                        <asp:BoundField DataField="ID" Visible="false" HeaderText="ID" />
                        <asp:BoundField DataField="Estado" HeaderText="Estado0" Visible="False" />


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
                    <RowStyle Font-Size="Small" />
                </asp:GridView>
            </div>
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel1" runat="server" Visible="False">
            <div class="panel panel-primary">

            <div class="panel-heading"><h4><asp:Label ID="Label1" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Font-Bold="True" Font-Size="Large"></asp:Label>
</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
            <br />   
            <br /> 
            <asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Descripción:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtDescripcion" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>           
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Descripción No puede Estar Vacio" ControlToValidate="txtDescripcion" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label5" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Solicitante" Width="150px"></asp:Label>
            <asp:TextBox ID="txtSolicitante" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="El Campo Solicitante No Puede Estar Vacío" ControlToValidate="txtSolicitante" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label3" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Sector" Width="150px"></asp:Label>
            <asp:TextBox ID="txtSector" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El Campo Sector No Puede Estar Vacío" ControlToValidate="txtSector" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Responsables:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtResponsables" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <br />   
            <br /> 
            <asp:Label ID="Label9" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Inicio:" Width="150px"></asp:Label>
            <asp:TextBox ID="TextBoxIni" runat="server" TabIndex="10" Width="300px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxIni" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="CalendarExtender1" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
            <br />   
            <br /> 
              <asp:Label ID="Label11" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Fin:" Width="150px"></asp:Label>
            <asp:TextBox ID="TextBoxFin" runat="server" TabIndex="10" Width="300px" CssClass="form-control"></asp:TextBox>
                <asp:MaskedEditExtender ID="MaskedEditExtender2" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                </asp:MaskedEditExtender>
                 <asp:CalendarExtender ID="CalendarExtender2" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
            <br />   
            <br /> 
            <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Costo Estimado:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCosto" cssclass="form-control" runat="server" Width="300px" TextMode="Number"></asp:TextBox>   
            <br />   
            <br /> 
           
            <asp:Label ID="Label8" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Tiempo:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtTiempo" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <br />   
            <br /> 
                        <asp:Label ID="Label7" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Estado:" Width="150px"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control" Width="300px">
                <asp:ListItem Value="0">En Proceso</asp:ListItem>
                <asp:ListItem Value="1">Pendiente</asp:ListItem>
                <asp:ListItem Value="2">Finalizado</asp:ListItem>
                        <asp:ListItem Value="3">Descartado</asp:ListItem>
                <asp:ListItem Value="4">Realizado</asp:ListItem>
                        </asp:DropDownList>
            <br />   
            <br /> 
          
            <asp:Label ID="Label10" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Detalle:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtDetalle" cssclass="form-control" runat="server" Width="300px" TextMode="MultiLine" Height="100px"></asp:TextBox>   
            
            
            <br />  
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

