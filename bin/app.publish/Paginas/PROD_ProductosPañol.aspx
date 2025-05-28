<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="PROD_ProductosPañol.aspx.cs" Inherits="SintecromNet.Paginas.PROD_ProductosPañol" %>
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
    <style type="text/css">
        .FixedHeader {
            /*position:static;*/
            position: absolute;
            
            /*top:initial;*/
            /*font-weight: bold;*/
            width:100%;
            
            
            
        }     
    </style>  
   <%--  <style type="text/css">
        
        .DataGridFixedHeader {background-color: white; position:absolute; top:expression(this.offsetParent.scrollTop);}
        
    </style>--%>
    

    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
   
     <form id="form1" runat="server">
        <!-- Main component for a primary marketing message or call to action -->
    <div class="jumbotron">
    <h2 style="background-color:honeydew">Productos Pañol Con Filtros 
            <asp:Label ID="lblMensaje" runat="server"  Text="Todos los Insumos Pañol" BackColor="LightBlue"></asp:Label>

    </h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        

            <div class="input-group">
            
                    
                  <span style ="float:right;">
                      <asp:LinkButton ID="LinkButton1" runat="server" CssClass="btn btn-info" Text="" OnClick="LinkButton1_Click" Visible="True" ToolTip="Todos"><i class="fas fa-filter fa-2x"></i></asp:LinkButton>
                      <asp:LinkButton ID="LinkButton7" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton7_Click" Visible="True" ToolTip="Conforme"><i class="fas fa-filter fa-2x"></i></asp:LinkButton>
                      <asp:LinkButton ID="LinkButton5" runat="server" CssClass="btn btn-primary" Text="" OnClick="LinkButton5_Click" Visible="True" ToolTip="Consumo"><i class="fas fa-filter fa-2x"></i></asp:LinkButton>
                      <asp:LinkButton ID="LinkButton3" runat="server" CssClass="btn btn-warning" Text="" OnClick="LinkButton3_Click" Visible="True" ToolTip="Warning"><i class="fas fa-filter fa-2x"></i></asp:LinkButton>
                      <asp:LinkButton ID="LinkButton4" runat="server" CssClass="btn btn-primary" BackColor="Black" Text="" OnClick="LinkButton4_Click" Visible="True" ToolTip="Vencidas"><i class="fas fa-filter fa-2x"></i></asp:LinkButton>
                      
                      <asp:LinkButton ID="LinkButton6" runat="server" CssClass="btn btn-danger" Text="" OnClick="LinkButton6_Click" Visible="True" ToolTip="Reposición"><i class="fas fa-filter fa-2x"></i></asp:LinkButton>
                      <asp:LinkButton ID="LinkButton2" runat="server" CssClass="btn btn-success" Text="" OnClick="LinkButton2_Click" Visible="True" ToolTip="Exportar a Excel"><i class="fa fa-file-excel-o fa-2x"></i></asp:LinkButton>
                 </span>
                <br />
                <br />
                <br />
            <%--<div style="OVERFLOW: auto; HEIGHT:450px">--%>
            <div style="OVERFLOW: auto; HEIGHT: 450px">

               <%-- <asp:GridView ID="gwHeader" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-bordered table-hover"                  
                   >
                    <Columns>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción" />
                        <asp:BoundField DataField="Rubro" HeaderText="Rubro" />
                        <asp:BoundField DataField="Ubicacion" HeaderText="Ubicación" />
                        <asp:BoundField DataField="Consumo" DataFormatString="{0:0.00}" HeaderText="Consumo" />
                        <asp:BoundField DataField="TiempoCompra" DataFormatString="{0:0.00}" HeaderText="L.Time" />
                        <asp:BoundField DataField="Reposicion" DataFormatString="{0:0.00}" HeaderText="Reposición" />
                        <asp:BoundField DataField="Stock" DataFormatString="{0:0.00}" HeaderText="Stock" />
                        <asp:BoundField DataField="Moneda" HeaderText="Moneda" />
                        <asp:BoundField DataField="Valor" DataFormatString="{0:0.00}" HeaderText="Valor" />
                        <asp:BoundField DataField="Cotizacion" DataFormatString="{0:0.00}" HeaderText="Cotizacion" />
                        <asp:BoundField DataField="Requerimiento" HeaderText="Req." />
                        <asp:BoundField DataField="UnidadMedida" HeaderText="U.M" />
                        <asp:BoundField DataField="Observaciones" HeaderText="Obs." />

                        <asp:BoundField HeaderText="ID" Visible="False" />
                    </Columns>
                    <HeaderStyle  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                    <RowStyle Font-Size="Small" />
                    
                </asp:GridView>--%>
               
              
                 <%--<span style ="float:left;">
                      
                       <i class="fas fa-file"></i>
                        </span>
        <br />--%>

                <%--CssClass="table table-striped table-bordered table-hover"--%>
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover"                  
                    EmptyDataText="No se Encontraron Datos" GridLines="None" OnRowDataBound="gwGrilla_RowDataBound1">
                    
                    <Columns>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" >
                        <HeaderStyle Width="6%"  />
                        <ItemStyle  Font-Size="X-Small" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Descripcion" HeaderText="Descripción">
                          <HeaderStyle Width="20%" />
                        <ItemStyle   Font-Size="X-Small" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Rubro" HeaderText="Rubro" >
                        <HeaderStyle Width="7%"  />
                        <ItemStyle  Font-Size="X-Small"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Ubicacion" HeaderText="Ubic." >
                        <HeaderStyle Width="5%" />
                        <ItemStyle  Font-Size="X-Small"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Consumo" DataFormatString="{0:0.00}" HeaderText="Cons." >
                         <HeaderStyle Width="6%" />
                        <ItemStyle  Font-Size="X-Small"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="TiempoCompra" DataFormatString="{0:0.00}" HeaderText="L.Time" >
                        <HeaderStyle Width="5%" />
                        <ItemStyle  Font-Size="X-Small"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Reposicion" DataFormatString="{0:0.00}" HeaderText="Reposicion" >
                        <HeaderStyle Width="5%" />
                        <ItemStyle  Font-Size="X-Small" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Stock" DataFormatString="{0:0.00}" HeaderText="Stock" >
                        <HeaderStyle Width="6%" />
                        <ItemStyle  Font-Size="X-Small" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fech_ulti_ingr" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Ult.Ing." >
                        <HeaderStyle Width="5%" />
                        <ItemStyle  Font-Size="X-Small"/>
                        </asp:BoundField>

                        <asp:BoundField DataField="fech_venc" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fech.Venc" >
                        <HeaderStyle Width="5%" />
                        <ItemStyle  Font-Size="X-Small"/>
                        </asp:BoundField>

                        <asp:BoundField DataField="Requerimiento" HeaderText="Req.">
                        <HeaderStyle Width="2%" />
                        <ItemStyle  Font-Size="X-Small"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="UnidadMedida" HeaderText="U.M">
                        <HeaderStyle Width="5%" />
                        <ItemStyle  Font-Size="X-Small" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Observaciones" HeaderText="Obs." >
                        <HeaderStyle Width="14%" />
                        <ItemStyle  Font-Size="X-Small" />
                        </asp:BoundField>

                        <asp:BoundField HeaderText="ID" Visible="False" />
                    </Columns>
                    <HeaderStyle CssClass="FixedHeader" BackColor="#337ab7" Font-Bold="False"  Font-Size="X-Small" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                    <RowStyle Font-Size="X-Small"  />
                    
                </asp:GridView>
                </div>
            </div>
       
        <br />
        
        
        
     
        </div>
        </form>
        </asp:Content>

