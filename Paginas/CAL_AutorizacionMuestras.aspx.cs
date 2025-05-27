using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.Configuration;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;
using Microsoft.Reporting.WebForms;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Text;
using System.Web.UI.HtmlControls;
using System.Net.Mail;






namespace SintecromNet.Paginas
{
    public partial class CAL_AutorizacionMuestras : System.Web.UI.Page
    {

        public string remitente { get; set; }
        public string titulo { get; set; }
        public string cuerpo { get; set; }


        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Estado"] = Request.QueryString["Parametro"];
                int iestado = Convert.ToInt32(Request.QueryString["Parametro"]);



                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES")
                        || group == ("DOMINIOW_CALIDAD") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL")
                        || group == "DOMINIOW_SUPPLYCHAIN" || group == ("DOMINIOW_PRODUCCION"))
                    {
                        Session["Accede"] = "OK";
                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");
                }
                else
                {
                    this.TraerGrilla(gwGrilla, "dbo.SP_CAL_TraerMuestrasParaAutorizar");
                    
                    switch (iestado)
                    {
                        case 0:
                            lblTitulo.Text = "Muestras Pendientes de Autorizar por Calidad";
                            Label3.Visible = true;
                            txtDetalle.Visible = true;
                            break;
                        case 1:
                            lblTitulo.Text = "Muestras Pendientes de Autorizar por Comercial";
                            Label3.Visible = true;
                            txtDetalle.Visible = true;
                            break;                            
                        case 2:
                            lblTitulo.Text = "Muestras Pendientes de Autorizar por Programación";
                            btnAutorizar.Text = "Aceptar";
                            Label3.Visible = true;
                            txtDetalle.Visible = true;
                            break;
                        case 3:
                            lblTitulo.Text = "Muestras Pendientes de Producción";
                            btnAutorizar.Text = "Aceptar";
                            Label3.Visible = false;
                            txtDetalle.Visible = false;
                            break;
                        case 4:
                            lblTitulo.Text = "Muestras Pendientes de Autorización Despacho Calidad";
                            btnAutorizar.Text = "Aceptar";
                            Label3.Visible = false;
                            txtDetalle.Visible = false;
                            break;
                        case 5:
                            lblTitulo.Text = "Muestras Pendientes de Despacho";
                            btnAutorizar.Text = "Aceptar";
                            Label3.Visible = false;
                            txtDetalle.Visible = false;
                            break;

                    }
                }
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;
               
            

            try
            {

                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@Estado", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Estado"]);
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

      

        private void EditarDatos(string nombreSP, int iRespuesta)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);

            try
            {
                unosParametros = new SqlParameter[7];

                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Session["ID"];

                unosParametros[1] = new SqlParameter("@Observa", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtDetalle.Text;

                unosParametros[2] = new SqlParameter("@Respuesta", System.Data.SqlDbType.Int);
                unosParametros[2].Value = iRespuesta;

                unosParametros[3] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[3].Value = Convert.ToInt32(Session["Estado"]);

                unosParametros[4] = new SqlParameter("@Despacho", System.Data.SqlDbType.DateTime);
                unosParametros[4].Value = DateTime.Now.ToShortDateString();

                unosParametros[5] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = Session["Usr"].ToString();

                unosParametros[6] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = Session["Cliente"].ToString();






                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }
    
      


        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Detalle")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                Panel1.Visible = true;
                Panel2.Visible = false;

                lblCliente.Text = this.gwGrilla.DataKeys[index].Values[0].ToString();
                lblEmail.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                lblTelefono.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                lblRequiereCertificado.Text = this.gwGrilla.DataKeys[index].Values[4].ToString();
                lblEmailCertificado.Text = this.gwGrilla.DataKeys[index].Values[5].ToString();
                lblEmbalaje.Text = this.gwGrilla.DataKeys[index].Values[6].ToString();
                lblPlegado.Text = this.gwGrilla.DataKeys[index].Values[7].ToString();
                lblProfundidad.Text = this.gwGrilla.DataKeys[index].Values[8].ToString();
                lblPintado.Text = this.gwGrilla.DataKeys[index].Values[9].ToString();
                lblAnodizado.Text = this.gwGrilla.DataKeys[index].Values[10].ToString();
                lblPerforado.Text = this.gwGrilla.DataKeys[index].Values[11].ToString();
                lblConformado.Text = this.gwGrilla.DataKeys[index].Values[12].ToString();
                lblObservacionesC.Text = this.gwGrilla.DataKeys[index].Values[13].ToString();
                lblObservacionesP.Text = this.gwGrilla.DataKeys[index].Values[14].ToString();
                lblObservacionesV.Text = this.gwGrilla.DataKeys[index].Values[15].ToString();
                lblComentarios.Text = this.gwGrilla.DataKeys[index].Values[16].ToString();
                lblDomicilio.Text = this.gwGrilla.DataKeys[index].Values[17].ToString();
                lblTransporte.Text = this.gwGrilla.DataKeys[index].Values[18].ToString();
                lblUsoFinal.Text = this.gwGrilla.DataKeys[index].Values[19].ToString();
                lblOrigen.Text = this.gwGrilla.DataKeys[index].Values[20].ToString();
                lblVendedor.Text = this.gwGrilla.DataKeys[index].Values[21].ToString();
                lblEstado.Text = this.gwGrilla.DataKeys[index].Values[22].ToString();
                lblFechaSolicitada.Text = Convert.ToDateTime(this.gwGrilla.DataKeys[index].Values[24].ToString()).ToString("dd/MM/yyyy");
                lblMaterial.Text = this.gwGrilla.DataKeys[index].Values[25].ToString();
                lblSerie.Text = this.gwGrilla.DataKeys[index].Values[26].ToString();
                lblEspesor.Text = this.gwGrilla.DataKeys[index].Values[27].ToString();
                lblAncho.Text = this.gwGrilla.DataKeys[index].Values[28].ToString();
                lblUnidadMedida.Text = this.gwGrilla.DataKeys[index].Values[29].ToString();
                lblLargo.Text = this.gwGrilla.DataKeys[index].Values[31].ToString();
                lblFechaDespacho.Text = this.gwGrilla.DataKeys[index].Values[32].ToString();
                lblAleacion.Text = this.gwGrilla.DataKeys[index].Values[34].ToString();
                lblTemple.Text = this.gwGrilla.DataKeys[index].Values[35].ToString();

                Session["Cliente"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                Session["ID"] = Convert.ToInt32(this.gwGrilla.DataKeys[index].Values[1]); 

            }
           
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
           
        }

        private bool EnviarEmail()
        {

            MailMessage msg = new MailMessage();

            msg.To.Add(remitente);

            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "Solicitud de Muestras", System.Text.Encoding.UTF8);

            msg.Subject = titulo;

            msg.SubjectEncoding = System.Text.Encoding.UTF8;

           
            msg.Body = cuerpo + " " + lblCliente.Text;


            msg.BodyEncoding = System.Text.Encoding.UTF8;

            msg.IsBodyHtml = false; //Si vas a enviar un correo con contenido html entonces cambia el valor a true
            //Aquí es donde se hace lo especial

            SmtpClient client = new SmtpClient();

            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte1234");

            client.Port = 587;

            client.Host = "smtp.gmail.com";//Este es el smtp valido para Gmail

            client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail

            client.UseDefaultCredentials = false;
            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte.2023*");
            client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "elvyffedyeximpwp");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;

            try
            {
                client.Send(msg);

                return true;
            }

            catch (Exception)
            {
                return false;
            }

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = true;
        }

    

        protected void btnAutorizar_Click(object sender, EventArgs e)
        {
            int iRespuesta = Convert.ToInt16(Request.QueryString["Parametro"]) + 1;
            switch (iRespuesta)
            {
                case 1:
                    remitente = "ventas@sintecrom.com.ar, programacion@sintecrom.com.ar";
                    titulo = "Autorización de Solicitud de Muestra";
                    cuerpo = "Se Requiere la Autorización Comercial para la solicitud de Muestra del Cliente:";
                    EnviarEmail();
                    break;
                case 2:
                    remitente = "programacion@sintecrom.com.ar";

                    titulo = "Autorización de Solicitud de Muestra";
                    cuerpo = "Se Requiere la Autorización de Programación para la solicitud de Muestra del Cliente:";
                    EnviarEmail();
                    break;
                case 3:
                    remitente = "produccion@sintecrom.com.ar";

                    titulo = "Procesamiento de Solicitud de Muestra";
                    cuerpo = "Se Requiere la producción de la solicitud de Muestra del Cliente:";
                    EnviarEmail();
                    break;
                case 4:
                    remitente = "calidad@sintecrom.com.ar, programacion@sintecrom.com.ar";

                    titulo = "Autorización de Solicitud de Muestra";
                    cuerpo = "Se Requiere la Autorización para el despacho de la solicitud de Muestra del Cliente:";
                    EnviarEmail();
                    break;
                case 5:
                    remitente = "expedicion@sintecrom.com.ar, ventas@sintecrom.com.ar, programacion@sintecrom.com.ar";

                    titulo = "Despacho de Solicitud de Muestra";
                    cuerpo = "Se ha Autorizado el despacho de la solicitud de Muestra del Cliente:";
                    EnviarEmail();
                    break;
                case 6:
                    remitente = "ventas@sintecrom.com.ar, programacion@sintecrom.com.ar";

                    titulo = "Despacho de Solicitud de Muestra";
                    cuerpo = "Se ha realizado el despacho de la solicitud de Muestra del Cliente:";
                    EnviarEmail();
                    break;


            }
            //Request.QueryString["Parametro"]
            this.EditarDatos("SP_CAL_EditarAutorizacionMuestras", Convert.ToInt16(Request.QueryString["Parametro"]) + 1);
            Panel2.Visible = true;
            Panel1.Visible = false;
            this.TraerGrilla(gwGrilla, "dbo.SP_CAL_TraerMuestrasParaAutorizar");
            gwGrilla.Visible = true;
        }

        protected void btnRechazar_Click(object sender, EventArgs e)
        {
            int iRespuesta = 10 + Convert.ToInt32(Session["Estado"]);
            remitente = "ventas@sintecrom.com.ar, programacion@sintecrom.com.ar";
            titulo = "Rechazo de Solicitud de Muestra";
            cuerpo = "Se ha Rechazado la solicitud de Muestra para el Cliente:";
            EnviarEmail();
            
            this.EditarDatos("SP_CAL_EditarAutorizacionMuestras", iRespuesta);
            Panel2.Visible = true;
            Panel1.Visible = false;
            this.TraerGrilla(gwGrilla, "dbo.SP_CAL_TraerMuestrasParaAutorizar");
        }
    }

       
}
