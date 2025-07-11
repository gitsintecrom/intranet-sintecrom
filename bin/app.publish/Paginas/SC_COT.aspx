<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SC_COT.aspx.cs" Inherits="SintecromNet.Paginas.SC_COT" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
 
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script  type="text/javascript">
    function btnGuardar_ClientCancel() {
        return false;
    }
   
    function procesar(xform) {
        document.open(xform, 'nventana', 'width=450,height=300,status=yes,resizable=yes,scrollbars=yes');

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
    <%--<form id="form1" method="post" enctype="multipart/form-data" runat="server" action= "https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do" target="ventanaForm" onsubmit="window.open('', 'ventanaForm', '')"  >--%>
    <form id="form1" method="post" enctype="multipart/form-data" runat="server" action= "https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do" target="nventana" onsubmit="procesar(this.action);"  >
    <%--<form id="form1" method="post" enctype="multipart/form-data" runat="server"   >--%>
        <div class="jumbotron">
    <h2>Generación COT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        
            
        
            </h2>
         
        
            <div class="panel-heading" style="background-color: #337AB7">
                <div class="input-group">
        <%--<asp:Label ID="Label2" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Empresa:" Width="150px"></asp:Label>
        <asp:TextBox ID="txtCliente" cssclass="form-control" runat="server" Width="300px"></asp:TextBox><asp:Label ID="Label1" runat="server" BackColor="#337AB7" CssClass="form-control" ForeColor="White" Text="Empresa:" Width="150px"></asp:Label>
        <asp:TextBox ID="TextBox1" cssclass="form-control" runat="server" Width="300px"></asp:TextBox>
        --%>
                     <input type='text' name="user">
                    <input type='password' name="password">
                    <%--<INPUT id="File1" type="file" runat="server" NAME="File">--%>
                    <input type='file' name="file"  > 
                    
                    <%--<asp:FileUpload ID="fuCOT" runat="server" Width="368px" CssClass="form-control" />--%>
                    <br />
                    <br />
        <asp:Button ID="btnAgregar" runat="server"  CssClass="btn btn-success"  TabIndex="160" Type="Submit" Text="Generar COT" OnClick="btnAgregar_Click3"  />
        <asp:Button ID="btnImportar" runat="server" CssClass="btn btn-success" formaction="/Paginas/SIS_AdmEquipos.aspx" onclick="btnImportar_Click1" TabIndex="170" Text="Importar COT" BackColor="#669999" />
      
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
                                
     
              
    </div>
                <%--<asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>--%>
        </div>
            </div>
         </form>
    
       
        </asp:Content>

