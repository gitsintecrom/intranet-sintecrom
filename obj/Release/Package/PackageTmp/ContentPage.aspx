<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="ContentPage.aspx.cs" Inherits="SintecromNet.ContentPage" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="StyleSection" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentSection" runat="server">
    <form id="form1" runat="server">
        <!--Si es Celular -->
            <div runat="server" id="movil" class="jumbotron" visible="true" style="background-color: #960101">
                <div class="container-fluid">
                <h4 style="color: #FFFFFF">Bienvenido a Intranet móvil</h4>

                <ul class="nav navbar-nav"> 
                                                 
                        
                        <li class="active"><a class="fas fa-user-tie fa-2x"  style="color:white; background-color: #960101;" data-toggle="collapse" data-placement="right" title="Direccion"  href="#collapseDir"></a></li> 
                        <li class="active"><a class="fab fa-apple fa-2x"  style="color:white; background-color: #960101;" data-toggle="collapse" data-placement="right" title="Sistemas"  href="#collapseSis"></a></li> 
                    <%--Quitar Comentario en el Inventario Anual JRN 06-07-2022--%>    
                    <%--<li class="active"><a class="fas fa-dolly-flatbed fa-2x"  style="color:white; background-color: #960101;" title="Inventario Anual" href="../Paginas/INV_IngresoInventarioAnual.aspx"></a></li>--%> 

                    </ul>
                 <div class="collapse" id="collapseSis">
                    <div class="card card-body">
                      <div class="btn-group" role="group" aria-label="Basic example" >
                          <a href="/Paginas/SIS_AdmEquipos.aspx" class="btn btn-light" style="color:#960101; background-color: white;">Equipamiento</a>
                          <a href="/Paginas/SIS_AdmIncidentes.aspx"class="btn btn-light" style="color:#960101; background-color: white;">Incidentes</a>
                          <a href="/Paginas/SIS_TableroSRP.aspx"class="btn btn-light" style="color:#960101; background-color: white;">Tablero</a>
                          <a href="/Paginas/SRP_TrackingProduccion.aspx"class="btn btn-light" style="color:#960101; background-color: white;">Tracking</a>
          
                    </div>
                     

                    </div>
                    </div>

                    <div class="collapse" id="collapseDir">
                    <div class="card card-body">
                      <div class="btn-group" role="group" aria-label="Basic example" >
                          <a href="/Paginas/DIR_TableroDireccion.aspx" class="btn btn-light" style="color:#960101; background-color: white;">Tablero Dirección</a>
                          <a href="/Paginas/DIR_Cobranzas.aspx"class="btn btn-light" style="color:#960101; background-color: white;">Tablero Gerencia</a>
                          <a href="/Paginas/DIR_RankingClientes.aspx"class="btn btn-light" style="color:#960101; background-color: white;">Ranking Clientes</a>
                         
                    </div>
                      <br />

                    </div>
                    </div>

                 </div>
                </div>
         <!--Si es PC -->
        <%--<div runat="server" id="Div1" class="jumbotron jumbotron-fluid" style="background-image: url('Images/fondo-contacto.jpg'); height: 500px;">--%>
        <div runat="server" id="pc" class="jumbotron jumbotron-fluid" style="background-image: url('Images/fondo-contacto.jpg');">
            <%--<div style="width: 449px; float: left; vertical-align: middle; text-align: center; height: 60px;">--%>
        <br />
      <%--  <asp:Image ID="imgAdvertencia" runat="server" Height="33px" 
            ImageUrl="~/Images/Advertencia.jpg" Visible="False" Width="50px" />--%>

                    <asp:LinkButton ID="LinkButton2" runat="server" CssClass="fas fa-exclamation-triangle" OnClick="LinkButton2_Click" ToolTip="Ir" ForeColor="#FFFF99"></asp:LinkButton>

               

        <asp:Label ID="lblMensaje" runat="server" Font-Size="Small" ForeColor="White" 
            Text="Tiene Requerimientos de Servicios Pendientes. Por Favor Verifique."></asp:Label>
    <%--</div>--%>
            <br /><br />
            <h3 style="color: #FFFFFF">Noticias</h3>
              
 
            <div class="input-group">
                <div style ="float:right; width:275px; height:250px;" >
                  <div id="cont_20488b3f74eb8ef135050ccea39857da"><script type="text/javascript" async src="https://www.meteored.com.ar/wid_loader/20488b3f74eb8ef135050ccea39857da"></script></div>    
              </div>
                <asp:Panel ID="Panel1" runat="server" BackColor="#C40338" BorderStyle="Outset" BorderWidth="3px" Width="280px" style="float: left; border-radius: 5px">
                <%--<asp:Label ID="lblNoticias1" runat="server" ForeColor="White" Height="85px" Width="275px" Font-Bold="True" Font-Size="Large" style="text-align: center"></asp:Label>--%>
                   
                    <asp:Image ID="Image1"  Height="250px" Width="275px" runat="server" />
                </asp:Panel>

                <asp:Panel ID="Panel2" runat="server" BackColor="#C40338" BorderStyle="Outset" BorderWidth="3px" Width="280px" style="float: left; border-radius: 5px">
                <%--<asp:Label ID="lblNoticias2" runat="server" ForeColor="White" Height="85px" Width="275px" Font-Bold="True" Font-Size="Large" style="text-align: center"></asp:Label>--%>
                   

                    <asp:Image ID="Image2"  Height="250px" Width="275px" runat="server" />
                </asp:Panel>
                 
                <asp:Panel ID="Panel3" runat="server" BackColor="#C40338" BorderStyle="Outset" BorderWidth="3px" Width="280px" style="float: left; border-radius: 5px">
                   
                    <asp:Image ID="Image3"  Height="250px" Width="275px" runat="server" />
                </asp:Panel>
                <br />
                
             
                
                
                            </div>
           <br />

            <%--<div style ="float:right;">--%>
            <%--<span style ="float:right; color:gray;" >--%>

                <%--<p>--%>
<%--  <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
   <i class="fab fa-apple fa-3x"></i>
  </a>
  
</p>
<div class="collapse" id="collapseExample">
  <div class="card card-body">
      <div class="btn-group" role="group" aria-label="Basic example">
          <a href="/Paginas/SIS_AdmEquipos.aspx" class="btn btn-info">Equipamiento</a>
          <a href="/Paginas/SIS_AdmIncidentes.aspx"class="btn btn-info">Incidentes</a>
          <a href="/Paginas/SIS_TableroSRP.aspx"class="btn btn-info">Tablero</a>
          <a href="/Paginas/SRP_TrackingProduccion.aspx"class="btn btn-info">Tracking</a>
          
    </div>
  </div>
</div>--%>

           </div>
            <%--</span>--%>
           <%--</div>--%>

        <%--</div>--%>







        

    </form>
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptSection" runat="server">
</asp:Content>
