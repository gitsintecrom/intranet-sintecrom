using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.IO;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net.Mail;



namespace SintecromNet.Paginas
{
    public partial class MIS_Incidentes : System.Web.UI.Page
    {
       
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["imgInc"] = "";
            lblFecha.Text = DateTime.Now.ToShortDateString();
            string sUsuario = Session["Usr"].ToString();
            sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
            lblUsuario.Text = sUsuario.Replace("DOMINIO", "");
            this.TraerDatos();



            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());
                if (group.Length >= 9)
                {
                    string sSector = group.Substring(0, 9);
                    if (sSector == ("DOMINIOW_"))
                    {

                        lblSector.Text = group.Replace("DOMINIOW_", "");

                    }
                }

            }
        }


        private void InsertarIncidentes(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            try
            {
                if (String.IsNullOrEmpty(Session["imgInc"].ToString()))
                {
                    unosParametros = new SqlParameter[5];

                    unosParametros[0] = new SqlParameter("@Comentario", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = txtComentario.Text;

                    unosParametros[1] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                    //unosParametros[1].Value = lblFecha.Text;
                    unosParametros[1].Value = DateTime.Now;


                    unosParametros[2] = new SqlParameter("@Tipo", System.Data.SqlDbType.VarChar);
                    unosParametros[2].Value = DropDownList1.SelectedValue;

                    unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                    unosParametros[3].Value = lblUsuario.Text;

                    unosParametros[4] = new SqlParameter("@Sector", System.Data.SqlDbType.VarChar);
                    unosParametros[4].Value = lblSector.Text;
                }
                else
                {
                    unosParametros = new SqlParameter[6];

                    unosParametros[0] = new SqlParameter("@Comentario", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = txtComentario.Text;

                    unosParametros[1] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                    //unosParametros[1].Value = lblFecha.Text;
                    unosParametros[1].Value = DateTime.Now;

                    unosParametros[2] = new SqlParameter("@Tipo", System.Data.SqlDbType.VarChar);
                    unosParametros[2].Value = DropDownList1.SelectedValue;

                    unosParametros[3] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                    unosParametros[3].Value = lblUsuario.Text;

                    unosParametros[4] = new SqlParameter("@Sector", System.Data.SqlDbType.VarChar);
                    unosParametros[4].Value = lblSector.Text;

                    unosParametros[5] = new SqlParameter("@Imagen", System.Data.SqlDbType.Image);
                    unosParametros[5].Value = Session["imgInc"];
                }





                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);
                
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        public void TraerDatos()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = lblUsuario.Text;
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_SIS_TraerUsuariosIntranet"), unosParametros);

                Session["email"] = unDS.Tables[0].Rows[0]["email"].ToString();
                Session["emailg"] = unDS.Tables[0].Rows[0]["emailg"].ToString();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private bool EnviarEmail() 
        {
            string error = "";
            MailMessage msg = new MailMessage();

            msg.To.Add("sistemas@sintecrom.com.ar");
            msg.CC.Add(Session["emailg"].ToString());


            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "SintecromNET Incidentes", System.Text.Encoding.UTF8);

            msg.Subject = "Se Ha Ingresado un Nuevo Incidente";

            msg.SubjectEncoding = System.Text.Encoding.UTF8;

            msg.Body = "El Usuario: " + lblUsuario.Text + " Ingresó un Incidente con el siguiente Detalle: " + txtComentario.Text;

            msg.BodyEncoding = System.Text.Encoding.UTF8;

            msg.IsBodyHtml = false; 
            SmtpClient client = new SmtpClient();
            
            client.Port = 587;

            client.Host = "smtp.gmail.com";

            client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "elvyffedyeximpwp");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;


            

            try
            {
                client.Send(msg);

                return true;
            }

            catch (Exception ex)
            {
                error = ex.Message.ToString();
                return false;
            }

        }

       

        protected void btnImagen_Click(object sender, EventArgs e)
        {
            string str;
            str = "window.open('Imagenes.aspx','Titulo','width=500,height=500,sc rollbars=no,resizable=no')";
            Response.Write("<script languaje=javascript>" + str + "</script>");
        }


        private Boolean ValidarExtension(string sExtension)
        {
            Boolean verif = false;
            switch (sExtension)
            {
                case ".jpg":
                case ".jpeg":
                case ".png":
                case ".gif":
                case ".bmp":
                    verif = true;
                    break;
                default:
                    verif = false;
                    break;
            }
            return verif;
        }
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
             
           
            byte[] imagen;
            string strFileName;
            string strFolder;
            string strExtension;
            strFolder = Server.MapPath("./");
            


            strFileName = oFile.PostedFile.FileName;
            strFileName = Path.GetFileName(strFileName);
            if (!string.IsNullOrEmpty(strFileName))
            {
                 strExtension = Path.GetExtension(strFileName);
                 if (!ValidarExtension(strExtension))
                 {
                     lblMsg.Visible = true;
                     lblMsg.CssClass = "alert alert-danger";
                     lblMsg.Text = "La Extensión del Archivo no es Correcta";
                     return;
                 }
                 else
                 {
                     using (BinaryReader reader = new BinaryReader(oFile.PostedFile.InputStream))
                     {
                         imagen = reader.ReadBytes(oFile.PostedFile.ContentLength);
                         Session["imgInc"] = imagen;

                     }
                 }
            }

            this.EnviarEmail();
            this.InsertarIncidentes("dbo.SP_InsertarIncidentes");
            lblMsg.Visible = true;
            lblMsg.CssClass = "alert alert-success";
            lblMsg.Text = "El Incidente fue Ingresado Correctamente";

            txtComentario.Text = "";

        }
    }
}