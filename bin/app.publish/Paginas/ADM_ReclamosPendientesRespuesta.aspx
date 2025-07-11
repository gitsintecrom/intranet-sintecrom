<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ADM_ReclamosPendientesRespuesta.aspx.cs" Inherits="SintecromNet.Paginas.ADM_ReclamosPendientesRespuesta" %>
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
    <h2>Reclamos Pendientes de Respuesta</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
        
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
            
            <asp:ButtonField ButtonType="Button" CommandName="Informe" HeaderText="Ver Informe"  ControlStyle-CssClass="btn btn-warning" Text="Ver Informe" >
            <ControlStyle CssClass="btn btn-warning"></ControlStyle>
            </asp:ButtonField>
            <asp:ButtonField CommandName="Enviar"  
                HeaderText="Enviar" ButtonType="Button" ControlStyle-CssClass="btn btn-danger" ControlStyle-BorderStyle="None" Text="Enviar" >            
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
        
     <asp:Panel ID="Panel5" runat="server" BackColor="#CCCCFF" BorderStyle="Outset" BorderWidth="3px" Height="65px" Visible="False" Width="660px">
           &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:ImageButton ID="ImageButton2" runat="server" OnClick="ImageButton2_Click" Height="60px" style="text-align:left" ImageUrl="~/Images/icono-pdf.jpg" Visible="True" Width="70px" />
           
           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
           <asp:ImageButton ID="ImageButton3" runat="server" Height="60px" ImageUrl="~/Images/salir.png" OnClick="ImageButton3_Click" style="text-align:right" Visible="True" Width="70px" />
           
    </asp:Panel>
                  
    <asp:Panel ID="Panel4" runat="server" BackColor="#CCCCCC" BorderStyle="Outset" BorderWidth="3px" Height="550px" Visible="False" Width="660px">
                                      
                <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
        <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <div style="float:left;">
               <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/Logo1.jpg" Height="70px" Width="90px" /></div>
                    <b><asp:Label ID="Label26" runat="server" Font-Size="15pt"  Font-Bold="True" ForeColor="White" style="text-align:center" Width="540px" BorderStyle="None"></asp:Label></b>
            </td>
        </tr>
        <tr>
            <td><b>Material:
                <asp:Label ID="lblMaterial" runat="server" Font-Size="11pt"></asp:Label>&nbsp;Caracteristicas:
                <asp:Label ID="lblCaracteristicas" runat="server" Font-Size="11pt"></asp:Label>
                </b></td>                     
        </tr> 
        <tr>
            <td>
            <b>Remito:
                <asp:Label ID="lblRemito" runat="server" Font-Size="11pt"></asp:Label>&nbsp;Serie/Lote:
                <asp:Label ID="lblSL" runat="server" Font-Size="11pt"></asp:Label>
                &nbsp;Reclamo Cliente:
                <asp:Label ID="lblReclamoExterno" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
                     <tr>
            <td>
                
                    <b>Contacto Cliente:
                <asp:Label ID="lblContacto" runat="server" Font-Size="11pt"></asp:Label>&nbsp;Email:
                <asp:Label ID="lblEmail" runat="server" Font-Size="11pt"></asp:Label> &nbsp;Cantidad:
                <asp:Label ID="lblCantidad" runat="server" Font-Size="11pt"></asp:Label>
               </b>
            </td>
        </tr>
                         
    </table>                       
           
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <asp:Label ID="Label3" runat="server" Font-Size="12pt" Text="Motivo" ForeColor="White"></asp:Label>
                    </td>
        </tr>
                 <tr>
            <td>
            <b>
                <asp:Label ID="lblMotivo" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                
                    <b>Emite:
                <asp:Label ID="lblEmite" runat="server" Font-Size="11pt" ForeColor="White"></asp:Label>&nbsp;Aprueba:
                <asp:Label ID="Label8" runat="server" Font-Size="11pt" Text="Gastón Broide" ForeColor="White"></asp:Label>
               </b>
            </td>
        </tr>
                 <tr>
            <td>
            <b>Observaciones:
                <asp:Label ID="lblObservaciones" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
                
    </table>
           
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <asp:Label ID="Label6" runat="server" Font-Size="12pt" Text="Analisis de la Causa" ForeColor="White"></asp:Label>
                    </td>
        </tr>
                 <tr>
            <td>
            <b>
                <asp:Label ID="lblCausa" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>
             
            <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <asp:Label ID="Label9" runat="server" Font-Size="12pt" Text="Acción Inmediata" ForeColor="White"></asp:Label>
                    </td>
        </tr>
                 <tr>
            <td>
            <b>
                <asp:Label ID="lblCorreccion" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>
            
                    <table border="1" style="font-family: Arial; font-size: 10pt; width: 640px">
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
                <b>Aprueba:<asp:Label ID="Label10" runat="server" Font-Size="11pt" Text=" Gastón Broide" ForeColor="White"></asp:Label>
                    
                &nbsp;Kilos Aceptados:<asp:Label ID="lblKilosAceptados" runat="server" Font-Size="11pt"  ForeColor="White"></asp:Label>
            </b></td>
        </tr>
                 <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
            <b>
                 SAC:&nbsp;<asp:Label ID="lblSAC" runat="server" Font-Size="11pt"></asp:Label>
                 Estado:&nbsp;<asp:Label ID="lblEstado" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
                         <tr>
            <td colspan="1" style="background-color: #337AB7; height: 18px; color: White; text-align:center; border: 1px solid white">
            <b>
                 Fecha Respuesta:&nbsp;<asp:Label ID="lblFechaRespuesta" runat="server" Font-Size="11pt"></asp:Label>
                 Informe Impreso el:&nbsp;<asp:Label ID="lblFechaHoy" runat="server" Font-Size="11pt"></asp:Label>
               
            </b>
            </td>   
            </tr> 
    </table>

            
    </asp:Panel>

    
     

        
    
        
       
          <br />
             <br />
             <br />
        </div>
    </form>
        </asp:Content>

