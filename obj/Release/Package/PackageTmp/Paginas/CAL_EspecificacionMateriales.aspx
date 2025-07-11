<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="CAL_EspecificacionMateriales.aspx.cs" Inherits="SintecromNet.Paginas.CAL_EspecificacionMateriales" %>
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
    <h2>Especificación Técnica de Materiales</h2>
    
    <form id="form1" runat="server">
       
    <div class="jumbotron">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    

                <asp:ImageButton ID="imgAlta" runat="server" ImageUrl="~/Images/add.gif" 
                    onclick="imgAlta_Click" style="width: 16px" />
                <asp:Label ID="Label1" runat="server"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" style="text-align:center" Text="Ingresar Una Nueva Definición" Width="280px"></asp:Label>

                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False" 
                CssClass="table table-striped table-bordered table-hover"  
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwGrilla_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwGrilla_RowCommand" 
                    onselectedindexchanged="gwGrilla_SelectedIndexChanged" 
                    DataKeyNames="ID" >
        <Columns>
            <asp:BoundField HeaderText="Familia" DataField="Familia" >
           
            </asp:BoundField>
            <asp:BoundField DataField="Codigo" HeaderText="Código" >
            
            </asp:BoundField>
            <asp:BoundField DataField="Descripcion" HeaderText="Descripción">
           
            </asp:BoundField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
        </Columns>
       
</asp:GridView>
           <asp:HiddenField ID="HiddenFieldError" runat="server" />


        <asp:Panel ID="Panel1" runat="server" Height="300px" Width="600px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
             <div class="input-group">
                <br />
                <br />
                <asp:Label ID="Label4" runat="server" Text="Familia"  CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="130px"></asp:Label>
                <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="300px">
                </asp:DropDownList>
                <br />
                <br />            
                <asp:Label ID="Label5" runat="server" Text="Cod.Defecto:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="130px"></asp:Label>
                <asp:TextBox ID="txtDefecto" runat="server" CssClass="form-control" Width="300px" TabIndex="20" 
                    MaxLength="3"></asp:TextBox>           
                <asp:RequiredFieldValidator ID="rqDefecto" runat="server" 
                    ControlToValidate="txtDefecto" ErrorMessage="El campo no puede estar Vacío" 
                    ValidationGroup="Validar"></asp:RequiredFieldValidator>
                <br />
                <%--<br />--%>
                <asp:Label ID="Label7" runat="server" Text="Defecto:" CssClass="form-control" BackColor="#337AB7" ForeColor="White" Width="130px"></asp:Label>
                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" Width="300px" TabIndex="40" 
                    MaxLength="100"></asp:TextBox>           
                 <asp:RequiredFieldValidator ID="rqDesc" runat="server" 
                     ControlToValidate="txtDescripcion" ErrorMessage="El Campo no puede Estar Vacío" 
                     ValidationGroup="Validar"></asp:RequiredFieldValidator>
                    <br />
                    <br />
                    <br />
                    <br />
            <asp:Button ID="btnModificar" runat="server" 
                onclick="btnModificar_Click" Text="Aceptar" ValidationGroup="Validar" cssclass="btn btn-success btn-circle"
                TabIndex="160"  Width="130px" />
            &nbsp;
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" cssclass="btn btn-success btn-circle" BackColor="Red"
                Text="Cerrar" TabIndex="170" BorderStyle="None" Width="130px" />
                 </div>
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>
        </div>
        </form>

        </asp:Content>

