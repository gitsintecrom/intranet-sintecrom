<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="INV_ReclasificacionScrap.aspx.cs" Inherits="SintecromNet.Paginas.INV_ReclasificacionScrap" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
        src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js";
        function ShowProgress() {
        setTimeout(function () {
            var modal = $('<div />');
            modal.addClass("modal");
            $('body').append(modal);
            var loading = $(".loading");
            loading.show();
            var top = Math.max($(window).height() / 2 - loading[0].offsetHeight / 2, 0);
            var left = Math.max($(window).width() / 2 - loading[0].offsetWidth / 2, 0);
            loading.css({ top: top, left: left });
        }, 200);
    }
    //$('panel1').live("submit", function () {
    //    ShowProgress();
    //});

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

    <style type="text/css">
    .modal
    {
        position: fixed;
        top: 0;
        left: 0;
        background-color: black;
        z-index: 99;
        opacity: 0.8;
        filter: alpha(opacity=80);
        -moz-opacity: 0.8;
        min-height: 100%;
        width: 100%;
    }
    .loading
    {
        font-family: Arial;
        font-size: 10pt;
        border: 5px solid #67CFF5;
        width: 200px;
        height: 120px;
        display: none;
        position: fixed;
        background-color: White;
        z-index: 999;
    }
</style>
    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <h2>Reclasificación a Scrap</h2>

    <form id="form1" runat="server">
           <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div class="jumbotron">
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
        
            
                <asp:Label ID="lblPedido2"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" runat="server" style="text-align: left" Text="Depósito:" Width="140px"></asp:Label>
                <asp:DropDownList ID="DropDownList2" runat="server" CssClass="form-control"  Width="140px">
                </asp:DropDownList>
                &nbsp;&nbsp;
                <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Serie/Lote:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtBSerie" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
                <br />  <br />
                <asp:Label ID="lblPedido6" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Cod.Producto:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtProducto" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
                 &nbsp;&nbsp;<asp:Label ID="lblPedido7" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Des.Producto:" Width="140px"></asp:Label>
                <asp:TextBox ID="txtDesProducto" runat="server" CssClass="form-control"  Width="140px"></asp:TextBox>
               
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
               
            <asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" onclick="ButtonVer_Click" TabIndex="50" Text="Buscar" Width="140px" />

            
          
                        </div>
                    </div>
             </div>

        <asp:Panel ID="Panel2" runat="server" Visible="False">
      
        <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" OnRowCommand="gwGrilla_RowCommand" DataKeyNames="SL,Kilos,DEPOSITO_ID,PRODUCTO_ID,SERIE_ID,LOTE_ID,CODPRODUCTO" OnRowDataBound="gwGrilla_RowDataBound1">
        <Columns>
            <asp:BoundField DataField="SL" HeaderText="Serie Lote" />
            <asp:BoundField DataField="CODPRODUCTO" HeaderText="Cod.Producto" >
            </asp:BoundField>
            <asp:BoundField DataField="DESPRODUCTO" HeaderText="Des.Producto" />
            <asp:BoundField DataField="Cliente" HeaderText="Cliente" Visible="False" />
            <asp:BoundField DataField="Deposito" HeaderText="Deposito" >
           </asp:BoundField>
            <asp:BoundField DataField="FechaUltima" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ultimo Movimiento" Visible="False" />
            <asp:BoundField DataField="Kilos" HeaderText="Stock" DataFormatString="{0:0.00}" />
            <asp:ButtonField CommandName="Detalle"  
                ButtonType="Button" ControlStyle-CssClass="btn btn-success" ControlStyle-BorderStyle="None" Text="Reclasificar" >            
            <ControlStyle BorderStyle="None" CssClass="btn btn-success"></ControlStyle>
            </asp:ButtonField>
             <%--<asp:TemplateField ShowHeader="False">
                 <ItemTemplate>
                     <asp:Button ID="Button1" runat="server" CausesValidation="false" CommandName="Detalle" Text="Reclasificar" />
                 </ItemTemplate>
                 <ControlStyle BorderStyle="None" CssClass="btn btn-success" />
            </asp:TemplateField>--%>
             </Columns>
                     <HeaderStyle Font-Size="8pt" HorizontalAlign="Center" VerticalAlign="Middle"/>
                            <RowStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" VerticalAlign="Middle" />
                    
                    <FooterStyle BackColor="Black" ForeColor="White" Font-Size="8pt" />
        </asp:GridView>
            </asp:Panel>

        <asp:Panel ID="Panel1" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Center" Width="1000px" BackColor="#CCCCCC" style="text-align: center" Visible="False">
    
                    <h3> Serie Lote: <asp:Label ID="lblDetalle1" runat="server" Font-Bold="True" ForeColor="#990000" Font-Size="Medium" ></asp:Label>&nbsp;&nbsp;
                        Producto a Reclasificar: <asp:Label ID="lblDetalle2" runat="server" Font-Bold="True" ForeColor="#990000" Font-Size="Medium" ></asp:Label>&nbsp;&nbsp;
                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-sign-out-alt" OnClick="LinkButton2_Click" ToolTip="Salir"></asp:LinkButton>
                       
                    </h3>
               
                    <%--<asp:UpdateProgress ID="UpdateProgress1"  DynamicLayout="true" runat="server" AssociatedUpdatePanelID="up">
                        <ProgressTemplate>
                       <%-- <div class="loading">
                    Cargando. Por Favor Espere.<br />
                <br />
                   
                <img src="~/Images/loader.gif" alt="" />
                </div>--%>
                          <%--  <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/loader.gif" />&nbsp;please wait...
                            </ProgressTemplate>
                    </asp:UpdateProgress>--%>

       
        <br />
            <div class="input-group">
                 

                <asp:Label ID="Label1" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" style="text-align: left" Text="Producto:" Width="140px"></asp:Label>
                <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">  
                    <ContentTemplate> 
                 <asp:DropDownList ID="ddProducto" runat="server" CssClass="form-control" Width="300px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddProducto" ErrorMessage="*" Font-Bold="True" ForeColor="Red" ValidationGroup="Aceptar"></asp:RequiredFieldValidator>
                     </ContentTemplate>
                    <Triggers>     
                       <asp:AsyncPostBackTrigger  ControlID="gwGrilla" /> 
                    </Triggers>
                        </asp:UpdatePanel>--%>
                <asp:DropDownList ID="ddProducto" runat="server" CssClass="form-control" Width="300px">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddProducto" ErrorMessage="*" Font-Bold="True" ForeColor="Red" ValidationGroup="Aceptar"></asp:RequiredFieldValidator>
                     
                <br />
                <br />
                <asp:Label ID="Label2" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align: left" Text="Motivo:" Width="140px"></asp:Label>

                


            

                    <asp:DropDownList ID="ddMotivo" runat="server" CssClass="form-control" Width="300px">
                        <asp:ListItem>Desarrollo productos</asp:ListItem>
                        <asp:ListItem>Merma comercial</asp:ListItem>
                        <asp:ListItem>Problemas en Producción</asp:ListItem>
                        <asp:ListItem>Problemas en Almacenamiento</asp:ListItem>
                        <asp:ListItem>Problemas en Movimentación</asp:ListItem>
                        <asp:ListItem>Defecto de origen</asp:ListItem>
                        <asp:ListItem>Sobrante chico</asp:ListItem>
                    </asp:DropDownList>

                


            

            </div>
            <br />

                   <asp:Button ID="btnCerrar0" CssClass="btn btn-success btn-circle" ForeColor="White" runat="server" OnClick="btnCerrar0_Click" Text="Aceptar" BorderStyle="None" ValidationGroup="Aceptar" />
      
    
                  
                        
 </asp:Panel>
  
</div>
</form>
        </asp:Content>

