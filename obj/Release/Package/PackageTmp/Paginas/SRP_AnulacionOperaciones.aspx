<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SRP_AnulacionOperaciones.aspx.cs" Inherits="SintecromNet.Paginas.SRP_AnulacionOperaciones" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
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
   

     <form id="form1" runat="server">
          

         <div class="jumbotron">
              <h2>Anuación Operaciones Pendientes</h2>
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
             <div class="panel panel-primary">
       <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
             
                <asp:Label ID="lblPedido3" runat="server" style="text-align: left" Text="Batch:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBBatch" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:Label ID="lblPedido5" runat="server" style="text-align: left" Text="Serie/Lote:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBSerie" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
                <br /> <br />
                <asp:Label ID="lblPedido7" runat="server" style="text-align: left" Text="Operacion:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtBMatching" runat="server" Width="130px" CssClass="form-control"></asp:TextBox>
                 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                <asp:Label ID="lblPedido2" runat="server" style="text-align: left" Text="Maquina:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" Width="130px" CssClass="form-control">
                    <asp:ListItem Value="Todos">--Seleccione</asp:ListItem>
                    <asp:ListItem Value="SL1">Slitter 1</asp:ListItem>
                    <asp:ListItem Value="SL2">Slitter 2</asp:ListItem>
                    <asp:ListItem Value="SL3">Slitter 3</asp:ListItem>
                    <asp:ListItem Value="PL1">Plancha 1</asp:ListItem>
                    <asp:ListItem Value="PL2">Plancha 2</asp:ListItem>
                    <asp:ListItem Value="PL3">Plancha 3</asp:ListItem>
                    <asp:ListItem>Pintado</asp:ListItem>
                    <asp:ListItem>Embalaje</asp:ListItem>
                    <asp:ListItem Value="HOR">Horno</asp:ListItem>
                    <asp:ListItem Value="Todos">Todos</asp:ListItem>
                </asp:DropDownList>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="130px" />
           
           
                       
                    </div>
                     </div>
                 </div>
             
             
            <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
        
                    
                    CssClass="table table-striped table-bordered table-hover" 
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" DataKeyNames="Operacion_ID,NumeroDocumento,Tarea,NroBatch,Origen_Lote">
        <Columns>
            <asp:BoundField DataField="NumeroDocumento" HeaderText="Operacion" />
            <asp:BoundField DataField="Tarea" HeaderText="Tarea" />
            <asp:BoundField DataField="Operacion_Nombre" HeaderText="Nombre" >
            </asp:BoundField>
            <asp:BoundField DataField="NroBatch" HeaderText="Nro.Batch" />
            <asp:BoundField HeaderText="Operacion_ID" DataField="Operacion_ID" Visible="False" >
            </asp:BoundField>
            <asp:BoundField DataField="Clientes" HeaderText="Clientes" Visible="False" >
            </asp:BoundField>
            <asp:BoundField DataField="Origen_Lote" HeaderText="S/L " />
            <asp:BoundField DataField="KilosProgramadosEntrantes" HeaderText="Kgs.Programados ">
            </asp:BoundField>
        </Columns>
       
</asp:GridView>
              <asp:HiddenField ID="HiddenFieldError" runat="server" />
                <asp:Panel ID="Panel2" runat="server" Height="300px" Width="600px" 
                            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
                            BackColor ="WhiteSmoke" style="text-align: center" 
                            ForeColor="#999999" HorizontalAlign="Justify">
             <div class="input-group">
                         <h3>Detalle</h3>                         
                        <br />
                      
                    <asp:Label ID="Label12" runat="server" Text="Operación" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="txtOperacion" runat="server" ReadOnly="True" Width="200px" CssClass="form-control"></asp:TextBox>
                    <br />
                    <br />
                    <asp:Label ID="Label10" runat="server" Text="Motivo:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                    <asp:TextBox ID="txtMotivo" runat="server" Width="310px" Height="61px" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                    <br />
                    <br />
                 <br />
                    <br />
                   
                        <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" cssclass="btn btn-success btn-circle" onclientclick="return estaseguro()" Width="130px" Text="Aceptar" />
                         &nbsp; &nbsp; &nbsp;<asp:Button ID="Button1" runat="server" onclick="Button2_Click1" cssclass="btn btn-success btn-circle"  Text="Cancelar" Width="130px" backcolor="Red" BorderStyle="None" />
                    
                    
                  </div>
                    <br />
                </asp:Panel>
             
    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel2" CancelControlID="Button1" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
  
</div>
         </form>

        </asp:Content>

