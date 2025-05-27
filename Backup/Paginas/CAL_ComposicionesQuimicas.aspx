<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CAL_ComposicionesQuimicas.aspx.cs" Inherits="SintecromNet.Paginas.CAL_ComposicionesQuimicas" %>
<%@ Register assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" namespace="System.Web.UI.DataVisualization.Charting" tagprefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
 
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
 
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <script language="javascript" type="text/javascript">
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Composiciones Quimicas<asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </h2>
<table style="width:100%;">
        <tr>
            <td align="center" valign="middle">
                &nbsp;</td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gwComposicionesQuimicas" runat="server" AutoGenerateColumns="False" 
        
                    
                    
                    EmptyDataText="No se Encontraron Datos" 
                    onrowdatabound="gwOCServicios_RowDataBound" 
                    AutoGenerateSelectButton="True" onrowcommand="gwOCServicios_RowCommand" 
                    onselectedindexchanged="gwOCServicios_SelectedIndexChanged" 
                    DataKeyNames="ID">
        <Columns>
            <asp:BoundField HeaderText="Familia" DataField="Familia" >
            <ItemStyle Font-Names="Arial" Font-Size="8pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="Aleacion" HeaderText="Aleación">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="8pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Carbono" HeaderText="Carbono" >
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Manganeso" HeaderText="Manganeso" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Fosforo" HeaderText="Fosforo" >
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="10%" />
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Azufre" HeaderText="Azufre">
            <ItemStyle Font-Names="Arial" Font-Size="7pt" HorizontalAlign="Center" 
                VerticalAlign="Middle" Width="5%" />
            </asp:BoundField>
            <asp:BoundField DataField="Silicio" 
                HeaderText="Silicio">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Talio" 
                HeaderText="Talio">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Cobre" 
                HeaderText="Cobre">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Aluminio" 
                HeaderText="Aluminio">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Hierro" 
                HeaderText="Hierro">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Magnesio" 
                HeaderText="Magnesio">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Cromo" 
                HeaderText="Cromo">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Cinc" 
                HeaderText="Cinc">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Vanadio" 
                HeaderText="Vanadio">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="SIFE" 
                HeaderText="SI + FE">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Otros" 
                HeaderText="Otros">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="5%" />
            </asp:BoundField>
               <asp:BoundField DataField="Notas" 
                HeaderText="Notas">
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Names="Arial" 
                Font-Size="7pt" Width="10%" />
            </asp:BoundField>
            <asp:BoundField DataField="ID" HeaderText="ID" Visible="False" />
        </Columns>
        <HeaderStyle BackColor="Maroon" ForeColor="White" HorizontalAlign="Center" 
            VerticalAlign="Middle" />
</asp:GridView>
            </td>
        </tr>
    </table>
    &nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
   
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;<asp:HiddenField ID="HiddenFieldError" runat="server" />


        <asp:Panel ID="Panel1" runat="server" Height="650px" Width="400px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center" 
    ForeColor="#999999" HorizontalAlign="Justify">
            <h2>
                <asp:Label ID="Label2" runat="server" Text="Familia:"></asp:Label>
                <asp:TextBox ID="TxtFamilia" runat="server" Width="150px" ReadOnly="True"></asp:TextBox>
                <asp:Label ID="Label3" runat="server" Text="Aleación"></asp:Label>
                <asp:TextBox ID="txtAleacion" runat="server" ReadOnly="True" Width="66px"></asp:TextBox>
            </h2> 
            <p>
                <asp:Label ID="Label4" runat="server" Text="Carbono" Width="70px"></asp:Label>
                <asp:TextBox ID="txtCarbono" runat="server" Width="66px"></asp:TextBox>
                &nbsp;<asp:Label ID="Label1" runat="server" Text="Manganeso" Width="70px"></asp:Label>
                <asp:TextBox ID="txtManganeso" runat="server" TabIndex="10" Width="66px"></asp:TextBox>
            </p>
            <p>
                &nbsp;</p>
            <p>
               <asp:Label ID="Label5" runat="server" Text="Fosforo" Width="70px"></asp:Label>
                <asp:TextBox ID="txtFosforo" runat="server" Width="66px" TabIndex="20"></asp:TextBox>
                <asp:Label ID="Label6" runat="server" Text="Azufre" Width="70px"></asp:Label>
                <asp:TextBox ID="txtAzufre" runat="server" TabIndex="30" Width="66px"></asp:TextBox>
            </p>
            <p>
                &nbsp;</p>
            <p>
                <asp:Label ID="Label7" runat="server" Text="Silicio" Width="70px"></asp:Label>
                <asp:TextBox ID="txtSilicio" runat="server" Width="66px" TabIndex="40"></asp:TextBox>
                <asp:Label ID="Label8" runat="server" Text="Talio" Width="70px"></asp:Label>
                <asp:TextBox ID="txtTalio" runat="server" TabIndex="50" Width="66px"></asp:TextBox>
            </p>
             <p>
                 &nbsp;</p>
             <p>
                <asp:Label ID="Label9" runat="server" Text="Cobre" Width="70px"></asp:Label>
                <asp:TextBox ID="txtCobre" runat="server" Width="66px" TabIndex="60"></asp:TextBox>
                 <asp:Label ID="Label10" runat="server" Text="Aluminio" Width="70px"></asp:Label>
                 <asp:TextBox ID="txtAluminio" runat="server" TabIndex="70" Width="66px"></asp:TextBox>
            </p>
            <p>
                &nbsp;</p>
             <p>
            <asp:Label ID="Label11" runat="server" Text="Hierro" Width="70px"></asp:Label>
            <asp:TextBox ID="txtHierro" runat="server" Width="66px" TabIndex="80"></asp:TextBox>
                 <asp:Label ID="Label12" runat="server" Text="Magnesio" Width="70px"></asp:Label>
                 <asp:TextBox ID="txtMagnesio" runat="server" TabIndex="90" Width="66px"></asp:TextBox>
            </p>
             <p>
                 &nbsp;</p>
               
               <p>
                <asp:Label ID="Label13" runat="server" Text="Cromo" Width="70px"></asp:Label>
                <asp:TextBox ID="txtCromo" runat="server" Width="66px" TabIndex="100"></asp:TextBox>

                   <asp:Label ID="Label14" runat="server" Text="Cinc" Width="70px"></asp:Label>
                   <asp:TextBox ID="txtCinc" runat="server" TabIndex="110" Width="66px"></asp:TextBox>
            </p>
                <p>
                    &nbsp;</p>
                <p>
                <asp:Label ID="Label15" runat="server" Text="Vanadio" Width="70px"></asp:Label>
                <asp:TextBox ID="txtVanadio" runat="server" Width="66px" TabIndex="120"></asp:TextBox>

                    <asp:Label ID="Label16" runat="server" Text="SI + FE" Width="70px"></asp:Label>
                    <asp:TextBox ID="txtSiFe" runat="server" TabIndex="130" Width="66px"></asp:TextBox>
            </p>
                 <p>
                     &nbsp;</p>
                 <p>
                <asp:Label ID="Label17" runat="server" Text="Otros" Width="70px"></asp:Label>
                <asp:TextBox ID="txtOtros" runat="server" Width="66px" 
                ontextchanged="txtOtros_TextChanged" TabIndex="140"></asp:TextBox>

                     <asp:Label ID="Label18" runat="server" Text="Notas" Width="70px"></asp:Label>
                     <asp:TextBox ID="txtNotas" runat="server" TabIndex="150" Width="66px"></asp:TextBox>
                     &nbsp;</p>
            <br />
            <br />
            <br />
            <asp:Button ID="btnModificar" runat="server" Enabled="False" 
                onclick="btnModificar_Click" Text="Modificar" ValidationGroup="Validar" 
                TabIndex="160" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
                Text="Cerrar" TabIndex="170" />
            <br />
            <br />
        </asp:Panel>

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        </asp:Content>

