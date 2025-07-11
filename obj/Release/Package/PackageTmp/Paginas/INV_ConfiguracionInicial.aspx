<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_ConfiguracionInicial.aspx.cs" Inherits="SintecromNet.Paginas.INV_ConfiguracionInicial" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Anular la Operación?')) return false;
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
    <h2>Procesos Inventario Anual</h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Procesos Inventario Anual&nbsp;&nbsp;&nbsp; </h4></div>
                <div class="panel-body">                
                    <div class="input-group">      
            
                
                
                
                    <asp:Label ID="labelRes1" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Fecha Inventario" Width="150px"></asp:Label>
                    <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="150px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="MaskedEditExtender1" runat="server" AutoComplete="False" CultureName="es-AR" Mask="99/99/9999" MaskType="Date" TargetControlID="TextBoxFin" UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
                    </asp:CalendarExtender>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBoxFin" CssClass="alert-danger" ErrorMessage="Debe Ingresar La Fecha del Inventario" ValidationGroup="Aceptar">*</asp:RequiredFieldValidator>

                        
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Generar" Width="140px" ValidationGroup="Aceptar" />
            <br />  <br />                
            <asp:Label ID="label1" runat="server" BackColor="Maroon" CssClass="form-control" ForeColor="White" style="text-align: left; top: 0px; left: -1px; width: 700px;" 
                Text="1 - Elimina las Etiquetas Ingresadas en el Inventario Anterior EJECUTAR UNA SOLA VEZ !!!!!" Font-Bold="True"></asp:Label>
               <br />  <br />     <br />  <br />  
                <asp:Label ID="label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Generar Ajustes y Bajas del Inventario" Width="300px"></asp:Label>
            
               
            <asp:Button ID="btnEjecutar" runat="server" cssclass="btn btn-success btn-circle" onclick="btnEjecutar_Click" TabIndex="50" Text="Ejecutar" Width="140px" />
            
                        <br />  <br />                
            <asp:Label ID="label3" runat="server" BackColor="Maroon" CssClass="form-control" ForeColor="White" style="text-align: left; top: 0px; left: 0px; width: 700px;" 
                Text="2 - Genera las Bajas y Ajustes resultantes de la toma del Inventario para ser procesadas Por Calipso" Font-Bold="True"></asp:Label>
               
          
                        

            
          
                        </div>
                    </div>
             </div>
       

</div>
</form>
        </asp:Content>

