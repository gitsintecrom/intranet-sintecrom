<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SIS_TableroSRP.aspx.cs" Inherits="SintecromNet.Paginas.SIS_TableroSRP" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <style type="text/css">
        .auto-style1 {
            padding: 15px;
            text-align: center;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <h2>Tablero de Control&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:Label ID="lblMensajeDuplicada" runat="server" Font-Size="XX-Large" Visible="False"></asp:Label>             
            <asp:Label ID="lblMensajeDuplicadaP" runat="server" Font-Size="Medium" ForeColor="Red"></asp:Label>             
            <br />
            <asp:Label ID="lblMensajeBatch" runat="server" Font-Size="XX-Large" Visible="False" ForeColor="#CC3300"></asp:Label>

            <asp:Label ID="lblMensajeSobrante" runat="server" Font-Size="Medium" Visible="False" ForeColor="Red"></asp:Label>
            <asp:Label ID="lblMensajeErrorBatch" runat="server" Font-Size="Medium" Visible="False" ForeColor="Red"></asp:Label>

            <asp:Label ID="lblMensajeErrorInventario" runat="server" Font-Size="Medium" Visible="False" ForeColor="Red"></asp:Label>

            <asp:Label ID="lblMensajeErrorJob" runat="server" Font-Size="Medium" Visible="False" ForeColor="Red"></asp:Label>

            </h2>
        
        
        

        <asp:Panel ID="Panel1" runat="server">
        
        
        

        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Tareas Transactor</h4></div>
            <div class="panel-body">
                <asp:Label ID="Label1" runat="server" Text="Lotes:" Width="70px" align="Right"></asp:Label>
                <asp:Button ID="btnAltasLotesOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasLotesW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasLotesD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label2" runat="server" Text="BajasSL:" Width="70px" align="Right"></asp:Label>
                &nbsp;<asp:Button ID="btnBajasSLOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnBajasSLW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnBajasSLD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label3" runat="server" Text="AltasSL:"  Width="70px" align="Right"></asp:Label>
                &nbsp;<asp:Button ID="btnAltasSLOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasSLW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasSLD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label4" runat="server" Text="Sobr.SL:"  Width="70px" align="Right"></asp:Label>
                <asp:Button ID="btnSobranteSLOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnSobranteSLW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnSobranteSLD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label5" runat="server" Text="BajasUO:"  Width="70px" align="Right"></asp:Label>
                <asp:Button ID="btnBajasUOOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnBajasUOW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnBajasUOD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label6" runat="server" Text="AltasUO:"  Width="70px" align="Right"></asp:Label>
                            <asp:Button ID="btnAltasUOOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasUOW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasUOD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label7" runat="server" Text="Sobr.UO:"  Width="70px" align="Right"></asp:Label>
                            <asp:Button ID="btnSobranteUOOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnSobranteUOW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnSobranteUOD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label8" runat="server" Text="BajasCP:"  Width="70px" align="Right"></asp:Label>
                            <asp:Button ID="btnBajasCPOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnBajasCPW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnBajasCPD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label9" runat="server" Text="AltasCP:"  Width="70px" align="Right"></asp:Label>
                            <asp:Button ID="btnAltasCPOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasCPW" runat="server" class="btn btn-warning btn-circle" Visible="False"/>
                            <asp:Button ID="btnAltasCPD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
            </div>
        
          <div class="panel-heading"><h4>Otros Controles</h4></div>
            <div runat="server" id="theDiv" class="alert alert-danger fade in">
                <strong>Error Pedido!!!</strong>
                Pedido: <asp:Label ID="lblPedido" runat="server" Text=""></asp:Label>
                Cliente: <asp:Label ID="lblCliente" runat="server" Text=""></asp:Label>
                Error: <asp:Label ID="lblError" runat="server" Text=""></asp:Label>          

            </div>
            <div class="auto-style1">

                <asp:Label ID="Label11" runat="server" Text="Op.SL:"  Width="60px" align="Right" style="text-align: center"></asp:Label>
                <asp:Button ID="btnOPSLOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnOPSLD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label12" runat="server" Text="Op.UO:"  Width="60px" align="Right"></asp:Label>
                <asp:Button ID="btnOPUOOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnOPUOD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>

               <%-- <asp:Label ID="Label14" runat="server" Text="Inventario:"  Width="60px" align="Right"></asp:Label>
                <asp:Button ID="btnControlOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>            
                <asp:Button ID="btnControlD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>--%>

                 <asp:Label ID="Label19" runat="server" Text="Pedidos:"  Width="40px" align="Right"></asp:Label>
                <asp:Button ID="btnODOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnODD" runat="server" class="btn btn-danger btn-circle" Visible="False"/> 
             
                <asp:Label ID="Label17" runat="server" Text="Incidentes:"  Width="70px" align="Right"></asp:Label>
                <asp:Button ID="btnIncidentesOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnIncidentesD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label25" runat="server" Text="Matching:"  Width="70px" align="Right"></asp:Label>
                <asp:Button ID="btnMatchingOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnMatchingD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label18" runat="server" Text="Transactor:"  Width="72px" align="Right"></asp:Label>
                <asp:Button ID="btnTransactorOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnTransactorD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>                 
                <asp:Label ID="Label22" runat="server" Text="Job BK:"  Width="72px" align="Right"></asp:Label>
                <asp:Button ID="btnJBOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnJBD" runat="server" class="btn btn-danger btn-circle" Visible="False"/>
                <asp:Label ID="Label23" runat="server" Text="Job:"  Width="72px" align="Right"></asp:Label>
                <asp:Button ID="btnJOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnJD" runat="server" class="btn btn-danger btn-circle" Visible="False"/> 
            </div>
        
             <div class="panel-heading"><h4>Acciones</h4></div>
            <div class="auto-style1">
                <asp:Label ID="Label10" runat="server" Text="Batch's:"  Width="85px" align="Right"></asp:Label>
                <asp:Button ID="btnBatchOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnBatchD" runat="server" class="btn btn-danger btn-circle" Visible="False" OnClick="btnBatchD_Click"/>
                <asp:Label ID="Label16" runat="server" Text="Flag Batch's:"  Width="85px" align="Right"></asp:Label>
                <asp:Button ID="btnFlagBatchOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnFlagBatchD" runat="server" class="btn btn-danger btn-circle" Visible="False" OnClick="btnFlagBatchD_Click"/>
                 <asp:Label ID="Label24" runat="server" Text="Status SRP:"  Width="85px" align="Right"></asp:Label>
                <asp:Button ID="btnEstadoSRPOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnEstadoSRPD" runat="server" class="btn btn-danger btn-circle" Visible="False" OnClick="btnEstadoSRPD_Click"/>
                <asp:Label ID="Label13" runat="server" Text="Sobrante:"  Width="85px" align="Right"></asp:Label>
                <asp:Button ID="btnSobranteOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnSobranteD" runat="server" class="btn btn-danger btn-circle" Visible="False" OnClick="btnSobranteD_Click"/>
                
               <%-- <asp:Label ID="Label13" runat="server" Text="Notas:"  Width="85px" align="Right"></asp:Label>
                <asp:Button ID="btnBloqueoOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnBloqueoD" runat="server" class="btn btn-danger btn-circle" Visible="False" OnClick="btnBloqueoD_Click"/>
                <asp:Label ID="Label20" runat="server" Text="Ancho SL:"  Width="85px" align="Right"></asp:Label>
                <asp:Button ID="btnAnchoSLOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnAnchoSLD" runat="server" class="btn btn-danger btn-circle" Visible="False" OnClick="btnAnchoSLD_Click"/>
                <asp:Label ID="Label21" runat="server" Text="Ancho UO:"  Width="85px" align="Right"></asp:Label>
                <asp:Button ID="btnAnchoUOOK" runat="server" class="btn btn-success btn-circle" Visible="False"/>
                <asp:Button ID="btnAnchoUOD" runat="server" class="btn btn-danger btn-circle" Visible="False" OnClick="btnAnchoUOD_Click"/>--%>
            </div>
        
        </div>
        </asp:Panel>

        
        <asp:Button ID="btnRefrescar" runat="server" class="btn btn-success btn-circle" Visible="True" OnClick="btnRefrescar_Click" Text="Refrescar"/>
    <asp:Timer ID="Timer1" runat="server" Interval="100000" OnTick="Timer1_Tick">
        </asp:Timer>
         <%--   <div class="panel panel-primary">
          
        </div>--%>
       
         <%--   <div class="panel panel-primary">
           
        </div>--%>
                                        
    </div>
    </form>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptSection" runat="server">
</asp:Content>