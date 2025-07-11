<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="SIS_Trafico_Intranet.aspx.cs" Inherits="SintecromNet.Paginas.SIS_Trafico_Intranet" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
    <script>
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
    <h2>Trafico Intranet</h2><asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
         <div class="panel panel-primary">
            <div class="panel-heading"><h4>Filtros</h4></div>
                <div class="panel-body">                
                    <div class="input-group">
    
            <asp:Label ID="lblDesde" runat="server" CssClass="form-control" BackColor="#336699" ForeColor="White" Width="120px">Fecha Desde:</asp:Label>
            <asp:TextBox ID="TextBoxIni" runat="server" CssClass="form-control" Width="100px" TabIndex="10"></asp:TextBox>
            <asp:MaskedEditExtender ID="TextBoxIni_MaskedEditExtender" runat="server" AutoComplete="False" Mask="99/99/9999" MaskType="Date" PromptCharacter="_" TargetControlID="TextBoxIni">
            </asp:MaskedEditExtender>
            <asp:CalendarExtender ID="TextBoxIni_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxIni">
            </asp:CalendarExtender>
            
            <asp:Label ID="lblpanel" runat="server" CssClass="form-control" BackColor="#336699" ForeColor="White" Width="120px">Fecha Hasta:</asp:Label>
            <asp:TextBox ID="TextBoxFin" runat="server" CssClass="form-control" TabIndex="10" Width="100px"></asp:TextBox>
            <asp:MaskedEditExtender ID="TextBoxFin_MaskedEditExtender" runat="server" AutoComplete="False" Mask="99/99/9999" MaskType="Date" PromptCharacter="_" TargetControlID="TextBoxFin">
            </asp:MaskedEditExtender>
            <asp:CalendarExtender ID="TextBoxFin_CalendarExtender" runat="server" Format="dd/MM/yyyy" TargetControlID="TextBoxFin">
            </asp:CalendarExtender>
            
            <asp:Label ID="Label2" runat="server" CssClass="form-control" Text="Usuario:" Width="120px" BackColor="#336699" ForeColor="White"></asp:Label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Width="100px"></asp:TextBox>
           &nbsp;&nbsp;
            <asp:Button ID="btnVer0" runat="server" cssclass ="btn btn-success btn-circle" onclick="ButtonVer_Click" style="text-align: center" TabIndex="50" Text="Buscar" Width="100px" />
            </div>
            </div>
              </div>
           


  
<asp:ImageButton ID="btnExcel" cssclass="form-control" runat="server" Height="51px" 
    ImageUrl="~/Images/exc.jpg" onclick="btnExcel_Click" style="margin-top: 0px" 
    ToolTip="Exportar a Excel" Width="53px" Visible="False" />
    <br />
                <asp:GridView ID="gwGrilla" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-striped table-bordered table-hover"
                    OnRowCommand="gwGrilla_RowCommand" OnRowDataBound="gwGrilla_RowDataBound" Width="400px">
        
                    <Columns>
                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />                        
                        <asp:BoundField DataField="Hora" HeaderText="Hora" />
                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" />
                        <asp:BoundField DataField="Pagina" HeaderText="Pagina" />
		                
                    </Columns>
  
</asp:GridView>
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
