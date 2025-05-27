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
    public partial class DIR_DetalleFacturacionAnual : System.Web.UI.Page
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

          
            else
            {
                this.TraerRanking("dbo.SP_TableroFacturacionDetalleClienteAnual");
                

                this.TraerFacturacionPorFamilia("dbo.SP_TableroFacturacionDetalleFamiliaAnual");

                this.TraerFacturacionPorFamiliaKilos("dbo.SP_TableroFacturacionDetalleFamiliaAnual");

                this.TraerFacturacionPorVendedor("dbo.SP_TableroFacturacionDetalleVendedorAnual");
            }


           
            
        }


        private void TraerFacturacionPorFamilia(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
           
            

            try
            {
               


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                


                //Cargo el Chart con la lista de los usuarios con rol
                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Supra_Familia";
                Chart1.Series["Series1"].YValueMembers = "Dolares";
               
                Chart1.DataBind();
               

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerFacturacionPorFamiliaKilos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
           


            try
            {
               


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));




                //Cargo el Chart con la lista de los usuarios con rol
                Chart4.DataSource = unDS;
                Chart4.Series["Series1"].XValueMember = "Supra_Familia";
                Chart4.Series["Series1"].YValueMembers = "Kilos";

                Chart4.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerRanking(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
           

            try
            {
               

                
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

                //Cargo el Chart con la lista de los usuarios con rol
                Chart5.DataSource = unDS;
                Chart5.Series["Series1"].XValueMember = "Cliente";
                Chart5.Series["Series1"].YValueMembers = "Dolares";

                Chart5.DataBind();


                       

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        private void TraerFacturacionPorVendedor(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
           


            try
            {
               


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));




                //Cargo el Chart con la lista de los usuarios con rol
                Chart2.DataSource = unDS;
                Chart2.Series["Series1"].XValueMember = "Vendedor";
                Chart2.Series["Series1"].YValueMembers = "Dolares";

                Chart2.DataBind();


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