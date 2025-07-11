<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DOC_TrackingDePedido.aspx.cs" Inherits="SintecromNet.Paginas.DOC_TrackingDePedido" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

        <h2>Tracking De Pedidos&nbsp;&nbsp; </h2>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <asp:Button ID="btnDescarga0" runat="server" onclick="btnDescarga0_Click"  
                Text="Descarga" style="text-align: center" />
            </p>
<p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>CONSULTA SP_OPERACIONES_MATCHING_ABIERTAS_POR_ITEM_PEDIDO]</strong></p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Parámetros:</strong> NroMatching , NotaMatching </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Descripción: </strong>Este store devuelve las operaciones de con sus kgs 
            a procesar y los items de pedidos asociados para un matching determinado.&nbsp;</p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>CONSULTA SP_OPERACIONES _ORIGEN_DESTINO_POR_MATCHING_SIN_ITEM_PEDIDO</strong>
        </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Parámetros:</strong> NroMatching , NotaMatching </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Descripción: </strong>Este store devuelve las operaciones de origen y 
            destino ( ARBOL DE OPERACIONES )con sus kgs a procesar para un matching 
            determinado. No da info sobre los items de pedido. </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            &nbsp;</p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>CONSULTAS PARA BATCHS PENDIENTES DE SER FABRICADOS</strong></p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>SP_OPERACIONES_DETALLE_DE_ARBOL_OP_PARA_BATCH_PENDIENTES </strong></p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Parámetros:</strong> No lleva </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Descripción:</strong> Devuelve todos los árboles con sus operaciones de 
            origen y destino para los batchs pendientes ( con flag distintos de 
            fabricado/anulado)</p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>SP_OPERACIONES_DETALLE_DE_OP_ABIERTASxITEMPEDIDOxBATCH_PENDIENTES
            </strong></p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Parámetros:</strong> No tiene </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
             <strong>Descripción:</strong> Este store devuelve tods los items de pedido de las operaciones que 
            se encuentran en un batch pendiente de fabricarse ( No incluye las operaciones 
            de los batchs con flag =FABRICADO o ANULADO). Se excluyen por un problema a 
            resolver de registración las operaciones de Horno y Embalaje&nbsp; </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            &nbsp;</p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            &nbsp;</p>
<p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>CONSULTAS POR ITEM DE PEDIDO </strong></p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>SP_OPERACIONES-Seguimiento-ITEM_PEDIDO-x-Matching </strong></p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
            <strong>Parámetros:</strong> NroPedido, Nro de Item,SoloOpItemPed </p>
        <p style="margin: 0px 0px 1.5em; padding: 0px; color: rgb(51, 51, 51); font-family: arial, tahoma, verdana, sans-serif; font-size: 13.2799997329712px; font-style: normal; font-variant: normal; font-weight: normal; letter-spacing: normal; line-height: 19.9200000762939px; orphans: auto; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 1; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255);">
             <strong>Descripción:</strong> Detalla todas/solo (@SoloOpItemPed=&#39;F&#39; o &#39;T&#39;) las operaciones de 
            los matching en que participa un item de pedido - Info de matching, itempedido , 
            operaciones Sintecrom &nbsp;</p>
<p>
            &nbsp;</p>
</asp:Content>
