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
    public partial class DIR_RankingClientes : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_GERENTES")
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
                this.TraerRankingPorFecha("dbo.SP_RankingTorta");

            }


           
            
        }



        private void TraerRankingTorta(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
           


            try
            {
               


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));



                Chart6.DataSource = unDS;
                Chart6.Series["Series1"].XValueMember = "Cliente";
                Chart6.Series["Series1"].YValueMembers = "Dolares";

                Chart6.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerRankingPorFecha(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            
            DateTime dPrimerDia = DateTime.Today;
            DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
            string sDesde = Desde.ToString("yyyyMMdd");
            string sHasta = DateTime.Today.ToString("yyyyMMdd");
            

            try
            {
                if(String.IsNullOrEmpty(TextBoxFin.Text))
                {
                    unosParametros = new SqlParameter[2];

                    unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = sDesde;

                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = sHasta;


                }

                else
                {
                    unosParametros = new SqlParameter[2];

                    unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = TextBoxIni.Text;

                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = TextBoxFin.Text;


                }


                unAcceso.AbrirConexion();
                //unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                Chart5.DataSource = unDS;
                Chart5.Series["Series1"].XValueMember = "Cliente";
                Chart5.Series["Series1"].YValueMembers = "Dolares";

                Chart5.DataBind();

                Chart6.DataSource = unDS;
                Chart6.Series["Series1"].XValueMember = "Cliente";
                Chart6.Series["Series1"].YValueMembers = "Dolares";

                Chart6.DataBind();

                DataTable dt = unDS.Tables[0].Copy();


                Session["Tabla"] = dt;
               

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerRanking(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            //DateTime dPrimerDia = DateTime.Today;
            //DateTime Desde = new DateTime(dPrimerDia.Year, dPrimerDia.Month, 1);
            //string sDesde = Desde.ToString("yyyyMMdd");
            //string sHasta = DateTime.Today.ToString("yyyyMMdd");


            try
            {
                
               
                    unosParametros = new SqlParameter[2];

                    unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = TextBoxIni.Text;

                    unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = TextBoxFin.Text;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                Chart5.DataSource = unDS;
                Chart5.Series["Series1"].XValueMember = "Cliente";
                Chart5.Series["Series1"].YValueMembers = "Dolares";

                Chart5.DataBind();

                Chart6.DataSource = unDS;
                Chart6.Series["Series1"].XValueMember = "Cliente";
                Chart6.Series["Series1"].YValueMembers = "Dolares";

                Chart6.DataBind();

                DataTable dt = unDS.Tables[0].Copy();


                Session["Tabla"] = dt;


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerRanking("dbo.SP_DIR_RankingTortaSeleccion");
            
            
        }

        protected void imgAlta_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "Ranking_Clientes" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            string nombre = "Ranking_Clientes" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

     

       
    }
}