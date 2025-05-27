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


namespace SintecromNet.Paginas
{
    public partial class RRHH_GestionNoticias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Cert"] = "";




                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_RRHH")
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
                    //this.TraerEmpleados("dbo.SP_I_TraerEmpleados");
                   

                }
              
            }

        
        }

      

        private void CargarGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
            

            try
            {
                //unosParametros = new SqlParameter[3];

                //unosParametros[0] = new SqlParameter("@Legajo", System.Data.SqlDbType.VarChar);
                //unosParametros[0].Value = txtLegajo.Text;

                //unosParametros[1] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                //unosParametros[1].Value = txtNombre.Text;

                //unosParametros[2] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                //unosParametros[2].Value = DropDownList1.SelectedValue;
               

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
                DataTable dt = unDS.Tables[0].Copy();


                Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarGrillaAusencias(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Legajo_Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();


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

      
       
      

        protected void Button2_Click1(object sender, EventArgs e)
        {
            //Panel9.Visible = false;
        }

      

        protected void btnModificar_Click(object sender, EventArgs e)
        {

            byte[] imagen;
            string strFileName;
            string strFolder;
            string strExtension;
            strFolder = Server.MapPath("./");
            if (!String.IsNullOrEmpty(fuImagen.ToString()))
            {
                strFileName = fuImagen.PostedFile.FileName;
                strFileName = Path.GetFileName(strFileName);
                strExtension = Path.GetExtension(strFileName);
                btnModificar.Enabled = true;

                if (!ValidarExtension(strExtension))
                {
                   
                    return;
                }
                else
                {
                    using (BinaryReader reader = new BinaryReader(fuImagen.PostedFile.InputStream))
                    {
                        imagen = reader.ReadBytes(fuImagen.PostedFile.ContentLength);
                        Session["imgInc"] = imagen;
                        Session["NombreArchivo"] = strFileName;

                    }
                }
                this.ActualizaFoto("dbo.SP_ModificarImagenNoticia");
               // btnModificar.Enabled = false;
            }
            
            Cargar_Foto();
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
                case ".pdf":
                case ".JPG":
                case ".JPEG":
                case ".PNG":
                case ".GIF":
                case ".BMP":
                case ".PDF":
                    verif = true;
                    break;
                default:
                    verif = false;
                    break;
            }
            return verif;
        }
        private void Cargar_Foto()
        {
            byte[] img = null;
            //string sArchivo = "";
            //string sPath = "/0-Proyectos/0-Proyectos/SintecromNet/SintecromNet/Images/Foto.jpg";
            //string sPath = "/Images/Foto.jpg";
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Noticia", System.Data.SqlDbType.Int);
                unosParametros[0].Value = DropDownList1.SelectedValue;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {
                    if (!String.IsNullOrEmpty(unDs.Tables[0].Rows[0]["Imagen"].ToString()))
                    {

                        img = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                        Session["Chota"] = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                        Session["NombreArchivo"] = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                        string sArchivo = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                        string sPath = "//intranet/TempImageFiles/";
                        File.WriteAllBytes(sPath + sArchivo, img);
                    

                        Image1.ImageUrl = ("~/HImagen.ashx");
                    }
                        DropDownList2.SelectedValue = unDs.Tables[0].Rows[0]["Panel"].ToString();
                        txtMensaje.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
                   
                    
                   
                }
                else
                {
                    Session["Chota"] = "Sin";
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }

            if (img != null)
            {
                //Response.ContentType = "image/jpeg";
                //Response.Expires = 0;
                //Response.Buffer = true;
                //Response.Clear();
                //Response.BinaryWrite(img);
                //Response.End();

                //File.WriteAllBytes(sPath, img);
                //imgFoto.ImageUrl = sPath;
            }
            //else
            //{
            //    Image1.Visible = false;
            //    lblMensaje.Visible = true;
            //    lblMensaje.Text = "El incidente Seleccionado no posee imágenes adjuntas";
            //}
        }

        private void ActualizaFoto(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Noticia", System.Data.SqlDbType.Int);
                unosParametros[0].Value = DropDownList1.SelectedValue;

                unosParametros[1] = new SqlParameter("@Imagen", System.Data.SqlDbType.Image);
                unosParametros[1].Value = Session["imgInc"];

                unosParametros[2] = new SqlParameter("@Archivo", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["NombreArchivo"].ToString().Trim();


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        
        }

        private void ActualizaNoticia(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Noticia", System.Data.SqlDbType.Int);
                unosParametros[0].Value = DropDownList1.SelectedValue;

                unosParametros[1] = new SqlParameter("@Panel", System.Data.SqlDbType.Int);
                unosParametros[1].Value = DropDownList2.SelectedValue;

                unosParametros[2] = new SqlParameter("@Texto", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtMensaje.Text;


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

     


        protected void btnFoto_Click(object sender, EventArgs e)
        {
             HiddenFieldError_ModalPopupExtender.Show();

        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            Panel2.Visible = true;
            Cargar_Foto();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            ActualizaNoticia("dbo.SP_ModificarNoticia");
            Panel2.Visible = false;
        }

       
       
      
      
      

       
    }

       
}
