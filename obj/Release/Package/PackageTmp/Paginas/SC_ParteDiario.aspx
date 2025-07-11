<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SC_ParteDiario.aspx.cs" Inherits="SintecromNet.Paginas.SC_ParteDiario" %>
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
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <h2>Parte Diario
    </h2>
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
                        <asp:Label ID="Label1" runat="server"  CssClass="form-control" Width="120px" Text="Fecha Inicial:" BackColor="#003366" ForeColor="White"></asp:Label>
                <asp:TextBox ID="TextBoxIni" runat="server" cssclass="form-control"  Width="100px"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" 
                        TargetControlID="TextBoxIni" Mask="99/99/9999" CultureName="es-AR" 
                        UserDateFormat="DayMonthYear" UserTimeFormat="TwentyFourHour">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxIni" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>&nbsp;&nbsp;
                        <asp:Label ID="Label2" runat="server" CssClass="form-control" Width="120px" Text="Fecha Final:" BackColor="#003366" ForeColor="White"></asp:Label>                         
                        <asp:TextBox ID="TextBoxFin" runat="server" cssclass="form-control" Width="100px" TabIndex="10"></asp:TextBox>
                    <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" 
                        AutoComplete="False" MaskType="Date" PromptCharacter="_" 
                        TargetControlID="TextBoxFin" 
                        Mask="99/99/9999">
                    </asp:MaskedEditExtender>
                    <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" 
                        TargetControlID="TextBoxFin" Format="dd/MM/yyyy">
                    </asp:CalendarExtender>
                        <asp:Label ID="lblPedido5" runat="server"  CssClass="form-control" BackColor="#003366" ForeColor="White" style="text-align: left; top: 0px; left: 0px;" Text="Familia:" Width="120px"></asp:Label>
                <asp:DropDownList ID="ddFamilia" runat="server" CssClass="form-control" Width="120px">
                </asp:DropDownList>
                         <asp:Button ID="btnVer" runat="server" cssclass ="btn btn-success btn-circle" OnClick="ButtonVer_Click" 
                        Text="Buscar" Width="135px"  />
                    </div>
           
                </div>
        </div>
    <asp:ImageButton ID="btnExcel" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
    
    <asp:GridView ID="gwParteDiario" runat="server" AutoGenerateColumns="False" 
         onrowdatabound="gwParteDiario_RowDataBound"  CssClass="table table-striped table-bordered table-hover"
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >            
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
            </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            </asp:BoundField>
        </Columns>        
</asp:GridView>
    <br />
<asp:ImageButton ID="btnExcel0" runat="server" CssClass="form-control" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel0_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
<asp:GridView ID="gwParteDiario0" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-striped table-bordered table-hover" onrowdatabound="gwParteDiario0_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >           
            </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
            </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            </asp:BoundField>
        </Columns>
        </asp:GridView>
    <br />
    <asp:ImageButton ID="btnExcel1" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel1_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
<asp:GridView ID="gwParteDiario1" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover" onrowdatabound="gwParteDiario1_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >            
           </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >            
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >            
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
            </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            </asp:BoundField>
        </Columns>
        </asp:GridView>
    <br />
        <asp:ImageButton ID="btnExcel2" runat="server" Height="51px" CssClass="form-control"
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel2_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
<asp:GridView ID="gwParteDiario2" runat="server" AutoGenerateColumns="False" 
         CssClass="table table-striped table-bordered table-hover" onrowdatabound="gwParteDiario2_RowDataBound" 
        ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="Numero" HeaderText="Número" >           
           </asp:BoundField>
            <asp:BoundField DataField="Familia" HeaderText="Familia" >            
            </asp:BoundField>
            <asp:BoundField DataField="ProveedorCliente" HeaderText="Cliente\Prov" >            
            </asp:BoundField>
            <asp:BoundField DataField="Producto" 
                HeaderText="Producto">
            </asp:BoundField>
            <asp:BoundField DataField="Condiciones" HeaderText="Condición">
           </asp:BoundField>
            <asp:BoundField DataField="Kgs" DataFormatString="{0:0.00}" 
                HeaderText="Kilos">
            </asp:BoundField>
        </Columns>
        </asp:GridView>
            <br />
           <asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="120px" Width="326px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center">
            <br />
            <asp:Label ID="LabelErr" runat="server" Text="Label" ForeColor="Black" 
                CssClass="align"></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
               Text="Aceptar" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
       
        </div>
</form>
</asp:Content>

