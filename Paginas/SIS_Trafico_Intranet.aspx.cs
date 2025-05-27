using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;


namespace SintecromNet.Paginas
{
    public partial class SIS_Trafico_Intranet : System.Web.UI.Page
    {
        string sFecha = "";
        string sHora = "";
        string sUsuariointranet = "";
        string sPagina = "";


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Session["Accede"] = "NO";
                 string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());

                 if (usuario == "DOMINIOgbroide" || usuario == "DOMINIOjcianfagna")
                 {
                     Session["Accede"] = "OK";
                 }

                 else
                 {
                     IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                     foreach (IdentityReference i in irc)
                     {
                         string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                         if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES")
                         {

                             Session["Accede"] = "OK";
                         }

                     }
                 }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }
                else
                {
                    this.DepurarTabla("dbo.SP_BorrarTraficoIntranet");
                    
                    string Ruta = ("\\\\intranet\\TempImageFiles\\Intranet\\");
                    string[] files = Directory.GetFiles(Ruta);


                    for (int i = 0; i < files.Count(); i++)
                    {
                        string fichero = files[i];

                        try
                        {
                            using (StreamReader lector = new StreamReader(fichero))
                            {
                                while (lector.Peek() > -1)
                                {
                                    string linea = lector.ReadLine();
                                    if (!String.IsNullOrEmpty(linea) && linea.Length > 40)
                                    {
                                        if (linea.Substring(34, 4).ToString() == "POST" && linea.Substring(40, 7).ToString() == "Paginas")
                                        {
                                            char[] delimitadores = { ' ' };
                                            string[] ejemploPartido = linea.Split(delimitadores);
                                            sFecha = ejemploPartido[0].ToString();
                                            sHora = ejemploPartido[1].ToString();
                                            sPagina = ejemploPartido[4].ToString();
                                            sUsuariointranet = ejemploPartido[7].ToString();
                                            this.InsertarNovedades("dbo.SP_InsertarTraficoIntranet");
                                        }

                                    }
                                }
                            }

                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("Error: " + ex.Message);
                        }
                        if (File.Exists(fichero))
                        {
                            File.Delete(fichero);
                        }

                    }
                }
                


            }
        }

        private void TraerGrilla(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";

            try
            {

                FechaInicial = this.TextBoxIni.Text;
                FechaFinal = this.TextBoxFin.Text;

                try
                {
                    if (FechaInicial.Trim() != "")
                    {
                        Convert.ToDateTime(FechaInicial);
                        FechaInicial = FechaInicial.Substring(6, 4) + FechaInicial.Substring(3, 2) + FechaInicial.Substring(0, 2);
                    }
                }
                catch (Exception)
                {
                    this.LabelErr.Text = "La Fecha Inicial no es válida";
                    HiddenFieldError_ModalPopupExtender.Show();
                    return;
                }

                try
                {
                    if (FechaFinal.Trim() != "")
                    {
                        Convert.ToDateTime(FechaFinal);
                        FechaFinal = FechaFinal.Substring(6, 4) + FechaFinal.Substring(3, 2) + FechaFinal.Substring(0, 2);
                    }
                }
                catch (Exception)
                {
                    this.LabelErr.Text = "La Fecha Final no es válida";
                    HiddenFieldError_ModalPopupExtender.Show();
                    return;
                }
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;

                unosParametros[2] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtNombre.Text;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                gwGrilla.DataSource = unDS;
                gwGrilla.DataBind();

                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0) btnExcel.Visible = true;



                Session["Tabla"] = dt;




            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      
        private void InsertarNovedades(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            try
            {

                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Fecha", System.Data.SqlDbType.DateTime);
                unosParametros[0].Value = Convert.ToDateTime(sFecha);

                unosParametros[1] = new SqlParameter("@Hora", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = sHora;
                
                unosParametros[2] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = sUsuariointranet;

                unosParametros[3] = new SqlParameter("@Pagina", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = sPagina;


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void DepurarTabla(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            try
            {

                unAcceso.AbrirConexion();
                unAcceso.EjecutarSentencia_NonQuery(nombreStored);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerGrilla("dbo.SP_TraerTraficoIntranet");
        }

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {

        }

        protected void gwGrilla_RowCommand(object sender, GridViewCommandEventArgs e)
        {

        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {

            string nombre = "Trafico";
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

       
    }
}