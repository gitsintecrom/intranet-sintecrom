<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CAL_InformeMuestras.aspx.cs" Inherits="SintecromNet.Paginas.CAL_InformeMuestras" %>
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
    <h2><asp:Label ID="lblTitulo" Text="Informe Muestras" runat="server"></asp:Label></h2>
    
    <form id="form1" runat="server">
       <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
        <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="labelRes0" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Cliente:" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                <asp:TextBox ID="txtCliente" runat="server" Width="230px" CssClass="form-control"></asp:TextBox>
                
                 &nbsp;<%--<br /><br />--%><asp:Label ID="lblPedido1" runat="server" style="text-align: left; top: 0px; left: 0px;" Text="Estado" Width="130px" BackColor="#337AB7" CssClass="form-control" ForeColor="White"></asp:Label>
                    <asp:DropDownList ID="ddEstado" CssClass="form-control" runat="server" Width="200px">
                        <asp:ListItem Value="0">Todos</asp:ListItem>
                        <asp:ListItem Value="1">Pendiente</asp:ListItem>
                        <asp:ListItem Value="2">Cumplido</asp:ListItem>
                    </asp:DropDownList>
                
              
                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      
                <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" />--%>
                <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="" OnClick="LinkButton1_Click" ToolTip="Buscar"><i class="fa fa-search fa-2x"></i></asp:LinkButton>
                
                        </div>
                    </div>
            </div>

        <asp:Panel  ID="Panel2" runat="server">
         <div style="overflow:auto; width:1020px; ">
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="Cliente,IDM,Email,Telefono,RequiereCertificado,EmailCertificado,Embalaje,Plegado,Profundidad,Pintado,Anodizado,Perforado,Conformado,ObservacionesC,ObservacionesP,ObservacionesV,Comentarios,Domicilio,Transporte,usofinal,origen,Vendedor,Estado,Fecha,FechaSolicitada,Material,Serie,Espesor,Ancho,UnidadMedida,Cantidad,largo,FechaDespacho,Aleacion,Temple">
        <Columns>
            <%--<asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" />--%>
            <asp:BoundField DataField="IDM" HeaderText="Nro." />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" >
            </asp:BoundField>
            <asp:BoundField DataField="Vendedor" HeaderText="Vendedor" />
           
            <asp:BoundField DataField="Estado" HeaderText="Estado" />
           
            <asp:BoundField DataField="Material" HeaderText="Material" />
            <asp:BoundField DataField="Espesor" HeaderText="Espesor" />
            <asp:BoundField DataField="Aleacion" HeaderText="Aleación" />
            <asp:BoundField DataField="Temple" HeaderText="Temple" />
            <asp:BoundField DataField="Ancho" HeaderText="Ancho" />
            <asp:BoundField DataField="Largo" HeaderText="Largo" />
            <asp:BoundField DataField="Serie" HeaderText="Serie" />
            <asp:BoundField DataField="UnidadMedida" HeaderText="UM" />
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" DataFormatString="{0:n0}" />
            <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha" />
            <asp:BoundField DataField="FechaSolicitada" HeaderText="Solicitada" DataFormatString="{0:dd/MM/yyyy}" />
            <asp:BoundField DataField="FechaDespacho" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Despacho" />
            <asp:BoundField DataField="IDM" HeaderText="ID" Visible="False" />
            <asp:BoundField DataField="Email" HeaderText="Email" Visible="False" />
            <asp:BoundField DataField="Telefono" HeaderText="Telefono" Visible="False" />
            <asp:BoundField DataField="RequiereCertificado" HeaderText="RequiereCertificado" Visible="False" />
            <asp:BoundField DataField="EmailCertificado" HeaderText="EmailCertificado" Visible="False" />
            <asp:BoundField DataField="Embalaje" HeaderText="Embalaje" Visible="False" />
            <asp:BoundField DataField="Plegado" HeaderText="Plegado" Visible="False" />
            <asp:BoundField DataField="Profundidad" HeaderText="Profundidad" Visible="False" />
            <asp:BoundField DataField="Pintado" HeaderText="Pintado" Visible="False" />
            <asp:BoundField DataField="Anodizado" HeaderText="Anodizado" Visible="False" />
            <asp:BoundField DataField="Perforado" HeaderText="Perforado" Visible="False" />
            <asp:BoundField DataField="Conformado" HeaderText="Conformado" Visible="False" />
            <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" Visible="False" />
            <asp:BoundField DataField="Domicilio" HeaderText="Domicilio" Visible="False" />
            <asp:BoundField DataField="Transporte" HeaderText="Transporte" Visible="False" />

            <asp:BoundField DataField="usofinal" HeaderText="Uso Final" Visible="False" />
            <asp:BoundField DataField="Origen" HeaderText="Origen" />

            <asp:ButtonField CommandName="Detalle"  
                ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="Detalle" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
        </Columns>			
                     <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="10px"/>
                            <RowStyle Font-Names="Arial" HorizontalAlign="Center" VerticalAlign="Middle" Font-Size="10px" />
                    
                    
        </asp:GridView>
        </div>
        </asp:Panel> 
   <asp:Panel ID="Panel1" runat="server"  BorderStyle="Outset" BorderWidth="3px" Width="100%" BackColor="#336699" Visible="False">
       <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" style='font-size:36px; color:azure' OnClick="LinkButton2_Click" ToolTip="Salir"></asp:LinkButton>
       <div class="input-group">

      <div class="well" widht="100%">
            <h4><b><u>Información Cliente</u></b></h4> 
                <h5>    Numero:<asp:Label ID="lblNumero" runat="server" Font-Bold="True" ></asp:Label>
                        Nombre: <asp:Label ID="lblCliente" runat="server" Font-Bold="True" ></asp:Label>
                        Email: <asp:Label ID="lblEmail" runat="server" Font-Bold="True" ></asp:Label>
                        Telefono: <asp:Label ID="lblTelefono" runat="server" Font-Bold="True" ></asp:Label>
                        Domicilio: <asp:Label ID="lblDomicilio" runat="server" Font-Bold="True" ></asp:Label>
                <br />
                        Vendedor: <asp:Label ID="lblVendedor" runat="server" Font-Bold="True" ></asp:Label>
                        Requiere Certificado: <asp:Label ID="lblRequiereCertificado" runat="server" Font-Bold="True" ></asp:Label>
                        Email Certificado: <asp:Label ID="lblEmailCertificado" runat="server" Font-Bold="True" ></asp:Label>
                        Transporte: <asp:Label ID="lblTransporte" runat="server" Font-Bold="True" ></asp:Label>
                <br />
                        Estado: <asp:Label ID="lblEstado" runat="server" Font-Bold="True" ></asp:Label>
                        Fecha Solicitada: <asp:Label ID="lblFechaSolicitada" runat="server" Font-Bold="True" ></asp:Label>                        
                        Fecha Despacho: <asp:Label ID="lblFechaDespacho" runat="server" Font-Bold="True" ></asp:Label>
                        
                </h5>          
           
        </div>
        <div class="well" widht="100%">
            <h4><b><u>Información Técnica</u></b></h4> 
                <h5>    
                        
                        Material: <asp:Label ID="lblMaterial" runat="server" Font-Bold="True" ></asp:Label>
                        Embalaje: <asp:Label ID="lblEmbalaje" runat="server" Font-Bold="True" ></asp:Label>
                        Serie: <asp:Label ID="lblSerie" runat="server" Font-Bold="True" ></asp:Label>
                        <br />
                        Espesor: <asp:Label ID="lblEspesor" runat="server" Font-Bold="True" ></asp:Label>
                        Ancho: <asp:Label ID="lblAncho" runat="server" Font-Bold="True" ></asp:Label>
                        Largo: <asp:Label ID="lblLargo" runat="server" Font-Bold="True" ></asp:Label>

                        
                        <br />
                        Un.Medida: <asp:Label ID="lblUnidadMedida" runat="server" Font-Bold="True" ></asp:Label>
                        Espesor: <asp:Label ID="lblCantidad" runat="server" Font-Bold="True" ></asp:Label>
                        Uso Final: <asp:Label ID="lblUsoFinal" runat="server" Font-Bold="True" ></asp:Label>
                        <br />
                        Origen: <asp:Label ID="lblOrigen" runat="server" Font-Bold="True" ></asp:Label>
                        Aleación: <asp:Label ID="lblAleacion" runat="server" Font-Bold="True" ></asp:Label>
                        Temple: <asp:Label ID="lblTemple" runat="server" Font-Bold="True" ></asp:Label>                        
                        
                        <br />                        
                        Plegado: <asp:Label ID="lblPlegado" runat="server" Font-Bold="True" ></asp:Label>
                        Embutido: <asp:Label ID="lblProfundidad" runat="server" Font-Bold="True" ></asp:Label>                        
                        Pintado: <asp:Label ID="lblPintado" runat="server" Font-Bold="True" ></asp:Label>
                        <br /> 
                        Anodizado: <asp:Label ID="lblAnodizado" runat="server" Font-Bold="True" ></asp:Label>                        
                        Perforado: <asp:Label ID="lblPerforado" runat="server" Font-Bold="True" ></asp:Label>
                        Conformado: <asp:Label ID="lblConformado" runat="server" Font-Bold="True" ></asp:Label> 
                        <br />
                    </h5>          
           
        </div>  
         <div class="well" widht="100%">
            <h4><b><u>Observaciones</u></b></h4> 
                <h5>    
                        Notas: <asp:Label ID="lblComentarios" runat="server" Font-Bold="True" ></asp:Label>
                        <br />
                        
                        Calidad: <asp:Label ID="lblObservacionesC" runat="server" Font-Bold="True" ></asp:Label>
                        <br />
                        Comercial: <asp:Label ID="lblObservacionesV" runat="server" Font-Bold="True" ></asp:Label>
                        <br />
                        Programación: <asp:Label ID="lblObservacionesP" runat="server" Font-Bold="True" ></asp:Label>
                       
                    </h5>          
           
        </div>  
            <%--<asp:Label ID="Label3" runat="server" BackColor="#000066" CssClass="form-control" ForeColor="White" Text="Observaciones:" Width="140px"></asp:Label>--%>
          <%-- 
            <asp:TextBox ID="txtDetalle" runat="server" CssClass="form-control" Width="350px" TextMode="MultiLine" Height="60px" ReadOnly="True"></asp:TextBox>
        <br /> 
        <br /> --%>
        <br /> 
        <br /> 
        <br /> 
        
             </div>
            
         <%--<div class="well" width="100%">--%>
                    <%--</div>--%>
 </asp:Panel> 
  
</div>
</form>
        </asp:Content>

