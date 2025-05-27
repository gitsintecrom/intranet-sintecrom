<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Incidentes.aspx.cs" Inherits="SintecromNet.Paginas.Incidentes" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">

        .style18
        {
            width: 136px;
        }
    




        .style19
        {
            width: 177px;
            text-align: left;
        }
        .style21
        {
            width: 154px;
        }
        .style22
        {
            text-align: center;
        }
        .style23
        {
            width: 267px;
            text-align: center;
        }
        </style>
    <script language="javascript" type="text/javascript">
// <![CDATA[

        function oFile_onclick() {

        }
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
  m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-67198984-1', 'auto');
        ga('send', 'pageview');

// ]]>
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>incidentes<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:SintecromNet %>" 
        SelectCommand="SELECT * FROM [Totales_Cobranzas]"></asp:SqlDataSource>
   
    </h2>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
<fieldset a="" style="width: auto; height: auto">
<fieldset a 
    style="width: 600px; height: 45px; ">
        <table style="margin-left: 0px" __designer:mapid="132" align="left">
            <tr __designer:mapid="133">
                <td align="left" class="style19" __designer:mapid="134" width="150">
                    Fecha:
                    <asp:Label ID="lblFecha" runat="server"></asp:Label>
                </td>
                <td align="left" class="style18" __designer:mapid="135" width="200">
                    &nbsp; Usuario:
                    <asp:Label ID="lblUsuario" runat="server"></asp:Label>
                </td>
                <td align="left" class="style18" __designer:mapid="135" width="450">
                    &nbsp;Sector: <asp:Label ID="lblSector" runat="server" style="text-align: left" 
                        Width="90px"></asp:Label>
                </td>
            </tr>
            </table>
                </fieldset a><fieldset a 
    style="width: 600px; height: auto; ">
    <table __designer:mapid="132" style="width: 545px;">
        <tr __designer:mapid="133">
            <td __designer:mapid="134" align="left" class="style23">
                Tipo Incidente:</td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                <asp:DropDownList ID="DropDownList1" runat="server" Width="244px">
                    <asp:ListItem Value="Hardware">Hardware</asp:ListItem>
                    <asp:ListItem Value="Software(No Calipso)">Software(No Calipso)</asp:ListItem>
                    <asp:ListItem Value="Calipso">Calipso</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr __designer:mapid="133">
            <td __designer:mapid="134" align="left" class="style23">
                Comentario:</td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                <asp:TextBox ID="txtComentario" runat="server" MaxLength="1000" 
                    Width="462px" Height="144px" TextMode="MultiLine"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtComentario" CssClass="failureNotification" 
                    ErrorMessage="El Campo No puede estar vacío" ValidationGroup="Validar"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr __designer:mapid="133">
            <td __designer:mapid="134" align="left" class="style23">
                Imagen:</td>
            <td __designer:mapid="135" align="left" class="style21" width="400">
                    <INPUT id="oFile" type="file" runat="server" NAME="oFile" onclick="return oFile_onclick()">
            </td>
        </tr>
        <tr __designer:mapid="133">
            <td __designer:mapid="134" align="center" class="style22" colspan="2" 
                width="200">
        <asp:Button ID="btnAceptar" runat="server" BackColor="Maroon" 
            Font-Names="Arial" ForeColor="White" onclick="btnAceptar_Click" Text="Aceptar" 
            ValidationGroup="Validar" />
            </td>
        </tr>
        </table>
         <asp:HiddenField ID="HiddenFieldError" runat="server" />

    <asp:ModalPopupExtender ID="HiddenFieldError_ModalPopupExtender" runat="server" 
        TargetControlID="HiddenFieldError" 
        PopupControlID="Panel1" CancelControlID="Button6" Enabled="True" 
            BackgroundCssClass="modalBackground">
    </asp:ModalPopupExtender>


        <asp:Panel ID="Panel1" runat="server" Height="94px" Width="326px" 
            BorderColor="Black" BorderStyle="Solid" BorderWidth ="1px" 
            BackColor ="WhiteSmoke" style="text-align: center">
            <br />
            <asp:Label ID="LabelErr" runat="server" Text="Label" ForeColor="Black" 
                CssClass="align"></asp:Label>
            <br />
            <br />
            &nbsp;&nbsp;&nbsp;<asp:Button ID="Button6" runat="server" onclick="Button2_Click1" 
               Text="Aceptar"  />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <br />
            <br />
            <br />
            <br />
        </asp:Panel>
                    <br />
                </fieldset a><br />
</fieldset><p>
&nbsp;&nbsp;
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </p>
    <p>
        &nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        ShowMessageBox="True" ShowSummary="False" ValidationGroup="Validar" />
    </asp:Content>
