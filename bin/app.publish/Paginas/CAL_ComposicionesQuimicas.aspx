<%@ Page Title="" Language="C#" MasterPageFile="~/main.Master" AutoEventWireup="true" CodeBehind="CAL_ComposicionesQuimicas.aspx.cs" Inherits="SintecromNet.Paginas.CAL_ComposicionesQuimicas" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }

    function estaseguro() {

        if (!confirm('Esta Seguro de Guardar la Modificación?')) return false;
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
    <h2>Composiciones Quimicas
    </h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

       <div class="panel panel-primary">
            <div class="panel-heading"><h4>Detalle:</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <div style="overflow:auto; width:900px;">
                <asp:GridView ID="gwComposicionesQuimicas" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-striped table-bordered table-hover"                   
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwOCServicios_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwOCServicios_RowCommand" 
                    onselectedindexchanged="gwOCServicios_SelectedIndexChanged" 
                    DataKeyNames="ID">
        <Columns>
            <asp:BoundField HeaderText="Familia" DataField="Familia" />           
            <asp:BoundField DataField="Aleacion" HeaderText="Aleación" />           
            <asp:BoundField DataField="Carbono" HeaderText="C" />
            <asp:BoundField DataField="Manganeso" HeaderText="Mn" />            
            <asp:BoundField DataField="Fosforo" HeaderText="P" />           
            <asp:BoundField DataField="Azufre" HeaderText="S" />           
            <asp:BoundField DataField="Silicio" HeaderText="Si" />           
            <asp:BoundField DataField="Talio" HeaderText="Ti" />
            <asp:BoundField DataField="Cobre" HeaderText="Cu" />           
            <asp:BoundField DataField="Aluminio" HeaderText="Al" />            
            <asp:BoundField DataField="Hierro" HeaderText="Fe" />            
            <asp:BoundField DataField="Magnesio" HeaderText="Mg" />           
            <asp:BoundField DataField="Cromo" HeaderText="Cr" />
            <asp:BoundField DataField="Cinc" HeaderText="Zn" />           
            <asp:BoundField DataField="Vanadio" HeaderText="V" />           
            <asp:BoundField DataField="SIFE" HeaderText="SI + FE" />            
            <asp:BoundField DataField="Otros" HeaderText="Otros" />           
            <asp:BoundField DataField="Notas" HeaderText="Notas" />            
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
        </Columns>        
</asp:GridView>
                        </div> 
                        </div>
                     </div>
            </div>
         </div>
         
 
        <asp:Panel ID="Panel2" runat="server" CssClass="form-control"   BackColor="#337AB7" BorderStyle="Solid" BorderWidth="1" style="text-align: left" Visible="False" Width="600px" Height="600px" >

                    <h3 style="color: #FFFFFF;">Detalles</h3>
                    <br />
                     <div class="input-group">
                         <asp:Label ID="Label19" runat="server" CssClass="form-control" Text="Familia:" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtFamilia" runat="server" CssClass="form-control" ReadOnly="True" Width="130px"></asp:TextBox>
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Label ID="Label20" runat="server" CssClass="form-control" Text="Aleación:" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtAleacion" runat="server" CssClass="form-control" ReadOnly="True" Width="130px"></asp:TextBox>
                        <br />
                        <br />
                         <asp:Label ID="Label4" runat="server" CssClass="form-control" Text="Carbono" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtCarbono" runat="server" CssClass="form-control" Width="80px"></asp:TextBox>
                           &nbsp;<asp:Label ID="Label1" runat="server" CssClass="form-control" Text="Manganeso" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtManganeso" runat="server" CssClass="form-control" TabIndex="10" Width="80px"></asp:TextBox>
                         <br />
                        <br />
                         <asp:Label ID="Label5" runat="server" CssClass="form-control" Text="Fosforo" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtFosforo" runat="server" CssClass="form-control" Width="80px" TabIndex="20"></asp:TextBox>
                        <asp:Label ID="Label6" runat="server" CssClass="form-control" Text="Azufre" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtAzufre" runat="server" CssClass="form-control" TabIndex="30" Width="80px"></asp:TextBox>
                         <br />
                        <br />
                         <asp:Label ID="Label7" runat="server" CssClass="form-control" Text="Silicio" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtSilicio" runat="server" CssClass="form-control" Width="80px" TabIndex="40"></asp:TextBox>
                        <asp:Label ID="Label8" runat="server" CssClass="form-control" Text="Talio" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtTalio" runat="server" CssClass="form-control" TabIndex="50" Width="80px"></asp:TextBox>
                         <br />
                        <br />
                         <asp:Label ID="Label9" runat="server" CssClass="form-control" Text="Cobre" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtCobre" runat="server" CssClass="form-control" Width="80px" TabIndex="60"></asp:TextBox>
                        <asp:Label ID="Label10" runat="server" CssClass="form-control" Text="Aluminio" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtAluminio" runat="server" CssClass="form-control" TabIndex="70" Width="80px"></asp:TextBox>
                         <br />
                        <br />
                         <asp:Label ID="Label11" runat="server" CssClass="form-control" Text="Hierro" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtHierro" runat="server" CssClass="form-control" Width="80px" TabIndex="80"></asp:TextBox>
                        <asp:Label ID="Label12" runat="server" CssClass="form-control" Text="Magnesio" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtMagnesio" runat="server" CssClass="form-control" TabIndex="90" Width="80px"></asp:TextBox>
                         <br />
                        <br />
                         <asp:Label ID="Label13" runat="server" CssClass="form-control" Text="Cromo" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtCromo" runat="server" CssClass="form-control" Width="80px" TabIndex="100"></asp:TextBox>
                        <asp:Label ID="Label14" runat="server" CssClass="form-control" Text="Cinc" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtCinc" runat="server" CssClass="form-control" TabIndex="110" Width="80px"></asp:TextBox>
                         <br />
                        <br />
                         <asp:Label ID="Label15" runat="server" CssClass="form-control" Text="Vanadio" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtVanadio" runat="server" CssClass="form-control" Width="80px" TabIndex="120"></asp:TextBox>
                        <asp:Label ID="Label16" runat="server" CssClass="form-control" Text="SI + FE" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtSiFe" runat="server" CssClass="form-control" TabIndex="130" Width="80px"></asp:TextBox>
                         <br />
                        <br />
                         <asp:Label ID="Label17" runat="server" CssClass="form-control" Text="Otros" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtOtros" runat="server" CssClass="form-control" Width="80px" TabIndex="140"></asp:TextBox>
                         <br />
                        <br />
                        <asp:Label ID="Label18" runat="server" CssClass="form-control" Text="Notas" Width="100px"></asp:Label>
                        <asp:TextBox ID="txtNotas" runat="server" CssClass="form-control" TabIndex="150" Width="300px" Height="70px" TextMode="MultiLine"></asp:TextBox>
                     <br />
                    <br />
                    <br />
                    <br />
                         <asp:Button ID="btnModificar" runat="server" CssClass="form-control" Width="90px" Enabled="False" 
                        onclick="btnModificar_Click" Text="Modificar" ValidationGroup="Validar" 
                        TabIndex="160" />            
                        <asp:Button ID="Button6" runat="server" CssClass="form-control" Width="70px" onclick="Button2_Click1" 
                        Text="Cerrar" TabIndex="170" />                                       
                     </div>
                </asp:Panel>

        
        
       


        </div>
    </form>
        </asp:Content>

