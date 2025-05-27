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





namespace SintecromNet.Paginas
{
    public partial class INV_ConfiguracionInicial : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES" )
                    {
                        Session["Accede"] = "OK";
                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");
                }
              
               
            }
        
        }

      

        private void IniciarInventario(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;         
            

            try
            {
                unosParametros = new SqlParameter[1];
               
                unosParametros[0] = new SqlParameter("@Fecha", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = TextBoxFin.Text;

               
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

       

        public void GenerarAjustesyBajas()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_INV_GenerarAjustesyBajasInventario"));


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

      

       

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.IniciarInventario("dbo.SP_INV_InicializarInventario");
            Response.Write("<script>window.confirm('La Inicialización del Inventario se ha Ejecutado Exitosamente');</script>");
            TextBoxFin.Text = "";


           
        }

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {
            this.GenerarAjustesyBajas();
            Response.Write("<script>window.confirm('La Generación de los Ajustes y las bajas del Inventario se han Ejecutado Exitosamente" +
                "Recuerde Ejectuar los Procesos En Calipso !!!');</script>");

        }
    }

       
}
