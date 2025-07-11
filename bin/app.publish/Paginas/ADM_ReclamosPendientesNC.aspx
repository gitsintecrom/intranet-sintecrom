<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_ReclamosPendientesNC.aspx.cs" Inherits="SintecromNet.Paginas.ADM_ReclamosPendientesNC" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%--<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>--%>
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro Actualizar el Reclamo?')) return false;
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
    <h2>Ingreso Nota de Crédito Reclamos</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
        
        <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="False" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br />
                <asp:GridView ID="gwGrilla" CssClass="table table-striped table-bordered table-hover" runat="server"  AutoGenerateColumns="False"      
                    EmptyDataText="No se Encontraron Datos" DataKeyNames="ID,Contacto,Caracteristicas,Motivo,Emite,Observaciones,ReclamoExterno,Cliente,Responsable,Grupo" 
                    OnRowCommand="gwGrilla_RowCommand" OnSelectedIndexChanged="gwGrilla_SelectedIndexChanged" OnRowDataBound="gwGrilla_RowDataBound1">
        <Columns>
           
            <asp:BoundField DataField="ID" HeaderText="Número" />
            <asp:BoundField DataField="Tipo" HeaderText="Tipo" />
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
            <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" />

            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="Contacto" HeaderText="Contacto" Visible="False" />
            <asp:BoundField DataField="Email" HeaderText="Email" Visible="False" />
            <asp:BoundField DataField="Caracteristicas" HeaderText="Caracteristicas" Visible="False" />
            <asp:BoundField DataField="Motivo" HeaderText="Motivo" Visible="False" />
            <asp:BoundField DataField="Emite" HeaderText="Emite" Visible="False" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" Visible="False" />
            <asp:BoundField DataField="ReclamoExterno" HeaderText="ReclamoExterno" Visible="False" />
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
            

            <asp:ButtonField CommandName="NC"  
                HeaderText="Nota de Crédito" ButtonType="Button" ControlStyle-CssClass="btn btn-danger" ControlStyle-BorderStyle="None" Text="Nota de Crédito" >            
                <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>


        </Columns>
        <%--<HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />--%>
                    <RowStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle" />
</asp:GridView>
               <%-- <br />
                <br />
                <br /> --%> 
        
               
    <asp:Panel ID="Panel1" runat="server" 
        Height="250px" Width="600px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke"  
    ForeColor="#999999" Visible="False" >
    
         <br />
        <asp:Label ID="Label1" runat="server" CssClass="form-control"  ForeColor="White" Width="600px" style="text-align:center"  BackColor="#003366" Font-Bold="True" Font-Size="Medium"></asp:Label>
        <div class="input-group">
                      
             <asp:Label ID="Label13" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Nota de Crédito:" Width="150px"></asp:Label>
             <asp:TextBox ID="txtReclamoExterno" runat="server" cssclass="form-control" Width="500px"></asp:TextBox>
         <br />

             <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El Campo Nota de Crédito no puede estar Vacío" ControlToValidate="txtReclamoExterno" ValidationGroup="Resumen"></asp:RequiredFieldValidator>
             
            <br />
           
                         
            &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
             <asp:Button ID="Button7" runat="server" class="btn btn-success btn-circle" width="130" onclick="Button7_Click" 
                Text="Aceptar" TabIndex="170" BackColor="#009933" BorderStyle="None" ValidationGroup="Resumen"  />
                 
             &nbsp;
             <asp:Button ID="Button6" runat="server" BackColor="#669999" BorderStyle="None" class="btn btn-success btn-circle" onclick="Button2_Click1" TabIndex="170" Text="Salir" width="130" />
                 
         </div>
     
          
        </asp:Panel>

    
     

        
    
        
       
          <br />
             <br />
             <br />
        </div>
    </form>
        </asp:Content>

