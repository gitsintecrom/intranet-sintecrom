<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="RRHH_NovedadesLiquidacion.aspx.cs" Inherits="SintecromNet.Paginas.RRHH_NovedadesLiquidacion" %>
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
    <h2>Novedades Liquidación&nbsp;&nbsp;&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
            </h2><asp:Label ID="lblError" runat="server"></asp:Label>
            
        
            <div class="panel-heading" style="background-color: #337AB7">
                <div class="input-group">
        <asp:FileUpload ID="fuNovedades" runat="server" Width="368px" CssClass="form-control" />
         &nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnAgregar" runat="server" CssClass="btn btn-success" onclick="btnAgregar_Click2" TabIndex="160" Text="Convertir Archivo" />

                    <br />
                    <br />
                  <asp:ImageButton ID="btnExcel" runat="server" Height="51px" cssclass ="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px; top: 0px; left: 0px;" 
    ToolTip="Exportar a Excel" Width="53px" ImageAlign="Middle" Visible="False" />
               
                
                <%--<asp:Button ID="btnVer0" runat="server" cssclass="btn btn-success btn-circle" width="150px" OnClick ="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" />--%>
                </div>      
            
            </div>
            <br />
   
              
                <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped table-bordered table-hover">
                     <HeaderStyle Font-Size="9pt"  BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>
            </asp:GridView>
   
              
                <br />
   
        </div>
         </form>
        </asp:Content>

