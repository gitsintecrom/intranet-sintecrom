using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Xml;
using System.Net;
using System.IO;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.Management;
using System.Text.RegularExpressions;

namespace SintecromNet
{
    public partial class ContentPage : System.Web.UI.Page
    {
        int iEstado = 0;
        string sUsuario = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            string version = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            string usuario = user.Name;
            usuario = Clases.Varias.RemoveSpecialCharacters(usuario.ToString());
            usuario = usuario.Replace("DOMINIO", "");
            sUsuario = usuario;
            this.Traer_Empleado("dbo.SP_TraerNombreUsuario");


            if (iEstado != 1)
            {
                Response.Redirect("Restringida.aspx");
            }
            else
            {
                string uAg = Request.ServerVariables["HTTP_USER_AGENT"];
                Regex regEx = new Regex(@"android|iphone|ios|ipad|ipod|blackberry|symbianos", RegexOptions.IgnoreCase);
                bool isMobile = regEx.IsMatch(uAg);


                if (isMobile)
                {
                    //Response.Write("Bienvenido a la Intranet móvil de Sintecrom");
                    movil.Visible = true;
                    pc.Visible = false;

                }
                else
                {
                    movil.Visible = false;
                    pc.Visible = true;
                    Panel1.Visible = false;
                    Panel2.Visible = false;
                    Panel3.Visible = false;
                    Cargar_Foto1();
                    Cargar_Foto2();
                    Cargar_Foto3();
                    this.TraerOC_Servicios("dbo.SP_I_TraerOrdenesDeComprasServiciosUS");
                }

            }
           
                    
        }

        private void Traer_Empleado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sUsuario.ToString().Trim();
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                iEstado = Convert.ToInt32(unDS.Tables[0].Rows[0]["estado"]);


               
                
            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

    


    private void TraerOC_Servicios(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            WindowsIdentity user = WindowsIdentity.GetCurrent();
            string usuario = user.Name;
            usuario = Clases.Varias.RemoveSpecialCharacters(usuario.ToString());
            usuario = usuario.Replace("DOMINIO", "");


            try
            {


                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = usuario;




                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);



                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    //imgAdvertencia.Visible = true;
                    LinkButton2.Visible = true;
                    lblMensaje.Visible = true;
                }
                else
                {
                    LinkButton2.Visible = false;
                    lblMensaje.Visible = false;
                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void Cargar_Foto1()
        {
            byte[] img = null;
           
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Noticia", System.Data.SqlDbType.Int);
                unosParametros[0].Value = 1;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {

                    if (Convert.ToInt32(unDs.Tables[0].Rows[0]["Panel"]) == 0)
                    {
                        Panel1.Visible = true;
                        //lblNoticias1.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
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
                        else
                        {
                            Session["Chota"] = "Sin";
                        }

                    }


                }
               
            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }
        private void Cargar_Foto2()
        {
            byte[] img = null;
           
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Noticia", System.Data.SqlDbType.Int);
                unosParametros[0].Value = 2;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {

                    


                    if(Convert.ToInt32( unDs.Tables[0].Rows[0]["Panel"]) == 0)
                    {
                        Panel2.Visible = true;
                        //lblNoticias2.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
                        if (!String.IsNullOrEmpty(unDs.Tables[0].Rows[0]["Imagen"].ToString()))
                        {
                            img = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                            Session["Chota2"] = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                            Session["NombreArchivo2"] = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                            string sArchivo = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                            string sPath = "//intranet/TempImageFiles/";
                            File.WriteAllBytes(sPath + sArchivo, img);
                            Image2.ImageUrl = ("~/HImagen2.ashx");


                        }
                        else
                        {
                            Session["Chota2"] = "Sin2";
                        }



                    }
                   

                }
                
            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }
        private void Cargar_Foto3()
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
                unosParametros[0].Value = 3;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {
                   

                    if (Convert.ToInt32(unDs.Tables[0].Rows[0]["Panel"]) == 0)
                    {
                        Panel3.Visible = true;
                        //lblNoticias3.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
                        if (!String.IsNullOrEmpty(unDs.Tables[0].Rows[0]["Imagen"].ToString()))
                        {

                            img = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                            Session["Chota3"] = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                            Session["NombreArchivo3"] = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                            string sArchivo = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                            string sPath = "//intranet/TempImageFiles/";
                            File.WriteAllBytes(sPath + sArchivo, img);
                            Image3.ImageUrl = ("~/HImagen3.ashx");

                        }
                        else
                        {
                            Session["Chota3"] = "Sin3";
                        }



                    }


                }
               
            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }

        protected void Image1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("/Paginas/VT_IngresoContactos.aspx");

        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Paginas/MIS_ReqServicios.aspx");
        }

    }
}