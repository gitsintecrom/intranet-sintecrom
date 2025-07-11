<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CAL_SIDPantallaInicial.aspx.cs" Inherits="SintecromNet.Paginas.CAL_SIDPantallaInicial" %>
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

    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
     <form id="form1" runat="server">
    <div class="jumbotron">
   <h2>SID</h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        

            <div class="input-group">
                <asp:Panel ID="Panel1" runat="server">                    
                        
                <asp:LinkButton ID="LinkButton2" runat="server" Text="" OnClick="LinkButton2_Click" Visible="True" ToolTip=" Gestión Ambiental"><i class="fa fa-recycle" aria-hidden="true"></i>Gestión Ambiental</asp:LinkButton>
            
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No se Encontraron Datos" DataKeyNames="Ruta" OnRowCommand="gwGrilla_RowCommand" OnRowDataBound="gwGrilla_RowDataBound">
                    <Columns>

                        <asp:ButtonField CommandName="Ver"  
                        HeaderText="Abrir" ButtonType="Button" ControlStyle-CssClass="btn btn-info" ControlStyle-BorderStyle="None" Text="Abrir" >            
<ControlStyle BorderStyle="None" CssClass="btn btn-info"></ControlStyle>
            </asp:ButtonField>
                        <asp:BoundField DataField="Codigo" HeaderText="Codigo" />
                        <asp:BoundField DataField="Descripcion" HeaderText="Procedimientos Documentados" />
                        <asp:BoundField DataField="Revision" HeaderText="Revisión" />
                        <asp:BoundField DataField="Fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha / Estado" />
                        <asp:BoundField HeaderText="ID" Visible="False" />
                     <%--   <asp:TemplateField HeaderText="Ruta" Visible="False">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Ruta") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Button1" runat="server" Text='<%# Bind("Ruta") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        
                        <asp:BoundField DataField="Ruta" HeaderText="Ruta" Visible="False" />
                        
                    </Columns>
                    <HeaderStyle BackColor="#337ab7" Font-Bold="True" ForeColor="White"  HorizontalAlign="Center" VerticalAlign="Middle"/>  
                    <RowStyle Font-Size="Small" />
                </asp:GridView>
                    </asp:Panel> 
                <asp:Panel ID="Panel2" runat="server" BorderStyle="Outset" BorderWidth="3px" HorizontalAlign="Left" Width="700px" BackColor="#CCCCCC" style="text-align: Left" >
                     <span style ="float:right;">
                        <asp:LinkButton ID="LinkButton1" runat="server" CssClass="fa fa-sign-out fa-2x" OnClick="LinkButton1_Click" ToolTip="Salir"></asp:LinkButton>
                    </span>
                    <h3>Gestión Ambiental</h3>
                   
                    <br />
                   
                    <asp:LinkButton ID="LinkButton3" runat="server" Text="" OnClick="LinkButton3_Click" Visible="True" ToolTip="Registro de Inspecciones"><i class="fa fa-recycle" aria-hidden="true"></i> Registro de Inspecciones y Visitas Ambientales</asp:LinkButton>
                    
                     <br />
                        <asp:LinkButton ID="LinkButton4" runat="server" Text="" OnClick="LinkButton4_Click" Visible="True" ToolTip="Orden Y Limpieza"><i class="fa fa-recycle" aria-hidden="true"></i> Orden y Limpieza</asp:LinkButton>
                     <br />
                   
                    <asp:LinkButton ID="LinkButton5" runat="server" Text="" OnClick="LinkButton5_Click" Visible="True" ToolTip="Ciclo de Vida"><i class="fa fa-recycle" aria-hidden="true"></i> Ciclo de Vida</asp:LinkButton>
                     <br />
                    
                    <asp:LinkButton ID="LinkButton6" runat="server" Text="" OnClick="LinkButton6_Click" Visible="True" ToolTip="Obligaciones Legales"><i class="fa fa-recycle" aria-hidden="true"></i> Obligaciones Legales</asp:LinkButton>
                     <br />  
                    <asp:LinkButton ID="LinkButton7" runat="server" Text="" OnClick="LinkButton7_Click" Visible="True" ToolTip="Evaluación de Aspectos Ambientales"><i class="fa fa-recycle" aria-hidden="true"></i> Evaluación de Aspectos Ambientales</asp:LinkButton>
                    <br />
                    
                    <asp:LinkButton ID="LinkButton8" runat="server" Text="" OnClick="LinkButton8_Click" Visible="True" ToolTip="Registro de Residuos"><i class="fa fa-recycle" aria-hidden="true"></i> Registro de Residuos</asp:LinkButton>
                  

                </asp:Panel>
            </div>
      
     
        </div>
        </form>
        </asp:Content>

