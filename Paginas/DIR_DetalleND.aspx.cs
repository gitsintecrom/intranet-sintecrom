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


namespace SintecromNet.Paginas
{
    public partial class DIR_DetalleND : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_ADMINISTRACION")
                {

                    Session["Accede"] = "OK";


                }

            }
            if (Session["Accede"].ToString() == "NO")
            {
                Response.Redirect("Restringida.aspx");

            }

            if (Session["Rango"].ToString() == "Mensual")
            {
                lblTitulo.Text = " Mes " + DateTime.Now.Month + "/" + DateTime.Now.Year;
            }
            else
            {
                lblTitulo.Text =  DateTime.Now.ToShortDateString();
            }


            this.TraerDetalleND("dbo.SP_NDDetalle");
            gwGrilla.Visible = true;

          
            
        }


      

        private void TraerDetalleND(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";
           

            try
            {
                if (Session["Rango"].ToString() == "Mensual")
                {
                    DateTime dPrimerDia = DateTime.Today;
                    DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
                    FechaInicial = Desde.ToString("dd/MM/yyy");
                }
                else
                {
                    FechaInicial = DateTime.Today.ToString("dd/MM/yyy");
                }
                FechaFinal = DateTime.Today.ToString("dd/MM/yyy"); 

            
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;

                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                gwGrilla.DataSource = unDS;
                gwGrilla.DataBind();


                       

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
          

       
    }
}