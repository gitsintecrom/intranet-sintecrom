<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_Contactos.aspx.cs" Inherits="SintecromNet.Paginas.ADM_Contactos" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
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
        <div class="jumbotron">
    <h2>Consulta Contactos&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
            </h2>
            
        
            <div class="panel-heading" style="background-color: #337AB7">
                <div class="input-group">
                <asp:Label ID="Label1" runat="server" CssClass="form-control" BackColor="#006666" ForeColor="White" Text="Empresa y/o Contacto" Width="200px" Height="50px"></asp:Label>
                <asp:TextBox ID="txtEmpresa" runat="server" CssClass="form-control" Width="300px" Height="50px"></asp:TextBox>
                &nbsp;&nbsp;<asp:ImageButton ID="ImageButton2" runat="server" Height="50px" ImageUrl="~/Images/buscar.png" OnClick="ImageButton2_Click" />  
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                <asp:ImageButton ID="ImageButton1" runat="server" Height="50px" ImageUrl="~/Images/new.jpg" OnClick="ImageButton1_Click" />  
                
                    <%--<Br /> <Br />--%>
               
                
                <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" />--%>
                </div>      
            
            </div>
  <asp:ImageButton ID="btnExcel" runat="server" Height="51px" cssclass ="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px; top: 0px; left: 0px;" 
    ToolTip="Exportar a Excel" Width="53px" ImageAlign="Middle" Visible="False" />
            <br />
              <asp:Panel ID="Panel1" runat="server" Visible="False">

           
                    <div class="input-group">
             <asp:Label ID="Label13" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Empresa:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCliente" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>           
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="El Campo Empresa No puede Estar Vacio" ControlToValidate="txtCliente" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
             <asp:Label ID="Label4" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Contacto:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtContacto0" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="El Campo Contacto No Puede Estar Vacio" ControlToValidate="txtContacto0" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br />
           
            <asp:Label ID="Label5" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Email:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtEmail" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>   
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="El Campo Email No Puede Estar Vacío" ControlToValidate="txtEmail" ValidationGroup="Aceptar" CssClass="alert-danger">*</asp:RequiredFieldValidator>
            <br />   
            <br /> 
            <asp:Label ID="Label6" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Teléfono:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtTelefono" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>      
            <br />   
            <br /> 
            <asp:Label ID="Label7" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Celular:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtCelular" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>     
            <br />   
            <br /> 
              
            <asp:Label ID="Label12" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Observaciones:" Width="150px"></asp:Label>
            <asp:TextBox ID="txtObservaciones" cssclass="form-control" runat="server" Width="300px" Height="70px" TextMode="MultiLine"></asp:TextBox>  
            <br /> 
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
          
        
                   
                        <br />
                        <br />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="Aceptar" CssClass="alert-danger" />
          
        
                   
                    </div>
            </asp:Panel>
                <asp:GridView ID="gwGrilla" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos" Visible="False" Width="600px" DataKeyNames="ID,Empresa,Contacto,Email,Telefono,Celular,Observaciones" OnRowCommand="gwGrilla_RowCommand">
        <Columns>
            <asp:BoundField DataField="Empresa" HeaderText="Empresa" />
            <asp:BoundField DataField="Contacto" HeaderText="Contacto" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Telefono" HeaderText="Telefono" />
            <asp:BoundField DataField="Celular" HeaderText="Celular" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
             <asp:ButtonField CommandName="Eliminar" HeaderText="Eliminar" ButtonType="Button" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-primary" Text="Eliminar" ControlStyle-BackColor="#993300">            
<ControlStyle BackColor="#993300" BorderStyle="None" CssClass="btn btn-primary"></ControlStyle>
            </asp:ButtonField>
            <asp:ButtonField CommandName="Modificar" HeaderText="Modificar" ButtonType="Button" ControlStyle-BorderStyle="None" ControlStyle-CssClass="btn btn-success" Text="Modificar" >            
<ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
        </Columns>
        <HeaderStyle Font-Size="8pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
        <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
   
              
                <br />
   
        </div>
         </form>
        </asp:Content>

