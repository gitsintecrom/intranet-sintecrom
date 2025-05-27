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

namespace SintecromNet.Paginas
{
    public partial class RRHH_Noticias : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel1.Visible = false;
            Panel2.Visible = false;
            Panel3.Visible = false;
            //Panel4.Visible = false;
            Cargar_Foto1();
            Cargar_Foto2();
            Cargar_Foto3();
            //Cargar_Foto4();

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
                unosParametros[0].Value = 4;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {

                    if (Convert.ToInt32(unDs.Tables[0].Rows[0]["Panel"]) == 0)
                    {
                        Panel1.Visible = true;
                        lblNoticias1.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
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
                unosParametros[0].Value = 6;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {




                    if (Convert.ToInt32(unDs.Tables[0].Rows[0]["Panel"]) == 0)
                    {
                        Panel2.Visible = true;
                        Panel1.Visible = false;
                        Panel3.Visible = false;
                        lblNoticias2.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
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
            
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Noticia", System.Data.SqlDbType.Int);
                unosParametros[0].Value = 5;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {


                    if (Convert.ToInt32(unDs.Tables[0].Rows[0]["Panel"]) == 0)
                    {
                        Panel3.Visible = true;
                       
                        lblNoticias3.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
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

        protected void Timer1_Tick(object sender, EventArgs e)
        {

        }

        //private void Cargar_Foto4()
        //{
        //    byte[] img = null;

        //    Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
        //    DataSet unDs = null;
        //    SqlParameter[] unosParametros = null;
        //    try
        //    {
        //        unosParametros = new SqlParameter[1];

        //        unosParametros[0] = new SqlParameter("@Noticia", System.Data.SqlDbType.Int);
        //        unosParametros[0].Value = 7;
        //        unAcceso.AbrirConexion();
        //        unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenNoticias"), unosParametros);

        //        if (unDs.Tables[0].Rows.Count > 0)
        //        {


        //            if (Convert.ToInt32(unDs.Tables[0].Rows[0]["Panel"]) == 0)
        //            {
        //                Panel4.Visible = true;
        //                lblNoticias4.Text = unDs.Tables[0].Rows[0]["Texto"].ToString();
        //                if (!String.IsNullOrEmpty(unDs.Tables[0].Rows[0]["Imagen"].ToString()))
        //                {

        //                    img = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
        //                    Session["Chota4"] = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
        //                    Session["NombreArchivo4"] = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
        //                    string sArchivo = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
        //                    string sPath = "//intranet/TempImageFiles/";
        //                    File.WriteAllBytes(sPath + sArchivo, img);
        //                    Image4.ImageUrl = ("~/HImagen4.ashx");

        //                }
        //                else
        //                {
        //                    Session["Chota4"] = "Sin4";
        //                }
        //            }


        //        }

        //    }
        //    finally
        //    {
        //        unAcceso.CerrarConexion();
        //    }


        //}

    }

    
       
}


