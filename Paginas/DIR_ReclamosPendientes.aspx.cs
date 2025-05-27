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
using  System.Web.UI.HtmlControls;
using System.Net.Mail;





namespace SintecromNet.Paginas
{
    public partial class DIR_ReclamosPendientes : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
              


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_AUTORIZACION_COMERCIAL"))
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
                    this.TraerGrilla(gwGrilla, "Pendiente", "dbo.SP_TraerReclamos");

                    LinkButton2.Visible = true;
                  
                }
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, String sEstado, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
          
            

            try
            {
                unosParametros = new SqlParameter[1];
               
                
                unosParametros[0] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sEstado;

                               
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

        private void TraerGrillaDetalle(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;



            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@ID", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["Numero"]);


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

      


        private void ActualizarDatos(string nombreSP, string sEstado)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32( Session["Numero"]);

                
                unosParametros[1] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sEstado;
                

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }

      
        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
           
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwGrilla.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwGrilla);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= FactLS.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }     


       

      

     
      

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            this.TraerGrilla(gwGrilla, "Pendiente","dbo.SP_TraerReclamos");

            LinkButton2.Visible = true;
            //btnExcel.Visible = true;          
        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);

                Session["Numero"] = this.gwGrilla.DataKeys[index].Values[0].ToString();
                string sCliente =  this.gwGrilla.DataKeys[index].Values[6].ToString();
                Label1.Text = "Reclamo:" + " " + Session["Numero"].ToString() + " " + "Cliente:" + " " + sCliente;
                txtEmite.Text = this.gwGrilla.DataKeys[index].Values[3].ToString();
                txtMotivo.Text = this.gwGrilla.DataKeys[index].Values[2].ToString();
                txtObservaciones.Text = this.gwGrilla.DataKeys[index].Values[4].ToString();
                txtReclamoExterno.Text = this.gwGrilla.DataKeys[index].Values[5].ToString();
                this.TraerGrillaDetalle(GridView1, "dbo.SP_REC_TraerReclamosRemitos");
                HiddenFieldError_ModalPopupExtender.Show();

               
                
            }
        }

        protected void gwGrilla_SelectedIndexChanged(object sender, EventArgs e)
        {

            //this.TraerDetalle(GridView1, "dbo.SP_TraerDetalleFacturacionLS");
            //if (Convert.ToInt16( Session["Estado"]) == 1)
            //{
            //    btnEjecutar.Visible = false;
            //}
            //else
            //{
            //    btnEjecutar.Visible = true;

            //}
           
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click en el Numero de Reclamo para Visualizar el Detalle.";

            }
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //this.TraerGrilla(gwGrilla, 1,"dbo.SP_TraerFacturacionLS");

            //btnExcel.Visible = true;
            //lblEstado.Visible = true;
            //lblEstado.Text = "Realizados";
            //Session["Estado"] = 1;
        }

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            this.ActualizarDatos("dbo.SP_ModificarEstadoReclamo", "En Proceso");
            this.TraerGrilla(gwGrilla, "Pendiente","dbo.SP_TraerReclamos");

            EnviarEmail();
            LinkButton2.Visible = true;
           
        }

       

        protected void Button1_Click1(object sender, EventArgs e)
        {
            this.ActualizarDatos("dbo.SP_ModificarEstadoReclamo", "Rechazado");
            this.TraerGrilla(gwGrilla, "Pendiente", "dbo.SP_TraerReclamos");


            LinkButton2.Visible = true;
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwGrilla.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwGrilla);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Reclamos.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
            gwGrilla.Visible = false;
        }

        private bool EnviarEmail()
        {

            MailMessage msg = new MailMessage();

            msg.To.Add("calidad@sintecrom.com.ar");
            //msg.To.Add("jnavarro@sintecrom.com.ar, megonzalez@sintecrom.com.ar, ninsua@sintecrom.com.ar");

            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "Reclamos Clientes", System.Text.Encoding.UTF8);

            msg.Subject = "Nuevo Reclamo Autorizado";

            msg.SubjectEncoding = System.Text.Encoding.UTF8;

            msg.Body = "Existe un Nuevo Reclamo Autorizado ";

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

       


       

      
       

       

      
       
       


           

      
      

       
     

    }

       
}
