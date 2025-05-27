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
    public partial class Dir_ProyectadoCobranzas : System.Web.UI.Page
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
           
            this.Consolido_Cobranzas("dbo.SP_Consolida_Cobranzas_Diarias");

            this.TraerAcumulado("dbo.SP_Acumulado_Mensual");
            this.TraerDiasT("dbo.SP_TraerDiasTranscurridos");
            this.TraerDiasH("dbo.SP_TraeDiasHabilesCobranzas");
        }

        

        private void Consolido_Cobranzas(string nombreSP)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");

            try
            {
                unAcceso.AbrirConexion();
                unAcceso.EjecutarSentencia_NonQuery(nombreSP);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
           


        }
        private void TraerAcumulado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
           
            DataSet unDS = null;
            decimal acumulado = 0;
           

            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored) );
               
                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Importe"].ToString());

                }
               
                lblAcumuladoMes.Text = String.Format("{0:c}", acumulado); //acumulado.ToString();
                Session["acumulado"] = acumulado;


                
                



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDiasT(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                lblDiasT.Text = unDS.Tables[0].Rows[0]["diast"].ToString();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerDiasH(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;
            decimal resultado = 0;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
                             
                //Convierto los labels en decimal

                //decimal dacumulado = Convert.ToDecimal(lblAcumuladoMes.Text);
                decimal dacumulado = Convert.ToDecimal(Session["acumulado"].ToString());
                decimal ddiast = Convert.ToDecimal(lblDiasT.Text);
                decimal dcobrado = dacumulado / ddiast;
                decimal ddiasp = Convert.ToDecimal(unDS.Tables[0].Rows[0]["dias"].ToString());
                decimal ddiasresto = ddiasp - ddiast;
                decimal dproyectado = ddiasresto * dcobrado;
                resultado = dproyectado + dacumulado;
                lblDiasP.Text = ddiasresto.ToString();

                




                lblProyectado.Text = String.Format("{0:c}", resultado); //acumulado.ToString();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

    

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }
    }
}